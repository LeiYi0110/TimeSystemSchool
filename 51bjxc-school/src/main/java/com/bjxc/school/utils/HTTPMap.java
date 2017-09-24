package com.bjxc.school.utils;

import java.util.HashMap;
import java.util.Map;

/**
 * 保存系统配置
 * @author levin
 *
 */
public class HTTPMap {
	private static HTTPMap instance; 
	private Map<String, String> systemConfigMap;

	public static synchronized HTTPMap getInstance() {  
		if (instance == null) {  
	        instance = new HTTPMap();  
	    }  
	    return instance;  
	}
	
	private HTTPMap (){
		systemConfigMap = new HashMap<String, String>(10);
	}
	
	public synchronized  Map<String, String> getSystemConfigMap(){
		return systemConfigMap;
	}

}
