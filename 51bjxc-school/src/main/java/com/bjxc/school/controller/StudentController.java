package com.bjxc.school.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.bjxc.Page;
import com.bjxc.Result;
import com.bjxc.school.Coach;
import com.bjxc.school.ServiceStation;
import com.bjxc.school.Student;
import com.bjxc.school.StudentInsLog;
import com.bjxc.school.StudentSubject;
import com.bjxc.school.TrainingCar;
import com.bjxc.school.security.UsinInfo;
import com.bjxc.school.service.CoachService;
import com.bjxc.school.service.StudentInsLongService;
import com.bjxc.school.service.StudentRefereeService;
import com.bjxc.school.service.StudentService;
import com.bjxc.school.service.StudentSubjectService;
import com.bjxc.school.service.TservicestationService;
import com.bjxc.web.utils.WebUtils;

/**
 * 学生信息管理 新增 修改、删除
 * 
 * @author fwq
 *
 */
@RestController
@RequestMapping(value = "/student")
public class StudentController {
	private static final Logger logger = LoggerFactory.getLogger(StudentController.class);
	private static final Integer Integer = null;
	@Resource
	private StudentService studentService;

	@Resource
	private StudentInsLongService studentInsLongService;

	@Resource
	private StudentRefereeService refereeService;

	@Resource
	private TservicestationService tservicestationService;
	
	@Resource
	private StudentSubjectService studentSubjectService;
	
	@Resource
	private CoachService coachService;
	
