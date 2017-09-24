package com.bjxc.school;
/**
 * 教练与网点关系服务
 * @author Administrator
 *
 */
public class CoachStation {

	private Integer id;
	private Integer stationid;
	private Integer coachId;
	
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getStationid() {
		return stationid;
	}
	public void setStationid(Integer stationid) {
		this.stationid = stationid;
	}
	public Integer getCoachId() {
		return coachId;
	}
	public void setCoachId(Integer coachId) {
		this.coachId = coachId;
	}
	
}
