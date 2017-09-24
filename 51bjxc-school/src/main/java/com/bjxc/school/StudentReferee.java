package com.bjxc.school;

import java.util.Date;

/**
* 学员报名
* @author yy
* @date : 2016年9月18日 下午2:05:58
*/
public class StudentReferee {
	private Integer id;
	private Integer userID;
	private Integer insId;			
	private Integer classType;
	private Integer stuId;
	private Double money;
	private String payment;
	private Integer statuss;
	private String name;			
	private String mobile;    
	private String idcard;		
	private Integer sex;			
	private String address;		
	private String refereeMobile;	
	private Date createTime;	
	private String typeName;
	private Double price;
	private Integer status;	//0-未处理 1-已处理
	private String refereeName;
	
	public Integer getStuId() {
		return stuId;
	}
	public void setStuId(Integer stuId) {
		this.stuId = stuId;
	}
	public Integer getStatuss() {
		return statuss;
	}
	public void setStatuss(Integer statuss) {
		this.statuss = statuss;
	}
	public String getPayment() {
		return payment;
	}
	public void setPayment(String payment) {
		this.payment = payment;
	}
	public Double getMoney() {
		if(money != null || new Double(0.0).equals(money)){
			return money/100.0;
		}
		return money;
	}
	public void setMoney(Double money) {
		this.money = money;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	public Double getPrice() {
		if(price != null || new Double(0.0).equals(price)){
			return price/100.0;
		}
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getUserID() {
		return userID;
	}
	public void setUserID(Integer userID) {
		this.userID = userID;
	}
	public Integer getInsId() {
		return insId;
	}
	public void setInsId(Integer insId) {
		this.insId = insId;
	}
	public Integer getClassType() {
		return classType;
	}
	public void setClassType(Integer classType) {
		this.classType = classType;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public Integer getSex() {
		return sex;
	}
	public void setSex(Integer sex) {
		this.sex = sex;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getRefereeMobile() {
		return refereeMobile;
	}
	public void setRefereeMobile(String refereeMobile) {
		this.refereeMobile = refereeMobile;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getRefereeName() {
		return refereeName;
	}
	public void setRefereeName(String refereeName) {
		this.refereeName = refereeName;
	}
}
