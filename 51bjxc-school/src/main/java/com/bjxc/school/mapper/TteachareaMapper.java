package com.bjxc.school.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.bjxc.school.ServiceStation;
import com.bjxc.school.Tteacharea;

public interface TteachareaMapper {
	
	


	List<Tteacharea> tteacharlist(@Param("searchText")String searchText,@Param("start")Integer start,@Param("size")Integer size,@Param("insId")Integer insId);
	
	Integer counteachar(@Param("searchText")String searchText,@Param("insId")Integer insId);
	
	Tteacharea get(Integer id);
	
	void add(Tteacharea tteacharea);
	
	void update(Tteacharea tteacharea);
	
	void disable(Tteacharea tteacharea);
	
	List<Tteacharea> selectdow(@Param("insId")Integer insId);
	/**
	 * 根据服务网点查询地点（通用）
	 */
	@Select("select t.* from TServiceStation s left join tteacharea t on  s.areaId=t.id where t.insid = #{insId} and s.id = #{id} and t.status=1")
	Tteacharea findTeachArea(@Param("id")Integer id,@Param("insId")Integer insId);
	
}
