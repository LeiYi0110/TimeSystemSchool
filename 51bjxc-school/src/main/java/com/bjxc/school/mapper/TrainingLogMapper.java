package com.bjxc.school.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bjxc.school.TrainingLog;
import com.bjxc.school.TrainingLogWithLocation;
import com.bjxc.school.TrainingRecord;

public interface TrainingLogMapper {
	List<TrainingLog> getList(@Param("recordId")String recordId,@Param("stunum")String stunum,@Param("day")String day,@Param("subjectId")String subjectId,@Param("inspass")String inspass,@Param("propass")String propass);

	List<Map> getLong(@Param("recordId")String recordId);
	
	@Update("update TrainingLog set inspass=#{pass},inreason=#{reason} where id=#{id}")
	Integer updatePass(@Param("pass")String pass,@Param("id")String id,@Param("reason")String reason);
	
	/**
	 * 批量通过或否决
	 * @param pass
	 * @param list
	 * @return
	 */
	Integer batchUpdatePass(@Param("pass")String pass ,@Param("inreason")String inreason ,@Param("list")List<Integer> list);
	
	//@Select("select id,imageurl,createtime from tdeviceimage where trainingRecordId in (select id from trainingrecord where studentId=(select id from tstudent where stunum=#{stunum}) and subjectid=#{subjectid})")
	//@Select("select id,imageurl,createtime,event,imageNum,inpass,reason from tdeviceimage where trainingRecordId = #{id}")
	List<Map> getPhoto(@Param("id")String id);
	
	List<Map> getGraduation(@Param("stuname")String stuname);
	
	List<String> getLongs(@Param("id")String recordId);
	
	List<Map> getLongAll(@Param("studentId") int studentId, @Param("subjectId") int subjectId);

	@Select("select tr.*,tc.id,tc.perdritype as trainingCarPerdritype,tc.isProvince as trainingCarIsProvince,rl.alertInfo,rl.status as locationStatus,rl.latitude,rl.longtitude,rl.carSpeed,rl.gpsSpeed,rl.orientation,rl.time,rl.sum_distance,rl.gasonline_cost,rl.elevation,rl.engine_speed from traininglog tr left join rlocationinfo rl on rl.id=tr.locationinfoid left join trainingrecord trr on trr.id=tr.trainingrecordid left join trainingcar tc on tc.id=trr.trainingcarid where tr.inspass is null or tr.inspass NOT IN(1,2,-1,-2)")
	List<TrainingLogWithLocation> getTrainingLogWithLocation();
	
	@Select("select tr.*,tc.id,tc.perdritype as trainingCarPerdritype,tc.isProvince as trainingCarIsProvince,rl.alertInfo,rl.status as locationStatus,rl.latitude,rl.longtitude,rl.carSpeed,rl.gpsSpeed,rl.orientation,rl.time,rl.sum_distance,rl.gasonline_cost,rl.elevation,rl.engine_speed from traininglog tr left join rlocationinfo rl on rl.id=tr.locationinfoid left join trainingrecord trr on trr.id=tr.trainingrecordid left join trainingcar tc on tc.id=trr.trainingcarid where tr.recordnum=#{recordnum} order by tr.recordtime desc limit 1")
	TrainingLogWithLocation getOneTrainingLogWithLocation(String recordnum);
	
	//获取该教学日志所有有效的学时记录
	@Select("select * from TrainingLog where trainingrecordid=#{trainingrecordid} and inspass IN(1,2)")
	List<TrainingLog> getLogList(@Param("trainingrecordid") Integer trainingrecordid);

	//所有学时判定无效
	@Update("update TrainingLog set inspass=#{inspass},inreason=#{inreason} where trainingrecordid=#{trainingrecordid}")
	Integer updateAllinspass(@Param("trainingrecordid") Integer trainingrecordid,@Param("inspass") Integer inspass,@Param("inreason") String inreason);
	
	//判定单个学时无效
	@Update("update TrainingLog set inspass=#{inspass},inreason=#{inreason} where id=#{id}")
	Integer updateinspass(@Param("id") Integer id,@Param("inspass") Integer inspass,@Param("inreason") String inreason);
	
	//获取学时总数
	@Select("select count(1) from TrainingLog where trainingrecordid=#{trainingrecordid}")
	Integer totalTrainingLog(@Param("trainingrecordid") Integer trainingrecordid);

	//获取有效学时总数
	@Select("select count(1) from TrainingLog where trainingrecordid=#{trainingrecordid} and inspass IN(1,2)")
	Integer totalValidTrainingLog(@Param("trainingrecordid") Integer trainingrecordid);
	
	@Select("select * from TrainingRecord where id=#{recordId}")
	TrainingRecord getTrainingRecord(@Param("recordId")Integer recordId);
	
	/**
	 * 获取学时记录的图片
	 * @param trainingId
	 * @return
	 */
	List<Map> getTrainingLogImage(Integer trainingId);
}
