package com.bjxc.school.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bjxc.Page;
import com.bjxc.Result;
import com.bjxc.school.Device;
import com.bjxc.school.ServiceStation;
import com.bjxc.school.Tteacharea;
import com.bjxc.school.service.TteachareaService;
import com.bjxc.web.utils.WebUtils;

@RestController
@RequestMapping(value="/ttracharea")
public class TteachareaController {
	private static final Logger logger = LoggerFactory.getLogger(DeviceController.class);
	@Resource
	private  TteachareaService tteachareaService;
	
	
	
	@RequestMapping(value="/list",method=RequestMethod.GET)
	@UserControllerLog(description = "教学区域列表")    
	public Result list(@RequestParam(value="searchText", required=false)String searchText,Integer pageIndex,Integer pageSize,Integer insIdd){
		Result result = new Result();
		try {
			int	rowCount =tteachareaService.counteachar(searchText,insIdd);
			Page<Tteacharea> page=tteachareaService.tteacharlist(searchText, pageIndex, pageSize,insIdd);
			page.setRowCount(rowCount);
			result.put("rowCount",rowCount);
			result.success(page.getData());
		} catch (Exception e) {
			logger.error("device search",e);
			result.error(e);
		}
		return result;
	}
	
	@RequestMapping(value="/{id}",method=RequestMethod.GET)
	@UserControllerLog(description = "查看单个教学区域")    
	public Result get(@PathVariable("id")Integer id){
		Result result = new Result();
		try {
			Tteacharea tteacharea= tteachareaService.get(id);
			result.success(tteacharea);
		} catch (Exception e) {
			result.error(e);
		}
	
		return result;
	}

	
	@RequestMapping(value="/saveUpdates",method=RequestMethod.POST)
	@UserControllerLog(description = "保存或更新教学区域")    
	public Result save(Integer id,HttpServletRequest request){
		String name = WebUtils.getParameterValue(request, "name");
		String perdritype = WebUtils.getParameterValue(request, "perdritype");
		Integer insId = WebUtils.getParameterIntegerValue(request, "insId");
		Integer insIdd= WebUtils.getParameterIntegerValue(request, "insIdd");
		Result result = new Result();
		Tteacharea tteacharea= new Tteacharea();
		try{
			tteacharea.setName(name);
			tteacharea.setPerdritype(perdritype);
		
			if(id == null){
				tteacharea.setInsId(insIdd);
				tteachareaService.add(tteacharea);
			}else{
				tteacharea.setId(id);
				tteacharea.setInsId(insId);
				tteachareaService.update(tteacharea);;
			}
			result.success();
		}catch(Throwable ex){
			result.error(ex);
		}
		
		return result;	
	}
	
	
	@RequestMapping(value="/disables",method=RequestMethod.POST)
	public Result disables(Integer id){
		Result result = new Result();
		Tteacharea tteacharea= new Tteacharea();
		try {
			if(id!=null){
				 tteacharea.setId(id);
				 tteachareaService.disable(tteacharea);
			}
			result.success(tteacharea);
		} catch (Exception e) {
			result.error(e);
		}
		return result;
	}
	
	/**
	 * 查询教学区域
	 */
	@RequestMapping(value="/findTteachArea",method=RequestMethod.POST)
	@UserControllerLog(description = "查询教学区域")    
	public Result findTteachArea(Integer id,Integer insId){
		Result result = new Result();
		try {
			Tteacharea datas = tteachareaService.findTteachArea(id, insId);
			result.success(datas); 
		} catch (Exception e) {
			result.error(e);
		}
		return result;
	}
}
