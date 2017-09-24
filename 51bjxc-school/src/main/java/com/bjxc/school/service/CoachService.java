package com.bjxc.school.service;

import java.lang.reflect.Method;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Arrays;
import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import com.bjxc.Page;
import com.bjxc.exception.DuplicateException;
import com.bjxc.json.JacksonBinder;
import com.bjxc.school.AppUser;
import com.bjxc.school.ClassType;
import com.bjxc.school.Coach;
import com.bjxc.school.CoachDuty;
import com.bjxc.school.CoachPayFirst;
import com.bjxc.school.CoachStation;
import com.bjxc.school.CoachTable;
import com.bjxc.school.Examiner;
import com.bjxc.school.ServiceStation;
import com.bjxc.school.Student;
import com.bjxc.school.StudentReserve;
import com.bjxc.school.enums.ReserveRoleType;
import com.bjxc.school.mapper.ClassTypeMapper;
import com.bjxc.school.mapper.CoachMapper;
import com.bjxc.school.mapper.CoachPayFirstMapper;
import com.bjxc.school.mapper.StudentMapper;
import com.bjxc.school.mapper.StudentReserveMapper;

@Service
public class CoachService {
	@Resource
	private CoachMapper coachMapper;
	@Resource
	private AppUserService appUserService;
	@Resource
	private StudentReserveMapper stuReserveMapper;
	@Resource
	private CoachPayFirstMapper coachPayFirstMapper;
	@Resource
	private StudentMapper studentMapper;
	@Resource
	private ClassTypeMapper classTypeMapper;
	
	public Page<Coach> list(Integer insId,Integer stationId,String searchText,Integer pageIndex,Integer pageSize){
		Page<Coach> page = new Page<Coach>(pageIndex,pageSize); 
		Integer totalCount = coachMapper.total(insId,stationId,searchText);
		page.setRowCount(totalCount);
		if(totalCount > 0){
			List<Coach> datas = coachMapper.list(searchText,insId,stationId,page.getStartRow(),page.getPageSize());
			page.setData(datas);
		}
		return page;
	}
	
