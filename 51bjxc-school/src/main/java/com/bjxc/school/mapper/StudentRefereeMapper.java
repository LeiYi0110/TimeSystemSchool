package com.bjxc.school.mapper;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bjxc.school.StudentReferee;
import com.bjxc.school.StudentRefereeInfo;

public interface StudentRefereeMapper {
	List<StudentReferee> list(Map map);
	
	Integer total(Map map);
	
	/**
	 * 报名已经处理
	 */
	@Update("update TStudentReferee set status=1 where id=#{id}")
	Integer update(Integer id);
	
	/**
	 * 查询
	 */
	@Select("select * from TStudentReferee where id=#{id}")
	StudentReferee get(Integer id);
	
	@Update("update TStudentReferee set refereeName=#{refereeName},refereeMobile=#{refereeMobile} where userId=#{id}")
	Integer updateName(@Param("refereeName")String refereeName,@Param("refereeMobile")String refereeMobile,@Param("id")Integer id);
	
	/**
	 * 创建报名信息
	 * @param studentReferee
	 * @return
	 */
	Integer insert(StudentReferee studentReferee);
	
	/**
	 * 获取学员的报名信息
	 * @param startTime
	 * @param endTime
	 * @param searchText
	 * @return
	 */
	List<StudentRefereeInfo> StudentRefereeList(@Param("insId") Integer insId, @Param("stationId") Integer stationId,
			@Param("startTime") Date startTime, @Param("endTime") Date endTime, @Param("searchText") String searchText,
			@Param("startIndex") Integer startIndex, @Param("pageSize") Integer pageSize);

	Integer StudentRefereeTotal(@Param("insId") Integer insId, @Param("stationId") Integer stationId,
			@Param("startTime") Date startTime, @Param("endTime") Date endTime, @Param("searchText") String searchText);

	
	StudentReferee getByUserId(@Param("userId")int userId);
	
}
