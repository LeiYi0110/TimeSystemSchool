package com.bjxc.school.controller;

import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.bjxc.Result;
import com.bjxc.school.TeachLog;
import com.bjxc.school.TrainningImage;
import com.bjxc.school.TrainningVideo;
import com.bjxc.school.service.StudentService;
import com.bjxc.school.service.TeachLogService;
import com.bjxc.school.service.TrainningImageService;
import com.bjxc.school.service.TrainningVideoService;
import com.bjxc.web.utils.WebUtils;

@RestController
@RequestMapping(value="/teachLog")
public class TeachLogController {
	private static final Logger logger = LoggerFactory.getLogger(TeachLogController.class);
	@Resource
	private TeachLogService teachLogService;
	@Resource
	private StudentService studentService;
	@Resource
	private TrainningImageService trainningImageService;
	@Resource
	private TrainningVideoService trainningVideoService;
	
	@RequestMapping(value="/getList",method=RequestMethod.GET)
	@UserControllerLog(description = "获取电子教学日志列表")    
	public Result getList(HttpServletRequest request){
		Result result=new Result();
		try {
			String searchText=WebUtils.getParameterValue(request, "searchText");
			Integer subjectId=WebUtils.getParameterIntegerValue(request, "subjectId");
			Integer status=WebUtils.getParameterIntegerValue(request, "status");
			Map map=new HashMap();
			map.put("searchText", searchText);
			map.put("subjectId", subjectId);
			map.put("status", status);
			String day=WebUtils.getParameterValue(request, "day");
			if(day!=null&&day!=""){
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
				Date date=sdf.parse(day);
				map.put("day", date);
			}
			List<TeachLog> list=teachLogService.getList(map);
			result.success(list);
		} catch (Exception e) {
			logger.error("teachLog api", e);
			result.error(e);
		}
		return result;
	}
	
	@RequestMapping(value="/getOne",method=RequestMethod.GET)
	@UserControllerLog(description = "获取电子教学日志")    
	public Result getOne(HttpServletRequest request){
		Result result=new Result();
		try {
			Integer id=WebUtils.getParameterIntegerValue(request, "id");
			TeachLog one=teachLogService.getOne(id);
			one.setPlatnum("A0041");
			one.setPhoto1("231180");
			one.setPhoto3("231181");
			result.success(one);
		} catch (Exception e) {
			logger.error("teachLog api", e);
			result.error(e);
		}
		return result;
	}
	
	@RequestMapping(value="/addLog",method=RequestMethod.POST)
	@UserControllerLog(description = "添加教学日志")    
	public Result addLog(HttpServletRequest request){
		Result result = new Result();
		try {
//			String platnum = WebUtils.getParameterValue(request, "platnum");
//			String inscode = WebUtils.getParameterValue(request, "inscode");
//			String etrainingLogCode = WebUtils.getParameterValue(request, "etrainingLogCode");
			String stunum = WebUtils.getParameterValue(request, "stunum");
			//Integer stuid = studentService.getStunum(stunum);
			String courseCode = WebUtils.getParameterValue(request, "courseCode");
			String photo1 = WebUtils.getParameterValue(request, "photo1");
//			String photo2 = WebUtils.getParameterValue(request, "photo2");
			String photo3 = WebUtils.getParameterValue(request, "photo3");
//			Integer mileage = WebUtils.getParameterIntegerValue(request, "mileage");
//			String duration = WebUtils.getParameterValue(request, "duration");
			Integer part = WebUtils.getParameterIntegerValue(request, "part");
			String createtime = WebUtils.getParameterValue(request, "createtime");
			Integer many= WebUtils.getParameterIntegerValue(request, "many");
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
			Integer lastTrainingLogCode = teachLogService.getLastTrainingLogCode(stunum)+1;
			for (int i = 0; i < many; i++) {
				Date starttime = simpleDateFormat.parse(createtime);
				
				if(i>0){
					starttime = new Date(starttime.getTime()+(1000*60*60*24*i));
					lastTrainingLogCode++;
				}
				Date endtime = new Date(starttime.getTime()+(1000*60*60));
				TeachLog teachLog = new TeachLog();
				teachLog.setStunum(stunum);
				teachLog.setCoachId(1);
				teachLog.setCreatetime(new Date());
				teachLog.setCourseCode(courseCode);
//				teachLog.setStatus(0);
//				teachLog.setMaxSpeed(20);
//				teachLog.setDistance(100);
//				if(part==3){
//					teachLog.setLocationInfoId(25);
//				}else if (part==2) {
//					teachLog.setLocationInfoId(26);
//				}else {
//					teachLog.setLocationInfoId(1);
//				}
				
				teachLog.setTrainingcarId(1);
				teachLog.setDeviceId(1);
				teachLog.setStarttime(starttime);
				teachLog.setEndtime(endtime);
				SimpleDateFormat sss = new SimpleDateFormat("YYMMdd");
				//teachLog.setRecordCode("0000000000000000"+sss.format(starttime)+"0001");
				teachLog.setCourseType("1");
				teachLog.setSubjectId(part);
				teachLog.setLoginPhotoUrl(photo1);
				teachLog.setLogoutPhotoUrl(photo3);
				
				
				String trainingLogCode = new DecimalFormat("00000").format(lastTrainingLogCode);
				teachLog.setEtrainingLogCode(trainingLogCode);
			
				teachLogService.add(teachLog);
			}
		}catch(Exception e){
			logger.error("addLog api", e);
			result.error(e);
		}
		return result;
	}
	
