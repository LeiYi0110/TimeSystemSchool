package com.bjxc.school.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.bjxc.school.ServiceStation;
import com.bjxc.school.StudentCount;
import com.bjxc.school.StudentSubject;
/**
 * 学员统计
 * @author Administrator
 *
 */
public interface StudentCountMapper {
	/**
	 * 学员  在学 毕业 新增  数量统计
	 * @param start
	 * @param size
	 * @return
	 */
	List<StudentCount> getList(@Param("start_date")Date startTime,@Param("end_date")Date endTime,
			@Param("insId")Integer insId,@Param("stationId")Integer stationId,@Param("startIndex")Integer startIndex,@Param("length")Integer length);
	
	/**
	 * 学员在学科目统计
	 * @return
	 */
	List<StudentSubject> studentSubjectCount(@Param("insId")Integer insId,@Param("stationId")Integer stationId);
	/**
	 * 查询全部服务网点
	 * @return
	 */
	@Select("SELECT * FROM TServiceStation where  Status = 1")
	List<ServiceStation> getServiceStationAll();
}
