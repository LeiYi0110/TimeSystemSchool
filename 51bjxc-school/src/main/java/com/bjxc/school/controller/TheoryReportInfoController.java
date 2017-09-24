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
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.bjxc.Page;
import com.bjxc.Result;
import com.bjxc.school.ServiceStation;
import com.bjxc.school.TheoryReportInfo;
import com.bjxc.school.Tteacharea;
import com.bjxc.school.service.TheoryReportInfoService;
import com.bjxc.web.utils.WebUtils;

/**  
* @author huangjr  
* @date 2016年12月3日  创建  
*/
@RestController
@RequestMapping(value="/theoryreportinfo")
public class TheoryReportInfoController {
	private static final Logger logger=LoggerFactory.getLogger(TheoryReportInfoController.class);
	@Resource
	private TheoryReportInfoService theoryReportInfoService;
	
	@RequestMapping(value="/getcourselist")
	@UserControllerLog(description = "获取课程列表")    
	public Result getCourseList(Integer insId,Integer areaId,String beginCreateTiStr,String endCreateTiStr,Integer pageIndex, Integer pageSize){
		Result result=new Result();
		Page<TheoryReportInfo> page=null;
		Assert.notNull(insId,"insId is null");
		if(areaId!=null){
			if(areaId==-1){
				areaId=null;
			}
		}
		try {
			page = theoryReportInfoService.getCourseList(insId,areaId,beginCreateTiStr,endCreateTiStr,pageIndex,pageSize);
			result.put("rowCount",page.getRowCount());
			result.success(page.getData());
		} catch (Exception e) {
			logger.error("getCourseList field ",e.getMessage());
			result.error(e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value="/getrolllist")
	public Result getRollList(Integer insId,Integer areaId,Integer stationId,Integer pageIndex, Integer pageSize){
		Result result=new Result();
		Page<TheoryReportInfo> page=null;
		Assert.notNull(insId,"insId is null");
		if(areaId!=null){
			if(areaId==-1){
				areaId=null;
			}
		}
		if(stationId!=null){
			if(stationId==-1){
				stationId=null;
			}
		}
		try {
			//page = theoryReportInfoService.;
			//result.put("rowCount", page.getTotalPageCount());
			//result.success(page.getData());
		} catch (Exception e) {
			logger.error("getRollList field ",e.getMessage());
			result.error(e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value="/getareas")
	public Result getAreas(Integer insId){
		Result result=new Result();
		Assert.notNull(insId,"insId is null");
		try {
			List<Tteacharea> list= theoryReportInfoService.getAreas(insId);
			result.success(list);
		} catch (Exception e) {
			logger.error("getAreas field ",e.getMessage());
			result.error(e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value="/getstations")
	public Result getStations(Integer insId){
		Result result=new Result();
		Assert.notNull(insId,"insId is null");
		try {
			List<ServiceStation> list= theoryReportInfoService.getStations(insId);
			result.success(list);
		} catch (Exception e) {
			logger.error("getStations field ",e.getMessage());
			result.error(e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value="/getstationbyareaid")
	public Result getStationByAreaId(Integer insId,Integer areaId){
		Result result=new Result();
		Assert.notNull(insId,"insId is null");
		Assert.notNull(areaId,"areaId is null");
		if(areaId==-1){
			areaId=null;
		}
		try {
			List<ServiceStation> list= theoryReportInfoService.getStationByAreaId(insId,areaId);
			result.success(list);
		} catch (Exception e) {
			logger.error("getStationByAreaId field ",e.getMessage());
			result.error(e.getMessage());
		}
		return result;
	}
	
	/**
	 * 导出理论课人数统计
	 * @param response
	 * @param request
	 * @return
	 * @throws IOException
	 */
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/theorecournum", method = RequestMethod.GET)
	public Result exportCourNum(Integer insId,Integer areaId,String beginCreateTiStr,String endCreateTiStr,
			String areaName,HttpServletResponse response,HttpServletRequest request) throws IOException {
		Assert.notNull(insId,"insId is null");
		if(areaId!=null){
			if(areaId==-1){
				areaId=null;
			}
		}
		
		response.setCharacterEncoding("UTF-8");
		String fileName = "理论课人数统计" + ".xls";
		fileName = new String(fileName.getBytes("GBK"), "ISO8859_1");
		response.setHeader("Content-Disposition", "attachment;filename=" + fileName);

		response.setDateHeader("Expires", 0);
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Pragma", "no-cache");

		try {
			HSSFSheet sheet = null;
			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFFont f = wb.createFont();
			List<TheoryReportInfo> exportlist = theoryReportInfoService.getExportCourNum(insId, areaId, beginCreateTiStr, endCreateTiStr);
			if(exportlist.size()>0){
				sheet = wb.createSheet("理论课人数统计");
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
				cell.setCellValue("上课总人数"); // 标题头部
				cell.setCellStyle(style);
				titleValRow.createCell(0).setCellValue(exportlist.get(0).getTotalCount());
				
				
				cell = titleRow.createCell(1);
				cell.setCellValue("片区"); // 标题头部
				cell.setCellStyle(style);
				titleValRow.createCell(1).setCellValue(areaName);
				
				
				cell = titleRow.createCell(2);
				cell.setCellValue("开始时间"); // 标题头部
				cell.setCellStyle(style);
				titleValRow.createCell(2).setCellValue(beginCreateTiStr);
				
				
				cell = titleRow.createCell(3);
				cell.setCellValue("结束时间"); // 标题头部
				cell.setCellStyle(style);
				titleValRow.createCell(3).setCellValue(endCreateTiStr);
				
				
				// 获取第一行的每一个单元格
				cell = row.createCell(0);
				// 往单元格里面写入值
				cell.setCellValue("网点名称"); // 头部
				cell.setCellStyle(style);
				
				cell = row.createCell(1);
				cell.setCellValue("要求上课人数"); // 头部
				cell.setCellStyle(style);
				
				cell = row.createCell(2);
				cell.setCellValue("提交日期"); // 头部
				cell.setCellStyle(style);
				
				for (int i = 0; i < exportlist.size(); i++) { // 循环导出数据
					TheoryReportInfo theory = exportlist.get(i);
					// 第四步，创建单元格，并设置值
					
					row = sheet.createRow((int) exportRow);
					//网点名称
					if (theory.getStationName()!= null) {
						row.createCell((short) 0).setCellValue(theory.getStationName());
					} else {
						row.createCell((short) 0).setCellValue(" ");
					}

					//要求上课人数
					if (theory.getRepNumber()!= null) {
						row.createCell((short) 1).setCellValue(theory.getRepNumber());
					} else {
						row.createCell((short) 1).setCellValue(" ");
					}

					// 提交日期
					if (theory.getCreatetime() != null) {
						row.createCell((short) 2).setCellValue(new SimpleDateFormat("yyyy-MM-dd hh-mm-ss").format(theory.getCreatetime()));
					} else {
						row.createCell((short) 2).setCellValue(" ");
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
	
}
