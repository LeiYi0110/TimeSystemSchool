package com.bjxc.school.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjxc.school.ClassType;
import com.bjxc.school.mapper.ClassTypeMapper;
/**
 * 班型服务
 * @author fwq
 *
 */
@Service
public class ClassTypeService {
	@Resource
	private ClassTypeMapper classTypeMapper;
	
	public List<ClassType> list(Integer insId,String searchText){
		return classTypeMapper.list(insId,searchText);
	}
	
	public ClassType get(Integer id){
		return classTypeMapper.get(id);
	}
	
	public void add(ClassType drivingField){
		classTypeMapper.add(drivingField);
	}
	
	public void delete(Integer id){
		classTypeMapper.delete(id);
	}
	
	public void updateClassTypeStatus(Integer id,Integer status){
		classTypeMapper.updateClassTypeStatus(id, status);
	}
	
	public void update(ClassType drivingField){
		classTypeMapper.update(drivingField);
	}
	
	public List<ClassType> getList(Integer insId){
		return classTypeMapper.getList(insId);
	}
	
	public ClassType Incrementselect(Integer insId){
		return classTypeMapper.Incrementselect(insId);
	}
	
	public void updateBeiAn(ClassType classType){
		classTypeMapper.updateBeiAn(classType);
	}
}
