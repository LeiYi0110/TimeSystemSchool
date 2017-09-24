package com.bjxc.school;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class Examiner {
	private Integer id;				//primary key
	private Integer insId;			//培训机构编号
	private String name;			//姓名
	private Integer sex;			//1:男性;2:女性
	private String idcard;			//身份证号
	private String mobile;			//手机号码
	private String address;			//联系地址
	private Integer photo;			//成功上传的安全员头像照片文件ID
	private Integer fingerprint;	//成功上传的指纹图片ID
	private String drilicence;		//驾驶证号
	private String fstdrilicdate;   //驾驶证初领日期
	private String dripermitted;	//准驾车型,下列编码单选：A1,A2,A3,B1,B2,C1,C2,C3,C4,C5,D,E,F,M,N,P\n
	private String teachpermitted; 	//准教车型, 下列编码单选：A1,A2,A3,B1,B2,C1,C2,C3,C4,C5,D,E,F,M,N,P\n
	private Integer employstatus;  	//供职状态, 0:在职 1:离职\n
	private Date hiredate;		   	//入职日期
	private Date leavedate;		  	//离职日期
	private String occupationno;	//职业资格证号
	private String occupationlevel;	//职业资格等级,1:一级 2:二级 3:三级 4:四级\n
	private String photourl;		//照片在服务器上的地址
	private String examnum;			//考核员编号
	/**
	 * 是否全国备案 (1 已备案)
	 */
	private Integer isCountry;
	/**
	 * 是否省备案 (1 已备案)
	 */
	private Integer isProvince;
	
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getSex() {
		return sex;
	}
	public void setSex(Integer sex) {
		this.sex = sex;
	}
	public String getIdcard() {
		return idcard;
	}
	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Integer getPhoto() {
		return photo;
	}
	public void setPhoto(Integer photo) {
		this.photo = photo;
	}
	public Integer getFingerprint() {
		return fingerprint;
	}
	public void setFingerprint(Integer fingerprint) {
		this.fingerprint = fingerprint;
	}
	public String getDrilicence() {
		return drilicence;
	}
	public void setDrilicence(String drilicence) {
		this.drilicence = drilicence;
	}
	public String getFstdrilicdate() {
		return fstdrilicdate;
	}
	public void setFstdrilicdate(String fstdrilicdate) {
		this.fstdrilicdate = fstdrilicdate;
	}
	public String getDripermitted() {
		return dripermitted;
	}
	public void setDripermitted(String dripermitted) {
		this.dripermitted = dripermitted;
	}
	public String getTeachpermitted() {
		return teachpermitted;
	}
	public void setTeachpermitted(String teachpermitted) {
		this.teachpermitted = teachpermitted;
	}
	public Integer getEmploystatus() {
		return employstatus;
	}
	public void setEmploystatus(Integer employstatus) {
		this.employstatus = employstatus;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public Date getHiredate() {
		return hiredate;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public void setHiredate(Date hiredate) {
		this.hiredate = hiredate;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public Date getLeavedate() {
		return leavedate;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public void setLeavedate(Date leavedate) {
		this.leavedate = leavedate;
	}
	public String getOccupationno() {
		return occupationno;
	}
	public void setOccupationno(String occupationno) {
		this.occupationno = occupationno;
	}
	public String getOccupationlevel() {
		return occupationlevel;
	}
	public void setOccupationlevel(String occupationlevel) {
		this.occupationlevel = occupationlevel;
	}
	public String getPhotourl() {
		return photourl;
	}
	public void setPhotourl(String photourl) {
		this.photourl = photourl;
	}
	public String getExamnum() {
		return examnum;
	}
	public void setExamnum(String examnum) {
		this.examnum = examnum;
	}
	public Integer getIsCountry() {
		return isCountry;
	}
	public void setIsCountry(Integer isCountry) {
		this.isCountry = isCountry;
	}
	public Integer getIsProvince() {
		return isProvince;
	}
	public void setIsProvince(Integer isProvince) {
		this.isProvince = isProvince;
	}
	
}
