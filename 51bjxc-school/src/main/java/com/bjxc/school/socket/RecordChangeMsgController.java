package com.bjxc.school.socket;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bjxc.school.NotificationMessage;

@Controller
@RequestMapping("/socket")
public class RecordChangeMsgController {
	
	public static int isSend = 0;
	
	public static List<Boolean> sendList = new ArrayList<Boolean>();
	
	//public static RecordChange recordChange; 
	public static NotificationMessage notificationMessage;
	
	public static int count = 0;
	
	private Logger logger = LoggerFactory.getLogger(RecordChangeMsgController.class);

    //@MessageMapping("/RecordChangeMsg")
	@RequestMapping(value="/ReviewMsg/StageTrainningTime", method=RequestMethod.POST)
    @SendTo("/topic/changeRelationship")
    public SocketResult change(Message message) throws Exception {
        
    	
    	/*
        while (isSend == 0) {
        	Thread.sleep(1);
		}
		
        isSend = 0;
		*/
        //return new SocketResult(recordChange.getMessageContent(),recordChange.getInscode());
        //return new SocketResult(notificationMessage.getContent(),notificationMessage.getInscode());
        return new SocketResult("abc","5851633716061642");
        
    }
	

}
