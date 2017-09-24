package com.bjxc.school.controller;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bjxc.Page;
import com.bjxc.Result;
import com.bjxc.school.StudentCount;
import com.bjxc.school.service.StudentCountService;

@Controller
@RequestMapping(value="/count")
public class StudentCountController {
	@Resource
	private StudentCountService StudentCountService;
	
	private static final Logger logger = LoggerFactory.getLogger(StudentCountController.class);
	/*@RequestMapping("/tongji")
	public Result getList(){
		Result result=new Result();
		List<StudentCount> getList=StudentCountService.getList(1, 5);
		for (StudentCount studentCount : getList) {
			System.out.println(studentCount.getName()+"--"+studentCount.getStatidate()
			+"--"+studentCount.getCurrentcount()+"--"+studentCount.getGraduatestudentcount()
			+"--"+studentCount.getNewstudentcount()+"--"+studentCount.getStationId()+"--"+studentCount.getRowno());
		}		
		result.success(getList);
		return result;
	}*/
	
	/**
	 *学员过期管理  名称的模糊搜索
	 */
	@ResponseBody
	@RequestMapping(value="/tongji",method=RequestMethod.GET)
	public Result pageExpireQuery(@RequestParam()Date startTime,@RequestParam()Date endTime,
			@RequestParam()Integer insId,@RequestParam()Integer stationId,Integer pageIndex,Integer pageSize){		
		Result result = new Result();
		try {
			Page<StudentCount> page = StudentCountService.getList(startTime,endTime,insId,stationId,pageIndex,pageSize);
			result.success(page.getData());
			result.put("rowCount", page.getRowCount());
		} catch (Exception e) {
			logger.error("Student field expireList",e);
			result.error(e);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/page",method=RequestMethod.POST)
	public Result page(){		
		Result result = new Result();
		try {
		//	Page<StudentCount> page = StudentCountService.getList(0,7);
			//result.success(page.getData());
			result.put("ServiceStationAll", StudentCountService.getServiceStationAll());
		} catch (Exception e) {
			logger.error("Student field expireList",e);
			result.error(e);
		}
		return result;
	}
}
