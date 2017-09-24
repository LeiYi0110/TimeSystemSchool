package com.bjxc.school.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.type.IntegerTypeHandler;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;

import com.bjxc.Page;
import com.bjxc.exception.DuplicateException;
import com.bjxc.school.AppUser;
import com.bjxc.school.Student;
import com.bjxc.school.StudentExam;
import com.bjxc.school.StudentInsLog;
import com.bjxc.school.StudentReferee;
import com.bjxc.school.StudentSubject;
import com.bjxc.school.mapper.StudentExamMapper;
import com.bjxc.school.mapper.StudentMapper;
import com.bjxc.school.mapper.StudentRefereeMapper;
/**
 * 学生服务
 * @author fwq
 *
 */
@Service
public class StudentService {
	@Resource
	private StudentMapper studentMapper;
	@Resource
	private AppUserService appUserService;
	@Resource
	private StudentSubjectService studentSubjectService;
	@Resource
	private StudentInsLongService studentInsLongService;
	@Resource
	private StudentExamMapper studentExamMapper;
	
	@Resource
	private SchedulingTheoryService schedulingTheoryService;
	@Resource
	private StudentRefereeMapper studentRefereeMapper;
	
	public Page<Student> pageQuery(Integer chargemode, Integer paymode, String stationName, Integer sex, Integer insId,
			Integer stationId, String traintype, String searchText, String time1, String time2, Integer subjectid,
			Integer pageIndex, Integer pageSize) {
		Page<Student> page = new Page<Student>(pageIndex, pageSize);
		System.out.println("123456" + searchText + "--" + time1 + "--" + time2);
		Integer totalCount = studentMapper.total(chargemode, paymode, stationName, sex, insId, stationId, traintype,
				searchText, time1, time2, subjectid);
		System.out.println("654321" + insId + "--" + stationId + "--" + searchText);
		page.setRowCount(totalCount);
		System.out.println(totalCount);
		if (totalCount > 0) {
			List<Student> datas = studentMapper.pageList(chargemode, paymode, stationName, sex, insId, stationId,
					traintype, searchText, time1, time2, subjectid, page.getStartRow(), page.getPageSize());
			page.setData(datas);
		}
		return page;
	}
	
	public Page<Student> getCoachStu(Integer coachId,String searchText,Integer pageIndex,Integer pageSize){
		Page<Student> page = new Page<Student>(pageIndex,pageSize); 
		Integer totalCount = studentMapper.totalCoachStu(coachId, searchText);
		page.setRowCount(totalCount);
		if(totalCount > 0){
			List<Student> datas = studentMapper.getCoachStu(coachId, searchText, page.getStartRow(),page.getPageSize());
			page.setData(datas);
		}
		return page;
	}
	
	public Student get(Integer id){
		return studentMapper.get(id);
	}
	/**
	 * 学员是否在申请退费
	 * @return
	 */
	public Integer checkStuRefund(Integer id){
		return studentMapper.checkStuRefund(id);
	}
	
