package com.bjxc.school.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import com.bjxc.Page;
import com.bjxc.exception.DuplicateException;
import com.bjxc.school.AppUser;
import com.bjxc.school.InstitutionInfo;
import com.bjxc.school.PlatformUser;
import com.bjxc.school.mapper.InstitutionInfoMapper;
import com.bjxc.school.mapper.PlatformUserMapper;


@Service
public class InstitutionInfoService {
	@Resource
	private InstitutionInfoMapper institutionInfoMapper;
	
	@Resource
	private PlatformUserMapper platformUserMapper;
	
	public InstitutionInfo get(Integer id){
		InstitutionInfo institutionInfo=institutionInfoMapper.get(id);
		return institutionInfo;
	}
	
	public Integer getCountIns(String inscode){
		return institutionInfoMapper.getCountIns(inscode);
	}
	/**
	 * 得到驾校概况
	 * @return
	 */
	public void getGeneralSituation(Map map){
		institutionInfoMapper.getGeneralSituation(map);
	}
	
	public void add(InstitutionInfo institutionInfo){
		institutionInfoMapper.add(institutionInfo);
		PlatformUser user=new PlatformUser();
		Md5PasswordEncoder md5PasswordEncoder = new Md5PasswordEncoder();
		String password = md5PasswordEncoder.encodePassword("123456","");
		user.setInsId(institutionInfo.getId());
		user.setUserName(institutionInfo.getName());
		user.setPassword(password);
		user.setUrole(100);
		user.setStatus(1);
		platformUserMapper.insert(user);
		
	
	}
	public Integer getInsId(String inscode){
		Integer id =institutionInfoMapper.getInsId(inscode);
		return id;
	}
	
	/**
	 * 添加excel中的数据到数据库
	 * @param institutionInfo
	 */
	public void addByExcel(InstitutionInfo institutionInfo){
		//检查培训机构统一编号是否已存在
		Assert.notNull(institutionInfo.getInscode());
		Integer id =institutionInfoMapper.getInsId(institutionInfo.getInscode());
		if(id != null){
			throw new DuplicateException("已存在统一编号为 " + institutionInfo.getInscode() + " 的培训机构");
		}
		institutionInfoMapper.addByExcel(institutionInfo);
		PlatformUser user=new PlatformUser();
		Md5PasswordEncoder md5PasswordEncoder = new Md5PasswordEncoder();
		String password = md5PasswordEncoder.encodePassword("123456","");
		user.setInsId(institutionInfo.getId());
		user.setUserName(institutionInfo.getName());
		user.setPassword(password);
		user.setUrole(100);
		user.setStatus(1);
		platformUserMapper.insert(user);
		
	}
	
	public void update(InstitutionInfo institutionInfo){
		institutionInfoMapper.update(institutionInfo);
	}
	/**
	 * 查询所有机构
	 * @param searchText
	 * @param pageIndex
	 * @param pageSize
	 * @return
	 */
	public Page<InstitutionInfo> pageQuery(String searchText,Integer pageIndex,Integer pageSize ){
		Page<InstitutionInfo> page = new Page<InstitutionInfo>(pageIndex,pageSize); 
		Integer totalCount = institutionInfoMapper.total(searchText);
		page.setRowCount(totalCount);
		if(totalCount > 0){
			List<InstitutionInfo> datas =institutionInfoMapper.pageList(searchText,page.getStartRow(),page.getPageSize());
			page.setData(datas);
		}
		return page;
	}
	
	public List<InstitutionInfo> getAll(){
		return institutionInfoMapper.getAll();
	}
	
	/**
	 * 省备案
	 * @param id
	 */
	public void updateProvinceStatus(Integer id){
		institutionInfoMapper.updateProvinceStatus(id);
	}
	
	public InstitutionInfo getIns(String insName)
	{
		return institutionInfoMapper.getIns(insName);
	}
	
}
