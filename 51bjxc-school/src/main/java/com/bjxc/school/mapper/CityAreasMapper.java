package com.bjxc.school.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.bjxc.school.Areas;
import com.bjxc.school.Tteacharea;

/**
* 城市与区域
* @author yy
* @date : 2016年9月12日 上午11:02:40
*/
public interface CityAreasMapper {
	@Select("select * from tdictareas where cityCode=440300")
	List<Areas> areasList();
	
	@Select("select * from tteacharea where astatus=1 and insId=#{insId}")
	List<Tteacharea> areaList(Integer insId);
}
