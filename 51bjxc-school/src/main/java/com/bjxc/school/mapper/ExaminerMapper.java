package com.bjxc.school.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bjxc.school.Examiner;


public interface ExaminerMapper {
	/**
	 * 搜索栏
	 * @return 
	 */
	List<Examiner> pageList(@Param("insId")Integer insId,@Param("searchText")String searchText,@Param("start")Integer start,@Param("size")Integer size);
	             
	Integer total(@Param("insId")Integer insId,@Param("searchText")String searchText);
	
	@Select("select id,insId,name,sex,idcard,mobile,address,photo,fingerprint,drilicence,fstdrilicdate,dripermitted,teachpermitted,employstatus,hiredate,leavedate,occupationno,occupationlevel,photourl,examnum,isCountry,isProvince from texaminer where id=#{id}")
	Examiner get(Integer id);
	
	/**
	 * 增加考核员信息
	 * @return 
	 */
	void add(Examiner examiner);
	
	/**
	 * 根据身份证号查询考核员信息
	 * @param insId
	 * @param idcard
	 * @return
	 */
	@Select("select id,insId,name,sex,idcard,mobile,address,photo,fingerprint,drilicence,fstdrilicdate,dripermitted,teachpermitted,employstatus,hiredate,leavedate,occupationno,occupationlevel,photourl,examnum from texaminer"
			+ " where insId=#{insId} and idcard=#{idcard}")
	Examiner getByIdcard(@Param("insId")Integer insId,@Param("idcard")String idcard);
	
	/**
	 * 修改考核员信息状态
	 * @return 
	 */
	Integer update(Examiner examiner);
	
	/**
	 * 查询所有考核员
	 * @return
	 */
	List<Examiner> examinerList(@Param("insId")Integer insId);
	
	void updatestutas(Examiner examiner);
	
	@Update("update texaminer set isProvince=0 where examnum=#{examNum}")
	Integer updateIsprovince(String examNum);
}
