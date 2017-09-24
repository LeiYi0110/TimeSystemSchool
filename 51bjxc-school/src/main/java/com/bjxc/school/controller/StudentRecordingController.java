package com.bjxc.school.controller;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.bjxc.Result;
import com.bjxc.school.StudentRecording;
import com.bjxc.school.service.StudentRecordingService;

@RestController
@RequestMapping(value="/studentRecording")
public class StudentRecordingController {
	private static final Logger logger = LoggerFactory.getLogger(StudentRecordingController.class);

	@Resource
	private StudentRecordingService studentRecordingService;
	
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public Result getAllStudentRecording(Integer id){
		Result result = new Result();
		try {
			List<StudentRecording> studentRecording = studentRecordingService.getAllStudentRecording(id);
			result.success(studentRecording);
		} catch (Throwable ex) {
			result.error(ex);
			logger.error("StudentRecordingApi getAllStudentRecording",ex);
		}
		return result;
	}
	
	
}
