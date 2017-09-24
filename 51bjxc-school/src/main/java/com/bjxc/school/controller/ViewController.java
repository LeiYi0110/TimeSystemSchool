package com.bjxc.school.controller;

import com.bjxc.school.Tteacharea;
import com.bjxc.school.service.CityAreasService;
import com.bjxc.school.service.DrivingFieldService;
import com.bjxc.school.service.TteachareaService;
import com.bjxc.web.utils.WebUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class ViewController {
	@Resource
	private CityAreasService areaService;
	
	@Resource
	private DrivingFieldService drivingFieldService;
	
	@Resource
	private  TteachareaService tteachareaService;

	@RequestMapping(value="/view/tteacharea")
	public String tteacharea(HttpServletRequest request){
		return "tteacharea";
	}

	@RequestMapping(value="/view/school")
	public String school(HttpServletRequest request){
		return "school";
	}
	
	@RequestMapping(value="/view/drivingField")
	public String drivingField(HttpServletRequest request,Integer insId){
	/*	Integer insId=WebUtils.getParameterIntegerValue(request, "insId");*/
		List<Tteacharea> areasList=tteachareaService.selectdow(insId);
		request.setAttribute("areasList", areasList);
		return "manager/drivingField";
	}
	
	@RequestMapping(value="/view/serviceStation")
	public String enrollPoint(HttpServletRequest request,Integer insId){
		/*Integer insId=WebUtils.getParameterIntegerValue(request, "insId");*/
		List<Tteacharea> areasList=tteachareaService.selectdow(insId);
		request.setAttribute("areasList", areasList);
		return "ServiceStation";
	}
	
	@RequestMapping(value="/view/mg/coachList")
	public String coachList(HttpServletRequest request){
		return "manager/coachList";
	}
	
	@RequestMapping(value="/view/mg/coachView")
	public String coachView(HttpServletRequest request){
		return "manager/coachView";
	}
	
	/**
	 * 教练新增
	 * @param request
	 */
	@RequestMapping(value="/view/mg/coachEditor")
	public String coachEditor(HttpServletRequest request){
		return "manager/coachEditor";
	}
	
	/**
	 * 班型
	 * @param request
	 */
	@RequestMapping(value="/view/classType")
	public String classType(HttpServletRequest request){
		return "manager/classType";
	}
	/**
	 * 学生
	 * @param request
	 */
	@RequestMapping(value="/view/student")
	public String studentInfo(HttpServletRequest request){
		return "student";
	}
	@RequestMapping(value="/view/demo")
	public String demo(HttpServletRequest request){
		return "demo";
	}
	
	/**
	 * 学生
	 * @param request
	 */
	@RequestMapping(value="/view/studentError")
	public String studentErrorInfo(HttpServletRequest request){
		return "studentError";
	}
	/**
	 * 学生信息编辑界面
	 * @param request
	 */
	@RequestMapping(value="/view/studentEditor")
	public String studentAdd(HttpServletRequest request){
		return "studentEditor";
	}
	
	/**
	 * 学员信息查看界面
	 * @param request
	 * @return
	 */

	@RequestMapping(value="/view/studentView")
	public String coachAdd(HttpServletRequest request){
		return "studentView";
	}
	
	/**
	 * 学员学习进度
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/view/studentInsLog")
	public String studentInsLog(HttpServletRequest request){
		return "studentInsLog";
	}
	
	/**
	 * 学员学时记录
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/view/studentRecording")
	public String studentRecording(HttpServletRequest request){
		return "studentRecording";
	}
	
	@RequestMapping(value="/view/manager")
	public String manager(HttpServletRequest request){
		return "manager/index";
	}
	
	/**
	 * 报名管理
	 * @param request
	 */
	@RequestMapping(value="/view/studentReferee")
	public String studentReferee(HttpServletRequest request){
		return "StudentReferee";
	}
	
	/**
	 * 报名管理
	 * @param request
	 */
	@RequestMapping(value="/view/studentChangeStation")
	public String studentChangeStation(HttpServletRequest request){
		return "studentStation";
	}
	
	/**
	 * 考试管理
	 * @param request
	 */
	@RequestMapping(value="/view/studentExam")
	public String studentExam(HttpServletRequest request){
		return "StudentExam";
	}
	
	/**
	 * 账号管理
	 * @return
	 */
	@RequestMapping(value="/view/platformUser")
	public String platformUser(HttpServletRequest request,Integer insId){
		
		List<Tteacharea> areaList=tteachareaService.selectdow(insId);
		request.setAttribute("areaList", areaList);
		return "platformUser";
	}
	
	/**
	 * 预约管理
	 * @param request
	 */
	@RequestMapping(value="/view/dutyList")
	public String dutyList(HttpServletRequest request){
		return "dutyList";
	}
	
	/**
	 * 网点排班
	 * @param request
	 */
	@RequestMapping(value="/view/stationDuty")
	public String stationDuty(HttpServletRequest request){
		return "stationDuty";
	}
	
	/**
	 * 先付后学班管理
	 * @param request
	 */
	@RequestMapping(value="/view/studentFirstPay")
	public String studentFistPay(HttpServletRequest request){
		return "studentFirstPay";
	}
	
	/**
	 * 先学后付班管理
	 * @param request
	 */
	@RequestMapping(value="/view/studentFirstLearning")
	public String studentFistLearning(HttpServletRequest request){
		return "studentFirstLearning";
	}
	
	/**
	 * 学生信息报错处理
	 * @param request
	 */
	@RequestMapping(value="/view/studentHandle")
	public String studentHandle(HttpServletRequest request){
		
		return "studentHandle";
	}
	
	/**
	 * 学员过期管理
	 * @param request
	 */
	@RequestMapping(value="/view/studentExpire")
	public String studentExpire(HttpServletRequest request){
		return "studentExpire";
	}
	/**
	 * 学时预警
	 * @param request
	 */
	@RequestMapping(value="/view/studentWarning")
	public String studentWarning(HttpServletRequest request){
		return "studentWarning";
	}
	@RequestMapping(value="/view/trainingCar")
	public String trainingCar(HttpServletRequest request){
		return "TrainingCar";
	}
	
	@RequestMapping(value="/view/CarEditor")
	public String carEditor(HttpServletRequest request){
		return "TrainingCarEditor";
	}
	
	@RequestMapping(value="/view/device")
	public String device(HttpServletRequest request){
		return "Device";
	}
	/**
	 * 安全员管理
	 * @param request
	 */
	@RequestMapping(value="/view/securityMember")
	public String securityMember(HttpServletRequest request){
		return "securityMember";
	}
	@RequestMapping(value="/view/securityMemberEditor")
	public String securityMemberEditor(HttpServletRequest request){
		return "securityMemberEditor";
	}
	/**
	 * 考核员管理
	 * @param request
	 */
	@RequestMapping(value="/view/assessment")
	public String assessment(HttpServletRequest request){
		return "assessment";
	}
	@RequestMapping(value="/view/assessmentEditor")
	public String assessmentEditor(HttpServletRequest request){
		return "assessmentEditor";
	}
	@RequestMapping(value="/view/comment")
	public String comment(HttpServletRequest request){
		return "Comment";
	}
	/**
	 * 投诉信息管理
	 * @param request
	 */
	@RequestMapping(value="/view/complaintInfo")
	public String complaintInfo(HttpServletRequest request){
		return "complaintInfo";
	}
	/**
	 * 教学管理
	 * @param request
	 */
	@RequestMapping(value="/view/teachingProgram")
	public String teachingProgram(HttpServletRequest request){
		return "teachingProgram";
	}
	
	
	@RequestMapping(value="/view/forCoachList")
	public String forCoachList(HttpServletRequest request){
		Integer coachId=WebUtils.getParameterIntegerValue(request, "coachId");
		String name=WebUtils.getParameterValue(request, "name");
		request.setAttribute("coachId", coachId);
		request.setAttribute("coachName", name);
		return "student";
	}
	
	/**
	 * 学员数据统计
	 * @param request
	 */
	@RequestMapping(value="/view/StudentCount")
	public String StudentCount(HttpServletRequest request){
		return "StudentCount";
	}
	/**
	 * 教练数据统计
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/view/CoachCount")
	public String CoachCount(HttpServletRequest request){
		return "CoachCount";
	}
	/**
	 * 学生账户
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/view/studentAccount")
	public String StudentAccount(HttpServletRequest request){
		return "studentAccount";
	}
	/**
	 * 缴费流水
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/view/payWaterCourse")
	public String PayWaterCourse(HttpServletRequest request){
		return "payWaterCourse";
	}
	
	/**
	 * 编辑培训机构
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/view/institution")
	public String Institution(HttpServletRequest request){
		return "institution";
	}
	
	/**
	 * 学员退费审核
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/view/trefund")
	public String trefund(HttpServletRequest request){
		return "trefund";
	}
	
	
	/**
	 * 正在开发。。。
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/view/development")
	public String development(HttpServletRequest request){
		return "development";
	}
	
	/**
	 * 学员统计。。。
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/view/studentCounts")
	public String studentCounts(HttpServletRequest request){
		return "studentCounts";
	}
	
	/**
	 * 教练统计。。。
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/view/coachCounts")
	public String coachCounts(HttpServletRequest request){
		return "coachCounts";
	}
	
	/**
	 * 教学大纲。。。
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/view/outline")
	public String outline(HttpServletRequest request){
		return "outline";
	}

	
	/**
	 * 学员评价教练。。。
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/view/Coachevaluation")
	public String Coachevaluation(HttpServletRequest request){
		return "Coachevaluation";
	}
	
	/**
	 * 学员评价驾校。。。
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/view/shcoolcomment")
	public String shcoolcomment(HttpServletRequest request){
		return "shcoolcomment";
	}

	
	/**
	 * 学员投诉驾校
	 * @param request
	 */
	@RequestMapping(value="/view/complaintsDriving")
	public String complaintsDriving(HttpServletRequest request){
		return "complaintsDriving";
	}
	
	/**
	 * 学员投诉教练
	 * @param request
	 */
	@RequestMapping(value="/view/complaintsCoach")
	public String complaintsCoach(HttpServletRequest request){
		return "complaintsCoach";
	}
	/**
	 * 学员转机构管理
	 * @param request
	 */
	@RequestMapping(value="/view/studentChangeInstitution")
	public String studentChangeInstitution(HttpServletRequest request){
		return "studentInstitution";
	}
	
	/**
	 * 学员教学日志
	 * @param request
	 */
	@RequestMapping(value="/view/TeachingLog")
	public String TeachingLog(HttpServletRequest request){
		return "TeachingLog";
	}
	
	/**
	 * 机构管理
	 * @param request
	 */
	@RequestMapping(value="/view/agency")
	public String agency(HttpServletRequest request){
		return "agency";
	}
	
	/**
	 * 机构管理-编辑
	 * @param request
	 */
	@RequestMapping(value="/view/editAgency")
	public String editAgency(HttpServletRequest request){
		return "editAgency";
	}

	/**
	 * 机构信息查看界面
	 * @param request
	 * @return
	 */

	@RequestMapping(value="/view/agencyView")
	public String agencyView(HttpServletRequest request){
		return "agencyView";
	}
	/**
	 * 理论课排班
	 * @param request
	 * @return
	 */

	@RequestMapping(value="/view/courseScheduling")
	public String courseScheduling(HttpServletRequest request){
		return "courseScheduling";
	}
	
	/**
	 * 理论排班记录
	 * @param request
	 * @return
	 */

	@RequestMapping(value="/view/theoreticalRecord")
	public String theoreticalRecord(HttpServletRequest request){
		return "theoreticalRecord";
	}
	
	
	/**
	 * 理论课人数
	 * @param request
	 * @return
	 */

	@RequestMapping(value="/view/theoreticalCourseNumber")
	public String theoreticalCourseNumber(HttpServletRequest request){
		return "theoreticalCourseNumber";
	}
	
	/**
	 * 理论课名单
	 * @param request
	 * @return
	 */

	@RequestMapping(value="/view/theoryList")
	public String theoryList(HttpServletRequest request){
		return "theoryList";
	}
	
	/**
	 * 理论课上报
	 * @param request
	 * @return
	 */

	@RequestMapping(value="/view/theoryClassReport")
	public String theoryClassReport(HttpServletRequest request){
		return "theoryClassReport";
	}
	
	@RequestMapping(value="/view/timerecord")
	public String timerecord(HttpServletRequest request){
		return "timerecord";
	}
	
	@RequestMapping(value="/view/graduation")
	public String graduation(HttpServletRequest request){
		return "graduation";
	}	
	
	@RequestMapping(value="/view/notificationMessage")
	public String notificationMessage(HttpServletRequest request)
	{
		return "notificationMessage";
	}
	
	@RequestMapping(value="/view/tcp")
	public String tcp(){
		return "../tcp/index";
	}
	
	@RequestMapping(value="/view/tcp/login")
	public String tcpLogin(){
		return "../tcp/login";
	}
	
	@RequestMapping(value="/view/tcp/logout")
	public String tcpLogout(){
		return "../tcp/logout";
	}
	
	@RequestMapping(value="/view/tcp/setParams")
	public String tcpSetParams(){
		return "../tcp/setParams";
	}
	
	@RequestMapping(value="/view/tcp/searchParams")
	public String tcpsearchParams(){
		return "../tcp/searchParams";
	}
	
	@RequestMapping(value="/view/tcp/searchOneParam")
	public String tcpsearchOneParam(){
		return "../tcp/searchOneParam";
	}
	
	@RequestMapping(value="/view/tcp/control")
	public String tcpcontrol(){
		return "../tcp/control";
	}
	
	@RequestMapping(value="/view/tcp/locationInfo")
	public String tcplocationInfo(){
		return "../tcp/locationInfo";
	}
	
	@RequestMapping(value="/view/tcp/locationFollow")
	public String tcplocationFollow(){
		return "../tcp/locationFollow";
	}
	
	@RequestMapping(value="/view/tcp/recordReport")
	public String tcprecordReport(){
		return "../tcp/recordReport";
	}
	
	@RequestMapping(value="/view/tcp/takePhoto")
	public String tcptakePhoto(){
		return "../tcp/takePhoto";
	}
	
	@RequestMapping(value="/view/tcp/searchPhoto")
	public String tcpsearchPhoto(){
		return "../tcp/searchPhoto";
	}
	
	@RequestMapping(value="/view/tcp/reportPhoto")
	public String tcpreportPhoto(){
		return "../tcp/reportPhoto";
	}
	
	@RequestMapping(value="/view/tcp/setDeviceParams")
	public String tcpsetDeviceParams(){
		return "../tcp/setDeviceParams";
	}
	
	@RequestMapping(value="/view/tcp/searchDeviceParams")
	public String tcpsearchDeviceParams(){
		return "../tcp/searchDeviceParams";
	}
	
	@RequestMapping(value="/view/tcp/setNoTrain")
	public String tcpsetNoTrain(){
		return "../tcp/setNoTrain";
	}
	
	@RequestMapping(value="/view/tcp/bindDevice")
	public String tcpbindDevice(){
		return "../tcp/bindDevice";
	}
	
	@RequestMapping(value="/view/tcp/autorecord")
	public String autorecord(){
		return "../tcp/autorecord";
	}
	
	@RequestMapping(value="/view/excelDatasAdd")
	public String excelDatasAdd(){
		return "excelDatasAdd";
	}
	
	@RequestMapping(value="/view/systemconfig")
	public String systemconfig(){
		return "systemconfig";
	}	
	
	@RequestMapping(value="/view/userlog")
	public String userlog(){
		return "userlog";
	}		
	
	/**
	 * 练车排班管理
	 * @return
	 */
	@RequestMapping(value="/view/coachDutyManage")
	public String coachDutyManage(HttpServletRequest request){
		return "coachDutyManage";
	}
	
	/**
	 * 练车排班管理
	 * @return
	 */
	@RequestMapping(value="/view/studentRefereeManage")
	public String studentRefereeManage(HttpServletRequest request){
		return "studentRefereeManage";
	}
	
	/**
	 * 角色管理
	 * @return
	 */
	@RequestMapping(value="/view/roleManage")
	public String roleManage(){
		return "roleManage";
	}
	
	@RequestMapping(value="/view/trainingLog")
	public String trainingLog(){
		return "TrainingLog";
	}
	
	@RequestMapping(value="/view/trainproc")
	public String trainproc(){
		return "trainproc";
	}
	
	
	/**
	 * 计时终端监控
	 * @return
	 */
	@RequestMapping(value="/view/monitor")
	public String monitor(){
		return "monitor";
	}
	
}

