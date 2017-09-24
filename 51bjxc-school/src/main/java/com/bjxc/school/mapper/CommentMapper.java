package com.bjxc.school.mapper;

import java.util.List;
import java.util.Map;


import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bjxc.school.CoachComment;
import com.bjxc.school.CommentInsCoach;
import com.bjxc.school.Evaluation;
import com.bjxc.school.StudentReserveComment;

public interface CommentMapper {
	List<Evaluation> getIns(@Param("insId")Integer insId,@Param("star")Integer star);
	
	CommentInsCoach getInsInfo(@Param("insId")Integer insId);
	
	List<CoachComment> getCoachComment(@Param("coachId")Integer coachId);
	
	Integer getCoachId(@Param("insId")Integer insId);
	
	CommentInsCoach getCoachInfo(@Param("coachId")Integer coachId);
	
	List<Map> getCoach(@Param("name")String name,@Param("insId")Integer insId);
	
	List<CommentInsCoach> commlist(@Param("insId")Integer insId,@Param("start")Integer start,@Param("size")Integer size,@Param("searchText")String searchText);
	
	Integer countcomm(@Param("insId")Integer insId,@Param("searchText")String searchText);
	
	List<CoachComment> getCoachCommentlist();
	
	List<Evaluation> shcoolcomm(@Param("insId")Integer insId,@Param("start")Integer start,@Param("size")Integer size,@Param("searchText")String searchText);
	
	Integer countshcoolcomm(@Param("insId")Integer insId,@Param("searchText")String searchText);
	
	List<CoachComment> coachdetails(@Param("id")Integer id);
	
	@Select("select *,stu.isCountry stuIsCountry from tevaluationInstitution eva left join TStudent stu on eva.studentId=stu.id where eva.id=#{id}")
	Evaluation get(@Param("id")Integer id);
	
	List<CommentInsCoach> exportcommlist(@Param("insId")Integer insId);
	
	List<Evaluation> exportshcoolcomm(@Param("insId")Integer insId);
	
	CommentInsCoach getComm(@Param("id")Integer id);
	/**
	 * 备案-学员评价教练
	 */
	@Update("update TStudentReserveComment set isCommProvince=#{isCommProvince} where id=#{id};")
	Integer updateCoachStatus(CommentInsCoach commentInsCoach);
	
	/**
	 * 备案-学员评价驾校
	 */
	@Update("update tevaluationInstitution set isCommProvince=#{isCommProvince} where id=#{id};")
	Integer updateEvalStatus(Evaluation evaluation);
	
	Integer insertEval(Evaluation evaluation);
	
	/**
	 * 创建评价
	 * @param comment
	 * @return
	 */
	Integer insertCoachComment(StudentReserveComment comment);
	

	/**
	 * 学员教练关系数量
	 * @param coachId
	 * @param studentId
	 * @return
	 */
	Integer countStudentCoach(@Param("coachId")Integer coachId , @Param("studentId")Integer studentId);
}
