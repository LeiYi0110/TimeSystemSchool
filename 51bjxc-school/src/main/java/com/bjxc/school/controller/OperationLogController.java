package com.bjxc.school.controller;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bjxc.Result;
import com.bjxc.school.ClassType;
import com.bjxc.school.OperationLog;
import com.bjxc.school.service.OperationLogService;
import com.bjxc.web.utils.WebUtils;

/**
 * 操作日志
 * @author John
 *
 */

@RestController
@RequestMapping(value="/operationLog")
public class OperationLogController {
	private static final Logger logger = LoggerFactory.getLogger(ClassTypeController.class);
	
	@Resource
	private OperationLogService operationLogService;
	
	@RequestMapping(value="/list",method=RequestMethod.GET)
	@UserControllerLog(description = "操作日志列表")    
	public Result list(@RequestParam(value="insId", required=true)Integer insId,@RequestParam(value="searchText", required=false)String searchText){
		Result result = new Result();
		try {
			List<OperationLog> datas = operationLogService.list(insId,searchText);
			result.success(datas);
		} catch (Exception e) {
			logger.error("operationLog field list",e);
			result.error(e);
		}
		return result;
	}
	
	@RequestMapping(value="/add",method=RequestMethod.POST)
	@UserControllerLog(description = "操作日志添加")    
	public Result get(HttpServletRequest request){
		Result result = new Result();
		try {
			Date logTime = new Date();
			String logEvent = WebUtils.getParameterValue(request, "logEvent");
			String logUser = WebUtils.getParameterValue(request, "logUser");
			Integer insId = WebUtils.getParameterIntegerValue(request, "insId");
			String remark = WebUtils.getParameterValue(request, "remark");
			OperationLog operationLog = new OperationLog();
			operationLog.setRemark(remark);
			operationLog.setLogEvent(logEvent);
			operationLog.setLogUser(logUser);
			operationLog.setInsId(insId);
			operationLog.setLogTime(logTime);
			operationLogService.add(operationLog);
			result.success();
		} catch (Exception e) {
			logger.error("operationLog field add ",e);
			result.error(e);
		}
		return result;
	}
}
