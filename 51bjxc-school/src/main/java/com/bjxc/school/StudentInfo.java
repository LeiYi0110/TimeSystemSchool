package com.bjxc.school;

public class StudentInfo {

	private Integer id;				//学员ID
	private String studentName;		//学员姓名	
	private Integer studentSex;		//学员性别
	private String studentAddress;	//所属地区
	private String stationAddress;	//所属报名网点 
	private String drvingName;		//练车场地
	private String className;		//班型
	private String subjectName;		//学习状态
	private String trainType;		//培训车型
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getStudentName() {
		return studentName;
	}
	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}
	public Integer getStudentSex() {
		return studentSex;
	}
	public void setStudentSex(Integer studentSex) {
		this.studentSex = studentSex;
	}
	public String getStudentAddress() {
		return studentAddress;
	}
	public void setStudentAddress(String studentAddress) {
		this.studentAddress = studentAddress;
	}
	public String getStationAddress() {
		return stationAddress;
	}
	public void setStationAddress(String stationAddress) {
		this.stationAddress = stationAddress;
	}
	public String getDrvingName() {
		return drvingName;
	}
	public void setDrvingName(String drvingName) {
		this.drvingName = drvingName;
	}
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	public String getSubjectName() {
		return subjectName;
	}
	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}
	public String getTrainType() {
		return trainType;
	}
	public void setTrainType(String trainType) {
		this.trainType = trainType;
	}
	
	
}
