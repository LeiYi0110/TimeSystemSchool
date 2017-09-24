package com.bjxc.school;

public class LocationInfo{
	
	private int alertInfo;
	private int status;
	private int latitude;
	private int longtitude;
	
	private short carSpeed;
	
	private short gpsSpeed;
	
	private short orientation;
	
	private String time; //BCD[6]���ʾʱ��
	
	public int getAlertInfo() {
		return alertInfo;
	}

	public void setAlertInfo(int alertInfo) {
		this.alertInfo = alertInfo;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getLatitude() {
		return latitude;
	}

	public void setLatitude(int latitude) {
		this.latitude = latitude;
	}

	public int getLongtitude() {
		return longtitude;
	}

	public void setLongtitude(int longtitude) {
		this.longtitude = longtitude;
	}

	public short getCarSpeed() {
		return carSpeed;
	}

	public void setCarSpeed(short carSpeed) {
		this.carSpeed = carSpeed;
	}

	public short getGpsSpeed() {
		return gpsSpeed;
	}

	public void setGpsSpeed(short gpsSpeed) {
		this.gpsSpeed = gpsSpeed;
	}

	public short getOrientation() {
		return orientation;
	}

	public void setOrientation(short orientation) {
		this.orientation = orientation;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

}
