package com.bjxc.school.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import org.apache.ibatis.annotations.Param;
import org.apache.poi.util.Units;
import org.springframework.stereotype.Service;

import com.bjxc.school.TrainingLog;
import com.bjxc.school.TrainingLogWithLocation;
import com.bjxc.school.TrainingRecord;
import com.bjxc.school.mapper.TrainingLogMapper;

@Service
public class TrainingLogService {
	@Resource
	private TrainingLogMapper trainingLogMapper;
	
	public List<TrainingLog> getList(String recordId,String stunum,String day,String subjectId,String inspass,String propass){
		return trainingLogMapper.getList(recordId, stunum, day, subjectId,inspass,propass);
	}
	
	public List<Map> getLong(String recordId){
		List<Map> list=trainingLogMapper.getLong(recordId);
		for (Map map : list) {
			Integer latitude = (int)map.get("latitude");
			String st=latitude/1000000+"";
			String la=latitude%1000000+"";
			String ne=st+"."+la;
			map.put("latitude", ne);
			Integer longtitude = (int)map.get("longtitude");
			String sts=longtitude/1000000+"";
			String las=longtitude%1000000+"";
			String nes=sts+"."+las;
			map.put("longtitude", nes);
		}
		return list;
	}
	
	public List<List<Map>> getLongs(String recordId){
		List<String> list=trainingLogMapper.getLongs(recordId);
		List<List<Map>> mapList=new ArrayList<List<Map>>();
		for (String id : list) {
			List<Map> map=getLong(id);
			mapList.add(map);
		}
		return mapList;
	}
	
	/**
	 * 获取学员科目的全部学时记录
	 * @param studentId
	 * @param subjectId
	 * @return
	 */
	public List<List<Map>> getLongAll(Integer studentId, Integer subjectId) {
		List<Map> teMaps = trainingLogMapper.getLongAll(studentId, subjectId);
		List<Integer> records = teMaps.stream().filter(f -> f.get("recordId") != null)
				.map(m -> Integer.valueOf(m.get("recordId").toString())).distinct().collect(Collectors.toList());
		List<List<Map>> list = new ArrayList<>();
		for (Integer item : records) {
			List<Map> itemMap = teMaps.stream().filter(f -> f.get("recordId").toString().equals(item.toString()))
					.collect(Collectors.toList());
			
			itemMap.stream().forEach(u -> {
				if(u.get("latitude") != null){
					Integer latitude = Integer.valueOf(u.get("latitude").toString());
					String st = latitude / 1000000 + "";
					String la = latitude % 1000000 + "";
					String ne = st + "." + la;
					u.put("latitude", ne);
				}
				if(u.get("longtitude") != null){
					Integer longtitude = Integer.valueOf(u.get("longtitude").toString());
					String sts = longtitude / 1000000 + "";
					String las = longtitude % 1000000 + "";
					String nes = sts + "." + las;
					u.put("longtitude", nes);
				}
			});
			list.add(itemMap);
		}
		return list;
	}
	
	
	public void updatePass(String pass,String id,String reason){
		trainingLogMapper.updatePass(pass, id, reason);
	}
	
	public List<Map> getPhoto(String id){
		return trainingLogMapper.getPhoto(id);
	}
	
	public List<Map> getGraduation(String stuname){
		return trainingLogMapper.getGraduation(stuname);
	}

	public List<TrainingLogWithLocation> getTrainingLogWithLocation() {
		return trainingLogMapper.getTrainingLogWithLocation();
	}
	
	public TrainingLogWithLocation getOneTrainingLogWithLocation(String recordnum) {
		return trainingLogMapper.getOneTrainingLogWithLocation(recordnum);
	}
	
	public TrainingRecord getTrainingRecord(Integer recordId){
		return trainingLogMapper.getTrainingRecord(recordId);
	}
	
	/**
	 * 批量更新学时记录
	 * @param pass
	 * @param inreason
	 * @param list
	 * @return
	 */
	public Integer batchUpdatePass(String pass ,String inreason ,List<Integer> list){
		return trainingLogMapper.batchUpdatePass(pass, inreason, list);
	}
	
	/**
	 * 查询学员学时进度照片
	 * @param trainingId
	 * @return
	 */
	public List<Map> getTrainingLogImage(Integer trainingId){
		return trainingLogMapper.getTrainingLogImage(trainingId);
	}
}
