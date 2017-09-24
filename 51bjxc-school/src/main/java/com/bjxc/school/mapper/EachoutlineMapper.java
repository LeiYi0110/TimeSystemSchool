package com.bjxc.school.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.bjxc.school.Eachoutline;


public interface EachoutlineMapper {
	/**
	 * 搜索栏
	 * @return 
	 */
	List<Eachoutline> pageList(@Param("cartype")String cartype,@Param("start")Integer start,@Param("size")Integer size);
	             
	Integer total(@Param("cartype")String cartype);
	
	@Select("select id,cartype,subjectId,courseNum from teachoutline where id=#{id}")
	Eachoutline get(Integer id);
	
	/**
	 * 增加安全员信息
	 * @return 
	 */
	void add(Eachoutline eachoutline);
	
	/**
	 * 修改安全员信息状态
	 * @return 
	 */
	Integer update(Eachoutline eachoutline);
}
