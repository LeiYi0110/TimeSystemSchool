package com.bjxc.school;

import java.util.Date;

public class CommentInsCoach {
	/**
	 * 编号
	 */
	private Integer id;
	/**
	 * name
	 */
	private String name;
	private Integer oneStar;
	private Integer twoStar;
	private Integer threeStar;
	private Integer fourStar;
	private Integer fiveStar;
	private Integer sumStar;
	private Double avgStar;
	private String servicename;
	private String  coachid;
	private Integer star;
	 
	
	private String studentName;
	private String comment;
	private String duration;
    private String coachname;
    private String idcard;
    private Date createTime;
	private Date starttime;
	private Date endtime;
	private String stunum;
	private String coachnum;
	/**
	 * 是否省备案 (1 已备案)
	 */
	private Integer isCommProvince;
	
	private Integer reserSubjectId;
	private Integer coaIsCountry;
	private Integer stuIsCountry;
	
	
	private Integer resInfoId;
	private Integer cCoachId;
	private String cCoachName;
	
	private Integer status;
	
	public Integer getOneStar() {
		return oneStar;
	}
	public void setOneStar(Integer oneStar) {
		this.oneStar = oneStar;
	}
	public Integer getTwoStar() {
		return twoStar;
	}
	public void setTwoStar(Integer twoStar) {
		this.twoStar = twoStar;
	}
	public Integer getThreeStar() {
		return threeStar;
	}
	public void setThreeStar(Integer threeStar) {
		this.threeStar = threeStar;
	}
	public Integer getFourStar() {
		return fourStar;
	}
	public void setFourStar(Integer fourStar) {
		this.fourStar = fourStar;
	}
	public Integer getFiveStar() {
		return fiveStar;
	}
	public void setFiveStar(Integer fiveStar) {
		this.fiveStar = fiveStar;
	}
	public Integer getSumStar() {
		return sumStar;
	}
	public void setSumStar(Integer sumStar) {
		this.sumStar = sumStar;
	}
	public Double getAvgStar() {
		return avgStar;
	}
	public void setAvgStar(Double avgStar) {
		this.avgStar = avgStar;
	}
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
	public String getServicename() {
		return servicename;
	}
	public void setServicename(String servicename) {
		this.servicename = servicename;
	}
	public String getCoachid() {
		return coachid;
	}
	public void setCoachid(String coachid) {
		this.coachid = coachid;
	}
	public Integer getStar() {
		return star;
	}
	public void setStar(Integer star) {
		this.star = star;
	}
	public String getStudentName() {
		return studentName;
	}
	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}

	public String getDuration() {
		return duration;
	}
	public void setDuration(String duration) {
		this.duration = duration;
	}
	public String getCoachname() {
		return coachname;
	}
	public void setCoachname(String coachname) {
		this.coachname = coachname;
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
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getIdcard() {
		return idcard;
	}
	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getStunum() {
		return stunum;
	}
	public void setStunum(String stunum) {
		this.stunum = stunum;
	}
	public String getCoachnum() {
		return coachnum;
	}
	public void setCoachnum(String coachnum) {
		this.coachnum = coachnum;
	}
	public Integer getIsCommProvince() {
		return isCommProvince;
	}
	public void setIsCommProvince(Integer isCommProvince) {
		this.isCommProvince = isCommProvince;
	}
	public Integer getReserSubjectId() {
		return reserSubjectId;
	}
	public void setReserSubjectId(Integer reserSubjectId) {
		this.reserSubjectId = reserSubjectId;
	}
	public Integer getCoaIsCountry() {
		return coaIsCountry;
	}
	public void setCoaIsCountry(Integer coaIsCountry) {
		this.coaIsCountry = coaIsCountry;
	}
	public Integer getStuIsCountry() {
		return stuIsCountry;
	}
	public void setStuIsCountry(Integer stuIsCountry) {
		this.stuIsCountry = stuIsCountry;
	}
	public Integer getResInfoId() {
		return resInfoId;
	}
	public void setResInfoId(Integer resInfoId) {
		this.resInfoId = resInfoId;
	}

	public Integer getcCoachId() {
		return cCoachId;
	}
	public void setcCoachId(Integer cCoachId) {
		this.cCoachId = cCoachId;
	}
	public String getcCoachName() {
		return cCoachName;
	}
	public void setcCoachName(String cCoachName) {
		this.cCoachName = cCoachName;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}

	
}

