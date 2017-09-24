package com.bjxc.school.controller;

import java.util.Date;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bjxc.Result;
import com.bjxc.school.ReFund;
import com.bjxc.school.service.ReFundService;
import com.bjxc.school.service.StudentService;

@Controller
@RequestMapping(value = "/refund")
public class ReFundController {
	private static final Logger logger = LoggerFactory.getLogger(ReFundController.class);
	@Resource
	private ReFundService reFundService;
	@Resource
	private StudentService studentService; 
	
	@ResponseBody
	@RequestMapping(value ="/add",method=RequestMethod.POST)
	@UserControllerLog(description = "退费申请")
	public Result add(Integer stuId,Integer money,String stuNote,Integer alreadyPay){
		Result result=new Result();
		try {
		if(money>alreadyPay){
			result.error("退费金额 不能大于 实缴金额!");
			throw new Exception("退费金额 不能大于 实缴金额!");
		}
		Integer check=studentService.checkStuRefund(stuId);
			if((check!=new Integer(1)&&check!=new Integer(2))||check==null){
				ReFund refund=new ReFund();
				refund.setStudentID(stuId);
				refund.setMoney(money*100);
				refund.setStuNote(stuNote);
				Date date=new Date();
				refund.setCreateTime(date);
				refund.setReviewUserId(-1);//没有审批人
				refund.setStatus(1);//已申请
				reFundService.add(refund);
				
				result.success();
			}else{
				result.error("你已经提交了一个退费申请,请等待审批吧");
			}
		} catch (Exception e) {
			logger.error("Student field list",e);
			result.error(e);
		}
		return result;
	}

}
