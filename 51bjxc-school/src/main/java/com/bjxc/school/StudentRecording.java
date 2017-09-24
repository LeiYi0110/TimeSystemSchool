package com.bjxc.school;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class StudentRecording {
	/**
	 * 学员名称
	 */
	private String studentName;
	/**
	 * 练车日期
	 */
	private Date day;
	/**
	 * 教练名称
	 */
	private String coachName;
	/**
	 * 练车时间
	 */
	private Integer time;
	/**
	 * 科目名称
	 */
	private String subjectName;
	
	
	public String getStudentName() {
		return studentName;
	}
	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	public Date getDay() {
		return day;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	public void setDay(Date day) {
		this.day = day;
	}
	public String getCoachName() {
		return coachName;
	}
	public void setCoachName(String coachName) {
		this.coachName = coachName;
	}
	public Integer getTime() {
		return time;
	}
	public void setTime(Integer time) {
		this.time = time;
	}
	public String getSubjectName() {
		return subjectName;
	}
	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}
	
}
