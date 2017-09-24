package com.bjxc.school.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.bjxc.school.StudentChangeStation;
import com.bjxc.school.mapper.StudentChangeStationMapper;

@Service
public class StudentChangeStationService {

	@Resource
	private StudentChangeStationMapper studentChangeStationMapper;

	public List<StudentChangeStation> list(Integer insId,Integer stationId,Integer status,Date startTime,Date endTime){
		List<StudentChangeStation> datas = studentChangeStationMapper.list(insId,stationId, status, startTime, endTime);
		if(CollectionUtils.isEmpty(datas)){
			return new ArrayList<StudentChangeStation>();
		}
		return datas;
	}

	public void add(StudentChangeStation studentChangeStation){
		studentChangeStationMapper.add(studentChangeStation);
	}
	
	public void update(Integer id,Integer status){
		studentChangeStationMapper.update(id,status);
	}
	
	public StudentChangeStation get(Integer id){
		return studentChangeStationMapper.get(id);
	}
	
}
