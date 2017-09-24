package com.bjxc.school.mapper;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.bjxc.school.SchedulingTheory;
import com.bjxc.school.TheoryReportInfo;

/**  
* @author huangjr  
* @date 2016年12月5日  创建  
*/
public interface SchedulingTheoryMapper {
	/**
	 * 理论课上报
	 * @param stationId
	 * @param start
	 * @param size
	 * @return
	 */
	List<SchedulingTheory> reportList(@Param("stationId")Integer stationId,@Param("start")Integer start,@Param("size")Integer size);
	
	Integer reportTotal(@Param("stationId")Integer stationId);
	
	/**
	 * 理论课排班
	 * @param stationId
	 * @param start
	 * @param size
	 * @return
	 */
	List<SchedulingTheory> schedulingList(@Param("stationId")Integer stationId,@Param("start")Integer start,@Param("size")Integer size);
	
	Integer schedulingTotal(@Param("stationId")Integer stationId);
	
	/**
	 * 理论排班排班记录
	 * @param stationId
	 * @param start
	 * @param size
	 * @return
	 */
	List<SchedulingTheory> recordList(@Param("classDate")String classDate,@Param("stationId")Integer stationId,@Param("start")Integer start,@Param("size")Integer size);
	
	Integer recordTotal(@Param("classDate")String classDate,@Param("stationId")Integer stationId);
	
	/**
	 * 理论课人数上报
	 * @param student
	 * @return
	 */
	void theoryUpdate(String[] ids);
	
	/**
	 * 理论课排班
	 * @param student
	 * @return
	 */
	void schedulingUpdate(String[] ids);
	
	/**
	 * 理论课未上报人数
	 * @param student
	 * @return
	 */
	void notReportedUpdate(String[] ids);
	
	/**
	 * 理论课排班上报日期、备注修改
	 * @param schedulingTheory
	 * @return
	 */
	void update(SchedulingTheory schedulingTheory);
	
	/**
	 * 导出教练信息
	 */
	List<SchedulingTheory> exporTrecordList(Map map);
	
	
	@Delete("delete from tcoach where id = #{id}")
	Integer delete(Integer id);
	
	/**
	 * 新增理论课上报统计信息
	 * @param coachid,stationid
	 */
	@Insert("insert into TheoryReportInfo(InsId,StationId,Createtime,RepNumber) value(#{insId},#{stationId},NOW(),#{repNumber})")
	Integer insertByTheoryReportInfo(@Param("insId")Integer insId,@Param("stationId")Integer stationId,@Param("repNumber")Integer repNumber);
	/**
	 * 查询对应的列表
	 * @param insId
	 * @param areaId
	 * @param staId
	 * @param classDate
	 * @param start
	 * @param size
	 * @return
	 */
	List<SchedulingTheory> getScheTheoryList(@Param("insId")Integer insId,@Param("areaId")Integer areaId,@Param("staId")Integer staId,
			@Param("classDate")String classDate,@Param("start")Integer start,@Param("size")Integer size);
	
	/**
	 * 查询上次上报信息
	 * @return
	 */
	@Select("select * from TheoryReportInfo where id=(select max(id) from TheoryReportInfo) and insId=#{insId} and stationId=#{stationId} ")
	TheoryReportInfo getTheoryReportInfo(@Param("insId")Integer insId,@Param("stationId")Integer stationId); 
	/**
	 * 总行数
	 * @param insId
	 * @param areaId
	 * @param staId
	 * @param classDate
	 * @return
	 */
	Integer totalTheoryNum(@Param("insId")Integer insId,@Param("areaId")Integer areaId,@Param("staId")Integer staId,
			@Param("classDate")String classDate);
	
	/**
	 * 添加理论排班记录
	 * @param coachid,stationid
	 */
	@Insert("insert into SchedulingTheory(StudentId,SubjectId,StationId,CreateTime,Status) value(#{studentId},#{subjectId},#{stationId},now(),1)")
	Integer insertSchedulingTheory(@Param("studentId")Integer studentId,@Param("subjectId")Integer subjectId,@Param("stationId")Integer stationId);
	
	/**
	 * 根据学员姓名查询信息
	 * @return
	 */
	@Select("select sche.*,stu.name as title,stu.mobile,stu.recordnum from SchedulingTheory sche left join TStudent stu on sche.StudentId=stu.id  where stu.insId=#{insId} and sche.stationId=#{stationId} and sche.Status=1 and stu.name like CONCAT(CONCAT('%',#{studentName}), '%')")
	List<SchedulingTheory> getByStudent(@Param("insId")Integer insId,@Param("stationId")Integer stationId,@Param("studentName")String studentName);
	
	/**
	 * 理论课排班学员添加
	 * @param schedulingTheory
	 * @return
	 */
	void addSchedulingStu(SchedulingTheory schedulingTheory);
}
