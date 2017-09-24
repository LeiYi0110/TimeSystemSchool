package com.bjxc.school;

public class ServiceStation {
	/**
	 * 编号
	 */
	private Integer id;
	
	/**
	 * 培训机构ID
	 */
	private Integer insId;
	
	/**
	 * 网点名字
	 */
	private String name;
	
	/**
	 * 区域
	 */
	private String area;
	
	/**
	 * 地址
	 */
	private String address;
	
	/**
	 * 负责人姓名
	 */
	private String functionary;
	
	/**
	 * 联系电话
	 */
	private String contactMobile;
	
	/**
	 * 经纬度 用,隔开
	 */
	private String location;
	
	/**
	 * 教学区域Id
	 * 
	 */
	private Integer areaId;
	
	private String readname;
	private Integer coachId;
	private Integer studentId;
	private String  areaname;
	/**
	 * 状态 1-有效，0-取消
	 */
	private Integer status;
	
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
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getFunctionary() {
		return functionary;
	}
	public void setFunctionary(String functionary) {
		this.functionary = functionary;
	}
	public String getContactMobile() {
		return contactMobile;
	}
	public void setContactMobile(String contactMobile) {
		this.contactMobile = contactMobile;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getCoachId() {
		return coachId;
	}
	public void setCoachId(Integer coachId) {
		this.coachId = coachId;
	}
	public Integer getStudentId() {
		return studentId;
	}
	public void setStudentId(Integer studentId) {
		this.studentId = studentId;
	}

	public Integer getAreaId() {
		return areaId;
	}
	public void setAreaId(Integer areaId) {
		this.areaId = areaId;
	}
	public String getReadname() {
		return readname;
	}
	public void setReadname(String readname) {
		this.readname = readname;
	}
	public String getAreaname() {
		return areaname;
	}
	public void setAreaname(String areaname) {
		this.areaname = areaname;
	}
	
}
