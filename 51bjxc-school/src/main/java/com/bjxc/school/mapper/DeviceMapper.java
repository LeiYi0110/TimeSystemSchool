package com.bjxc.school.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bjxc.school.Device;

public interface DeviceMapper {
	List<Device> getList(@Param("searchText")String searchText,@Param("start")Integer start,@Param("size")Integer size,@Param("insId")Integer insId);
	
	@Select("select * from tdevice")
	List<Device> getAll();
	
	@Select("SELECT d.*,t.licnum,t.carnum,t.id as carId,de.sim FROM tdevice d left join tdevassign de on d.id=de.deviceId left join trainingcar t on de.trainingcarId=t.id where d.id=#{id}")
	Device getOne(Integer id);
	
	List<Map> getCar(@Param("name")String name,@Param("insId")Integer insId);
	
	Integer add(Device one);
	
	@Select("select imei from tdevice where imei=#{imei}")
	String getByImei(@Param("imei")String imei);
	
	@Insert("insert into tdevassign(deviceId,trainingcarId,sim) values((select id from tdevice where devnum=#{devnum} limit 1),(select id from trainingcar where carnum=#{carnum} limit 1),#{sim})")
	Integer addDevassign(@Param("devnum")String devnum,@Param("sim")String sim,@Param("carnum")String carnum);
	
	Integer update(Device one);
	
	@Update("update tdevassign set trainingcarId=#{carId} where deviceId=#{deviceId}")
	Integer updateDevassign(@Param("deviceId")Integer deviceId,@Param("carId")Integer carId);
	
	
	Integer totaldevice(@Param("searchText")String searchText,@Param("insId")Integer insId);
	
	/**
	 * 删除
	 * @param one
	 */
	void deletes(Device one);
	
	@Delete("delete from tdevassign where id=#{id}")
	Integer deleteDevassign(Integer id);
	
	Map findLocal(Integer id);
	
	/**
	 * 计时终端监控
	 * @param insId
	 * @param searchText
	 * @return
	 */
	List<Device> getCarList(@Param("insId")Integer insId,@Param("searchText")String searchText);
	
	/**
	 * 根据车牌号 查询出一次信息
	 * @param licnum
	 * @return
	 */
	Device getCarByLicNum(@Param("licnum")String licnum);
}
