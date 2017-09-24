package com.bjxc.school.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bjxc.school.CoachDuty;

public interface CoachDutyMapper {

	/**
	 * 获取教练时段的排班记录
	 * 
	 * @param coachId
	 * @param now
	 * @param enDate
	 * @return
	 */
	List<CoachDuty> list(@Param("coachId") Integer coachId, @Param("now") Date now, @Param("enDate") Date enDate);

	/**
	 * 更新教练某个时间的排班记录
	 * 
	 * @param coachId
	 * @param date
	 *            如期
	 * @param hour
	 *            小时
	 * @param work
	 *            是否工作，1工作，0休息，3被约
	 * @return
	 */
	Integer update(CoachDuty coachDuty);

	/**
	 * 批量增加出勤时间
	 * 
	 * @param list
	 * @return
	 */
	Integer insertCoachDutyList(List<CoachDuty> list);

	/**
	 * 创建排班记录
	 * 
	 * @param coachDuty
	 * @return
	 */
	Integer add(CoachDuty coachDuty);

	/**
	 * 获取教练某天的排班
	 * 
	 * @param coachId
	 * @param time
	 * @return
	 */
	CoachDuty searchCoach(@Param("coachId") Integer coachId, @Param("time") Date time);

}

