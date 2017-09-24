package com.bjxc.school.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjxc.Page;
import com.bjxc.school.ServiceStation;
import com.bjxc.school.StudentCount;
import com.bjxc.school.mapper.StudentCountMapper;


@Service
public class StudentCountService {
	@Resource
	private StudentCountMapper studentCountMapper;
	
	public Page<StudentCount> getList(Date startTime,Date endTime,Integer insId,Integer stationId,Integer startIndex,Integer length){
		Page<StudentCount> page = new Page<StudentCount>(startIndex,length); 
		Integer totalCount = 100;
		page.setRowCount(totalCount);
		if(totalCount > 0){
			List<StudentCount> datas = studentCountMapper.getList(startTime,endTime,insId,stationId,page.getStartRow(),page.getPageSize());
			page.setData(datas);
		}
		return page;
	}
	
	public List<ServiceStation> getServiceStationAll(){
		return studentCountMapper.getServiceStationAll();
	}
}
