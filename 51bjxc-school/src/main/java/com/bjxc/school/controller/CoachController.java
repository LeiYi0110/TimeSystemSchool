package com.bjxc.school.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Method;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.StringUtils;
import org.apache.commons.fileupload.FileUploadBase;
import org.apache.commons.lang.ObjectUtils.Null;
import org.apache.log4j.varia.FallbackErrorHandler;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.aspectj.weaver.reflect.ReflectionWorld;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.bjxc.Page;
import com.bjxc.Result;
import com.bjxc.school.*;
import com.bjxc.school.security.UsinInfo;
import com.bjxc.school.service.CityAreasService;
import com.bjxc.school.service.CoachDutyService;
import com.bjxc.school.service.CoachService;
import com.bjxc.school.service.InstitutionInfoService;
import com.bjxc.school.service.ServiceStationService;
import com.bjxc.school.service.TservicestationService;
import com.bjxc.school.utils.ReaderExcelUtils;
import com.bjxc.web.utils.WebUtils;
import com.mysql.jdbc.Field;

@Controller
@RequestMapping(value = "/coach")
public class CoachController {
	private static final Logger logger = LoggerFactory.getLogger(CoachController.class);
	@Resource
	private CoachService coachService;
	@Resource
	private CityAreasService areaService;

	@Resource
	private TservicestationService tservicestationService;
	
	@Resource
	private CoachDutyService coachDutyService;

