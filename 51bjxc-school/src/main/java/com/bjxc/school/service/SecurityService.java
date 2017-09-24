package com.bjxc.school.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import com.bjxc.Page;
import com.bjxc.exception.DuplicateException;
import com.bjxc.school.AppUser;
import com.bjxc.school.Security;
import com.bjxc.school.Student;
import com.bjxc.school.mapper.SecurityMapper;

@Service
public class SecurityService {
	@Resource
	private SecurityMapper securityMapper;
	
	public Page<Security> pageQuery(Integer insId,String searchText,Integer pageIndex,Integer pageSize ){
		Page<Security> page = new Page<Security>(pageIndex,pageSize); 
		Integer totalCount = securityMapper.total(insId,searchText);
		page.setRowCount(totalCount);
		if(totalCount > 0){
			List<Security> datas =securityMapper.pageList(insId,searchText,page.getStartRow(),page.getPageSize());
			page.setData(datas);
		}
		return page;
	}
	
	public Security get(Integer id){
		return securityMapper.get(id);
	}
	
	public void add(Security security){
		securityMapper.add(security);
	}
	/**
	 * 根据excel添加数据
	 * @param security
	 */
	public void addByExcel(Security security){
		//检查安全员身份证号是否已存在
		Assert.notNull(security.getIdcard());
		Security securitySecu =securityMapper.getByIdCard(security.getInsId(), security.getIdcard());
		if(securitySecu != null){
			throw new DuplicateException("本驾校已存在身份证号为 " + security.getIdcard() + " 的安全员");
		}
		securityMapper.add(security);
	}
	
	public void update(Security security){
		securityMapper.update(security);
	}
	/**
	 * 导出所有安全员信息
	 * @return
	 */
	public List<Security> exceporSecurity(Integer insId){
		return	securityMapper.securityList(insId);
	}
	
	public void updatestatus(Security security){
		securityMapper.updatestatus(security);
	}
	
	public void updateIsprovince(String secunum){
		securityMapper.updateIsprovince(secunum);
	}
}
