package com.bjxc.school;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.lang.StringUtils;

public class TeachLog {
	private Integer id;
	private Integer insid;	//培训机构Id
	private String inscode;	//培训机构编号
	private Integer studentId;	//学员Id
	private String stunum;	//学员编号
	private String stuname;	//学员姓名 
	private Integer coachId;	//教练Id
	private String coachnum;	//教练编号
	private String coachname;	//教练员姓名
	private Integer carId;	//培训机构Id
	private String carnum;	//培训机构编号
	private Integer deviceId;	//终端Id
	private String devnum;	//终端编号
	private String platnum;	//平台编号
	private String etrainingLogCode;	//电子教学日志编号
	private String courseCode;	//课程编码
	private Integer subjectId;	//科目Id
	private String photo1;	//签到照片id
	private String photo2;	//随机照片id
	private String photo3;	//签退照片id
	private Date starttime;	//培训开始时间
	private Date endtime;	//培训结束时间
	private String duration;	//培训学时
	private Integer mileage;	//培训里程
	private Integer avevelocity;	//培训平均速度
	private String coacmt;	//教练员点评
	private Integer total;	//总累计学时
	private Integer part1;	//第一部分累计学时
	private Integer part2;	//第二部分累计学时
	private Integer part3;	//第三部分累计学时
	private Integer part4;	//第四部分累计学时
	private Integer isProvince;	//是否已备案，0未备案1已备案
	private Date createtime;
	//private Integer status;
	private String loginPhotoId;
	private String logoutPhotoId;
	private Integer pass;
	//private Integer maxSpeed;
	//private Integer distance;
	//private Integer locationInfoId;
	private Integer trainingcarId;
	//private String recordCode;
	private String courseType;
	private String loginPhotoUrl;
	private String logoutPhotoUrl;
	
	private Long zero;	//速度为0的学时条数
	private Long five;	//速度为0-5的学时条数
	private Long bigfive;	//速度为>5的学时条数
	
	private String reason;
	private Integer inpass;
	
	private Integer approvalDuration;	//认可学时
	
	private Integer subjectApprovalDuration ;//本部分认可学时
	private Integer subjectMileage ; //本部分累计里程
	
	private Double logratio;	//分钟学时认可比率
	
	private Integer approvalDurationCount; //认可学时数量
	
	public Integer getInpass() {
		return inpass;
	}
	public void setInpass(Integer inpass) {
		this.inpass = inpass;
	}
	private String inreason;

	public String getInreason() {
		return inreason;
	}
	public void setInreason(String inreason) {
		this.inreason = inreason;
	}
	public Long getZero() {
		return zero;
	}
	public void setZero(Long zero) {
		this.zero = zero;
	}
	public Long getFive() {
		return five;
	}
	public void setFive(Long five) {
		this.five = five;
	}
	public Long getBigfive() {
		return bigfive;
	}
	public void setBigfive(Long bigfive) {
		this.bigfive = bigfive;
	}
	public String getLoginPhotoUrl() {
		return loginPhotoUrl;
	}
	public void setLoginPhotoUrl(String loginPhotoUrl) {
		this.loginPhotoUrl = loginPhotoUrl;
	}
	public String getLogoutPhotoUrl() {
		return logoutPhotoUrl;
	}
	public void setLogoutPhotoUrl(String logoutPhotoUrl) {
		this.logoutPhotoUrl = logoutPhotoUrl;
	}

	public String getCourseType() {
		return courseType;
	}
	public void setCourseType(String courseType) {
		this.courseType = courseType;
	}
	public Integer getTrainingcarId() {
		return trainingcarId;
	}
	public void setTrainingcarId(Integer trainingcarId) {
		this.trainingcarId = trainingcarId;
	}

	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getInsid() {
		return insid;
	}
	public void setInsid(Integer insid) {
		this.insid = insid;
	}
	public String getInscode() {
		return inscode;
	}
	public void setInscode(String inscode) {
		this.inscode = inscode;
	}

