package com.bjxc.school;

public class CoachCommentParam {
	private String studentNum;	//学员编号
	private String studentName;	//学员名字
	
	private String coachNum;	//教练员编号
	private String coachName;	//教练名字
	
	private String comment;		//评价内容
	private Integer start;		//星级
	
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
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public Integer getStart() {
		return start;
	}
	public void setStart(Integer start) {
		this.start = start;
	}
	
	
	
}
