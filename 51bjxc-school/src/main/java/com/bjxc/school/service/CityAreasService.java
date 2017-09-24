package com.bjxc.school.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjxc.school.Areas;
import com.bjxc.school.Tteacharea;
import com.bjxc.school.mapper.CityAreasMapper;

@Service
public class CityAreasService {
	@Resource
	private CityAreasMapper cityAreasMapper;
	
	public List<Areas> areasList(){
		return cityAreasMapper.areasList();
	}
	
	public List<Tteacharea> areaList(Integer insId){
		
		return cityAreasMapper.areaList(insId);
	}
	
}
