package com.bjxc.school;

import java.util.Date;

public class TrainingLogWithLocation {
	private Integer id;
	private String recordnum;	//学时记录编号
	private Integer uploadtype;		//1自动上报，2手动上报
	private String name;
	private String studentnum;		
	private String coachnum;
	private Integer courseid;	//课堂id
	private Date recordtime;	//记录时间
	private String course;		//课程编码
	private Integer status;		//0正常记录，1异常记录
	private Integer maxspeed;	//1min内车辆达到的最大卫星定位速度，1/10km/h
	private Integer mileage;	//车辆1min内行驶的总里程
	private Integer inspass;	//平台审核,1表示手动审核通过，-1表示手动审核未通过，2表示自动审核通过，-2表示自动审核未通过
	private Integer propass;	//省审核
	private String reason;
	private Integer locationinfoid;
	private Integer trainingrecordid;	//教学日志id
	private Integer isProvince;
	private Integer subjectId;
	private Integer trainingCarId;
	private Integer trainingCarIsProvince;
	private String trainingCarPerdritype;
	
	private int alertInfo;
	private int locationStatus;
	private int latitude;
	private int longtitude;
	private short carSpeed;
	private short gpsSpeed;
	private short orientation;
	private String time;
	private int sum_distance;
	private int gasonline_cost;
	private int elevation;
	private int engine_speed;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getRecordnum() {
		return recordnum;
	}
	public void setRecordnum(String recordnum) {
		this.recordnum = recordnum;
	}
	public Integer getUploadtype() {
		return uploadtype;
	}
	public void setUploadtype(Integer uploadtype) {
		this.uploadtype = uploadtype;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public Integer getCourseid() {
		return courseid;
	}
	public void setCourseid(Integer courseid) {
		this.courseid = courseid;
	}
	public Date getRecordtime() {
		return recordtime;
	}
	public void setRecordtime(Date recordtime) {
		this.recordtime = recordtime;
	}
	public String getCourse() {
		return course;
	}
	public void setCourse(String course) {
		this.course = course;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getMaxspeed() {
		return maxspeed;
	}
	public void setMaxspeed(Integer maxspeed) {
		this.maxspeed = maxspeed;
	}
	public Integer getMileage() {
		return mileage;
	}
	public void setMileage(Integer mileage) {
		this.mileage = mileage;
	}
	public Integer getInspass() {
		return inspass;
	}
	public void setInspass(Integer inspass) {
		this.inspass = inspass;
	}
	public Integer getPropass() {
		return propass;
	}
	public void setPropass(Integer propass) {
		this.propass = propass;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public Integer getLocationinfoid() {
		return locationinfoid;
	}
	public void setLocationinfoid(Integer locationinfoid) {
		this.locationinfoid = locationinfoid;
	}
	public Integer getTrainingrecordid() {
		return trainingrecordid;
	}
	public void setTrainingrecordid(Integer trainingrecordid) {
		this.trainingrecordid = trainingrecordid;
	}
	public Integer getIsProvince() {
		return isProvince;
	}
	public void setIsProvince(Integer isProvince) {
		this.isProvince = isProvince;
	}
	public Integer getSubjectId() {
		return subjectId;
	}
	public void setSubjectId(Integer subjectId) {
		this.subjectId = subjectId;
	}
	public int getAlertInfo() {
		return alertInfo;
	}
	public void setAlertInfo(int alertInfo) {
		this.alertInfo = alertInfo;
	}
	public int getLocationStatus() {
		return locationStatus;
	}
	public void setLocationStatus(int locationStatus) {
		this.locationStatus = locationStatus;
	}
	public int getLatitude() {
		return latitude;
	}
	public void setLatitude(int latitude) {
		this.latitude = latitude;
	}
	public int getLongtitude() {
		return longtitude;
	}
	public void setLongtitude(int longtitude) {
		this.longtitude = longtitude;
	}
	public short getCarSpeed() {
		return carSpeed;
	}
	public void setCarSpeed(short carSpeed) {
		this.carSpeed = carSpeed;
	}
	public short getGpsSpeed() {
		return gpsSpeed;
	}
	public void setGpsSpeed(short gpsSpeed) {
		this.gpsSpeed = gpsSpeed;
	}
	public short getOrientation() {
		return orientation;
	}
	public void setOrientation(short orientation) {
		this.orientation = orientation;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public int getSum_distance() {
		return sum_distance;
	}
	public void setSum_distance(int sum_distance) {
		this.sum_distance = sum_distance;
	}
	public int getGasonline_cost() {
		return gasonline_cost;
	}
	public void setGasonline_cost(int gasonline_cost) {
		this.gasonline_cost = gasonline_cost;
	}
	public int getElevation() {
		return elevation;
	}
	public void setElevation(int elevation) {
		this.elevation = elevation;
	}
	public int getEngine_speed() {
		return engine_speed;
	}
	public void setEngine_speed(int engine_speed) {
		this.engine_speed = engine_speed;
	}
	public Integer getTrainingCarId() {
		return trainingCarId;
	}
	public void setTrainingCarId(Integer trainingCarId) {
		this.trainingCarId = trainingCarId;
	}
	public Integer getTrainingCarIsProvince() {
		return trainingCarIsProvince;
	}
	public void setTrainingCarIsProvince(Integer trainingCarIsProvince) {
		this.trainingCarIsProvince = trainingCarIsProvince;
	}
	public String getTrainingCarPerdritype() {
		return trainingCarPerdritype;
	}
	public void setTrainingCarPerdritype(String trainingCarPerdritype) {
		this.trainingCarPerdritype = trainingCarPerdritype;
	}
}
