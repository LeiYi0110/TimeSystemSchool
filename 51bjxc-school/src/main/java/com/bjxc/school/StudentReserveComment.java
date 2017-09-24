package com.bjxc.school;

import java.util.Date;

public class StudentReserveComment {
	private Integer id;
	private Integer studentId;
	private Integer resInfoId;
	private Integer start;
	private String comment;
	private Date createTime;
	private Integer isCommentProvince;
	private Integer coachId;
	private Integer status;
	
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
	public Integer getResInfoId() {
		return resInfoId;
	}
	public void setResInfoId(Integer resInfoId) {
		this.resInfoId = resInfoId;
	}
	public Integer getStart() {
		return start;
	}
	public void setStart(Integer start) {
		this.start = start;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Integer getIsCommentProvince() {
		return isCommentProvince;
	}
	public void setIsCommentProvince(Integer isCommentProvince) {
		this.isCommentProvince = isCommentProvince;
	}
	public Integer getCoachId() {
		return coachId;
	}
	public void setCoachId(Integer coachId) {
		this.coachId = coachId;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	
	
}
