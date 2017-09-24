package com.bjxc.school;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
/**
 * 教学区域
 * @author aimee
 *
 */
public class Tteacharea {
	private Integer id;
	private String name;
	private String perdritype;
  
	private Integer insId;
	private Integer astatus;

	private Date createtime;
  
	public Integer getId() {
		return id;
	}
	
	public void setId(Integer id) {
		this.id = id;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getPerdritype() {
		return perdritype;
	}
	
	public void setPerdritype(String perdritype) {
		this.perdritype = perdritype;
	}
	
	public Integer getInsId() {
		return insId;
	}
	
	public void setInsId(Integer insId) {
		this.insId = insId;
	}
	
	public Date getCreatetime() {
		return createtime;
	}
	
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Integer getAstatus() {
		return astatus;
	}

	public void setAstatus(Integer astatus) {
		this.astatus = astatus;
	}

 
  

}
