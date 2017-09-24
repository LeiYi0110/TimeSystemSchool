package com.bjxc.school.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bjxc.Page;
import com.bjxc.Result;
import com.bjxc.school.*;
import com.bjxc.school.security.UsinInfo;
import com.bjxc.school.service.StudentRefereeService;
import com.bjxc.web.utils.WebUtils;

/**
* 报名action
* @author yy
* @date : 2016年9月18日 下午2:26:29
*/
@Controller
@RequestMapping(value="/referee")
public class StudentRefereeController {
	private static final Logger logger = LoggerFactory.getLogger(StudentRefereeController.class);
	@Resource
	private StudentRefereeService refereeService;
	
	/**
	 * app报名列表
	 */
	@ResponseBody
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public Result list(@RequestParam(value="searchText", required=false)String searchText,HttpServletRequest request){
		Result result = new Result();
		Integer pageIndex=WebUtils.getParameterIntegerValue(request, "pageIndex");
		Integer pageSize=WebUtils.getParameterIntegerValue(request, "pageSize");
		Integer status=WebUtils.getParameterIntegerValue(request, "status");
		if(status==null){		//初次进来
			status=0;
		}else if (status==3) {
			status=null;
		}
		Map map=new HashMap();
		map.put("insId", request.getParameter("insId"));
		map.put("status", status);
		map.put("pageIndex", pageIndex);
		map.put("pageSize", pageSize);
		try {
			Page<StudentReferee> pages=refereeService.list(map);
			//List<StudentReferee> datas=refereeService.list(map);
			result.success(pages.getData());
			result.put("rowCount", pages.getRowCount());
		} catch (Exception e) {
			logger.error("报名列表",e);
			result.error(e);
		}
		return result;
	}
	
	
	@RequestMapping(value="/{id}",method=RequestMethod.GET)
	public String update(@PathVariable Integer id,HttpServletRequest request){
		try {
			StudentReferee referee = refereeService.get(id);
			request.setAttribute("referee", referee);
		} catch (Exception e) {
			logger.error("报名通过",e);
		}
		return "studentEditor";
	}
	
	/**
	 * 获取学员的报名信息
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/studentRefereeList", method = RequestMethod.GET)
	public Result StudentRefereeList(StudentRefereeListParam param) {
		Result result = new Result();

		try {
			SecurityContext context = SecurityContextHolder.getContext();
			boolean has_ROLE_SCHOOL_MANAGER = context.getAuthentication().getAuthorities().stream()
					.filter(a -> a.getAuthority().equals("ROLE_SCHOOL_MANAGER")).count() > 0;// 判断是否有ROLE_SCHOOL_MANAGER权限，是否为机构账号
			UsinInfo usinInfo = (UsinInfo) context.getAuthentication().getPrincipal();
			Integer stationId = null;
			if (!has_ROLE_SCHOOL_MANAGER) {
				stationId = usinInfo.getStationId();
			}

			Date startTime = null;
			Date endTime = null;
			String searchText = null;
			
			param.setSearchText(param.getSearchText().trim());

			if (!StringUtils.isBlank(param.getSearchText())) {
				searchText = param.getSearchText();
			}
			if (param.getStartTime() > 0) {
				startTime = new Date(param.getStartTime());
			}
			if (param.getEndTime() > 0) {
				endTime = new Date(param.getEndTime());
			}

			Page<StudentRefereeInfo> page = refereeService.StudentRefereeList(usinInfo.getInsId(), stationId, startTime,
					endTime, searchText, param.getPageIndex(), param.getPageSize());

			result.success(page.getData());
			result.put("rowCount", page.getRowCount());

		} catch (Exception e) {
			result.error(e);
			logger.error("studentRefereeList --> ", e);
		}

		return result;
	}
}
