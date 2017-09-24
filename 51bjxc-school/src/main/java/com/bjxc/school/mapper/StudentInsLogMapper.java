package com.bjxc.school.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.bjxc.school.StudentInsLog;

public interface StudentInsLogMapper {

	@Insert("insert into TStudentInsLog(StudentID,InsId,Content,Category,CreateTime)value(#{studentID},#{insId},#{content},#{category},now())")
	void add(StudentInsLog studentInsLong);

	@Select("select l.*,s.name studentName from TStudentInsLog l left join tstudent s on l.studentId = s.id where l.studentId = #{studentId}")
	List<StudentInsLog> list(Integer studentId);
	
	List<StudentInsLog> getList(@Param("search")String search);
	
	Integer addHasTime(StudentInsLog studentInsLong);
	
}
