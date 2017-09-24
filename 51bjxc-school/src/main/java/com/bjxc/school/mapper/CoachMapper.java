package com.bjxc.school.mapper;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bjxc.school.Coach;
import com.bjxc.school.CoachDuty;
import com.bjxc.school.CoachStation;
import com.bjxc.school.CoachTable;
import com.bjxc.school.ServiceStation;

public interface CoachMapper {
	List<Coach> list(@Param("searchText")String searchText,@Param("insId")Integer insId,@Param("stationId")Integer stationId,@Param("start")Integer start,@Param("size")Integer size);
	
	Integer total(@Param("insId")Integer insId,@Param("stationId")Integer stationId, @Param("searchText")String searchText);
	
	/**
	 * 根据教练id搜索报名网点
	 * @return
	 */
	@Select("select * from tservicestation where id=(select stationid from tcoachservice where coachid=#{id})")
	ServiceStation findByCoach(@Param("id")Integer id);
	
	/**
	 * 根据教练id更改教练与网点关系
	 * @param coachid,stationid
	 */
	@Update("update tcoachservice set stationid=#{stationId} where coachid=#{coachId}")
	Integer changeByCoach(@Param("coachId")Integer coachId,@Param("stationId")Integer stationId);
	
	/**
	 * 根据教练id新增教练与网点关系
	 * @param coachid,stationid
	 */
	@Insert("insert into tcoachservice(stationid,coachid) value(#{stationId},#{coachId})")
	Integer insertByCoach(@Param("coachId")Integer coachId,@Param("stationId")Integer stationId);
	
	@Select("select * from tcoachservice where coachId = #{coachId}")
	CoachStation getCoachService(@Param("coachId")Integer coachId);
	
	@Delete("delete from tcoach where id = #{id}")
	Integer delete(Integer id);
	
	@Select("select c.*,s.StationId from tcoach c left join TCoachService s on s.CoachId=c.id  where c.id = #{id}")
	Coach get(Integer id);
	
	/**
	 * 教练预约列表
	 * @param Map(insId驾校id，stationId网点id，date1大于，date2小于，name名字)
	 */
	List<CoachDuty> dutyList(Map map);
	
	Integer totalDuty(Map map);
	
	List<Map> dutyStu(@Param("day")Date day,@Param("coachId")Integer id);
	
	Integer add(Coach coach);
	/**
	 * 验证是否已存在身份证号
	 * @param insId 机构号
	 * @param idCard 身份证号
	 * @return
	 */
	@Select("select ID,UserId,InsId,`Name`,Sex,Idcard,Mobile,Address,Photo,Fingerprint,Drilicence,Occupationlevel,Dripermitted,"
			+ "Teachpermitted,Employstatus,Hiredate,Leavedate,Coachnum,Star,CreateTime,birth,DrivingTime,CarBrand,CarPlate,`Subject`,"
			+ "ReceiveTime,DrivingFieldID,`Language`,Occupationno,PhotoId,FingerprintId "
			+ " from tcoach where insId=#{insId} and idCard=#{idCard}")
	Coach getByIdcard(@Param("insId")Integer insId,@Param("idCard")String idCard);
	
	Integer addByExcel(Coach coach);
	
	Integer update(Coach coach);
	
	/**
	 * 下一科目可选教练
	 */
	List<Coach> coachList(@Param("insId")Integer insId,@Param("stationId")Integer stationId,@Param("subjectId")Integer subjectId);

	Integer updateDuty(Map map);
	
	@Select("select * from TCoach where id = #{id}")
	Coach getCoach(Integer id);
	
	@Select("select * from tcoach where coachnum=#{coachnum}")
	Coach getCoachByNum(@Param("coachnum")String coachnum);
	
	/**
	 * 导出教练信息
	 */
	List<Coach> exportCoachList(Map map);
	
	@Select("select Regular from tcoachdutyregular where coachId=#{coachId}")
	String getRegular(Integer coachId);
	
	List<Date> getDay(@Param("coachId")Integer coachId,@Param("day")String day);
	
	/**
	 * 添加教练出勤日
	 * @param coachDuty
	 * @return
	 */
	@Insert("insert into tcoachDuty(coachId,day,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,f19,f20,f21,Rest,Publish) VALUES(#{coachId},#{day},#{f6},#{f7},#{f8},#{f9},#{f10},#{f11},#{f12},#{f13},#{f14},#{f15},#{f16},#{f17},#{f18},#{f19},#{f20},#{f21},0,0)")
	int insertCoachDuty(CoachDuty coachDuty);
	
	@Select("select * from TCoach where insId = #{insId} and Mobile=#{mobile}")
	Coach getByMobile(Coach coach);
	
	/**
	 * 教练数据统计
	 * @param map
	 */
	List<CoachTable> getCoachSituation(Map map);
	
	@Update("update TCoach set employstatus=1,isProvince=0  where id=#{id};")
	void updatestatus(Coach coach);
	
	@Update("update TCoach set isProvince=0  where coachNum=#{coachNum};")
	Integer updateIsprovince(String coachNum);
	
	/**
	 * 获取教练集合，根据条件
	 * @param map
	 * @return
	 */
	List<Coach> getCoachCollector(Map map);
	
	/**
	 * 获取教练集合总数
	 * @param map
	 * @return
	 */
	Integer getCoachCollectorTotal(Map map);
	
	/**
	 * 获取网点端的所有教练 
	 * @param map
	 * @return
	 */
	List<Coach> getStationCoach(Map map);
	
	Coach getByCoachNum(@Param("coachNum") String coachNum, @Param("coachName") String coachName);
}
