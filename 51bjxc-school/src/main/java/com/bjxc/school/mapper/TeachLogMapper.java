package com.bjxc.school.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bjxc.school.TeachLog;

public interface TeachLogMapper {
	List<TeachLog> getList(Map map);
	
	@Select("select (select count(1) from TrainingLog where trainingrecordid=#{id} and maxspeed=0) as zero,(select count(1) from TrainingLog where trainingrecordid=#{id} and maxspeed between 1 and 50) as five,(select count(1) from TrainingLog where trainingrecordid=#{id} and maxspeed>50) as bigfive from TrainingLog group by zero")
	Map<String,Long> getMap(Integer id);
	
	@Update("update trainingrecord set isProvince=1 where id=#{id}")
	Integer update(Integer id);
	
	//@Select("select tr.*,ts.name as stuname,ts.stunum,ti.inscode,rl.sum_distance as mileage,rl.carSpeed as avevelocity from trainingrecord tr INNER JOIN tstudent ts on ts.id=tr.studentid INNER JOIN TInstitution ti on ti.id=ts.insid LEFT JOIN tcoach tc on tc.id=tr.coachid LEFT JOIN tdevice td on td.id=tr.deviceid LEFT JOIN rlocationinfo rl on rl.id=tr.locationinfoid where tr.id=#{id}")
	TeachLog getOne(Integer id);
	
	@Insert("insert into trainingrecord(studentId,coachId,courseCode,trainingcarId,deviceId,starttime,endtime,courseType,subjectId,etrainingLogCode) "
			+ "values((select id from tstudent where stunum=#{stunum}),#{coachId},#{courseCode},#{trainingcarId},#{deviceId},#{starttime},#{endtime},#{courseType},#{subjectId},#{etrainingLogCode})")
	void add(TeachLog teachLog);
	
	@Select("select * from trainingrecord where studentId=(select id from tstudent where stunum=#{stunum}) order by id desc limit 1")
	TeachLog getLastTrainingLogCode(String stunum);
	
	Map getTimeRecord(@Param("id")Integer id,@Param("subject")Integer subject);
	
	List<Map> getRecordMap();
	
	@Select("select subjectid,valid,validtime,needfultime,t.url,j.pdfurl from jtrainingresult j left join timesystemfile t on t.id=j.pdfid where subjectid in (1,2,3,4,5) and stunum=#{stunum}")
	List<Map> getRecordMapSub(String stunum);
	
	@Select("select tl.recordnum as recordCode,tr.eTrainingLogCode from trainingrecord tr left join traininglog tl on tl.trainingrecordid=tr.id where tr.isProvince=1 and tr.studentId=#{id} and tr.subjectId=#{subject}")
	List<Map> getRecordCodeMap(@Param("id")Integer studentId,@Param("subject")Integer subject);
	
	@Insert("insert into jtrainingresult(inscode,stunum,subjectId,totaltime,duration,vehicletime,classtime,simulatortime,networktime,mileage,rectype,examresult,pdfurl) "
			+ "values(#{inscode},#{stunum},#{subjectId},#{totaltime},#{duration},#{vehicletime},#{classtime},#{simulatortime},#{networktime},#{mileage},#{rectype},#{examresult},#{pdfurl})")
	void addTimeRecord(HashMap<String, Object> map);
	
	@Update("update trainingrecord set pass=#{pass},reason=#{reason} where id=#{id}")
	void updatePass(@Param("id")Integer id,@Param("pass")Integer pass,@Param("reason")String reason);
	
	//获取所有未检测的教学日志
	@Select("select * from trainingrecord where (subjectId IN (2,3)) and ((inpass is null) or (inpass NOT IN(1,2,-1,-2))) ")
	List<TeachLog> getUnCheckList();
	
	
	@Update("update trainingrecord set inpass=#{inpass},inreason=#{inreason},logratio=#{logratio} where id=#{id}")
	void updateInPass(@Param("id")Integer id,@Param("inpass")Integer inpass,@Param("inreason")String inreason,@Param("logratio")Float logratio);
	
	/**
	 * 更新照片审核
	 * @param imageId
	 * @param pass
	 * @param reason
	 * @return
	 */
	Integer updateImagePass(@Param("imageId") Integer imageId, @Param("pass") Integer pass,
			@Param("reason") String reason);
	
	/**
	 * 批量更新教学日志
	 * @return
	 */
	Integer batchTeachLog(@Param("list") List<Integer> list, @Param("pass") Integer pass,
			@Param("reason") String reason);
}
