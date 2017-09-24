package com.bjxc.school.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import org.aspectj.weaver.ast.And;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.NativeWebRequest;

import com.bjxc.Page;
import com.bjxc.json.JacksonBinder;
import com.bjxc.school.Areas;
import com.bjxc.school.ClassType;
import com.bjxc.school.Coach;
import com.bjxc.school.DrivingField;
import com.bjxc.school.OperationItem;
import com.bjxc.school.OperationItemNode;
import com.bjxc.school.PlatformUserAuth;
import com.bjxc.school.RoleAuth;
import com.bjxc.school.ServiceStation;
import com.bjxc.school.Tteacharea;
import com.bjxc.school.security.UsinInfo;
import com.bjxc.school.service.CityAreasService;
import com.bjxc.school.service.ClassTypeService;
import com.bjxc.school.service.CoachService;
import com.bjxc.school.service.DrivingFieldService;
import com.bjxc.school.service.OperationItemService;
import com.bjxc.school.service.ServiceStationService;

/**
 * 将动态数据静态化
 * @author cras
 *
 */
@RestController
@RequestMapping(value="/resources/js")
public class JSController {
	private static final Logger logger = LoggerFactory.getLogger(JSController.class);
	
	@Resource
	private ClassTypeService classTypeService;
	
	@Resource
	private ServiceStationService serviceStationService;
	
	@Resource
	private DrivingFieldService drivingFieldService;
	
	@Resource
	private CityAreasService areaService;
	
	@Resource
	private CoachService coachService;
	
	@Resource
	private OperationItemService operationItemService; 
	
	/**
	 * 班型
	 * @param insId 培训机构
	 * @return
	 */
	@RequestMapping(value="/classType/{insId}",method=RequestMethod.GET, produces="application/javascript;charset=utf-8")
	@UserControllerLog(description = "班型精据以js输出")
	public String classType(@PathVariable(value="insId")Integer insId){
		StringBuffer js = new StringBuffer(" var classTypes = ");
		try {
			StringBuffer data = new StringBuffer("");
			List<ClassType> datas = classTypeService.getList(insId);
			String djs = JacksonBinder.buildNonNullBinder().toJson(datas);
			data.append(djs);
			
			js.append(data + ";");
			
		} catch (Exception e) {
			logger.error("班型精据以js输出",e);
			js.append("[];");
		}
		return js.toString();
	}

	@RequestMapping(value="/serviceStation/{insId}",method=RequestMethod.GET, produces="application/javascript;charset=utf-8")
	@UserControllerLog(description = "服务网点搜索列表")
	public String serviceStation(@PathVariable(value="insId")Integer insId){
		StringBuffer js = new StringBuffer(" var serviceStations = ");
		try {
			List<ServiceStation> datas = serviceStationService.list(insId, null);
			String djs = JacksonBinder.buildNonNullBinder().toJson(datas);
			js.append(djs);
		} catch (Exception e) {
			logger.error("服务网点搜索列表",e);
		}
		return js.toString();
	}
	
	/**
	 * 练车场地
	 * @param insId 培训机构
	 * @return
	 */
	@RequestMapping(value="/drivingFied/{insId}",method=RequestMethod.GET, produces="application/javascript;charset=utf-8")
	@UserControllerLog(description = "练车场地精据以js输出")
	public String drivingFied(@PathVariable(value="insId")Integer insId){
		StringBuffer js = new StringBuffer(" var drivingFieds = ");
		try {
			
			List<DrivingField> data = drivingFieldService.list(null,insId);
			String djs = JacksonBinder.buildNonNullBinder().toJson(data);
			js.append(djs);
		} catch (Exception e) {
			logger.error("练车场地精据以js输出",e);
		}
		return js.toString();
	}
	
	/**
	 * 地区
	 * @param insId 培训机构
	 * @return
	 */
	@RequestMapping(value="/Areas",method=RequestMethod.GET, produces="application/javascript;charset=utf-8")
	@UserControllerLog(description = "地区精据以js输出")
	public String Areas(){
		StringBuffer js = new StringBuffer(" var areas = ");
		try {
			List<Areas> areasList=areaService.areasList();
			String djs = JacksonBinder.buildNonNullBinder().toJson(areasList);
			js.append(djs);
		} catch (Exception e) {
			logger.error("练车场地精据以js输出",e);
		}
		return js.toString();
	}
	/**
	 * 教学区域
	 * @param insId 培训机构
	 * @return
	 */
	@RequestMapping(value="/Area/{insId}",method=RequestMethod.GET, produces="application/javascript;charset=utf-8")
	@UserControllerLog(description = "教学区域精据以js输出")
	public String Area(@PathVariable(value="insId")Integer insId){
		StringBuffer js = new StringBuffer(" var areas = ");
		try {
			List<Tteacharea> areasList=areaService.areaList(insId);
			String djs = JacksonBinder.buildNonNullBinder().toJson(areasList);
			js.append(djs);
		} catch (Exception e) {
			logger.error("练车场地精据以js输出",e);
		}
		return js.toString();
	}
	
