package com.bjxc.school.controller;

import java.io.File;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.bjxc.Result;
import com.bjxc.school.Coach;
import com.bjxc.school.Device;
import com.bjxc.school.Examiner;
import com.bjxc.school.InstitutionInfo;
import com.bjxc.school.Security;
import com.bjxc.school.Student;
import com.bjxc.school.StudentSubject;
import com.bjxc.school.TrainingCar;
import com.bjxc.school.service.CoachService;
import com.bjxc.school.service.DeviceService;
import com.bjxc.school.service.ExaminerService;
import com.bjxc.school.service.InstitutionInfoService;
import com.bjxc.school.service.SecurityService;
import com.bjxc.school.service.StudentService;
import com.bjxc.school.service.StudentSubjectService;
import com.bjxc.school.service.TrainingCarService;
import com.bjxc.school.utils.ReaderExcelUtils;

/**
 * excel表格的数据录入
 * 
 * @author hjr
 *
 */

@Controller
public class InsertExcelDatasController {
	private static final Logger logger = LoggerFactory.getLogger(InsertExcelDatasController.class);

	private ReaderExcelUtils reu = new ReaderExcelUtils();

	@Resource
	private InstitutionInfoService institutionService;
	@Resource
	private CoachService coachService;
	@Resource
	private ExaminerService examinerService;
	@Resource
	private SecurityService securityService;
	@Resource
	private TrainingCarService trainingCarService;
	@Resource
	private DeviceService deviceService;
	@Resource
	private StudentService studentService;
	@Resource
	private StudentSubjectService studentSubjectService;
	
	private String insCode610=null;
	
	/**
	 * 读取Excel文件,将数据存入数据库
	 * 
	 * @param data
	 *            数据
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "static-access" })
	@ResponseBody
	@RequestMapping(value = "/insertsevensheetsdatas")
	@UserControllerLog(description = "读取Excel文件,将数据存入数据库")
	public Result InsertToDataBase(HttpServletRequest request) throws Exception {
		Result result = new Result();
		Date date = new Date();
		long time = date.getTime();
		try {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			MultipartFile file = multipartRequest.getFile("upfile");
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
				//是否有错误
				int number = 0;
				// sheet名数组下标
				int sheetIndex = 0;
				/**
				 * 培训机构
				 */
				int[] count = new int[nameStrs.length];
				it = dataListMap.iterator();// 遍历
				while (it.hasNext()) {// 完整
					Map oneMap = (Map) it.next();
					Object map = oneMap.get("sheetName" + nameStrs[sheetIndex]);
					if (map == null) {
						continue;
					} else {
						count[sheetIndex]++;

						InstitutionInfo institution = new InstitutionInfo();
						institution.setDistrict(oneMap.get("区县行政区划代码").toString().trim());//区县行政区划代码
						institution.setName(oneMap.get("培训机构名称").toString());// 培训机构名称
						institution.setShortName(oneMap.get("培训机构简称").toString());// 培训机构简称
						institution.setLicnum(oneMap.get("经营许可证编号").toString().trim());// 经营许可证编号
						institution.setLicetime(oneMap.get("经营许可日期").toString());// 经营许可日期
						institution.setBusiness(oneMap.get("营业执照注册号").toString().trim());// 营业执照注册号
						institution.setCreditcode(oneMap.get("统一社会信用代码").toString().trim());// 统一社会信用代码
						institution.setAddress(oneMap.get("培训机构地址").toString());// 培训机构地址
						institution.setLegal(oneMap.get("法人代表").toString());// 法人代表
						institution.setContact(oneMap.get("联系人").toString());// 联系人
						institution.setPhone(oneMap.get("联系电话").toString().trim());// 联系电话
						institution.setInscode(oneMap.get("培训机构编号").toString().trim());// 培训机构编号
						Integer coachNumberEx=StringUtils.isNotEmpty(oneMap.get("教练员总数").toString().trim())?
								Integer.valueOf(oneMap.get("教练员总数").toString().trim()):null;
						institution.setCoachnumber(coachNumberEx);// 教练员总数
						institution.setBusiscope(oneMap.get("经营范围").toString());//经营范围
						institution.setBusistatus(oneMap.get("经营状态").toString());//经营状态
						Integer levelEx = StringUtils.isNotEmpty(oneMap.get("分类等级").toString().trim())
								? Integer.parseInt(oneMap.get("分类等级").toString().trim()) : null;
						institution.setLevel(levelEx);
						Integer grasupvnumEx =StringUtils.isNotEmpty( oneMap.get("考核员总数").toString().trim() )
								? Integer.parseInt(oneMap.get("考核员总数").toString().trim()) : null;
						institution.setGrasupvnum(grasupvnumEx);
						Integer safmngnumEx = StringUtils.isNotEmpty(oneMap.get("安全员总数").toString().trim() )
								? Integer.parseInt(oneMap.get("安全员总数").toString().trim()) : null;
						institution.setSafmngnum(safmngnumEx);
						Integer tracarnumEx = StringUtils.isNotEmpty(oneMap.get("教练车总数").toString().trim() )
								? Integer.parseInt(oneMap.get("教练车总数").toString().trim()) : null;
						institution.setTracarnum(tracarnumEx);
						Integer classroomEx = StringUtils.isNotEmpty(oneMap.get("教室总面积").toString().trim())
								? Integer.parseInt(oneMap.get("教室总面积").toString().trim()) : null;
						institution.setClassroom(classroomEx);
						Integer thclassroomEx =StringUtils.isNotEmpty( oneMap.get("理论教室面积").toString().trim() )
								? Integer.parseInt(oneMap.get("理论教室面积").toString().trim()) : null;
						institution.setThclassroom(thclassroomEx);
						Integer praticefieldEx = StringUtils.isNotEmpty(oneMap.get("教练场总面积").toString().trim() )
								? Integer.parseInt(oneMap.get("教练场总面积").toString().trim()) : null;
						institution.setPraticefield(praticefieldEx);
						institution.setPostcode(oneMap.get("邮政编码").toString().trim());
						try {
							institutionService.addByExcel(institution);
						} catch (Exception e) {
							logger.error(e.getMessage());
							result.error("");
							number++;
						}
						
						it.remove();
						if (count[sheetIndex] == Integer
								.parseInt(oneMap.get(nameStrs[sheetIndex] + "SheetNumber").toString())) {
							sheetIndex++;
							break;
						}
					}
				}

