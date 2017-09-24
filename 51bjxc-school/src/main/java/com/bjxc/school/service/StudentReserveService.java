package com.bjxc.school.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjxc.Page;
import com.bjxc.school.Coach;
import com.bjxc.school.StudentReservePay;
import com.bjxc.school.mapper.StudentReserveMapper;

@Service
public class StudentReserveService {

	@Resource
	private StudentReserveMapper studentReserveMapper;
	
	public Page<StudentReservePay> list(Integer insId,String searchText,Integer payType,Integer status,Date startTime,
			Date endTime,Integer pageIndex,Integer pageSize){
		Page<StudentReservePay> page = new Page<StudentReservePay>(pageIndex,pageSize);
		Map map=new HashMap();
		map.put("insId", insId);
		map.put("searchText", searchText);
		map.put("payType", payType);
		map.put("startTime", startTime);
		map.put("endTime", endTime);
		map.put("start", pageIndex);
		map.put("size", pageSize);
		map.put("status", status);
		Integer totalCount = studentReserveMapper.total(map);
		page.setRowCount(totalCount);
		if(totalCount > 0){
			List<StudentReservePay> datas = studentReserveMapper.list(map);
			page.setData(datas);
		}
		return page;
	}
	
	public void updateReserveStatus(Integer id){
		studentReserveMapper.updateReserveStatus(id);
	}
	
	public void updateReserveInfoStatus(Integer id){
		studentReserveMapper.updateReserveInfoStatus(id);
	}
	
	
	public void updatePayOrder(String payNo){
		studentReserveMapper.updatePayOrder(payNo);
	}
	
}
