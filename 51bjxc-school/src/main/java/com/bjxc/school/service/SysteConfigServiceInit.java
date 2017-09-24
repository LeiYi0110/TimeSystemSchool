package com.bjxc.school.service;


import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Service;



@Service
public class SysteConfigServiceInit  implements ApplicationListener<ContextRefreshedEvent>{
    private static final Logger logger = LoggerFactory.getLogger(SysteConfigServiceInit.class);
    
	@Resource
	private SystemConfigService systemConfigService;
	
	
	@Override
	public void onApplicationEvent(ContextRefreshedEvent event) {
		if(event.getApplicationContext().getParent() == null){
			logger.info("Load system config....");
			systemConfigService.loadSystemConfig();
		}
	}

}
