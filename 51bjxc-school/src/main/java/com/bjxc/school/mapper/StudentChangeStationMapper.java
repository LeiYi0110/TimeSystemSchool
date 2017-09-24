package com.bjxc.school.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bjxc.school.StudentChangeStation;
/**
 * 学员转点
 * @author Administrator
 *
 */
public interface StudentChangeStationMapper {
	
	List<StudentChangeStation> list(@Param("insId")Integer insId,@Param("stationId")Integer stationId,@Param("status")Integer status,@Param("startTime")Date startTime,@Param("endTime")Date endTime);
	
	/**
	 * 提交转店申请
	 * @param studentChangeStation
	 */
	void add(StudentChangeStation studentChangeStation);
	
	/**
	 * 转店审核
	 * @param id
	 * @param status
	 */
	@Update("update tStudentChangeStation set status = #{status} where id = #{id}")
	void update(@Param("id")Integer id,@Param("status")Integer status);
	
	@Select("select * from tStudentChangeStation where id = #{id}")
	StudentChangeStation get(@Param("id")Integer id);
	
}