	public List<Map> stuCoachDuty(Integer coachId,Integer subjectId,String name){
		List<Map> list=studentMapper.stuCoachDuty(coachId, subjectId,name);
		return list;
	}
	
	
	public Integer add(Student student) {
		// 检查证件号是否已存在
		Assert.notNull(student.getIdcard());
		Student studentIc = studentMapper.getByIdcard(student.getInsId(), student.getIdcard());
		if (studentIc != null) {
			throw new DuplicateException("本驾校已存在证件号为 " + student.getIdcard() + " 的学员");
		}
		// 为学员添加帐号
		AppUser appUser = appUserService.createStudentAppUser(student.getUserId(), student.getMobile(),
				student.getName(), student.getIdcard(), student.getPhoto(), student.getSex());
		student.setUserId(appUser.getId());
		studentMapper.add(student);

		//创建报名时间
		StudentInsLog studentInsLog = new StudentInsLog();
		studentInsLog.setStudentID(student.getId());
		studentInsLog.setInsId(student.getInsId());
		studentInsLog.setCategory(StudentInsLog.LOG_TYPE_TEACHER);
		studentInsLog.setContent("学员报名");
		studentInsLog.setCreateTime(student.getApplydate());
		studentInsLongService.addHasTime(studentInsLog);
		
		StudentReferee studentReferee = null;
		
		studentReferee = studentRefereeMapper.getByUserId(student.getUserId());
		if (studentReferee != null) {
			// 学员在APP报名慧出现一条记录,更新为已处理
			studentRefereeMapper.update(studentReferee.getId());
		} else {
			studentReferee = new StudentReferee();
			studentReferee.setUserID(student.getUserId());
			studentReferee.setInsId(student.getInsId());
			studentReferee.setClassType(student.getClassTypeId());
			studentReferee.setName(student.getName());
			studentReferee.setMobile(student.getMobile());
			studentReferee.setIdcard(student.getIdcard());
			studentReferee.setSex(student.getSex());
			studentReferee.setAddress(student.getAddress());
			studentReferee.setRefereeMobile(student.getRefereeMobile());
			studentReferee.setRefereeName(student.getRefereeName());
			studentReferee.setCreateTime(student.getApplydate());
			studentReferee.setStatus(1);
			studentRefereeMapper.insert(studentReferee);
		}

		return student.getId();
	}
	public void addByExcel(Student student){
		//检查证件号是否已存在
		Assert.notNull(student.getIdcard());
		Student studentIc =studentMapper.getByIdcard(student.getInsId(), student.getIdcard());
		if(studentIc != null){
			throw new DuplicateException("本驾校已存在证件号为 " + student.getIdcard() + " 的学员");
		}
		//为学员添加帐号
		AppUser appUser = appUserService.createStudentAppUser(student.getUserId(), student.getMobile(), student.getName(), student.getIdcard(), student.getPhoto(), student.getSex());
		student.setUserId(appUser.getId());
		studentMapper.addByExcel(student);
	}
	
	
	public void update(Student student){
		if(StringUtils.hasText(student.getIdcard())){
			//检查 用户证件号是否相同
			Student studentIc =studentMapper.getByIdcard(student.getInsId(), student.getIdcard());
			if(studentIc != null && !student.getId().equals(studentIc.getId())){
				throw new DuplicateException("本驾校已存在证件号为 " + student.getIdcard() + " 的学员");
			}
		}
		//用户帐号信息管理
		Student studentUser = studentMapper.get(student.getId());
		AppUser appUser = appUserService.createStudentAppUser(studentUser.getUserId(), student.getMobile(), student.getName(), student.getIdcard(), student.getPhoto(), student.getSex());
		if(appUser.getId().equals(student.getUserId())){
			//用户ID不一致时使用新的
		}else{
			student.setUserId(appUser.getId());
		}
		student.setAlreadyPay(student.getAlreadyPay()*10000);
		studentMapper.update(student);
		studentMapper.updateUser(student);
	}
	
