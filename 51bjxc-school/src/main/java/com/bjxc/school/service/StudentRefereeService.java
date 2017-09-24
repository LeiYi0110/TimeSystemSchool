package com.bjxc.school.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import com.bjxc.Page;
import com.bjxc.school.Student;
import com.bjxc.school.StudentReferee;
import com.bjxc.school.StudentRefereeInfo;
import com.bjxc.school.mapper.StudentRefereeMapper;

/**
 * 报名管理
 * @author yy
 */
@Service
public class StudentRefereeService {
	@Resource
	private StudentRefereeMapper refereeMapper;
	
	public Page<StudentReferee> list(Map map){
		Integer pageIndex=Integer.parseInt(map.get("pageIndex")+"");
		Integer pageSize=Integer.parseInt(map.get("pageSize")+"");
		Page<StudentReferee> page = new Page<StudentReferee>(pageIndex,pageSize);
		Integer totalCount = refereeMapper.total(map);
		page.setRowCount(totalCount);
		if(totalCount > 0){
			map.put("start", page.getStartRow());
			map.put("size", page.getPageSize());
			List<StudentReferee> datas = refereeMapper.list(map);
			page.setData(datas);
		}
		return page;
	}
	
	public StudentReferee get(Integer id){
		refereeMapper.update(id);
		return refereeMapper.get(id);
	}
	
	public void update(String refereeName,String refereeMobile,Integer id){
		refereeMapper.updateName(refereeName, refereeMobile, id);
	}
	
	public Page<StudentRefereeInfo> StudentRefereeList(Integer insId, Integer stationId, Date startTime, Date endTime,
			String searchText, Integer pageIndex, Integer pageSize) {
		Page<StudentRefereeInfo> page = new Page<StudentRefereeInfo>(pageIndex, pageSize);

		Integer totalCount = refereeMapper.StudentRefereeTotal(insId, stationId, startTime, endTime, searchText);

		page.setRowCount(totalCount);
		if (totalCount > 0) {

			Integer startIndex = (pageIndex) * pageSize;

			List<StudentRefereeInfo> datas = refereeMapper.StudentRefereeList(insId, stationId, startTime, endTime,
					searchText, startIndex, pageSize);
			page.setData(datas);
		}

		return page;
	}
}
