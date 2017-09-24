package com.bjxc.school;

import java.util.Date;

public class TheoryReportInfo {
	private Integer id;			//primary key
	private Integer insId;		//培训机构Id
	private Integer stationId;	//上报网点ID
	private Date createtime;	//上报创建时间
	private Integer repNumber;	//上报人数
	private Integer areaId;		//片区Id
	private String areaName;	//
	private String stationName; //网点名称
	private Integer totalCount; //片区统计总数
	
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
	public Integer getStationId() {
		return stationId;
	}
	public void setStationId(Integer stationId) {
		this.stationId = stationId;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	public Integer getRepNumber() {
		return repNumber;
	}
	public void setRepNumber(Integer repNumber) {
		this.repNumber = repNumber;
	}
	public Integer getAreaId() {
		return areaId;
	}
	public void setAreaId(Integer areaId) {
		this.areaId = areaId;
	}
	public String getStationName() {
		return stationName;
	}
	public void setStationName(String stationName) {
		this.stationName = stationName;
	}
	public Integer getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(Integer totalCount) {
		this.totalCount = totalCount;
	}
	public String getAreaName() {
		return areaName;
	}
	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}
	
}
