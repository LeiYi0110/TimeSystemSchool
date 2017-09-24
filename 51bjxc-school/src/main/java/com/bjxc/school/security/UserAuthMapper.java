package com.bjxc.school.security;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

public interface UserAuthMapper {
	
	@Select("select platformUserId, operationItemId, itemName as operationItemName from tplatformuserauth inner join toperationitem on tplatformuserauth.operationItemId = toperationitem.id where isMenu = 0 and platformUserId = #{platformUserId}")
	List<UserAuth> getPlatformUserAuthList(@Param("platformUserId")Integer platformUserId);

}
