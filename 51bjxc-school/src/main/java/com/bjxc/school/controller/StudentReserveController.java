package com.bjxc.school.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.bjxc.Page;
import com.bjxc.Result;
import com.bjxc.school.ClassType;
import com.bjxc.school.Coach;
import com.bjxc.school.StudentReservePay;
import com.bjxc.school.service.ClassTypeService;
import com.bjxc.school.service.StudentReserveService;
import com.bjxc.web.utils.WebUtils;

/**
 * @author fwq
 *
 */
@RestController
@RequestMapping(value="/studentReservePay")
public class StudentReserveController {
	private static final Logger logger = LoggerFactory.getLogger(StudentReserveController.class);
	@Resource
	private StudentReserveService studentReserveService;
	
	/**
	 * 先付后学 payType = 2 先学后付 payType = 3
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public Result list(HttpServletRequest request){
		Result result = new Result();
		Integer payType=WebUtils.getParameterIntegerValue(request, "payType");
		Integer status=WebUtils.getParameterIntegerValue(request, "status");
		Integer insId=WebUtils.getParameterIntegerValue(request, "insId");
		Integer pageIndex=WebUtils.getParameterIntegerValue(request, "pageIndex");
		Integer pageSize=WebUtils.getParameterIntegerValue(request, "pageSize");
		String startTime=WebUtils.getParameterValue(request, "startTime");
		String endTime=WebUtils.getParameterValue(request, "endTime");
		String searchText=WebUtils.getParameterValue(request, "searchText");
		try {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date startDate = new Date();
			Date endDate = new Date();
			if(!StringUtils.isEmpty(startTime)){
				startDate = format.parse(startTime);
			}
			if(!StringUtils.isEmpty(endTime)){
				endDate = format.parse(endTime);
			}
			Page<StudentReservePay> page = studentReserveService.list(insId,searchText,payType,status,startDate,endDate,pageIndex,pageSize);
			result.success(page.getData());
			result.put("rowCount", page.getRowCount());
		} catch (Exception e) {
			logger.error("先付后学或先学后付搜索列表",e);
			result.error(e);
		}
		return result;
	}
	
	@RequestMapping(value="/update/{infoId}",method=RequestMethod.POST)
	public Result update(@PathVariable("infoId")Integer infoId){
		Assert.notNull(infoId,"infoId is null");
		Result result = new Result();
		try {
			studentReserveService.updateReserveInfoStatus(infoId);
			result.success();
		} catch (Throwable ex) {
			logger.error("驾校确认退费成功",ex);
			result.error(ex);
		}
		return result;
	}
	
	@RequestMapping(value="/updatePayOrder/{infoId}/{payNo}/{reserveId}",method=RequestMethod.POST)
	public Result updatePayOrder(@PathVariable("reserveId")Integer reserveId,@PathVariable("infoId")Integer infoId,@PathVariable("payNo")String payNo){
		Assert.notNull(infoId,"infoId is null");
		Assert.notNull(payNo,"payNo is null");
		Result result = new Result();
		try {
			studentReserveService.updateReserveStatus(reserveId);
			studentReserveService.updatePayOrder(payNo);
			result.success();
		} catch (Throwable ex) {
			logger.error("驾校确认退费成功",ex);
			result.error(ex);
		}
		return result;
	}
	
	
}
