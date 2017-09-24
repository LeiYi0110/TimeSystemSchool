package com.bjxc.school;



public class Eachoutline {
	private Integer id;			//primary key
	private String cartype;		//'A1,A2,A3,B1,B2,C1,C2,C3,C4,C5,D,E,F,M,N,P'
	private Integer subjectId;	//'科目Id'
	private Integer courseNum;	//'学时数'
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getCartype() {
		return cartype;
	}
	public void setCartype(String cartype) {
		this.cartype = cartype;
	}
	public Integer getSubjectId() {
		return subjectId;
	}
	public void setSubjectId(Integer subjectId) {
		this.subjectId = subjectId;
	}
	public Integer getCourseNum() {
		return courseNum;
	}
	public void setCourseNum(Integer courseNum) {
		this.courseNum = courseNum;
	}
	
}
