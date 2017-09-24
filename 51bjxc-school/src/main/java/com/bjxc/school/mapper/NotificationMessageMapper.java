package com.bjxc.school.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.bjxc.school.NotificationMessage;

public interface NotificationMessageMapper {
	
	@Insert("insert tnotificationmessage(content,inscode,createtime) values(#{content},#{inscode},#{createtime})")
	Integer add(NotificationMessage message);
	
	@Select("select * from tnotificationmessage order by id desc")
	List<NotificationMessage> list();

}
