package com.bjxc.school.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bjxc.Page;
import com.bjxc.Result;
import com.bjxc.school.Coach;
import com.bjxc.school.CoachComment;
import com.bjxc.school.CoachCommentParam;
import com.bjxc.school.CommentInsCoach;
import com.bjxc.school.Evaluation;
import com.bjxc.school.InstitutionInfo;
import com.bjxc.school.SchoolCommentParam;
import com.bjxc.school.Student;
import com.bjxc.school.security.UsinInfo;
import com.bjxc.school.service.CoachService;
import com.bjxc.school.service.CommentService;
import com.bjxc.school.service.InstitutionInfoService;
import com.bjxc.school.service.StudentService;
import com.bjxc.web.utils.WebUtils;

@Controller
@RequestMapping(value="/comment")
public class CommentController {
	private static final Logger logger = LoggerFactory.getLogger(CommentController.class);
	@Resource
	private CommentService commentService;
	@Resource
	private StudentService studentService;
	@Resource
	private CoachService coachService;
	
	@Resource
	private InstitutionInfoService institutionInfoService;
	
	@ResponseBody
	@RequestMapping(value="/getList",method=RequestMethod.GET)
	@UserControllerLog(description = "获取评论列表")
	public Result getList(Integer insId,Integer coachId,Integer star){
		Result result=new Result();
		try {
			Assert.notNull(insId);
			/*if(star==0){
				star=null;
			}*/
				if(coachId==0){
					coachId=commentService.getCoachId(insId);
				}
				CommentInsCoach coach=commentService.getCoachInfo(coachId);
				List<CoachComment> coachs=commentService.getCoachComment(coachId);
				result.success(coachs);
				result.put("coach", coach);
			
		} catch (Exception e) {
			logger.error("评价信息",e);
			result.error(e);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/getCoach",method=RequestMethod.GET)
	@UserControllerLog(description = "教练搜索")
	public Result getCoach(Integer insId,HttpServletRequest request){
		Result result=new Result();
		try {
			String name=request.getParameter("keyword");
			result.success(commentService.getCoach(name, insId));
		} catch (Exception e) {
			logger.error("教练搜索",e);
			result.error(e);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/commlist",method=RequestMethod.GET)
	@UserControllerLog(description = "评论列表")
	public Result commlist(Integer insId,Integer pageIndex,Integer pageSize,String searchText,HttpServletRequest request){
		Result result=new Result();
		try {
			int rowCount=commentService.countcomm(insId,searchText);
			Page<CommentInsCoach> page= commentService.commlist(insId,pageIndex,pageSize,searchText);
			result.put("rowCount",rowCount);
			result.success(page.getData());
		} catch (Exception e) {
			result.error(e);
		}
		return result;
	}
	
	
	@ResponseBody
	@RequestMapping(value="/shcoolcomm",method=RequestMethod.GET)
	@UserControllerLog(description = "驾校评论列表")
	public Result shcoolcomm(Integer insId,Integer pageIndex,Integer pageSize,HttpServletRequest request,String searchText){
		Result result=new Result();
		try {
			System.out.println(searchText);
			int rowCount=commentService.countshcoolcomm(insId,searchText);
			Page<Evaluation> page= commentService.shcoolcomm(insId,pageIndex,pageSize,searchText);
			result.put("rowCount",rowCount);
			result.success(page.getData());
		} catch (Exception e) {
			result.error(e);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/coachdetails",method=RequestMethod.GET)
	@UserControllerLog(description = "获取教练评价列表")
	public Result coachdetails(Integer id,HttpServletRequest request){
		Result result=new Result();
		try {
			List<CoachComment> list = commentService.coachdetails(id);
			request.setAttribute("list", list);
			result.success(list);
		} catch (Exception e) {
			result.error(e);
		}
		return result;
	}
	@ResponseBody
	@RequestMapping(value="/{id}",method=RequestMethod.GET)
	@UserControllerLog(description = "获取评论信息")
	public Result get(@PathVariable Integer id,HttpServletRequest request){
		Assert.notNull(id,"id is null");
		Result result = new Result();
		try {
			Evaluation evaluation=commentService.get(id);
			result.success(evaluation);
		} catch (Exception e) {
			logger.error("Evaluation get",e);
		}
		return result;
	}
  
	/**
	 * 导出学员评价驾校
	 * @param response
	 * @param request
	 * @return
	 * @throws IOException
	 */
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/exportshcoolcomm", method = RequestMethod.GET)
	@UserControllerLog(description = "导出学员评价驾校")
	public Result exportStudents(HttpServletResponse response,HttpServletRequest request) throws IOException {
		Integer insId = WebUtils.getParameterIntegerValue(request, "insId");
		response.setCharacterEncoding("UTF-8");
		String fileName = "学员评价驾校信息" + ".xls";
		fileName = new String(fileName.getBytes("GBK"), "ISO8859_1");
		response.setHeader("Content-Disposition", "attachment;filename=" + fileName);

		response.setDateHeader("Expires", 0);
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Pragma", "no-cache");

		try {
			HSSFSheet sheet = null;
			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFFont f = wb.createFont();
			int exportRow = 1;
			List<Evaluation> exportlist = commentService.exportshcoolcomm(insId);
			sheet = wb.createSheet("学员评价驾校信息");
			HSSFRow row = sheet.createRow(0);
			HSSFCell cell = null;
			HSSFCellStyle style = wb.createCellStyle();
			style.setWrapText(true);// 设置自动换行
			// 第一个参数代表列id(从0开始),第2个参数代表宽度值
			sheet.setColumnWidth(0, 4500);
			sheet.setColumnWidth(1, 4500);
			sheet.setColumnWidth(2, 4500);
			sheet.setColumnWidth(3, 4500);
			sheet.setColumnWidth(4, 4500);
			sheet.setColumnWidth(5, 4500);
			f.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);// 粗体显示
			style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
			sheet.autoSizeColumn(1, true);
			// row.setHeightInPoints(30); //设置行高
			style.setFont(f);
			sheet.autoSizeColumn(1);
			// 获取第一行的每一个单元格
			cell = row.createCell(0);
			// 往单元格里面写入值
			cell.setCellValue("评价时间"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(1);
			cell.setCellValue("学员姓名"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(2);
			cell.setCellValue("身份证号码"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(3);
			cell.setCellValue("隶属报名处"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(4);
			cell.setCellValue("评价等级"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(5);
			cell.setCellValue("评价内容"); // 头部
			cell.setCellStyle(style);
			for (int i = 0; i < exportlist.size(); i++) { // 循环导出数据
				Evaluation stu = exportlist.get(i);
				// 第四步，创建单元格，并设置值
				
				row = sheet.createRow((int) exportRow);
				//评论时间  
			
				if (stu.getEvaluatetime() != null) {
					row.createCell((short) 0).setCellValue(new SimpleDateFormat("yyyy-MM-dd").format(stu.getEvaluatetime()));
				} else {
					row.createCell((short) 0).setCellValue(" ");
				}

				// 学员名称
				if (stu.getStuName() != null) {
					row.createCell((short) 1).setCellValue(stu.getStuName());
				} else {
					row.createCell((short) 1).setCellValue(" ");
				}

				// 身份证号码
				if (stu.getIdcard() != null) {
					row.createCell((short) 2).setCellValue(stu.getIdcard());
				} else {
					row.createCell((short) 2).setCellValue(" ");
				}

				// 隶属报名处
				if (stu.getTationname() != null) {
					row.createCell((short) 3).setCellValue(stu.getTationname());
				} else {
					row.createCell((short) 3).setCellValue(" ");
				}

				// 评价等级
				if (stu.getOverall() != null) {					
					if(stu.getOverall()==1){
						row.createCell((short) 4).setCellValue("一星");
					}else if(stu.getOverall()==2){
						row.createCell((short) 4).setCellValue("二星");
					}else if(stu.getOverall()==3){
						row.createCell((short) 4).setCellValue("三星");
					}else if(stu.getOverall()==4){
						row.createCell((short) 4).setCellValue("四星");
					}else if(stu.getOverall()==5){
						row.createCell((short) 4).setCellValue("五星");
					}else{
						row.createCell((short) 4).setCellValue(" ");
					}
				} else {
					row.createCell((short) 4).setCellValue(" ");
				}

				// 评价内容
				if (stu.getTeachlevel() != null) {
					row.createCell((short) 5).setCellValue(stu.getTeachlevel());
				} else {
					row.createCell((short) 5).setCellValue(" ");
				}

				exportRow++;
			}
			// 第六步，将文件存到指定位置
			// wb.write(response.getOutputStream());
			OutputStream out = response.getOutputStream();
			wb.write(out);
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 导出学员评价教练
	 */
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/exportcommlist", method = RequestMethod.GET)
	@UserControllerLog(description = "导出学员评价教练")
	public Result exportcommlist(HttpServletResponse response,HttpServletRequest request) throws IOException {
		Integer insId = WebUtils.getParameterIntegerValue(request, "insId");
		response.setCharacterEncoding("UTF-8");
		String fileName = "学员评论教练信息" + ".xls";
		fileName = new String(fileName.getBytes("GBK"), "ISO8859_1");
		response.setHeader("Content-Disposition", "attachment;filename=" + fileName);

		response.setDateHeader("Expires", 0);
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Pragma", "no-cache");

		try {
			HSSFSheet sheet = null;
			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFFont f = wb.createFont();
			int exportRow = 1;
			List<CommentInsCoach> exportlist = commentService.exportcommlist(insId);
			sheet = wb.createSheet("学员评论教练信息");
			HSSFRow row = sheet.createRow(0);
			HSSFCell cell = null;
			HSSFCellStyle style = wb.createCellStyle();
			style.setWrapText(true);// 设置自动换行
			// 第一个参数代表列id(从0开始),第2个参数代表宽度值
			sheet.setColumnWidth(0, 4500);
			sheet.setColumnWidth(1, 4500);
			sheet.setColumnWidth(2, 4500);
			sheet.setColumnWidth(3, 4500);
			sheet.setColumnWidth(4, 4500);
			sheet.setColumnWidth(5, 4500);
			sheet.setColumnWidth(6, 4500);
			sheet.setColumnWidth(7, 4500);
			sheet.setColumnWidth(8, 4500);
			sheet.setColumnWidth(9, 12000);
			f.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);// 粗体显示
			style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
			sheet.autoSizeColumn(1, true);
			// row.setHeightInPoints(30); //设置行高
			style.setFont(f);
			sheet.autoSizeColumn(1);
			// 获取第一行的每一个单元格
			cell = row.createCell(0);
			// 往单元格里面写入值
			cell.setCellValue("评论时间"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(1);
			cell.setCellValue("隶属报名处"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(2);
			cell.setCellValue("身份证号码"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(3);
			cell.setCellValue("学员姓名"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(4);
			cell.setCellValue("教练名称"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(5);
			cell.setCellValue("培训开始时间"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(6);
			cell.setCellValue("培训结束时间"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(7);
			cell.setCellValue("课时时长"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(8);
			cell.setCellValue("评价等级"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(9);
			cell.setCellValue("评价内容"); // 头部
			cell.setCellStyle(style);
			
			for (int i = 0; i < exportlist.size(); i++) { // 循环导出数据
				CommentInsCoach stu = exportlist.get(i);
				// 第四步，创建单元格，并设置值
				row = sheet.createRow((int) exportRow);
				
				
				if (stu.getCreateTime() != null) {
					row.createCell((short) 0).setCellValue(new SimpleDateFormat("yyyy-MM-dd").format(stu.getCreateTime()));
				} else {
					row.createCell((short) 0).setCellValue(" ");
				}

				
				if (stu.getServicename() != null) {
					row.createCell((short) 1).setCellValue(stu.getServicename());
				} else {
					row.createCell((short) 1).setCellValue(" ");
				}

			
				if (stu.getIdcard() != null) {
					row.createCell((short) 2).setCellValue(stu.getIdcard());
				} else {
					row.createCell((short) 2).setCellValue(" ");
				}

			
				if (stu.getStudentName() != null) {
					row.createCell((short) 3).setCellValue(stu.getStudentName());
				} else {
					row.createCell((short) 3).setCellValue(" ");
				}

		
				if (stu.getCoachname() != null) {
					row.createCell((short) 4).setCellValue(stu.getCoachname());
				} else {
					row.createCell((short) 4).setCellValue(" ");
				}

		
				if (stu.getStarttime() != null) {
					row.createCell((short) 5).setCellValue(stu.getStarttime());
				} else {
					row.createCell((short) 5).setCellValue(" ");
				}

			
				if (stu.getEndtime() != null) {
					row.createCell((short) 6).setCellValue(stu.getEndtime());
				} else {
					row.createCell((short) 6).setCellValue(" ");
				}

		
				if (stu.getDuration() != null) {
					row.createCell((short) 7).setCellValue(stu.getDuration());
				} else {
					row.createCell((short) 7).setCellValue(" ");
				}

		
				if (stu.getStar() != null) {
					
					if(stu.getStar()==1){
						row.createCell((short) 8).setCellValue("一星");
					}else if(stu.getStar()==2){
						row.createCell((short) 8).setCellValue("二星");
					}else if(stu.getStar()==3){
						row.createCell((short) 8).setCellValue("三星");
					}else if(stu.getStar()==4){
						row.createCell((short) 8).setCellValue("四星");
					}else if(stu.getStar()==5){
						row.createCell((short) 8).setCellValue("五星");
					}else{
						row.createCell((short) 8).setCellValue(" ");
					}
					
				} else {
					row.createCell((short) 8).setCellValue(" ");
				}
				if (stu.getComment() != null) {
					row.createCell((short) 9).setCellValue(stu.getComment());
				} else {
					row.createCell((short) 9).setCellValue(" ");
				}
				exportRow++;
			}
			// 第六步，将文件存到指定位置
			// wb.write(response.getOutputStream());
			OutputStream out = response.getOutputStream();
			wb.write(out);
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@ResponseBody
	@RequestMapping(value="/getComm",method=RequestMethod.GET)
	@UserControllerLog(description = "getComm")
	public Result getComm(Integer id,HttpServletRequest request){
		Assert.notNull(id,"id is null");
		Result result = new Result();
		try {
			CommentInsCoach commentInsCoach=commentService.getComm(id);
			result.success(commentInsCoach);
		} catch (Exception e) {
			logger.error("CommentInsCoach get",e);
		}
		return result;
	}

	//备案-学员评价教练
	@ResponseBody
	@RequestMapping(value="/coachStatus",method=RequestMethod.POST)
	@UserControllerLog(description = "备案-学员评价教练")
	public Result updateCoachStatus(CommentInsCoach commentInsCoach,HttpServletRequest request){
		Result result = new Result();
		try {
			commentService.updateCoachStatus(commentInsCoach);
			result.success();
		} catch (Exception e) {
			logger.error("CommentInsCoach updateCoachStatus",e);
			result.error(e.getMessage());
		}
		return result;
	}
	
	//备案-学员评价驾校
	@ResponseBody
	@RequestMapping(value="/evalStatus",method=RequestMethod.POST)
	@UserControllerLog(description = "备案-学员评价驾校")
	public Result updateEvalStatus(Evaluation evaluation,HttpServletRequest request){
		Result result = new Result();
		try {
			commentService.updateEvalStatus(evaluation);
			result.success();
		} catch (Exception e) {
			logger.error("CommentInsCoach updateEvalStatus",e);
			result.error(e.getMessage());
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/addSchoolComment",method=RequestMethod.POST)
	public Result addSchoolComment(SchoolCommentParam param){
		Result result = new Result();
		try {
			//UsinInfo usinInfo = (UsinInfo)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			
			InstitutionInfo insInfo = institutionInfoService.getIns(param.getInstitutionName().trim());
			param.setInsId(insInfo.getId());
			commentService.addEval(param);
			result.success();
		} catch (Exception e) {
			logger.error("addSchoolComment",e);
			result.error(e.getMessage());
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/addCoachComment",method=RequestMethod.POST)
	public Result addCoachComment(CoachCommentParam param){
		Result result = new Result();
		try{
			commentService.addCoachComment(param);
			result.success();
		}catch (Exception e) {
			logger.error("addCoachComment",e);
			result.error(e.getMessage());
		}
		
		return result;
	}
}
