package com.bjxc.school.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.print.attribute.ResolutionSyntax;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.bjxc.Page;
import com.bjxc.Result;
import com.bjxc.school.NotificationMessage;
import com.bjxc.school.service.NotificationMessageService;

@RestController
@RequestMapping(value="/notificationMsg")
public class NotificationMessageController {
	
	@Resource
	private NotificationMessageService service;
	@RequestMapping(value="/list",method=RequestMethod.GET)
	@UserControllerLog(description = "消息通知控制")    
	public Result list()
	{
		Result result = new Result();
		
		//List<NotificationMessage> list = service.list();
		Page<NotificationMessage> page = service.list();
		//result.setData(result);
		result.success(page.getData());
		result.put("rowCount", page.getRowCount());
		return result;
		
	}

}
