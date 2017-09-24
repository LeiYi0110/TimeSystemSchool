package com.bjxc.school.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjxc.Page;
import com.bjxc.school.NotificationMessage;
import com.bjxc.school.Student;
import com.bjxc.school.mapper.NotificationMessageMapper;

@Service
public class NotificationMessageService {
	
	@Resource
	private NotificationMessageMapper messasgeMapper;
	
	public Integer addMesage(NotificationMessage message)
	{
		return messasgeMapper.add(message);
	}
	
	public Page<NotificationMessage> list()
	{
		Page<NotificationMessage> page = new Page<NotificationMessage>();
		page.setData(messasgeMapper.list());
		page.setRowCount(12);
		return page;
	}

}
