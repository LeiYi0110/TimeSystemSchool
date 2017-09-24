package com.bjxc.school.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.bjxc.school.Complaint;
import com.bjxc.school.Examiner;


public interface ComplaintMapper {
	/**
	 * 搜索栏
	 * @return 
	 */
	List<Complaint> pageList(@Param("type") Integer type, @Param("searchText") String searchText,
			@Param("insId")Integer insId , @Param("stationId")Integer stationId,
			@Param("startTime")Date startTime , @Param("endTime")Date endTime,
			@Param("start") Integer start, @Param("size") Integer size);

	Integer pageListTotal(@Param("type") Integer type, @Param("searchText") String searchText,
			@Param("insId")Integer insId , @Param("stationId")Integer stationId,
			@Param("startTime")Date startTime , @Param("endTime")Date endTime);
	
	Integer total(@Param("searchText")String searchText);
	
	@Select("select co.*,coa.Name as CoachName,ins.Name as InstitutionName,stu.name as studentName,stu.stunum,coa.Coachnum as coachnum from tcomplaint co left join TCoach coa on co.objectId = coa.id left join TInstitution ins on co.objectId = ins.id left join TStudent stu on stu.id=co.studentId where co.id=#{id}")
	Complaint get(Integer id);
	
	/**
	 * 增加安全员信息
	 * @return 
	 */
	void add(Complaint complaint);
	
	/**
	 * 修改安全员信息状态
	 * @return 
	 */
	Integer update(Complaint complaint);
	
	/**
	 * 查询所有考核员
	 * @return
	 */
	List<Complaint> tcomplaintList(@Param("type")Integer type);
	
	
	void udpatedriving(Complaint complaint);
	
}