				/**
				 * 教练员
				 */
				it = dataListMap.iterator();
				while (it.hasNext()) {// 完整
					Map oneMap = (Map) it.next();
					if (oneMap.get("sheetName" + nameStrs[sheetIndex]) == null) {
						continue;
					} else {
						count[sheetIndex]++;
						// 字符串中的日期格式
						DateFormat to_type = new SimpleDateFormat("yyyyMMdd");

						Coach coach = new Coach();
						String insIdEx = StringUtils.isNotEmpty(oneMap.get("培训机构编号").toString().trim() ) ? oneMap.get("培训机构编号").toString() : null;
						Integer insId = institutionService.getInsId(insIdEx);// 得到对应的培训机构id
						coach.setInsId(insId);
						coach.setCoachnum(oneMap.get("教练员编号").toString());
						coach.setName(oneMap.get("姓名").toString());
						// 性别(空值就设置为 男 )
						Integer sexEx =StringUtils.isNotEmpty( oneMap.get("性别").toString().trim() )
								? Integer.parseInt(oneMap.get("性别").toString().trim()) : 1;
						coach.setSex(sexEx);
						coach.setIdcard(oneMap.get("身份证号").toString());
						coach.setMobile(oneMap.get("手机号码").toString());
						coach.setAddress(oneMap.get("联系地址").toString());
						Integer photoIdEx = StringUtils.isNotEmpty(oneMap.get("照片文件ID").toString().trim() )
								? Integer.parseInt(oneMap.get("照片文件ID").toString().trim()) : null;
						coach.setPhotoId(photoIdEx);
						Integer fingerPrintIdEx =StringUtils.isNotEmpty( oneMap.get("指纹图片ID").toString().trim() )
								? Integer.parseInt(oneMap.get("指纹图片ID").toString().trim()) : null;
						coach.setFingerprintId(fingerPrintIdEx);
						coach.setDrilicence(oneMap.get("驾驶证号").toString());
						Date receiveTimeEx = StringUtils.isNotEmpty(oneMap.get("驾驶证初领日期").toString().trim() )
								? to_type.parse(oneMap.get("驾驶证初领日期").toString()) : null;
						coach.setReceiveTime(receiveTimeEx);
						coach.setOccupationno(oneMap.get("职业资格证号").toString());
						Integer occLevelEx = StringUtils.isNotEmpty(oneMap.get("职业资格等级").toString().trim() )
								? Integer.parseInt(oneMap.get("职业资格等级").toString().trim()) : null;
						coach.setOccupationlevel(occLevelEx);
						coach.setDripermitted(oneMap.get("准驾车型").toString());
						coach.setTeachpermitted(oneMap.get("准教车型").toString());
						Integer employStaEx =StringUtils.isNotEmpty( oneMap.get("供职状态").toString().trim() )
								? Integer.parseInt(oneMap.get("供职状态").toString().trim()) : null;
						coach.setEmploystatus(employStaEx);
						Date hireDateEx =StringUtils.isNotEmpty( oneMap.get("入职时间").toString().trim() )
								? to_type.parse(oneMap.get("入职时间").toString().trim()) : null;
						coach.setHiredate(hireDateEx);
						Date leaveDateEx = StringUtils.isNotEmpty(oneMap.get("离职时间").toString().trim() )
								? to_type.parse(oneMap.get("离职时间").toString().trim()) : null;
						coach.setLeavedate(leaveDateEx);
						
						try{
							coachService.addByExcel(coach);
						} catch (Exception e) {
							logger.error(e.getMessage());
							result.error("");
							number++;
						}
						it.remove();

						if (count[sheetIndex] == Integer
								.parseInt(oneMap.get(nameStrs[sheetIndex] + "SheetNumber").toString())) {
							sheetIndex++;
							break;
						}
					}
				}

				/**
				 * 考核员
				 */
				it = dataListMap.iterator();
				while (it.hasNext()) {//完整
					Map oneMap = (Map) it.next();
					if (oneMap.get("sheetName" + nameStrs[sheetIndex]) == null) {
						continue;
					} else {
						count[sheetIndex]++;
						// 字符串中的日期格式
						DateFormat to_type = new SimpleDateFormat("yyyyMMdd");

						Examiner examiner = new Examiner();
						String insIdEx = StringUtils.isNotEmpty(oneMap.get("培训机构编号").toString().trim() ) ? oneMap.get("培训机构编号").toString() : null;
						Integer insId = institutionService.getInsId(insIdEx);
						examiner.setInsId(insId);
						examiner.setName(oneMap.get("姓名").toString());
						Integer sexEx = StringUtils.isNotEmpty(oneMap.get("性别").toString().trim() )
								? Integer.parseInt(oneMap.get("性别").toString().trim()) : 1;
						examiner.setSex(sexEx);
						examiner.setIdcard(oneMap.get("身份证号").toString());
						examiner.setMobile(oneMap.get("手机号码").toString());
						examiner.setAddress(oneMap.get("联系地址").toString());
						examiner.setDrilicence(oneMap.get("驾驶证号").toString());
						examiner.setFstdrilicdate(oneMap.get("驾驶证初领日期").toString());
						examiner.setDripermitted(oneMap.get("准驾车型").toString());
						examiner.setTeachpermitted(oneMap.get("准教车型").toString());
						Integer employStatusEx = StringUtils.isNotEmpty(oneMap.get("供职状态").toString().trim() )
								? Integer.parseInt(oneMap.get("供职状态").toString().trim()) : null;
						examiner.setEmploystatus(employStatusEx);
						Date hireDateEx = StringUtils.isNotEmpty(oneMap.get("入职时间").toString().trim() )
								? to_type.parse(oneMap.get("入职时间").toString().trim()) : null;
						examiner.setHiredate(hireDateEx);
						Date leaveDateEx =StringUtils.isNotEmpty( oneMap.get("离职时间").toString().trim() )
								? to_type.parse(oneMap.get("离职时间").toString().trim()) : null;
						examiner.setLeavedate(leaveDateEx);
						examiner.setOccupationno(oneMap.get("职业资格证号").toString());
						examiner.setOccupationlevel(oneMap.get("职业资格等级").toString());
						examiner.setExamnum(oneMap.get("考核员编号").toString().trim());
						Integer photoEx = StringUtils.isNotEmpty(oneMap.get("照片文件ID").toString().trim() )
								? Integer.parseInt(oneMap.get("照片文件ID").toString().trim()) : null;
						examiner.setPhoto(photoEx);
						Integer fingerPrintEx = StringUtils.isNotEmpty(oneMap.get("指纹图片ID").toString().trim() )
								? Integer.parseInt(oneMap.get("指纹图片ID").toString().trim()) : null;
						examiner.setFingerprint(fingerPrintEx);

						try {
							examinerService.addByExcel(examiner);
						} catch (Exception e) {
							result.error("");
							number++;
							if(("本驾校已存在身份证号为 " + examiner.getIdcard() + " 的考核员").equals(e.getMessage())){
								logger.error(e.getMessage());
								result.error("");
							}else{
								logger.error(e.getMessage());
								result.error("");
							}
						}
						it.remove();
						if (count[sheetIndex] == Integer
								.parseInt(oneMap.get(nameStrs[sheetIndex] + "SheetNumber").toString())) {
							sheetIndex++;
							break;
						}
					}
				}

				/**
				 * 安全员
				 */

