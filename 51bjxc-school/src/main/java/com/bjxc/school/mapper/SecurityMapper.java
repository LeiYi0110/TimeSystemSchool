package com.bjxc.school.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bjxc.school.Security;


public interface SecurityMapper {
	/**
	 * 搜索栏
	 * @return 
	 */
	List<Security> pageList(@Param("insId")Integer insId,@Param("searchText")String searchText,@Param("start")Integer start,@Param("size")Integer size);
	             
	Integer total(@Param("insId")Integer insId,@Param("searchText")String searchText);
	
	@Select("select id,insId,name,sex,idcard,mobile,address,photo,fingerprint,drilicence,fstdrilicdate,dripermitted,teachpermitted,employstatus,hiredate,leavedate,secunum,photoUrl,isProvince,isCountry from tsecurity where id=#{id}")
	Security get(Integer id);
	
	/**
	 * 增加安全员信息
	 * @return 
	 */
	void add(Security security);
	/**
	 * 判断是否有该安全员编号的安全员
	 * @param insId
	 * @param secunum
	 * @return
	 */
	@Select("select id,insId,name,sex,idcard,mobile,address,photo,fingerprint,drilicence,fstdrilicdate,dripermitted,teachpermitted,employstatus,hiredate,leavedate,secunum,photoUrl "
			+ "from tsecurity where insId=#{insId} and idcard=#{idcard}")
	Security getByIdCard(@Param("insId")Integer insId,@Param("idcard")String idcard);
	
	/**
	 * 修改安全员信息状态
	 * @return 
	 */
	Integer update(Security security);
	
	/**
	 * 查询安全员信息
	 */
	List<Security> securityList(@Param("insId")Integer insId);
	
	void updatestatus(Security security);
	
	@Update("update tsecurity set isProvince=0 where secunum=#{secunum}")
	Integer updateIsprovince(String secunum);
}
