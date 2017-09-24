package com.bjxc.school;

import java.util.Date;

public class TrainingCar {
	private Integer id;
	/**
	 * 培训机构编号
	 */
	private Integer insId;
	private String inscode;
	/**
	 * 车架号
	 */
	private String franum;
	/**
	 * 发动机号
	 */
	private String engnum;
	/**
	 * 车辆牌号
	 */
	private String licnum;
	/**
	 * 车辆颜色 1:蓝色2:黄色3:黑色4:白色5:绿色9:其他
	 */
	private Integer platecolor;
	/**
	 * 成功上传的教练车照片文件ID
	 */
	private Integer photo;
	/**
	 * 生产厂家
	 */
	private String manufacture;
	/**
	 * 车辆品牌
	 */
	private String brand;
	/**
	 * 车辆型号
	 */
	private String model;
	/**
	 * 培训车型, 下列编码单选：A1,A2,A3,B1,B2,C1,C2,C3,C4,C5,D,E,F,M,N,P
	 */
	private String perdritype;
	/**
	 * 购买日期
	 */
	private Date buydate;
	
	
	private String photourl;
	
	/**
	 * 车辆编号
	 */
	private String carnum;
	
	/**
	 * 地址
	 */
	private String Address;
	
	/**
	 * 教练ID
	 */
	private Integer coachId;
	
	/**
	 * 隶属区域
	 * @return
	 */
    private String areaname;
    
    /**
     * 备注
     * @return
     */
	private String remarks;
	
	
	private Integer isProvince;
	
	private Integer isCountry;
	
	public String getCarnum() {
		return carnum;
	}
	public void setCarnum(String carnum) {
		this.carnum = carnum;
	}
	public String getPhotourl() {
		return photourl;
	}
	public void setPhotourl(String photourl) {
		this.photourl = photourl;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getInscode() {
		return inscode;
	}
	public void setInscode(String inscode) {
		this.inscode = inscode;
	}
	public String getFranum() {
		return franum;
	}
	public void setFranum(String franum) {
		this.franum = franum;
	}
	public String getEngnum() {
		return engnum;
	}
	public void setEngnum(String engnum) {
		this.engnum = engnum;
	}
	public String getLicnum() {
		return licnum;
	}
	public void setLicnum(String licnum) {
		this.licnum = licnum;
	}
	public Integer getPlatecolor() {
		return platecolor;
	}
	public void setPlatecolor(Integer platecolor) {
		this.platecolor = platecolor;
	}
	public Integer getPhoto() {
		return photo;
	}
	public void setPhoto(Integer photo) {
		this.photo = photo;
	}
	public String getManufacture() {
		return manufacture;
	}
	public void setManufacture(String manufacture) {
		this.manufacture = manufacture;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public String getPerdritype() {
		return perdritype;
	}
	public void setPerdritype(String perdritype) {
		this.perdritype = perdritype;
	}
	public Date getBuydate() {
		return buydate;
	}
	public void setBuydate(Date buydate) {
		this.buydate = buydate;
	}
	public String getAddress() {
		return Address;
	}
	public void setAddress(String address) {
		Address = address;
	}
	public Integer getCoachId() {
		return coachId;
	}
	public void setCoachId(Integer coachId) {
		this.coachId = coachId;
	}
	public String getAreaname() {
		return areaname;
	}
	public void setAreaname(String areaname) {
		this.areaname = areaname;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public Integer getInsId() {
		return insId;
	}
	public void setInsId(Integer insId) {
		this.insId = insId;
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
}
