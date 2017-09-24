package com.bjxc.school.controller;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import com.bjxc.Result;
import com.bjxc.school.TrainingLog;
import com.bjxc.school.TrainingRecord;
import com.bjxc.school.service.CoordinateConversionService;
import com.bjxc.school.service.TrainingLogService;
import com.bjxc.web.utils.WebUtils;

/**
 * @author yy
 * 学时记录管理
 */
@RestController
@RequestMapping(value="/trainingLog")
public class TrainingLogController {
	private static final Logger logger = LoggerFactory.getLogger(TrainingLogController.class);
	
	@Resource
	private TrainingLogService trainingLogService;
	@Resource
	private CoordinateConversionService coordinateConversionService;
	
	@RequestMapping(value="/getList",method=RequestMethod.GET)
	@UserControllerLog(description = "教学日志列表")    
	public Result getList(HttpServletRequest request){
		Result result = new Result();
		try {
			String recordId = request.getParameter("recordId");
			String stunum = request.getParameter("stunum");
			String inspass = request.getParameter("inspass");
			String propass = request.getParameter("propass");
			if(stunum!=null){
				recordId=null;
			}
			String day = request.getParameter("day");
			String subjectId = request.getParameter("subjectId");
			List<TrainingLog> list=trainingLogService.getList(recordId, stunum, day, subjectId,inspass,propass);
			result.success(list);
		} catch (Exception e) {
			logger.error("TrainingLog 获取列表",e);
			result.error(e);
		}
		return result;
	}
	
	@RequestMapping(value="/getLong",method=RequestMethod.GET)
	public Result getLong(String recordId){
		Result result = new Result();
		try {
			//教学日志id
			result.success(trainingLogService.getLong(recordId));
		} catch (Exception e) {
			logger.error("TrainingLog 获取经纬度",e);
			result.error(e);
		}
		return result;
	}
	
	@RequestMapping(value="/getLong/{recordId}",method=RequestMethod.GET)
	public Result getLongs(@PathVariable String recordId){
		Result result = new Result();
		try {
			//教学日志id
			List<List<Map>> listMap=trainingLogService.getLongs(recordId);
			result.success(listMap);
		} catch (Exception e) {
			logger.error("TrainingLog 获取经纬度",e);
			result.error(e);
		}
		return result;
	}
	
	/**
	 * 获取学员科目的所有教学日志
	 * @param studentId
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/getLongAll/{recordId}" , method = RequestMethod.GET)
	public Result getLongAll(@PathVariable("recordId") Integer recordId){
		Result result = new Result();
		try{
			TrainingRecord trainingRecord = trainingLogService.getTrainingRecord(recordId);
			Integer studentId = trainingRecord.getStudentId();
			Integer subjectId = trainingRecord.getSubjectId();
			List<List<Map>> list = trainingLogService.getLongAll(studentId, subjectId);

			result.success(list);
		}catch(Exception e){
			logger.error("getLongAll 获取经纬度",e);
			result.error(e);
		}
		return result;
	}
	
	@RequestMapping(value="/updatePass",method=RequestMethod.POST)
	@UserControllerLog(description = "更新教学日志状态")    
	public Result updatePass(String pass,String id,String reason){
		Result result = new Result();
		try {
			Assert.notNull(id, "id不能为空");
			if(StringUtils.isEmpty(reason)){
				reason=null;
			}
			trainingLogService.updatePass(pass, id, reason);
		} catch (Exception e) {
			logger.error("TrainingLog 更新状态",e);
			result.error(e);
		}
		return result;
	}
	
	/**
	 * 批量更新学时日志
	 * @param pass
	 * @param ids
	 * @param reason
	 * @return
	 */
	@RequestMapping(value="/batchUpdatePass",method=RequestMethod.POST)
	@UserControllerLog(description = "批量更新教学日志状态")
	public Result batchUpdatePass(String pass, String ids, String reason) {
		Result result = new Result();
		try {
			Assert.notNull(ids, "ids不能为空");
			if (StringUtils.isEmpty(reason)) {
				reason = null;
			}
			List<Integer> idList = Arrays.asList(ids.split(",")).stream()
					.filter(f -> !StringUtils.isEmpty(f) && org.apache.commons.lang.StringUtils.isNumeric(f))
					.map(m -> Integer.valueOf(m)).collect(Collectors.toList());
			if(idList.size() > 0){
				Integer row = trainingLogService.batchUpdatePass(pass, reason, idList);
				result.success(row);
			}
		} catch (Exception e) {
			logger.error("TrainingLog 更新状态", e);
			result.error(e);
		}
		return result;
	}
	
	@RequestMapping(value="/searchPhoto",method=RequestMethod.GET)
	@UserControllerLog(description = "查看图片")    
	public Result searchPhoto(String id){
		Result result = new Result();
		try {
			result.success(trainingLogService.getPhoto(id));
		} catch (Exception e) {
			logger.error("TrainingLog 更新状态",e);
			result.error(e);
		}
		return result;
	}
	
	@RequestMapping(value="/graduation",method=RequestMethod.GET)
	@UserControllerLog(description = "查询学员学时进度")   
	public Result graduation(HttpServletRequest request){
		String stuname = WebUtils.getParameterValue(request, "stuname");
		Result result = new Result();
		result.success(trainingLogService.getGraduation(stuname));
		return result;
	}
	
	/**
	 * 查询学员学时进度照片
	 * @param trainingId
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/getTrainingLogImage/{trainingId}",method=RequestMethod.GET)
	@UserControllerLog(description = "查询学员学时进度照片")   
	public Result getTrainingLogImage(@PathVariable Integer trainingId){
		Result result = new Result();
		try{
			List<Map> list = trainingLogService.getTrainingLogImage(trainingId);
			result.success(list);
		}catch (Exception e) {
			logger.error("getTrainingLogImage 查询学员学时进度照片",e);
			result.error(e);
		}
		return result;
	}
}
