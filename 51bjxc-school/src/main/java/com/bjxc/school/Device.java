package com.bjxc.school;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class Device {
	private Integer id;
	/**
	 * 计时终端类型, 1:车载计程计时终端2:课堂教学计时终端3:模拟训练计时终端
	 */
	private Integer termtype;
	/**
	 * 生产厂家
	 */
	private String vender;
	/**
	 * 终端型号
	 */
	private String model;
	/**
	 * 终端IMEI号或设备MAC地址
	 */
	private String imei;
	/**
	 * 终端出厂序列号
	 */
	private String sn;
	/**
	 * 绑定车牌号
	 */
	private String licnum;
	
	private Integer carId;
	
	private String devnum;
	
	private String carnum;
	
	private Integer signid;
	
	private String sim;
	
	private String key;
	
	private String passwd;
	
	private Integer insId;
	
	private Integer isProvince;
	
	private Integer isCountry;
	/**
	 * 安装日期
	 */
	private Date installDate;
	private Integer isLogin;
	
	private String studentnum;
	private String coachnum;
	private Integer engineSpeed;
	private Integer carSpeed;
	private Integer status;//rlocationinfo的行驶状态
	private Integer latitude;
	private Integer longtitude;
	private Date  time;
	private String timeStr;
	private String location;
	private Integer trcaId;
	
	public Integer getSignid() {
		return signid;
	}
	public void setSignid(Integer signid) {
		this.signid = signid;
	}
	public String getDevnum() {
		return devnum;
	}
	public void setDevnum(String devnum) {
		this.devnum = devnum;
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public Integer getCarId() {
		return carId;
	}
	public void setCarId(Integer carId) {
		this.carId = carId;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getTermtype() {
		return termtype;
	}
	public void setTermtype(Integer termtype) {
		this.termtype = termtype;
	}
	public String getVender() {
		return vender;
	}
	public void setVender(String vender) {
		this.vender = vender;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public String getImei() {
		return imei;
	}
	public void setImei(String imei) {
		this.imei = imei;
	}
	public String getSn() {
		return sn;
	}
	public void setSn(String sn) {
		this.sn = sn;
	}
	public String getLicnum() {
		return licnum;
	}
	public void setLicnum(String licnum) {
		this.licnum = licnum;
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
	public String getCarnum() {
		return carnum;
	}
	public void setCarnum(String carnum) {
		this.carnum = carnum;
	}
	public String getSim() {
		return sim;
	}
	public void setSim(String sim) {
		this.sim = sim;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public Date getInstallDate() {
		return installDate;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public void setInstallDate(Date installDate) {
		this.installDate = installDate;
	}
	public Integer getIsLogin() {
		return isLogin;
	}
	public void setIsLogin(Integer isLogin) {
		this.isLogin = isLogin;
	}
	public String getStudentnum() {
		return studentnum;
	}
	public void setStudentnum(String studentnum) {
		this.studentnum = studentnum;
	}
	public String getCoachnum() {
		return coachnum;
	}
	public void setCoachnum(String coachnum) {
		this.coachnum = coachnum;
	}
	public Integer getEngineSpeed() {
		return engineSpeed;
	}
	public void setEngineSpeed(Integer engineSpeed) {
		this.engineSpeed = engineSpeed;
	}
	public Integer getCarSpeed() {
		return carSpeed;
	}
	public void setCarSpeed(Integer carSpeed) {
		this.carSpeed = carSpeed;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getLatitude() {
		return latitude;
	}
	public void setLatitude(Integer latitude) {
		this.latitude = latitude;
	}
	public Integer getLongtitude() {
		return longtitude;
	}
	public void setLongtitude(Integer longtitude) {
		this.longtitude = longtitude;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public String getTimeStr() {
		return timeStr;
	}
	public void setTimeStr(String timeStr) {
		this.timeStr = timeStr;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public Integer getTrcaId() {
		return trcaId;
	}
	public void setTrcaId(Integer trcaId) {
		this.trcaId = trcaId;
	}
}
