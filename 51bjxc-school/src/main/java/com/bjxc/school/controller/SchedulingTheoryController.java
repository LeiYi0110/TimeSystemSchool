package com.bjxc.school.controller;


import java.io.IOException;
import java.io.OutputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bjxc.Page;
import com.bjxc.Result;
import com.bjxc.school.*;
import com.bjxc.school.service.SchedulingTheoryService;
import com.bjxc.web.utils.WebUtils;

@Controller
@RequestMapping(value = "/schedulingTheory")
public class SchedulingTheoryController {
	private static final Logger logger = LoggerFactory.getLogger(SchedulingTheoryController.class);
	@Resource
	private SchedulingTheoryService schedulingTheoryService;
	

	/**
	 * 理论课上报
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/reportList", method = RequestMethod.GET)
	@UserControllerLog(description = "理论课上报")
	public Result reportList(HttpServletRequest request) {
		Result result = new Result();
		Integer stationId=WebUtils.getParameterIntegerValue(request,"stationId");
		/*String station = request.getParameter("stationId");
		Integer stationId = null;
		if (!station.equals("null")) {
			stationId = Integer.parseInt(station);
		}*/
		Integer pageIndex = WebUtils.getParameterIntegerValue(request, "pageIndex");
		Integer pageSize = WebUtils.getParameterIntegerValue(request, "pageSize");
		logger.error("request", request);
		try {
			Page<SchedulingTheory> page = schedulingTheoryService.reportList(stationId,pageIndex, pageSize);
			result.success(page.getData());
			result.put("rowCount", page.getRowCount());
		} catch (Exception e) {
			logger.error("理论课上报搜索列表", e);
			result.error(e);
		}
		return result;
	}
	
	/**
	 * 理论课排班
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/schedulingList", method = RequestMethod.GET)
	@UserControllerLog(description = "理论课排班")
	public Result schedulingList(HttpServletRequest request) {
		Result result = new Result();
		Integer stationId=WebUtils.getParameterIntegerValue(request,"stationId");
		Integer pageIndex = WebUtils.getParameterIntegerValue(request, "pageIndex");
		Integer pageSize = WebUtils.getParameterIntegerValue(request, "pageSize");
		logger.error("request", request);
		try {
			Page<SchedulingTheory> page = schedulingTheoryService.schedulingList(stationId,pageIndex, pageSize);
			result.success(page.getData());
			result.put("rowCount", page.getRowCount());
		} catch (Exception e) {
			logger.error("理论课排班搜索列表", e);
			result.error(e);
		}
		return result;
	}
	/**
	 * 理论排班记录
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/recordList", method = RequestMethod.GET)
	@UserControllerLog(description = "理论排班记录")
	public Result recordList(@RequestParam(value = "classDate", required = false) String classDate,HttpServletRequest request) {
		Result result = new Result();
		
		Integer stationId=WebUtils.getParameterIntegerValue(request,"stationId");
		Integer pageIndex = WebUtils.getParameterIntegerValue(request, "pageIndex");
		Integer pageSize = WebUtils.getParameterIntegerValue(request, "pageSize");
		logger.error("request", request);
		try {
			Page<SchedulingTheory> page = schedulingTheoryService.recordList(classDate,stationId,pageIndex, pageSize);
			result.success(page.getData());
			result.put("rowCount", page.getRowCount());
		} catch (Exception e) {
			logger.error("理论课排班记录搜索列表", e);
			result.error(e);
		}
		return result;
	}
	/**
	 * 理论课上报人数
	 * @param ids
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/theoryUpdate", method = RequestMethod.POST)
	@UserControllerLog(description = "理论课上报人数")
	public Result theoryUpdate(@RequestParam(value = "ids[]", required = true)String[] ids,HttpServletRequest request) {
		Integer stationId = WebUtils.getParameterIntegerValue(request, "stationId");
		Integer insId = WebUtils.getParameterIntegerValue(request, "insId");
		Integer repNumber = WebUtils.getParameterIntegerValue(request, "repNumber");
		Result result = new Result();
		try {
			schedulingTheoryService.theoryUpdate(ids);
			schedulingTheoryService.insertBySchedulingTheory(insId,stationId,repNumber);
			TheoryReportInfo theoryReportInfo=schedulingTheoryService.getTheoryReportInfo(insId,stationId);
			result.success(theoryReportInfo);
		} catch (Exception e) {
			logger.error("theoryUpdate id ", e);
			result.error(e);
		}
		return result;
	}
	
	/**
	 * 理论课排班提交名单
	 * @param ids
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/schedulingUpdate", method = RequestMethod.POST)
	@UserControllerLog(description = "理论课排班提交名单")
	public Result schedulingUpdate(@RequestParam(value = "arrId[]", required = false)String[] arrId,@RequestParam(value = "ids[]", required = false)String[] ids) {
		Result result = new Result();
		try {
			if(arrId!=null){
				schedulingTheoryService.schedulingUpdate(arrId);
			}
			if(ids!=null){
				schedulingTheoryService.notReportedUpdate(ids);
			}
			result.success();
		} catch (Exception e) {
			logger.error("schedulingUpdate id ", e);
			result.error(e);
		}
		return result;
	}
	
	/**
	 * 导出理论课排班记录
	 */
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/exporTrecordList", method = RequestMethod.GET)
	@UserControllerLog(description = "导出理论课排班记录")
	public Result exportStudentstow(@RequestParam(value = "stationId")Integer stationId,@RequestParam(value = "classDate")String classDate,HttpServletResponse response) throws IOException {
		// Result result= new Result();
		//List<ServiceStation> tataion = tservicestationService.gettation();
		response.setCharacterEncoding("UTF-8");
		String fileName = "理论课排班记录.xls";
		fileName = new String(fileName.getBytes("GBK"), "ISO8859_1");
		response.setHeader("Content-Disposition", "attachment;filename=" + fileName);

		response.setDateHeader("Expires", 0);
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Pragma", "no-cache");
		try {
			HSSFSheet sheet = null;
			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFFont f = wb.createFont();
			
			Map map = new HashMap();
			if(stationId != null && stationId != 0){
				map.put("stationId", stationId);
				map.put("classDate", classDate);
			}
			
			
		List<SchedulingTheory> exporTrecordList = schedulingTheoryService.exporTrecordList(map);
		//for (ServiceStation string : tataion) { // 循环添加sheet
			int exportRow = 1;
			 sheet = wb.createSheet("教练信息");
			//sheet = wb.createSheet(string.getName());
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
			cell.setCellValue("日期"); 
			cell.setCellStyle(style);
			
			cell = row.createCell(1);
			cell.setCellValue("学员姓名"); 
			cell.setCellStyle(style);
			
			cell = row.createCell(2);
			cell.setCellValue("电话号码"); 
			cell.setCellStyle(style);
			
			cell = row.createCell(3);
			cell.setCellValue("身份证号"); 
			cell.setCellStyle(style);
		
			cell = row.createCell(4);
			cell.setCellValue("流水"); 
			cell.setCellStyle(style);

			cell = row.createCell(5);
			cell.setCellValue("提交时间"); 
			cell.setCellStyle(style);
	
			
			for (int i = 0; i < exporTrecordList.size(); i++) { // 循环导出数据
				SchedulingTheory sche = exporTrecordList.get(i);
				// 第四步，创建单元格，并设置值
				row = sheet.createRow((int) exportRow);

				//if (string.getId() == stu.getStationId()) {
				
				// 上课日期
				if (sche.getEndTime() != null) {
					row.createCell((short) 0).setCellValue(new SimpleDateFormat("yyyy-MM-dd").format(sche.getClassDate()));
				} else {
					row.createCell((short) 0).setCellValue(" ");
				}
 
				
				// 学员姓名
				if (sche.getStudentName() != null) {
					row.createCell((short) 1).setCellValue(sche.getStudentName());
				} else {
					row.createCell((short) 1).setCellValue(" ");
				}
				// 电话	
				if (sche.getMobile() != null) {

					row.createCell((short) 2).setCellValue(sche.getMobile());
				} else {
					row.createCell((short) 2).setCellValue(" ");
				}

				//身份证号
				if (sche.getIdcard() != null) {

					row.createCell((short) 3).setCellValue(sche.getIdcard());
				} else {
					row.createCell((short) 3).setCellValue(" ");
				}
					
					
				
					
		      
				// 流水号
				if (sche.getRecordnum() != null) {
					row.createCell((short) 4).setCellValue(sche.getRecordnum());
				} else {
					row.createCell((short) 4).setCellValue(" ");
				}


					
				// 提交时间
				if (sche.getEndTime() != null) {
				      cell = row.createCell((short) 5);  
				      cell.setCellValue(new SimpleDateFormat("yyyy-MM-dd").format(sche.getEndTime()));  
				} else {
					row.createCell((short) 5).setCellValue(" ");
				}
					exportRow++;
				}
			//}	
		//}	
			// 设置弹出，用户自己选择路径进行保存。
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
	 * 修改上课日期或备注
	 * @param schedulingTheory
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@UserControllerLog(description = "修改上课日期或备注")
	public Result update(SchedulingTheory schedulingTheory) {
		Result result = new Result();
		
		try {
			schedulingTheoryService.update(schedulingTheory);
			result.success();
		} catch (Exception e) {
			logger.error("change schedulingTheory ", e);
			result.error(e);
		}
		return result;
	}
	/**
	 * 查询上次理论课上报信息
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/getTheoryReportInfo",method=RequestMethod.GET)
	@UserControllerLog(description = "查询上次理论课上报信息")
	public Result get(HttpServletRequest request){
		Integer insId = WebUtils.getParameterIntegerValue(request, "insId");
		Integer stationId = WebUtils.getParameterIntegerValue(request,"stationId");
		Result result = new Result();
		try {
			TheoryReportInfo theoryReportInfo=schedulingTheoryService.getTheoryReportInfo(insId,stationId);
			result.success(theoryReportInfo);
		} catch (Exception e) {
			logger.error("TheoryReportInfo get",e);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/schetheorylist")
	@UserControllerLog(description = "查询上次理论课上报信息列表")
	public Result getScheTheoryList(Integer insId,Integer areaId,Integer staId,String classDateStr,Integer pageIndex,Integer pageSize){
		Result result=new Result();
		Page<SchedulingTheory> page=null;
		Assert.notNull(insId,"insId is null");
		if(areaId!=null){
			if(areaId==-1){
				areaId=null;
			}
		}
		if(staId!=null){
			if(staId==-1){
				staId=null;
			}
		}
		try {
			page = schedulingTheoryService.getScheTheoryList(insId, areaId, staId, classDateStr, pageIndex, pageSize);
			result.put("rowCount", page.getTotalPageCount());
			result.success(page.getData());
		} catch (Exception e) {
			logger.error("getScheTheoryList field ",e.getMessage());
			result.error(e.getMessage());
		}
		return result;
	}
	
	/**
	 * 导出理论上课名单
	 * @param response
	 * @param request
	 * @return
	 * @throws IOException
	 */
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/exportschetheory", method = RequestMethod.GET)
	@UserControllerLog(description = "导出理论上课名单")
	public Result exportCourNum(Integer insId,Integer areaId,String classDateStr,Integer staId,
			String areaName,String staName,HttpServletResponse response,HttpServletRequest request) throws IOException {
		Assert.notNull(insId,"insId is null");
		if(areaId!=null){
			if(areaId==-1){
				areaId=null;
			}
		}
		if(staId!=null){
			if(staId==-1){
				staId=null;
			}
		}
		
		response.setCharacterEncoding("UTF-8");
		String fileName = "理论上课名单" + ".xls";
		fileName = new String(fileName.getBytes("GBK"), "ISO8859_1");
		response.setHeader("Content-Disposition", "attachment;filename=" + fileName);

		response.setDateHeader("Expires", 0);
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Pragma", "no-cache");

		try {
			HSSFSheet sheet = null;
			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFFont f = wb.createFont();
			List<SchedulingTheory> exportlist = schedulingTheoryService.getExportScheduList(insId, areaId, staId, classDateStr);
			if(exportlist.size()>0){
				sheet = wb.createSheet("理论上课名单");
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
				HSSFRow titleRow = sheet.createRow(0);
				HSSFRow titleValRow = sheet.createRow(1);
				HSSFRow row = sheet.createRow(2);
				int exportRow = 3;
				
				cell = titleRow.createCell(0);
				cell.setCellValue("片区"); // 标题头部
				cell.setCellStyle(style);
				titleValRow.createCell(0).setCellValue(areaName);
				
				
				cell = titleRow.createCell(1);
				cell.setCellValue("网点"); // 标题头部
				cell.setCellStyle(style);
				titleValRow.createCell(1).setCellValue(staName);
				
				
				cell = titleRow.createCell(2);
				cell.setCellValue("时间"); // 标题头部
				cell.setCellStyle(style);
				titleValRow.createCell(2).setCellValue(classDateStr);				
				
				// 获取第一行的每一个单元格
				cell = row.createCell(0);
				// 往单元格里面写入值
				cell.setCellValue("日期"); // 头部
				cell.setCellStyle(style);
				
				cell = row.createCell(1);
				cell.setCellValue("网点名称"); // 头部
				cell.setCellStyle(style);
				
				cell = row.createCell(2);
				cell.setCellValue("学员姓名"); // 头部
				cell.setCellStyle(style);
				
				cell = row.createCell(3);
				cell.setCellValue("电话号码"); // 头部
				cell.setCellStyle(style);
				
				cell = row.createCell(4);
				cell.setCellValue("身份证号"); // 头部
				cell.setCellStyle(style);
				
				cell = row.createCell(5);
				cell.setCellValue("流水号"); // 头部
				cell.setCellStyle(style);
				
				cell = row.createCell(6);
				cell.setCellValue("提交日期"); // 头部
				cell.setCellStyle(style);
				
				cell = row.createCell(7);
				cell.setCellValue("备注"); // 头部
				cell.setCellStyle(style);
				
				for (int i = 0; i < exportlist.size(); i++) { // 循环导出数据
					SchedulingTheory scheduling = exportlist.get(i);
					// 第四步，创建单元格，并设置值
					
					row = sheet.createRow((int) exportRow);
					//日期
					if (scheduling.getClassDate()!= null) {
						row.createCell((short) 0).setCellValue(new SimpleDateFormat("yyyy-MM-dd").format(scheduling.getClassDate()));
					} else {
						row.createCell((short) 0).setCellValue(" ");
					}

					//网点名称
					if (scheduling.getStationName()!= null) {
						row.createCell((short) 1).setCellValue(scheduling.getStationName());
					} else {
						row.createCell((short) 1).setCellValue(" ");
					}

					//学员姓名
					if (scheduling.getStuName() != null) {
						row.createCell((short) 2).setCellValue(scheduling.getStuName());
					} else {
						row.createCell((short) 2).setCellValue(" ");
					}

					//电话号码
					if (scheduling.getStuMobile() != null) {
						row.createCell((short) 3).setCellValue(scheduling.getStuMobile());
					} else {
						row.createCell((short) 3).setCellValue(" ");
					}

					//身份证号
					if (scheduling.getStuIdCard() != null) {
						row.createCell((short) 4).setCellValue(scheduling.getStuIdCard());
					} else {
						row.createCell((short) 4).setCellValue(" ");
					}

					//流水号
					if (scheduling.getStuRecNum() != null) {
						row.createCell((short) 5).setCellValue(scheduling.getStuRecNum());
					} else {
						row.createCell((short) 5).setCellValue(" ");
					}

					//提交日期
					if (scheduling.getEndTime() != null) {
						row.createCell((short) 6).setCellValue(new SimpleDateFormat("yyyy-MM-dd").format(scheduling.getEndTime()));
					} else {
						row.createCell((short) 6).setCellValue(" ");
					}
					
					//备注
					if (scheduling.getRemarks()!= null) {
						row.createCell((short) 7).setCellValue(scheduling.getRemarks());
					} else {
						row.createCell((short) 7).setCellValue(" ");
					}
					exportRow++;
				}
				// 第六步，将文件存到指定位置
				// wb.write(response.getOutputStream());
				OutputStream out = response.getOutputStream();
				wb.write(out);
				out.flush();
				out.close();
			}else{
				logger.info("没有数据");
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		return null;
	}
	
	@ResponseBody
	@RequestMapping(value="/getByStudent",method=RequestMethod.POST)
	@UserControllerLog(description = "获取学员理论排班")
	public Result getByStudent(Integer insId,Integer stationId,String keyword,HttpServletRequest request){
		Result result = new Result();
		try {
			List<SchedulingTheory> schedulingTheory=schedulingTheoryService.getByStudent(insId, stationId, keyword);
			result.success(schedulingTheory);
		} catch (Exception e) {
			logger.error("SchedulingTheory get",e);
		}
		return result;
	}
	
	/**
	 * 理论课排班学员添加
	 * @param schedulingTheory
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/addSchedulingStu", method = RequestMethod.POST)
	@UserControllerLog(description = "理论课排班学员添加")
	public Result addSchedulingStu(SchedulingTheory schedulingTheory) {
		Result result = new Result();
		
		try {
			schedulingTheoryService.addSchedulingStu(schedulingTheory);
			result.success();
			
		} catch (Exception e) {
			logger.error("change schedulingTheory ", e);
			result.error(e);
		}
		return result;
	}
}
