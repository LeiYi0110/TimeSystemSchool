package com.bjxc.school.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.bjxc.Result;
import com.bjxc.school.OperationLog;
import com.bjxc.school.service.OperationLogService;

/**
 * 系统配置
 * @author levin
 */

@RestController
@RequestMapping(value="/userlog")
public class UserLogController {

	private static final Logger logger = LoggerFactory.getLogger(UserLogController.class);
	
	@Resource
	private OperationLogService operationLogService;

	@RequestMapping(value="/getlist",method=RequestMethod.GET)
	public Result getList(@RequestParam(value="insId", required=true)Integer insId){
		Result result = new Result();
		logger.info("/userlog/getlist");
		//获取日志
		List<OperationLog> data = operationLogService.list(insId,null);
		result.success(data);
		return result;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public Result getList(String searchText, Integer pageIndex, Integer pageSize, Integer insId,
			HttpServletResponse response) {
		response.setCharacterEncoding("UTF-8");
		Result result = new Result();
		logger.info("/userlog/list");
		List<OperationLog> data = operationLogService.list(insId, searchText);
		result.success(data);
		return result;
	}

	
}
