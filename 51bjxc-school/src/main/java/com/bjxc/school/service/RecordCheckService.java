package com.bjxc.school.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import java.awt.Polygon;
import java.awt.geom.Point2D;
import java.awt.geom.Point2D.Double;

import javax.annotation.Resource;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.bjxc.school.DeviceImage;
import com.bjxc.school.TeachLog;
import com.bjxc.school.TrainingLog;
import com.bjxc.school.mapper.DeviceImageMapper;
import com.bjxc.school.mapper.TeachLogMapper;
import com.bjxc.school.mapper.TrainingLogMapper;
import com.bjxc.school.Coach;
import com.bjxc.school.DrivingField;
import com.bjxc.school.Student;
import com.bjxc.school.TrainingLogWithLocation;
import com.bjxc.school.utils.HTTPMap;

/**
 * 自动检查学时
 * @author levin
 * @author 春春 
 *
 */

@Component
public class RecordCheckService {
	
	@Resource
	private TeachLogMapper teachLogMapper;
	
	@Resource
	private DeviceImageMapper deviceImageMapper;	

	@Resource
	private TrainingLogMapper trainingLogMapper;

	@Resource
	private TrainingLogService trainingLogService;
	@Resource
	private CoachService coachService;
	@Resource
	private StudentService studentService;
	@Resource
	private DrivingFieldService drivingFieldService;
	@Resource
	private SystemConfigService systemConfigService;	
	
	private final static  String AUTO_CHECK = "1";
	
	private boolean check = true;
	
    @Scheduled(cron="0/10 * *  * * ? ")   //每10秒执行一次      
	public void recordCheck(){
    	
    	String auto = systemConfigService.getAutoCheckRecord();
    	if( AUTO_CHECK.equals(auto) && check){
    		
    		//检查标记位，防止10秒检查不完
    		check = false;
    		
    		//step1:自动检查学时
    		checkRealRecord();
    		
    		//Step2:自动检查教学日志
    		checkTrainningRecord();
    		
    		check = true;
    	}
	}
    
