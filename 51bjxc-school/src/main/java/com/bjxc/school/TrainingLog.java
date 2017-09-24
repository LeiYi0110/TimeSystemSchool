package com.bjxc.school;

import java.util.Date;

/**
 * 学时记录
 */
public class TrainingLog {
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
	private Integer enginespeed;
	private Integer locationinfoid;
	private Integer trainingrecordid;	//教学日志id
	private Integer isProvince;
	private Integer subjectId;
	private Float logratio;
	private String inreason;
	
	private Integer carSpeed;
	private Integer gpsSpeed;
	private Integer locationStatus;
	
	private Integer imageCount;
	
	public Integer getSubjectId() {
		return subjectId;
	}
	public void setSubjectId(Integer subjectId) {
		this.subjectId = subjectId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public Integer getIsProvince() {
		return isProvince;
	}
	public void setIsProvince(Integer isProvince) {
		this.isProvince = isProvince;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
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
		if(this.maxspeed!=null){
			return maxspeed/10;
		}
		return maxspeed;
	}
	public void setMaxspeed(Integer maxspeed) {
		this.maxspeed = maxspeed;
	}
	public Integer getMileage() {
		/*if(this.mileage!=null){
			return mileage/10;
		}*/
		return mileage;
	}
	public void setMileage(Integer mileage) {
		this.mileage = mileage;
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
	public Integer getEnginespeed() {
		return enginespeed;
	}
	public void setEnginespeed(Integer enginespeed) {
		this.enginespeed = enginespeed;
	}
	public Float getLogratio() {
		return logratio;
	}
	public void setLogratio(Float logratio) {
		this.logratio = logratio;
	}
	public String getInreason() {
		return inreason;
	}
	public void setInreason(String inreason) {
		this.inreason = inreason;
	}
	public Integer getCarSpeed() {
		return carSpeed;
	}
	public void setCarSpeed(Integer carSpeed) {
		this.carSpeed = carSpeed;
	}
	public Integer getGpsSpeed() {
		return gpsSpeed;
	}
	public void setGpsSpeed(Integer gpsSpeed) {
		this.gpsSpeed = gpsSpeed;
	}
	public Integer getLocationStatus() {
		return locationStatus;
	}
	public void setLocationStatus(Integer locationStatus) {
		this.locationStatus = locationStatus;
	}
	public Integer getImageCount() {
		return imageCount;
	}
	public void setImageCount(Integer imageCount) {
		this.imageCount = imageCount;
	}
	
}
