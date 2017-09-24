package com.bjxc.school;

public class StudentRefereeListParam {
	private Long startTime;// 日期
	private Long endTime;
	private String searchText;// 学员名称/车型

	private Integer pageIndex;
	private Integer pageSize;

	public String getSearchText() {
		return searchText;
	}

	public void setSearchText(String searchText) {
		this.searchText = searchText;
	}

	public Long getStartTime() {
		return startTime;
	}

	public void setStartTime(Long startTime) {
		this.startTime = startTime;
	}

	public Long getEndTime() {
		return endTime;
	}

	public void setEndTime(Long endTime) {
		this.endTime = endTime;
	}

	public Integer getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(Integer pageIndex) {
		this.pageIndex = pageIndex;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	@Override
	public String toString() {
		return "StudentRefereeListParam [startTime=" + startTime + ", endTime=" + endTime + ", searchText=" + searchText
				+ ", pageIndex=" + pageIndex + ", pageSize=" + pageSize + "]";
	}

}
