package com.bjxc.school;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

/**
* 学员考试管理
* @author yy
* @date : 2016年9月18日 下午3:10:20
*/
public class StudentExam {
	private Integer id;
	private Integer studentID;
	private Integer insId;
	private Integer coachId;
	private Integer subjectId;
	private Integer pass;
	private String examField;
	private Integer stationId;
	private String stationName;
	private String area;
	private String stuName;
	private String coachName;
	private Date examTime;
	private Date createTime;
	private Integer score;
	
	
	public Integer getScore() {
		return score;
	}
	public void setScore(Integer score) {
		this.score = score;
	}
	public String getCoachName() {
		return coachName;
	}
	public void setCoachName(String coachName) {
		this.coachName = coachName;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getStudentID() {
		return studentID;
	}
	public void setStudentID(Integer studentID) {
		this.studentID = studentID;
	}
	public Integer getInsId() {
		return insId;
	}
	public void setInsId(Integer insId) {
		this.insId = insId;
	}
	public Integer getCoachId() {
		return coachId;
	}
	public String getStationName() {
		return stationName;
	}
	public void setStationName(String stationName) {
		this.stationName = stationName;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getStuName() {
		return stuName;
	}
	public void setStuName(String stuName) {
		this.stuName = stuName;
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
	public Integer getPass() {
		return pass;
	}
	public void setPass(Integer pass) {
		this.pass = pass;
	}
	public String getExamField() {
		return examField;
	}
	public void setExamField(String examField) {
		this.examField = examField;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public Date getExamTime() {
		return examTime;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public void setExamTime(Date examTime) {
		this.examTime = examTime;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public Date getCreateTime() {
		return createTime;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Integer getStationId() {
		return stationId;
	}
	public void setStationId(Integer stationId) {
		this.stationId = stationId;
	}
	
}
