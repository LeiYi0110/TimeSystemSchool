package com.bjxc.school.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bjxc.school.Complaint;
import com.bjxc.school.InstitutionInfo;


/**
 * 培训机构信息
 * @author hjr
 *
 */
public interface InstitutionInfoMapper {
	/**
	 * 培训机构信息
	 */
	void add(InstitutionInfo institutionInfo);
	/**
	 * 根据机构统一编号查询
	 * @param insId
	 * @return
	 */
	@Select("select id from TInstitution where Inscode=#{insId}")
	Integer getInsId(@Param("insId")String insId);
	
	@Select("select count(1) from TInstitution where Inscode=#{inscode}")
	Integer getCountIns(String inscode);
	/**
	 * 得到概况
	 * @param map
	 * @return
	 */
	void getGeneralSituation(Map map);
	
	void addByExcel(InstitutionInfo institutionInfo);
	
	InstitutionInfo get(Integer insId);
	
	/**
	 * 修改培训机构信息
	 * @return 
	 */
	Integer update(InstitutionInfo institutionInfo);
	
	/**
	 * 搜索栏
	 * @return 
	 */
	List<InstitutionInfo> pageList(@Param("searchText")String searchText,@Param("start")Integer start,@Param("size")Integer size);
	
	@Select("select * from tinstitution")
	List<InstitutionInfo> getAll();
	/**
	 * 根据条件查询总记录条数             
	 * @param searchText
	 * @return
	 */
	Integer total(@Param("searchText")String searchText);
	
	/**
	 * 省备案
	 * @param id
	 */
	@Update("UPDATE `TInstitution` SET `isProvince`=1 WHERE (`ID`=#{id});")
	void updateProvinceStatus(@Param("id")Integer id);
	
	@Select("select * from tinstitution where name=#{insName}")
	InstitutionInfo getIns(@Param("insName")String insName);
}