    /**
     * 第一步，学时常规性检查
     */
    public void checkRealRecord(){
    	
    	TrainingLogWithLocation trainingLogWithLocationTemp = null;
    	try {
	    	//1、获取所有未审核的学时记录
	    	List<TrainingLogWithLocation> trainingLogWithLocations = trainingLogService.getTrainingLogWithLocation();
	    	
	    	//yyyyMMddHHmmss
	    	String trainningStartTime = systemConfigService.getTrainningStartTime();
	    	String trainningEndTime = systemConfigService.getTrainningEndTime();
	    	Date trainningStartDate = getMinDateOneDay(trainningStartTime,"yyyyMMddHHmmss");
	    	Date trainningEndDate = getMinDateOneDay(trainningEndTime,"yyyyMMddHHmmss");

	    	for (TrainingLogWithLocation trainingLogWithLocation : trainingLogWithLocations) {
	    		trainingLogWithLocationTemp = trainingLogWithLocation;
	        	//1:有效培训时段：不在有效培训时间段内的学时无效，有效时段应按地市范围设置，可按培训机构设置；（参数：实车教学有效培训时段、课堂和模拟教学有效培训时段、远程教学有效培训时段）
	    		Date trainningTime = getMinDateOneDay(trainingLogWithLocation.getTime(),"yyMMddHHmmss");
	    		if( trainningTime.before(trainningStartDate) || trainningTime.after(trainningEndDate)){
	    			trainingLogService.updatePass("-2", trainingLogWithLocation.getId()+"", "有效培训时段审核不通过");
					continue;
	    		}
	    		
	        	//2:教练员规则：是否备案、是否列入黑名单、是否超出准教车型；(学时)
	    		Coach coachByNum = coachService.getCoachByNum(trainingLogWithLocation.getCoachnum());
	    		Student studentByNum = studentService.getStudentByNum(trainingLogWithLocation.getStudentnum());
	    		if (coachByNum.getIsProvince()!=1) {
	    			trainingLogService.updatePass("-2", trainingLogWithLocation.getId()+"", "教练员备案审核不通过");
					continue;
				}
	    		if(!coachByNum.getTeachpermitted().toUpperCase().contains(studentByNum.getTraintype().toUpperCase())) {
					trainingLogService.updatePass("-2", trainingLogWithLocation.getId()+"", "教练员准教车型审核不通过");
					continue;
				}
	    		
	        	//3:教练车规则：是否备案、是否年审、是否与培训车型不符；(学时)
	    		if(trainingLogWithLocation.getTrainingCarIsProvince()!=1){
	    			trainingLogService.updatePass("-2", trainingLogWithLocation.getId()+"", "教练车备案审核不通过");
					continue;
	    		}
	    		if(!trainingLogWithLocation.getTrainingCarPerdritype().toUpperCase().contains(studentByNum.getTraintype().toUpperCase())){
	    			trainingLogService.updatePass("-2", trainingLogWithLocation.getId()+"", "教练车培训车型审核不通过");
					continue;
	    		}
	        	
	        	//4:分钟学时中发动机转速为0，该分钟学时无效；（学时）
	    		if(trainingLogWithLocation.getEngine_speed() == 0){
	    			trainingLogService.updatePass("-2", trainingLogWithLocation.getId()+"", "分钟学时中发动机转速为0  审核不通过");
					continue;
	    		}
	        	
	        	//5:连续2分钟或以上分钟学时中最大速度为0或行驶记录速度为0，该2分钟或以上的分钟学时无效；（参数：最大允许停车时间，默认2分钟）（学时）
	    		if(trainingLogWithLocation.getMaxspeed() == 0 || trainingLogWithLocation.getCarSpeed() == 0 ){
	    			String start = trainingLogWithLocation.getRecordnum().substring(0, 24);
	    			String end = trainingLogWithLocation.getRecordnum().substring(24);
	    			int index = Integer.parseInt(end)-1;
	    			TrainingLogWithLocation oneTrainingLogWithLocation = trainingLogService.getOneTrainingLogWithLocation(start+index);
	    			if(oneTrainingLogWithLocation != null && (oneTrainingLogWithLocation.getMaxspeed() == 0 || oneTrainingLogWithLocation.getCarSpeed() == 0 )){
		    			trainingLogService.updatePass("-2", trainingLogWithLocation.getId()+"", "连续2分钟或以上分钟学时中最大速度为0或行驶记录速度为0  审核不通过");
		    			trainingLogService.updatePass("-2", oneTrainingLogWithLocation.getId()+"", "连续2分钟或以上分钟学时中最大速度为0或行驶记录速度为0  审核不通过");
						continue;
	    			}
	    		}
	        	
	        	//6:连续2分钟或以上分钟学时的里程为0，该2分钟或以上的分钟学时无效；（学时）
	    		if(trainingLogWithLocation.getMileage() == 0){
	    			String start = trainingLogWithLocation.getRecordnum().substring(0, 24);
	    			String end = trainingLogWithLocation.getRecordnum().substring(24);
	    			int index = Integer.parseInt(end)-1;
	    			TrainingLogWithLocation oneTrainingLogWithLocation = trainingLogService.getOneTrainingLogWithLocation(start+index);
	    			if(oneTrainingLogWithLocation != null && oneTrainingLogWithLocation.getMileage() == 0){
		    			trainingLogService.updatePass("-2", trainingLogWithLocation.getId()+"", "连续2分钟或以上分钟学时的里程为0  审核不通过");
		    			trainingLogService.updatePass("-2", oneTrainingLogWithLocation.getId()+"", "连续2分钟或以上分钟学时的里程为0  审核不通过");
						continue;
	    			}
	    		}
	        	
	        	//7:判断学时记录中上传的GNSS坐标是否在教学区域内，出区域的分钟学时为无效学时。
	    		Double point = new Point2D.Double(trainingLogWithLocation.getLatitude(), trainingLogWithLocation.getLongtitude());
	    		List<Point2D.Double> pointList = new ArrayList<Point2D.Double>();
	    		DrivingField drivingField = drivingFieldService.get(coachByNum.getDrivingFieldId());
	    		String location = drivingField.getLocation();
	    		String[] split = location.split(";");
	    		for (int i = 0; i < split.length; i++) {
	    			String[] split2 = split[i].split(",");
	    			pointList.add(new Point2D.Double(java.lang.Double.parseDouble(split2[1])*100000,java.lang.Double.parseDouble(split2[0])*100000));
				}
	    		if(!checkWithJdkPolygon(point,pointList)){
	    			trainingLogService.updatePass("-2", trainingLogWithLocation.getId()+"", "学时记录中上传的GNSS坐标是否在教学区域内 审核不通过");
					continue;
	    		}
	    		
	    		//学时自动审核通过
	    		trainingLogService.updatePass("2", trainingLogWithLocation.getId()+"", "");
	    	}
    	} catch (Exception e) {
			e.printStackTrace();
			try{
				if(trainingLogWithLocationTemp != null){
					trainingLogService.updatePass("-2", trainingLogWithLocationTemp.getId()+"", "自动审核报错 不通过");
				}
			}catch(Exception exception){
				exception.printStackTrace();
			}
		}
    	
    }
    
