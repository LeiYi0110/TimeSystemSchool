package com.bjxc.school.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bjxc.school.TrainingCar;

public interface TrainingCarMapper {
	List<TrainingCar> getList(@Param("searchText")String searchText,@Param("insId")Integer insId,
			@Param("start")Integer start,@Param("size")Integer size);
	
	@Select("select * from trainingcar where inscode=#{insCode}")
	List<TrainingCar> getAll(String insCode);
	
	Integer total(@Param("searchText")String searchText,@Param("insId")Integer insId);
	
	@Select("select * from TrainingCar where id=#{id}")
	TrainingCar getOne(Integer id);
	
	@Insert("insert into TrainingCar(inscode,franum,engnum,licnum,platecolor,manufacture,brand,model,perdritype,buydate,photourl,carnum,buydate) values(#{inscode},#{franum},#{engnum},#{licnum},#{platecolor},#{manufacture},#{brand},#{model},#{perdritype},#{buydate},#{photourl},#{carnum},#{buydate})")
	Integer add(TrainingCar car);
	
	Integer update(TrainingCar car);

	List<TrainingCar> carlist();
	
	Integer adds(TrainingCar car);
	/**
	 * 
	 * @param licnum
	 * @return
	 */
	@Select("select licnum from TrainingCar where inscode=#{inscode} and licnum=#{licnum}")
	String getByLicNum(@Param("inscode")String inscode,@Param("licnum")String licnum);
	
	@Insert("insert into TrainingCar(inscode,insId,franum,engnum,licnum,platecolor,manufacture,photo,brand,model,perdritype,buydate,carnum)"
			+ " values(#{inscode},#{insId},#{franum},#{engnum},#{licnum},#{platecolor},#{manufacture},#{photo},#{brand},#{model},#{perdritype},#{buydate},#{carnum})")
	Integer addByExcel(TrainingCar car);
	
	
	void deletes(TrainingCar car);

	@Update("update TrainingCar set isProvince=0 where carnum=#{carnum}")
	Integer updateIsprovince(String carnum);
}
