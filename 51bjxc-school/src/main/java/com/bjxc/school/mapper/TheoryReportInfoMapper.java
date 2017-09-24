package com.bjxc.school.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.bjxc.school.SchedulingTheory;
import com.bjxc.school.ServiceStation;
import com.bjxc.school.TheoryReportInfo;
import com.bjxc.school.Tteacharea;

/**  
* @author huangjr  
* @date 2016年12月3日  创建  
*/
public interface TheoryReportInfoMapper {
	
	/**
	 * 理论课的行
	 * @return
	 */
	List<TheoryReportInfo> getCourseList(@Param("insId")Integer insId,@Param("areaId")Integer areaId,@Param("beginCreateTiStr")String beginCreateTiStr,@Param("endCreateTiStr")String endCreateTiStr,@Param("start")Integer start,@Param("size")Integer size);
	
	/**
	 * 得到总行数
	 * @param insId
	 * @param areaId
	 * @return
	 */
	Integer getSumNum(@Param("insId")Integer insId,@Param("areaId")Integer areaId,@Param("beginCreateTiStr")String beginCreateTiStr,@Param("endCreateTiStr")String endCreateTiStr);
	
	/**
	 * 得到理论课总条数
	 * @param insId
	 * @return
	 */
	Integer totalCourseNum(@Param("insId")Integer insId,@Param("areaId")Integer areaId,@Param("beginCreateTiStr")String beginCreateTiStr,@Param("endCreateTiStr")String endCreateTiStr);
	
	@Select("select id,`name` from Tteacharea where insId=#{insId}")
	List<Tteacharea> getAreas(@Param("insId")Integer insId);
	
	@Select("select id,`name` from tservicestation where insId=#{insId}")
	List<ServiceStation> getStations(@Param("insId")Integer insId);
	
	List<ServiceStation> getStationByAreaId(@Param("insId")Integer insId,@Param("areaId")Integer areaId);
	
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
			@Param("classDate")Date classDate,@Param("start")Integer start,@Param("size")Integer size);
}
