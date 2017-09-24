package com.bjxc.school.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjxc.Page;
import com.bjxc.school.Trefund;
import com.bjxc.school.mapper.TrefundMapper;

@Service
public class TrefundService {

	@Resource
	private TrefundMapper trefundMapper;	
	
	public Page<Trefund> getTrefund(Integer insId,Integer stationId,Integer status,String time1,String time2,Integer start,Integer size){
		Trefund a = new Trefund();
		Page<Trefund> page = new Page<Trefund>(start,size); 
		Integer totalCount = trefundMapper.total(insId,stationId,status,time1,time2);
		page.setRowCount(totalCount);
		if(totalCount > 0){
			List<Trefund> datas = trefundMapper.getTrefund(insId,stationId,status,time1,time2,page.getStartRow(),page.getPageSize());
			page.setData(datas);
		}
		return page;	
	}
	/**
	 * 返回审核人数
	 * @param arrId
	 * @param userNote
	 * @param status
	 * @param reviewUser
	 * @return
	 */
	public Integer update(List<Integer> arrId,String userNote,Integer status,Integer reviewUser){
		int count=0;
		for (Integer integer : arrId) {
			int cmp = trefundMapper.getTrefundstatus(integer);
			if(cmp==1){
				trefundMapper.updateTrefund(integer, status, userNote, reviewUser);
				count++;
			}
		}
		return count;
	}
}
