package com.bjxc.school.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjxc.Page;
import com.bjxc.school.Coach;
import com.bjxc.school.CoachComment;
import com.bjxc.school.CoachCommentParam;
import com.bjxc.school.CommentInsCoach;
import com.bjxc.school.Complaint;
import com.bjxc.school.Evaluation;
import com.bjxc.school.SchoolCommentParam;
import com.bjxc.school.Student;
import com.bjxc.school.StudentReserveComment;
import com.bjxc.school.Tteacharea;
import com.bjxc.school.mapper.CoachMapper;
import com.bjxc.school.mapper.CommentMapper;
import com.bjxc.school.mapper.StudentMapper;
import com.bjxc.school.mapper.StudentSubjectMapper;

@Service
public class CommentService {
	@Resource
	private CommentMapper commentMapper;
	@Resource
	private StudentMapper studentMapper;
	@Resource
	private CoachMapper coachMapper;
	
	/**
	 * 学员评论教练
	 * @param insId
	 * @param pageIndex
	 * @param pageSize
	 * @return
	 */
	public Page<CommentInsCoach> commlist(Integer insId,Integer pageIndex,Integer pageSize,String searchText){
		 Page<CommentInsCoach> page= new Page<CommentInsCoach>(pageIndex,pageSize); 		 
			Integer totalCount = commentMapper.countcomm(insId,searchText);
			page.setRowCount(totalCount);
			if(totalCount > 0){
				List<CommentInsCoach> datas = commentMapper.commlist(insId,page.getStartRow(),page.getPageSize(),searchText);
				
				datas.stream().forEach(d -> {
					if(d.getResInfoId() == null || d.getResInfoId().equals(0)){
						d.setCoachname(d.getcCoachName());
					}
				});
				
				page.setData(datas);
			}
			return page;
	}
	
	
	/**
	 * 学员评论驾校
	 * @param insId
	 * @param star
	 * @return
	 */
	public Page<Evaluation> shcoolcomm(Integer insId,Integer pageIndex,Integer pageSize,String searchText){
		 Page<Evaluation> page= new Page<Evaluation>(pageIndex,pageSize); 		 
			Integer totalCount = commentMapper.countshcoolcomm(insId,searchText);
			page.setRowCount(totalCount);
			if(totalCount > 0){
				List<Evaluation> datas =commentMapper.shcoolcomm(insId,page.getStartRow(),page.getPageSize(),searchText);
				page.setData(datas);
			}
			return page;
	}
	
	
	public List<Evaluation> getIns(Integer insId,Integer star){
		return commentMapper.getIns(insId,star);
	}
	
	public CommentInsCoach getInsInfo(Integer insId){
		return commentMapper.getInsInfo(insId);
	}
	
	public CommentInsCoach getCoachInfo(Integer coachId){
		return commentMapper.getCoachInfo(coachId);
	}
	
	public Integer getCoachId(Integer insId){
		return commentMapper.getCoachId(insId);
	}
	
	public List<CoachComment> getCoachComment(Integer coachId){
		return commentMapper.getCoachComment(coachId);
	}
	
	public List<Map> getCoach(String name,Integer insId){
		return commentMapper.getCoach(name,insId);
	}
	

	public Integer countcomm(Integer insId,String searchText){
		return commentMapper.countcomm(insId,searchText);
		
	}
	
    public List<CoachComment> getCoachCommentlist(Integer coachId){
		return commentMapper.getCoachComment(coachId); 	
    }
    
    public Integer countshcoolcomm(Integer insId,String searchText){
		return commentMapper.countshcoolcomm(insId,searchText);
    	
    }
    
    public List<CoachComment> coachdetails(Integer id){
		return commentMapper.coachdetails(id);
    	
    }
    
    /**
     * 教练评论导出
     * @param insId
     * @return
     */
    public List<CommentInsCoach> exportcommlist(Integer insId){
		return commentMapper.exportcommlist(insId);
    	
    }
    
    /**
     * 驾校评论导出
     * @param insId
     * @return
     */
    public List<Evaluation> exportshcoolcomm(Integer insId){
		return commentMapper.exportshcoolcomm(insId);
    	
    }

    public Evaluation get(Integer id){
		return commentMapper.get(id);
	}
    public CommentInsCoach getComm(Integer id){
		return commentMapper.getComm(id);
	}
    
    /**
     * 备案-学员评价教练
     * @param commentInsCoach
     * @return
     */
    public Integer updateCoachStatus(CommentInsCoach commentInsCoach){
    	return commentMapper.updateCoachStatus(commentInsCoach);
    }
    
    /**
     * 备案-学员评价驾校
     * @param evaluation
     * @return
     */
    public Integer updateEvalStatus(Evaluation evaluation){
    	return commentMapper.updateEvalStatus(evaluation);
    }
    
    
    public Integer addEval(SchoolCommentParam param) throws Exception{
    	Student student = studentMapper.getByStuNum(param.getStudentNum(),param.getStudentName());
		if(student == null){
			throw new Exception("学员不存在");
		}
		
		

		Evaluation evaluation = new Evaluation();
		evaluation.setStudentId(student.getId());
		evaluation.setInsId(param.getInsId());
		evaluation.setOverall(param.getStart());
		evaluation.setTeachlevel(param.getComent());
		evaluation.setSrvmanner(param.getComent());
		
		evaluation.setIsValid(param.getInsId() == student.getInsId() ? 1 : 0);
		
		return commentMapper.insertEval(evaluation);
    }
    
    /**
     * 创建教练评价
     * @param param
     * @return
     * @throws Exception
     */
    public Integer addCoachComment(CoachCommentParam param) throws Exception{
    	
    	Coach coach = coachMapper.getByCoachNum(param.getCoachNum(), param.getCoachName());
    	if(coach == null){
    		throw new Exception("教练不存在");
    	}
    	Student student = studentMapper.getByStuNum(param.getStudentNum(), param.getStudentName());
    	if(student == null){
    		throw new Exception("学员不存在");
    	}
    	
    	int studentCoachCount = commentMapper.countStudentCoach(coach.getId(), student.getId());
    	
    	StudentReserveComment comment = new StudentReserveComment();
    	comment.setStart(param.getStart());
    	comment.setComment(param.getComment());
    	comment.setStudentId(student.getId());
    	comment.setCoachId(coach.getId());
    	comment.setIsCommentProvince(0);
    	comment.setResInfoId(0);
    	comment.setStatus(studentCoachCount > 0 ? 1 : 0);
    	
    	return commentMapper.insertCoachComment(comment);
    }
    
}
