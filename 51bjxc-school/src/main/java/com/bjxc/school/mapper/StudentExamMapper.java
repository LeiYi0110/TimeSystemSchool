package com.bjxc.school.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bjxc.school.Coach;
import com.bjxc.school.StudentExam;

public interface StudentExamMapper {
	List<StudentExam> list(Map map);
	
	/**
	 * 更新学员考试，如果通过考试则修改新增学员科目表
	 */
	Integer updateExam(StudentExam exam);
	
	/**
	 * 更新学员状态为毕业
	 * @param id
	 * @return
	 */
	@Update("update tstudent set status = 3 where id=#{id}")
	Integer updateStudent(Integer id);
	
	
	@Select("select count(1) from tstudentExam where studentid=#{studentID} and subjectId=#{subjectId}")
	Integer getCountExam(StudentExam exam);
	
	@Insert("insert tstudentExam(studentid,insId,coachId,subjectId,pass,examtime,createtime,checkstatus,score) value(#{studentID},#{insId},#{coachId},#{subjectId},#{pass},#{examTime},#{createTime},1,#{score})")
	Integer insertExam(StudentExam exam);

	@Select("select id from tstudent where idcard=#{idcard}")
	Integer getStuId(String idcard);
}