	/**
	 * 修改学员的进度
	 * 1、将学员在进行为的状态全部设为完成
	 * 2、为学员添加新的状态
	 * 3、跟据新的状态去修改学员信息表的状态
	 * 4、将学员状态的变化写到日志表
	 * @param insId
	 * @param studentId
	 * @param status
	 * @param coachId
	 */
	/*public void changeStudentStatus(Integer insId, Integer studentId, Integer status,Integer coachId){
		if(new Integer(0).equals(status)){
			studentSubjectService.endAllSubject(studentId);
			//录入指纹
			StudentSubject studentSubject = new StudentSubject();
			studentSubject.setStatus(new Integer(2));
			studentSubject.setStudentId(studentId);
			studentSubject.setSubjectId(new Integer(0));
			studentSubjectService.addStudentSubject(insId, studentSubject);
			studentInsLongService.add(studentId, insId, "完成科目一录入", StudentInsLog.LOG_TYPE_TEACHER);
			//启动科目一
			StudentSubject studentSubjectOne = new StudentSubject();
			studentSubjectOne.setStatus(new Integer(1));
			studentSubjectOne.setStudentId(studentId);
			studentSubjectOne.setSubjectId(new Integer(1));
			studentSubjectService.addStudentSubject(insId, studentSubjectOne);
			studentInsLongService.add(studentId, insId, "开始科目一学习", StudentInsLog.LOG_TYPE_TEACHER);
			//学习中
			this.updateStatus(studentId,new Integer(2));
		}else if(new Integer(1).equals(status)){
			studentSubjectService.endAllSubject(studentId);
			//启动科目一
			StudentSubject studentSubjectOne = new StudentSubject();
			studentSubjectOne.setStatus(new Integer(1));
			studentSubjectOne.setStudentId(studentId);
			studentSubjectOne.setSubjectId(new Integer(1));
			studentSubjectService.addStudentSubject(insId, studentSubjectOne);
			//学习中
			this.updateStatus(studentId,new Integer(2));
			studentInsLongService.add(studentId, insId, "开始科目一学习", StudentInsLog.LOG_TYPE_TEACHER);
			
		}else if(new Integer(2).equals(status)){
			studentSubjectService.endAllSubject(studentId);
			studentInsLongService.add(studentId, insId, "结束科目一学习", StudentInsLog.LOG_TYPE_TEACHER);
			//启动科目二
			StudentSubject studentSubjectOne = new StudentSubject();
			studentSubjectOne.setStatus(new Integer(1));
			studentSubjectOne.setStudentId(studentId);
			studentSubjectOne.setSubjectId(new Integer(2));
			studentSubjectOne.setCoachId(coachId);
			studentSubjectService.addStudentSubject(insId, studentSubjectOne);
			//学习中
			this.updateStatus(studentId,new Integer(2));
			studentInsLongService.add(studentId, insId, "开始科目二学习", StudentInsLog.LOG_TYPE_TEACHER);
			
		}else if(new Integer(3).equals(status)){
			studentInsLongService.add(studentId, insId, "结束科目二学习", StudentInsLog.LOG_TYPE_TEACHER);
			studentSubjectService.endAllSubject(studentId);
			//启动科目三
			StudentSubject studentSubjectOne = new StudentSubject();
			studentSubjectOne.setStatus(new Integer(1));
			studentSubjectOne.setStudentId(studentId);
			studentSubjectOne.setSubjectId(new Integer(3));
			studentSubjectOne.setCoachId(coachId);
			studentSubjectService.addStudentSubject(insId, studentSubjectOne);
			//学习中
			this.updateStatus(studentId,new Integer(2));
			studentInsLongService.add(studentId, insId, "开始科目三学习", StudentInsLog.LOG_TYPE_TEACHER);
			
		}else if(new Integer(4).equals(status)){
			studentInsLongService.add(studentId, insId, "结束科目三学习", StudentInsLog.LOG_TYPE_TEACHER);
			studentSubjectService.endAllSubject(studentId);
			//启动科目四
			StudentSubject studentSubjectOne = new StudentSubject();
			studentSubjectOne.setStatus(new Integer(1));
			studentSubjectOne.setStudentId(studentId);
			studentSubjectOne.setSubjectId(new Integer(4));
			studentSubjectService.addStudentSubject(insId, studentSubjectOne);
			//学习中
			this.updateStatus(studentId,new Integer(2));
			studentInsLongService.add(studentId, insId, "开始科目四学习", StudentInsLog.LOG_TYPE_TEACHER);
			
		}else if(new Integer(5).equals(status)){
			studentInsLongService.add(studentId, insId, "结束科目四学习", StudentInsLog.LOG_TYPE_TEACHER);
			//结束
			studentSubjectService.endAllSubject(studentId);
			//设为拿到驾照
			this.updateStatus(studentId,new Integer(3));
			studentInsLongService.add(studentId, insId, "拿到驾照", StudentInsLog.LOG_TYPE_TEACHER);
		}
	}
*/	
	/**
	 * 修改学员的进度
	 * 1、录入学员统一编号
	 * 2、将学员在进行为的状态全部设为完成
	 * 3、录入考试成绩
	 * 4、为学员添加新的状态
	 * 5、跟据新的状态去修改学员信息表的状态
	 * 6、将学员状态的变化写到日志表
	 * @param insId
	 * @param studentId
	 * @param status
	 * @param coachId
	 */
	public void updateStudentStatus(Integer insId, Integer studentId, Integer status,Integer coachId,
			String recordnum,Integer score,String drilicnum,String organno,String certificateno
			,String documenturl,String signatureurl
			){
		
		StudentExam exam=null;
		if(score != null){
			exam = new StudentExam();
			exam.setScore(score);
			exam.setSubjectId(status-1);
			exam.setInsId(insId);
			exam.setStudentID(studentId);
			exam.setCoachId(coachId);
			exam.setCreateTime(new Date());	
			exam.setExamTime(new Date());
			exam.setPass(1);
		}
		if(new Integer(-2).equals(status)){
			this.updateStudentStunum(studentId, null);
		}
		else if(new Integer(-1).equals(status)){
			studentSubjectService.endAllSubject(studentId);
			//录入指纹
			StudentSubject studentSubject = new StudentSubject();
			studentSubject.setStatus(new Integer(1));
			studentSubject.setStudentId(studentId);
			studentSubject.setSubjectId(new Integer(-1));
			studentSubjectService.addStudentSubject(insId, studentSubject);
			//录入学员编号
			if(recordnum != null){
				this.updateStudentStunum(studentId, recordnum);
			}	
			Student student=studentMapper.get(studentId);
			schedulingTheoryService.insertSchedulingTheory(studentId, studentSubject.getSubjectId(), student.getStationId());
			/*studentInsLongService.add(studentId, insId, "完成科目一录入", StudentInsLog.LOG_TYPE_TEACHER);
			//启动科目一
			StudentSubject studentSubjectOne = new StudentSubject();
			studentSubjectOne.setStatus(new Integer(1));
			studentSubjectOne.setStudentId(studentId);
			studentSubjectOne.setSubjectId(new Integer(1));
			studentSubjectService.addStudentSubject(insId, studentSubjectOne);
			studentInsLongService.add(studentId, insId, "开始科目一学习", StudentInsLog.LOG_TYPE_TEACHER);*/
			//学习中
			//this.updateStatus(studentId,new Integer(2));
		}else if(new Integer(1).equals(status)){
			studentSubjectService.endAllSubject(studentId);
			//启动科目一
			StudentSubject studentSubjectOne = new StudentSubject();
			studentSubjectOne.setStatus(new Integer(1));
			studentSubjectOne.setStudentId(studentId);
			studentSubjectOne.setSubjectId(new Integer(1));
			studentSubjectService.addStudentSubject(insId, studentSubjectOne);
			//学习中
			this.updateStatus(studentId,new Integer(2),null,null,null,null);
			studentInsLongService.add(studentId, insId, "开始科目一学习", StudentInsLog.LOG_TYPE_TEACHER);
			
		}else if(new Integer(2).equals(status)){
			studentSubjectService.endAllSubject(studentId);
			studentInsLongService.add(studentId, insId, "结束科目一学习", StudentInsLog.LOG_TYPE_TEACHER);
			
			if(score != null){
				studentExamMapper.insertExam(exam);
			}
			//启动科目二
			StudentSubject studentSubjectOne = new StudentSubject();
			studentSubjectOne.setStatus(new Integer(1));
			studentSubjectOne.setStudentId(studentId);
			studentSubjectOne.setSubjectId(new Integer(2));
			studentSubjectOne.setCoachId(coachId);
			studentSubjectService.addStudentSubject(insId, studentSubjectOne);
			//学习中
			
			this.updateStatus(studentId,new Integer(2),null,null,null,null);
			studentInsLongService.add(studentId, insId, "开始科目二学习", StudentInsLog.LOG_TYPE_TEACHER);
			
		}else if(new Integer(3).equals(status)){
			studentInsLongService.add(studentId, insId, "结束科目二学习", StudentInsLog.LOG_TYPE_TEACHER);
			studentSubjectService.endAllSubject(studentId);
			
			if(score != null){
				exam.setSubjectId(status);
				studentExamMapper.insertExam(exam);
			}
			//启动科目三
			StudentSubject studentSubjectOne = new StudentSubject();
			studentSubjectOne.setStatus(new Integer(1));
			studentSubjectOne.setStudentId(studentId);
			studentSubjectOne.setSubjectId(new Integer(3));
			studentSubjectOne.setCoachId(coachId);
			studentSubjectService.addStudentSubject(insId, studentSubjectOne);
			//学习中
			this.updateStatus(studentId,new Integer(2),null,null,null,null);
			studentInsLongService.add(studentId, insId, "开始科目三学习", StudentInsLog.LOG_TYPE_TEACHER);
			
		}else if(new Integer(4).equals(status)){
			studentInsLongService.add(studentId, insId, "结束科目三学习", StudentInsLog.LOG_TYPE_TEACHER);
			studentSubjectService.endAllSubject(studentId);
			
			if(score != null){
				studentExamMapper.insertExam(exam);
			}
			//启动科目四
			StudentSubject studentSubjectOne = new StudentSubject();
			studentSubjectOne.setStatus(new Integer(1));
			studentSubjectOne.setStudentId(studentId);
			studentSubjectOne.setSubjectId(new Integer(4));
			studentSubjectService.addStudentSubject(insId, studentSubjectOne);
			//学习中
			this.updateStatus(studentId,new Integer(2),null,null,null,null);
			studentInsLongService.add(studentId, insId, "开始科目四学习", StudentInsLog.LOG_TYPE_TEACHER);
			
		}else if(new Integer(5).equals(status)){

			if(score != null){
				studentExamMapper.insertExam(exam);
			}
			//启动科目四
			StudentSubject studentSubjectOne = new StudentSubject();
			studentSubjectOne.setStatus(new Integer(1));
			studentSubjectOne.setStudentId(studentId);
			studentSubjectOne.setSubjectId(new Integer(4));
			studentSubjectService.addStudentSubject(insId, studentSubjectOne);
			//学习中
			this.updateStatus(studentId,new Integer(2),null,null,null,null);
			studentInsLongService.add(studentId, insId, "结束科目四学习", StudentInsLog.LOG_TYPE_TEACHER);
			//结束
			
			if(score != null){
				studentExamMapper.insertExam(exam);
			}
			studentSubjectService.endAllSubject(studentId);
			//设为拿到驾照
			this.updateStatus(studentId, new Integer(3), organno, certificateno, documenturl, signatureurl);
			studentInsLongService.add(studentId, insId, "拿到驾照", StudentInsLog.LOG_TYPE_TEACHER);
		}
		
	}
	//organno,certificateno,documenturl,signatureurl
	private void updateStatus(Integer studentId,Integer status,String organno,String certificateno,String documenturl,String signatureurl){
		studentMapper.updateStatus(studentId, status,organno,certificateno,documenturl,signatureurl);
	}
	
