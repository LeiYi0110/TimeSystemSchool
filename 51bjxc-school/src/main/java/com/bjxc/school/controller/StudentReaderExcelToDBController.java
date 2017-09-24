package com.bjxc.school.controller;

import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileUploadBase;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.bjxc.Result;
import com.bjxc.school.Student;
import com.bjxc.school.service.InstitutionInfoService;
import com.bjxc.school.service.StudentService;
import com.bjxc.school.utils.ReaderExcelUtils;

/**
 * excel表格的数据录入
 * 
 * @author hjr
 *
 */

@Controller
public class StudentReaderExcelToDBController {
	private static final Logger logger = LoggerFactory.getLogger(StudentReaderExcelToDBController.class);

	private ReaderExcelUtils reu = new ReaderExcelUtils();

	@Resource
	private InstitutionInfoService institutionService;
	@Resource
	private StudentService studentService;
	/**
	 * 读取Excel文件,将数据存入数据库
	 * 
	 * @param data
	 *            数据
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "static-access" })
	@ResponseBody
	@RequestMapping(value = "/InsertStudentToDB", method = RequestMethod.POST)
	@UserControllerLog(description = "从Exccel读取学员数据")    
	public Result InsertToDataBase(@RequestParam("stationId") Integer stationId, HttpServletRequest request,
			HttpSession httpSession) throws Exception {
		Result result = new Result();
		Date date = new Date();
		long time = date.getTime();
		List errorList=new ArrayList();
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
				int number = 0;
				// sheet名数组下标
				int sheetIndex = 0;
				int[] count = new int[nameStrs.length];
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
						String insIdEx = oneMap.get("培训机构编号").toString() != "" ? oneMap.get("培训机构编号").toString() : null;
						Integer insId = institutionService.getInsId(insIdEx);// 得到对应的培训机构id
						student.setInsId(insId);
						student.setStationId(stationId);// 培训网点
						student.setTuition(200000);// 应交学费(单位为:分)
						student.setAlreadyPay(0);// 已交学费(单位为:分)
						student.setArrearage(200000);// 还欠学费(单位为:分)
						student.setName(oneMap.get("姓名").toString());
						student.setMobile(oneMap.get("手机号码").toString());
						Integer cradTypeEx = oneMap.get("证件类型").toString().trim() != ""
								? Integer.parseInt(oneMap.get("证件类型").toString().trim()) : null;
						student.setCradtype(cradTypeEx);
						student.setIdcard(oneMap.get("证件号").toString());
						student.setNationality(oneMap.get("国籍").toString());
						Integer sexEx = oneMap.get("性别").toString().trim() != ""
								? Integer.parseInt(oneMap.get("性别").toString().trim()) : null;
						student.setSex(sexEx);
						student.setAddress(oneMap.get("联系地址").toString());
						Integer busiTypeEx = oneMap.get("业务类型").toString().trim() != ""
								? Integer.parseInt(oneMap.get("业务类型").toString().trim()) : null;
						student.setBusitype(busiTypeEx);
						student.setDrilicnum(oneMap.get("驾驶证号").toString());
						Date fstdriDateEx = oneMap.get("驾驶证初领日期").toString().trim() != ""
								? to_type.parse(oneMap.get("驾驶证初领日期").toString().trim()) : null;
						student.setFstdrilicdate(fstdriDateEx);
						student.setPerdritype(oneMap.get("原准驾车型").toString());
						student.setTraintype(oneMap.get("培训车型").toString());
						Date applyDateEx = oneMap.get("报名时间").toString().trim() != ""
								? to_type.parse(oneMap.get("报名时间").toString().trim()) : null;
						student.setApplydate(applyDateEx);
						try {
							studentService.addByExcel(student);
						} catch (Exception e) {
							if(("本驾校已存在证件号为 " + student.getIdcard() + " 的学员").equals(e.getMessage())){
								logger.error(e.getMessage());
								if(errorList.size()<5){
									errorList.add(e.getMessage());
								}
							}else{
								logger.error(e.getMessage());
								if(errorList.size()<5){
									errorList.add("本驾校已存在电话号为 " + student.getMobile() + " 的学员");
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
				logger.error("StudentReaderExcelToDBController field list", e);
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
			logger.error("StudentReaderExcelToDBController field list", e);
			result.error(e);
		} catch (Exception e) {
			logger.error("StudentReaderExcelToDBController field list", e);
			result.error(e);
		}
		return result;
	}
}