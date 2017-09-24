package com.bjxc.school;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;


public class Complaint {
	private Integer id;			//primary key
	private Integer studentId;	//学员编号
	private Integer type;		//投诉对象类型,1:教练员 2:培训机构\n
	private Integer objectId;	//CoachId 或者是 InstitutionId
	private Date cdate;			//投诉时间
	private String content;		//投诉内容
	private String schopinion;	//培训机构处理意见
	
	private String coachnum;  //教练员编号
	private String coachName;		//教练姓名
	
	private String institutionName;	//培训机构名称
	private Integer insId;
	private String name;
	
	private String studentName;
	private String stunum;	//学员编号,全国统一
	
	private String depaopinion;
	private Integer isProvince;
	private Integer status;
	
	private String idcard;
	private Integer reserveCount;
	private Integer insReserveCount;
	
	private Integer isValid;
	
	

	
	public Integer getIsValid() {
		return isValid;
	}
	public void setIsValid(Integer isValid) {
		this.isValid = isValid;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getStudentId() {
		return studentId;
	}
	public void setStudentId(Integer studentId) {
		this.studentId = studentId;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public Integer getObjectId() {
		return objectId;
	}
	public void setObjectId(Integer objectId) {
		this.objectId = objectId;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	public Date getCdate() {
		return cdate;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	public void setCdate(Date cdate) {
		this.cdate = cdate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSchopinion() {
		return schopinion;
	}
	public void setSchopinion(String schopinion) {
		this.schopinion = schopinion;
	}
	public String getCoachName() {
		return coachName;
	}
	public void setCoachName(String coachName) {
		this.coachName = coachName;
	}
	public String getInstitutionName() {
		return institutionName;
	}
	public void setInstitutionName(String institutionName) {
		this.institutionName = institutionName;
	}
	public String getName() {
		if(this.getCoachName()!=""&&this.getCoachName()!=null){
			this.setName(this.getCoachName());
		}else {
			this.setName(this.getInstitutionName());
		}
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getStudentName() {
		return studentName;
	}
	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}
	public String getDepaopinion() {
		return depaopinion;
	}
	public void setDepaopinion(String depaopinion) {
		this.depaopinion = depaopinion;
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
	public Integer getIsProvince() {
		return isProvince;
	}
	public void setIsProvince(Integer isProvince) {
		this.isProvince = isProvince;
	}
	public String getIdcard() {
		return idcard;
	}
	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}
	public Integer getReserveCount() {
		return reserveCount;
	}
	public void setReserveCount(Integer reserveCount) {
		this.reserveCount = reserveCount;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getInsReserveCount() {
		return insReserveCount;
	}
	public void setInsReserveCount(Integer insReserveCount) {
		this.insReserveCount = insReserveCount;
	}
	public Integer getInsId() {
		return insId;
	}
	public void setInsId(Integer insId) {
		this.insId = insId;
	}
	
	
	
}
