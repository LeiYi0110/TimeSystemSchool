package com.bjxc.school;

import java.util.Date;

public class Evaluation {
	private Integer id;
	/**
	 * 学员id
	 */
	private Integer studentId;
	/**
	 * 学员姓名
	 */
	private String stuName;
	/**
	 * 机构id
	 */
	private Integer insId;
	/**
	 * 机构name
	 */
	private String insName;
	/**
	 * 总体满意度,1:一星 2:二星 3:三星 4:四星 5:五星
	 */
	private Integer overall;
	/**
	 * 培训部分 1:第一部分 2:第二部分 3:第三部分 4:第四部分
	 */
	private Integer part;
	/**
	 * 评价时间
	 */
	private Date evaluatetime;
	/**
	 * 评价用语列表
	 */
	private String srvmanner;
	/**
	 * 个性化评价
	 */
	private String teachlevel;
	
	/**
	 * 隶属教练
	 * @return
	 */
	private String coachname;
	
	/**
	 * 隶属报名处
	 * @return
	 */
	private String tationname;

    /**
     * 身份证号码
     * @return
     */
	private String idcard;
	/**
	 * 学员统一编号
	 */
	private String stunum;
	private Integer isCommProvince;
	
	private Integer stuIsCountry;
	
	private Integer isValid;
	
	

	public Integer getIsValid() {
		return isValid;
	}
	public void setIsValid(Integer isValid) {
		this.isValid = isValid;
	}
	
	public String getInsName() {
		return insName;
	}
	public void setInsName(String insName) {
		this.insName = insName;
	}
	public Integer getInsId() {
		return insId;
	}
	public void setInsId(Integer insId) {
		this.insId = insId;
	}
	public String getStuName() {
		return stuName;
	}
	public void setStuName(String stuName) {
		this.stuName = stuName;
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
	public Integer getOverall() {
		return overall;
	}
	public void setOverall(Integer overall) {
		this.overall = overall;
	}
	public Integer getPart() {
		return part;
	}
	public void setPart(Integer part) {
		this.part = part;
	}
	public Date getEvaluatetime() {
		return evaluatetime;
	}
	public void setEvaluatetime(Date evaluatetime) {
		this.evaluatetime = evaluatetime;
	}
	public String getSrvmanner() {
		return srvmanner;
	}
	public void setSrvmanner(String srvmanner) {
		this.srvmanner = srvmanner;
	}
	public String getTeachlevel() {
		return teachlevel;
	}
	public void setTeachlevel(String teachlevel) {
		this.teachlevel = teachlevel;
	}
	public String getCoachname() {
		return coachname;
	}
	public void setCoachname(String coachname) {
		this.coachname = coachname;
	}
	public String getTationname() {
		return tationname;
	}
	public void setTationname(String tationname) {
		this.tationname = tationname;
	}
	public String getIdcard() {
		return idcard;
	}
	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}
	public String getStunum() {
		return stunum;
	}
	public void setStunum(String stunum) {
		this.stunum = stunum;
	}
	public Integer getIsCommProvince() {
		return isCommProvince;
	}
	public void setIsCommProvince(Integer isCommProvince) {
		this.isCommProvince = isCommProvince;
	}
	public Integer getStuIsCountry() {
		return stuIsCountry;
	}
	public void setStuIsCountry(Integer stuIsCountry) {
		this.stuIsCountry = stuIsCountry;
	}
	
}