				it = dataListMap.iterator();
				while (it.hasNext()) {//完整
					Map oneMap = (Map) it.next();
					if (oneMap.get("sheetName" + nameStrs[sheetIndex]) == null) {
						continue;
					} else {
						count[sheetIndex]++; // 字符串中的日期格式
						DateFormat to_type = new SimpleDateFormat("yyyyMMdd");

						Security security = new Security();
						String insIdEx = StringUtils.isNotEmpty(oneMap.get("培训机构编号").toString().trim()) ? oneMap.get("培训机构编号").toString() : null;
						Integer insId = institutionService.getInsId(insIdEx);// 得到对应的培训机构id
						security.setInsId(insId);
						security.setName(oneMap.get("姓名").toString().trim());
						// 性别(空值就设置为 男 )
						Integer sexEx =StringUtils.isNotEmpty( oneMap.get("性别").toString().trim() )
								? Integer.parseInt(oneMap.get("性别").toString().trim()) : 1;
						security.setSex(sexEx);
						security.setIdcard(oneMap.get("身份证号").toString());
						security.setMobile(oneMap.get("手机号码").toString());
						Integer photoEx =StringUtils.isNotEmpty( oneMap.get("照片文件ID").toString().trim() )
								? Integer.parseInt(oneMap.get("照片文件ID").toString().trim()) : null;
						security.setPhoto(photoEx);
						Integer fingerprintEx = StringUtils.isNotEmpty(oneMap.get("指纹图片ID").toString().trim() )
								? Integer.parseInt(oneMap.get("指纹图片ID").toString().trim()) : null;
						security.setFingerprint(fingerprintEx);
						security.setAddress(oneMap.get("联系地址").toString());
						security.setDrilicence(oneMap.get("驾驶证号").toString());
						security.setFstdrilicdate(oneMap.get("驾驶证初领日期").toString());
						security.setDripermitted(oneMap.get("准驾车型").toString());
						security.setTeachpermitted(oneMap.get("准教车型").toString());
						Integer employStatusEx = StringUtils.isNotEmpty(oneMap.get("供职状态").toString().trim() )
								? Integer.parseInt(oneMap.get("供职状态").toString().trim()) : null;
						security.setEmploystatus(employStatusEx);
						Date hireDateEx = StringUtils.isNotEmpty(oneMap.get("入职时间").toString().trim() )
								? to_type.parse(oneMap.get("入职时间").toString().trim()) : null;
						security.setHiredate(hireDateEx);
						Date leaveDateEx =StringUtils.isNotEmpty( oneMap.get("离职时间").toString().trim() )
								? to_type.parse(oneMap.get("离职时间").toString().trim()) : null;
						security.setLeavedate(leaveDateEx);
						security.setSecunum(oneMap.get("安全员编号").toString());

						try {
							securityService.addByExcel(security);
						} catch (Exception e) {
							result.error("");
							number++;
							if(("本驾校已存在身份证号为 " + security.getIdcard() + " 的安全员").equals(e.getMessage())){
								logger.error(e.getMessage());
								result.error("");
							}else{
								logger.error(e.getMessage());
								result.error("");
							}
						}
						it.remove();
						if (count[sheetIndex] == Integer
								.parseInt(oneMap.get(nameStrs[sheetIndex] + "SheetNumber").toString())) {
							sheetIndex++;
							break;
						}
					}
				}

				/**
				 * 教练车
				 */

				it = dataListMap.iterator();
				while (it.hasNext()) {
					Map oneMap = (Map) it.next();
					if (oneMap.get("sheetName" + nameStrs[sheetIndex]) == null) {
						continue;
					} else {
						count[sheetIndex]++; // 字符串中的日期格式
						DateFormat to_type = new SimpleDateFormat("yyyyMMdd");

						TrainingCar trainingCar = new TrainingCar();
						String insIdEx = StringUtils.isNotEmpty(oneMap.get("培训机构编号").toString().trim() ) ? oneMap.get("培训机构编号").toString() : null;
						trainingCar.setInscode(insIdEx);
						Integer insId = institutionService.getInsId(insIdEx);// 得到对应的培训机构id
						trainingCar.setInsId(insId);
						trainingCar.setFranum(oneMap.get("车架号").toString());
						trainingCar.setEngnum(oneMap.get("发动机号").toString());
						trainingCar.setLicnum(oneMap.get("车辆牌号").toString());
						Integer plateColorEx =StringUtils.isNotEmpty( oneMap.get("车牌颜色").toString().trim() )
								? Integer.parseInt(oneMap.get("车牌颜色").toString().trim()) : null;
						trainingCar.setPlatecolor(plateColorEx);
						Integer photoEx = StringUtils.isNotEmpty(oneMap.get("照片文件ID").toString().trim() )
								? Integer.parseInt(oneMap.get("照片文件ID").toString().trim()) : null;
						trainingCar.setPhoto(photoEx);
						trainingCar.setManufacture(oneMap.get("生产厂家").toString());
						trainingCar.setBrand(oneMap.get("车辆品牌").toString());
						trainingCar.setModel(oneMap.get("车辆型号").toString());
						trainingCar.setPerdritype(oneMap.get("培训车型").toString());
						Date buyDateEx = StringUtils.isNotEmpty(oneMap.get("购买日期").toString().trim() )
								? to_type.parse(oneMap.get("购买日期").toString().trim()) : null;
						trainingCar.setBuydate(buyDateEx);
						trainingCar.setCarnum(oneMap.get("教练车编号").toString());
						
						try {
							trainingCarService.addByExcel(trainingCar);
						} catch (Exception e) {
							result.error("");
							number++;
							if(("本驾校已存在车牌号为 " + trainingCar.getLicnum() + " 的教练车").equals(e.getMessage())){
								logger.error(e.getMessage());
								result.error("");
							}else{
								logger.error(e.getMessage());
								result.error("");
							}
						}
						it.remove();
						if (count[sheetIndex] == Integer
								.parseInt(oneMap.get(nameStrs[sheetIndex] + "SheetNumber").toString())) {
							sheetIndex++;
							break;
						}
					}
				}

				/**
				 * 计时终端
				 */
				it = dataListMap.iterator();
				while (it.hasNext()) {//// 完整
					Map oneMap = (Map) it.next();
					if (oneMap.get("sheetName" + nameStrs[sheetIndex]) == null) {
						continue;
					} else {
						count[sheetIndex]++;
						Device device = new Device();
						Integer termTypeEx=StringUtils.isNotEmpty(oneMap.get("计时终端类型").toString().trim())?
								Integer.parseInt(oneMap.get("计时终端类型").toString().trim()):null;
						device.setTermtype(termTypeEx);
						device.setVender(oneMap.get("生产厂家").toString());
						device.setModel(oneMap.get("终端型号").toString());
						device.setImei(oneMap.get("终端IMEI号或设备MAC地址").toString());
						device.setSn(oneMap.get("终端出厂序列号").toString());
						device.setDevnum(oneMap.get("终端编号").toString());
						String insIdEx = StringUtils.isNotEmpty(oneMap.get("培训机构编号").toString().trim() ) ? oneMap.get("培训机构编号").toString() : null;
						Integer insId = institutionService.getInsId(insIdEx);// 得到对应的培训机构id
						device.setInsId(insId);
						device.setPasswd(oneMap.get("终端证书口令").toString().trim());
						device.setKey(oneMap.get("终端证书").toString().trim());
						try{
							deviceService.addByExcel(device);
						} catch (Exception e) {
							logger.error(e.getMessage());
							result.error("");
							number++;
						}
						it.remove();
						if (count[sheetIndex] == Integer.parseInt(oneMap.get(nameStrs[sheetIndex] + "SheetNumber").toString())) {
							sheetIndex++;
							break;
						}
					}
				}

				/**
				 * 学员
				 */

