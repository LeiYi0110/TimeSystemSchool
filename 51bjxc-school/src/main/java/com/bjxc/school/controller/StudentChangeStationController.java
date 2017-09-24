package com.bjxc.school.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bjxc.Result;
import com.bjxc.school.Student;
import com.bjxc.school.StudentChangeStation;
import com.bjxc.school.mapper.StudentMapper;
import com.bjxc.school.service.StudentChangeStationService;
import com.bjxc.web.utils.WebUtils;

@RestController
@RequestMapping(value="/studentChangeStation")
public class StudentChangeStationController {
	private static final Logger logger = LoggerFactory.getLogger(StudentChangeStationController.class);
	@Resource
	private StudentChangeStationService studentChangeStationService;
	@Resource
	private StudentMapper studentMapper;
	
	
	
	
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public Result list(@RequestParam(value="insId", required=true)Integer insId,
			@RequestParam(value="startTime", required=false)String startTime,
			@RequestParam(value="endTime", required=false)String endTime,
			@RequestParam(value="stationId", required=false)Integer stationId,
			@RequestParam(value="status", required=false)Integer status){
		Result result = new Result();
		try {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date start = null;
			if(!StringUtils.isEmpty(startTime)){
				 start = format.parse(startTime); 
			}
			Date end =  null;
			if(!StringUtils.isEmpty(endTime)){
				 end = format.parse(endTime);
			}
			if(status == null){
				status = new Integer(-1);
			}
			List<StudentChangeStation> list = studentChangeStationService.list(insId,stationId, status,start,end);
			result.success(list);
		} catch (Throwable ex) {
			logger.error("StudentChangeStation field list",ex);
			result.error(ex);
		}
		return result;
	}
	
	@RequestMapping(method=RequestMethod.POST)
	public Result save(HttpServletRequest request){
		Integer createUserId = WebUtils.getParameterIntegerValue(request, "createUserId");
		Integer studentId = WebUtils.getParameterIntegerValue(request, "studentId");
		Integer fromStation = WebUtils.getParameterIntegerValue(request, "fromStation");
		Integer toStation = WebUtils.getParameterIntegerValue(request, "toStation");
		System.out.println("123456789");
		Result result = new Result();
		try{
			StudentChangeStation studentChangeStation = new StudentChangeStation();
			studentChangeStation.setStudentId(studentId);
			studentChangeStation.setFromStation(fromStation);
			studentChangeStation.setToStation(toStation);
			studentChangeStation.setCreateUserId(createUserId);
			//新增转出学员
			studentChangeStationService.add(studentChangeStation);
			
			result.success(studentChangeStation);
		}catch(Throwable ex){
			logger.error("save Student field ", ex);
			result.error(ex);
		}
		return result;	
	}
	
	@RequestMapping(value="/manage/{id}/{manage}/{studentId}",method=RequestMethod.POST)
	public Result manage(@PathVariable("id")Integer id,@PathVariable("manage")Integer manage,@PathVariable("studentId")Integer studentId){
		Result result = new Result();
		try {
			StudentChangeStation studentChangeStation = studentChangeStationService.get(id);
			if(new Integer(1).equals(manage)){//接收学员
				studentChangeStationService.update(id, new Integer(1));
				//修改学员网点
				Student student = studentMapper.get(studentId);
				student.setStationId(studentChangeStation.getToStation());
				studentMapper.update(student);
			}else if(new Integer(2).equals(manage)){//拒绝接收学员
				studentChangeStationService.update(id, new Integer(2));
			}
			result.success();
		} catch (Exception e) {
			logger.error("classType field delete ",e);
			result.error(e);
		}
		return result;
	}
	
}