    /**
     * 检查教学日志
     */
    public void checkTrainningRecord(){
    	
    	//获取所有未检查的列表
    	List<TeachLog> unCheckList = teachLogMapper.getUnCheckList();
    	
    	int mileage = 0;
    	for (TeachLog teachLog : unCheckList) {
        	//R1：一次电子教学日志的总里程<100米 ，该条教学日志对应的分钟学时均无效。
    		mileage = teachLog.getMileage();
    		if( mileage<1){
    			//设置该条教学日志对应的分钟学时均无效
    			trainingLogMapper.updateAllinspass(teachLog.getId(), -2, "总里程<100米");
    			//设置该条教学日志结果
    			teachLogMapper.updateInPass(teachLog.getId(), -2, "总里程<100米",0f);
    			continue;
    		}
    		
    		//R2:处理照片规则
    		checkPhoto(teachLog);
    		
    		//R3：学时规则满足，有效学时>=75%
    		checkTotalLog(teachLog);
		}
    }
    
    
    
    /**
     * 检查教学日志的照片
     * @param teachLog
     */
    private void checkPhoto(TeachLog teachLog){
    	//时间规则：照片的时间不在登录登出时间范围之内，该照片无效。
    	//数量规则: 检查本次电子教学日志签到、签退、定时照片（每15分钟一张）的数量，缺少的照片为缺失照片；
    	
    	//未检查照片列表：1表示有效，-1表示无效，其他表示未检查
    	
    	List <Date> invalidDeviceImageList = new ArrayList<Date>(10);
    	
    	
    	//按照时间升序排列，获取该电子教学日志的所有照片
    	List<DeviceImage> deviceImageList = deviceImageMapper.getDeviceImage(teachLog.getId());
    	
    	Date teachStartDate = getMinDate(teachLog.getStarttime());
    	Date teachEndDate = teachLog.getEndtime();
    	
    	//从0开始包含签到、签出的照片，都是以分钟为判断标准
    	int minnum = 0;
    	Date minDate = new Date(teachStartDate.getTime()+minnum*15*60*1000);
    	Date imageDate = null;
    	boolean valid = false;
    	while( minDate.before(teachEndDate)){
    		//超过15分钟判断是否有照片，如果没有表示是无效照片
        	for (DeviceImage deviceImage : deviceImageList) {
        		imageDate = getMinDate(deviceImage.getCreatetime());
        		//如果有对应时段的照片，说明
        		if(minDate.getTime() == imageDate.getTime()){
        			valid = true;
        			break;
        		}
        	}
        	
        	//如果是无效照片，则记录到无效照片列表
        	if(!valid){
        		invalidDeviceImageList.add(minDate);
        	}
        	
        	//继续判断
        	minnum++;
        	minDate = new Date(teachStartDate.getTime()+minnum*15*60*1000);
    	}
    	
    	//根据无效照片，设置无效学时
    	if( invalidDeviceImageList.size() >0){
        	//根据教学日志id获取其所有学时列表
        	List<TrainingLog> trainingLogList = trainingLogMapper.getLogList(teachLog.getId());
        	long startDateFlag = invalidDeviceImageList.get(0).getTime();
        	long endDateFlag = 0;
        	long imageDateflag = 0;
    		Date invalidImageDate = null;
    		for (int i = 0; i < invalidDeviceImageList.size(); i++) {
    			invalidImageDate = invalidDeviceImageList.get(i);
    			endDateFlag = invalidImageDate.getTime();
    			
    			//如果连续两张照片无效，则所有分钟学时无效
    			if( endDateFlag >  startDateFlag + 15*60*1000){
    				trainingLogMapper.updateAllinspass(teachLog.getId(), -2, "连续两张照片无效.");
    				break;
    			}else{ //继续判断
    				startDateFlag = endDateFlag;
    			}
    			
    			//前后7个学时无效
    			for(TrainingLog trainingLog : trainingLogList) {
    				imageDateflag = trainingLog.getRecordtime().getTime();
    				if( Math.abs(imageDateflag-endDateFlag)<=7){
        				trainingLogMapper.updateinspass(trainingLog.getId(), -2, "连续两张照片无效.");
    				}
				}
			}
    		
    	}
    }
    
