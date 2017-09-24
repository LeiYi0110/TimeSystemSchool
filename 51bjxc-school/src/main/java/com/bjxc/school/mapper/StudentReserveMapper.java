package com.bjxc.school.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

import com.bjxc.school.StudentReserve;
import com.bjxc.school.StudentReservePay;

public interface StudentReserveMapper {
	
	Integer add(StudentReserve reserve);
	
	Integer addInfo(StudentReserve reserve);
	
	Integer update(StudentReserve reserve);
	
	Integer total(Map map);
	
	List<StudentReservePay> list(Map map);
	
	@Update("update TStudentReserve set status = 1 where id = #{id} ")
	void updateReserveStatus(@Param("id")Integer id);
	
	@Update("update TStudentReserveInfo set status = -2 where id = #{id} ")
	void updateReserveInfoStatus(@Param("id")Integer id);
	
	@Update("update TPayOrder set status = 1 where payNo = #{payNo} ")
	void updatePayOrder(@Param("payNo")String payNo);
	
	/**
	 * 取消教练这个时间段的预约
	 * @param reserve
	 * @return
	 */
	Integer displayCoachReserveThisTime(StudentReserve reserve);
}
