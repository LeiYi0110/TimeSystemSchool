package com.bjxc.school;

/**
* 平台用户
* @author yy
* @date : 2016年9月19日 下午3:07:26
*/
public class PlatformUser {
	private Integer id;
	private Integer insId;
	private Integer stationId;
	private String stationName;  //网点*
	private String headImg;
	private String mobile;
	private String password;
	private String userName;
	private Integer status;	//'0-失效，1-有效'
	private Integer urole;  //1-平台管理员 2-学校一级管理员 3-网点管理员
	private String email;
	private String area;  //大区*
	private Integer areaId;	//区域编号
	private Integer drivingfiledId;//练车场地编号
	
	public Integer getStationId() {
		return stationId;
	}
	public void setStationId(Integer stationId) {
		this.stationId = stationId;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getStationName() {
		return stationName;
	}
	public void setStationName(String stationName) {
		this.stationName = stationName;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getInsId() {
		return insId;
	}
	public void setInsId(Integer insId) {
		this.insId = insId;
	}
	public String getHeadImg() {
		return headImg;
	}
	public void setHeadImg(String headImg) {
		this.headImg = headImg;
	}
	
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getUrole() {
		return urole;
	}
	public void setUrole(Integer urole) {
		this.urole = urole;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Integer getAreaId() {
		return areaId;
	}
	public void setAreaId(Integer areaId) {
		this.areaId = areaId;
	}
	public Integer getDrivingfiledId() {
		return drivingfiledId;
	}
	public void setDrivingfiledId(Integer drivingfiledId) {
		this.drivingfiledId = drivingfiledId;
	}
	
}
