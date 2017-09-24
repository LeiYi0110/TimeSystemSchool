package com.bjxc.school.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.bjxc.school.StudentRecording;

public interface StudentRecordingMapper {
	
	/**
	 * 学员学车记录
	 * @param studentId
	 * @return
	 */
	@Select("SELECT sd.name studentName,sri.day day,tc.name coachName,sri.time time,sb.name subjectName FROM  TStudentReserve sr LEFT JOIN TStudentReserveInfo sri on sr.id = sri.reserveId LEFT JOIN tstudent sd ON sd.id = sr.studentId LEFT JOIN TCoach tc ON tc.id = sr.coachId LEFT JOIN tsubject sb ON sb.ID = sr.subjectId where sd.id = #{studentId} and sri.status != -1 ORDER BY sri.day DESC,sri.time asc")
	List<StudentRecording> getAllStudentRecording(Integer studentId);
	
}