    /**
     * 检查教学日志的学时是否满足3/4
     * @param teachLog
     */
    public void checkTotalLog(TeachLog teachLog){
    	int totalLog = trainingLogMapper.totalTrainingLog(teachLog.getId());
    	int totalValidLog = trainingLogMapper.totalValidTrainingLog(teachLog.getId());
    	float logratio = 1;
    	if( (float)totalValidLog/totalLog < (float)3/4 ){
    		logratio = (float)totalValidLog/totalLog * (float)4/3;
    		if(logratio>1){
    			logratio = 1;
    		}
    		//更新状态
    		teachLogMapper.updateInPass(teachLog.getId(), -2, "有效学时未超过3/4",logratio);
    	}else{
    		teachLogMapper.updateInPass(teachLog.getId(), 2, "有效学时比例为"+logratio,logratio);
    	}
    }
    
    /**
     * 将时间转换成分钟
     * @param date
     * @return
     */
    private Date getMinDate(Date date){
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm"); 
        String datestr = sdf.format(date);
        try {
			Date newDate = sdf.parse(datestr);
			return newDate;
		} catch (ParseException e) {
			//Do nothing
		}
        return date;
    }
    
    /**
     * 获取同一天的小时分钟秒，去掉天的差别
     * @param datestr
     * @param formatstr
     * @return
     */
    private static Date getMinDateOneDay(String datestr, String formatstr){
        SimpleDateFormat sdf=new SimpleDateFormat(formatstr);
        SimpleDateFormat sdf2=new SimpleDateFormat("HHmmss");
        SimpleDateFormat sdf3=new SimpleDateFormat("yyyyMMddHHmmss");
		try {
			Date date1 = sdf.parse(datestr);
			return sdf3.parse("20170101"+sdf2.format(date1));
		} catch (ParseException e) {
			//e.printStackTrace();
		}
		//
		return new Date();
    }
    
    /**
     * java 判断点是否在多边形区域内
     * @param point
     * @param polygon
     * @return
     */
    private boolean checkWithJdkPolygon(Point2D.Double point, List<Point2D.Double> polygon) {  
        java.awt.Polygon p = new Polygon();  
        // java.awt.geom.GeneralPath  
        final int TIMES = 1000;  
        for (Point2D.Double d : polygon) {  
            int x = (int) d.x * TIMES;  
            int y = (int) d.y * TIMES;  
            p.addPoint(x, y);  
        }  
        int x = (int) point.x * TIMES;  
        int y = (int) point.y * TIMES;  
        return p.contains(x, y);  
    }  
}
