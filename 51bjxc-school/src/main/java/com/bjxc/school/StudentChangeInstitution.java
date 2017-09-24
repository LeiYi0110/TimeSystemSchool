package com.bjxc.school;

import java.util.Date;

public class StudentChangeInstitution {
	private Integer id;			
	private Integer studentId;	//学员ID
	private Integer fromInsId;	//转出机构ID
	private Integer toInsId;	//转入机构ID
	private Integer status;		//状态 0-发起 1-同意
	private Integer createUserId;	//创建人ID
	private Date createTime;	//创建时间
	private String studentName;	//学员姓名
	private String insName;	//机构名称
	private Integer sex;	//学员性别
	private String idcard;//身份证号
	private Integer isProvince; //省备案标识
	private String stunum;
	private String inscodes;
	
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
	public Integer getFromInsId() {
		return fromInsId;
	}
	public void setFromInsId(Integer fromInsId) {
		this.fromInsId = fromInsId;
	}
	public Integer getToInsId() {
		return toInsId;
	}
	public void setToInsId(Integer toInsId) {
		this.toInsId = toInsId;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getCreateUserId() {
		return createUserId;
	}
	public void setCreateUserId(Integer createUserId) {
		this.createUserId = createUserId;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getStudentName() {
		return studentName;
	}
	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}
	public String getInsName() {
		return insName;
	}
	public void setInsName(String insName) {
		this.insName = insName;
	}
	public Integer getSex() {
		return sex;
	}
	public void setSex(Integer sex) {
		this.sex = sex;
	}
	public String getIdcard() {
		return idcard;
	}
	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}
	public Integer getIsProvince() {
		return isProvince;
	}
	public void setIsProvince(Integer isProvince) {
		this.isProvince = isProvince;
	}
	public String getStunum() {
		return stunum;
	}
	public void setStunum(String stunum) {
		this.stunum = stunum;
	}
	public String getInscodes() {
		return inscodes;
	}
	public void setInscodes(String inscodes) {
		this.inscodes = inscodes;
	}
	
	
}
