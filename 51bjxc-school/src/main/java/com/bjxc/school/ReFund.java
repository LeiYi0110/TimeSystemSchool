package com.bjxc.school;

import java.util.Date;

public class ReFund {
	private Integer id;
	private Date createTime;//退费时间
	private Integer money;//退费金额（分）
	private Integer reviewUserId;//审核人ID
	private Integer studentID;//学员ID
	private Integer status;//退费状态
	private String userNote;//管理审批备注
	private String stuNote;//学员退费备注
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Integer getMoney() {
		if(money != null || new Integer(0).equals(money)){
			return money/100;
		}		
		return money;
	}
	public void setMoney(Integer money) {
		this.money = money;
	}
	public Integer getReviewUserId() {
		return reviewUserId;
	}
	public void setReviewUserId(Integer reviewUserId) {
		this.reviewUserId = reviewUserId;
	}
	public Integer getStudentID() {
		return studentID;
	}
	public void setStudentID(Integer studentID) {
		this.studentID = studentID;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getUserNote() {
		return userNote;
	}
	public void setUserNote(String userNote) {
		this.userNote = userNote;
	}
	public String getStuNote() {
		return stuNote;
	}
	public void setStuNote(String stuNote) {
		this.stuNote = stuNote;
	}
}
