package com.bjxc.school;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class StudentSubject {
	private Integer id;
	private Integer studentId;
	private String studentName;
	private Integer subjectId;
	private String subjectName;
	private String coachName;
	private Integer coachId;
	private Integer status;
	private Date endTime;
	private Date createTime;
	
	private Integer count;	//在学科目数量
	
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
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
	public Integer getSubjectId() {
		return subjectId;
	}
	public void setSubjectId(Integer subjectId) {
		this.subjectId = subjectId;
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
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public Date getEndTime() {
		return endTime;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public Date getCreateTime() {
		return createTime;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	public String getStudentName() {
		return studentName;
	}
	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}
	public String getSubjectName() {
		return subjectName;
	}
	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}
	public String getCoachName() {
		return coachName;
	}
	public void setCoachName(String coachName) {
		this.coachName = coachName;
	}
	
}
