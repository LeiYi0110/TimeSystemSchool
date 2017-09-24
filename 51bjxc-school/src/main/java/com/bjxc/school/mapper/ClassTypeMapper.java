package com.bjxc.school.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bjxc.school.ClassType;
import com.bjxc.school.DrivingField;

public interface ClassTypeMapper {

	/**
	 * 搜索栏
	 * @return 
	 */
	List<ClassType> list(@Param("insId")Integer insId,@Param("searchText")String searchText);
	             
	
	/**
	 * 增加班型信息
	 * @return 
	 */
	void add(ClassType drivingField);
	
	/**
	 * 删除班型信息
	 * @return 
	 */
	@Delete("delete from TClassType where id = #{id}")
	Integer delete(Integer id);
	
	/**
	 * 停用班型信息
	 * @return 
	 */
	/*@Delete("update TClassType set Status = #{status} where id = #{id}")*/
	@Delete("delete from TClassType where id = #{id}")
	Integer updateClassTypeStatus(@Param("id")Integer id,@Param("status")Integer status);
	
	/**
	 * 根据(id)查询班型信息
	 * @return 
	 */
	@Select("select * from  TClassType where id = #{id}")
	ClassType get(Integer id);
	
	/**
	 * 修改班型信息
	 * @return 
	 */
	Integer update(ClassType drivingField);
	//获取所有班型
	List<ClassType> getList(@Param("insId")Integer insId);
	
	ClassType Incrementselect(@Param("insId")Integer insId);
	
	@Update("update TClassType set isProvince = #{isProvince} where id = #{id}")
	void updateBeiAn(ClassType type);
}
