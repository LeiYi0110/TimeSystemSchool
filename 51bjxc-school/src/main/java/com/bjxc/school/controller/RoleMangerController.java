package com.bjxc.school.controller;


import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.varia.FallbackErrorHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bjxc.Result;
import com.bjxc.school.PlatformUserAuth;
import com.bjxc.school.RoleAuth;
import com.bjxc.school.security.UsinInfo;
import com.bjxc.school.service.OperationItemService;

@Controller
@RequestMapping(value = "/roleManger")
public class RoleMangerController {
	private static final Logger logger = LoggerFactory.getLogger(RoleMangerController.class);
	
	@Resource
	private OperationItemService operationItemService; 
	
	/**
	 * 角色授权列表
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/authlist")
	@UserControllerLog(description = "角色授权列表")
	public Result authlist(){
		
		
		
		return new Result();
	}
	
	@ResponseBody
	@RequestMapping(value = "/upateRoleAuth", method = RequestMethod.POST)
	@UserControllerLog(description = "角色授权 修改")
	public Result upateRoleAuth(@RequestParam("authIds") String authIds,
			@RequestParam(value = "role", defaultValue = "3", required = false) Integer role) {
		Result result = new Result();

		try {
			List<RoleAuth> list = new ArrayList<>();
			List<Integer> authIdArrays = Arrays.asList(authIds.split(",")).stream().filter(f -> !StringUtils.isBlank(f))
					.map(a -> Integer.valueOf(a)).collect(Collectors.toList());
			for (Integer item : authIdArrays) {
				RoleAuth roleAuth = new RoleAuth();
				roleAuth.setOperationItemId(item);
				roleAuth.setRoleId(role);
				list.add(roleAuth);
			}
			operationItemService.updateRoleAuth(list, role);
			result.success();

		} catch (Exception exception) {
			logger.error(exception.toString());
			result.error("保存失败");
		}

		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/getPlatformUserAuth", method = RequestMethod.POST)
	@UserControllerLog(description = "获取角色授权")
	public Result getPlatformUserAuth(@RequestParam("platformUserId") Integer platformUserId) {
		Result result = new Result();

		try {
			List<PlatformUserAuth> platformUserAuths = operationItemService
					.getPlatformUserAuthByPlatformUserId(platformUserId);
			result.success(platformUserAuths);

		} catch (Exception exception) {
			logger.error(exception.toString());
			result.error("获取失败");
		}

		return result;
	}

	@ResponseBody
	@RequestMapping(value = "/roleAuth/{role}", method = RequestMethod.GET)
	@UserControllerLog(description = "获取角色授权列表")
	public Result getRoleAuth(@PathVariable(value = "role") Integer role) {
		Result result = new Result();

		try {
			List<RoleAuth> roleAuths = operationItemService.getRoleAuth(role);
			result.success(roleAuths);
		} catch (Exception exception) {
			logger.error(exception.toString());
			result.error("获取失败");
		}

		return result;
	}
}
