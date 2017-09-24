package com.bjxc.school.controller;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.bjxc.Page;
import com.bjxc.Result;
import com.bjxc.school.Trefund;
import com.bjxc.school.service.TrefundService;
/**
 * 学员退费审核
 * @author Administrator
 *
 */
@RestController
@RequestMapping(value = "/Trefund")
public class TrefundController {
	private static final Logger logger = LoggerFactory.getLogger(TrefundController.class);
	
	@Resource
	private TrefundService trefundService;
	
	
	/**
	 * 退费列表
	 * @param insId
	 * @param stationId
	 * @param pageIndex
	 * @param pageSize
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public Result pageList(@RequestParam(value = "insId", required = true) Integer insId,
			@RequestParam(value = "stationId", required = false) Integer stationId,
			@RequestParam(value = "status", required = false) Integer status,
			@RequestParam(value = "time1", required = false) String time1,
			@RequestParam(value = "time2", required = false) String time2,
			Integer pageIndex,
			Integer pageSize
			){
		if(time1==""){
			time1=null;
		}
		if(time2==""){
			time2=null;
		}
		if(status ==-1){
			status=null;
		}
		Result result = new Result();
		try{
			Page<Trefund> page = trefundService.getTrefund(insId, stationId,status,time1,time2,pageIndex, pageSize);
			result.success(page.getData());
			result.put("rowCount", page.getRowCount());
		}catch(Exception e){
			logger.error("Trefund field expireList",e);
			result.error(e);
		}		
		return result;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public Result update(@RequestParam("arrId[]") List<Integer> arrId,
			@RequestParam("reviewUser")Integer reviewUser,
			@RequestParam("userNote")String userNote,
			@RequestParam("status")Integer status
			){
		Result result = new Result();
		try {
			int tmp = trefundService.update(arrId, userNote, status, reviewUser);
			result.put("tmp", tmp);
		} catch (Exception e) {
			logger.error("Trefund field update",e);
			result.error(e);
		}
		return result;
	}
}
