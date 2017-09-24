package com.bjxc.school;

import java.sql.Timestamp;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
/**
 * 教练评价接口持久化类
 * @author fwq
 */
public class CoachComment {
	/**
	 * 评价ID
	 */
	private Integer id;
	/**
	 * 学员姓名
	 */
	private String studentName;
	/**
	 * 评价星级
	 */
	private Integer star;
	/**
	 * 文字评论
	 */
	private String comment;
	/**
	 * 评价时间
	 */
	private Date createTime;
	
	/**
	 * 学员编号
	 * @return
	 */
	private Integer stuId;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getStudentName() {
		return studentName;
	}
	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}
	public Integer getStar() {
		return star;
	}
	public void setStar(Integer star) {
		this.star = star;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Integer getStuId() {
		return stuId;
	}
	public void setStuId(Integer stuId) {
		this.stuId = stuId;
	}
	
	
}
