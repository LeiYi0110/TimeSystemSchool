package com.bjxc.school.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.bjxc.school.OperationLog;

public interface OperationLogMapper {

	List<OperationLog> list(@Param("insId")Integer insId, @Param("searchText")String searchText);

	@Insert("insert into toperationlog(logTime,logEvent,logUser,insId,remark) values(#{logTime},#{logEvent},#{logUser},#{insId},#{remark})")
	void add(OperationLog operationLog);

}