	/**
	 * 培训过程上传图片
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/uploadPhoto",method=RequestMethod.POST)
	public Result updatePhoto(HttpServletRequest request){
		Result result = new Result();
		try {
			Integer traningrecordId = WebUtils.getParameterIntegerValue(request, "traningrecordId");
			String imageTime = WebUtils.getParameterValue(request, "imageTime");
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
			Date parseDate = simpleDateFormat.parse(imageTime);
			String imageUrl = WebUtils.getParameterValue(request, "imageUrl");
			TrainningImage trainningImage = new TrainningImage();
			trainningImage.setImageTime(parseDate);
			trainningImage.setImageUrl(imageUrl);
			trainningImage.setTraningrecordId(traningrecordId);
			trainningImageService.add(trainningImage);
		} catch (ParseException e) {
			logger.error("uploadPhoto api", e);
			result.error(e);
		}
		return result;
	}
	
	/**
	 * 获取培训过程（http）上传的图片
	 */
	@RequestMapping(value="/getUploadPhoto",method=RequestMethod.GET)
	public Result getUploadPhoto(Integer id){
		Result result=new Result();
		try {
			List<TrainningImage> list = trainningImageService.getList(id);
			result.success(list);
		} catch (Exception e) {
			logger.error("getUploadPhoto api", e);
			result.error(e);
		}
		return result;
	}
	
	@RequestMapping(value="/uploadVideo",method=RequestMethod.POST)
	public Result updateVideo(HttpServletRequest request){
		Result result = new Result();
		try {
			Integer traningrecordId = WebUtils.getParameterIntegerValue(request, "traningrecordId");
			String starttime = WebUtils.getParameterValue(request, "starttime");
			String endtime = WebUtils.getParameterValue(request, "endtime");
			Integer event = WebUtils.getParameterIntegerValue(request, "event");
			String videoURL = WebUtils.getParameterValue(request, "videoURL");
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
			Date startDate = simpleDateFormat.parse(starttime);
			Date endDate = simpleDateFormat.parse(endtime);
			TrainningVideo trainningVideo = new TrainningVideo();
			trainningVideo.setEndtime(endDate);
			trainningVideo.setStarttime(startDate);
			trainningVideo.setEvent(event);
			trainningVideo.setTraningrecordId(traningrecordId);
			trainningVideo.setVideoURL(videoURL);
			trainningVideoService.add(trainningVideo);
		} catch (ParseException e) {
			logger.error("uploadVideo api", e);
			result.error(e);
		}
		return result;
	}

	/**
	 * 获取培训过程（http）上传的视频
	 */
	@RequestMapping(value="/getUploadVideo",method=RequestMethod.GET)
	public Result getUploadVideo(Integer id){
		Result result=new Result();
		try {
			List<TrainningVideo> list = trainningVideoService.getList(id);
			result.success(list);
		} catch (Exception e) {
			logger.error("getUploadVideo api", e);
			result.error(e);
		}
		return result;
	}
	
	@RequestMapping(value="/updateLog",method=RequestMethod.GET)
	public Result updateOne(HttpServletRequest request){
		Result result=new Result();
		try {
			Integer id=WebUtils.getParameterIntegerValue(request, "id");
			teachLogService.updateLog(id);
		} catch (Exception e) {
			logger.error("teachLog api", e);
			result.error(e);
		}
		return result;
	}
	
	/**
	 * 获取(所有)阶段培训记录
	 */
	@RequestMapping(value="/getRecordMap",method=RequestMethod.GET)
	public Result getRecordMap(){
		Result result=new Result();
		try {
			result.success(teachLogService.getRecordMap());
		} catch (Exception e) {
			logger.error("TimeRecord api", e);
			result.error(e);
		}
		return result;
	}
	
	/**
	 * 获取(学员)阶段培训记录
	 */
	@RequestMapping(value="/getTimeRecord",method=RequestMethod.GET)
	public Result getTimeRecord(Integer id,Integer subject){
		Result result=new Result();
		try {
			result.success(teachLogService.getTimeRecord(id,subject));
			result.put("datas",teachLogService.getRecordCodeMap(id, subject));
		} catch (Exception e) {
			logger.error("TimeRecord api", e);
			result.error(e);
		}
		return result;
	}
	