	/**
	 * 生成教练出勤
	 * @throws ParseException 
	 */
	public void addSeven(String date,Integer coachId) throws ParseException{
		//获得教练出勤规则
		String regular=coachMapper.getRegular(coachId);
		if(regular==null){
			regular="{\"6\":\"false\",\"7\":\"false\",\"8\":\"true\",\"9\":\"true\",\"10\":\"true\",\"11\":\"true\",\"12\":\"false\",\"13\":\"false\",\"14\":\"true\",\"15\":\"true\",\"16\":\"true\",\"17\":\"true\",\"18\":\"false\",\"19\":\"false\",\"20\":\"false\",\"21\":\"false\"}";
		}
		Map<String, String> map = JacksonBinder.buildNormalBinder().fromJson(regular, HashMap.class);
		CoachDuty coachDuty=new CoachDuty();
		coachDuty.setCoachId(coachId);
		if(map.get("6").equals("true")){
			coachDuty.setF6(1);
		}else {
			coachDuty.setF6(-1);
		}
		if(map.get("7").equals("true")){
			coachDuty.setF7(1);
		}else {
			coachDuty.setF7(-1);
		}
		if(map.get("8").equals("true")){
			coachDuty.setF8(1);
		}else {
			coachDuty.setF8(-1);
		}
		if(map.get("9").equals("true")){
			coachDuty.setF9(1);
		}else {
			coachDuty.setF9(-1);
		}
		if(map.get("10").equals("true")){
			coachDuty.setF10(1);
		}else {
			coachDuty.setF10(-1);
		}
		if(map.get("11").equals("true")){
			coachDuty.setF11(1);
		}else {
			coachDuty.setF11(-1);
		}
		if(map.get("12").equals("true")){
			coachDuty.setF12(1);
		}else {
			coachDuty.setF12(-1);
		}
		if(map.get("13").equals("true")){
			coachDuty.setF13(1);
		}else {
			coachDuty.setF13(-1);
		}
		if(map.get("14").equals("true")){
			coachDuty.setF14(1);
		}else {
			coachDuty.setF14(-1);
		}
		if(map.get("15").equals("true")){
			coachDuty.setF15(1);
		}else {
			coachDuty.setF15(-1);
		}
		if(map.get("16").equals("true")){
			coachDuty.setF16(1);
		}else {
			coachDuty.setF16(-1);
		}
		if(map.get("17").equals("true")){
			coachDuty.setF17(1);
		}else {
			coachDuty.setF17(-1);
		}
		if(map.get("18").equals("true")){
			coachDuty.setF18(1);
		}else {
			coachDuty.setF18(-1);
		}
		if(map.get("19").equals("true")){
			coachDuty.setF19(1);
		}else {
			coachDuty.setF19(-1);
		}
		if(map.get("20").equals("true")){
			coachDuty.setF20(1);
		}else {
			coachDuty.setF20(-1);
		}
		if(map.get("21").equals("true")){
			coachDuty.setF21(1);
		}else {
			coachDuty.setF21(-1);
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		List<Date> dayList=coachMapper.getDay(coachId, date);
		List<Date> addList=new ArrayList<Date>();
		Date dates=sdf.parse(date);
		for (int i = 0; i < 7; i++) {	//添加七天
			Calendar calendar = Calendar.getInstance();  
			calendar.setTimeInMillis(dates.getTime());
			calendar.add(Calendar.DATE, i);
			Date seven = calendar.getTime();
			addList.add(seven);
		}
		addList.removeAll(dayList);
		for (Date date2 : addList) {
			coachDuty.setDay(date2);
			coachMapper.insertCoachDuty(coachDuty);
		}
	}
	
	public List<CoachDuty> getData(List<CoachDuty> datas) {
		List<CoachDuty> data = new ArrayList<CoachDuty>();

		List<Method> methods = Arrays.asList(CoachDuty.class.getMethods());

		for (CoachDuty coachDuty : datas) {
			List<Map> list = coachMapper.dutyStu(coachDuty.getDay(), coachDuty.getCoachId());

			/*
			 * setF6s 到 setF21s setF6m 到 setF21m setF6i 到 setF21i 方法调用
			 */
			for (int i = 0; i < list.size(); i++) {
				Map<String, Object> map2 = list.get(i);
				
				Integer hour = Integer.parseInt(map2.get("time") + "");

				String fsName = String.format("setF%ds", hour);
				String fmName = String.format("setF%dm", hour);
				String fiName = String.format("setF%di", hour);
				String foName = String.format("setF%do", hour);
				String frName = String.format("setF%dr", hour);
				String getFN = String.format("getF%d", hour);
				
				Method setFsMethod = methods.stream().filter(f -> f.getName().equals(fsName)).findFirst().orElse(null);
				Method setFmMethod = methods.stream().filter(f -> f.getName().equals(fmName)).findFirst().orElse(null);
				Method setFiMethod = methods.stream().filter(f -> f.getName().equals(fiName)).findFirst().orElse(null);
				Method setFoMethod = methods.stream().filter(f -> f.getName().equals(foName)).findFirst().orElse(null);
				Method setFrMethod = methods.stream().filter(f -> f.getName().equals(frName)).findFirst().orElse(null);
				Method getFNMethod = methods.stream().filter(f -> f.getName().equals(getFN)).findFirst().orElse(null);
				
				if(setFiMethod == null || setFmMethod == null || setFiMethod == null || getFNMethod == null){
					continue;
				}
				
				try {
					Integer fn = (Integer)getFNMethod.invoke(coachDuty);
					if(fn == 0 || fn == 1){
						//空闲和休息 不处理
						continue;
					}

					setFsMethod.invoke(coachDuty, map2.get("stuName"));
					setFmMethod.invoke(coachDuty, map2.get("mobile"));
					
					Integer id = 0;
					if (map2.get("id") != null) {
						id = Integer.parseInt(map2.get("id").toString());
					}
					setFiMethod.invoke(coachDuty, id);
					
					setFrMethod.invoke(coachDuty, map2.get("reserveRole"));
					int reserveRole = Integer.parseInt(map2.get("reserveRole").toString());
					switch (ReserveRoleType.valueOf(reserveRole)) {
					case Student:
						setFoMethod.invoke(coachDuty, map2.get("stuName"));
						break;
					case Coach:
						setFoMethod.invoke(coachDuty, map2.get("coachName"));
						break;
					case Institution:
						setFoMethod.invoke(coachDuty, map2.get("optionUserName"));
						break;
					}
				} catch (Exception ex) {
					continue; 
				}	
			}
			data.add(coachDuty);
		}
		return data;
	}
	
	public Page<CoachDuty> stationDuty(Map map){
		Page<CoachDuty> page = new Page<CoachDuty>(Integer.parseInt(map.get("pageIndex") + ""),
				Integer.parseInt(map.get("pageSize") + ""));
		Integer totalCount = coachMapper.totalDuty(map);
		page.setRowCount(totalCount);
		if (totalCount > 0) {
			map.put("start", page.getStartRow());
			map.put("size", page.getPageSize());
			List<CoachDuty> datas = coachMapper.dutyList(map);
			List<CoachDuty> data = getData(datas);
			page.setData(data);
		}
		return page;
	}
	
	public List<CoachDuty> dutyList(Map map){
		List<CoachDuty> datas = coachMapper.dutyList(map);
		List<CoachDuty> data=getData(datas);
		return data;
	}
	
	public ServiceStation findByCoach(Integer id){
		return coachMapper.findByCoach(id);
	}
	
	/**
	 * 根据教练id更改教练与网点关系
	 * @param coachid,stationid
	 */
	public void changeByCoach(Integer coachId,Integer stationId){
		coachMapper.changeByCoach(coachId, stationId);
	}
	
	/**
	 * 根据教练id新增教练与网点关系
	 * @param coachid,stationid
	 */
	public void insertByCoach(Integer coachId,Integer stationId){
		CoachStation coachStation = coachMapper.getCoachService(coachId);
		if(coachStation == null && null != stationId){
			coachMapper.insertByCoach(coachId, stationId);
		}else{
			coachMapper.changeByCoach(coachId, stationId);
		}
	}
	
	public void delete(Integer id){
		coachMapper.delete(id);
	}
	
	public Coach get(Integer id){
		return coachMapper.get(id);
	}
	
	public Integer add(Coach coach) throws Exception{
		Coach coachMobile =coachMapper.getByMobile(coach);
		
		if(coachMobile != null){
			//throw new DuplicateException("本驾校已存在电话号码" + coach.getMobile() + " 的教练");
			return new Integer(-1);
		}
		AppUser appUser = appUserService.createCoachAppUser(coach.getUserId(), coach.getMobile(), coach.getName(), coach.getIdcard(), coach.getPhoto(), coach.getSex());
		coach.setUserId(appUser.getId());
		Integer id = coachMapper.add(coach);
		return id;
	}
	
	/**
	 * 导入excel中Coach的信息
	 * @param coach
	 * @return
	 * @throws Exception
	 */
	public Integer addByExcel(Coach coach) throws Exception{
		//检查教练员身份证件号是否已存在
		Assert.notNull(coach.getIdcard());
		
		Coach coachIc =coachMapper.getByIdcard(coach.getInsId(), coach.getIdcard());
		if(coachIc != null){
			throw new DuplicateException("本驾校已存在身份证号为 " + coach.getIdcard() + " 的教练员");
		}
		AppUser appUser = appUserService.createCoachAppUser(coach.getUserId(), coach.getMobile(), coach.getName(), coach.getIdcard(), coach.getPhoto(), coach.getSex());
		coach.setUserId(appUser.getId());
		Integer id = coachMapper.addByExcel(coach);
		return id;
	}
	
	public void update(Coach coach){
		
		//检查电话号码是否存在
		/*Coach coachMobile =coachMapper.getByMobile(coach);
		if(coachMobile != null && !coach.getId().equals(coachMobile.getId())){
			throw new DuplicateException("本驾校已存在电话号码" + coach.getMobile() + " 的教练");
		}*/
		coachMapper.update(coach);
	}
	/**
	 * 获取驾校、服务点的教练
	 * @param insId
	 * @param stationId
	 * @param subjectId
	 * @return
	 */
	public List<Coach> coachList(Integer insId,Integer stationId,Integer subjectId){
		return coachMapper.coachList(insId, stationId, subjectId);
	}
	
	public void updDuty(StudentReserve reserve,Integer status) throws Exception{
		
		Assert.notNull(reserve.getCoachId());
		Assert.notNull(reserve.getTime());
		Assert.notNull(reserve.getDay());
		// 取消教练这个时间的所有预约记录
		stuReserveMapper.displayCoachReserveThisTime(reserve);
		
		
		Map map = new HashMap();
		map.put("time", reserve.getTime());
		map.put("status", status);
		map.put("coachId", reserve.getCoachId());
		map.put("day", reserve.getDay());
		map.put("optionUserId", reserve.getOptionUserId());
		
		coachMapper.updateDuty(map);
		if (status == 3) {
			Student student = studentMapper.getById(reserve.getStudentId());
			if(student == null){
				throw new Exception("学员不存在");
			}
			ClassType classType = classTypeMapper.get(student.getClassTypeId());
			reserve.setPayType(classType.getPaymode());
			
			stuReserveMapper.add(reserve);
			stuReserveMapper.addInfo(reserve);
		}
	}
	
	/**
	 * 新增教练先学后付价格
	 * @param coachPayFirst
	 */
	public void addCoachPayOrUpd(Integer coachId,Double timeCharges){
		CoachPayFirst coachPayFirsts = coachPayFirstMapper.getCoachPayFirst(coachId); 
		if(null == coachPayFirsts){
			if(null != timeCharges){
				CoachPayFirst coachPayFirst = new CoachPayFirst();
				coachPayFirst.setCoachId(coachId);
				coachPayFirst.setPrice(timeCharges);
				coachPayFirstMapper.insertCoachPay(coachPayFirst);
			}
		}else{
			coachPayFirsts.setPrice(timeCharges);
			coachPayFirstMapper.updateCoachPay(coachPayFirsts); 
		}
	}
	/**
	 * 修改教练先学后付价格
	 * @param coachPayFirst
	 */
	public void updateCoachPay(CoachPayFirst coachPayFirst){
		coachPayFirstMapper.updateCoachPay(coachPayFirst);
	}
	/**
	 * 查询教练先学后付价格
	 * @param coachPayFirst
	 */
	public CoachPayFirst getCoachPay(Integer coachId){
		return coachPayFirstMapper.getCoachPayFirst(coachId);
	}
	
	public Coach getCoach(Integer id){
		
		return coachMapper.getCoach(id);
	}

	public Coach getCoachByNum(String coachnum){
		return coachMapper.getCoachByNum(coachnum);
	}

	
	/**
	 * 导出教练信息
	 */
	public List<Coach> exportCoachList(Map map){
		return coachMapper.exportCoachList(map);
		
	}
	/**
	 * 教练数据统计
	 * @param map
	 */
	@SuppressWarnings("unchecked")
	public Page<CoachTable> getCoachSituation(Map map,Integer pageIndex,Integer pageSize){
		Page<CoachTable> page=new Page<CoachTable>(pageIndex,pageSize);
		map.put("start",page.getStartRow());
		map.put("size",page.getPageSize());
		List<CoachTable> list=coachMapper.getCoachSituation(map);
		Integer totalCount=Integer.parseInt(map.get("coaTCount").toString());
		page.setRowCount(totalCount);
		List<CoachTable> coachList=new ArrayList<CoachTable>();
		if(totalCount>0){
			for (CoachTable coachTable : list) {
				coachTable.setTwoPercentStr((coachTable.getSubjTwoPassPercent()==null?0:coachTable.getSubjTwoPassPercent())
						*100+"%");
				coachTable.setThreePercentStr((coachTable.getSubjThreePassPercent()==null?0:coachTable.getSubjThreePassPercent())
						*100+"%");
				coachTable.setPassPercentStr((coachTable.getStuPassPercent()==null?0:coachTable.getStuPassPercent())
						*100+"%");
				//封装好的结果集
				coachList.add(coachTable);
			}
			page.setData(coachList);
		}
		return page;
	}
	
	public void updatestatus(Coach coach){
		coachMapper.updatestatus(coach);
	}
	
	public void updateIsprovince(String coachNum){
		coachMapper.updateIsprovince(coachNum);
	}
	
	
	/**
	 * 根据参数赛选教练
	 * @param map
	 * @return
	 */
	public Page<Coach> getCoachCollector(Map map) {
		Page<Coach> page = new Page<Coach>();

		/**
		 * 有分页参数才设置分页
		 */
		if (map.get("pageIndex") != null && map.get("pageSize") != null) {
			Integer pageIndex = Integer.parseInt(map.get("pageIndex").toString());
			Integer pageSize = Integer.parseInt(map.get("pageSize").toString());

			map.put("start", (pageIndex - 1) * pageSize);
			map.put("size", pageSize);
		}

		Integer totalCount = coachMapper.getCoachCollectorTotal(map);
		page.setRowCount(totalCount);
		if (totalCount > 0) {
			List<Coach> datas = coachMapper.getCoachCollector(map);
			page.setData(datas);
		}
		return page;
	}
	
	/**
	 * 根据关键字获取教练信息
	 * @param keyword	 教练名字/电话号码
	 * @param ins		机构id
	 * @param areaId	片区id
	 * @param stationId	网点id
	 * @return
	 */
	public List<Coach> getCoachCollectorByKeyWork(String keyword , Integer ins , Integer areaId , Integer stationId){
		Map map = new HashMap<>();
		map.put("insId", ins);
		
		if(!StringUtils.isBlank(keyword)){
			map.put("searchText", keyword);
		}
		if(areaId != null && areaId != 0){
			map.put("", areaId);
		}
		if(stationId != null && stationId != 0){
			map.put("stationId", stationId);
		}
		return coachMapper.getCoachCollector(map);
	}
	
	/**
	 * 获取网点端教练列表
	 * @param stationId 网点id
	 * @return
	 */
	public List<Coach> getStationCoach(Integer stationId){
		Map<String, Integer> map = new HashMap<>();
		map.put("stationId", stationId);
		
		return coachMapper.getStationCoach(map);
	}
}
