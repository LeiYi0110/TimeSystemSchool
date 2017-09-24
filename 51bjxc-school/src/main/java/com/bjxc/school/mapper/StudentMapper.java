package com.bjxc.school.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bjxc.school.Student;
/**
 * 学生信息
 * @author fwq
 *
 */
public interface StudentMapper {
	/**
	 * 搜索栏
	 * @return 
	 */
	List<Student> pageList(@Param("chargemode")Integer chargemode,@Param("paymode")Integer paymode,@Param("stationName")String stationName,@Param("sex")Integer sex,@Param("insId")Integer insId,@Param("stationId")Integer stationId,@Param("traintype")String traintype,@Param("searchText")String searchText,@Param("time1")String time1,@Param("time2")String time2,@Param("subjectid")Integer subjectid,@Param("start")Integer start,@Param("size")Integer size);
	
	Integer total(@Param("chargemode")Integer chargemode,@Param("paymode")Integer paymode,@Param("stationName")String stationName,@Param("sex")Integer sex,@Param("insId")Integer insId,@Param("stationId")Integer stationId,@Param("traintype")String traintype,@Param("searchText")String searchText,@Param("time1")String time1,@Param("time2")String time2,@Param("subjectid")Integer subjectid);
	
	List<Student> getCoachStu(@Param("coachId")Integer coachId,@Param("searchText")String searchText,@Param("start")Integer start,@Param("size")Integer size);
	
	Integer totalCoachStu(@Param("coachId")Integer coachId,@Param("searchText")String searchText);
	
	/**
	 * 增加学生信息
	 * @return 
	 */
	Integer add(Student student);
	
	/**
	 * 增加Excel中的学生信息
	 */
	void addByExcel(Student student);
	
	/**
	 * 删除学生信息
	 * @return 
	 */
	@Delete("delete from tStudent where id = #{id}")
	Integer delete(Integer id);
	
	@Select("select count(1) from tstudent where stunum=#{stunum}")
	Integer getStunum(String stunum);
	
	/**
	 * 根据(id)查询学生信息
	 * @return 
	 */
	/*@Select("select st.*,se.name stationName,ct.classcurr classTypeName,re.refereeMobile as refereeMobiles,re.refereeName from  tStudent st left join TServiceStation se on st.StationId = se.id  left join tstudentReferee re on st.userId= re.userId left join TClassType ct on ct.id=st.ClassTypeId  where st.id = #{id}")*/
	Student get(@Param("id")Integer id);
	
	/**
	 * 根据(classType)查询所有学习中的学生信息
	 * @return 
	 */
	@Select("select * from tstudent where Status=2 and ClassTypeId = #{classType}")
	List<Student> getAliveStudentListByClassType(Integer classType);

	@Select("select * from  tStudent where Idcard = #{idcard} and insId = #{insId}")
	Student getByIdcard(@Param("insId")Integer insId,@Param("idcard")String  idcard);
	/**
	 * 修改学生信息状态
	 * @return 
	 */
	Integer update(Student student);
	
	
	Integer updateUser(Student student);
	

	void updateStatus(@Param("studentId")Integer studentId,@Param("status")Integer status,@Param("organno")String organno,@Param("certificateno")String certificateno,@Param("documenturl")String documenturl,@Param("signatureurl")String signatureurl);
	
	/**
	 * 查找可执教学员
	 */
	List<Map> stuCoachDuty(@Param("coachId")Integer coachId,@Param("subjectId")Integer subjectId,@Param("name")String name);
	
	
	/**
	 * 录入学员编号
	 * @param studentId
	 * @param stunum
	 */
	@Update("update tStudent set recordnum = #{recordnum} where id = #{studentId}")
	void updateStudentStunum(@Param("studentId")Integer studentId,@Param("recordnum")String recordnum);
	
	
	/**
	 * 根据电话号码查询学生信息
	 * @return 
	 */
	@Select("select st.*,se.name stationName from  tStudent st left join TServiceStation se on st.StationId = se.id where st.insId = #{insId} and st.mobile = #{mobile} ")
	Student getStudentByMobile(@Param("insId")Integer insId,@Param("mobile")String mobile);
	
