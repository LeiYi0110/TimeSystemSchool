package com.bjxc.school.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import com.bjxc.Page;
import com.bjxc.school.Coach;
import com.bjxc.school.CoachStation;
import com.bjxc.school.Complaint;
import com.bjxc.school.SchedulingTheory;
import com.bjxc.school.ServiceStation;
import com.bjxc.school.TheoryReportInfo;
import com.bjxc.school.mapper.SchedulingTheoryMapper;


@Service
public class SchedulingTheoryService {
	@Resource
	private SchedulingTheoryMapper schedulingTheoryMapper;

	
	/**
	 * 理论课上报
	 * @param stationId
	 * @param pageIndex
	 * @param pageSize
	 * @return
	 */
	public Page<SchedulingTheory> reportList(Integer stationId,Integer pageIndex,Integer pageSize){
		Page<SchedulingTheory> page = new Page<SchedulingTheory>(pageIndex,pageSize); 
		Integer totalCount = schedulingTheoryMapper.reportTotal(stationId);
		page.setRowCount(totalCount);
		if(totalCount > 0){
			List<SchedulingTheory> datas = schedulingTheoryMapper.reportList(stationId,page.getStartRow(),page.getPageSize());
			page.setData(datas);
		}
		return page;
	}
	
	/**
	 * 理论课排班
	 * @param stationId
	 * @param pageIndex
	 * @param pageSize
	 * @return
	 */
	public Page<SchedulingTheory> schedulingList(Integer stationId,Integer pageIndex,Integer pageSize){
		Page<SchedulingTheory> page = new Page<SchedulingTheory>(pageIndex,pageSize); 
		Integer totalCount = schedulingTheoryMapper.schedulingTotal(stationId);
		page.setRowCount(totalCount);
		if(totalCount > 0){
			List<SchedulingTheory> datas = schedulingTheoryMapper.schedulingList(stationId,page.getStartRow(),page.getPageSize());
			page.setData(datas);
		}
		return page;
	}
	
	/**
	 * 理论课排班
	 * @param stationId
	 * @param pageIndex
	 * @param pageSize
	 * @return
	 */
	public Page<SchedulingTheory> recordList(String classDate,Integer stationId,Integer pageIndex,Integer pageSize){
		Page<SchedulingTheory> page = new Page<SchedulingTheory>(pageIndex,pageSize); 
		Integer totalCount = schedulingTheoryMapper.recordTotal(classDate,stationId);
		page.setRowCount(totalCount);
		if(totalCount > 0){
			List<SchedulingTheory> datas = schedulingTheoryMapper.recordList(classDate,stationId,page.getStartRow(),page.getPageSize());
			page.setData(datas);
		}
		return page;
	}
	
	/**
	 * 理论报名上报人数
	 * @param coachPayFirst
	 */
	public void theoryUpdate(String[] ids){
		schedulingTheoryMapper.theoryUpdate(ids);
	}
	
	/**
	 * 理论排班提交名单
	 * @param coachPayFirst
	 */
	public void schedulingUpdate(String[] ids){
		schedulingTheoryMapper.schedulingUpdate(ids);
	}
	
	
	/**
	 * 导出理论上课排班记录
	 */
	public List<SchedulingTheory> exporTrecordList(Map map){
		return schedulingTheoryMapper.exporTrecordList(map);
		
	}
	
	/**
	 *	新增理论课上报统计信息
	 * @param insId,stationid,repNumber
	 */
	public void insertBySchedulingTheory(Integer insId,Integer stationId,Integer repNumber){
		schedulingTheoryMapper.insertByTheoryReportInfo(insId, stationId, repNumber);
		
	}
	
	/**
	 * 修改上课日期或备注
	 * @param schedulingTheory
	 */
	public void update(SchedulingTheory schedulingTheory){
		schedulingTheoryMapper.update(schedulingTheory);
	}
	
	/**
	 * 查询上次上报理论课信息
	 * @return
	 */
	public TheoryReportInfo getTheoryReportInfo(Integer insId,Integer stationId){
		return schedulingTheoryMapper.getTheoryReportInfo(insId,stationId);
	}
	
	/**
	 * 查询对应列表
	 * @param insId
	 * @param areaId
	 * @param staId
	 * @param classDate
	 * @param pageIndex
	 * @param pageSize
	 * @return
	 * @throws ParseException 
	 */
	public Page<SchedulingTheory> getScheTheoryList(Integer insId,Integer areaId,Integer staId,String classDate,Integer pageIndex,Integer pageSize){
		Page<SchedulingTheory> page=new Page<SchedulingTheory>(pageIndex,pageSize);
		Integer totalRows=schedulingTheoryMapper.totalTheoryNum(insId,areaId,staId,classDate);
		page.setRowCount(totalRows);
		if(totalRows>0){
			List<SchedulingTheory> list=schedulingTheoryMapper.getScheTheoryList(insId,areaId,staId,classDate,page.getStartRow(),page.getPageSize());
			page.setData(list);
		}
		return page;
	}
	/**
	 * 导出
	 * @param insId
	 * @param areaId
	 * @param staId
	 * @param classDate
	 * @return
	 */
	public List<SchedulingTheory> getExportScheduList(Integer insId,Integer areaId,Integer staId,String classDate){
		return schedulingTheoryMapper.getScheTheoryList(insId,areaId,staId,classDate,null,null);		
	}
	
	/**
	 * 理论排班提交名单
	 * @param coachPayFirst
	 */
	public void notReportedUpdate(String[] ids){
		schedulingTheoryMapper.notReportedUpdate(ids);
	}
	
	/**
	 * 添加理论课记录
	 * @param 
	 */
	public void insertSchedulingTheory(Integer studentId,Integer subjectId,Integer stationId){
		schedulingTheoryMapper.insertSchedulingTheory(studentId, subjectId,stationId);
	}
	/**
	 * 根据条件获取学员信息
	 * @param insId
	 * @param stationId
	 * @param studentName
	 * @return
	 */
	public List<SchedulingTheory> getByStudent(Integer insId,Integer stationId,String studentName){
		return schedulingTheoryMapper.getByStudent(insId, stationId, studentName);
	}
	
	/**
	 * 理论课排班学员添加
	 * @param schedulingTheory
	 */
	public void addSchedulingStu(SchedulingTheory schedulingTheory){
		schedulingTheoryMapper.addSchedulingStu(schedulingTheory);
	}
}