package com.bjxc.school;

public class RecordChange {
	
	private Integer recordtype;
	private Integer changetype;
	private String inscode;
	private String recordnum;
	private String reason;
	
	
	public Integer getRecordtype() {
		return recordtype;
	}
	public void setRecordtype(Integer recordtype) {
		this.recordtype = recordtype;
	}
	public Integer getChangetype() {
		return changetype;
	}
	public void setChangetype(Integer changetype) {
		this.changetype = changetype;
	}
	public String getInscode() {
		return inscode;
	}
	public void setInscode(String inscode) {
		this.inscode = inscode;
	}
	public String getRecordnum() {
		return recordnum;
	}
	public void setRecordnum(String recordnum) {
		this.recordnum = recordnum;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getRecordTypeContent()
	{
		switch(this.getRecordtype().intValue())
		{
			case 1:
				return "计时平台";
			case 2:
				return "教练员";
			case 3:
				return "考核员";
			case 4:
				return "安全员";
			case 5:
				return "教练车";
			case 6:
				return "教学区域";
			default:
				return "";

		
		}
	}
	public String getChangeTypeContent()
	{
		switch(this.getChangetype().intValue())
		{
			case 0:
				return "解除备案";
			case 1:
				return "恢复备案";
			
			default:
				return "";

		
		}
	}
	public String getMessageContent()
	{
		return this.getChangeTypeContent() + ": " + this.getRecordTypeContent() + this.getRecordnum();
		//return this.getChangeTypeContent()  + this.getRecordTypeContent() + this.getRecordnum();
	}
	
	
	

}
