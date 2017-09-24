package com.bjxc.school.mapper;


import java.util.List;


import com.bjxc.school.ServiceStation;
import com.bjxc.school.service.ServiceStationService;

public interface TservicestationMapper {

	
	/**
	 * 查询所有网点
	 * @param 
	 * @return
	 */
	List<ServiceStation> gettation();
}
