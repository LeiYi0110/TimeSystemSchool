package com.bjxc.school.mapper;

import java.util.List;

import com.bjxc.school.SystemConfig;

/**
 * @author levin
 */
public interface SystemConfigMapper {
	Integer add(SystemConfig obj);
	Integer update(SystemConfig obj);
	List <SystemConfig> getSystemConfigList();
	List<SystemConfig> getSystemConfigListByInscode(String Inscode);
	SystemConfig getSystemConfigById(Integer id);
}
