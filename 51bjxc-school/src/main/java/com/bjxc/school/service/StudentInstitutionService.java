package com.bjxc.school.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Service;

import com.bjxc.Page;
import com.bjxc.school.StudentChangeInstitution;
import com.bjxc.school.mapper.StudentInstitutionMapper;

@Service
public class StudentInstitutionService {
	
	@Resource
	private StudentInstitutionMapper studentInstitutionMapper;
	/**
	 * 查询转出记录
	 * @param pageIndex
	 * @param pageSize
	 * @return
	 */
	public Page<StudentChangeInstitution> pageQuery(Integer fromInsId,Integer pageIndex,Integer pageSize,String searchText ){
		Page<StudentChangeInstitution> page = new Page<StudentChangeInstitution>(pageIndex,pageSize); 
		Integer totalCount = studentInstitutionMapper.total(fromInsId,searchText);
		page.setRowCount(totalCount);
		if(totalCount > 0){
			List<StudentChangeInstitution> datas =studentInstitutionMapper.fromList(fromInsId,page.getStartRow(),page.getPageSize(),searchText);
			page.setData(datas);
		}
		return page;
	}
	
	/**
	 * 查询转入记录
	 * @param pageIndex
	 * @param pageSize
	 * @return
	 */
	public Page<StudentChangeInstitution> toPageQuery(Integer toInsId,Integer pageIndex,Integer pageSize,String searchText ){
		Page<StudentChangeInstitution> page = new Page<StudentChangeInstitution>(pageIndex,pageSize); 
		Integer totalCount = studentInstitutionMapper.toTotal(toInsId,searchText);
		page.setRowCount(totalCount);
		if(totalCount > 0){
			List<StudentChangeInstitution> datas =studentInstitutionMapper.toList(toInsId,page.getStartRow(),page.getPageSize(),searchText);
			page.setData(datas);
		}
		return page;
	}
	/**
	 * 新增
	 * @param studentChangeInstitution
	 */
	public void insertByStudentInstitution(StudentChangeInstitution studentChangeInstitution){
		
			studentInstitutionMapper.add(studentChangeInstitution);
			studentInstitutionMapper.updateStuIns(studentChangeInstitution);
	}

	/**
	 * 备案修改状态
	 * @param studentChangeInstitution
	 * @return
	 */
	   
	/*
	public StudentChangeInstitution updatestu(StudentChangeInstitution studentChangeInstitution){
		return studentChangeInstitution;
		
	}*/
	
	/**
	 * 根据id查询
	 * @param id
	 * @return
	 */
	public StudentChangeInstitution getid(Integer id){
		return studentInstitutionMapper.getid(id);
		
	}
}
