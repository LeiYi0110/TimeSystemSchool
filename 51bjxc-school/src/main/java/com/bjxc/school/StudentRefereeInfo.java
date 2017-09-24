package com.bjxc.school;

public class StudentRefereeInfo extends StudentReferee {
	
	private String trainType;
	private String className;
	private Integer paymode;
	private Double price;
	private Long createTimeStamp;
	
	public String getTrainType() {
		return trainType;
	}
	public void setTrainType(String trainType) {
		this.trainType = trainType;
	}
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	public Integer getPaymode() {
		return paymode;
	}
	public void setPaymode(Integer paymode) {
		this.paymode = paymode;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public Long getCreateTimeStamp() {
		if(this.getCreateTime() != null){
			return this.getCreateTime().getTime();
		}
		return 0L;
	}
	public void setCreateTimeStamp(Long createTimeStamp) {
		this.createTimeStamp = createTimeStamp;
	}
	
	

}
