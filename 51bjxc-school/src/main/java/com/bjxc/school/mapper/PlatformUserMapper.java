package com.bjxc.school.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bjxc.school.PlatformUser;

public interface PlatformUserMapper {
	List<PlatformUser> list(@Param("searchText")String searchText,@Param("insId")Integer insId,@Param("stationId")Integer stationId,@Param("start")Integer start,@Param("size")Integer size);
	
	Integer countUser(@Param("searchText")String searchText,@Param("insId")Integer insId,@Param("stationId")Integer stationId);
	
	/**
	 * 停用帐号
	 * @return
	 */
	@Update("update tplatformuser set Status=0 where id=#{id}")
	Integer updateUse(Integer id);
	
	/**
	 * 恢复帐号
	 * @return
	 */
	@Update("update tplatformuser set Status=1 where id=#{id}")
	Integer updateUse2(Integer id);
	
	/**
	 * 修改帐号
	 * @return
	 */
	Integer update(PlatformUser user);
	
	/*@Insert("insert into tplatformuser(insId,stationId,mobile,password,userName,status,urole,createtime,Headimg,areaId,DrivingfiledId) value(#{insId},#{stationId},#{mobile},#{password},#{userName},1,#{urole},now(),#{headImg},#{areaId},#{drivingfiledId})")*/
	Integer insert(PlatformUser user);
	
	@Select("select * from tplatformuser where id=#{id}")
	PlatformUser get(Integer id);
	
	@Select("select * from tplatformuser where id=#{id}")
	PlatformUser getPlatformuser(Integer id);
	
	/**
	 * 查询所有用户管理信息
	 * @return
	 */
	List<PlatformUser> platformUserList();
	
	/**
	 * 修改用户密码或电话
	 * @return
	 */
	Integer updatePassword(PlatformUser user);
	
	void updatepwd(PlatformUser user);
}
