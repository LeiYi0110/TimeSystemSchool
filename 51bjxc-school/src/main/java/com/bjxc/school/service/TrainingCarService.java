package com.bjxc.school.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import com.bjxc.Page;
import com.bjxc.exception.DuplicateException;
import com.bjxc.school.Examiner;
import com.bjxc.school.Student;
import com.bjxc.school.TrainingCar;
import com.bjxc.school.mapper.TrainingCarMapper;

@Service
public class TrainingCarService {
	@Resource
	private TrainingCarMapper carMapper;
	
	public Page<TrainingCar> getList(String searchText,Integer insId,Integer pageIndex,Integer pageSize){
		Page<TrainingCar> page = new Page<TrainingCar>(pageIndex,pageSize);
		Integer totalCount = carMapper.total(searchText, insId);
		page.setRowCount(totalCount);
		if(totalCount > 0){
			List<TrainingCar> datas =carMapper.getList(searchText,insId,page.getStartRow(),page.getPageSize());
			page.setData(datas);
		}
		return page;
	}
	
	public List<TrainingCar> getAll(String insCode){
		return carMapper.getAll(insCode);
	}
	
	
	public TrainingCar getOne(Integer id){
		return carMapper.getOne(id);
	}
	
	public void update(TrainingCar car){
		carMapper.update(car);
	}
	/**
	 * 添加Excel中的数据到数据库
	 * @param car
	 */
	public void addByExcel(TrainingCar car){
		//检查是否已存在该车牌的教练车
		Assert.notNull(car.getLicnum());
		String licNum =carMapper.getByLicNum(car.getInscode(), car.getLicnum());
		if(licNum != null){
			throw new DuplicateException("本驾校已存在车牌号为 " + car.getLicnum() + " 的教练车");
		}
		carMapper.addByExcel(car);
	}
	
	public void add(TrainingCar car){
		carMapper.add(car);
	}
	
	public List<TrainingCar> carlist(){
		return carMapper.carlist();
		
	}
	public void adds(TrainingCar car){
		carMapper.adds(car);
	}
	public void deletes(TrainingCar car){
		carMapper.deletes(car);
	}
	
	public void updateIsprovince(String carnum){
		carMapper.updateIsprovince(carnum);
	}
}
