package com.bjxc.school;


/**
 * 学员统计
 * @author Administrator
 *
 */
public class StudentCount {
	
	private Integer rowno;		//排序
	private String statidate;    //时间
	private Integer stationId;	 //服务网点ID
	private String name;		//服务网点名称
	private Integer newstudentcount;	//新增学员数量
	private Integer graduatestudentcount;	//毕业学员数量
	private Integer currentcount;        //在学学员
	
	public Integer getRowno() {
		return rowno;
	}
	public void setRowno(Integer rowno) {
		this.rowno = rowno;
	}
	public String getStatidate() {
		return statidate;
	}
	public void setStatidate(String statidate) {
		this.statidate = statidate;
	}
	public Integer getStationId() {
		return stationId;
	}
	public void setStationId(Integer stationId) {
		this.stationId = stationId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getNewstudentcount() {
		return newstudentcount;
	}
	public void setNewstudentcount(Integer newstudentcount) {
		this.newstudentcount = newstudentcount;
	}
	public Integer getGraduatestudentcount() {
		return graduatestudentcount;
	}
	public void setGraduatestudentcount(Integer graduatestudentcount) {
		this.graduatestudentcount = graduatestudentcount;
	}
	public Integer getCurrentcount() {
		return currentcount;
	}
	public void setCurrentcount(Integer currentcount) {
		this.currentcount = currentcount;
	}
	
	
	
}
