package com.bjxc.school.controller;

import java.util.Date;
import java.util.logging.Logger;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;

import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.bjxc.Result;
import com.bjxc.school.NotificationMessage;
import com.bjxc.school.RecordChange;
import com.bjxc.school.mapper.NotificationMessageMapper;
import com.bjxc.school.service.NotificationMessageService;
import com.bjxc.school.socket.Message;
import com.bjxc.school.socket.RecordChangeMsgController;
import com.bjxc.school.socket.SocketResult;
import com.bjxc.web.utils.WebUtils;

@RestController
@RequestMapping("/socket")
public class RelationShipChangeNotificationController {
	
	@Resource
	private NotificationMessageService service;
	@RequestMapping(value="/relationshipChange", method=RequestMethod.POST)
	@UserControllerLog(description = "socket relationshipChange")
	public Result RelationShipChange(ServletRequest request)
	{
		Result result = new Result();
		
		RecordChangeMsgController.isSend = 1;

	
		
		//inscode
		String inscode = WebUtils.getParameterValue(request, "inscode");
		Integer changeType = Integer.parseInt(WebUtils.getParameterValue(request, "type")) ;
		Integer recordType = Integer.parseInt(WebUtils.getParameterValue(request, "recordtype")) ;
		String recordNum = WebUtils.getParameterValue(request, "recordNum");
		RecordChange recordChange = new RecordChange();
		recordChange.setRecordtype(recordType);
		recordChange.setInscode(inscode);
		recordChange.setChangetype(changeType);
		recordChange.setRecordnum(recordNum);
		
		NotificationMessage notificationMessage = new NotificationMessage();
		notificationMessage.setInscode(recordChange.getInscode());
		notificationMessage.setContent(recordChange.getMessageContent());
		notificationMessage.setCreatetime(new Date());
		
		RecordChangeMsgController.notificationMessage = notificationMessage;
		service.addMesage(notificationMessage);
		try
		{
			change();
		}
		catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		result.setData(inscode);
		return result;
	}
	
	@SendTo("/topic/changeRelationship")
    public SocketResult change() throws Exception {
        //return new SocketResult(recordChange.getMessageContent(),recordChange.getInscode());
        return new SocketResult("abc","5851633716061642");
        		
        
    }
	
	

}
