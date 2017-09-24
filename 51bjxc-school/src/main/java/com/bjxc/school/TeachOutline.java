package com.bjxc.school;
/**  
 * 教学大纲
* @author huangjr  
* @date 2016年11月28日  创建  
*/
public class TeachOutline {
	private String cartype;
	private Integer subjectId;
	private Integer courseNum;
	private Integer insId;
	
	
	public TeachOutline() {
		super();
	}
	public TeachOutline(String cartype, Integer subjectId, Integer courseNum, Integer insId) {
		super();
		this.cartype = cartype;
		this.subjectId = subjectId;
		this.courseNum = courseNum;
		this.insId = insId;
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
	public Integer getInsId() {
		return insId;
	}
	public void setInsId(Integer insId) {
		this.insId = insId;
	}
	
}
