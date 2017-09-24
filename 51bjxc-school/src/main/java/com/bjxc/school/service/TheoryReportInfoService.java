package com.bjxc.school.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjxc.Page;
import com.bjxc.school.ServiceStation;
import com.bjxc.school.TheoryReportInfo;
import com.bjxc.school.Tteacharea;
import com.bjxc.school.mapper.TheoryReportInfoMapper;

/**  
* @author huangjr  
* @date 2016年12月3日  创建  
*/
@Service
public class TheoryReportInfoService {
	@Resource
	TheoryReportInfoMapper theoryReportInfoMapper;
	
	public Page<TheoryReportInfo> getCourseList(Integer insId,Integer areaId,String beginCreateTiStr,String endCreateTiStr,Integer pageIndex, Integer pageSize){
		Page<TheoryReportInfo> page=new Page<TheoryReportInfo>(pageIndex,pageSize);
		Integer totalRows=theoryReportInfoMapper.totalCourseNum(insId,areaId,beginCreateTiStr,endCreateTiStr);
		page.setRowCount(totalRows);
		if(totalRows>0){
			List<TheoryReportInfo> list=theoryReportInfoMapper.getCourseList(insId,areaId,beginCreateTiStr,endCreateTiStr,page.getStartRow(),page.getPageSize());
			Integer totalCount=theoryReportInfoMapper.getSumNum(insId, areaId,beginCreateTiStr,endCreateTiStr);
			for (TheoryReportInfo theoryReportInfo : list) {
				theoryReportInfo.setTotalCount(totalCount);
				break;
			}
			page.setData(list);
		}
		return page;
	}
	
	/**
	 * 得到片区
	 * @param insId
	 * @return
	 */
	public List<Tteacharea> getAreas(Integer insId){
		return theoryReportInfoMapper.getAreas(insId);
	}
	
	public List<ServiceStation> getStations(Integer insId){
		return theoryReportInfoMapper.getStations(insId);
	}
	
	public List<ServiceStation> getStationByAreaId(Integer insId,Integer areaId){
		return theoryReportInfoMapper.getStationByAreaId(insId,areaId);
	}
	/**
	 * 查询需要导出的数据
	 * @param insId
	 * @param areaId
	 * @param beginCreateTiStr
	 * @param endCreateTiStr
	 * @return
	 */
	public List<TheoryReportInfo> getExportCourNum(Integer insId,Integer areaId,String beginCreateTiStr,String endCreateTiStr){
		 List<TheoryReportInfo> list= theoryReportInfoMapper.getCourseList(insId,areaId,beginCreateTiStr,endCreateTiStr,null,null);
		 Integer totalCount=theoryReportInfoMapper.getSumNum(insId, areaId,beginCreateTiStr,endCreateTiStr);
		 for (TheoryReportInfo theoryReportInfo : list) {
			theoryReportInfo.setTotalCount(totalCount);
			break;
		}
		return list;
	}
}