	public String getStunum() {
		return stunum;
	}
	public void setStunum(String stunum) {
		this.stunum = stunum;
	}
	public Integer getCoachId() {
		return coachId;
	}
	public void setCoachId(Integer coachId) {
		this.coachId = coachId;
	}
	public String getCoachnum() {
		return coachnum;
	}
	public void setCoachnum(String coachnum) {
		this.coachnum = coachnum;
	}
	public Integer getCarId() {
		return carId;
	}
	public void setCarId(Integer carId) {
		this.carId = carId;
	}
	public String getCarnum() {
		return carnum;
	}
	public void setCarnum(String carnum) {
		this.carnum = carnum;
	}
	public Integer getDeviceId() {
		return deviceId;
	}
	public void setDeviceId(Integer deviceId) {
		this.deviceId = deviceId;
	}
	public String getDevnum() {
		return devnum;
	}
	public void setDevnum(String devnum) {
		this.devnum = devnum;
	}
	public String getPlatnum() {
		return platnum;
	}
	public void setPlatnum(String platnum) {
		this.platnum = platnum;
	}
	public String getEtrainingLogCode() {
		return etrainingLogCode;
	}
	public void setEtrainingLogCode(String etrainingLogCode) {
		this.etrainingLogCode = etrainingLogCode;
	}
	public Integer getStudentId() {
		return studentId;
	}
	public void setStudentId(Integer studentId) {
		this.studentId = studentId;
	}
	public String getCourseCode() {
		return courseCode;
	}
	public void setCourseCode(String courseCode) {
		this.courseCode = courseCode;
	}
	public Integer getSubjectId() {
		return subjectId;
	}
	public void setSubjectId(Integer subjectId) {
		this.subjectId = subjectId;
	}
	public String getPhoto1() {
		return photo1;
	}
	public void setPhoto1(String photo1) {
		this.photo1 = photo1;
	}
	public String getPhoto2() {
		return photo2;
	}
	public void setPhoto2(String photo2) {
		this.photo2 = photo2;
	}
	public String getPhoto3() {
		return photo3;
	}
	public void setPhoto3(String photo3) {
		this.photo3 = photo3;
	}
	public Date getStarttime() {
		return starttime;
	}
	public void setStarttime(Date starttime) {
		this.starttime = starttime;
	}
	public Date getEndtime() {
		return endtime;
	}
	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}
	public String getDuration() {
		Long startDate=this.starttime.getTime();
		Long endDate=this.endtime.getTime();
		Integer minuts=(int) ((endDate - startDate)/(1000 * 60));  
		return minuts+"";
	}
	public void setDuration(String duration) {
		this.duration = duration;
	}
	public Integer getMileage() {
		if(this.mileage==null){
			return 0;
		}else {
			return this.mileage;
		}
	}
	public void setMileage(Integer mileage) {
		this.mileage = mileage;
	}
	public Integer getAvevelocity() {
		if(this.avevelocity==null){
			return 0;
		}else {
			return this.avevelocity;
		}
		
	}
	public void setAvevelocity(Integer avevelocity) {
		this.avevelocity = avevelocity;
	}
	public String getCoacmt() {
		return coacmt;
	}
	public void setCoacmt(String coacmt) {
		this.coacmt = coacmt;
	}
	public Integer getTotal() {
		return total;
	}
	public void setTotal(Integer total) {
		this.total = total;
	}
	public Integer getPart1() {
		return part1;
	}
	public void setPart1(Integer part1) {
		this.part1 = part1;
	}
	public Integer getPart2() {
		return part2;
	}
	public void setPart2(Integer part2) {
		this.part2 = part2;
	}
	public Integer getPart3() {
		return part3;
	}
	public void setPart3(Integer part3) {
		this.part3 = part3;
	}
	public Integer getPart4() {
		return part4;
	}
	public void setPart4(Integer part4) {
		this.part4 = part4;
	}
	public Integer getIsProvince() {
		return isProvince;
	}
	public void setIsProvince(Integer isProvince) {
		this.isProvince = isProvince;
	}
	public String getStuname() {
		return stuname;
	}
	public void setStuname(String stuname) {
		this.stuname = stuname;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	public String getLoginPhotoId() {
		return loginPhotoId;
	}
	public void setLoginPhotoId(String loginPhotoId) {
		this.loginPhotoId = loginPhotoId;
	}
	public String getLogoutPhotoId() {
		return logoutPhotoId;
	}
	public void setLogoutPhotoId(String logoutPhotoId) {
		this.logoutPhotoId = logoutPhotoId;
	}
	public Integer getPass() {
		return pass;
	}
	public void setPass(Integer pass) {
		this.pass = pass;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getCoachname() {
		return coachname;
	}
	public void setCoachname(String coachname) {
		this.coachname = coachname;
	}
	public Integer getApprovalDuration() {
		return this.approvalDuration;
	}
	public void setApprovalDuration(Integer approvalDuration) {
		this.approvalDuration = approvalDuration;
	}
	public Integer getSubjectApprovalDuration() {
		return subjectApprovalDuration;
	}
	public void setSubjectApprovalDuration(Integer subjectApprovalDuration) {
		this.subjectApprovalDuration = subjectApprovalDuration;
	}
	public Integer getSubjectMileage() {
		return subjectMileage;
	}
	public void setSubjectMileage(Integer subjectMileage) {
		this.subjectMileage = subjectMileage;
	}
	public Double getLogratio() {
		return logratio;
	}
	public void setLogratio(Double logratio) {
		this.logratio = logratio;
	}
	public Integer getApprovalDurationCount() {
		return approvalDurationCount;
	}
	public void setApprovalDurationCount(Integer approvalDurationCount) {
		this.approvalDurationCount = approvalDurationCount;
	}
	
}
