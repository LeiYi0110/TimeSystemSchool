package com.bjxc.school.service;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import com.bjxc.school.AppUser;
import com.bjxc.school.mapper.AppUserMapper;

@Service
public class AppUserService {

	Md5PasswordEncoder md5PasswordEncoder = new Md5PasswordEncoder();
	
	@Resource
	private AppUserMapper appUserMapper;
	
	@Value("${bjxc.user.defaultPassword}")
	private String defaultPassword;
	
	@Value("${bjxc.user.md5salt}")
	private String MD5salt;
	
	/**
	 * 创建学员用户
	 * @param userId
	 * @param mobile
	 * @param userName
	 * @param idCard
	 * @param headimg
	 * @param sex
	 * @return
	 */
	public AppUser createStudentAppUser(Integer userId,String mobile,String userName,String idCard,String headimg,Integer sex){
		System.out.println(mobile);
		Assert.notNull(mobile);
		AppUser user = null;
		if(userId != null){
			user = appUserMapper.get(userId,null);
		}else{
			user = appUserMapper.get(null, mobile);
		}
		if(user == null){
			user = new AppUser();
			String password = md5PasswordEncoder.encodePassword(mobile+defaultPassword,MD5salt);
			user.setPassword(password);
			user.setMobile(mobile);
			user.setRole(new Integer(1));
		}
		user.setHeadimg(headimg);
		user.setIdCard(idCard);
		user.setSex(sex);
		user.setStatus(new Integer(1));
		user.setUserName(userName);
		if(user.getId() != null){
			appUserMapper.update(user);
		}else{
			appUserMapper.addUser(user);
		}
		return user;
	}
	
	/**
	 * 创建教练用户
	 * @param userId
	 * @param mobile
	 * @param userName
	 * @param idCard
	 * @param headimg
	 * @param sex
	 * @return
	 */
	public AppUser createCoachAppUser(Integer userId,String mobile,String userName,String idCard,String headimg,Integer sex){
		Assert.notNull(mobile);
		AppUser user = null;
		if(userId != null){
			user = appUserMapper.get(userId,null);
		}else{
			user = appUserMapper.get(null, mobile);
		}
		if(user == null){
			user = new AppUser();
			String password = md5PasswordEncoder.encodePassword(mobile+defaultPassword,MD5salt);
			user.setPassword(password);
			user.setMobile(mobile);
			user.setRole(new Integer(2));
		}
		user.setHeadimg(headimg);
		user.setIdCard(idCard);
		user.setSex(sex);
		user.setStatus(new Integer(1));
		user.setUserName(userName);
		if(user.getId() != null){
			appUserMapper.update(user);
		}else{
			appUserMapper.addUser(user);
		}
		return user;
	}
}