	public void updateStudentStunum(Integer studentId,String recordnum){
		studentMapper.updateStudentStunum(studentId, recordnum);
	}
	
	public Student getStudentByMobile(Integer insId,String mobile){
		return studentMapper.getStudentByMobile(insId,mobile);
	}
	
	public List<Student> getAliveStudentListByClassType(Integer classType) {
		return studentMapper.getAliveStudentListByClassType(classType);
	}
	
	public Page<Student> pageBaocuoQuery(Integer insId,Integer stationId,String searchText,Integer pageIndex,Integer pageSize ){
		Page<Student> page = new Page<Student>(pageIndex,pageSize); 
		Integer totalCount = studentMapper.totalBaocuo(insId,stationId, searchText);
		page.setRowCount(totalCount);
		if(totalCount > 0){
			
			List<Student> datas = studentMapper.pageBaocuoList(insId,stationId,searchText,page.getStartRow(),page.getPageSize());
			page.setData(datas);
		}
		return page;
	}
	
	
	public void updateBaocuo(Integer id,Integer isWrong){
		studentMapper.updateBaocuo(id, isWrong);
	}
	
	public Page<Student> pageExpireQuery(Integer insId,Integer stationId,String searchText,Integer pageIndex,Integer pageSize ){
		Page<Student> page = new Page<Student>(pageIndex,pageSize); 
		Integer totalCount = studentMapper.totalExpire(insId,stationId, searchText);
		page.setRowCount(totalCount);
		if(totalCount > 0){
			
			List<Student> datas = studentMapper.pageExpireList(insId,stationId,searchText,page.getStartRow(),page.getPageSize());
			page.setData(datas);
		}
		return page;
	}
	
