package com.bjxc.school.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjxc.Page;
import com.bjxc.school.Eachoutline;
import com.bjxc.school.mapper.EachoutlineMapper;


@Service
public class EachoutlineService {
	@Resource
	private EachoutlineMapper eachoutlineMapper;
	
	public Page<Eachoutline> pageQuery(String cartype,Integer pageIndex,Integer pageSize ){
		Page<Eachoutline> page = new Page<Eachoutline>(pageIndex,pageSize); 
		Integer totalCount = eachoutlineMapper.total(cartype);
		page.setRowCount(totalCount);
		if(totalCount > 0){
			List<Eachoutline> datas =eachoutlineMapper.pageList(cartype,page.getStartRow(),page.getPageSize());
			page.setData(datas);
		}
		return page;
	}
	
	public Eachoutline get(Integer id){
		return eachoutlineMapper.get(id);
	}
	
	public void add(Eachoutline eachoutline){
		eachoutlineMapper.add(eachoutline);
	}
	
	public void update(Eachoutline eachoutline){
		eachoutlineMapper.update(eachoutline);
	}
}