				it = dataListMap.iterator();
				while (it.hasNext()) {
					Map oneMap = (Map) it.next();
					if (oneMap.get("sheetName" + nameStrs[sheetIndex]) == null) {
						continue;
					} else {
						count[sheetIndex]++;
						DateFormat to_type = new SimpleDateFormat("yyyyMMdd");// 字符串中的日期格式

						Student student = new Student();
						String insIdEx =StringUtils.isNotEmpty( oneMap.get("培训机构编号").toString().trim() ) ? oneMap.get("培训机构编号").toString() : null;
						Integer insId = institutionService.getInsId(insIdEx);// 得到对应的培训机构id
						student.setInsId(insId);
						Integer stationIdEx = StringUtils.isNotEmpty(oneMap.get("培训网点").toString().trim() )
								? Integer.parseInt(oneMap.get("培训网点").toString().trim()) : 0;
						student.setStationId(stationIdEx);// 培训网点
						Integer tuitionEx = StringUtils.isNotEmpty(oneMap.get("应交学费").toString().trim() )
								? Integer.parseInt(oneMap.get("应交学费").toString().trim()) : 0;
						student.setTuition(tuitionEx*10000);// 应交学费
						Integer alreadyPayEx = StringUtils.isNotEmpty(oneMap.get("已交学费").toString().trim() )
								? Integer.parseInt(oneMap.get("已交学费").toString().trim()) : 0;
						student.setAlreadyPay(alreadyPayEx*10000);// 已交学费
						Integer arrearageEx =StringUtils.isNotEmpty( oneMap.get("还欠学费").toString().trim() )
								? Integer.parseInt(oneMap.get("还欠学费").toString().trim()) : 0;
						student.setArrearage(arrearageEx*10000);// 还欠学费
						student.setStunum(oneMap.get("学员编号").toString().trim());
						student.setName(oneMap.get("姓名").toString());
						student.setMobile(oneMap.get("手机号码").toString());
						Integer cradTypeEx = StringUtils.isNotEmpty(oneMap.get("证件类型").toString().trim() )
								? Integer.parseInt(oneMap.get("证件类型").toString().trim()) : null;
						student.setCradtype(cradTypeEx);
						student.setIdcard(oneMap.get("证件号").toString());
						student.setNationality(oneMap.get("国籍").toString());
						Integer sexEx = StringUtils.isNotEmpty(oneMap.get("性别").toString().trim() )
								? Integer.parseInt(oneMap.get("性别").toString().trim()) : null;
						student.setSex(sexEx);
						student.setAddress(oneMap.get("联系地址").toString());
						Integer busiTypeEx =StringUtils.isNotEmpty( oneMap.get("业务类型").toString().trim() )
								? Integer.parseInt(oneMap.get("业务类型").toString().trim()) : null;
						student.setBusitype(busiTypeEx);
						student.setDrilicnum(oneMap.get("驾驶证号").toString());
						Date fstdriDateEx = StringUtils.isNotEmpty(oneMap.get("驾驶证初领日期").toString().trim() )
								? to_type.parse(oneMap.get("驾驶证初领日期").toString().trim()) : null;
						student.setFstdrilicdate(fstdriDateEx);
						student.setPerdritype(oneMap.get("原准驾车型").toString());
						student.setTraintype(oneMap.get("培训车型").toString());
						Date applyDateEx = StringUtils.isNotEmpty(oneMap.get("报名时间").toString().trim() )
								? to_type.parse(oneMap.get("报名时间").toString().trim()) : null;
						student.setApplydate(applyDateEx);
						Integer photoIdEx = StringUtils.isNotEmpty(oneMap.get("照片文件ID").toString().trim() )
								? Integer.parseInt(oneMap.get("照片文件ID").toString().trim()) : null;
						student.setPhotoId(photoIdEx);
						Integer fingerprintsIdEx = StringUtils.isNotEmpty(oneMap.get("指纹图片ID").toString().trim() )
								? Integer.parseInt(oneMap.get("指纹图片ID").toString().trim()) : null;
						student.setFingerprintsId(fingerprintsIdEx);
								
						try {
							studentService.addByExcel(student);
							StudentSubject studentSubject=new StudentSubject();
							 studentSubject.setStudentId(student.getId());
							studentSubjectService.addSubject(studentSubject);
						} catch (Exception e) {
							logger.error(e.getMessage());
							result.error("");
							number++;
							if(("本驾校已存在证件号为 " + student.getIdcard() + " 的学员").equals(e.getMessage())){
								logger.error(e.getMessage());
								result.error("");
							}else{
								logger.error(e.getMessage());
								result.error("");
							}
						}
						it.remove();
						if (count[sheetIndex] == Integer
								.parseInt(oneMap.get(nameStrs[sheetIndex] + "SheetNumber").toString())) {
							sheetIndex++;
							break;
						}
					}
				}

