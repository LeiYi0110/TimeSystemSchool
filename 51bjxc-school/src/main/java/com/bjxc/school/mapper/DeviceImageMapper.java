package com.bjxc.school.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.bjxc.school.DeviceImage;

/**
 * 实时图片处理
 * @author levin
 *
 */
public interface DeviceImageMapper {

	@Select("select * from tdeviceimage where trainingRecordId=#{trainingRecordId} order by createtime asc")
	List <DeviceImage> getDeviceImage(@Param("trainingRecordId")Integer trainingRecordId);
	
	
}
