package com.bjxc.school.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjxc.school.OperationLog;
import com.bjxc.school.mapper.OperationLogMapper;

@Service
public class OperationLogService {
	
	@Resource
	private OperationLogMapper operationLogMapper;

	public List<OperationLog> list(Integer insId, String searchText) {
		return operationLogMapper.list(insId,searchText);
	}

	public void add(OperationLog operationLog) {
		operationLogMapper.add(operationLog);
	}

}
