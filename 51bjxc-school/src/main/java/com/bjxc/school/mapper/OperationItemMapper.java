package com.bjxc.school.mapper;


import java.util.List;

import com.bjxc.school.OperationItem;

public interface OperationItemMapper {
	
	/**
	 * 获取全部菜单
	 * @return
	 */
	List<OperationItem> menuList();
	/**
	 * 获取全部菜单按钮
	 * @return
	 */
	List<OperationItem> list();
}
