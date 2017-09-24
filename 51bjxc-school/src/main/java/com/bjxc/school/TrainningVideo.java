package com.bjxc.school;

import java.util.Date;

public class TrainningVideo {
	
	private Integer id;
	private Integer traningrecordId;
	private Date starttime;
	private Date endtime;
	private Integer event;
	private String videoURL;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getTraningrecordId() {
		return traningrecordId;
	}
	public void setTraningrecordId(Integer traningrecordId) {
		this.traningrecordId = traningrecordId;
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
	public Integer getEvent() {
		return event;
	}
	public void setEvent(Integer event) {
		this.event = event;
	}
	public String getVideoURL() {
		return videoURL;
	}
	public void setVideoURL(String videoURL) {
		this.videoURL = videoURL;
	}

}
