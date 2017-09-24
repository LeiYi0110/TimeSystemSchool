package com.bjxc.school;

public class SchoolCommentParam {

	private String studentNum;	//学员编号	
	private String studentName;		//名字
	private String coment;		//内容
	private Integer start;		//星级
	
	private String coachNum;	//教练员编号
	private String coachName;	//教练名字
	private Integer type;		//1驾校，2教练
	
	private Integer insId;		//
	
	private String institutionName;
	

	
	
	public String getInstitutionName() {
		return institutionName;
	}
	public void setInstitutionName(String institutionName) {
		this.institutionName = institutionName;
	}
	public String getStudentNum() {
		return studentNum;
	}
	public void setStudentNum(String studentNum) {
		this.studentNum = studentNum;
	}
	public String getStudentName() {
		return studentName;
	}
	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}
	public String getComent() {
		return coment;
	}
	public void setComent(String coment) {
		this.coment = coment;
	}
	public Integer getStart() {
		return start;
	}
	public void setStart(Integer start) {
		this.start = start;
	}
	public String getCoachNum() {
		return coachNum;
	}
	public void setCoachNum(String coachNum) {
		this.coachNum = coachNum;
	}
	public String getCoachName() {
		return coachName;
	}
	public void setCoachName(String coachName) {
		this.coachName = coachName;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	
	public Integer getInsId() {
		return insId;
	}
	public void setInsId(Integer insId) {
		this.insId = insId;
	}
	@Override
	public String toString() {
		return "SchoolCommentParam [studentNum=" + studentNum + ", studentName=" + studentName + ", coment=" + coment
				+ ", start=" + start + ", coachNum=" + coachNum + ", coachName=" + coachName + ", type=" + type
				+ ", insId=" + insId + "]";
	}

	
}
