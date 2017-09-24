package com.bjxc.school.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bjxc.school.CoachPayFirst;

public interface CoachPayFirstMapper {
	
	/**
	 * 新增
	 */
	@Insert("INSERT INTO tcoachpayfirst(coachId,price) VALUES(#{coachId},#{price})")
	void insertCoachPay(CoachPayFirst coachPayFirst);
	
	/**
	 * 教练ID查询
	 */
	@Select("SELECT * FROM tcoachpayfirst WHERE CoachID = #{coachId}")
	CoachPayFirst getCoachPayFirst(@Param("coachId")Integer coachId);
	
	/**
	 * 修改
	 */
	@Update("UPDATE tcoachpayfirst SET Price = ${price} WHERE coachId = #{coachId}")
	void updateCoachPay(CoachPayFirst coachPayFirst);
	
	
}
