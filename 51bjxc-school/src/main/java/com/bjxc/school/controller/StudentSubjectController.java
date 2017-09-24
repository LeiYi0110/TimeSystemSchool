package com.bjxc.school.controller;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bjxc.Result;
import com.bjxc.school.StudentSubject;
import com.bjxc.school.service.StudentSubjectService;
import com.bjxc.web.utils.WebUtils;

@RestController
@RequestMapping(value="/studentSubject")
public class StudentSubjectController {
	private static final Logger logger = LoggerFactory.getLogger(StudentController.class);
	@Resource
	private StudentSubjectService studentSubjectService;
	
	/**
	 *学员信息  名称的模糊搜索
	 */
	@RequestMapping(value="/list",method=RequestMethod.GET)
	@UserControllerLog(description = "获取学员科目列表")    
	public Result list(@RequestParam(value="studentId", required=true)Integer studentId,@RequestParam(value="insId", required=true)Integer insId){
		Result result = new Result();
		try {
			List<StudentSubject> data = studentSubjectService.list(insId,studentId);
			result.success(data);
		} catch (Exception e) {
			logger.error("Student subject list",e);
			result.error(e);
		}
		return result;
	}

	@RequestMapping(value="/completeSubject",method=RequestMethod.POST)
	@UserControllerLog(description = "操作完成科目")    
	public Result completeSubject(@RequestParam(value="studentId", required=true)Integer studentId,@RequestParam(value="subjectId", required=true)Integer subjectId){
		Result result = new Result();
		try {
			studentSubjectService.endSubject(studentId, subjectId);
			result.success();
		} catch (Exception e) {
			logger.error("Student subject complete",e);
			result.error(e);
		}
		return result;
	}


	@RequestMapping(value="/add",method=RequestMethod.POST)
	@UserControllerLog(description = "添加学员科目")    
	public Result add(@RequestParam(value="insId", required=true)Integer insId,@RequestParam(value="studentId", required=true)Integer studentId,@RequestParam(value="subjectId", required=true)Integer subjectId,HttpServletRequest request){
		Result result = new Result();
		try {
			Integer coachId=WebUtils.getParameterIntegerValue(request, "coachId");
			StudentSubject studentSubject = new StudentSubject();
			studentSubject.setCoachId(coachId);
			studentSubject.setStudentId(studentId);
			studentSubject.setSubjectId(subjectId);
			studentSubjectService.addStudentSubject(insId,studentSubject);
			if(new Integer(0).equals(subjectId)){
				//科目一寻入 需要再 录入科目一开始
				studentSubject.setEndTime(null);
				studentSubject.setId(null);
				studentSubject.setSubjectId(new Integer(1));
				studentSubjectService.addStudentSubject(insId,studentSubject);
			}
			
			result.success();
		} catch (Exception e) {
			logger.error("Student subject add",e);
			result.error(e);
		}
		return result;
	}
	
	/**
	 * 更换教练
	 * @param studentId
	 * @param subjectId
	 * @param coachId
	 * @return
	 */
	@RequestMapping(value="/changeCoach",method=RequestMethod.POST)
	@UserControllerLog(description = "更换教练")    
	public Result changeCoach(@RequestParam(value="studentId", required=true)Integer studentId,@RequestParam(value="subjectId", required=true)Integer subjectId,@RequestParam(value="coachId", required=true)Integer coachId){
		Result result = new Result();
		try {
			studentSubjectService.changeCoach(studentId, subjectId, coachId);
			result.success();
		} catch (Exception e) {
			logger.error("Student subject changeCoach",e);
			result.error(e);
		}
		return result;
	}
}
