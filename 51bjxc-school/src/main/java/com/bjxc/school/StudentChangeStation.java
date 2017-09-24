package com.bjxc.school;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class StudentChangeStation {

	private Integer id;				//primary key,
	private Integer studentId;		//'学员ID',
	private Integer fromStation;	//'转出网点ID',
	private Integer toStation;		//'转入网点ID',
	private Integer status;			//'状态 0-发起 1-同意',
	private Date createTime;		//'创建时间'
	private Integer createUserId; 	//申请人ID
	
	private String createUserName;	//申请人姓名
	private String fromStationName;	//'转出网点名字',
	private String toStationName;	//'转入网点名字',
	private String functionary;     //申请人姓名
	private String studentName;     //学员姓名
	private String classTypeName;	//班型名称
	
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
	public Integer getFromStation() {
		return fromStation;
	}
	public void setFromStation(Integer fromStation) {
		this.fromStation = fromStation;
	}
	public Integer getToStation() {
		return toStation;
	}
	public void setToStation(Integer toStation) {
		this.toStation = toStation;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public Date getCreateTime() {
		return createTime;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getFromStationName() {
		return fromStationName;
	}
	public void setFromStationName(String fromStationName) {
		this.fromStationName = fromStationName;
	}
	public String getToStationName() {
		return toStationName;
	}
	public void setToStationName(String toStationName) {
		this.toStationName = toStationName;
	}
	public Integer getCreateUserId() {
		return createUserId;
	}
	public void setCreateUserId(Integer createUserId) {
		this.createUserId = createUserId;
	}
	public String getCreateUserName() {
		return createUserName;
	}
	public void setCreateUserName(String createUserName) {
		this.createUserName = createUserName;
	}
	public String getFunctionary() {
		return functionary;
	}
	public void setFunctionary(String functionary) {
		this.functionary = functionary;
	}
	public String getStudentName() {
		return studentName;
	}
	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}
	public String getClassTypeName() {
		return classTypeName;
	}
	public void setClassTypeName(String classTypeName) {
		this.classTypeName = classTypeName;
	}

}
