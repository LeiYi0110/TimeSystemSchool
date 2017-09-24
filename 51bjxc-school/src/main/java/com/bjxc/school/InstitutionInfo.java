package com.bjxc.school;

import java.util.Date;

public class InstitutionInfo {
	private Integer id;			//primary key
	private String name;		//培训机构名称
	private String district;	//区县行政区划代码
	private String shortName;	//培训机构简称
	private String licnum;		//经营许可证编号
	private String licetime;	//经营许可日期
	private String business;	//经营执照注册号
	private String creditcode;	//统一社会信用代码
	private String postcode;	//邮政编码
	private String province;	//省
	private String city;		//市
	private String area;		//区
	private String address;		//驾校地址
	private String legal;		//法人代表
	private String busistatus;	//经营状态
	private String contact;		//联系人
	private String phone;		//联系电话
	private String inscode;		//培训机构编号-统一编号
	private Integer level;		//分类等级
	private Integer coachnumber;//教练员总数
	private Integer grasupvnum;	//考核员总数
	private Integer safmngnum;	//安全员总数
	private Integer tracarnum;	//教练车总数
	private Integer classroom;	//教室总面积
	private Integer thclassroom;//理论教室面积
	private Integer praticefield;//教练场总面积
	private String introduction;//简介
	private Date createTime;	//创建时间
	private String busiscope;	//经营范围
	private Integer isProvince;	//是否是省备案
	private Integer isCountry;  //是否是国家备案
	private String remark;		//备注
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDistrict() {
		return district;
	}
	public void setDistrict(String district) {
		this.district = district;
	}
	public String getShortName() {
		return shortName;
	}
	public void setShortName(String shortName) {
		this.shortName = shortName;
	}
	public String getLicnum() {
		return licnum;
	}
	public void setLicnum(String licnum) {
		this.licnum = licnum;
	}
	public String getLicetime() {
		return licetime;
	}
	public void setLicetime(String licetime) {
		this.licetime = licetime;
	}
	public String getBusiness() {
		return business;
	}
	public void setBusiness(String business) {
		this.business = business;
	}
	public String getCreditcode() {
		return creditcode;
	}
	public void setCreditcode(String creditcode) {
		this.creditcode = creditcode;
	}
	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getLegal() {
		return legal;
	}
	public void setLegal(String legal) {
		this.legal = legal;
	}
	public String getBusistatus() {
		return busistatus;
	}
	public void setBusistatus(String busistatus) {
		this.busistatus = busistatus;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getInscode() {
		return inscode;
	}
	public void setInscode(String inscode) {
		this.inscode = inscode;
	}
	public Integer getLevel() {
		return level;
	}
	public void setLevel(Integer level) {
		this.level = level;
	}
	public Integer getCoachnumber() {
		return coachnumber;
	}
	public void setCoachnumber(Integer coachnumber) {
		this.coachnumber = coachnumber;
	}
	public Integer getGrasupvnum() {
		return grasupvnum;
	}
	public void setGrasupvnum(Integer grasupvnum) {
		this.grasupvnum = grasupvnum;
	}
	public Integer getSafmngnum() {
		return safmngnum;
	}
	public void setSafmngnum(Integer safmngnum) {
		this.safmngnum = safmngnum;
	}
	public Integer getTracarnum() {
		return tracarnum;
	}
	public void setTracarnum(Integer tracarnum) {
		this.tracarnum = tracarnum;
	}
	public Integer getClassroom() {
		return classroom;
	}
	public void setClassroom(Integer classroom) {
		this.classroom = classroom;
	}
	public Integer getThclassroom() {
		return thclassroom;
	}
	public void setThclassroom(Integer thclassroom) {
		this.thclassroom = thclassroom;
	}
	public Integer getPraticefield() {
		return praticefield;
	}
	public void setPraticefield(Integer praticefield) {
		this.praticefield = praticefield;
	}
	public String getIntroduction() {
		return introduction;
	}
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getBusiscope() {
		return busiscope;
	}
	public void setBusiscope(String busiscope) {
		this.busiscope = busiscope;
	}
	public Integer getIsProvince() {
		return isProvince;
	}
	public void setIsProvince(Integer isProvince) {
		this.isProvince = isProvince;
	}
	public Integer getIsCountry() {
		return isCountry;
	}
	public void setIsCountry(Integer isCountry) {
		this.isCountry = isCountry;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}
