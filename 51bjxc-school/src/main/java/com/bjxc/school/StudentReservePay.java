package com.bjxc.school;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class StudentReservePay {

	private String studentName;		//学员姓名
	private String studentmobile;	//学员电话
	private String coachName;		//教练姓名
	private String coachMobile;		//教练电话
	private Date day;				//练车日期
	private Integer time;			//练车时间
	private String payNo;			//订单编号	
	private Integer totalFee;		//支付金额
	private Integer payOrderStatus;	//支付状态
	private Integer reserveId;		//预约ID
	private Integer reserveStatus;  //预约状态
	private Integer infoId;			//预约详情ID
	private Integer infoStatus;  	//预约详情状态
	private Date updateTime;		//申请退费时间
	
	
	
	
	public Integer getReserveId() {
		return reserveId;
	}
	public void setReserveId(Integer reserveId) {
		this.reserveId = reserveId;
	}
	public Integer getInfoStatus() {
		return infoStatus;
	}
	public void setInfoStatus(Integer infoStatus) {
		this.infoStatus = infoStatus;
	}
	public String getPayNo() {
		return payNo;
	}
	public void setPayNo(String payNo) {
		this.payNo = payNo;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	public Date getUpdateTime() {
		return updateTime;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public Integer getInfoId() {
		return infoId;
	}
	public void setInfoId(Integer infoId) {
		this.infoId = infoId;
	}
	public Integer getReserveStatus() {
		return reserveStatus;
	}
	public void setReserveStatus(Integer reserveStatus) {
		this.reserveStatus = reserveStatus;
	}
	public String getStudentName() {
		return studentName;
	}
	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}
	public String getStudentmobile() {
		return studentmobile;
	}
	public void setStudentmobile(String studentmobile) {
		this.studentmobile = studentmobile;
	}
	public String getCoachName() {
		return coachName;
	}
	public void setCoachName(String coachName) {
		this.coachName = coachName;
	}
	public String getCoachMobile() {
		return coachMobile;
	}
	public void setCoachMobile(String coachMobile) {
		this.coachMobile = coachMobile;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public Date getDay() {
		return day;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public void setDay(Date day) {
		this.day = day;
	}
	public Integer getTime() {
		return time;
	}
	public void setTime(Integer time) {
		this.time = time;
	}
	public Integer getTotalFee() {
		return totalFee;
	}
	public void setTotalFee(Integer totalFee) {
		this.totalFee = totalFee;
	}
	public Integer getPayOrderStatus() {
		return payOrderStatus;
	}
	public void setPayOrderStatus(Integer payOrderStatus) {
		this.payOrderStatus = payOrderStatus;
	}
	
	
}
