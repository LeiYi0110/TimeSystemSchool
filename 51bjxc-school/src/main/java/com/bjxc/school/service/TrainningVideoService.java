package com.bjxc.school.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjxc.school.TrainningImage;
import com.bjxc.school.TrainningVideo;
import com.bjxc.school.mapper.TrainningVideoMapper;

@Service
public class TrainningVideoService {

	@Resource
	private TrainningVideoMapper trainningVideoMapper;
	
	public void add(TrainningVideo trainningVideo) {
		trainningVideoMapper.add(trainningVideo);
	}
	
	public List<TrainningVideo> getList(Integer trainningRecordId) {
		return trainningVideoMapper.getList(trainningRecordId);
	}
}
