package com.bjxc.school.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bjxc.school.StudentChangeInstitution;

public interface StudentInstitutionMapper {
	/**
	 * 查询所有转出
	 * @param start
	 * @param size
	 * @return
	 */
	List<StudentChangeInstitution> fromList(@Param("fromInsId")Integer fromInsId,@Param("start")Integer start,@Param("size")Integer size,@Param("searchText")String searchText);
	/**
	 * 查询转出总记录
	 * @return
	 */
	Integer total(@Param("fromInsId")Integer fromInsId,@Param("searchText")String searchText);
	
	/**
	 * 查询所有转入
	 * @param start
	 * @param size
	 * @return
	 */
	List<StudentChangeInstitution> toList(@Param("toInsId")Integer toInsId,@Param("start")Integer start,@Param("size")Integer size,@Param("searchText")String searchText);
	/**
	 * 查询转入总记录
	 * @return
	 */
	Integer toTotal(@Param("toInsId")Integer toInsId,@Param("searchText")String searchText);
	
	/**
	 * 新增转机构
	 * @return 
	 */
	@Insert("insert into TStudentChangeInstitution(StudentId,FromInsId,ToInsId,Status,CreateUserID,CreateTime) VALUES(#{studentId},#{fromInsId},(select id from TInstitution where inscode=#{inscodes} limit 1),0,#{createUserId},now())")
	void add(StudentChangeInstitution studentChangeInstitution);
	
	/**
	 * 备案标识
	 * @param id
	 * @return
	 */
	/*StudentChangeInstitution updatestu(StudentChangeInstitution studentChangeInstitution);*/
	
	
	/**
	 * 根据id查询
	 * @param id
	 * @return
	 */
	@Select("select sci.*,stu.name as studentName,stu.sex,ins.name as insName,stu.Idcard as idcard from TStudentChangeInstitution sci left join TStudent stu on stu.id=sci.StudentID left join TInstitution ins on ins.ID=sci.toInsId where sci.id=#{id}")
	StudentChangeInstitution getid(Integer id);
	
	@Update("update tstudent set insid=(select id from TInstitution where inscode=#{inscodes} limit 1) where id=#{studentId}")
	void updateStuIns(StudentChangeInstitution studentChangeInstitution);
}