	/**
	 * 获取(学员)阶段培训记录
	 */
	@RequestMapping(value="/addTimeRecord",method=RequestMethod.POST)
	public Result addTimeRecord(HttpServletRequest request){
		Result result=new Result();
		try {
			String inscode = WebUtils.getParameterValue(request, "inscode");
			String stunum = WebUtils.getParameterValue(request, "stunum");
			int subjectId = WebUtils.getParameterIntegerValue(request, "subject");
			int totaltime = WebUtils.getParameterIntegerValue(request, "totaltime");
			int duration = WebUtils.getParameterIntegerValue(request, "duration");
			int vehicletime = WebUtils.getParameterIntegerValue(request, "vehicletime");
			int classtime = WebUtils.getParameterIntegerValue(request, "classtime");
			int simulatortime = WebUtils.getParameterIntegerValue(request, "simulatortime");
			int networktime = WebUtils.getParameterIntegerValue(request, "networktime");
			int mileage = WebUtils.getParameterIntegerValue(request, "mileage");
			int rectype = WebUtils.getParameterIntegerValue(request, "rectype");
			int examresult = WebUtils.getParameterIntegerValue(request, "examresult");
			HashMap<String,Object> hashMap = new HashMap<String, Object>();
			hashMap.put("inscode", inscode);
			hashMap.put("stunum", stunum);
			hashMap.put("subjectId", subjectId);
			hashMap.put("totaltime", totaltime);
			hashMap.put("duration", duration);
			hashMap.put("vehicletime", vehicletime);
			hashMap.put("classtime", classtime);
			hashMap.put("simulatortime", simulatortime);
			hashMap.put("networktime", networktime);
			hashMap.put("mileage", mileage);
			hashMap.put("rectype", rectype);
			hashMap.put("examresult", examresult);
			
			teachLogService.addTimeRecord(hashMap);
		} catch (Exception e) {
			logger.error("TimeRecord api", e);
			result.error(e);
		}
		return result;
	}
	
	@RequestMapping(value="/addGraduation",method=RequestMethod.POST)
	public Result addGraduation(HttpServletRequest request){
		Result result=new Result();
		try {
			String inscode = WebUtils.getParameterValue(request, "inscode");
			String stunum = WebUtils.getParameterValue(request, "stunum");
			String pdfurl = request.getParameter("pdfurl");
			HashMap<String,Object> hashMap = new HashMap<String, Object>();
			hashMap.put("inscode", inscode);
			hashMap.put("stunum", stunum);
			hashMap.put("pdfurl", pdfurl);
			hashMap.put("subjectId", 5);
			teachLogService.addTimeRecord(hashMap);
		} catch (Exception e) {
			logger.error("Graduation api", e);
			result.error(e);
		}
		return result;
	}
	
	/**
	 * 获取(学员)阶段培训记录
	 */
	@RequestMapping(value="/updatePass",method=RequestMethod.POST)
	public Result updatePass(HttpServletRequest request){
		Result result=new Result();
		
		Integer id = WebUtils.getParameterIntegerValue(request, "id");
		Integer pass = WebUtils.getParameterIntegerValue(request, "pass");
		String reason = WebUtils.getParameterValue(request, "reason");
		
		try {
			teachLogService.updatePass(id,pass,reason);
		} catch (Exception e) {
			logger.error("TimeRecord api", e);
			result.error(e);
		}
		return result;
	}
	
	/**
	 * 获取学员头像图片
	 * @param studentId
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/getStudentImg",method = RequestMethod.GET)
	public Result getStudentImg(@RequestParam("studentId") Integer studentId){
		Result result = new Result();
		try{
			result.success(studentService.getStudentImg(studentId));
		}catch(Exception e){
			logger.error("getStudentImg", e);
			result.error(e);
		}
		return result;
	}
	
	/**
	 * 审核照片
	 * @param recordId
	 * @param pass
	 * @param reason
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/passImage" , method = RequestMethod.POST)
	public Result passImage(Integer imageId, Integer pass, String reason) {
		Result result = new Result();
		try {
			if(StringUtils.isEmpty(reason)){
				reason = null;
			}
			Integer row = teachLogService.updateImagePass(imageId, pass, reason);
			result.success(row);
		} catch (Exception e) {
			logger.error("passImage", e);
			result.error(e);
		}
		return result;
	}
	
	/**
	 * 批量审核教学日志
	 * @param pass
	 * @param reason
	 * @param recordIds ,隔开
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/passTeachLog" , method = RequestMethod.POST)
	public Result passTeachLog(String recordIds, Integer pass, String reason) {
		Result result = new Result();
		try {
			List<Integer> ids = Arrays.asList(recordIds.split(",")).stream()
					.filter(f -> !StringUtils.isEmpty(f) && org.apache.commons.lang.StringUtils.isNumeric(f))
					.map(m -> Integer.valueOf(m)).collect(Collectors.toList());

			if(ids.size() > 0){
				Integer row = teachLogService.udpateTeachLog(ids, pass, reason);
				result.success(row);
			}
		} catch (Exception e) {
			logger.error("passTeachLog", e);
			result.error(e);
		}
		return result;
	}
}