	/**
	 * 获取网点端的教练列表
	 * @return
	 */
	@RequestMapping(value = "/StationCoach",method = RequestMethod.GET ,produces="application/javascript;charset=utf-8" )
	@UserControllerLog(description = "获取网点端的教练列表")
	public String stationCoach(){
		StringBuffer js = new StringBuffer(" var stationCoach = ");
		
		SecurityContext context = SecurityContextHolder.getContext();
		UsinInfo sUsinInfo = (UsinInfo)context.getAuthentication().getPrincipal();
		
		if(sUsinInfo.getAuthorities().stream().filter(a -> a.getAuthority().equals("ROLE_SCHOOL_SERVICE")).count() > 0){
			//网点权限才可以获取
			try{
				List<Coach> coachs = coachService.getStationCoach(sUsinInfo.getStationId());
				String coachJson = JacksonBinder.buildNonNullBinder().toJson(coachs);
				js.append(coachJson);
			}
			catch(Exception ex){
				logger.error("网点端教练列表",ex);
			}
		}
		else{
			js.append("[];");
		}

		return js.toString();
	}
	/**
	 * 授权菜单
	 * @return
	 */
	@RequestMapping(value = "/operationItem",method = RequestMethod.GET ,produces="application/javascript;charset=utf-8" )
	@UserControllerLog(description = "授权菜单")
	public String operationItem(){
		StringBuffer js = new StringBuffer(" ;var operationItems = ");
		
		try{
			List<OperationItem> operationItems = operationItemService.getOperationItemMenuList();
			String operationItemJson = JacksonBinder.buildNonNullBinder().toJson(operationItems);
			js.append(operationItemJson);
			js.append(";");
			
		}catch(Exception exception){
			js.append("[];");
			logger.error("授权菜单列表",exception);
		}
		
		return js.toString();
	}
	/**
	 * 授权菜单按钮
	 * @return
	 */
	@RequestMapping(value = "/operationItemAll",method = RequestMethod.GET ,produces="application/javascript;charset=utf-8" )
	@UserControllerLog(description = "授权菜单按钮")
	public String operationItemAll(){
		StringBuffer js = new StringBuffer(" ;var operationItemsAll = ");
		
		try{
			List<OperationItem> operationItems = operationItemService.getALLOperationItemList();
			String operationItemJson = JacksonBinder.buildNonNullBinder().toJson(operationItems);
			js.append(operationItemJson);
			js.append(";");
			
		}catch(Exception exception){
			js.append("[];");
			logger.error("授权菜单列表",exception);
		}
		
		return js.toString();
	}
	
