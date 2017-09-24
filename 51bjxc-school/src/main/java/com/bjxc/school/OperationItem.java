package com.bjxc.school;

public class OperationItem {
	private Integer id;
	private String itemName;
	private Integer level;
	private Integer parentId;
	private Byte isMenu;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public Integer getLevel() {
		return level;
	}
	public void setLevel(Integer level) {
		this.level = level;
	}
	public Integer getParentId() {
		return parentId;
	}
	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}
	public Byte getIsMenu() {
		return isMenu;
	}
	public void setIsMenu(Byte isMenu) {
		this.isMenu = isMenu;
	}
	@Override
	public String toString() {
		return "OperationItem [id=" + id + ", itemName=" + itemName + ", level=" + level + ", parentId=" + parentId
				+ ", isMenu=" + isMenu + "]";
	}	
	
	
}
