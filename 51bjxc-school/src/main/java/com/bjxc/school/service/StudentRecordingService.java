package com.bjxc.school.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjxc.school.StudentRecording;
import com.bjxc.school.mapper.StudentRecordingMapper;

@Service
public class StudentRecordingService {

	@Resource
	private StudentRecordingMapper studentrecordingMapper;
	
	public List<StudentRecording> getAllStudentRecording(Integer studentId){
		List<StudentRecording> studentRecording = studentrecordingMapper.getAllStudentRecording(studentId);
		return studentRecording;
	}
	
}
