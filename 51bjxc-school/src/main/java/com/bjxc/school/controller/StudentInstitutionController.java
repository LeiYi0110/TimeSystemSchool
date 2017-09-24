package com.bjxc.school.controller;

import java.io.UnsupportedEncodingException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bjxc.Page;
import com.bjxc.Result;
import com.bjxc.school.DrivingField;
import com.bjxc.school.Examiner;
import com.bjxc.school.Student;
import com.bjxc.school.StudentChangeInstitution;
import com.bjxc.school.service.StudentInstitutionService;
import com.bjxc.school.service.StudentService;

@RestController
@RequestMapping(value="/studentInstitution")
public class StudentInstitutionController {
	
	private static final Logger logger =LoggerFactory.getLogger(StudentInstitutionController.class);
	
	@Resource
	private StudentInstitutionService studentInstitutionService;
	
	
	@Resource
	private StudentService studentService;
	/**
	 *查询所有转出记录
	 */
	@RequestMapping(value="/list",method=RequestMethod.GET)
	@UserControllerLog(description = "查询所有转出记录")    
	public Result pageQuery(@RequestParam(value="searchText", required=false)String searchText,Integer insId,Integer pageIndex,Integer pageSize){
		Result result = new Result();
		try {
			Page<StudentChangeInstitution> page = studentInstitutionService.pageQuery(insId,pageIndex,pageSize,searchText);
			result.success(page.getData());
			result.put("rowCount", page.getRowCount());
		} catch (Exception e) {
			logger.error("StudentChangeInstitution field list",e);
			result.error(e);
		}
		return result;
	}
	
	/**
	 *查询所有转入记录
	 */
	@RequestMapping(value="/toList",method=RequestMethod.GET)
	@UserControllerLog(description = "查询所有转入记录")    
	public Result toPageQuery(@RequestParam(value="searchText", required=false)String searchText,Integer insId,Integer pageIndex,Integer pageSize){
		Result result = new Result();
		try {
			Page<StudentChangeInstitution> page = studentInstitutionService.toPageQuery(insId,pageIndex,pageSize,searchText);
			result.success(page.getData());
			result.put("rowCount", page.getRowCount());
		} catch (Exception e) {
			logger.error("StudentChangeInstitution field list",e);
			result.error(e);
		}
		return result;
	}
	
	@RequestMapping(value="/saveOrUpdate",method=RequestMethod.POST)
	public Result saveOrUpdate(HttpServletRequest request,Integer createUserId,Integer studentId,Integer fromInsId,String toInsId){
		Result result = new Result();
		StudentChangeInstitution studentChangeInstitution = new StudentChangeInstitution();
		studentChangeInstitution.setCreateUserId(createUserId);
		studentChangeInstitution.setStudentId(studentId);
		studentChangeInstitution.setFromInsId(fromInsId);
		studentChangeInstitution.setInscodes(toInsId);
		try {
			studentInstitutionService.insertByStudentInstitution(studentChangeInstitution);
		} catch (Exception e) {
			logger.error("StudentInstitution saveOrUpdate",e);
			result.error(e);
		}
		return result;
	}
	
/*	@RequestMapping(value="/record",method=RequestMethod.POST)
	public Result record(HttpServletRequest request,Integer id,Integer isProvince){
		Result result = new Result();
		StudentChangeInstitution studentChangeInstitution = new StudentChangeInstitution();
		try {
			studentChangeInstitution.setId(id);
			studentChangeInstitution.setIsProvince(isProvince);
			studentInstitutionService.updatestu(studentChangeInstitution);
			result.success(studentChangeInstitution);
		} catch (Exception e) {
			logger.error("StudentInstitution saveOrUpdate",e);
			result.error(e);
		}
		return result;
	}*/
	

	/**
	 * 按ID找
	 * 
	 * @param id
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value = "/studentService", method = RequestMethod.GET)
	public Result studentService(String idcard,HttpServletRequest request) throws UnsupportedEncodingException {
		Result result = new Result();
		request.setCharacterEncoding("UTF-8");
		 Student student = studentService.idcarname(idcard);
		try {
			result.success(student);
		} catch (Exception e) {
			result.error(e);
		}
		return result;
	}
	
}
