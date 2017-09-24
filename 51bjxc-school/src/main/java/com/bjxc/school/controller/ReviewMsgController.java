package com.bjxc.school.controller;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.bjxc.Result;
import com.bjxc.school.NotificationMessage;
import com.bjxc.school.service.NotificationMessageService;
import com.bjxc.school.socket.RecordChangeMsgController;
import com.bjxc.web.utils.WebUtils;

@RestController
//@RequestMapping("/socket")
public class ReviewMsgController {
	
	@Resource
	private NotificationMessageService service;
	
	@RequestMapping(value="/ReviewMsg/DrivingFiled", method=RequestMethod.POST)
	@UserControllerLog(description = "socket ReviewMsg/DrivingFiled")
	public Result DrivingFiled(ServletRequest request)
	{
		Result result = new Result();
		String inscode = WebUtils.getParameterValue(request, "inscode");
		Integer seq = Integer.parseInt(WebUtils.getParameterValue(request, "seq")) ;
		
		NotificationMessage notificationMessage = new NotificationMessage();
		
		notificationMessage.setContent("培训机构：" + inscode + " 教学区域序号：" + seq.toString() + "有审核结果");
		notificationMessage.setInscode(inscode);
		notificationMessage.setCreatetime(new Date());
		RecordChangeMsgController.notificationMessage = notificationMessage;
		RecordChangeMsgController.isSend = 1;
		
		service.addMesage(notificationMessage);
		
		return result;
	}
	
	@RequestMapping(value="/ReviewMsg/StageTrainningTime", method=RequestMethod.POST)
	@UserControllerLog(description = "socket ReviewMsg/StageTrainningTime")
	public Result StageTrainningTime(ServletRequest request)
	{
		Result result = new Result();
		String stunum = WebUtils.getParameterValue(request, "stunum");
		Integer subject = Integer.parseInt(WebUtils.getParameterValue(request, "subject")) ;
		
		
		NotificationMessage notificationMessage = new NotificationMessage();
		notificationMessage.setContent("学员编号：" + stunum + " 科目：" + subject.toString() + "有审核结果");
		notificationMessage.setInscode("5851633716061642");
		notificationMessage.setCreatetime(new Date());
		
		RecordChangeMsgController.notificationMessage = notificationMessage;
		
		RecordChangeMsgController.isSend = 1;
		
		service.addMesage(notificationMessage);
		
		return result;
	}
	

}
