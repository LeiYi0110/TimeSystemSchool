package com.bjxc.school.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bjxc.school.PlatformUserAuth;

public interface PlatformUserAuthMapper {
	
	/**
	 * 给用户给定按钮授权
	 * @param list
	 * @return
	 */
	public Integer add(List<PlatformUserAuth> list);
	
	/**
	 * 删除用户按钮授权
	 * @param platformUserId
	 * @return
	 */
	public Integer delete(@Param("platformUserId") Integer platformUserId);
	
	/**
	 * 获取按钮授权
	 * @param platformUserId
	 * @return
	 */
	public List<PlatformUserAuth> getByPlatformUserId(@Param("platformUserId") Integer platformUserId);
	
}
