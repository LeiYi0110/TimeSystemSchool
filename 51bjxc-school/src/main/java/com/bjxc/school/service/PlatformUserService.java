package com.bjxc.school.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bjxc.Page;
import com.bjxc.school.PlatformUser;
import com.bjxc.school.PlatformUserAuth;
import com.bjxc.school.PlatformUserParam;
import com.bjxc.school.mapper.PlatformUserMapper;

@Service
public class PlatformUserService {
	@Resource
	private PlatformUserMapper platformUserMapper;
	@Resource
	private OperationItemService operationItemService;
	
	public Page<PlatformUser> list(String searchText,Integer insId,Integer stationId,Integer pageIndex,Integer pageSize){
		Page<PlatformUser> page=new Page<PlatformUser>(pageIndex,pageSize); 
		Integer totalCount=platformUserMapper.countUser(searchText, insId, stationId);
		page.setRowCount(totalCount);
		if(totalCount > 0){
			List<PlatformUser> datas=platformUserMapper.list(searchText, insId, stationId,page.getStartRow(),page.getPageSize());
			page.setData(datas);
		}
		return page;
	}
	
	/**
	 * @param id
	 * @param use 1使用0停用
	 */
	public void updateUse(Integer id,Integer use){
		if(use == 0){
			platformUserMapper.updateUse(id);
		}else if (use == 1) {
			platformUserMapper.updateUse2(id);
		}
		
	}
	
	@Transactional
	public void updateUser(PlatformUserParam user){
		platformUserMapper.update(user);
		
		List<Integer> authIds = Arrays.asList(user.getAuthIds().split(",")).stream()
				.filter(f -> !StringUtils.isBlank(f)).map(a -> Integer.valueOf(a)).collect(Collectors.toList());
		List<PlatformUserAuth> platformUserAuths = new ArrayList<>();
		authIds.stream().forEach(a -> {
			PlatformUserAuth platformUserAuth = new PlatformUserAuth();
			platformUserAuth.setPlatformUserId(user.getId());
			platformUserAuth.setOperationItemId(a);
			platformUserAuths.add(platformUserAuth);
		});
		
		operationItemService.updatePlatformUserAuth(platformUserAuths, user.getId());
	}
	/**
	 * 创建网点账号
	 * @param user
	 */
	@Transactional
	public void insertUser(PlatformUserParam user){
		List<Integer> authIds = Arrays.asList(user.getAuthIds().split(",")).stream()
				.filter(f -> !StringUtils.isBlank(f)).map(a -> Integer.valueOf(a)).collect(Collectors.toList());
		platformUserMapper.insert(user);
		
		List<PlatformUserAuth> platformUserAuths = new ArrayList<>();
		authIds.stream().forEach(a -> {
			PlatformUserAuth platformUserAuth = new PlatformUserAuth();
			platformUserAuth.setPlatformUserId(user.getId());
			platformUserAuth.setOperationItemId(a);
			platformUserAuths.add(platformUserAuth);
		});
		
		operationItemService.updatePlatformUserAuth(platformUserAuths, user.getId());
		
	}
	
	public PlatformUser userInfo(Integer id){
		return platformUserMapper.get(id);
	}
	public PlatformUser getPlatformUser(Integer id){
		return platformUserMapper.getPlatformuser(id);
	}
	/**
	 * 导出所有用户管理信息
	 * @return
	 */
	public List<PlatformUser> exceporPlatformUser(){
		return platformUserMapper.platformUserList();
	}
	
	public void updateUserInfo(PlatformUser user){
		platformUserMapper.updatePassword(user);
	}
	
	public void updatepwd(PlatformUser user){
		platformUserMapper.updatepwd(user);
	}
}
