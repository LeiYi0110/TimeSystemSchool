package com.bjxc.school.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjxc.school.Student;
import com.bjxc.school.StudentInsLog;
import com.bjxc.school.mapper.StudentInsLogMapper;

@Service
public class StudentInsLongService {
	@Resource
	private StudentInsLogMapper studentInsLongMapper;
	
	@Resource
	private StudentService studentService;


	public void add(Integer studentId,String content,Integer category){
		Student student = studentService.get(studentId);
		this.add(studentId,student.getInsId(), content, category);
	}
	public void add(Integer studentId,Integer insId,String content,Integer category){
		StudentInsLog studentInsLong = new StudentInsLog();
		studentInsLong.setStudentID(studentId);
		studentInsLong.setInsId(insId);
		studentInsLong.setContent(content);
		studentInsLong.setCategory(category);
		add(studentInsLong);
	}
	
	
	public void add(StudentInsLog studentInsLong){
		studentInsLongMapper.add(studentInsLong);
	}
	
	public List<StudentInsLog> list(Integer studentId){
		return studentInsLongMapper.list(studentId);
	}
	
	public Integer addHasTime(StudentInsLog studentInsLong){
		return studentInsLongMapper.addHasTime(studentInsLong);
	}
	
	public List<StudentInsLog> getList(String search){
		return studentInsLongMapper.getList(search);
	}
}
