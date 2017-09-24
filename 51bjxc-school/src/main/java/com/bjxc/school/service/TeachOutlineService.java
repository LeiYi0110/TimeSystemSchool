package com.bjxc.school.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjxc.school.TeachOutline;
import com.bjxc.school.TeachOutlineSubjectFour;
import com.bjxc.school.TeachOutlineSubjectOne;
import com.bjxc.school.TeachOutlineSubjectThree;
import com.bjxc.school.TeachOutlineSubjectTwo;
import com.bjxc.school.mapper.TeachOutlineMapper;
import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException;

/**  
* @author huangjr  
* @date 2016年11月28日  创建  
*/
@Service
public class TeachOutlineService {
	@Resource
	private TeachOutlineMapper teachOutlineMapper;
	
	/**
	 * 添加教学大纲
	 * @param one
	 * @return
	 */
	public Integer add(Integer insId,String cartype,Integer subOneCourseNum,Integer subTwoCourseNum,Integer subThreeCourseNum,
			Integer subFourCourseNum) throws MySQLIntegrityConstraintViolationException{
		//科目一的学时
		TeachOutline subOne=new TeachOutline(cartype,1,subOneCourseNum,insId);
		//科目二的学时
		TeachOutline subTwo=new TeachOutline(cartype,2,subTwoCourseNum,insId);
		//科目三的学时
		TeachOutline subThree=new TeachOutline(cartype,3,subThreeCourseNum,insId);
		//科目四的学时
		TeachOutline subFour=new TeachOutline(cartype,4,subFourCourseNum,insId);
		Integer numberReturn=-1;
		numberReturn=teachOutlineMapper.add(subOne);
		numberReturn=teachOutlineMapper.add(subTwo);
		numberReturn=teachOutlineMapper.add(subThree);
		numberReturn=teachOutlineMapper.add(subFour);
		return numberReturn;
	}
	
	/**
	 * 更新教学大纲
	 */
	public Integer update(Integer insId,String cartype,Integer subOneCourseNum,Integer subTwoCourseNum,Integer subThreeCourseNum,
			Integer subFourCourseNum){
		//科目一的学时
		TeachOutline subOne=new TeachOutline(cartype,1,subOneCourseNum,insId);
		//科目二的学时
		TeachOutline subTwo=new TeachOutline(cartype,2,subTwoCourseNum,insId);
		//科目三的学时
		TeachOutline subThree=new TeachOutline(cartype,3,subThreeCourseNum,insId);
		//科目四的学时
		TeachOutline subFour=new TeachOutline(cartype,4,subFourCourseNum,insId);
		Integer numberReturn=-1;
		numberReturn=teachOutlineMapper.update(subOne);
		numberReturn=teachOutlineMapper.update(subTwo);
		numberReturn=teachOutlineMapper.update(subThree);
		numberReturn=teachOutlineMapper.update(subFour);
		return numberReturn;
	}
	
	/**
	 * 添加教学大纲 科目一学时表
	 * @param one
	 * @return
	 */
	public Integer addSubjectOne(TeachOutlineSubjectOne one) throws MySQLIntegrityConstraintViolationException{
			return teachOutlineMapper.addSubjectOne(one);
	}
	
	/**
	 * 添加教学大纲 科目二学时表
	 * @param one
	 * @return
	 */
	public Integer addSubjectTwo(TeachOutlineSubjectTwo one){
		return teachOutlineMapper.addSubjectTwo(one);
	}
	
	/**
	 * 添加教学大纲 科目三学时表
	 * @param one
	 * @return
	 */
	public Integer addSubjectThree(TeachOutlineSubjectThree one){
		return teachOutlineMapper.addSubjectThree(one);
	}
	
	/**
	 * 添加教学大纲 科目四学时表
	 * @param one
	 * @return
	 */
	public Integer addSubjectFour(TeachOutlineSubjectFour one){
		return teachOutlineMapper.addSubjectFour(one);
	}
	
	public Integer updateSubjectOne(TeachOutlineSubjectOne one){
		return teachOutlineMapper.updateSubjectOne(one);
	}
	
	public Integer updateSubjectTwo(TeachOutlineSubjectTwo one){
		return teachOutlineMapper.updateSubjectTwo(one);
	}
	
	public Integer updateSubjectThree(TeachOutlineSubjectThree one){
		return teachOutlineMapper.updateSubjectThree(one);
	}
	
	public Integer updateSubjectFour(TeachOutlineSubjectFour one){
		return teachOutlineMapper.updateSubjectFour(one);
	}

}
