package com.bjxc.school.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjxc.school.CoachDuty;
import com.bjxc.school.mapper.CoachDutyMapper;

@Service
public class CoachDutyService {
	
	@Resource
	private CoachDutyMapper coachDutyMapper;
	
	/**
	 * 获取教练指定时段的约车安排
	 * @param coachId
	 * @param now
	 * @param enDate
	 * @return
	 */
	public List<CoachDuty> list(Integer coachId , Date now , Date enDate){
		return coachDutyMapper.list(coachId, now, enDate);
	}
	
	/**
	 * 更新教练某个
	 * @param coachId
	 * @param date
	 * @param hour
	 * @param work
	 * @return
	 */
	public Integer update(CoachDuty coachDuty){
		return coachDutyMapper.update(coachDuty);
	}
	
	
	/**
	 * 创建排班记录
	 * @param coachDuty
	 * @return
	 */
	public Integer add(CoachDuty coachDuty){
		return coachDutyMapper.add(coachDuty);
	}
	
	/**
	 * 获取教练的一条排班记录
	 * @param coachId
	 * @param time
	 * @return
	 */
	public CoachDuty getCoach(Integer coachId , Date time){
		return coachDutyMapper.searchCoach(coachId, time);
	}
}