package com.bjxc.school.service;

import javax.annotation.Resource;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.bjxc.school.ReFund;
import com.bjxc.school.mapper.ReFundMapper;
/**
 * 退费
 * @author hjr
 *
 */
@Service
public class ReFundService {
	@Resource
	private ReFundMapper reFundMapper;
	/**
	 * 添加退费
	 * @param refund
	 */
	public void add(ReFund refund){
		reFundMapper.add(refund);
	}
	
}
