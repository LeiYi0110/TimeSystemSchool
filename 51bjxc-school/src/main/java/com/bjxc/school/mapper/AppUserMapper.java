package com.bjxc.school.mapper;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;

import com.bjxc.school.AppUser;

public interface AppUserMapper {

	Integer addUser(AppUser user);

	Integer update(AppUser user);
	AppUser get(@Param("id")Integer id,@Param("mobile")String mobile);
}
