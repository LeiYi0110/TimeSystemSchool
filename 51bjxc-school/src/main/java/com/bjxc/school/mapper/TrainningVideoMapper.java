package com.bjxc.school.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.bjxc.school.TrainningImage;
import com.bjxc.school.TrainningVideo;

public interface TrainningVideoMapper {
	
	@Insert("insert into trainningvideo(traningrecordId,starttime,endtime,event,videoURL) values(#{traningrecordId},#{starttime},#{endtime},#{event},#{videoURL})")
	void add(TrainningVideo trainningVideo);

	@Select("select * from trainningvideo where traningrecordId=#{trainningRecordId}")
	List<TrainningVideo> getList(Integer trainningRecordId);
}
