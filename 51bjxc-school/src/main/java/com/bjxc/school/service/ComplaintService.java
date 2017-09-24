package com.bjxc.school.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.bjxc.Page;
import com.bjxc.school.Coach;
import com.bjxc.school.Complaint;
import com.bjxc.school.Examiner;
import com.bjxc.school.Student;
import com.bjxc.school.controller.ComplaintController;
import com.bjxc.school.mapper.CoachMapper;
import com.bjxc.school.mapper.ComplaintMapper;
import com.bjxc.school.mapper.StudentMapper;

@Service
public class ComplaintService {
	
	private static final Logger logger = LoggerFactory.getLogger(ComplaintService.class);
	
	@Resource
	private ComplaintMapper complaintMapper;
	@Resource
	private StudentMapper studentMapper;
	@Resource
	private CoachMapper coachMapper;
	
	@Resource
	private StudentSubjectService studentSubjectService;
	
	public Page<Complaint> pageQuery(Integer type, String searchText, Integer insId, Integer stationId, Date startTime,
			Date endTime, Integer pageIndex, Integer pageSize) {
		Page<Complaint> page = new Page<Complaint>(pageIndex, pageSize);
		Integer totalCount = complaintMapper.pageListTotal(type, searchText, insId, stationId, startTime, endTime);
		page.setRowCount(totalCount);
		if (totalCount > 0) {
			List<Complaint> datas = complaintMapper.pageList(type, searchText, insId, stationId, startTime, endTime,
					page.getStartRow(), page.getPageSize());
			page.setData(datas);
		}
		return page;
	}
	
	public Complaint get(Integer id){
		return complaintMapper.get(id);
	}
	
	public void add(Complaint complaint) throws Exception{
		if(complaint.getType() == 1){
			Student student = studentMapper.getByStuNum(complaint.getStunum(),complaint.getStudentName());
			if(student == null){
				throw new Exception("学员不存在");
			}
			complaint.setStudentId(student.getId());
			
			Coach coach = coachMapper.getByCoachNum(complaint.getCoachnum(), complaint.getCoachName());
			if(coach == null){
				throw new Exception("教练不存在");
			}
			
			complaint.setObjectId(coach.getId());
			
			if (studentSubjectService.isExistsRelationShip(student.getId(), coach.getId())) {
				complaint.setIsValid(1);
			}
			else {
				complaint.setIsValid(0);
			}
			
		}else{
			Student student = studentMapper.getByStuNum(complaint.getStunum(),complaint.getStudentName());
			if(student == null){
				throw new Exception("学员不存在");
			}
			complaint.setStudentId(student.getId());
			complaint.setObjectId(complaint.getInsId());
			complaint.setIsValid(complaint.getInsId() == student.getInsId()? 1 : 0);
		}
		complaintMapper.add(complaint);
	}
	
	public void update(Complaint complaint){
		complaintMapper.update(complaint);
	}
	
	/**
	 * 导出所有教练或机构的投诉信息
	 * @return
	 */
	public List<Complaint> exceporComplaint(Integer type){
		
		return	complaintMapper.tcomplaintList(type);
	}
	
	
	public void udpatedriving(Complaint complaint){
		complaintMapper.udpatedriving(complaint);
	}
}
