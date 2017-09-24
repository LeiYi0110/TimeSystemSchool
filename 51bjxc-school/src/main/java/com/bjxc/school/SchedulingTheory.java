package com.bjxc.school;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
/**
 * 理论课排班
 * @author Administrator
 *
 */
public class SchedulingTheory {
	private	Integer id;			//primary key
	private Integer studentId;	//学员ID
	private Integer subjectId;	//科目ID
	private Integer stationId;	//排班网点ID
	private Date endTime;		//完成时间
	private Date classDate;		//上课时间
	private Date createTime;	//创建时间
	private Integer status;		//状态 1-受理未上课 2上报未排班 3理论课已排班 4科目一学习中
	private String remarks;		//备注
	
	private String stationName; //网点名 huangjr
	private String stuName;		//学员名
	private String stuMobile;	//学员电话号码
	private String stuIdCard;	//学员idcard
	private String stuRecNum;	//学员流水号
	
	private String studentName;	//学员姓名
	private String mobile;		//学员手机号码 
	private String idcard;		//学员身份证号码
	private String recordnum;	//流水号
	private String applydate;	//报名时间
	private Integer insId;		//机构编号
	private String title;
	
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
	public Integer getStationId() {
		return stationId;
	}
	public void setStationId(Integer stationId) {
		this.stationId = stationId;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public Date getEndTime() {
		return endTime;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public Date getClassDate() {
		return classDate;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public void setClassDate(Date classDate) {
		this.classDate = classDate;
	}
	public String getStationName() {
		return stationName;
	}
	public void setStationName(String stationName) {
		this.stationName = stationName;
	}
	public String getStuName() {
		return stuName;
	}
	public void setStuName(String stuName) {
		this.stuName = stuName;
	}
	public String getStuMobile() {
		return stuMobile;
	}
	public void setStuMobile(String stuMobile) {
		this.stuMobile = stuMobile;
	}
	public String getStuIdCard() {
		return stuIdCard;
	}
	public void setStuIdCard(String stuIdCard) {
		this.stuIdCard = stuIdCard;
	}
	public String getStuRecNum() {
		return stuRecNum;
	}
	public void setStuRecNum(String stuRecNum) {
		this.stuRecNum = stuRecNum;
	}
	public String getStudentName() {
		return studentName;
	}
	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getIdcard() {
		return idcard;
	}
	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}
	public String getRecordnum() {
		return recordnum;
	}
	public void setRecordnum(String recordnum) {
		this.recordnum = recordnum;
	}
	public String getApplydate() {
		return applydate;
	}
	public void setApplydate(String applydate) {
		this.applydate = applydate;
	}
	public Integer getInsId() {
		return insId;
	}
	public void setInsId(Integer insId) {
		this.insId = insId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	
}
