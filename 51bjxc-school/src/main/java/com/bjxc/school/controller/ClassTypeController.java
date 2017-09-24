package com.bjxc.school.controller;

import java.util.Date;
import java.util.List;

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

import com.bjxc.Result;
import com.bjxc.school.ClassType;
import com.bjxc.school.service.ClassTypeService;
import com.bjxc.school.service.StudentService;
import com.bjxc.web.utils.WebUtils;

/**
 * 班型管理 新增 修改、停用
 * @author fwq
 *
 */
@RestController
@RequestMapping(value="/classType")
public class ClassTypeController {
	private static final Logger logger = LoggerFactory.getLogger(ClassTypeController.class);
	@Resource
	private ClassTypeService classTypeService;
	
	@Resource
	private StudentService studentService;
	
	/**
	 *班型列表 支持对班型名称的模糊搜索
	 */
	@RequestMapping(value="/list",method=RequestMethod.GET)
	@UserControllerLog(description = "获取班型列表")    
	public Result list(@RequestParam(value="insId", required=true)Integer insId,@RequestParam(value="searchText", required=false)String searchText){
		Result result = new Result();
		try {
			List<ClassType> datas = classTypeService.list(insId,searchText);
			result.success(datas);
		} catch (Exception e) {
			logger.error("classType field list",e);
			result.error(e);
		}
		return result;
	}
	
	/**
	 * 按ID找班型信息
	 * @param id 练车场地ID必填
	 * @return
	 */
	@RequestMapping(value="/{id}",method=RequestMethod.GET)
	@UserControllerLog(description = "按ID找班型信息")    
	public Result get(@PathVariable("id")Integer id){
		Result result = new Result();
		try {
			Assert.notNull(id,"not found Id");
			ClassType classType = classTypeService.get(id);
			result.success(classType);
		} catch (Exception e) {
			logger.error("classType field get ",e);
			result.error(e);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/addseq/{insId}",method=RequestMethod.GET)
	@UserControllerLog(description = "addseq")    
	public Result getAddSeq(@PathVariable("insId")Integer insId){
		Result result = new Result();
		try {
			Assert.notNull(insId,"not found insId");
			ClassType classType = classTypeService.Incrementselect(insId);
			if(classType==null){
				classType = new ClassType();
			}
			//没有班型的情况下，自动加1，mod by Levin 20161219
			int seq = 0;
			if( null != classType.getSeq() ){
				seq= classType.getSeq() + 1;
			}else{
				seq = seq +1 ;
			}
			String str = String.format("%04d", seq);   //最后插入的值*/	
			result.success(str);		
			
		} catch (Exception e) {
			logger.error(e.getMessage());
			result.error(e.getMessage());
		}
		return result;
	}

	/**
	 * 保存班型信息，前端传有ID参数为修改，没有ID信息为新增
	 * @param request web请求对象 
	 * @return
	 */
	@RequestMapping(method=RequestMethod.POST)
	@UserControllerLog(description = "保存班型信息")    
	public Result save(HttpServletRequest request){
		Integer id = WebUtils.getParameterIntegerValue(request, "id");
		Integer insId = WebUtils.getParameterIntegerValue(request, "insId");
		String classcurr = WebUtils.getParameterValue(request, "classcurr");
		String vehicletype = WebUtils.getParameterValue(request, "vehicletype");
		Integer shuttle = WebUtils.getParameterIntegerValue(request, "shuttle");
		Integer resRegular = WebUtils.getParameterIntegerValue(request, "resRegular");
		Double price = WebUtils.getParameterDoubleValue(request, "price");
		Integer coachType = WebUtils.getParameterIntegerValue(request, "coachType");
		String photo = WebUtils.getParameterValue(request, "photo");
		String description = WebUtils.getParameterValue(request, "description");
		Integer paymode = WebUtils.getParameterIntegerValue(request, "paymode");
		Integer seq = WebUtils.getParameterIntegerValue(request, "seq");
		Integer subject = WebUtils.getParameterIntegerValue(request, "subject");
		Integer trainningtime = WebUtils.getParameterIntegerValue(request, "trainningtime");
		Integer trainningmode = WebUtils.getParameterIntegerValue(request, "trainningmode");
		Integer chargemode = WebUtils.getParameterIntegerValue(request, "chargemode");
		String service = WebUtils.getParameterValue(request, "service");
		Integer isProvince=WebUtils.getParameterIntegerValue(request, "isprovince");
		
		Date uptime = new Date();
		Result result = new Result();
		try{
			ClassType classType = new ClassType();
			classType.setInsId(insId);
			classType.setClasscurr(classcurr);
			classType.setDrvingType(new Integer(0));
			classType.setStatus(1);
			classType.setVehicletype(vehicletype);
			if(price!=null){
				classType.setPrice(new Double(price)*10000.0);
			}
			classType.setDescription(description);
			classType.setPaymode(paymode);
			classType.setTrainningmode(trainningmode);
			classType.setSubject(subject);
			classType.setTrainningtime(trainningtime);
			classType.setChargemode(chargemode);
			classType.setService(service);
			classType.setUptime(uptime);
			classType.setShuttle(new Integer(0));
			classType.setResRegular(resRegular);
			classType.setCoachType(new Integer(1));
			classType.setPhoto(photo);
			classType.setSeq(seq);
			classType.setIsProvince(isProvince);
			if(id == null){
				classTypeService.add(classType);
			}else{
				classType.setId(id);
				classTypeService.update(classType);
			}
			result.success();
		}catch(Throwable ex){
			logger.error("save classType field ", ex);
			result.error(ex);
		}
		return result;	
	}
	
	@RequestMapping(value="/updatebeian",method=RequestMethod.POST)
	@UserControllerLog(description = "更新班型备案信息")
	public Result updateBeiAn(HttpServletRequest request){
		Integer id = WebUtils.getParameterIntegerValue(request, "id");
		Integer isProvince=WebUtils.getParameterIntegerValue(request, "isprovince");
		Result result=new Result();
		try {
			ClassType classType = new ClassType();
			classType.setId(id);
			classType.setIsProvince(isProvince);
			classTypeService.updateBeiAn(classType);
		} catch (Exception e) {
			logger.error("updateBeiAn classType field ", e.getMessage());
			result.error(e.getMessage());
		}
		return result;
	}
	
	/**
	 * 停用班型信息
	 * @param id 班型ID 必传
	 * @return
	 */
	@RequestMapping(value="/{id}",method=RequestMethod.DELETE)
	@UserControllerLog(description = "停用班型信息")
	public Result remove(@PathVariable("id")Integer id){
		Result result = new Result();
		try {
			Assert.notNull(id,"not found Id");
			classTypeService.updateClassTypeStatus(id,new Integer(0));
			result.success();
//			List<Student> aliveStudentList = studentService.getAliveStudentListByClassType(id);
//			if(aliveStudentList==null || aliveStudentList.size()==0){
//				classTypeService.updateClassTypeStatus(id,new Integer(0));
//				result.success();
//			}else{
//				result.error("该班型仍有正在学习的学员,不能被删除");
//			}
		} catch (Exception e) {
			logger.error("classType field delete ",e);
			result.error(e);
		}
		return result;
	}
}
