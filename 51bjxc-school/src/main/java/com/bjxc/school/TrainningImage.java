package com.bjxc.school;

import java.util.Date;

public class TrainningImage {
	
	private Integer id;
	private Integer traningrecordId;
	private Date imageTime;
	private String imageUrl;
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
	public Date getImageTime() {
		return imageTime;
	}
	public void setImageTime(Date imageTime) {
		this.imageTime = imageTime;
	}
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	
}
