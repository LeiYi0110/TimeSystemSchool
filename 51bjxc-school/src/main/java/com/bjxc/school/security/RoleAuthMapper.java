package com.bjxc.school.security;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

public interface RoleAuthMapper {
	
	@Select("select roleId, operationItemId, itemName as operationItemName from troleauth inner join toperationitem on troleauth.operationItemId = toperationitem.id where isMenu = 1 and roleId = #{roleId}")
	List<RoleAuth> getRoleAuthList(@Param("roleId")Integer roleId);
	

}
