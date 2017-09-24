package com.bjxc.school;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class StudentReserve {
	private Integer id;
	private Integer studentId;
	private Integer coachId;
	private Integer subjectId;
	private Integer time;//info内容
	private Date day;//info内容
	
	private Integer optionUserId;//操作人
	private Integer reserveRole;//约车单创建角色
	private Integer payType;//支付类型
		
	public Integer getTime() {
		return time;
	}
	public void setTime(Integer time) {
		this.time = time;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public Date getDay() {
		return day;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public void setDay(Date day) {
		this.day = day;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getStudentId() {
		return studentId;
	}
	public void setStudentId(Integer studentId) {
		this.studentId = studentId;
	}
	public Integer getCoachId() {
		return coachId;
	}
	public void setCoachId(Integer coachId) {
		this.coachId = coachId;
	}
	public Integer getSubjectId() {
		return subjectId;
	}
	public void setSubjectId(Integer subjectId) {
		this.subjectId = subjectId;
	}
	public Integer getOptionUserId() {
		return optionUserId;
	}
	public void setOptionUserId(Integer optionUserId) {
		this.optionUserId = optionUserId;
	}
	public Integer getReserveRole() {
		return reserveRole;
	}
	public void setReserveRole(Integer reserveRole) {
		this.reserveRole = reserveRole;
	}
	public Integer getPayType() {
		return payType;
	}
	public void setPayType(Integer payType) {
		this.payType = payType;
	}

}
