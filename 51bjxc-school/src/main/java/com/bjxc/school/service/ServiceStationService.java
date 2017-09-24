package com.bjxc.school.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import com.bjxc.Page;
import com.bjxc.school.ServiceStation;
import com.bjxc.school.mapper.ServiceStationMapper;

/**
 * 服务网点service
 */
@Service
public class ServiceStationService {
	@Resource
	private ServiceStationMapper enrollPointMapper;

	public Page<ServiceStation> page(Integer insId, String searchText, Integer pageIndex, Integer pageSize) {
		Page<ServiceStation> page = new Page<ServiceStation>(pageIndex, pageSize);
		Integer totalCount = enrollPointMapper.countStation(insId, searchText);
		page.setRowCount(totalCount);
		if (totalCount > 0) {
			List<ServiceStation> list = enrollPointMapper.list(insId, searchText, page.getStartRow(),
					page.getPageSize());		
		page.setData(list);
	
		}
		return page;
	}

	public List<ServiceStation> list(Integer insId, String searchText) {
		return enrollPointMapper.list(insId, searchText, 0, 1000);
	}

	public List<ServiceStation> findByArea(Integer id, Integer insId) {
		return enrollPointMapper.findByArea(id, insId);
	}

	public ServiceStation findStationArea(Integer id, Integer insId) {
		return enrollPointMapper.findStationArea(id, insId);
	}

	public ServiceStation get(Integer id) {
		return enrollPointMapper.get(id);
	}

	public void add(ServiceStation serviceStation) {
		enrollPointMapper.add(serviceStation);
	}

	public void delete(Integer id) {
		enrollPointMapper.delete(id);
	}

	public void update(ServiceStation serviceStation) {
		enrollPointMapper.update(serviceStation);
	}
	public ServiceStation dotdelete(Integer id,Integer insId){
		
		return enrollPointMapper.dotdelete(id,insId);
	}
	
	/**
	 * 根据机构号,得到网点
	 * @param insId
	 * @return
	 */
	public List<ServiceStation> getStationsByInsId(Integer insId){
		List<ServiceStation> stationList=new ArrayList<ServiceStation>();
		stationList=enrollPointMapper.getStationsByInsId(insId);
		return stationList;
	}

}
