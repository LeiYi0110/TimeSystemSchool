package com.bjxc.school.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import com.bjxc.exception.DuplicateException;
import com.bjxc.exception.StatusException;
import com.bjxc.school.StudentSubject;
import com.bjxc.school.mapper.StudentSubjectMapper;

@Service
public class StudentSubjectService {
	
	@Resource
	private StudentSubjectMapper studentSubjectMapper;
	
	public List<StudentSubject> list(Integer insId,Integer studentId){
		return studentSubjectMapper.list(insId,studentId);
	}
	
	public void endSubject(Integer studentId,Integer subjectId){
		studentSubjectMapper.updateNowSubject(studentId, subjectId);
	}
	
	/**
	 * 修改当前学习科目为已完成
	 */
	public void updateNowSubject(Integer studentId,Integer subjectId){
		studentSubjectMapper.updateNowSubject(studentId, subjectId);
		studentSubjectMapper.updateSubject(studentId);
	}

	public void endAllSubject(Integer studentId){
		studentSubjectMapper.endAllSubject(studentId);
	}
	/**
	 * 更换教练
	 * @param studentId 学员ID
	 * @param subjectId 科目ID
	 * @param coachId 教练ID
	 */
	public void changeCoach(Integer studentId,Integer subjectId,Integer coachId){
		studentSubjectMapper.changeCoach(studentId, subjectId, coachId);
	}
	
	/**
	 * 新增下一个科目的学习状态为进行中
	 */
	public void addStudentSubject(Integer insId,StudentSubject studentSubject){
		Assert.notNull(insId);
		studentSubject.setStatus(new Integer(1));
		List<StudentSubject> stusubs = studentSubjectMapper.list(insId,studentSubject.getStudentId());
		/*for(StudentSubject stusub : stusubs){
			if(new Integer(1).equals(stusub.getStatus())){
				throw new StatusException("学员还有科目未完成");
			}else if(studentSubject.getSubjectId().equals(stusub.getSubjectId())){
				throw new DuplicateException("当前学员已学习指定科目");
			}
		}*/
		int cmp = 0;
		for(StudentSubject stusub : stusubs){
			
			if(studentSubject.getSubjectId().equals(stusub.getSubjectId())){
				cmp=520;
			}
		}
		if(new Integer(0).equals(studentSubject.getSubjectId())){
			//科目一寻入 结束时间也为当前时间
			studentSubject.setEndTime(new Date());
			studentSubject.setStatus(new Integer(2));
		}
		if(cmp==520){
			studentSubjectMapper.updateStudentSubject(studentSubject);
		}else{
			studentSubjectMapper.addStudentSubject(studentSubject);
		}
	}
	/**
	 * 新增下一个科目的学习状态为进行中
	 */
	public void addSubject(StudentSubject studentSubject){

		studentSubjectMapper.addSubject(studentSubject);
	}
	
	public boolean isExistsRelationShip(Integer studentId, Integer coachId){
		Integer count = studentSubjectMapper.isExistsRelationShip(studentId, coachId);
		
		return count == 0 ? false: true;
	}

	
}
