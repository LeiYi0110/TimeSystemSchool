package com.bjxc.school.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjxc.school.Coach;
import com.bjxc.school.StudentExam;
import com.bjxc.school.StudentSubject;
import com.bjxc.school.mapper.StudentExamMapper;

/**
 * 考试管理
 * @author yy
 */
@Service
public class StudentExamService {
	@Resource
	private StudentExamMapper studentExamMapper;
	
	@Resource
	private StudentSubjectService studentSubjectService;
	
	@Resource
	private StudentService studentService;
	
	public List<StudentExam> list(Map map){
		return studentExamMapper.list(map);
	}
	
	public Integer getStuId(String idcard){
		return studentExamMapper.getStuId(idcard);
	}
	
	public void updateExam2(StudentExam studentExam){
		if(new Integer(1).equals(studentExam.getPass())){
			studentSubjectService.updateNowSubject(studentExam.getStudentID(), studentExam.getSubjectId());
			if(new Integer(4).compareTo(studentExam.getSubjectId())>0){
				Integer newSub=studentExam.getSubjectId()+1;
				StudentSubject studentSubject=new StudentSubject();
				studentSubject.setCoachId(studentExam.getCoachId());
				studentSubject.setStudentId(studentExam.getStudentID());
				studentSubject.setSubjectId(newSub);
				studentSubjectService.addStudentSubject(studentExam.getInsId(),studentSubject);
			}
		}
		Integer count=studentExamMapper.getCountExam(studentExam);
		if(count>0){
			studentExamMapper.updateExam(studentExam);
		}else{
			studentExamMapper.insertExam(studentExam);
		}
	}
	
	public void updateExam(StudentExam studentExam){
		studentExamMapper.updateExam(studentExam);
		if(new Integer(1).equals(studentExam.getPass())){
			studentSubjectService.updateNowSubject(studentExam.getStudentID(), studentExam.getSubjectId());
			if(new Integer(4).compareTo(studentExam.getSubjectId())>0){
				Integer newSub=studentExam.getSubjectId()+1;
				StudentSubject studentSubject=new StudentSubject();
				studentSubject.setCoachId(studentExam.getCoachId());
				studentSubject.setStudentId(studentExam.getStudentID());
				studentSubject.setSubjectId(newSub);
				studentSubjectService.addStudentSubject(studentExam.getInsId(),studentSubject);
				studentExamMapper.updateStudent(studentExam.getStudentID());
			}
		}
	}
}
