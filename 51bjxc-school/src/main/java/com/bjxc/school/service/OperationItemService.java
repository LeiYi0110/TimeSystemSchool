package com.bjxc.school.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;

import org.aspectj.weaver.ast.Var;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bjxc.school.mapper.OperationItemMapper;
import com.bjxc.school.mapper.PlatformUserAuthMapper;
import com.bjxc.school.mapper.TRoleAuthMapper;
import com.bjxc.school.OperationItem;
import com.bjxc.school.PlatformUserAuth;
import com.bjxc.school.RoleAuth;

@Service
public class OperationItemService {

	@Resource
	private OperationItemMapper operationItemMapper;
	@Resource
	private TRoleAuthMapper troleAuthMapper;
	@Resource
	private PlatformUserAuthMapper platformUserAuthMapper;
	
	/**
	 * 获取所有1,2级菜单
	 * @return
	 */
	public List<OperationItem> getOperationItemMenuList(){
		return operationItemMapper.menuList();
	}
	
	/**
	 * 获取所有菜单按钮
	 * @return
	 */
	public List<OperationItem> getALLOperationItemList(){
		return operationItemMapper.list();
	}
	
	/**
	 * 获取角色的菜单授权
	 * @param roleId
	 * @return
	 */
	public List<RoleAuth> getRoleAuth(Integer roleId){
		return troleAuthMapper.getRoleAuth(roleId);
	}
	
	/**
	 * 更新角色菜单授权
	 * @param list
	 * @param roleId
	 * @return
	 */
	@Transactional
	public Integer updateRoleAuth(List<RoleAuth> list , Integer roleId){
		roleId = roleId == null ? 0 : roleId;
		troleAuthMapper.deleteByRoleId(roleId);
		
		for(RoleAuth item : list){
			item.setRoleId(roleId);
		}
		if(list.size() <= 0){
			return 0;
		}

		List<OperationItem> operationItems = operationItemMapper.list();
		
		List<OperationItem> one = new ArrayList<>();//一级标题
		
		list.stream().forEach(o -> {
			OperationItem pageAuth = operationItems.stream()
					.filter(f -> f.getId().equals(o.getOperationItemId())).findFirst().orElse(null);
			if(pageAuth != null){
				//一级标题
				OperationItem fathter = operationItems.stream()
						.filter(f -> f.getId().equals(pageAuth.getParentId())).findFirst().orElse(null);
				if(fathter != null && one.stream().filter(f -> f.getId().equals(fathter.getId())).count() <= 0){
					one.add(fathter);
				}
			}
		});
		
		for(OperationItem item : one){
			RoleAuth roleAuth = new RoleAuth();
			roleAuth.setOperationItemId(item.getId());
			roleAuth.setRoleId(roleId);
			
			list.add(roleAuth);
		}
		
		return troleAuthMapper.add(list);
	}
	
	/**
	 * 更新/创建 网点的按钮授权
	 * @param list
	 * @param platformUserId
	 * @return
	 */
	@Transactional
	public Integer updatePlatformUserAuth(List<PlatformUserAuth> list,Integer platformUserId){
		platformUserAuthMapper.delete(platformUserId);
		
		for(PlatformUserAuth item : list){
			item.setPlatformUserId(platformUserId);
		}
		if(list.size() <= 0){
			return 0;
		}

		return platformUserAuthMapper.add(list);
	}
	
	/**
	 * 获取用户的按钮授权
	 * @param platformUserId
	 * @return
	 */
	public List<PlatformUserAuth> getPlatformUserAuthByPlatformUserId(Integer platformUserId){
		return platformUserAuthMapper.getByPlatformUserId(platformUserId);
	}
}
