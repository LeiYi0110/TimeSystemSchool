package com.bjxc.school.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjxc.school.TeachLog;
import com.bjxc.school.mapper.TeachLogMapper;

@Service
public class TeachLogService {
	@Resource
	private TeachLogMapper teachLogMapper;
	
	public List<TeachLog> getList(Map map){
		List<TeachLog> list=teachLogMapper.getList(map);
		for (TeachLog teachLog : list) {
			if(teachLog.getSubjectId()==2||teachLog.getSubjectId()==3){
				//临时用，消耗性能不推荐
				Map<String,Long> getMap=teachLogMapper.getMap(teachLog.getId());
				if(!getMap.isEmpty()){
					teachLog.setZero(getMap.get("zero"));
					teachLog.setFive(getMap.get("five"));
					teachLog.setBigfive(getMap.get("bigfive"));
				}
			}
		}
		return list;
	}
	
	public TeachLog getOne(Integer id){
		return teachLogMapper.getOne(id);
	}
	
	public void updateLog(Integer id){
		teachLogMapper.update(id);
	}
	
	public void add(TeachLog teachLog) {
		teachLogMapper.add(teachLog);
	}
	
	public Integer getLastTrainingLogCode(String studentnum){
		TeachLog lastTrainingLogCode = teachLogMapper.getLastTrainingLogCode(studentnum);
		if(lastTrainingLogCode==null){
			return 0;
		}
		return Integer.parseInt(lastTrainingLogCode.getEtrainingLogCode());
	}
	
	public Map getTimeRecord(Integer id,Integer subject){
		return teachLogMapper.getTimeRecord(id,subject);
	}
	
	public List<Map> getRecordMap(){
		List<Map> maps=teachLogMapper.getRecordMap();
		List<Map> newMap=new ArrayList<Map>();
		for (Map map : maps) {
			List<Map> map2=teachLogMapper.getRecordMapSub(map.get("stunum").toString());
			map.put("sub", map2);
			newMap.add(map);
		}
		return newMap;
	}
	
	public List<Map> getRecordCodeMap(Integer studentId,Integer subject){
		return teachLogMapper.getRecordCodeMap(studentId, subject);
	}
	
	public void addTimeRecord(HashMap<String, Object> map) {
		teachLogMapper.addTimeRecord(map);
	}
	
	public void updatePass(Integer id,Integer pass,String reason){
		teachLogMapper.updatePass(id,pass,reason);
	}
	
	/**
	 * 更新照片审核
	 * @param imageId
	 * @param pass
	 * @param reason
	 * @return
	 */
	public Integer updateImagePass(Integer imageId , Integer pass , String reason){
		return teachLogMapper.updateImagePass(imageId, pass, reason);
	}
	
	/**
	 * 批量审核教学日志
	 * @param ids
	 * @param pass
	 * @param reason
	 * @return
	 */
	public Integer udpateTeachLog(List<Integer> ids, Integer pass , String reason){
		return teachLogMapper.batchTeachLog(ids, pass, reason);
	}
}
