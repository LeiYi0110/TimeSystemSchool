package com.bjxc.school;

import java.util.List;

public class OperationItemNode extends OperationItem {
	
	private List<OperationItemNode> child;

	public List<OperationItemNode> getChild() {
		return child;
	}

	public void setChild(List<OperationItemNode> child) {
		this.child = child;
	}

}
