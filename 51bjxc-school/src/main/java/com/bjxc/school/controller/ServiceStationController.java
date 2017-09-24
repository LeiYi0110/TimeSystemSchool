package com.bjxc.school.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Delete;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bjxc.Page;
import com.bjxc.Result;
import com.bjxc.school.*;
import com.bjxc.school.security.SchoolUser;
import com.bjxc.school.service.DrivingFieldService;
import com.bjxc.school.service.ServiceStationService;
import com.bjxc.school.service.TteachareaService;
import com.bjxc.web.utils.WebUtils;

/**
* 报名网点管理
* @author yy
* @date : 2016年9月2日 下午3:38:03
*/
@RestController
@RequestMapping(value="/serviceStation")
public class ServiceStationController {
	private static final Logger logger = LoggerFactory.getLogger(ServiceStationController.class);
	@Resource
	private ServiceStationService enrollPointService;
	@Resource
	private DrivingFieldService dservice;
	@Resource
	private  TteachareaService tteachareaService;
	
	
	
	/**
	 *服务网点列表 支持对地址、负责人姓名的模糊搜索
	 */
	@RequestMapping(value="/list",method=RequestMethod.GET)
	@UserControllerLog(description = "服务网点列表 支持对地址、负责人姓名的模糊搜索")
	public Result list(@RequestParam(value="searchText", required=false)String searchText,HttpServletRequest request){
		Result result = new Result();
		Integer insId=Integer.parseInt(request.getParameter("insId"));
		Integer pageIndex=WebUtils.getParameterIntegerValue(request, "pageIndex");
		Integer pageSize=WebUtils.getParameterIntegerValue(request, "pageSize");
		
		try {
			Page<ServiceStation> page = enrollPointService.page(insId, searchText, pageIndex, pageSize);
			result.success(page.getData());
			result.put("rowCount", page.getRowCount());
		} catch (Exception e) {
			result.error(e);
			logger.error("服务网点搜索列表",e);
		}
		return result;
	}
	
	/**
	 * 根据地点查询服务网点（通用）
	 */
	@RequestMapping(value="/findByArea",method=RequestMethod.POST)
	@UserControllerLog(description = "根据地点查询服务网点（通用）")
	public Result findByArea(Integer id,Integer insId){
		Result result = new Result();
		try {
			List<ServiceStation> datas = enrollPointService.findByArea(id, insId);
			List<DrivingField> data=dservice.getByArea(id);
			result.success(datas);
			result.put("drivingfield", data);
		} catch (Exception e) {
			logger.error("根据地点查询服务网点",e);
			result.error(e);
		}
		return result;
	}
	
	
	
	/**
	 * 根据服务网点查询地点
	 */
	@RequestMapping(value="/findStationArea",method=RequestMethod.POST)
	@UserControllerLog(description = "根据服务网点查询地点")
	public Result findStationArea(Integer id,Integer insId){
		Result result = new Result();
		try {
			ServiceStation datas = enrollPointService.findStationArea(id, insId);
			result.success(datas); 
		} catch (Exception e) {
			logger.error("根据地点查询服务网点",e);
			result.error(e);
		}
		return result;
	}
	
	
	/**
	 * 按ID找练车场地信息
	 * @param id 练车场地ID必填
	 * @return
	 */
	@RequestMapping(value="/{id}",method=RequestMethod.GET)
	@UserControllerLog(description = "按ID找服务网点信息")
	public Result get(@PathVariable("id")Integer id){
		Result result = new Result();
		try {
			Assert.notNull(id,"id不能为空");
			ServiceStation station=enrollPointService.get(id);
			result.success(station);
		} catch (Exception e) {
			logger.error("服务网点查找 ",e);
			result.error(e);
		}
		return result;
	}
	
	
	/**
	 * 按ID停用
	 * @param id 
	 */
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	@UserControllerLog(description = "按ID停用服务网点信息")
	public Result Delete(Integer id){
		Result result = new Result();
		try {
			enrollPointService.delete(id);
		} catch (Exception e) {
			logger.error("服务网点删除",e);
			result.error(e);
		}
		return result;
	}
	
	
	/**
	 * 服务网点的新增修改
	 */
	@RequestMapping(value="/saveUpdate",method=RequestMethod.POST)
	@UserControllerLog(description = " 服务网点的新增修改")
	public Result saveOrUpdate(HttpServletRequest request){
		Result result = new Result();
		String address = WebUtils.getParameterValue(request, "address");
		Integer areaId = WebUtils.getParameterIntegerValue(request, "areaId");
		String name = WebUtils.getParameterValue(request, "name");
		String areaname = WebUtils.getParameterValue(request, "areaname");
		String functionary = WebUtils.getParameterValue(request, "functionary");
		String contactMobile = WebUtils.getParameterValue(request, "contactMobile");
		Integer id = WebUtils.getParameterIntegerValue(request, "id");
		Integer insId = WebUtils.getParameterIntegerValue(request, "insId");
		String location = WebUtils.getParameterValue(request, "location");
		ServiceStation serviceStation= new ServiceStation();
		try {
			serviceStation.setAddress(address);
			serviceStation.setAreaId(areaId);
			serviceStation.setArea(areaname);
			serviceStation.setName(name);
			serviceStation.setFunctionary(functionary);
			serviceStation.setContactMobile(contactMobile);
			serviceStation.setLocation(location);
			serviceStation.setInsId(insId);
			if(id==null){
				enrollPointService.add(serviceStation);
			}else {
				 serviceStation.setId(id);
				enrollPointService.update(serviceStation);
			}
		} catch (Exception e) {
			logger.error("服务网点增加修改",e);
			result.error(e);
		}
		return result;
	}
	
	
	
	@RequestMapping(value="finddon",method=RequestMethod.GET)
	@UserControllerLog(description = " 服务网点查找")
	public Result finddons(Integer id,Integer insId){		
		Result result = new Result();
		try {
			ServiceStation serviceStation=enrollPointService.dotdelete(id,insId);	
			result.success(serviceStation);
		} catch (Exception e) {
			logger.error("服务网点查找 ",e);
			result.error(e);
		}
		return result;
	}
}
