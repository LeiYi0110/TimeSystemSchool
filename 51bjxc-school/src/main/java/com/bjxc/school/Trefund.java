package com.bjxc.school;

import java.util.Date;

/**
 * 学员退费申请表
 * 
 * @author Administrator
 *
 */
public class Trefund {
	/**
	 * 
	 */
	private Integer id;
	/**
	 * 退费创建时间
	 */
	private Date createtime;
	/**
	 * 退费金额（分）
	 */
	private Integer money;
	/**
	 * 审核人ID
	 */
	private Integer reviewUser;
	/**
	 * 学员ID
	 */
	private Integer studentID;
	/**
	 * 1-已申请 2-审批中 3已驳回 4已退费
	 */
	private Integer status;
	/**
	 * 管理审批备注
	 */
	private String userNote;
	/**
	 * 学员退费备注
	 */
	private String stuNote;
	
	private String studentName;  //学生姓名
	
	
	private String teachareaName;  //隶属区域
	
	private String serviceStationName;   //隶属报名处

	private String tcoachName;       //隶属教练

	//应交学费
	private Integer tuition;
	//已交学费
	private Integer alreadyPay;
	//欠费
	private Integer arrearage;
	
	private String classcurr;  //班型
	
	private Integer subjectId;    //科目编号
	
	private String stunum;  // 学员统一编号
	
	

	public String getStunum() {
		return stunum;
	}
	public void setStunum(String stunum) {
		this.stunum = stunum;
	}
	public String getStudentName() {
		return studentName;
	}
	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}
	public String getTeachareaName() {
		return teachareaName;
	}
	public void setTeachareaName(String teachareaName) {
		this.teachareaName = teachareaName;
	}
	public String getServiceStationName() {
		return serviceStationName;
	}
	public void setServiceStationName(String serviceStationName) {
		this.serviceStationName = serviceStationName;
	}
	
	public String getTcoachName() {
		return tcoachName;
	}
	public void setTcoachName(String tcoachName) {
		this.tcoachName = tcoachName;
	}
	public Integer getTuition() {
		if(tuition != null || new Integer(0).equals(tuition)){
			return tuition/100;
		}		
		return tuition;
	}
	public void setTuition(Integer tuition) {
		this.tuition = tuition;
	}
	public Integer getAlreadyPay() {
		if(alreadyPay != null || new Integer(0).equals(alreadyPay)){
			return alreadyPay/100;
		}		
		return alreadyPay;
	}
	public void setAlreadyPay(Integer alreadyPay) {
		this.alreadyPay = alreadyPay;
	}
	public Integer getArrearage() {
		if(arrearage != null || new Integer(0).equals(arrearage)){
			return arrearage/100;
		}		
		return arrearage;
	}
	public void setArrearage(Integer arrearage) {
		this.arrearage = arrearage;
	}
	public String getClasscurr() {
		return classcurr;
	}
	public void setClasscurr(String classcurr) {
		this.classcurr = classcurr;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	public Integer getMoney() {
		if(money != null || new Integer(0).equals(money)){
			return money/100;
		}		
		return money;
	}
	public void setMoney(Integer money) {
		this.money = money;
	}
	public Integer getReviewUser() {
		return reviewUser;
	}
	public void setReviewUser(Integer reviewUser) {
		this.reviewUser = reviewUser;
	}
	public Integer getStudentID() {
		return studentID;
	}
	public void setStudentID(Integer studentID) {
		this.studentID = studentID;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getUserNote() {
		return userNote;
	}
	public void setUserNote(String userNote) {
		this.userNote = userNote;
	}
	public String getStuNote() {
		return stuNote;
	}
	public void setStuNote(String stuNote) {
		this.stuNote = stuNote;
	}
	public Integer getSubjectId() {
		return subjectId;
	}
	public void setSubjectId(Integer subjectId) {
		this.subjectId = subjectId;
	}
	
}
