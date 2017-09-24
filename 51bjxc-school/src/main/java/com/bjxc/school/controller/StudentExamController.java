package com.bjxc.school.controller;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.bjxc.Result;
import com.bjxc.school.*;
import com.bjxc.school.service.StudentExamService;
import com.bjxc.school.utils.ReaderExcelUtils;
import com.bjxc.web.utils.WebUtils;

/**
* 考试管理action
* @author yy
* @date : 2016年9月18日 下午2:26:29
*/
@Controller
@RequestMapping(value="/exam")
public class StudentExamController {
	private static final Logger logger = LoggerFactory.getLogger(ClassTypeController.class);
	@Resource
	private StudentExamService examService;
	
	private ReaderExcelUtils reu = new ReaderExcelUtils();
	
	@ResponseBody
	@RequestMapping(value="/importScore",method=RequestMethod.POST)
	public Result importScore(HttpServletRequest request,Integer subject) throws Exception{
		//MultipartFile方式读取文件
		Result result = new Result();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request; 
		MultipartFile file = multipartRequest.getFile("upfile");  
		Integer insId=WebUtils.getParameterIntegerValue(request, "insId");
		if(file.isEmpty()){  
			throw new Exception("文件不存在！");  
		}  
		InputStream in = file.getInputStream();
		String fileName=file.getOriginalFilename();
		List<Map> dataMap=reu.ReaderExcel(in, fileName);
		List<Map> errorList=new ArrayList<Map>();
		
		for (int i = 0; i < dataMap.size()-1; i++) {
			try {
				StudentExam exam=new StudentExam();
				Integer id=examService.getStuId(dataMap.get(i).get("证件号码").toString());
				if(dataMap.get(i).get("考试结果").toString().equals("合格")){
					exam.setPass(1);
				}else{
					exam.setPass(0);
				}
				exam.setStudentID(id);
				exam.setSubjectId(subject);
				exam.setInsId(insId);
				exam.setCoachId(null);
				examService.updateExam2(exam);
			} catch (Exception e) {
				Map<String,String> errorMap=new HashMap<String,String>();
				errorMap.put("科目", subject.toString());
				errorMap.put("证件号码", dataMap.get(i).get("证件号码").toString());
				errorMap.put("考试结果", dataMap.get(i).get("考试结果").toString());
				errorMap.put("姓名", dataMap.get(i).get("姓名").toString());
				errorMap.put("流水号", dataMap.get(i).get("流水号").toString());
				errorMap.put("考试日期", dataMap.get(i).get("考试日期").toString());
				errorMap.put("考试成绩", dataMap.get(i).get("考试成绩").toString());
				errorList.add(errorMap);
			}
		}
		result.success(errorList);
		return result;
	}
	
	/**
	 * 考试管理列表
	 */
	@ResponseBody
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public Result list(@RequestParam(value="searchText", required=false)String searchText,HttpServletRequest request){
		Result result = new Result();
		Map map=new HashMap();
		map.put("insId", request.getParameter("insId"));
		try {
			List<StudentExam> datas=examService.list(map);
			result.success(datas);
		} catch (Exception e) {
			logger.error("考试列表",e);
			result.error(e);
		}
		return result;
	}
	

	
	/**
	 * 考试通过（通过与否pass重新设为null）
	 */
	@ResponseBody
	@RequestMapping(value="/{id}",method=RequestMethod.POST)
	public Result change(@PathVariable Integer id,HttpServletRequest request){
		Result result = new Result();
		Integer pass=WebUtils.getParameterIntegerValue(request, "status");
		Integer subjectId=WebUtils.getParameterIntegerValue(request, "subjectId");
		Integer studentId=WebUtils.getParameterIntegerValue(request, "studentId");
		Integer coachId=WebUtils.getParameterIntegerValue(request, "coach");
		Integer insId=WebUtils.getParameterIntegerValue(request, "insId");
		try {
			StudentExam exam=new StudentExam();
			exam.setId(id);
			exam.setPass(pass);
			exam.setSubjectId(subjectId);
			exam.setStudentID(studentId);
			exam.setCoachId(coachId);
			exam.setInsId(insId);
			examService.updateExam(exam);
		} catch (Exception e) {
			logger.error("考试通过",e);
			result.error(e);
		}
		return result;
	}
}
