package com.bjxc.school.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bjxc.school.ServiceStation;

public interface ServiceStationMapper {
	/**
	 * 搜索栏
	 * @return 
	 */
	List<ServiceStation> list(@Param("insId")Integer insId,@Param("searchText")String searchText,@Param("start")Integer start,@Param("size")Integer size);
	
	Integer countStation(@Param("insId")Integer insId,@Param("searchText")String searchText);
	
	/**
	 * 根据地点查询服务网点（通用）
	 */
	@Select("select * from TServiceStation where areaId=#{id} and insid=#{insId} and status=1")
	List<ServiceStation> findByArea(@Param("id")Integer id,@Param("insId")Integer insId);
	
	/**
	 * 根据服务网点查询地点（通用）
	 */
	@Select("select * from TServiceStation where InsId = #{insId} and id= #{id} and status=1")
	ServiceStation findStationArea(@Param("id")Integer id,@Param("insId")Integer insId);
	
	/**
	 * 增加服务网点
	 * @return 
	 */
	void add(ServiceStation serviceStation);
	
	/**
	 * 停用服务网点
	 * @return 
	 */
	
	Integer delete(@Param("id")Integer id);
	
	/**
	 * 根据(id)查询服务网点
	 * @return 
	 */
	@Select("select * from TServiceStation where id = #{id}")
	ServiceStation get(Integer id);
	
	/**
	 * 修改服务网点
	 * @return 
	 */
	Integer update(ServiceStation serviceStation);
	
	ServiceStation dotdelete(@Param("id")Integer id,@Param("insId")Integer insId);
	
	/**
	 * 根据机构号查询网点
	 * @param insId
	 * @return
	 * 
	 */
	@Select("select ID,`Name` from TServiceStation where InsId = #{insId} and status=1")
	List<ServiceStation> getStationsByInsId(@Param("insId")Integer insId);
	
}