	/**
	 * 搜索栏
	 * @return 
	 */
	List<Student> pageBaocuoList(@Param("insId")Integer insId,@Param("stationId")Integer stationId,@Param("searchText")String searchText,@Param("start")Integer start,@Param("size")Integer size);
	             
	Integer totalBaocuo(@Param("insId")Integer insId,@Param("stationId")Integer stationId,@Param("searchText")String searchText);
	
	/**
	 * 修改学员信息报错状态
	 * @param id
	 * @param isWrong
	 */
	@Update("update tStudent set isWrong = #{isWrong} where id = #{id}")
	void updateBaocuo(@Param("id")Integer id,@Param("isWrong")Integer isWrong);
	
	/**
	 * 搜索栏
	 * @return 
	 */
	List<Student> pageExpireList(@Param("insId")Integer insId,@Param("stationId")Integer stationId,@Param("searchText")String searchText,@Param("start")Integer start,@Param("size")Integer size);
	             
	Integer totalExpire(@Param("insId")Integer insId,@Param("stationId")Integer stationId,@Param("searchText")String searchText);
	
	/**
	 * 搜索栏
	 * @return 
	 */
	List<Student> pageWarningList(@Param("insId")Integer insId,@Param("stationId")Integer stationId,@Param("searchText")String searchText,@Param("start")Integer start,@Param("size")Integer size);
	             
	Integer totalWarning(@Param("insId")Integer insId,@Param("stationId")Integer stationId,@Param("searchText")String searchText);
	
	/**
	 * 查询所有学员信息
	 */
	List<Student> studentList(@Param("insId")Integer insId,@Param("stationId")Integer stationId);
	
	/**
	 * 查询学生账户
	 * @return
	 */
	List<Student> getAccountList(@Param("stationId")Integer stationId,@Param("start")Integer start,@Param("size")Integer size);
	
	/**
	 * 缴费流水列表
	 * @return
	 */
	List<Student> getPayWaterList(@Param("stuId")Integer stuId,@Param("stationId")Integer stationId,@Param("start")Integer start,@Param("size")Integer size);
	/**
	 * 缴费流水总条数
	 * @return
	 */
	Integer totalAccount(@Param("stationId")Integer stationId,@Param("stuId")Integer stuId);
	/**
	 * 是否是申请退费中
	 * @return
	 */
	Integer checkStuRefund(Integer id);
	
	List<Student> getCoachStudent(@Param("coachId")Integer coachId,@Param("searchText")String searchText);
	
	/**
	 * 根据(id)查询学员信息
	 * @return 
	 */
	@Select("select * from TStudent where InsId=#{insId} and id=#{id}")
	Student getByStudent(@Param("insId")Integer insId,@Param("id")Integer id);
	
	
	void updateisProvince(Student student);
	
	Student idcarname(String idcard);
	
	/**
	 * 获取教练的学员
	 * @param coachId
	 * @return
	 */
	List<Student> getCoachStudents(@Param("coachId")int coachId);
	
	Student getById(@Param("id")Integer id);
	
	Student getByStuNum(@Param("stuNum") String stuNum, @Param("stuName") String stuName);

	@Select("select ts.*,(select subjectid from tstudentsubject tss,tstudent tst where tss.StudentId=tst.id and tst.stunum=#{stunum} order by tss.subjectid limit 1) as subjectId from tstudent ts where ts.stunum=#{stunum}")
	Student getStudentByNum(@Param("stunum")String stunum);
	
	@Select("select Photo from tstudent where id=#{studentId} limit 1")
	String getStudentImg(@Param("studentId") Integer studentId);
}
