package com.bjxc.school.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.bjxc.school.SystemConfig;
import com.bjxc.school.mapper.SystemConfigMapper;
import com.bjxc.school.utils.HTTPMap;

/**
 * 
 * @author levin
 *
 */

@Service
public class SystemConfigService{

    private static final Logger logger = LoggerFactory.getLogger(SystemConfigService.class);

    //变量值
    public final static String AutoCheckRecord = "AutoCheckRecord";
    
    //yyyyMMddHHmmss
    public final static String TrainningStartTime="TrainningStartTime";
    public final static String TrainningEndTime = "TrainningEndTime";
	
	@Resource
	private SystemConfigMapper systemConfigMapper;

	/**
	 * 更新机构配置参数
	 * @param systemConfig
	 */
	public void updateSystemConfig(SystemConfig systemConfig) {
		Integer result = systemConfigMapper.update(systemConfig);
		if (result > 0) {
			HTTPMap.getInstance().getSystemConfigMap().put(systemConfig.getFlagName(),
					systemConfig.getFlagValue());
		}
	}
	
	/**
	 * 根据机构编号获取对应的配置
	 * @param Inscode
	 * @return
	 */
	@UserServiceLog(description = "查询参数")    
	public List<SystemConfig> getSystemConfigListByInscode(String Inscode){
		return systemConfigMapper.getSystemConfigListByInscode(Inscode);
	}
	
	
	/**
	 * 获取系统所有机构的配置
	 * @return
	 */
	public List<SystemConfig> getSystemConfigList(){
		return systemConfigMapper.getSystemConfigList();
	}
	
	
	/**
	 * 加载所有配置，后续根据驾校登录加载，当前先采用初始加载的方式
	 */
	public void loadSystemConfig(){
		List <SystemConfig> systemConfigList = systemConfigMapper.getSystemConfigList();
		Map<String,String> systemconfigMap = HTTPMap.getInstance().getSystemConfigMap();
		for (SystemConfig systemConfig : systemConfigList) {
			systemconfigMap.put(systemConfig.getFlagName(), systemConfig.getFlagValue());
		}
	}
	
	/**
	 * 获取系统配置的值
	 * @param Inscode
	 * @param flag_name
	 * @return
	 */
	public String getSystemConfigValue(String Inscode,String flagName){
		return HTTPMap.getInstance().getSystemConfigMap().get(flagName);
	}
	
	
	public SystemConfig getSystemConfigById(Integer id){
		return systemConfigMapper.getSystemConfigById(id);
	}
	
	/**
	 * 获取培训开始时间
	 * @return yyyyMMddHHmmss
	 */
	public String getTrainningStartTime(){
		return HTTPMap.getInstance().getSystemConfigMap().get(TrainningStartTime);
	}
	
	/**
	 * 获取培训结束时间
	 * @return yyyyMMddHHmmss
	 */
	public String getTrainningEndTime(){
		return HTTPMap.getInstance().getSystemConfigMap().get(TrainningEndTime);
	}
	
	/**
	 * 是否自动检查日志
	 * @return
	 */
	public String getAutoCheckRecord(){
		return HTTPMap.getInstance().getSystemConfigMap().get(AutoCheckRecord);
	}
	

	
}