	public Page<Student> pageWarningQuery(Integer insId,Integer stationId,String searchText,Integer pageIndex,Integer pageSize ){
		Page<Student> page = new Page<Student>(pageIndex,pageSize); 
		Integer totalCount = studentMapper.totalWarning(insId,stationId, searchText);
		page.setRowCount(totalCount);
		if(totalCount > 0){
			
			List<Student> datas = studentMapper.pageWarningList(insId,stationId,searchText,page.getStartRow(),page.getPageSize());
			page.setData(datas);
		}
		return page;
	}
	
	/**
	 * 导出学员信息
	 */
	public List<Student> exceporStudent(Integer insId,Integer stationId){
		return  studentMapper.studentList(insId,stationId);
	}
	
	/**
	 * 学员缴费流水列表
	 * @return
	 */
	public Page<Student> getPayWaterList(Integer stuId,Integer stationId,Integer pageIndex,Integer pageSize){
		Page<Student> page=new Page<Student>();
		if(pageIndex!=null&&pageSize!=null){
			page = new Page<Student>(pageIndex,pageSize);
		}
		Integer totalCount=null;
		if(stuId==null){
			totalCount = studentMapper.totalAccount(stationId,null);
		}else{
			totalCount = studentMapper.totalAccount(stationId,stuId);
		}
		page.setRowCount(totalCount);
		if(totalCount > 0){
			List<Student> datas = studentMapper.getPayWaterList(stuId,stationId,page.getStartRow(),page.getPageSize());
			page.setData(datas);
		}
		return page;
	}
	/**
	 * 学生账户列表
	 * @return
	 */
	public Page<Student> getAccountList(Integer stationId,Integer pageIndex,Integer pageSize){
		Page<Student> page = new Page<Student>(pageIndex,pageSize); 
		Integer totalCount = studentMapper.totalAccount(stationId,null);
		page.setRowCount(totalCount);
		if(totalCount > 0){
			List<Student> datas = studentMapper.getAccountList(stationId,page.getStartRow(),page.getPageSize());
			page.setData(datas);
		}
		return page;
	}
	/**
	 * 根据教练员查询
	 * @param coachId
	 * @param searchText
	 * @return
	 */
	public List<Student> getCoachStudent(Integer coachId,String searchText){
		List<Student> list = studentMapper.getCoachStudent(coachId, searchText);
		
		return list;
	}
	
	public Student getByStudent(Integer insId,Integer id){
		return studentMapper.getByStudent(insId, id);
	}
	
	public void updateisProvince(Student student){
		studentMapper.updateisProvince(student);
		
	}
	
	public Integer delete(Integer id){
		return studentMapper.delete(id);
	}
	
	public Student idcarname(String idcard){
		return studentMapper.idcarname(idcard);
	}
	
	public Integer getStunum(String stunum){
		return studentMapper.getStunum(stunum);
	}
	
	/**
	 * 获取教练的学员
	 * @param coachId
	 * @return
	 */
	public List<Student> getCoachStudent(int coachId){
		return studentMapper.getCoachStudents(coachId);
	}

	public Student getStudentByNum(String studentnum){
		return studentMapper.getStudentByNum(studentnum);
	}
	
	public String getStudentImg(Integer studentId){
		return studentMapper.getStudentImg(studentId);
	}
}
