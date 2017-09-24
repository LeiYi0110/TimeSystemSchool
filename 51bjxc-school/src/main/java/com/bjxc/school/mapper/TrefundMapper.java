package com.bjxc.school.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.bjxc.school.Trefund;

public interface TrefundMapper {
	
	/**
	 * 审核退费申请  修改状态
	 * @param Trefund
	 * @return
	 */
	Integer updateTrefund(@Param("id")Integer id,@Param("status")Integer status,@Param("userNote")String userNote,@Param("reviewUser")Integer reviewUser);
	
	@Select("select status from Trefund where id=#{id}")
	Integer getTrefundstatus(@Param("id")Integer id);
	/**
	 * 查询退费申请
	 * @param stationId
	 * @param start
	 * @param size
	 * @return
	 */
	List<Trefund> getTrefund(@Param("insId")Integer insId,@Param("stationId")Integer stationId,@Param("status")Integer status,@Param("time1")String time1,@Param("time2")String time2,@Param("start")Integer start,@Param("size")Integer size);
	
	
	Integer total(@Param("insId")Integer insId,@Param("stationId")Integer stationId,@Param("status")Integer status,@Param("time1")String time1,@Param("time2")String time2);
	
}
