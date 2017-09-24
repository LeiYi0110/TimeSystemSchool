package com.bjxc.school.enums;

import java.util.Arrays;

/**
 * 约车单创建类型
 * @author Administrator
 *
 */
public enum ReserveRoleType {
	Student(1),//学员创建
	Coach(2),//教练创建
	Institution(3);//驾校/网点创建
	
	private ReserveRoleType(int value) {
		// TODO Auto-generated constructor stub
		this.value = value;
	}
	
	public static ReserveRoleType valueOf(int value){
		return Arrays.asList(values()).stream()
				.filter(f -> f.getValue() == value)
				.findFirst().get();
	}
	
	private int value;

	public int getValue() {
		return value;
	}
	
	
}