	/**
	 * 教练列表 支持对姓名、手机号码的模糊搜索
	 */
	@ResponseBody
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	@UserControllerLog(description = "教练列表模糊搜索")
	public Result list(HttpServletRequest request) {
		Result result = new Result();
		String searchText = WebUtils.getParameterValue(request, "searchText");
		Integer insId = WebUtils.getParameterIntegerValue(request, "insId");
		// Integer stationId=WebUtils.getParameterIntegerValue(request,
		// "stationId");
		String station = request.getParameter("stationId");
		Integer stationId = null;
		if (!station.equals("null")) {
			stationId = Integer.parseInt(station);
		}
		Integer pageIndex = WebUtils.getParameterIntegerValue(request, "pageIndex");
		Integer pageSize = WebUtils.getParameterIntegerValue(request, "pageSize");
		//logger.error("request", request);
		try {
			Page<Coach> page = coachService.list(insId, stationId, searchText, pageIndex, pageSize);
			result.success(page.getData());
			result.put("rowCount", page.getRowCount());
		} catch (Exception e) {
			logger.error("教练搜索列表", e);
			result.error(e);
		}
		return result;
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@ResponseBody
	@RequestMapping(value="/coachSituation",method=RequestMethod.GET)
	@UserControllerLog(description = "coachSituation")
	public Result getCoachSituation(@RequestParam("insId")Integer insId,@RequestParam("stationId")Integer stationId,
			@RequestParam("coaMonth")Integer coaMonth,Integer pageIndex, Integer pageSize,HttpServletRequest request){
		Result result = new Result();
		try {
			Assert.notNull(insId,"id is null");
			Map map=new HashMap();
			Page<CoachTable> coachPage=null;
			map.put("insId",insId);
			if(stationId!=null){
				if(stationId==-1){
					stationId=null;
				}
			}
			if(stationId!=null&&coaMonth!=null){
				map.put("stationId",stationId);
				map.put("coaMonth",coaMonth);
			}else if(stationId!=null){
				map.put("stationId",stationId);
				map.put("coaMonth",null);
			}else if(coaMonth!=null){
				map.put("stationId",null);
				map.put("coaMonth",coaMonth);
			}else{
				map.put("stationId",null);
				map.put("coaMonth",null);
			}
			
			coachPage=coachService.getCoachSituation(map,pageIndex,pageSize);//获取概况
			result.success(coachPage.getData());
			result.put("rowCount", coachPage.getRowCount());
			/*Map dataMap=new HashMap();
			dataMap.put("coaName",map.get("coaName").toString());
			dataMap.put("coaCarPlate",map.get("coaCarPlate").toString());
			dataMap.put("subjTwoCount",Integer.parseInt(map.get("subjTwoCount").toString()));
			String twoPassPercent=(Double.parseDouble(map.get("subjTwoPassPercent").toString()))*100+"%";
			dataMap.put("subjTwoPassPercent",twoPassPercent);
			dataMap.put("subjThreeCount",Integer.parseInt(map.get("subjThreeCount").toString()));
			String threePassPercent=(Double.parseDouble(map.get("subjThreePassPercent").toString()))*100+"%";
			dataMap.put("subjThreePassPercent",threePassPercent);
			String stuPercent=(Double.parseDouble(map.get("stuPassPercent").toString()))*100+"%";
			dataMap.put("stuPassPercent",stuPercent);
			dataMap.put("teachingCount",Integer.parseInt(map.get("teachingCount").toString()));
			dataMap.put("stuCount",Integer.parseInt(map.get("stuCount").toString()));*/
			
		} catch (Exception e) {
			logger.error("CoachController getCoachSituation",e);
			result.error("");
		}
		return result;
	}

	/**
	 * 按ID删除
	 * 
	 * @param id
	 */
	@ResponseBody
	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	@UserControllerLog(description = "按id删除教练")
	public Result Delete(@PathVariable("id") Integer id) {
		Assert.notNull(id, "id不能为空");
		Result result = new Result();
		try {
			coachService.delete(id);
		} catch (Exception e) {
			logger.error("教练删除", e);
			result.error(e);
		}
		return result;
	}

	@ResponseBody
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	@UserControllerLog(description = "获取教练信息")
	public Result get(@PathVariable("id") Integer id, HttpServletRequest request) {
		Assert.notNull(id, "id不能为空");
		Result result = new Result();
		try {
			Coach coach = coachService.get(id);
			CoachPayFirst coachPay = coachService.getCoachPay(coach.getId());
			if (coachPay != null) {
				coach.setPrice(coachPay.getPrice() * 100);
			}
			result.success(coach);
		} catch (Exception e) {
			logger.error("find Coach  ", e);
			result.error(e);
		}
		return result;
	}

	@ResponseBody
	@RequestMapping(value = "/getInsCoach", method = RequestMethod.GET)
	@UserControllerLog(description = "按科目查找教练信息")
	public Result getCoach(HttpServletRequest request) {
		Result result = new Result();
		Integer subjectId = WebUtils.getParameterIntegerValue(request, "subjectId");
		Integer stationId = WebUtils.getParameterIntegerValue(request, "stationId");
		Integer insId = WebUtils.getParameterIntegerValue(request, "insId");
		Assert.notNull(insId, "insId is null");
		try {
			// List<Coach>
			// coachList=coachService.coachList(insId,stationId,subjectId+1);
			List<Coach> coachList = coachService.coachList(insId, stationId, subjectId);
			result.success(coachList);
		} catch (Throwable e) {
			logger.error("下一科目教练列表", e);
			result.error(e);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/getDutyList", method = RequestMethod.GET)
	@UserControllerLog(description = "获取教练排版数据")
	public Result getDutyList(HttpServletRequest request, Integer coachId,String date) {
		Result result = new Result();
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date dateTime=null;
			if(date==null||date.equals("null")){
				dateTime=new Date();
				//生成7天数据，已有则不做处理
				coachService.addSeven(sdf.format(dateTime),coachId);
			}else{
				dateTime=sdf.parse(date);
			}
			Calendar calendar = Calendar.getInstance();  
			calendar.setTimeInMillis(dateTime.getTime());
			calendar.add(Calendar.DATE, 6);
		    Date seven = calendar.getTime();
		    Map map = new HashMap();
			map.put("now", sdf.format(dateTime)); // 搜索框
			map.put("future", sdf.format(seven)); // 驾校id
			map.put("coachId", coachId); // 网点id
			List<CoachDuty> page = coachService.dutyList(map);
			List<CoachDuty> data = new ArrayList<CoachDuty>();
			
			for (int i = 0; i <=6; i++) {
				Calendar calendar2 = Calendar.getInstance(); 
				calendar2.setTimeInMillis(dateTime.getTime());
				calendar2.add(Calendar.DATE, i);
//				CoachDuty codu=new CoachDuty();
//				codu.setDay(calendar2.getTime());
				data.add(i, null);
				for (CoachDuty coachDuty : page) {
					if(coachDuty.getDay().getDay()==calendar2.getTime().getDay()){
						data.remove(i);
						data.add(i,coachDuty);
						break;
					}
				}
			}
			result.success(data);
//			result.success(page);
		} catch (Throwable e) {
			logger.error("教练预约列表", e);
			result.error(e);
		}
		return result;
	}

	@ResponseBody
	@RequestMapping(value = "/getStationDuty", method = RequestMethod.GET)
	@UserControllerLog(description = "教练预约列表")
	public Result getDutyList(HttpServletRequest request, String stationId, Integer pageIndex
			, Integer pageSize
			,@RequestParam(value = "startTime", required = false) Long startTime
			,@RequestParam(value = "endTime", required = false) Long endTime) {
		Result result = new Result();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String searchText = request.getParameter("searchText");
		
		try {
			Map map = new HashMap();
			if(startTime !=null && startTime != 0){
				String startTimeString = sdf.format(new Date(startTime));
				map.put("now", startTimeString);
			}else{
				map.put("now", sdf.format(new Date()));
			}
			if(endTime != null && endTime != 0){
				map.put("future", sdf.format(new Date(endTime)));
			}
			map.put("searchText", searchText); // 搜索框
			map.put("pageIndex", pageIndex); // 第几页
			map.put("pageSize", pageSize); // 每页条数
			
			//获取登录用户信息
			SecurityContext context = SecurityContextHolder.getContext();
			boolean has_ROLE_SCHOOL_MANAGER = context.getAuthentication().getAuthorities()
					.stream().filter(a -> a.getAuthority().equals("ROLE_SCHOOL_MANAGER"))
					.count() > 0;//判断是否有ROLE_SCHOOL_MANAGER权限，是否为机构账号
			
			UsinInfo usinInfo = (UsinInfo)context.getAuthentication().getPrincipal();
			map.put("insId", usinInfo.getInsId());
			
			//权限判断		
			if(has_ROLE_SCHOOL_MANAGER){
				//机构账号
				String strStationId = request.getParameter("stationId");
				String strAreaId = request.getParameter("areaId");
				
				if(!StringUtils.isEmpty(strStationId)){
					Integer stationId1 = Integer.valueOf(strStationId);
					map.put("stationId", stationId1); // 网点id
				}
				if(!StringUtils.isEmpty(strAreaId)){
					Integer areaId = Integer.valueOf(strAreaId);
					map.put("areaId", areaId);//片区
				}
			}else{
				//网点账号
				Integer thisStationId = ((UsinInfo)context.getAuthentication().getPrincipal()).getStationId();
				map.put("stationId", thisStationId);
			}
			
			Page<CoachDuty> page = coachService.stationDuty(map);
			result.success(page.getData());
			result.put("rowCount", page.getRowCount());
		} catch (Throwable e) {
			logger.error("教练预约列表", e);
			result.error(e);
		}
		return result;
	}

	@ResponseBody
	@RequestMapping(value = "/saveDuty", method = RequestMethod.POST)
	@UserControllerLog(description = "预约教练")
	public Result saveDuty(HttpServletRequest request) throws ParseException {
		Result result = new Result();
		Integer status = WebUtils.getParameterIntegerValue(request, "status");
		Integer time = WebUtils.getParameterIntegerValue(request, "time");
		Integer subjectId = WebUtils.getParameterIntegerValue(request, "subjectId");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date day = sdf.parse(request.getParameter("day"));
		Integer coachId = WebUtils.getParameterIntegerValue(request, "coachId");
		Integer stuId = WebUtils.getParameterIntegerValue(request, "stuId");
		
		UsinInfo usinInfo = (UsinInfo)SecurityContextHolder.getContext()
				.getAuthentication().getPrincipal();
		
		/*
		 * status = 1  教练可以预约
		 * status = 0  教练休息，不预约
		 * status = 3 给教练指定学员
		 * */
			
		try {
			Calendar ca=Calendar.getInstance();
			ca.setTime(day);
			ca.add(Calendar.HOUR_OF_DAY, time);
			if(new Date().compareTo(ca.getTime())>0){
				throw new Exception("超时了！不可预约");
			}
			StudentReserve reserve = new StudentReserve();
			reserve.setCoachId(coachId);
			reserve.setDay(day);
			reserve.setStudentId(stuId);
			reserve.setSubjectId(subjectId);
			reserve.setTime(time);
			reserve.setOptionUserId(usinInfo.getId());
			
			coachService.updDuty(reserve, status);
			
			Map<String, String> dataMap = new HashMap<>();
			dataMap.put("optionUserName", usinInfo.getUsername());
			
			result.success(dataMap);
			
		} catch (Exception e) {
			logger.error("预约更改", e);
			result.error(e);
		}
		return result;
	}

	/**
	 * 保存教练信息，前端传有ID参数为修改，没有ID信息为新增
	 * 
	 * @param request
	 *            web请求对象
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/saveCoach",method = RequestMethod.POST)
	@UserControllerLog(description = "保存教练信息")
	public Result save(HttpServletRequest request) {
		Integer id = WebUtils.getParameterIntegerValue(request, "id");
		String name = WebUtils.getParameterValue(request, "name");
		Integer insId = WebUtils.getParameterIntegerValue(request, "insId");
		String mobile = WebUtils.getParameterValue(request, "mobile");
		String idcard = WebUtils.getParameterValue(request, "idcard");
		Integer sex = WebUtils.getParameterIntegerValue(request, "sex");
		String address = WebUtils.getParameterValue(request, "address");
		String photo = WebUtils.getParameterValue(request, "photo");
		String fingerprint = WebUtils.getParameterValue(request, "fingerprint");
		String drilicence = WebUtils.getParameterValue(request, "drilicence");
		String receiveTime = WebUtils.getParameterValue(request, "receiveTime");
		String dripermitted = WebUtils.getParameterValue(request, "dripermitted");
		String teachpermitted = WebUtils.getParameterValue(request, "teachpermitted");
		String occupationno=WebUtils.getParameterValue(request, "occupationno");
		Integer occupationlevel = WebUtils.getParameterIntegerValue(request, "occupationlevel");
		Integer subject = WebUtils.getParameterIntegerValue(request, "subject");
		String birth = WebUtils.getParameterValue(request, "birth");
		String hiredate = WebUtils.getParameterValue(request, "hiredate");
		String leavedate = WebUtils.getParameterValue(request, "leavedate");
		String coachNum = WebUtils.getParameterValue(request, "coachnum");
		String carBrand = WebUtils.getParameterValue(request, "carBrand");
		String carPlate = WebUtils.getParameterValue(request, "carPlate");
		String drivingTime = WebUtils.getParameterValue(request, "drivingTime");
		Integer star = WebUtils.getParameterIntegerValue(request, "star");
		Integer stationId = WebUtils.getParameterIntegerValue(request, "stationId");
		Integer employstatus = WebUtils.getParameterIntegerValue(request, "employstatus");
		Integer drivingFieldId = WebUtils.getParameterIntegerValue(request, "drivingFieldId");
		Integer language = WebUtils.getParameterIntegerValue(request, "language");
		Integer isCountry=WebUtils.getParameterIntegerValue(request, "iscountry");
		Integer isProvince=WebUtils.getParameterIntegerValue(request, "isprovince");

		//logger.error("save coach  1");
		// 先付后学
		String firstAfterSchooL = WebUtils.getParameterValue(request, "firstAfterSchooL");
		Double timeCharges = WebUtils.getParameterDoubleValue(request, "timeCharges");
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Result result = new Result();
		try {
			Coach coach = new Coach();
			coach.setInsId(insId);
			coach.setName(name);
			coach.setAddress(address);
			coach.setFingerprint(fingerprint);
			coach.setIdcard(idcard);
			coach.setMobile(mobile);
			coach.setPhoto(photo);
			coach.setSex(sex);
			coach.setStationId(stationId);
			coach.setCarBrand(carBrand);
			coach.setCarPlate(carPlate);
			coach.setCoachnum(coachNum);
			coach.setDrilicence(drilicence);
			coach.setDripermitted(dripermitted);
			coach.setEmploystatus(employstatus);
			coach.setOccupationno(occupationno);
			coach.setOccupationlevel(occupationlevel);
			coach.setSubject(subject);
			coach.setTeachpermitted(teachpermitted);
			coach.setStar(star);
			coach.setDrivingFieldId(drivingFieldId);
			coach.setLanguage(language);
			coach.setIsCountry(isCountry);
			coach.setIsProvince(isProvince);
			//logger.error("save coach  2");
			if (StringUtils.hasText(receiveTime)) {
				coach.setReceiveTime(format.parse(receiveTime));
			}
			if (StringUtils.hasText(leavedate)) {
				coach.setLeavedate(format.parse(leavedate));
			}
			if (StringUtils.hasText(drivingTime)) {
				coach.setDrivingTime(format.parse(drivingTime));
			}
			if (StringUtils.hasText(hiredate)) {
				coach.setHiredate(format.parse(hiredate));
			}
			if (StringUtils.hasText(birth)) {
				coach.setBirth(format.parse(birth));
			}
			//logger.error("save coach  3");
			if (id == null) {
				//logger.error("save coach  5");
				Integer coachId = coachService.add(coach);
				
				if(coachId.intValue() == -1)
				{
					result.error("教练身份证已存在");
					return result;
				}
				coachService.insertByCoach(coach.getId(), stationId);
				if (StringUtils.hasText(firstAfterSchooL)) {
					coachService.addCoachPayOrUpd(coach.getId(), timeCharges);
				}
			} else {
				coach.setId(id);
				//logger.error("save coach  6");
				coachService.update(coach);
				//logger.error("save coach 7 ");
				if(stationId!=null){
					coachService.insertByCoach(coach.getId(), stationId);
				}
				
				/*
				if (StringUtils.hasText(firstAfterSchooL)) {
					coachService.addCoachPayOrUpd(coach.getId(), timeCharges);
				}
				*/
			}
			//logger.error("save coach  1");
			result.success(coach);
		} catch (Throwable ex) {
			//logger.error("save coach  2");
			result.error(ex);
		}
		return result;
	}

	@ResponseBody
	@RequestMapping(value = "/getcoach/{id}", method = RequestMethod.GET)
	@UserControllerLog(description = "获取教练信息")
	public Result getCoach(@PathVariable Integer id, HttpServletRequest request) {
		Assert.notNull(id, "id is null");
		Result result = new Result();
		try {
			Coach security = coachService.getCoach(id);
			result.success(security);
		} catch (Exception e) {
			logger.error("Coach get", e);
		}
		return result;
	}

	/**
	 * 导出教练信息
	 */
	/*@SuppressWarnings("deprecation")
	@RequestMapping(value = "/exportCoachlist", method = RequestMethod.GET)
	public Result exportStudents(HttpServletResponse response) throws IOException {
		// Result result= new Result();
		//List<ServiceStation> tataion = tservicestationService.gettation();
		response.setCharacterEncoding("UTF-8");
		String fileName = "教练基本信息.xls";
		fileName = new String(fileName.getBytes("GBK"), "ISO8859_1");
		response.setHeader("Content-Disposition", "attachment;filename=" + fileName);

		response.setDateHeader("Expires", 0);
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Pragma", "no-cache");
		try {
			HSSFSheet sheet = null;
			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFFont f = wb.createFont();
		List<Coach> exportlist = coachService.exportCoachList();
		//for (ServiceStation string : tataion) { // 循环添加sheet
			int exportRow = 1;
			 sheet = wb.createSheet("教练信息");
			//sheet = wb.createSheet(string.getName());
			HSSFRow row = sheet.createRow(0);
			HSSFCell cell = null;
			HSSFCellStyle style = wb.createCellStyle();
			style.setWrapText(true);// 设置自动换行
			// 第一个参数代表列id(从0开始),第2个参数代表宽度值
			sheet.setColumnWidth(0, 4500);
			sheet.setColumnWidth(1, 4500);
			sheet.setColumnWidth(2, 4500);
			sheet.setColumnWidth(3, 4500);
			sheet.setColumnWidth(4, 4500);
			sheet.setColumnWidth(5, 4500);
			f.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);// 粗体显示
			style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
			sheet.autoSizeColumn(1, true);
			// row.setHeightInPoints(30); //设置行高
			style.setFont(f);
			sheet.autoSizeColumn(1);
			// 获取第一行的每一个单元格
			cell = row.createCell(0);
			// 往单元格里面写入值
			cell.setCellValue("教练信息"); // 头部
			cell.setCellStyle(style);
			
			for (int i = 0; i < exportlist.size(); i++) { // 循环导出数据
				Coach stu = exportlist.get(i);
				// 第四步，创建单元格，并设置值
				row = sheet.createRow((int) exportRow);

				//if (string.getId() == stu.getStationId()) {
					// 姓名
					if (stu.getName() != null) {
						row.createCell((short) 0).setCellValue(stu.getName());
					} else {
						row.createCell((short) 0).setCellValue(" ");
					}

					// 性别
					if (stu.getSex() != null) {
						if (stu.getSex() == 1) {
							row.createCell((short) 1).setCellValue("男");
						} else if (stu.getSex() == 2) {
							row.createCell((short) 1).setCellValue("女");
						}
					} else {
						row.createCell((short) 1).setCellValue(" ");
					}
					// 电话
					if (stu.getMobile() != null) {

						row.createCell((short) 2).setCellValue(stu.getMobile());
					} else {
						row.createCell((short) 2).setCellValue(" ");
					}

					// 教练车车牌
					if (stu.getCarPlate() != null) {
						row.createCell((short) 3).setCellValue(stu.getCarPlate());
					} else {
						row.createCell((short) 3).setCellValue(" ");
					}

					// 准驾车型
					if (stu.getDripermitted() != null) {
						row.createCell((short) 4).setCellValue(stu.getDripermitted());
					} else {
						row.createCell((short) 4).setCellValue(" ");
					}

					// 准教车型
					if (stu.getTeachpermitted() != null) {
						row.createCell((short) 5).setCellValue(stu.getTeachpermitted());
					} else {
						row.createCell((short) 5).setCellValue(" ");
					}

					// 联系地址
					if (stu.getAddress() != null) {
						row.createCell((short) 6).setCellValue(stu.getAddress());
					} else {
						row.createCell((short) 6).setCellValue(" ");
					}
					exportRow++;
				}
			//}	
		//}	
			// 设置弹出，用户自己选择路径进行保存。
			OutputStream out = response.getOutputStream();
			wb.write(out);
			out.flush();  
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}*/
	
	private ReaderExcelUtils reu = new ReaderExcelUtils();
	@Resource
	private InstitutionInfoService institutionService;
	/**
	 * 读取Excel文件,将数据存入数据库
	 * 
	 * @param data
	 *            数据
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "static-access" })
	@ResponseBody
	@RequestMapping(value = "/InsertCoachToDB", method = RequestMethod.POST)
	@UserControllerLog(description = "excel导入教练数据")
	public Result InsertToDataBase(@RequestParam(value="stationId", required=false)Integer stationId, HttpServletRequest request) throws Exception {
		Result result = new Result();
		Date date = new Date();
		long time = date.getTime();
		List errorList=new ArrayList();
		try {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			MultipartFile file = multipartRequest.getFile("upCoachfile");
			if(file.isEmpty()){  
	            throw new Exception("文件为空！");  
	        }
			//文件名字
			String fileName=file.getOriginalFilename();
			//输入流
			InputStream in=file.getInputStream();
			List<Map> dataListMap = reu.ReaderExcel(in, fileName);
			Iterator it = null;
			// sheet名字数组
			String[] nameStrs = new String[0];
			if (dataListMap != null) {
				int index = dataListMap.size() - 1;
				Map namesMap = dataListMap.get(index);
				String names = namesMap.get("nameStrs").toString();
				nameStrs = names.split(",");
			}
			try {
				int number = 0;
				// sheet名数组下标
				int sheetIndex = 0;
				int[] count = new int[nameStrs.length];
				/**
				 * 教练员
				 */
				it = dataListMap.iterator();
				while (it.hasNext()) {
					Map oneMap = (Map) it.next();
					if (oneMap.get("sheetName" + nameStrs[sheetIndex]) == null) {
						continue;
					} else {
						count[sheetIndex]++;
						// 字符串中的日期格式
						DateFormat to_type = new SimpleDateFormat("yyyyMMdd");

						Coach coach = new Coach();
						String insIdEx = oneMap.get("培训机构编号").toString() != "" ? oneMap.get("培训机构编号").toString() : null;
						Integer insId = institutionService.getInsId(insIdEx);// 得到对应的培训机构id
						coach.setInsId(insId);
						coach.setStationId(stationId);//培训网点
						coach.setCoachnum(oneMap.get("教练员编号").toString());
						coach.setName(oneMap.get("姓名").toString());
						// 性别(空值就设置为 男 )
						Integer sexEx = oneMap.get("性别").toString().trim() != ""
								? Integer.parseInt(oneMap.get("性别").toString().trim()) : 1;
						coach.setSex(sexEx);
						coach.setIdcard(oneMap.get("身份证号").toString());
						coach.setMobile(oneMap.get("手机号码").toString());
						coach.setAddress(oneMap.get("联系地址").toString());
						Integer photoIdEx = oneMap.get("照片文件ID").toString().trim() != ""
								? Integer.parseInt(oneMap.get("照片文件ID").toString().trim()) : null;
						coach.setPhotoId(photoIdEx);
						Integer fingerPrintIdEx = oneMap.get("指纹图片ID").toString().trim() != ""
								? Integer.parseInt(oneMap.get("指纹图片ID").toString().trim()) : null;
						coach.setFingerprintId(fingerPrintIdEx);
						coach.setDrilicence(oneMap.get("驾驶证号").toString());
						Date receiveTimeEx = oneMap.get("驾驶证初领日期").toString().trim() != ""
								? to_type.parse(oneMap.get("驾驶证初领日期").toString().trim()) : null;
						coach.setReceiveTime(receiveTimeEx);
						coach.setOccupationno(oneMap.get("职业资格证号").toString());
						Integer occLevelEx = oneMap.get("职业资格等级").toString().trim() != ""
								? Integer.parseInt(oneMap.get("职业资格等级").toString().trim()) : null;
						coach.setOccupationlevel(occLevelEx);
						coach.setDripermitted(oneMap.get("准驾车型").toString());
						coach.setTeachpermitted(oneMap.get("准教车型").toString());
						Integer employStaEx = oneMap.get("供职状态").toString().trim() != ""
								? Integer.parseInt(oneMap.get("供职状态").toString().trim()) : null;
						coach.setEmploystatus(employStaEx);
						Date hireDateEx = oneMap.get("入职时间").toString().trim() != ""
								? to_type.parse(oneMap.get("入职时间").toString().trim()) : null;
						coach.setHiredate(hireDateEx);
						Date leaveDateEx = oneMap.get("离职时间").toString().trim() != ""
								? to_type.parse(oneMap.get("离职时间").toString().trim()) : null;
						coach.setLeavedate(leaveDateEx);

						try {
							number = coachService.addByExcel(coach);
						} catch (Exception e) {
							if(("本驾校已存在身份证号为 " + coach.getIdcard() + " 的教练员").equals(e.getMessage())){
								logger.error(e.getMessage());
								if(errorList.size()<5){
									errorList.add(e.getMessage());
								}
							}else{
								logger.error(e.getMessage());
								if(errorList.size()<5){
									errorList.add("本驾校已存在电话号为 " + coach.getMobile() + " 的教练员");
								}
							}
						}
						number = 1;
						it.remove();
						if (count[sheetIndex] == Integer
								.parseInt(oneMap.get(nameStrs[sheetIndex] + "SheetNumber").toString())) {
							sheetIndex++;
							break;
						}
					}
				}
			} catch (Exception e) {
				logger.error("CoachController field list", e);
				result.error(e);
			}
			if(errorList.size()>0){
				if(errorList.size()==5){
					errorList.add("...");
				}
				result.error("");
				result.put("errorList", errorList);
			}
			Date date2 = new Date();
			long time2 = date2.getTime();
			long longs = time2 - time;
			System.out.println(longs);
		} catch (FileUploadBase.FileSizeLimitExceededException e) {
			logger.error("CoachController field list", e);
			result.error(e);
		} catch (Exception e) {
			logger.error("CoachController field list", e);
			result.error(e);
		}
		return result;
	}
	
	/**
	 * 教练员模版和数据对应导出
	 */
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/exportCoachlist", method = RequestMethod.GET)
	@UserControllerLog(description = "教练员模版和数据对应导出")
	public Result exportStudentstow(@RequestParam(value="insId")Integer insId,@RequestParam(value = "stationId")Integer stationId,HttpServletResponse response) throws IOException {
		// Result result= new Result();
		//List<ServiceStation> tataion = tservicestationService.gettation();
		response.setCharacterEncoding("UTF-8");
		String fileName = "教练基本信息.xls";
		fileName = new String(fileName.getBytes("GBK"), "ISO8859_1");
		response.setHeader("Content-Disposition", "attachment;filename=" + fileName);

		response.setDateHeader("Expires", 0);
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Pragma", "no-cache");
		try {
			HSSFSheet sheet = null;
			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFFont f = wb.createFont();
			
			Map map = new HashMap();
			map.put("insId", insId);
			if(stationId != null && stationId != 0){
				map.put("stationId", stationId);
			}
			
			
		List<Coach> exportlist = coachService.exportCoachList(map);
		//for (ServiceStation string : tataion) { // 循环添加sheet
			int exportRow = 1;
			 sheet = wb.createSheet("教练信息");
			//sheet = wb.createSheet(string.getName());
			HSSFRow row = sheet.createRow(0);
			HSSFCell cell = null;
			HSSFCellStyle style = wb.createCellStyle();
			style.setWrapText(true);// 设置自动换行
			// 第一个参数代表列id(从0开始),第2个参数代表宽度值
			sheet.setColumnWidth(0, 4500);
			sheet.setColumnWidth(1, 4500);
			sheet.setColumnWidth(2, 4500);
			sheet.setColumnWidth(3, 4500);
			sheet.setColumnWidth(4, 4500);
			sheet.setColumnWidth(5, 4500);
			f.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);// 粗体显示
			style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
			sheet.autoSizeColumn(1, true);
			// row.setHeightInPoints(30); //设置行高
			style.setFont(f);
			sheet.autoSizeColumn(1);
			// 获取第一行的每一个单元格
			cell = row.createCell(0);
			cell.setCellValue("教练员编号"); 
			cell.setCellStyle(style);
			
			cell = row.createCell(1);
			cell.setCellValue("姓名"); 
			cell.setCellStyle(style);
			
			cell = row.createCell(2);
			cell.setCellValue("性别"); 
			cell.setCellStyle(style);
			
			cell = row.createCell(3);
			cell.setCellValue("身份证号"); 
			cell.setCellStyle(style);
		
			cell = row.createCell(4);
			cell.setCellValue("手机号码"); 
			cell.setCellStyle(style);

			cell = row.createCell(5);
			cell.setCellValue("准驾车型"); 
			cell.setCellStyle(style);
			
			cell = row.createCell(6);
			cell.setCellValue("供职状态"); 
			cell.setCellStyle(style);
			
			cell = row.createCell(7);
			cell.setCellValue("入职时间"); 
			cell.setCellStyle(style);
			
			cell = row.createCell(8);
			cell.setCellValue("离职时间"); 
			cell.setCellStyle(style);
			
			for (int i = 0; i < exportlist.size(); i++) { // 循环导出数据
				Coach stu = exportlist.get(i);
				// 第四步，创建单元格，并设置值
				row = sheet.createRow((int) exportRow);

				//if (string.getId() == stu.getStationId()) {
				
				
				// 教练员编号
				if (stu.getCoachnum() != null) {
					row.createCell((short) 0).setCellValue(stu.getCoachnum());
				} else {
					row.createCell((short) 0).setCellValue(" ");
				}
 
				
				// 姓名
				if (stu.getName() != null) {
					row.createCell((short) 1).setCellValue(stu.getName());
				} else {
					row.createCell((short) 1).setCellValue(" ");
				}

				// 性别
				if (stu.getSex() != null) {
					if (stu.getSex() == 1) {
						row.createCell((short) 2).setCellValue("男");
					} else if (stu.getSex() == 2) {
						row.createCell((short) 2).setCellValue("女");
					}
				} else {
					row.createCell((short) 2).setCellValue(" ");
				}
				
					
				//身份证号
				if (stu.getIdcard() != null) {

					row.createCell((short) 3).setCellValue(stu.getIdcard());
				} else {
					row.createCell((short) 3).setCellValue(" ");
				}
					
					
				// 电话	
				if (stu.getMobile() != null) {

					row.createCell((short) 4).setCellValue(stu.getMobile());
				} else {
					row.createCell((short) 4).setCellValue(" ");
				}
					
		      
				// 准驾车型
				if (stu.getDripermitted() != null) {
					row.createCell((short) 5).setCellValue(stu.getDripermitted());
				} else {
					row.createCell((short) 5).setCellValue(" ");
				}

				// 供职状态
				if (stu.getEmploystatus() != null) {
					if(stu.getEmploystatus()==0){
						row.createCell((short) 6).setCellValue("在职");
					}else if(stu.getEmploystatus()==1){
						row.createCell((short) 6).setCellValue("离职");
					}
				} else {
					row.createCell((short) 6).setCellValue(" ");
				}

					
				// 入职时间
				if (stu.getHiredate() != null) {
				      cell = row.createCell((short) 7);  
				      cell.setCellValue(new SimpleDateFormat("yyyy-MM-dd").format(stu  
			                    .getHiredate()));  
				} else {
					row.createCell((short) 7).setCellValue(" ");
				}
					
				// 离职时间
				if (stu.getLeavedate() != null) {
				      cell = row.createCell((short) 8);  
				      cell.setCellValue(new SimpleDateFormat("yyyy-MM-dd").format(stu  
			                    .getLeavedate()));  
				} else {
					row.createCell((short) 8).setCellValue(" ");
				}
					exportRow++;
				}
			//}	
		//}	
			// 设置弹出，用户自己选择路径进行保存。
			OutputStream out = response.getOutputStream();
			wb.write(out);
			out.flush();  
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@Resource
	private ServiceStationService stationService;
	
	@ResponseBody
	@RequestMapping(value="/getStations",method=RequestMethod.GET)
	@UserControllerLog(description = "getStations")
	public Result getStationsByInsId(@RequestParam("insId")Integer insId,HttpServletRequest request){
		Result result = new Result();
		try {
			Assert.notNull(insId,"id is null");
			List<ServiceStation> stationList=new ArrayList<ServiceStation>();
			stationList=stationService.getStationsByInsId(insId);
			result.success(stationList);
		} catch (Exception e) {
			logger.error("CoachController getStations",e);
			result.error("");
		}
		return result;
	}

	/**
	 * 导出某个时间段内的教练排班列表
	 * 
	 * @param startTime
	 *            开始时间
	 * @param endTime
	 *            结束时间
	 * @param response
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@ResponseBody
	@RequestMapping(value = "/exportCoachStationDuty", method = RequestMethod.GET)
	@UserControllerLog(description = "导出某个时间段内的教练排班列表")
	public Result exportCoachStationDuty(@RequestParam(value = "coachId") Integer coachId,
			@RequestParam(value = "stationId")Integer stationId,
			@RequestParam(value = "searchText", required = false)String searchText,
			@RequestParam(value = "startTime", required = false) Long startTime,
			@RequestParam(value = "endTime", required = false) Long endTime, HttpServletResponse response)
			throws IOException {

		Assert.notNull(coachId);
		Assert.notNull(stationId);
		
		if(startTime == 0){
			startTime = Calendar.getInstance().getTime().getTime();
		}

		String fileName = new String("教练排班信息.xls".getBytes("GBK"), "ISO8859_1");

		response.setCharacterEncoding("UTF-8");
		response.setHeader("Content-Disposition", "attachment;filename=" + fileName);

		response.setDateHeader("Expires", 0);
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Pragma", "no-cache");

		try {
			HSSFSheet sheet = null;
			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFFont f = wb.createFont();
			
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			//String searchText = request.getParameter("searchText");
			
			Map map = new HashMap();
			startTime = startTime == 0 ? Calendar.getInstance().getTime().getTime() : startTime;
			map.put("now", dateFormat.format(new Date(startTime)));
			if(endTime != 0){
				map.put("future", dateFormat.format(new Date(endTime)));
			}
			map.put("searchText", null); // 搜索框
			if(searchText != null && searchText.equals("")){
				map.put("searchText", searchText);
			}
			if(stationId != 0 && stationId != null){
				map.put("stationId", stationId); // 网点id	
			}
			if(coachId != 0){
				map.put("coachId", coachId);
			}
			map.put("pageIndex", 0); // 第几页
			map.put("pageSize", Integer.MAX_VALUE); // 每页条数
			Page<CoachDuty> page = coachService.stationDuty(map);
			
			List<CoachDuty> exportlist = page.getData();// coachService.exportCoachList(insId);

			// 设置表头
			List<String> columnsName = new ArrayList<>();
			columnsName.addAll(Arrays.asList(new String[] { "日期", "教练" }));

			for (int i = 6; i < 22; i++) {
				String name = String.valueOf(i) + ":00-" + String.valueOf((i + 1)) + ":00";
				columnsName.add(name);
			}

			int exportRow = 1;

			HSSFCell cell = null;
			HSSFCellStyle style = wb.createCellStyle();
			style.setWrapText(true);// 设置自动换行

			f.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);// 粗体显示
			style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式

			sheet = wb.createSheet("教练排班信息");
			HSSFRow row = sheet.createRow(0);
			// 第一个参数代表列id(从0开始),第2个参数代表宽度值
			for (int columnIndex = 0; columnIndex < columnsName.size(); columnIndex++) {
				sheet.setColumnWidth(columnIndex, 4500);
			}
			sheet.autoSizeColumn(1, true);
			// row.setHeightInPoints(30); //设置行高
			style.setFont(f);
			sheet.autoSizeColumn(1);

			// 设置第一行全部单元格
			for (int columnIndex = 0; columnIndex < columnsName.size(); columnIndex++) {
				cell = row.createCell((columnIndex));
				cell.setCellValue(columnsName.get(columnIndex).toString());
			}

			// 获取CoachDuty类所有方法对象
			Class clazz = CoachDuty.class;
			List<java.lang.reflect.Method> coachMethods = Arrays.asList(clazz.getDeclaredMethods());
			

			for (int i = 0; i < exportlist.size(); i++) { // 循环导出数据
				CoachDuty coachDuty = exportlist.get(i);
				// 第四步，创建单元格，并设置值
				row = sheet.createRow((int) exportRow++);

				// 第一列 日期
				String dateString = coachDuty.getDay() != null ? dateFormat.format(coachDuty.getDay()) : " ";
				row.createCell(0).setCellValue(dateString);
				// 第一列 教练
				String coachNameString = coachDuty.getName() != null ? coachDuty.getName() : " ";
				row.createCell(1).setCellValue(coachNameString);

				// 后面列 这一天的所有时间点
				for (int timeIndex = 6; timeIndex < 22; timeIndex++) {
					String methodName = "getF" + timeIndex + "s";
					String resultString = "";
					// 存在getF6s方法 类似名字的方法
					Method getFs = coachMethods.stream().filter(s -> s.getName().equals(methodName)).findFirst().get();
					if (getFs != null) {
						resultString = (String) getFs.invoke(coachDuty);
					}
					row.createCell(timeIndex - 4).setCellValue(resultString);
				}

			}

			// 设置弹出，用户自己选择路径进行保存。
			OutputStream out = response.getOutputStream();
			wb.write(out);
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	//删除
	@ResponseBody
	@RequestMapping(value="/updatestatus",method=RequestMethod.POST)
	@UserControllerLog(description = "updatestatus")
	public Result updatestatus(Integer id){
		Result result = new Result();
		Coach coach= new Coach();
		Assert.notNull(id,"id is null");
		try {
			coach.setId(id);
			coachService.updatestatus(coach);
			result.success(coach);
		} catch (Exception e) {
			logger.error(e.getMessage());
			result.error(e);
		}
		return result;
	}
	
	
	/**
	 * 练车排班管理 , 如果根据参数查询存在2个及以上的教练，择返回教练列表，只有一个则返回这个教练的未来7天排班记录
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/exerciseManage", method = RequestMethod.GET)
	@UserControllerLog(description = "练车排班管理")
	public Result exerciseManage(@RequestParam(value = "coachId") Integer coachId,
			@RequestParam(value = "areaId") Integer areaId,
			@RequestParam(value = "stationId") Integer stationId,
			@RequestParam(value = "searchText") String searchText) {
		Result result = new Result();
		
		if(coachId == 0 && areaId == 0 && stationId == 0 && StringUtils.isEmpty(searchText)){
			result.error(707,"必须填一项");
			return result;
		}

		SecurityContext context = SecurityContextHolder.getContext();
		UsinInfo usinInfo = (UsinInfo) context.getAuthentication().getPrincipal();

		Integer InsId = usinInfo.getInsId();
		// 获取教练id
		boolean has_ROLE_SCHOOL_SERVICE = context.getAuthentication().getAuthorities().stream()
				.filter(a -> a.getAuthority().equals("ROLE_SCHOOL_SERVICE")).count() > 0;
		if (has_ROLE_SCHOOL_SERVICE) {
			// 网点账号,不能选择片区和网点
			areaId = null;
			stationId = usinInfo.getStationId();
		}

		Map map = new HashMap<>();
		map.put("coachId", coachId);
		map.put("searchText", searchText);
		map.put("areaId", areaId);
		map.put("stationId", stationId);
		map.put("insId", InsId);

		Page<Coach> coachPage = coachService.getCoachCollector(map);
		List<Coach> coachs = coachPage.getData();

		// 2个及以上的教练直接返回教练列表，没有则返回没有教练
		if (coachs.size() > 1) {
			List<CoachMapItem> mapData = (List<CoachMapItem>)coachs.stream().map(a -> new CoachMapItem(a.getName(),a.getId().toString()))
					.collect(Collectors.toList());
			result.setData(mapData);
			result.error(705, "多个教练");
			return result;
		}
		if (coachs.size() == 0) {
			result.error(706, "没有教练");
			return result;
		}

		// 只有1个教练的时候执行下面获取排班记录逻辑

		// 根据教练id获取排班记录
		Coach coach = coachs.get(0);// 此步必定存在一个教练

		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date dateTime = Calendar.getInstance().getTime();

			// 生成7天数据，已有则不做处理
			coachService.addSeven(sdf.format(dateTime), coach.getId());

			Calendar calendar = Calendar.getInstance();
			calendar.setTimeInMillis(dateTime.getTime());
			calendar.add(Calendar.DATE, 6);
			Date seven = calendar.getTime();

			map = new HashMap();
			map.put("now", sdf.format(dateTime)); // 搜索框
			map.put("future", sdf.format(seven)); // 驾校id
			map.put("coachId", coach.getId()); // 教练id
			
			List<CoachDuty> page = coachService.dutyList(map);
			List<CoachDuty> data = new ArrayList<CoachDuty>();

			for (int i = 0; i <= 6; i++) {
				Calendar calendar2 = Calendar.getInstance();
				calendar2.setTimeInMillis(dateTime.getTime());
				calendar2.add(Calendar.DATE, i);

				data.add(i, null);
				for (CoachDuty coachDuty : page) {
					if (coachDuty.getDay().getDay() == calendar2.getTime().getDay()) {
						data.remove(i);
						data.add(i, coachDuty);
						break;
					}
				}
			}
			
			result.success(data);
		} catch (Throwable e) {
			logger.error("教练预约列表", e);
			result.error(e);
		}

		return result;
	}
	
	/**
	 * 根据关键字获取教练列表
	 * @param coachKeyWork
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/searchCoach", method = RequestMethod.GET)
	@UserControllerLog(description = "根据关键字获取教练列表")
	public Result searchCoach(searchCoachParam param) {
		
		Result result = new Result();
		
		if(org.apache.commons.lang.StringUtils.isBlank(param.getSearchKeyWord())){
			result.success(new ArrayList<CoachMapItem>());
			return result;
		}

		SecurityContext context = SecurityContextHolder.getContext();
		UsinInfo usinInfo = (UsinInfo) context.getAuthentication().getPrincipal();

		boolean has_ROLE_SCHOOL_SERVICE = context.getAuthentication().getAuthorities().stream()
				.filter(a -> a.getAuthority().equals("ROLE_SCHOOL_SERVICE")).count() > 0;

		List<Coach> coachs = null;
		if (has_ROLE_SCHOOL_SERVICE) {
			// TODO 网点账号 根据网点获取网点的教练列表
			coachs = coachService.getCoachCollectorByKeyWork(param.getSearchKeyWord(), usinInfo.getInsId(), null,
					usinInfo.getStationId());
		} else {
			// TODO 机构账号
			coachs = coachService.getCoachCollectorByKeyWork(param.getSearchKeyWord(), usinInfo.getInsId(),
					param.getAreaId(), param.getStationId());
		}

		List<CoachMapItem> coachMapItems = coachs != null && coachs.size() > 0 ? coachs.stream()
				.map(c -> new CoachMapItem(c.getName(), c.getId().toString())).collect(Collectors.toList())
				: new ArrayList<CoachMapItem>();

		result.success(coachMapItems);
		return result;
	}
	
	/**
	 * 保存教练某天的排班是否发布
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/saveCoachDutyStatus", method = RequestMethod.POST)
	@UserControllerLog(description = "保存教练某天的排班是否发布")
	public Result saveCoachDutyStatus(@RequestParam(value = "coachId")Integer coachId 
			, @RequestParam(value = "time")Long time 
			, @RequestParam(value = "publish")Integer publish){

		Result result = new Result();
		Date now = new Date(time);
		//获取教练
		CoachDuty coachDuty = coachDutyService.getCoach(coachId, now);
		if(coachDuty == null){
			result.error(705,"获取教练失败");
			return result;
		}
		//设置状态
		coachDuty.setSubject(publish);
		//保存发布状态 
		Integer updateResult = coachDutyService.update(coachDuty);
		if(updateResult > 0){
			result.success();
		}
		
		return result;
	}
	
}
