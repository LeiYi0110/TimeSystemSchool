package com.bjxc.school;

public class CoachMapItem {
	private String title;
	private String result;
	
	/**
	 * 
	 * @param title 教练名
	 * @param result 教练id
	 */
	public CoachMapItem(String title , String result) {
		// TODO Auto-generated constructor stub
		this.title = title;
		this.result = result;
	}
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	
	
}