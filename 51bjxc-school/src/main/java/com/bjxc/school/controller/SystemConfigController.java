package com.bjxc.school.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.bjxc.Result;
import com.bjxc.school.SystemConfig;
import com.bjxc.school.service.SystemConfigService;
import com.bjxc.web.utils.WebUtils;

/**
 * 系统配置
 * @author levin
 */

@RestController
@RequestMapping(value="/systemconfig")
public class SystemConfigController {
	
	private static final Logger logger = LoggerFactory.getLogger(SystemConfigController.class);

	@Resource
	private SystemConfigService systemConfigService;
	
	@RequestMapping(value="/getlist",method=RequestMethod.GET)
	@UserControllerLog(description = "获取配置参数列表")    
	public Result getList(@RequestParam(value="Inscode", required=true)String Inscode){
		Result result = new Result();
		try {
			List<SystemConfig> data = systemConfigService.getSystemConfigListByInscode(Inscode);
			//List<SystemConfig> data = systemConfigService.getSystemConfigList();
			result.success(data);
		} catch (Exception e) {
			logger.error("getSystemConfigListByInscode error.",e);
			result.error(e);
		}
		
		//Integer AutoCheckRecord = HTTPMap.getInstance().getSystemConfigMap().get(Inscode+SystemConfigService.AutoCheckRecord);
		//System.out.println(AutoCheckRecord);

		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	@UserControllerLog(description = "获取单个配置参数")    
	public Result getOne(@PathVariable Integer id) {
		Result result = new Result();
		try {
			SystemConfig one = systemConfigService.getSystemConfigById(id);
			result.success(one);
		} catch (Exception e) {
			logger.error("systemconfig one search", e);
			result.error(e);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@UserControllerLog(description = "更新配置参数")    
	public Result saveOrUpdate(HttpServletRequest request) {
		Result result = new Result();
		Integer id = WebUtils.getParameterIntegerValue(request, "id");
		String inscode = WebUtils.getParameterValue(request, "Inscode");
		String flagName = WebUtils.getParameterValue(request, "flagName");
		String flagValue = WebUtils.getParameterValue(request, "flagValue");
		
		SystemConfig systemConfig = new SystemConfig();
		systemConfig.setId(id);
		systemConfig.setFlagName(flagName);
		systemConfig.setFlagValue(flagValue);
		systemConfig.setInscode(inscode);
		
		systemConfigService.updateSystemConfig(systemConfig);
	
		return result;
	}

}
