package com.bjxc.school.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import com.bjxc.Page;
import com.bjxc.exception.DuplicateException;
import com.bjxc.school.AppUser;
import com.bjxc.school.Device;
import com.bjxc.school.mapper.DeviceMapper;

@Service
public class DeviceService {
	@Resource
	private DeviceMapper deviceMapper;
	
	public Page<Device> getList(String searchText,Integer pageIndex,Integer pageSize,Integer insId){
		 Page<Device> page= new Page<Device>(pageIndex,pageSize); 		 
			Integer totalCount = deviceMapper.totaldevice(searchText,insId);
			page.setRowCount(totalCount);
			if(totalCount > 0){
				List<Device> datas = deviceMapper.getList(searchText,page.getStartRow(),page.getPageSize(),insId);
				page.setData(datas);
			}
			return page;

	}
	
	public List<Device> getAll(){
		return deviceMapper.getAll();
	}
	
	public Device getOne(Integer id){
		return deviceMapper.getOne(id);
	}
	
	public List<Map> getCar(String name,Integer insId){
		return deviceMapper.getCar(name, insId);
	}
	
	public void add(Device one){
		//TODO:判断统一机构，同一个计时IEMI号，不重复添加
		
		deviceMapper.add(one);
	}
	
	/**
	 * 导入excel中 计时终端 的信息
	 * @param device
	 * @return
	 * @throws Exception
	 */
	public void addByExcel(Device device) throws Exception{
		//检查是否已存在  为  的计时终端
		Assert.notNull(device.getImei());	
		String deviceIm =deviceMapper.getByImei(device.getImei());
		if(deviceIm != null){
			throw new DuplicateException("本驾校已存在终端IMEI号或设备MAC地址为 " + device.getImei() + " 的计时终端");
		}
		deviceMapper.add(device);
	}
	
	public void update(Device one){
		deviceMapper.update(one);
	}
	
	public Integer totaldevice(String searchText,Integer insId){
		return deviceMapper.totaldevice(searchText,insId);	
	}
	
	public void addDevassign(String devnum,String sim,String carnum){
		deviceMapper.addDevassign(devnum, sim, carnum);
	}
	
	public void deletes(Device one){
		deviceMapper.deletes(one);
	}
	
	public void deleteDevassign(Integer id){
		deviceMapper.deleteDevassign(id);
	}
	
	public Map findLocal(Integer id){
		Map map=deviceMapper.findLocal(id);
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
		return map;
	}
	
	/**
	 * 计时终端对应的车辆列表
	 * @param insId
	 * @param searchText
	 * @return
	 */
	public Map getCarList(Integer insId,String searchText){
		Map<String,Object> map=new HashMap<>();
		List<Device> list=deviceMapper.getCarList(insId,searchText);
		int onlineNum=0;
		int offlineNum=0;
		for (Device device : list) {
			if(device.getLicnum()==null){
				device.setLicnum("未查到车牌号");
			}
			if(device.getIsLogin()!=null && device.getIsLogin()==1){
				onlineNum++;
			}else if(device.getIsLogin()==null || device.getIsLogin()==0){
				offlineNum++;
			}
		}
		map.put("deviceList", list);
		map.put("onlineNum",onlineNum);
		map.put("offlineNum",offlineNum);
		return map;
	}
	
	/**
	 * 根据车牌号 查询出一次信息
	 * @param licNum
	 * @return
	 * @throws ParseException 
	 */
	public Device getCarByLicNum(String licNum) throws ParseException{
		Device device= deviceMapper.getCarByLicNum(licNum);
		SimpleDateFormat format=new SimpleDateFormat("YYMMDDhhmmss");
		device.setTime(StringUtils.isNotBlank(device.getTimeStr())?
				format.parse(device.getTimeStr()):null);
		return device;
	}
}
