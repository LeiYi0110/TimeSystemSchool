package com.bjxc.school.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjxc.Page;
import com.bjxc.school.DrivingField;

import com.bjxc.school.TrainingCar;
import com.bjxc.school.mapper.DrivingFieldMapper;

/**
 * 场地应用服务
 * 
 * @author cras
 */
@Service
public class DrivingFieldService {

	@Resource
	private DrivingFieldMapper drivingFieldMapper;

	public Page<DrivingField> getPagelist(String searchText, Integer insId,Integer pageIndex,Integer pageSize) {
		Page<DrivingField> page = new Page<DrivingField>(pageIndex, pageSize);
		Integer totalCount = drivingFieldMapper.total(searchText, insId);
		page.setRowCount(totalCount);
		if (totalCount > 0) {
			List<DrivingField> datas = drivingFieldMapper.list(searchText, insId, page.getStartRow(),
					page.getPageSize());
			page.setData(datas);
		}
		return page;
	}
	
	public List<DrivingField> list(String searchText, Integer insId) {
		return drivingFieldMapper.list(searchText, insId,null,null);
	}
	
	public List<DrivingField> getByArea(Integer area){
		return drivingFieldMapper.getByArea(area);
	}
	
	public DrivingField get(Integer id) {
		return drivingFieldMapper.get(id);
	}

	public void add(DrivingField drivingField) {
		drivingFieldMapper.add(drivingField);
	}

	public void delete(Integer id) {
		drivingFieldMapper.delete(id);
	}

	public void update(DrivingField drivingField) {
		drivingFieldMapper.update(drivingField);
	}

	public void updateDrivingFieldStatus(Integer id, Integer status) {
		drivingFieldMapper.updateDrivingFieldStatus(id, status);
	}

	public List<DrivingField> carlist(Integer insId) {

		return drivingFieldMapper.carlist(insId);
	}
	
	public List<DrivingField> findByDriving(String name, Integer insId) {
		return drivingFieldMapper.findByDriving(name, insId);
	}
	public void updatestatus(DrivingField drivingField){
		drivingFieldMapper.updatestatus(drivingField);
	}
	
	public List<DrivingField> findByIdDriving(Integer id, Integer insId) {
		return drivingFieldMapper.findByIdDriving(id, insId);
	}
	public DrivingField Incrementselect(Integer insId){
		return drivingFieldMapper.Incrementselect(insId);
	}
	
	public void updateIsprovince(Integer seq,String inscode,Integer type){
		drivingFieldMapper.updateIsprovince(seq,inscode,type);
	}
	
	public void updateIsnotice(Integer seq,String inscode){
		drivingFieldMapper.updateIsnotice(seq, inscode);
	}
	
	public DrivingField findByCoach(Integer recordid){
		return drivingFieldMapper.findByCoach(recordid);
	}
}
