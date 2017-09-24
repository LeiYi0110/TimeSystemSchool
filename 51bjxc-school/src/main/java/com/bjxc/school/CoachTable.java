package com.bjxc.school;
/**  
 * 存储过程中生成的表
* @author huangjr  
* @date 2016年11月22日  创建  
*/
public class CoachTable {
	private Integer row_no;
	private String coaName;
	private String coaCarPlate;
	private Integer subjTwoCount;
	private Double subjTwoPassPercent;
	/**
	 * 科二考试合格率
	 */
	private String twoPercentStr;
	private Integer subjThreeCount;
	private Double subjThreePassPercent;
	/**
	 * 科三考试合格率
	 */
	private String threePercentStr;
	private Double stuPassPercent;
	/**
	 * 综合合格率
	 */
	private String passPercentStr;
	private Integer teachingCount;
	private Integer stuCount;
	
	public Integer getRow_no() {
		return row_no;
	}
	public void setRow_no(Integer row_no) {
		this.row_no = row_no;
	}
	public String getCoaName() {
		return coaName;
	}
	public void setCoaName(String coaName) {
		this.coaName = coaName;
	}
	public String getCoaCarPlate() {
		return coaCarPlate;
	}
	public void setCoaCarPlate(String coaCarPlate) {
		this.coaCarPlate = coaCarPlate;
	}
	public Integer getSubjTwoCount() {
		return subjTwoCount;
	}
	public void setSubjTwoCount(Integer subjTwoCount) {
		this.subjTwoCount = subjTwoCount;
	}
	public Double getSubjTwoPassPercent() {
		return subjTwoPassPercent;
	}
	public void setSubjTwoPassPercent(Double subjTwoPassPercent) {
		this.subjTwoPassPercent = subjTwoPassPercent;
	}
	public Integer getSubjThreeCount() {
		return subjThreeCount;
	}
	public void setSubjThreeCount(Integer subjThreeCount) {
		this.subjThreeCount = subjThreeCount;
	}
	public Double getSubjThreePassPercent() {
		return subjThreePassPercent;
	}
	public void setSubjThreePassPercent(Double subjThreePassPercent) {
		this.subjThreePassPercent = subjThreePassPercent;
	}
	public Double getStuPassPercent() {
		return stuPassPercent;
	}
	public void setStuPassPercent(Double stuPassPercent) {
		this.stuPassPercent = stuPassPercent;
	}
	public Integer getTeachingCount() {
		return teachingCount;
	}
	public void setTeachingCount(Integer teachingCount) {
		this.teachingCount = teachingCount;
	}
	public Integer getStuCount() {
		return stuCount;
	}
	public void setStuCount(Integer stuCount) {
		this.stuCount = stuCount;
	}
	public String getTwoPercentStr() {
		return twoPercentStr;
	}
	public void setTwoPercentStr(String twoPercentStr) {
		this.twoPercentStr = twoPercentStr;
	}
	public String getThreePercentStr() {
		return threePercentStr;
	}
	public void setThreePercentStr(String threePercentStr) {
		this.threePercentStr = threePercentStr;
	}
	public String getPassPercentStr() {
		return passPercentStr;
	}
	public void setPassPercentStr(String passPercentStr) {
		this.passPercentStr = passPercentStr;
	}
}
