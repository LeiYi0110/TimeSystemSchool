package com.bjxc.school.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bjxc.Result;
import com.bjxc.school.TeachOutline;
import com.bjxc.school.TeachOutlineSubjectFour;
import com.bjxc.school.TeachOutlineSubjectOne;
import com.bjxc.school.TeachOutlineSubjectThree;
import com.bjxc.school.TeachOutlineSubjectTwo;
import com.bjxc.school.service.TeachOutlineService;
import com.bjxc.web.utils.WebUtils;
import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException;

/**  
* @author huangjr  
* @date 2016年11月28日  创建  
*/
@Controller
@RequestMapping(value = "/teachoutline")
public class TeachOutlineController {
	private static final Logger logger = LoggerFactory.getLogger(TeachOutlineController.class);
	@Resource
	private TeachOutlineService teachOutlineService;
	
	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Result addTeachingProgramme(TeachOutlineSubjectOne subjectOne,TeachOutlineSubjectTwo subjectTwo,TeachOutlineSubjectThree subjectThree,TeachOutlineSubjectFour subjectFour
			,HttpServletRequest request){
		Result result = new Result();
		Integer insId=WebUtils.getParameterIntegerValue(request, "insId");
		String cartype=WebUtils.getParameterValue(request, "cartype");
		Integer subOneCourseNum=WebUtils.getParameterIntegerValue(request, "subOneCourseNum");
		Integer subTwoCourseNum=WebUtils.getParameterIntegerValue(request, "subTwoCourseNum");
		Integer subThreeCourseNum=WebUtils.getParameterIntegerValue(request, "subThreeCourseNum");
		Integer subFourCourseNum=WebUtils.getParameterIntegerValue(request, "subFourCourseNum");
		try {
			//科目一学时
			subjectOne.setCartype(cartype);
			subjectOne.setInsId(insId);
			try {
				teachOutlineService.addSubjectOne(subjectOne);
			} catch (Exception e) {
				subjectOne.setSubPeriodId(1);
				teachOutlineService.updateSubjectOne(subjectOne);
			}
			//科目二学时
			subjectTwo.setInsId(insId);
			subjectTwo.setCartype(cartype);
			try {
				teachOutlineService.addSubjectTwo(subjectTwo);
			} catch (Exception e) {
				subjectTwo.setSubPeriodId(2);
				teachOutlineService.updateSubjectTwo(subjectTwo);
			}
			
			//科目三学时
			subjectThree.setInsId(insId);
			subjectThree.setCartype(cartype);
			try {
				teachOutlineService.addSubjectThree(subjectThree);
			} catch (Exception e) {
				subjectThree.setSubPeriodId(3);
				teachOutlineService.updateSubjectThree(subjectThree);
			}
			
			//科目四学时
			subjectFour.setInsId(insId);
			subjectFour.setCartype(cartype);
			try {
				teachOutlineService.addSubjectFour(subjectFour);
			} catch (Exception e) {
				subjectFour.setSubPeriodId(4);
				teachOutlineService.updateSubjectFour(subjectFour);
			}
			
			try {
				teachOutlineService.add(insId,cartype,subOneCourseNum,subTwoCourseNum,subThreeCourseNum,subFourCourseNum);
			} catch (Exception e) {
				teachOutlineService.update(insId,cartype,subOneCourseNum,subTwoCourseNum,subThreeCourseNum,subFourCourseNum);
				result.setMessage("教学大纲更新成功");
			}
			result.success();
		} catch (Exception e) {
			logger.error(e.getMessage());
			result.error("");
		}
		return result;
	}
}
