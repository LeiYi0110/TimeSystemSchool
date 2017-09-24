package com.bjxc.school.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import com.bjxc.Page;
import com.bjxc.exception.DuplicateException;
import com.bjxc.school.AppUser;
import com.bjxc.school.Examiner;
import com.bjxc.school.Security;
import com.bjxc.school.Student;
import com.bjxc.school.mapper.ExaminerMapper;

@Service
public class ExaminerService {
	@Resource
	private ExaminerMapper examinerMapper;
	
	public Page<Examiner> pageQuery(Integer insId,String searchText,Integer pageIndex,Integer pageSize ){
		Page<Examiner> page = new Page<Examiner>(pageIndex,pageSize); 
		Integer totalCount = examinerMapper.total(insId,searchText);
		page.setRowCount(totalCount);
		if(totalCount > 0){
			List<Examiner> datas =examinerMapper.pageList(insId,searchText,page.getStartRow(),page.getPageSize());
			page.setData(datas);
		}
		return page;
	}
	
	public Examiner get(Integer id){
		return examinerMapper.get(id);
	}
	
	public void add(Examiner examiner){
		examinerMapper.add(examiner);
	}
	/**
	 *  导入excel中的examiner中的数据
	 * @param examiner
	 */
	public void addByExcel(Examiner examiner){
		//检查考核员驾驶证件号是否已存在
		Assert.notNull(examiner.getIdcard());
		Examiner examinerIc =examinerMapper.getByIdcard(examiner.getInsId(), examiner.getIdcard());
		if(examinerIc != null){
			throw new DuplicateException("本驾校已存在身份证号为 " + examiner.getIdcard() + " 的考核员");
		}
		examinerMapper.add(examiner);
	}
	
	public void update(Examiner examiner){
		examinerMapper.update(examiner);
	}
	/**
	 * 导出所有考核员信息
	 * @return
	 */
	public List<Examiner> exceporExaminer(Integer insId){
		return	examinerMapper.examinerList(insId);
	}
	
	public void updatestutas(Examiner examiner){
		examinerMapper.updatestutas(examiner);
	}
	
	public void updateIsprovince(String examNum){
		examinerMapper.updateIsprovince(examNum);
	}
}