	@RequestMapping(value = "/operationItemByTree", method = RequestMethod.GET, produces = "application/javascript;charset=utf-8")
	@UserControllerLog(description = "授权菜单列表")
	public String operationItemByTree() {
		StringBuffer js = new StringBuffer(" ;var operationItemsByTree = ");

		try {
			List<OperationItem> operationItems = operationItemService.getALLOperationItemList();
			
			List<OperationItem> dabaiaoti = operationItems.stream().filter(f -> f.getParentId() == null)
					.collect(Collectors.toList());
			List<OperationItemNode> operationItemNodes = new ArrayList<>();
			
			for(OperationItem item : dabaiaoti){
				
				OperationItemNode node = new OperationItemNode();
				node.setId(item.getId());
				node.setItemName(item.getItemName());
				node.setIsMenu(item.getIsMenu());
				node.setLevel(item.getLevel());
				
				/*List<OperationItem> xiaoBiaoTie = operationItems.stream()
						.filter(f -> f.getParentId() == item.getId())
						.collect(Collectors.toList());*/
				
				List<OperationItemNode> childNodes = new ArrayList<>();
				
				for(Integer j = 0 ;j< operationItems.size() ;j++){
						
					OperationItem item_b = operationItems.get(j);
					
					if(item_b.getParentId() == null){
						continue;
					}
					if(!item_b.getParentId().equals(item.getId())){
						continue;
					}
					
					OperationItemNode operationItemNode = new OperationItemNode();
					operationItemNode.setId(item_b.getId());
					operationItemNode.setItemName(item_b.getItemName());
					operationItemNode.setIsMenu(item_b.getIsMenu());
					operationItemNode.setLevel(item_b.getLevel());
					operationItemNode.setParentId(item_b.getParentId());
					
					/*List<OperationItem> buttons = operationItems.stream()
							.filter(f -> (f.getIsMenu() == 0 && f.getParentId() == item_b.getId()))
							.collect(Collectors.toList());*/
					
					List<OperationItemNode> buttonsNode = new ArrayList<>();
					
					for(Integer i = 0 ;i< operationItems.size() ;i++){
						
						OperationItem item_btn = operationItems.get(i);
						
						if(item_btn.getParentId() == null){
							continue;
						}
						if(!item_btn.getParentId().equals(item_b.getId())){
							continue;
						}
						OperationItemNode btNode = new OperationItemNode();
						btNode.setId(item_btn.getId());
						btNode.setItemName(item_btn.getItemName());
						btNode.setIsMenu(item_btn.getIsMenu());
						btNode.setLevel(item_btn.getLevel());
						btNode.setParentId(item_btn.getParentId());
						
						buttonsNode.add(btNode);
					}
					
					operationItemNode.setChild(buttonsNode);
					
					childNodes.add(operationItemNode);
				}
				
				node.setChild(childNodes);
				
				operationItemNodes.add(node);
			}
			
			String operationItemJson = JacksonBinder.buildNonNullBinder().toJson(operationItemNodes);
			js.append(operationItemJson);
			js.append(";");

		} catch (Exception exception) {
			js.append("[];");
			logger.error("授权菜单列表", exception);
		}

		return js.toString();
	}
	
	/**
	 * 获取用户已经授权的菜单
	 * @return
	 */
	@RequestMapping(value = "/roleAuth/{role}", method = RequestMethod.GET, produces = "application/javascript;charset=utf-8")
	@UserControllerLog(description = "获取用户已经授权的菜单")
	public String roleAuth(@PathVariable(value = "role") Integer role) {
		StringBuffer js = new StringBuffer(" ;var roleAuths = ");

		try {
			List<RoleAuth> roleAuths = operationItemService.getRoleAuth(role);
			String roleAuthJson = JacksonBinder.buildNonNullBinder().toJson(roleAuths);
			js.append(roleAuthJson);
			js.append(";");
		} catch (Exception exception) {
			js.append("[];");
			logger.error("授权菜单列表", exception);
		}

		return js.toString();
	}

	@RequestMapping(value = "/platformUserAuth", method = RequestMethod.GET, produces = "application/javascript;charset=utf-8")
	@UserControllerLog(description = "获取用户授权菜单列表")
	public String platformUserAuth() {
		StringBuffer js = new StringBuffer(" ;var platformUserAuths = ");

		try {
			Integer pUserId = ((UsinInfo) SecurityContextHolder.getContext().getAuthentication().getPrincipal())
					.getId();

			List<PlatformUserAuth> platformUserAuths = operationItemService
					.getPlatformUserAuthByPlatformUserId(pUserId);
			String roleAuthJson = JacksonBinder.buildNonNullBinder().toJson(platformUserAuths);
			js.append(roleAuthJson);
			js.append(";");
		} catch (Exception exception) {
			js.append("[];");
			logger.error("授权菜单列表", exception);
		}

		return js.toString();
	}
	
	@RequestMapping(value = "/userRoles", method = RequestMethod.GET, produces = "application/javascript;charset=utf-8")
	@UserControllerLog(description = "获取用户授权菜单列表 userRoles")
	public String userRoles() {
		StringBuffer js = new StringBuffer(" ;var userRoles = ");

		try {
			UsinInfo usinInfo = (UsinInfo) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

			String roleAuthJson = JacksonBinder.buildNonNullBinder()
					.toJson(usinInfo.getAuthorities().stream().map(m -> m.getAuthority().toString()).collect(Collectors.toList()));
			js.append(roleAuthJson);
			js.append(";");
		} catch (Exception exception) {
			js.append("[];");
			logger.error("授权菜单列表", exception);
		}

		return js.toString();
	}
}
