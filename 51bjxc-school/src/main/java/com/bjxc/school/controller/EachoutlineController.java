package com.bjxc.school.controller;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.bjxc.Page;
import com.bjxc.Result;
import com.bjxc.school.Eachoutline;
import com.bjxc.school.service.EachoutlineService;

/**
 * 安全员管理新增、修改、删除
 * @author Administrator
 *
 */
@RestController
@RequestMapping(value="/eachoutline")
public class EachoutlineController {
	private static final Logger logger = LoggerFactory.getLogger(EachoutlineController.class);
	@Resource
	private EachoutlineService eachoutlineService;
	
	/**
	 *安全员  姓名的模糊搜索
	 */
	@RequestMapping(value="/list",method=RequestMethod.GET)
	@UserControllerLog(description = "安全员  姓名的模糊搜索")
	public Result pageQuery(@RequestParam(value="cartype", required=false)String cartype,Integer pageIndex,Integer pageSize){
		if(cartype==""){
			cartype="A1";
		}
		Result result = new Result();
		
		try {
			Page<Eachoutline> page = eachoutlineService.pageQuery(cartype,pageIndex,pageSize);
			result.success(page.getData());
			result.put("rowCount", page.getRowCount());
		} catch (Exception e) {
			logger.error("Eachoutline field list",e);
			result.error(e);
		}
		return result;
	}
	@RequestMapping(value="/{id}",method=RequestMethod.GET)
	@UserControllerLog(description = "安全员  信息")
	public Result get(@PathVariable Integer id,HttpServletRequest request){
		System.out.println(id+"dddddddddddddddddd");
		Assert.notNull(id,"id is null");
		Result result = new Result();
		try {
			Eachoutline security=eachoutlineService.get(id);
			result.success(security);
		} catch (Exception e) {
			logger.error("Eachoutline get",e);
		}
		return result;
	}
	@RequestMapping(value="/saveOrUpdate",method=RequestMethod.POST)
	@UserControllerLog(description = "安全员  保存或修改")
	public Result saveOrUpdate(Eachoutline eachoutline,HttpServletRequest request){
		Result result = new Result();
		try {
			if(eachoutline.getId()!=null){
				eachoutlineService.update(eachoutline);
			}else {
				eachoutlineService.add(eachoutline);
			}
		} catch (Exception e) {
			logger.error("Eachoutline saveOrUpdate",e);
			result.error(e);
		}
		return result;
	}
}