	/**
	 * 学员信息 名称的模糊搜索
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	@UserControllerLog(description = "学员信息查询")    
	public Result pageQuery(@RequestParam(value = "insId", required = true) Integer insId,
			@RequestParam(value = "stationId", required = false) Integer stationId,
			@RequestParam(value = "searchText", required = false) String searchText,
			@RequestParam(value = "time1", required = false) String time1,
			@RequestParam(value = "time2", required = false) String time2,
			@RequestParam(value = "subjectid", required = true) Integer subjectid,
			@RequestParam(value = "traintype", required = false) String traintype,
			@RequestParam(value = "sex", required = false) Integer sex,
			@RequestParam(value = "stationName", required = false) String stationName,
			@RequestParam(value = "paymode", required = false) Integer paymode,
			@RequestParam(value = "chargemode", required = false) Integer chargemode,Integer pageIndex, Integer pageSize,
			HttpServletRequest request) {
		if (searchText == "") {
			searchText = null;
		}
		if (time1 == "") {
			time1 = null;
		}
		if (time2 == "") {
			time2 = null;
		}
		if (subjectid == -100) {
			subjectid = null;
		}
		Result result = new Result();
		Integer coachId = WebUtils.getParameterIntegerValue(request, "coachId");
		Integer coachOrStu = 1;
				/*WebUtils.getParameterIntegerValue(request, "coachOrStu");*/
		try {
			Page<Student> page = null;
			if (coachId != null) {
				System.out.println(1);
				page = studentService.getCoachStu(coachId, searchText, pageIndex, pageSize);
			} else if (new Integer(1).equals(coachOrStu) || coachOrStu == null) {
				System.out.println(2);
				page = studentService.pageQuery(chargemode,paymode,stationName,sex,insId, stationId,traintype,searchText, time1, time2, subjectid, pageIndex,
						pageSize);
			} else if (new Integer(2).equals(coachOrStu)) {
				System.out.println(3);
				page = studentService.getCoachStu(coachId, searchText, pageIndex, pageSize);
			}

			result.success(page.getData());
			result.put("rowCount", page.getRowCount());
		} catch (Exception e) {
			logger.error("Student field list", e);
			result.error(e);
		}
		return result;
	}

	@RequestMapping(value = "/accountList", method = RequestMethod.GET)
	@UserControllerLog(description = "获取用户列表")    
	public Result getAccountList(Integer stationId, Integer pageIndex, Integer pageSize, HttpServletRequest request) {
		Result result = new Result();
		try {
			Page<Student> page = null;
			page = studentService.getAccountList(stationId, pageIndex, pageSize);
			result.success(page.getData());
			result.put("rowCount", page.getRowCount());
		} catch (Exception e) {
			logger.error("Student field list", e);
			result.error(e);
		}
		return result;
	}

	@ResponseBody
	@RequestMapping(value = "/payWaterList", method = RequestMethod.GET)
	public Result getPayWaterList(Integer id, Integer stationId, Integer pageIndex, Integer pageSize,
			HttpServletRequest request) {
		Result result = new Result();
		try {
			Page<Student> page = null;
			if (id == null) {
				page = studentService.getPayWaterList(null, stationId, pageIndex, pageSize);
			} else {
				page = studentService.getPayWaterList(id, stationId, 0, 10);
			}
			result.success(page.getData());
			result.put("rowCount", page.getRowCount());
		} catch (Exception e) {
			logger.error("Student field list", e);
			result.error(e);
		}
		return result;
	}

	/**
	 * 按ID找练车场地信息
	 * 
	 * @param id
	 *            练车场地ID必填
	 * @return
	 */
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public Result get(@PathVariable("id") Integer id, HttpServletRequest request) {
		Assert.notNull(id, "id is null");
		Result result = new Result();
		try {
			Student student = studentService.get(id);
			/*Integer tuition = student.getTuition();
			if (tuition != null) {
				tuition = tuition / 100;
				student.setTuition(tuition);
			}
			Integer alreadyPay = student.getAlreadyPay();
			if (alreadyPay != null) {
				alreadyPay = alreadyPay / 100;
				student.setAlreadyPay(alreadyPay);
			}
			Integer arrearage = student.getArrearage();
			if (arrearage != null) {
				arrearage = arrearage / 100;
				student.setArrearage(arrearage);
			}*/

			result.success(student);
		} catch (Throwable ex) {
			logger.error("student field get ", ex);
		}
		return result;
	}

	/**
	 * 保存学员信息，前端传有ID参数为修改，没有ID信息为新增
	 * 
	 * @param request
	 *            web请求对象
	 * @return
	 */
	@RequestMapping(method = RequestMethod.POST)
	public Result save(HttpServletRequest request) {
		String name = WebUtils.getParameterValue(request, "name");
		System.out.println("name" + name);
		Integer status = WebUtils.getParameterIntegerValue(request, "status");
		Integer insId = WebUtils.getParameterIntegerValue(request, "insId");
		String userIds = WebUtils.getParameterValue(request, "userId");
		Integer userId=null;
		if(userIds!=null && !userIds.equals("null")){
			userId=Integer.parseInt(userIds);
		}
		Integer paymentType = WebUtils.getParameterIntegerValue(request, "paymentType");
		Integer cradtype = WebUtils.getParameterIntegerValue(request, "cradtype");
		Integer sex = WebUtils.getParameterIntegerValue(request, "sex");
		Integer busitype = WebUtils.getParameterIntegerValue(request, "busitype");
		String mobile = WebUtils.getParameterValue(request, "mobile");
		String idcard = WebUtils.getParameterValue(request, "idcard");
		String nationality = WebUtils.getParameterValue(request, "nationality");
		String address = WebUtils.getParameterValue(request, "address");
		String photo = WebUtils.getParameterValue(request, "photo");
		String fingerprint = WebUtils.getParameterValue(request, "fingerprint");
		String drilicnum = WebUtils.getParameterValue(request, "drilicnum");
		String perdritype = WebUtils.getParameterValue(request, "perdritype");
		String traintype = WebUtils.getParameterValue(request, "traintype");
		String recordnum = WebUtils.getParameterValue(request, "recordnum");
		String applydate = WebUtils.getParameterValue(request, "applydate");
		String remark = WebUtils.getParameterValue(request, "remark");
		String fstdrilicdate = WebUtils.getParameterValue(request, "fstdrilicdate");
		Integer id = WebUtils.getParameterIntegerValue(request, "id");
		Integer classTypeId = WebUtils.getParameterIntegerValue(request, "classTypeId");
		Integer stationId = WebUtils.getParameterIntegerValue(request, "stationId");
		Double tuition = WebUtils.getParameterDoubleValue(request, "tuition");
		Double alreadyPay = WebUtils.getParameterDoubleValue(request, "alreadyPay");
		System.out.println(alreadyPay+",1111111111111111111111");
		Double arrearage = WebUtils.getParameterDoubleValue(request, "arrearage");
		String refereeMobile = WebUtils.getParameterValue(request, "refereeMobile");
		String refereeName = WebUtils.getParameterValue(request, "refereeName");
		String stunum=WebUtils.getParameterValue(request, "stunum");
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Integer isProvince = WebUtils.getParameterIntegerValue(request, "isProvince");
		Result result = new Result();
		try {
			Student student = new Student();
			student.setInsId(insId);
			student.setName(name);
			student.setStatus(status);
			student.setAddress(address);
			student.setPaymentType(paymentType);
			student.setRemark(remark);
			if (StringUtils.hasText(applydate)) {
				student.setApplydate(format.parse(applydate));// format.parse(applydate)
			}
			student.setBusitype(busitype);
			student.setCradtype(cradtype);
			student.setDrilicnum(drilicnum);
			student.setFingerprint(fingerprint);
			if (StringUtils.hasText(fstdrilicdate)) {
				student.setFstdrilicdate(format.parse(fstdrilicdate));// format.parse(fstdrilicdate)
			}
			student.setIdcard(idcard);
			student.setMobile(mobile);
			student.setNationality(nationality);
			student.setPerdritype(perdritype);
			student.setPhoto(photo);
			student.setSex(sex);
			student.setStatus(status);
			student.setRecordnum(recordnum);
			student.setTraintype(traintype);
			student.setUserId(userId);
			student.setStationId(stationId);
			student.setClassTypeId(classTypeId);
			student.setRefereeMobile(refereeMobile);
			student.setStunum(stunum);
			if (tuition != null) {
				student.setTuition(new Double(tuition * 10000.0).intValue());
			}
			if (alreadyPay != null) {
				student.setAlreadyPay(new Double(alreadyPay * 10000.0).intValue());
			}
			if (arrearage != null) {
				student.setArrearage(new Double(arrearage * 10000.0).intValue());
			}
			if (id == null) {
				 Integer studentId=studentService.add(student);
				 StudentSubject studentSubject=new StudentSubject();
				 studentSubject.setStudentId(studentId);
				studentSubjectService.addSubject(studentSubject);
			} else {
				student.setIsProvince(isProvince);
				student.setId(id);
				studentService.update(student);
			}
			refereeService.update(refereeName, refereeMobile, userId);
			result.success(student);
		} catch (Throwable ex) {
			logger.error("save Student field ", ex);
			result.error(ex);
		}
		return result;
	}

	/*@RequestMapping(value = "/changeStudentStatus", method = RequestMethod.POST)
	public Result changeStudentStatus(@RequestParam(value = "insId") Integer insId,
			@RequestParam(value = "studentId") Integer studentId, @RequestParam(value = "status") Integer status,
			@RequestParam(value = "coachId", required = false) Integer coachId) {
		Result result = new Result();
		try {
			studentService.changeStudentStatus(insId, studentId, status, coachId);

			result.success();
		} catch (Exception e) {
			logger.error("change student status ", e);
			result.error(e);
		}
		return result;
	}*/

	@RequestMapping(value = "/getStudentInsLog", method = RequestMethod.GET)
	public Result getStudentInsLog(@RequestParam(value = "studentId") Integer studentId) {
		Result result = new Result();
		try {
			List<StudentInsLog> logs = studentInsLongService.list(studentId);
			result.success(logs);
		} catch (Exception e) {
			logger.error("change student status ", e);
			result.error(e);
		}
		return result;
	}
	
	@RequestMapping(value = "/getStudentLog", method = RequestMethod.GET)
	public Result getStudentInsLog(String search) {
		Result result = new Result();
		try {
			
			//List<StudentInsLog> logs = studentInsLongService.getList(search);
			//测试数据
			StudentInsLog studentInsLog = new StudentInsLog();
			studentInsLog.setStunum("1918175333257674");
			studentInsLog.setStudentName("王小明");
			studentInsLog.setIdcard("334411199912081191");
			studentInsLog.setMobile("13678789900");
			studentInsLog.setCreateTime(getNowDate("2017-01-17 15:01:30"));
			studentInsLog.setContent("第一部分开始");
			
			StudentInsLog studentInsLog2 = new StudentInsLog();
			studentInsLog2.setStunum("1918175333257674");
			studentInsLog2.setStudentName("王小明");
			studentInsLog2.setIdcard("334411199912081191");
			studentInsLog2.setMobile("13678789900");
			studentInsLog2.setCreateTime(getNowDate("2017-01-17 15:02:30"));
			studentInsLog2.setContent("第一部分通过");
			
			StudentInsLog studentInsLog3 = new StudentInsLog();
			studentInsLog3.setStunum("1918175333257674");
			studentInsLog3.setStudentName("王小明");
			studentInsLog3.setIdcard("334411199912081191");
			studentInsLog3.setMobile("13678789900");
			studentInsLog3.setCreateTime(getNowDate("2017-01-17 15:03:30"));
			studentInsLog3.setContent("第二部分开始");
			
			StudentInsLog studentInsLog4 = new StudentInsLog();
			studentInsLog4.setStunum("1918175333257674");
			studentInsLog4.setStudentName("王小明");
			studentInsLog4.setIdcard("334411199912081191");
			studentInsLog4.setMobile("13678789900");
			studentInsLog4.setCreateTime(getNowDate("2017-01-17 15:04:30"));
			studentInsLog4.setContent("第二部分通过");	
			
			StudentInsLog studentInsLog5 = new StudentInsLog();
			studentInsLog5.setStunum("1918175333257674");
			studentInsLog5.setStudentName("王小明");
			studentInsLog5.setIdcard("334411199912081191");
			studentInsLog5.setMobile("13678789900");
			studentInsLog5.setCreateTime(getNowDate("2017-01-17 15:05:30"));
			studentInsLog5.setContent("第三部分开始");	
			
			StudentInsLog studentInsLog6 = new StudentInsLog();
			studentInsLog6.setStunum("1918175333257674");
			studentInsLog6.setStudentName("王小明");
			studentInsLog6.setIdcard("334411199912081191");
			studentInsLog6.setMobile("13678789900");
			studentInsLog6.setCreateTime(getNowDate("2017-01-17 15:05:30"));
			studentInsLog6.setContent("第三部分通过");	
			
			StudentInsLog studentInsLog7 = new StudentInsLog();
			studentInsLog7.setStunum("1918175333257674");
			studentInsLog7.setStudentName("王小明");
			studentInsLog7.setIdcard("334411199912081191");
			studentInsLog7.setMobile("13678789900");
			studentInsLog7.setCreateTime(getNowDate("2017-01-17 15:06:30"));
			studentInsLog7.setContent("第四部分开始");	
			
			StudentInsLog studentInsLog8 = new StudentInsLog();
			studentInsLog8.setStunum("1918175333257674");
			studentInsLog8.setStudentName("王小明");
			studentInsLog8.setIdcard("334411199912081191");
			studentInsLog8.setMobile("13678789900");
			studentInsLog8.setCreateTime(getNowDate("2017-01-17 15:10:30"));
			studentInsLog8.setContent("第四部分通过");	
			
			StudentInsLog studentInsLog9 = new StudentInsLog();
			studentInsLog9.setStunum("1918175333257674");
			studentInsLog9.setStudentName("王小明");
			studentInsLog9.setIdcard("334411199912081191");
			studentInsLog9.setMobile("13678789900");
			studentInsLog9.setCreateTime(getNowDate("2017-01-17 15:15:30"));
			studentInsLog9.setContent("结业");	
			
			List<StudentInsLog> logs = new ArrayList<StudentInsLog>(10);
			logs.add(studentInsLog);
			logs.add(studentInsLog2);
			logs.add(studentInsLog3);
			logs.add(studentInsLog4);
			logs.add(studentInsLog5);
			logs.add(studentInsLog6);
			logs.add(studentInsLog7);
			logs.add(studentInsLog8);
			logs.add(studentInsLog9);

			result.success(logs);
		} catch (Exception e) {
			logger.error("change student status ", e);
			result.error(e);
		}
		return result;
	}
	
	public static Date getNowDate(String dateString) {
		   SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		   Date currentTime_2 = null;
		try {
			currentTime_2 = formatter.parse(dateString);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		   return currentTime_2;
	}

	@RequestMapping(value = "getCoachStu", method = RequestMethod.POST)
	public Result getCoachStu(HttpServletRequest request, HttpServletResponse response) {
		Result result = new Result();
		Integer coachId = WebUtils.getParameterIntegerValue(request, "coachId");
		Integer subjectId = WebUtils.getParameterIntegerValue(request, "subjectId");
		String name = request.getParameter("keyword");
		try {
			List<Map> list = studentService.stuCoachDuty(coachId, subjectId, name);
			result.success(list);
		} catch (Exception e) {
			logger.error("教练可执教学员列表", e);
			result.error(e);
		}
		return result;
	}

	@RequestMapping(value = "/changeStudentStunum", method = RequestMethod.POST)
	public Result updateStudentStunum(@RequestParam(value = "studentId", required = true) Integer studentId,
			@RequestParam(value = "recordnum", required = true) String recordnum) {
		Result result = new Result();
		try {
			studentService.updateStudentStunum(studentId, recordnum);
			result.success();
		} catch (Exception e) {
			logger.error("change student status ", e);
			result.error(e);
		}
		return result;
	}

	@RequestMapping(value = "/getStudentByMobile", method = RequestMethod.POST)
	public Result getStudentByMobile(@RequestParam(value = "insId", required = true) Integer insId, String mobile) {
		Result result = new Result();
		try {
			Student student = studentService.getStudentByMobile(insId, mobile);
			result.success(student);
		} catch (Exception e) {
			logger.error("change student status ", e);
			result.error(e);
		}
		return result;
	}

	/**
	 * 学员信息报错 名称的模糊搜索
	 */
	@RequestMapping(value = "/bcList", method = RequestMethod.GET)
	public Result pageBaocuoQuery(@RequestParam(value = "insId", required = true) Integer insId,
			@RequestParam(value = "stationId", required = false) Integer stationId,
			@RequestParam(value = "searchText", required = false) String searchText, Integer pageIndex,
			Integer pageSize) {
		Result result = new Result();
		try {
			Page<Student> page = studentService.pageBaocuoQuery(insId, stationId, searchText, pageIndex, pageSize);
			result.success(page.getData());
			result.put("rowCount", page.getRowCount());
		} catch (Exception e) {
			logger.error("Student field list", e);
			result.error(e);
		}
		return result;
	}

	@RequestMapping(value = "/studentHandle", method = RequestMethod.POST)
	public Result updateBaocuo(@RequestParam(value = "id", required = true) Integer id,
			@RequestParam(value = "isWrong", required = true) Integer isWrong) {
		Result result = new Result();
		System.out.println(id + "," + isWrong);
		try {
			studentService.updateBaocuo(id, isWrong);
			result.success();
		} catch (Exception e) {
			logger.error("change studentHandle isWrong ", e);
			result.error(e);
		}
		return result;
	}

	/**
	 * 学员过期管理 名称的模糊搜索
	 */
	@RequestMapping(value = "/expireList", method = RequestMethod.GET)
	public Result pageExpireQuery(@RequestParam(value = "insId", required = true) Integer insId,
			@RequestParam(value = "stationId", required = false) Integer stationId,
			@RequestParam(value = "searchText", required = false) String searchText, Integer pageIndex,
			Integer pageSize) {
		Result result = new Result();
		try {
			Page<Student> page = studentService.pageExpireQuery(insId, stationId, searchText, pageIndex, pageSize);
			result.success(page.getData());
			result.put("rowCount", page.getRowCount());
		} catch (Exception e) {
			logger.error("Student field expireList", e);
			result.error(e);
		}
		return result;
	}

	/**
	 * 学时预警管理 名称的模糊搜索
	 */
	@RequestMapping(value = "/WarningList", method = RequestMethod.GET)
	public Result pageWarningQuery(@RequestParam(value = "insId", required = true) Integer insId,
			@RequestParam(value = "stationId", required = false) Integer stationId,
			@RequestParam(value = "searchText", required = false) String searchText, Integer pageIndex,
			Integer pageSize) {
		Result result = new Result();
		try {
			Page<Student> page = studentService.pageWarningQuery(insId, stationId, searchText, pageIndex, pageSize);
			result.success(page.getData());
			result.put("rowCount", page.getRowCount());
		} catch (Exception e) {
			logger.error("Student field WarningList", e);
			result.error(e);
		}
		return result;
	}

	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/exportstu", method = RequestMethod.GET)
	public Result exportstu(Integer insId,HttpServletResponse response,HttpServletRequest request,String insCode) throws UnsupportedEncodingException {
		response.setCharacterEncoding("UTF-8");
		String fileName = "学员基本信息";
		fileName = new String(fileName.getBytes("GBK"), "ISO8859_1");
		response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ".xls");

		response.setDateHeader("Expires", 0);
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Pragma", "no-cache");
		String stationIds=request.getParameter("stationId");
		Integer stationId=null;
		if(!stationIds.equals("null")){
			stationId=Integer.parseInt(stationIds);
		}
		try {
			HSSFSheet sheet = null;
			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFFont f = wb.createFont();
			// for (ServiceStation string : tataion) { // 循环添加sheet
			int exportRow = 1;
			List<Student> exportlist = studentService.exceporStudent(insId,stationId);
			sheet = wb.createSheet("学员信息");
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
			sheet.setColumnWidth(6, 4500);
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
			cell.setCellValue("隶属报名处"); // 头部
			cell.setCellStyle(style);
			cell = row.createCell(1);
			// 往单元格里面写入值
			cell.setCellValue("身份证号"); // 头部
			cell.setCellStyle(style);
			cell = row.createCell(2);
			// 往单元格里面写入值
			cell.setCellValue("学生姓名"); // 头部
			cell.setCellStyle(style);
			cell = row.createCell(3);
			// 往单元格里面写入值
			cell.setCellValue("性别"); // 头部
			cell.setCellStyle(style);
			cell = row.createCell(4);
			// 往单元格里面写入值
			cell.setCellValue("手机号码"); // 头部
			cell.setCellStyle(style);
			cell = row.createCell(5);
			// 往单元格里面写入值
			cell.setCellValue("班型"); // 头部
			cell.setCellStyle(style);
			cell = row.createCell(6);
			// 往单元格里面写入值
			cell.setCellValue("国籍"); // 头部
			cell.setCellStyle(style);
			cell = row.createCell(7);
			// 往单元格里面写入值
			cell.setCellValue("学员编号"); // 头部
			cell.setCellStyle(style);
			cell = row.createCell(8);
			// 往单元格里面写入值
			cell.setCellValue("教学机构编号"); // 头部
			cell.setCellStyle(style);
			cell = row.createCell(9);
			// 往单元格里面写入值
			cell.setCellValue("驾驶证号"); // 头部
			cell.setCellStyle(style);
			cell = row.createCell(10);
			// 往单元格里面写入值
			cell.setCellValue("驾驶证初领日期"); // 头部
			cell.setCellStyle(style);
			cell = row.createCell(11);
			// 往单元格里面写入值
			cell.setCellValue("原准驾车型"); // 头部
			cell.setCellStyle(style);
			cell = row.createCell(12);
			// 往单元格里面写入值
			cell.setCellValue("证件类型"); // 头部
			cell.setCellStyle(style);
			cell = row.createCell(13);
			// 往单元格里面写入值
			cell.setCellValue("联系地址"); // 联系地址
			cell.setCellStyle(style);
			cell = row.createCell(14);
			// 往单元格里面写入值
			cell.setCellValue("培训车型"); // 联系地址
			cell.setCellStyle(style);
			cell = row.createCell(15);
			// 往单元格里面写入值
			cell.setCellValue("报名时间"); // 头部
			cell.setCellStyle(style);
			for (int i = 0; i < exportlist.size(); i++) { // 循环导出数据
				Student stu = exportlist.get(i);
				// 第四步，创建单元格，并设置值
				// if (string.getId() == stu.getStationId()) {
				row = sheet.createRow((int) exportRow);
				// 身份证号码
				if (stu.getStationName() != null) {
					row.createCell((short) 0).setCellValue(stu.getStationName());
				} else {
					row.createCell((short) 0).setCellValue(" ");
				}
				// 身份证号码
				if (stu.getIdcard() != null) {
					row.createCell((short) 1).setCellValue(stu.getIdcard());
				} else {
					row.createCell((short) 1).setCellValue(" ");
				}
				// 姓名
				if (stu.getName() != null) {
					row.createCell((short) 2).setCellValue(stu.getName());
				} else {
					row.createCell((short) 2).setCellValue(" ");
				}

				// 性别
				if (stu.getSex() != null) {
					if (stu.getSex() == 1) {
						row.createCell((short) 3).setCellValue("男");
					} else if (stu.getSex() == 2) {
						row.createCell((short) 3).setCellValue("女");
					}
				} else {
					row.createCell((short) 3).setCellValue(" ");
				}

				// 电话
				if (stu.getMobile() != null) {
					row.createCell((short) 4).setCellValue(stu.getMobile());
				} else {
					row.createCell((short) 4).setCellValue(" ");
				}
				
				// 班型
				if (stu.getClassTypeName() != null) {
					row.createCell((short) 5).setCellValue(stu.getClassTypeName());
				} else {
					row.createCell((short) 5).setCellValue(" ");
				}
				// 报名时间
				if (stu.getApplydate() != null) {
					row.createCell((short) 15).setCellValue(new SimpleDateFormat("yyyy年MM月dd日").format(stu.getApplydate()));
				} else {
					row.createCell((short) 15).setCellValue(" ");
				}
				row.createCell((short) 6).setCellValue("中国");
				row.createCell((short) 7).setCellValue(stu.getStunum());	//学员编号
				row.createCell((short) 8).setCellValue(insCode);		//机构编号
				row.createCell((short) 9).setCellValue(" ");	//驾驶证号
				row.createCell((short) 10).setCellValue(" ");		//驾驶证初领日期
				row.createCell((short) 11).setCellValue(" ");	//原准驾车型
				row.createCell((short) 12).setCellValue(stu.getCradtype());	//证件类型
				row.createCell((short) 13).setCellValue(stu.getAddress());	//联系地址
				row.createCell((short) 14).setCellValue(stu.getTraintype());	//联系地址
				exportRow++;
			}
			// }
			// }
			// 第六步，将文件存到指定位置

			OutputStream out = response.getOutputStream();
			wb.write(out);
			out.flush();
			out.close();
		} catch (Exception e) {

			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 学员信息 名称的模糊搜索
	 */
	@RequestMapping(value = "/getCoachlist", method = RequestMethod.GET)
	public Result getCoachQuery(@RequestParam(value = "insId", required = true) Integer insId,
			@RequestParam(value = "searchText", required = false) String searchText, HttpServletRequest request) {
		Result result = new Result();
		Integer coachId = WebUtils.getParameterIntegerValue(request, "coachId");
		/* WebUtils.getParameterIntegerValue(request, "coachOrStu"); */
		try {
			List<Student> list = null;
			list = studentService.getCoachStudent(coachId, searchText);
			result.success(list);
		} catch (Exception e) {
			logger.error("Student field list", e);
			result.error(e);
		}
		return result;
	}

	@RequestMapping(value = "/updatestatus", method = RequestMethod.POST)
	public Result updatestatus(HttpServletRequest request) {
		Result result = new Result();
		String recordnum = WebUtils.getParameterValue(request, "recordnum");
		Integer studentid = WebUtils.getParameterIntegerValue(request, "studentid");
		Integer coachId = WebUtils.getParameterIntegerValue(request, "coachId");
		Integer status = WebUtils.getParameterIntegerValue(request, "status");
		Integer insId = WebUtils.getParameterIntegerValue(request, "insId");
		Integer score = WebUtils.getParameterIntegerValue(request, "score");
		String drilicnum = WebUtils.getParameterValue(request, "drilicnum");
		String organno = WebUtils.getParameterValue(request, "organno");
		String certificateno = WebUtils.getParameterValue(request, "certificateno");
		String documenturl = WebUtils.getParameterValue(request, "documenturl");
		String signatureurl = WebUtils.getParameterValue(request, "signatureurl");
		System.out.println("-"+documenturl+"--"+signatureurl+"--"+organno+"--"+certificateno+"--"+score+"--"+drilicnum+"----------------");
		try{
			studentService.updateStudentStatus(insId, studentid, status, coachId, recordnum, score, drilicnum, organno, certificateno,documenturl,signatureurl);
			result.success();
		}catch (Exception e) {
			logger.error("Student field list", e);
			result.error(e);
		}
		
		return result;
	}
	/**
	 * 按ID查找学员
	 * 
	 * @param id
	 *       
	 * @return
	 */
	@RequestMapping(value = "/getByStudent", method = RequestMethod.GET)
	public Result getByStudent(Integer insId,Integer id, HttpServletRequest request) {
		Assert.notNull(id, "id is null");
		Result result = new Result();
		try {
			Student student = studentService.getByStudent(insId, id);
			result.success(student);
		} catch (Throwable ex) {
			logger.error("student field get ", ex);
		}
		return result;
	}
	
	
	@RequestMapping(value = "/updateisProvince", method = RequestMethod.POST)
	public Result updateisProvince(HttpServletRequest request) {
		Result result = new Result();
		Student student =  new Student();
		Integer id = WebUtils.getParameterIntegerValue(request, "id");
		Integer isProvince = WebUtils.getParameterIntegerValue(request, "isProvince");
		System.out.println(id+"\t"+isProvince);
		try{
			student.setId(id);
			student.setIsProvince(isProvince);
			studentService.updateisProvince(student);
			result.success();
		}catch (Exception e) {
			logger.error("Student field list", e);
			result.error(e);
		}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public Result deletes(Integer id){
		Result result = new Result();
		try {
			if(id!=null){
				Integer  stu = studentService.delete(id);
			}
			result.success();
		} catch (Exception e) {
			logger.error("TrainingCar findOne",e);
			result.error(e);
		}
		return result;
	}
	
	
	@ResponseBody
	@RequestMapping(value="/stunum",method=RequestMethod.GET)
	public Result stunum(String stunum){
		Result result = new Result();
		try {
			Assert.notNull(stunum, "stunum不能为空");
			Integer count=studentService.getStunum(stunum);
			result.success(count);
		} catch (Exception e) {
			logger.error("TrainingCar findOne",e);
			result.error(e);
		}
		return result;
	}
	
	/**
	 * 获取教练的学员
	 * @param coachId
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/getCoachStudents", method = RequestMethod.GET)
	public Result getCoachStudents(int coachId){
		Result result = new Result();
		
		Coach coach = coachService.get(coachId);
		UsinInfo usinInfo = (UsinInfo)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		boolean has_ROLE_SCHOOL_SERVICE = usinInfo.getAuthorities().stream()
				.filter(f -> f.getAuthority().equals("ROLE_SCHOOL_SERVICE"))
				.count() > 0;
		if(coach.getInsId() != usinInfo.getInsId()
				|| (has_ROLE_SCHOOL_SERVICE && coach.getStationId() != usinInfo.getStationId())){
			result.error(705,"没有权限");
			return result;
		}
		
		result.success(studentService.getCoachStudent(coachId));
		return result;
	}
}
