package com.bjxc.school.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.bjxc.school.TrainningImage;

public interface TrainningImageMapper {
	
	@Insert("insert into trainningimage(traningrecordId,imageTime,imageUrl) values(#{traningrecordId},#{imageTime},#{imageUrl})")
	void add(TrainningImage trainningImage);
	
	@Select("select * from trainningimage where traningrecordId=#{trainningRecordId}")
	List<TrainningImage> getList(Integer trainningRecordId);

}
