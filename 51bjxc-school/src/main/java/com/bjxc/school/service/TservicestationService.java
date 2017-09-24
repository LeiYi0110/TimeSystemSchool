package com.bjxc.school.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;


import com.bjxc.school.ServiceStation;

import com.bjxc.school.mapper.TservicestationMapper;

@Service
public class TservicestationService {
	@Resource
	private TservicestationMapper tservicestationMapper;

	/**
	 * 查询网点
	 */
     public List<ServiceStation> gettation(){
    	 
		return tservicestationMapper.gettation();
     }

}