				if (number == 0) {
					result.success();
					System.out.println("全部插入数据库");
				}else{
					result.error(number+"");
					System.out.println("数据中有错误");
				}				
			} catch (Exception e) {
				logger.error("InsertExcelDatasController field list", e);
				result.error(e);
			}
			Date date2 = new Date();
			long time2 = date2.getTime();
			long longs = time2 - time;
			System.out.println(longs);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
		@RequestMapping(value = "/exportdatas580")
		@UserControllerLog(description = "exportdatas580")
	public void exportDatas(Integer insId,Integer stationId,String insCode,
			HttpServletRequest request,HttpServletResponse response) throws Exception {
		if(stationId!=null){
			if(stationId==-1){
				stationId=null;
			}
		}
		
		response.setCharacterEncoding("UTF-8");
		String fileName = "基础数据";
		fileName = new String(fileName.getBytes("GBK"), "ISO8859_1");
		response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ".xls");

		response.setDateHeader("Expires", 0);
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Pragma", "no-cache");
		
		
		try {
			HSSFWorkbook wb = new HSSFWorkbook();
			exportInstitution(wb,insId);
			exportCoach(wb,insId,stationId);
			exportExaminer(wb,insId);
			exportSecurity(wb,insId);
			exportTrainingCar(wb, insCode);
			exportDevice(wb, insCode);
			exportStudent(wb, insId, stationId, insCode);
			
			OutputStream out = response.getOutputStream();
			wb.write(out);
			out.flush();  
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 培训机构
	 */
	private void exportInstitution(HSSFWorkbook wb,Integer insId){
		try {
			HSSFSheet sheet=null;
			HSSFFont f = wb.createFont();
			int exportRow = 1;
			List<InstitutionInfo> list=institutionService.getAll();
			sheet = wb.createSheet("培训机构信息");
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
			sheet.setColumnWidth(7, 4500);
			sheet.setColumnWidth(8, 4500);
			sheet.setColumnWidth(9, 4500);
			
			f.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);// 粗体显示
			style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
			sheet.autoSizeColumn(1, true);
			// row.setHeightInPoints(30); //设置行高
			style.setFont(f);
			sheet.autoSizeColumn(1);
			int count=0;
			// 获取第一行的每一个单元格
			
			cell = row.createCell(count++);
			cell.setCellValue("培训机构编号"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("区县行政区划代码"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("培训机构名称"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("培训机构简称"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("经营许可证编号"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("经营许可日期"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("营业执照注册号"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("统一社会信用代码"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("培训机构地址"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("邮政编码"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("法人代表"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("联系人"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("联系电话"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("经营范围"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("经营状态"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("分类等级"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("教练员总数"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("考核员总数"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("安全员总数"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("教练车总数"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("教室总面积"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("理论教室面积"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("教练场总面积"); 
			cell.setCellStyle(style);

			for (int i = 0; i < list.size(); i++) {
				InstitutionInfo ins=list.get(i);
				if(ins.getId()==insId){
					insCode610=ins.getInscode()==null?" ":ins.getInscode();
				}
				
				row = sheet.createRow((int) exportRow);
				count=0;
				row.createCell(count++).setCellValue(ins.getInscode()==null?" ":ins.getInscode());
				row.createCell(count++).setCellValue(ins.getDistrict()==null?" ":ins.getDistrict());
				row.createCell(count++).setCellValue(ins.getName()==null?" ":ins.getName());
				row.createCell(count++).setCellValue(ins.getShortName()==null?" ":ins.getShortName());
				row.createCell(count++).setCellValue(ins.getLicnum()==null?" ":ins.getLicnum());
				row.createCell(count++).setCellValue(ins.getLicetime()==null?" ":ins.getLicetime());
				row.createCell(count++).setCellValue(ins.getBusiness()==null?" ":ins.getBusiness());
				row.createCell(count++).setCellValue(ins.getCreditcode()==null?" ":ins.getCreditcode());
				row.createCell(count++).setCellValue(ins.getAddress()==null?" ":ins.getAddress());
				row.createCell(count++).setCellValue(ins.getPostcode()==null?" ":ins.getPostcode());
				row.createCell(count++).setCellValue(ins.getLegal()==null?" ":ins.getLegal());
				row.createCell(count++).setCellValue(ins.getContact()==null?" ":ins.getContact());
				row.createCell(count++).setCellValue(ins.getPhone()==null?" ":ins.getPhone());
				row.createCell(count++).setCellValue(ins.getBusiscope()==null?" ":ins.getBusiscope());
				row.createCell(count++).setCellValue(ins.getBusistatus()==null?" ":ins.getBusistatus());
				row.createCell(count++).setCellValue(ins.getLevel()==null?" ":ins.getLevel()+"");
				row.createCell(count++).setCellValue(ins.getCoachnumber()==null?" ":ins.getCoachnumber()+"");
				row.createCell(count++).setCellValue(ins.getGrasupvnum()==null?" ":ins.getGrasupvnum()+"");
				row.createCell(count++).setCellValue(ins.getSafmngnum()==null?" ":ins.getSafmngnum()+"");
				row.createCell(count++).setCellValue(ins.getTracarnum()==null?" ":ins.getTracarnum()+"");
				row.createCell(count++).setCellValue(ins.getClassroom()==null?" ":ins.getClassroom()+"");
				row.createCell(count++).setCellValue(ins.getThclassroom()==null?" ":ins.getThclassroom()+"");
				row.createCell(count++).setCellValue(ins.getPraticefield()==null?" ":ins.getPraticefield()+"");
				exportRow++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 教练导出
	 * @param wb
	 * @param sheet
	 * @param insId
	 * @param stationId
	 */
	private void exportCoach(HSSFWorkbook wb,Integer insId,Integer stationId){
		try {
			HSSFSheet sheet=null;
			HSSFFont f = wb.createFont();
			
			Map map = new HashMap();
			map.put("insId", insId);
			if(stationId != null && stationId != 0){
				map.put("stationId", stationId);
			}
			
		List<Coach> exportlist = coachService.exportCoachList(map);
			int exportRow = 1;
			 sheet = wb.createSheet("教练信息");
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

			//培训机构编号
			cell = row.createCell(9);
			cell.setCellValue("培训机构编号"); 
			cell.setCellStyle(style);

			//联系地址
			cell = row.createCell(10);
			cell.setCellValue("联系地址"); 
			cell.setCellStyle(style);

			//照片文件ID
			cell = row.createCell(11);
			cell.setCellValue("照片文件ID"); 
			cell.setCellStyle(style);

			//指纹图片ID
			cell = row.createCell(12);
			cell.setCellValue("指纹图片ID"); 
			cell.setCellStyle(style);

			//驾驶证号
			cell = row.createCell(13);
			cell.setCellValue("驾驶证号"); 
			cell.setCellStyle(style);

			//驾驶证初领日期
			cell = row.createCell(14);
			cell.setCellValue("驾驶证初领日期"); 
			cell.setCellStyle(style);

			//职业资格证号
			cell = row.createCell(15);
			cell.setCellValue("职业资格证号"); 
			cell.setCellStyle(style);

			//职业资格等级
			cell = row.createCell(16);
			cell.setCellValue("职业资格等级"); 
			cell.setCellStyle(style);

			//准教车型
			cell = row.createCell(17);
			cell.setCellValue("准教车型"); 
			cell.setCellStyle(style);
			
			for (int i = 0; i < exportlist.size(); i++) { // 循环导出数据
				Coach stu = exportlist.get(i);
				// 第四步，创建单元格，并设置值
				row = sheet.createRow((int) exportRow);				
				
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
					row.createCell((short) 2).setCellValue(stu.getSex());
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
				      cell.setCellValue(new SimpleDateFormat("yyyyMMdd").format(stu  
			                    .getHiredate()));  
				} else {
					row.createCell((short) 7).setCellValue(" ");
				}
					
				// 离职时间
				if (stu.getLeavedate() != null) {
				      cell = row.createCell((short) 8);  
				      cell.setCellValue(new SimpleDateFormat("yyyyMMdd").format(stu  
			                    .getLeavedate()));  
				} else {
					row.createCell((short) 8).setCellValue(" ");
				}
				
				//培训机构编号
				row.createCell(9).setCellValue(insCode610);

				//联系地址
				row.createCell(10).setCellValue(stu.getAddress()==null?" ":stu.getAddress());

				//照片文件ID
				row.createCell(11).setCellValue(stu.getPhotoId()==null?" ":stu.getPhotoId().toString());

				//指纹图片ID
				row.createCell(12).setCellValue(stu.getFingerprintId()==null?" ":stu.getFingerprintId().toString());

				//驾驶证号
				row.createCell(13).setCellValue(stu.getDrilicence()==null?" ":stu.getDrilicence());

				//驾驶证初领日期
				row.createCell(14).setCellValue(stu.getReceiveTime()==null?" ":
					new SimpleDateFormat("yyyyMMdd").format(stu.getReceiveTime()));

				//职业资格证号
				row.createCell(15).setCellValue(stu.getOccupationno()==null?" ":stu.getOccupationno());

				//职业资格等级
				row.createCell(16).setCellValue(stu.getOccupationlevel()==null?" ":stu.getOccupationlevel().toString());

				//准教车型
				row.createCell(17).setCellValue(stu.getTeachpermitted()==null?" ":stu.getTeachpermitted());				
				
				exportRow++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 考核员导出
	 * @param wb
	 * @param insId
	 */
	private void exportExaminer(HSSFWorkbook wb,Integer insId){
		try {
			HSSFSheet sheet=null;
			HSSFFont f = wb.createFont();
			int exportRow = 1;
			List<Examiner> exportlist = examinerService.exceporExaminer(insId);
			sheet = wb.createSheet("考核员信息");
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
			sheet.setColumnWidth(7, 4500);
			f.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);// 粗体显示
			style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
			sheet.autoSizeColumn(1, true);
			// row.setHeightInPoints(30); //设置行高
			style.setFont(f);
			sheet.autoSizeColumn(1);
			// 获取第一行的每一个单元格

			int num=0;
			
			cell = row.createCell(num);
			// 往单元格里面写入值
			cell.setCellValue("姓名"); // 头部
			cell.setCellStyle(style);
			num++;

			cell = row.createCell(num);
			// 往单元格里面写入值
			cell.setCellValue("性别"); // 头部
			cell.setCellStyle(style);
			num++;

			cell = row.createCell(num);
			// 往单元格里面写入值
			cell.setCellValue("手机号码"); // 头部
			cell.setCellStyle(style);
			num++;

			cell = row.createCell(num);
			// 往单元格里面写入值
			cell.setCellValue("身份证号"); // 头部
			cell.setCellStyle(style);
			num++;

			cell = row.createCell(num);
			// 往单元格里面写入值
			cell.setCellValue("供职状态"); // 头部
			cell.setCellStyle(style);
			num++;

			cell = row.createCell(num);
			// 往单元格里面写入值
			cell.setCellValue("入职时间"); // 头部
			cell.setCellStyle(style);
			num++;

			cell = row.createCell(num);
			// 往单元格里面写入值
			cell.setCellValue("离职时间"); // 头部
			cell.setCellStyle(style);
			num++;

			//培训机构编号
			cell = row.createCell(num);
			cell.setCellValue("培训机构编号");
			cell.setCellStyle(style);
			num++;

			//联系地址
			cell = row.createCell(num);
			cell.setCellValue("联系地址");
			cell.setCellStyle(style);
			num++;

			//驾驶证号
			cell = row.createCell(num);
			cell.setCellValue("驾驶证号");
			cell.setCellStyle(style);
			num++;

			//驾驶证初领日期
			cell = row.createCell(num);
			cell.setCellValue("驾驶证初领日期");
			cell.setCellStyle(style);
			num++;

			//准驾车型
			cell = row.createCell(num);
			cell.setCellValue("准驾车型");
			cell.setCellStyle(style);
			num++;

			//准教车型
			cell = row.createCell(num);
			cell.setCellValue("准教车型");
			cell.setCellStyle(style);
			num++;

			//职业资格证号
			cell = row.createCell(num);
			cell.setCellValue("职业资格证号");
			cell.setCellStyle(style);
			num++;

			//职业资格等级
			cell = row.createCell(num);
			cell.setCellValue("职业资格等级");
			cell.setCellStyle(style);
			num++;

			//考核员编号
			cell = row.createCell(num);
			cell.setCellValue("考核员编号");
			cell.setCellStyle(style);
			num++;

			//照片文件ID
			cell = row.createCell(num);
			cell.setCellValue("照片文件ID");
			cell.setCellStyle(style);
			num++;

			//指纹图片ID
			cell = row.createCell(num);
			cell.setCellValue("指纹图片ID");
			cell.setCellStyle(style);	
			
			for (int i = 0; i < exportlist.size(); i++) { // 循环导出数据
				Examiner examiner = exportlist.get(i);
				// 第四步，创建单元格，并设置值
				// if (string.getId() == stu.getStationId()) {
				row = sheet.createRow((int) exportRow);
				int count=0;

				// 姓名
				if (examiner.getInsId() != null) {
					row.createCell((short) count).setCellValue(examiner.getName());
				} else {
					row.createCell((short) count).setCellValue(" ");
				}
				count++;
				
				// 性别
				if (examiner.getSex() != null) {
					row.createCell((short) count).setCellValue(examiner.getSex());
				} else {
					row.createCell((short) count).setCellValue(" ");
				}
				count++;
				
				// 电话
				if (examiner.getMobile() != null) {
					row.createCell((short) count).setCellValue(examiner.getMobile());
				} else {
					row.createCell((short) count).setCellValue(" ");
				}
				count++;
				
				//身份证号码
				if(examiner.getIdcard()!=null){
					row.createCell((short)count).setCellValue(examiner.getIdcard());
				}else{
					row.createCell((short)count).setCellValue("");
				}
				count++;
				
				//供职状态
				if(examiner.getEmploystatus()!=null){
					row.createCell((short) count).setCellValue(examiner.getEmploystatus());
				}else{
					row.createCell((short) count).setCellValue(" ");
				}
				count++;
				
				//入职日期
				if(examiner.getHiredate()!=null){
					row.createCell((short) count).setCellValue(new SimpleDateFormat("yyyyMMdd").format(examiner.getHiredate()));
				}else{
					row.createCell((short) count).setCellValue(" ");
				}
				count++;

				//离职日期
				if(examiner.getLeavedate()!=null){
					row.createCell((short) count).setCellValue(new SimpleDateFormat("yyyyMMdd").format(examiner.getLeavedate()));
				}else{
					row.createCell((short) count).setCellValue(" ");
				}
				count++;
				
				//培训机构编号
				row.createCell(count).setCellValue(insCode610);
				count++;

				//联系地址
				row.createCell(count).setCellValue(examiner.getAddress()==null?" ":examiner.getAddress());
				count++;

				//驾驶证号
				row.createCell(count).setCellValue(examiner.getDrilicence()==null?" ":examiner.getDrilicence());
				count++;

				System.out.println(examiner.getFstdrilicdate());
				//驾驶证初领日期
				row.createCell(count).setCellValue(examiner.getFstdrilicdate()==null?" "
						:new SimpleDateFormat("yyyyMMdd").format(examiner.getFstdrilicdate()));
				count++;

				//准驾车型
				row.createCell(count).setCellValue(examiner.getDripermitted()==null?" ":examiner.getDripermitted());
				count++;

				//准教车型
				row.createCell(count).setCellValue(examiner.getTeachpermitted()==null?" ":examiner.getTeachpermitted());
				count++;

				//职业资格证号
				row.createCell(count).setCellValue(examiner.getOccupationno()==null?" ":examiner.getOccupationno());
				count++;

				//职业资格等级
				row.createCell(count).setCellValue(examiner.getOccupationlevel()==null?" ":examiner.getOccupationlevel());
				count++;

				//考核员编号
				row.createCell(count).setCellValue(examiner.getExamnum()==null?" ":examiner.getExamnum());
				count++;

				//照片文件ID
				row.createCell(count).setCellValue(examiner.getPhoto()==null?" ":examiner.getPhoto().toString());
				count++;

				//指纹图片ID
				row.createCell(count).setCellValue(examiner.getFingerprint()==null?" ":examiner.getFingerprint().toString());
				
				exportRow++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 安全员导出
	 * @param wb
	 * @param insId
	 */
	private void exportSecurity(HSSFWorkbook wb,Integer insId){
		try {
			HSSFSheet sheet = null;
			HSSFFont f = wb.createFont();
			int exportRow = 1;
			List<Security> exportlist = securityService.exceporSecurity(insId);
			sheet = wb.createSheet("安全员信息");
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
			sheet.setColumnWidth(7, 4500);
			sheet.setColumnWidth(8, 4500);
			sheet.setColumnWidth(9, 4500);
			f.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);// 粗体显示
			style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
			sheet.autoSizeColumn(1, true);
			// row.setHeightInPoints(30); //设置行高
			style.setFont(f);
			sheet.autoSizeColumn(1);
			// 获取第一行的每一个单元格
			int num=0;

			cell = row.createCell(num);
			// 往单元格里面写入值
			cell.setCellValue("姓名"); // 头部
			cell.setCellStyle(style);
			num++;

			cell = row.createCell(num);
			// 往单元格里面写入值
			cell.setCellValue("性别"); // 头部
			cell.setCellStyle(style);
			num++;

			cell = row.createCell(num);
			// 往单元格里面写入值
			cell.setCellValue("手机号码"); // 头部
			cell.setCellStyle(style);
			num++;

			cell = row.createCell(num);
			// 往单元格里面写入值
			cell.setCellValue("身份证号"); // 头部
			cell.setCellStyle(style);
			num++;

			cell = row.createCell(num);
			// 往单元格里面写入值
			cell.setCellValue("供职状态"); // 头部
			cell.setCellStyle(style);
			num++;

			cell = row.createCell(num);
			// 往单元格里面写入值
			cell.setCellValue("入职时间"); // 头部
			cell.setCellStyle(style);
			num++;

			cell = row.createCell(num);
			// 往单元格里面写入值
			cell.setCellValue("离职时间"); // 头部
			cell.setCellStyle(style);
			num++;

			//培训机构编号
			cell = row.createCell(num);
			cell.setCellValue("培训机构编号");
			cell.setCellStyle(style);
			num++;

			//照片文件ID
			cell = row.createCell(num);
			cell.setCellValue("照片文件ID");
			cell.setCellStyle(style);
			num++;

			//指纹图片ID
			cell = row.createCell(num);
			cell.setCellValue("指纹图片ID");
			cell.setCellStyle(style);
			num++;

			//联系地址
			cell = row.createCell(num);
			cell.setCellValue("联系地址");
			cell.setCellStyle(style);
			num++;

			//驾驶证号
			cell = row.createCell(num);
			cell.setCellValue("驾驶证号");
			cell.setCellStyle(style);
			num++;

			//驾驶证初领日期
			cell = row.createCell(num);
			cell.setCellValue("驾驶证初领日期");
			cell.setCellStyle(style);
			num++;

			//准驾车型
			cell = row.createCell(num);
			cell.setCellValue("准驾车型");
			cell.setCellStyle(style);
			num++;

			//准教车型
			cell = row.createCell(num);
			cell.setCellValue("准教车型");
			cell.setCellStyle(style);
			num++;

			//安全员编号
			cell = row.createCell(num);
			cell.setCellValue("安全员编号");
			cell.setCellStyle(style);
			
			for (int i = 0; i < exportlist.size(); i++) { // 循环导出数据
				Security security = exportlist.get(i);
				// 第四步，创建单元格，并设置值
				// if (string.getId() == stu.getStationId()) {
				row = sheet.createRow((int) exportRow);
				
				int count=0;				
				//安全员姓名
				if(security.getName()!=null){
					row.createCell((short)count).setCellValue(security.getName());
				}else{
					row.createCell((short)count).setCellValue("");
				}
				count++;
				
				// 性别
				if (security.getSex() != null) {
					row.createCell((short) count).setCellValue(security.getSex());
				} else {
					row.createCell((short) count).setCellValue(" ");
				}
				count++;
				
				// 电话
				if (security.getMobile() != null) {
					row.createCell((short) count).setCellValue(security.getMobile());
				} else {
					row.createCell((short) count).setCellValue(" ");
				}
				count++;
				
				//身份证号码
				if(security.getIdcard()!=null){
					row.createCell((short)count).setCellValue(security.getIdcard());
				}else{
					row.createCell((short)count).setCellValue("");
				}
				count++;
				
				//供职状态
				if(security.getEmploystatus()!=null){
					row.createCell((short) count).setCellValue(security.getEmploystatus());
				}else{
					row.createCell((short) count).setCellValue(" ");
				}
				count++;

				//入职日期
				if(security.getHiredate()!=null){
					row.createCell((short) count).setCellValue(new SimpleDateFormat("yyyyMMdd").format(security.getHiredate()));
				}else{
					row.createCell((short) count).setCellValue(" ");
				}
				count++;
				
				//离职日期
				if(security.getLeavedate()!=null){
					row.createCell((short) count).setCellValue(new SimpleDateFormat("yyyyMMdd").format(security.getLeavedate()));
				}else{
					row.createCell((short) count).setCellValue(" ");
				}
				count++;
				
				//培训机构编号
				row.createCell(count).setCellValue(insCode610);
				count++;

				//照片文件ID
				row.createCell(count).setCellValue(security.getPhoto()==null?" ":
					security.getPhoto().toString());
				count++;

				//指纹图片ID
				row.createCell(count).setCellValue(security.getFingerprint()==null?" ":
					security.getFingerprint().toString());
				count++;

				//联系地址
				row.createCell(count).setCellValue(security.getAddress()==null?" ":
					security.getAddress());
				count++;

				//驾驶证号
				row.createCell(count).setCellValue(security.getDrilicence()==null?" ":
					security.getDrilicence());
				count++;

				System.out.println(security.getFstdrilicdate());
				//驾驶证初领日期
				row.createCell(count).setCellValue(security.getFstdrilicdate()==null?" ":
					new SimpleDateFormat("yyyyMMdd").format(security.getFstdrilicdate()));
				count++;

				//准驾车型
				row.createCell(count).setCellValue(security.getDripermitted()==null?" ":
					security.getDripermitted());
				count++;

				//准教车型
				row.createCell(count).setCellValue(security.getTeachpermitted()==null?" ":
					security.getTeachpermitted());
				count++;

				//安全员编号
				row.createCell(count).setCellValue(security.getSecunum()==null?" ":
					security.getSecunum());
				
				exportRow++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 教练车导出
	 * @param wb
	 * @param insCode
	 */
	private void exportTrainingCar(HSSFWorkbook wb,String insCode){
		try {
			HSSFSheet sheet = null;
			HSSFFont f = wb.createFont();
			int exportRow = 1;
			sheet = wb.createSheet("教练车列表");
			HSSFRow row = sheet.createRow(0);
			HSSFCell cell = null;
			HSSFCellStyle style = wb.createCellStyle();
			style.setWrapText(true);// 设置自动换行
			f.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);// 粗体显示
			style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
			sheet.autoSizeColumn(1, true);
			style.setFont(f);
			sheet.autoSizeColumn(1);
			int count=0;
			cell = row.createCell(count++);
			cell.setCellValue("培训机构编号"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("教练车编号"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("车架号"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("发动机号"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("车辆牌号"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("车牌颜色"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("生产厂家"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("车辆品牌"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("车辆型号"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("培训车型"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("购买日期"); 
			cell.setCellStyle(style);
			//照片文件ID
			cell = row.createCell(count++);
			cell.setCellValue("照片文件ID"); 
			cell.setCellStyle(style);
			
			List<TrainingCar> list=trainingCarService.getAll(insCode);
			for (int i = 0; i < list.size(); i++) {
				TrainingCar car=list.get(i);
				row = sheet.createRow((int) exportRow);
				count=0;
				row.createCell(count++).setCellValue(car.getInscode()==null?" ":car.getInscode());
				row.createCell(count++).setCellValue(car.getCarnum()==null?" ":car.getCarnum());
				row.createCell(count++).setCellValue(car.getFranum()==null?" ":car.getFranum());
				row.createCell(count++).setCellValue(car.getEngnum()==null?" ":car.getEngnum());
				row.createCell(count++).setCellValue(car.getLicnum()==null?" ":car.getLicnum());
				row.createCell(count++).setCellValue(car.getPlatecolor()==null?" ":car.getPlatecolor()+"");
				row.createCell(count++).setCellValue(car.getManufacture()==null?" ":car.getManufacture());
				row.createCell(count++).setCellValue(car.getBrand()==null?" ":car.getBrand());
				row.createCell(count++).setCellValue(car.getModel()==null?" ":car.getModel());
				row.createCell(count++).setCellValue(car.getPerdritype()==null?" ":car.getPerdritype());
				row.createCell(count++).setCellValue(car.getBuydate()==null?" ":
					new SimpleDateFormat("yyyyMMdd").format(car.getBuydate()+""));
				row.createCell(count++).setCellValue(car.getPhoto()==null?" ":car.getPhoto().toString());
				exportRow++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 计时终端导出
	 * @param wb
	 * @param insCode
	 */
	private void exportDevice(HSSFWorkbook wb,String insCode){
		try {
			HSSFSheet sheet = null;
			HSSFFont f = wb.createFont();
			int exportRow = 1;
			sheet = wb.createSheet("计时终端列表");
			HSSFRow row = sheet.createRow(0);
			HSSFCell cell = null;
			HSSFCellStyle style = wb.createCellStyle();
			style.setWrapText(true);// 设置自动换行
			f.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);// 粗体显示
			style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
			sheet.autoSizeColumn(1, true);
			style.setFont(f);
			sheet.autoSizeColumn(1);
			int count=0;
			cell = row.createCell(count++);
			cell.setCellValue("终端编号"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("计时终端类型"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("生产厂家"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("终端型号"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("安装日期"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("终端IMEI号或设备MAC地址"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("终端出厂序列号"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("培训机构编号"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("终端证书口令"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("终端证书"); 
			cell.setCellStyle(style);
			List<Device> list=deviceService.getAll();
			for (int i = 0; i < list.size(); i++) {
				Device device=list.get(i);
				row = sheet.createRow((int) exportRow);
				count=0;
				row.createCell(count++).setCellValue(device.getDevnum()==null?" ":device.getDevnum());
				row.createCell(count++).setCellValue(device.getTermtype()==null?" ":device.getTermtype()+"");
				row.createCell(count++).setCellValue(device.getVender()==null?" ":device.getVender());
				row.createCell(count++).setCellValue(device.getModel()==null?" ":device.getModel());
				row.createCell(count++).setCellValue(device.getInstallDate()==null?" ":
						new SimpleDateFormat("yyyyMMdd").format(device.getInstallDate()));
				row.createCell(count++).setCellValue(device.getImei()==null?" ":device.getImei());
				row.createCell(count++).setCellValue(device.getSn()==null?" ":device.getSn());
				row.createCell(count++).setCellValue(insCode);
				row.createCell(count++).setCellValue(device.getPasswd()==null?" ":device.getPasswd());
				row.createCell(count++).setCellValue(device.getKey()==null?" ":device.getKey());
				exportRow++;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 学员导出
	 * @param wb
	 * @param insCode
	 */
	private void exportStudent(HSSFWorkbook wb,Integer insId,Integer stationId,String insCode){
		try {
			HSSFSheet sheet = null;
			HSSFFont f = wb.createFont();
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
			int count=0;
			
//			cell = row.createCell(count++);
//			// 往单元格里面写入值
//			cell.setCellValue("隶属报名处"); // 头部
//			cell.setCellStyle(style);
			
			cell = row.createCell(count++);
			// 往单元格里面写入值
			cell.setCellValue("报名时间"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(count++);
			// 往单元格里面写入值
			cell.setCellValue("证件号"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(count++);
			// 往单元格里面写入值
			cell.setCellValue("姓名"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(count++);
			// 往单元格里面写入值
			cell.setCellValue("性别"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(count++);
			// 往单元格里面写入值
			cell.setCellValue("手机号码"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(count++);
			// 往单元格里面写入值
			cell.setCellValue("班型"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(count++);
			// 往单元格里面写入值
			cell.setCellValue("国籍"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(count++);
			// 往单元格里面写入值
			cell.setCellValue("学员编号"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(count++);
			// 往单元格里面写入值
			cell.setCellValue("培训机构编号"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(count++);
			// 往单元格里面写入值
			cell.setCellValue("驾驶证号"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(count++);
			// 往单元格里面写入值
			cell.setCellValue("驾驶证初领日期"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(count++);
			// 往单元格里面写入值
			cell.setCellValue("原准驾车型"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(count++);
			// 往单元格里面写入值
			cell.setCellValue("证件类型"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(count++);
			// 往单元格里面写入值
			cell.setCellValue("联系地址"); // 联系地址
			cell.setCellStyle(style);
			
			cell = row.createCell(count++);
			// 往单元格里面写入值
			cell.setCellValue("培训车型"); // 联系地址
			cell.setCellStyle(style);
			
			//培训网点
			cell = row.createCell(count++);
			cell.setCellValue("培训网点");
			cell.setCellStyle(style);

			//应交学费
			cell = row.createCell(count++);
			cell.setCellValue("应交学费");
			cell.setCellStyle(style);

			//已交学费
			cell = row.createCell(count++);
			cell.setCellValue("已交学费");
			cell.setCellStyle(style);

			//还欠学费
			cell = row.createCell(count++);
			cell.setCellValue("还欠学费");
			cell.setCellStyle(style);

			//业务类型
			cell = row.createCell(count++);
			cell.setCellValue("业务类型");
			cell.setCellStyle(style);

			//照片文件ID
			cell = row.createCell(count++);
			cell.setCellValue("照片文件ID");
			cell.setCellStyle(style);

			//指纹图片ID
			cell = row.createCell(count);
			cell.setCellValue("指纹图片ID");
			cell.setCellStyle(style);

			for (int i = 0; i < exportlist.size(); i++) { // 循环导出数据
				Student stu = exportlist.get(i);
				// 第四步，创建单元格，并设置值
				// if (string.getId() == stu.getStationId()) {
				row = sheet.createRow((int) exportRow);
//				// 身份证号码
//				if (stu.getStationName() != null) {
//					row.createCell((short) 0).setCellValue(stu.getStationName());
//				} else {
//					row.createCell((short) 0).setCellValue(" ");
//				}
				// 报名时间
				if (stu.getApplydate() != null) {
					row.createCell((short) 0).setCellValue(new SimpleDateFormat("yyyyMMdd").format(stu.getApplydate()));
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
					row.createCell((short) 3).setCellValue(stu.getSex());
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
				row.createCell((short) 6).setCellValue(stu.getNationality()==null?" ":stu.getNationality());
				row.createCell((short) 7).setCellValue(stu.getStunum());	//学员编号
				row.createCell((short) 8).setCellValue(insCode);		//机构编号
				row.createCell((short) 9).setCellValue(stu.getDrilicnum()==null?" ":
					stu.getDrilicnum());	//驾驶证号
				row.createCell((short) 10).setCellValue(stu.getFstdrilicdate()==null?" ":
					new SimpleDateFormat("yyyyMMdd").format(stu.getFstdrilicdate()));		//驾驶证初领日期
				row.createCell((short) 11).setCellValue(stu.getPerdritype()==null?" ":stu.getPerdritype());	//原准驾车型
				row.createCell((short) 12).setCellValue(stu.getCradtype());	//证件类型
				row.createCell((short) 13).setCellValue(stu.getAddress());	//联系地址
				row.createCell((short) 14).setCellValue(stu.getTraintype());	//
				
				int num=15;
				//培训网点
				row.createCell(num++).setCellValue(stu.getStationId()==null?" ":stu.getStationId().toString());

				//应交学费
				row.createCell(num++).setCellValue(stu.getTuition()==null?" ":stu.getTuition().toString());

				//已交学费
				row.createCell(num++).setCellValue(stu.getAlreadyPay()==null?" ":stu.getAlreadyPay().toString());

				//还欠学费
				row.createCell(num++).setCellValue(stu.getArrearage()==null?" ":stu.getArrearage().toString());

				//业务类型
				row.createCell(num++).setCellValue(stu.getBusitype()==null?" ":stu.getBusitype().toString());

				//照片文件ID
				row.createCell(num++).setCellValue(stu.getPhotoId()==null?" ":stu.getPhotoId().toString());

				//指纹图片ID
				row.createCell(num).setCellValue(stu.getFingerprintsId()==null?" ":stu.getFingerprintsId().toString());
				
				exportRow++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}