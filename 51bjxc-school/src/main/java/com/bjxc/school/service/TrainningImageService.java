package com.bjxc.school.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjxc.school.TrainningImage;
import com.bjxc.school.mapper.TrainningImageMapper;

@Service
public class TrainningImageService {
	@Resource
	private TrainningImageMapper trainningImageMapper;
	
	public void add(TrainningImage trainningImage) {
		trainningImageMapper.add(trainningImage);
	}
	
	public List<TrainningImage> getList(Integer trainningRecordId) {
		return trainningImageMapper.getList(trainningRecordId);
	}
}
