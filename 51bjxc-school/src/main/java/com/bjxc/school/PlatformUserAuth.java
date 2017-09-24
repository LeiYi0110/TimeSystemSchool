package com.bjxc.school;

public class PlatformUserAuth {
	private Integer id;
	private Integer platformUserId;	//用户id/驾校用户id/网点用户id
	private Integer operationItemId;//按钮id
	
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getPlatformUserId() {
		return platformUserId;
	}
	public void setPlatformUserId(Integer platformUserId) {
		this.platformUserId = platformUserId;
	}
	public Integer getOperationItemId() {
		return operationItemId;
	}
	public void setOperationItemId(Integer operationItemId) {
		this.operationItemId = operationItemId;
	}
	@Override
	public String toString() {
		return "PlatformUserAuth [id=" + id + ", platformUserId=" + platformUserId + ", operationItemId="
				+ operationItemId + "]";
	}
	
	
}
