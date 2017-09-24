package com.bjxc.school.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bjxc.school.StudentSubject;

public interface StudentSubjectMapper {
	@Select("select st.*,su.Name subjectName,sd.name studentName,co.name coachName from TStudentSubject st  "
			+ "left join TSubject su on st.SubjectId = su.id  "
			+ "left join TStudent sd on st.StudentId = sd.id   "
			+ "left join TCoach   co on st.CoachId = co.id "
			+ "where st.studentId=#{studentId} and sd.insId =#{insId}")
	List<StudentSubject> list(@Param("insId")Integer insId,@Param("studentId")Integer studentId);
	
	/**
	 * 修改当前学习科目为已完成
	 */
	@Update("update TStudentSubject set Status = 2 ,EndTime = now()  where StudentId=#{studentId} and subjectId = #{subjectId}")
	void updateNowSubject(@Param("studentId")Integer studentId,@Param("subjectId")Integer subjectId);
	@Update("update TStudentSubject set Status = 2  where StudentId=#{studentId}")
	void updateSubject(@Param("studentId")Integer studentId);
	
	@Update("update TStudentSubject set Status = 2 ,EndTime = now()  where StudentId=#{studentId}")
	void endAllSubject(@Param("studentId")Integer studentId);
	/**
	 * 更换教练
	 * @param studentId 学员ID
	 * @param subjectId 科目ID
	 * @param coachId 教练ID
	 */
	@Update("update TStudentSubject set CoachId = #{coachId} where StudentId=#{studentId} and subjectId = #{subjectId}")
	void changeCoach(@Param("studentId")Integer studentId,@Param("subjectId")Integer subjectId,@Param("coachId")Integer coachId);
	
	/**
	 * 新增下一个科目的学习状态为进行中
	 */
	void addStudentSubject(StudentSubject studentSubject);
	
	
	void updateStudentSubject(StudentSubject studentSubject);
	
	/**
	 * 新增下一个科目的学习状态为进行中
	 */
	void addSubject(StudentSubject studentSubject);
	
	@Select("select count(*) from tStudentSubject where studentId=#{studentId} and coachId=#{coachId}")
	Integer isExistsRelationShip(@Param("studentId")Integer studentId,@Param("coachId")Integer coachId);
}
