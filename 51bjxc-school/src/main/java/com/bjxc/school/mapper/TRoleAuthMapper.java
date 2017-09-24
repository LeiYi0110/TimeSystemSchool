package com.bjxc.school.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bjxc.school.RoleAuth;

public interface TRoleAuthMapper {

	/**
	 * 获取角色所持有的菜单权限
	 * 
	 * @param roleId
	 * @return
	 */
	List<RoleAuth> getRoleAuth(@Param("roleId") int roleId);

	/**
	 * 给角色授权菜单
	 * 
	 * @param list
	 * @return
	 */
	Integer add(List<RoleAuth> list);

	/**
	 * 删除角色授权菜单
	 * 
	 * @param list
	 * @return
	 */
	Integer delete(List<RoleAuth> list);

	/**
	 * 删除角色的菜单授权
	 * 
	 * @param roleId
	 * @return
	 */
	Integer deleteByRoleId(@Param("roleId") int roleId);
}
