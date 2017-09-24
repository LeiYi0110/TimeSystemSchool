package com.bjxc.school;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class NotificationMessage {
	
	private String inscode;
	private String content;
	
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date createtime;
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getInscode() {
		return inscode;
	}
	public void setInscode(String inscode) {
		this.inscode = inscode;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	

	

}
