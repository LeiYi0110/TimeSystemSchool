package com.bjxc.school.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjxc.Page;
import com.bjxc.school.Device;
import com.bjxc.school.ServiceStation;
import com.bjxc.school.Tteacharea;
import com.bjxc.school.mapper.TteachareaMapper;

@Service
public class TteachareaService {
	@Resource
	private TteachareaMapper tteachareaMapper;

	
	public Page<Tteacharea> tteacharlist(String searchText,Integer pageIndex,Integer pageSize,Integer insId) {
		 Page<Tteacharea> page= new Page<Tteacharea>(pageIndex,pageSize); 		 
			Integer totalCount = tteachareaMapper.counteachar(searchText,insId);
			page.setRowCount(totalCount);
			if(totalCount > 0){
				List<Tteacharea> datas = tteachareaMapper.tteacharlist(searchText,page.getStartRow(),page.getPageSize(),insId);
				page.setData(datas);
			}
			return page;
	}
	
	public Tteacharea get(Integer id) {
		return tteachareaMapper.get(id);

	}

	public void add(Tteacharea tteacharea) {
		tteachareaMapper.add(tteacharea);
	}

	public void update(Tteacharea tteacharea) {
		tteachareaMapper.update(tteacharea);
	}
	
	public void adds(Tteacharea tteacharea){
		tteachareaMapper.add(tteacharea);
	}
	
	public Integer counteachar(String searchText,Integer insId){
		
		return tteachareaMapper.counteachar(searchText,insId);
	}
	
	public void disable(Tteacharea tteacharea){
		tteachareaMapper.disable(tteacharea);
	}
	
	public List<Tteacharea> selectdow(Integer insId){
		return tteachareaMapper.selectdow(insId);	
	}
	public Tteacharea findTteachArea(Integer id, Integer insId) {
		return tteachareaMapper.findTeachArea(id, insId);
	}

}
