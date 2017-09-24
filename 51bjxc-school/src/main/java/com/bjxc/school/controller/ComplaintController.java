package com.bjxc.school.controller;


import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.bjxc.Page;
import com.bjxc.Result;
import com.bjxc.school.Complaint;
import com.bjxc.school.InstitutionInfo;
import com.bjxc.school.security.UsinInfo;
import com.bjxc.school.service.ComplaintService;
import com.bjxc.school.service.InstitutionInfoService;

/**
 * 投诉信息管理新增、修改、删除
 * @author Administrator
 *
 */
@RestController
@RequestMapping(value="/complaint")
public class ComplaintController {
	private static final Logger logger = LoggerFactory.getLogger(ComplaintController.class);
	@Resource
	private ComplaintService complaintService;
	
	@Resource
	private InstitutionInfoService institutionInfoService;
	/**
	 *安全员  姓名的模糊搜索
	 */
	@ResponseBody
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	@UserControllerLog(description = "投诉信息的模糊搜索")
	public Result pageQuery(@RequestParam(value = "type", required = false) Integer type,
			@RequestParam(value = "searchText", required = false) String searchText,
			@RequestParam(value = "startTime", defaultValue = "0", required = false) Long startTime,
			@RequestParam(value = "endTime", defaultValue = "0", required = false) Long endTime, Integer pageIndex,
			Integer pageSize) {
		Result result = new Result();
		try {
			if (type == null || type != 2) {
				type = 1;
			}
			Date startTimeDate = null;
			Date endTimeDate = null;
			if (startTime > 0) {
				startTimeDate = new Date(startTime);
			}
			if (endTime > 0) {
				endTimeDate = new Date(endTime);
			}
			if(StringUtils.isBlank(searchText)){
				searchText = null;
			}
			else{
				searchText = searchText.trim();
			}
			Page<Complaint> page = complaintService.pageQuery(type, searchText, null, null, startTimeDate, endTimeDate,
					pageIndex, pageSize);
			result.success(page.getData());
			result.put("rowCount", page.getRowCount());
		} catch (Exception e) {
			logger.error("Complaint field list", e);
			result.error(e);
		}
		return result;
	}
	
	@RequestMapping(value="/{id}",method=RequestMethod.GET)
	@UserControllerLog(description = "获取投诉信息")
	public Result get(@PathVariable Integer id,HttpServletRequest request){
		Assert.notNull(id,"id is null");
		Result result = new Result();
		try {
			Complaint security=complaintService.get(id);
			result.success(security);
		} catch (Exception e) {
			logger.error("Complaint get",e);
		}
		return result;
	}
	@RequestMapping(value="/saveOrUpdate",method=RequestMethod.POST)
	@UserControllerLog(description = "修改或新增投诉信息")
	public Result saveOrUpdate(Complaint complaint,HttpServletRequest request){
		Result result = new Result();
		try {
			if(complaint.getId()!=null){
				complaintService.update(complaint);
			}else {
				if(complaint.getType() == 2){
					UsinInfo usinInfo = (UsinInfo)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
					InstitutionInfo insInfo = institutionInfoService.getIns(complaint.getInstitutionName().trim());
					//complaint.setInsId(usinInfo.getInsId());
					complaint.setInsId(insInfo.getId());
				}
				complaintService.add(complaint);
			}
		} catch (Exception e) {
			logger.error("Complaint saveOrUpdate",e);
			result.error(e);
		}
		return result;
	}
	
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/exportComplaint", method = RequestMethod.GET)
	@UserControllerLog(description = "导出投诉信息excel")
	public Result exportExaminer(Integer type,HttpServletResponse response) throws UnsupportedEncodingException{
		response.setCharacterEncoding("UTF-8");
		String fileName = "投诉信息.xls";
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
			List<Complaint> exportlist = complaintService.exceporComplaint(type);
			sheet = wb.createSheet("投诉信息");
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
			cell.setCellValue("学员编号"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(1);
			// 往单元格里面写入值
			cell.setCellValue("投诉类型"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(2);
			// 往单元格里面写入值
			cell.setCellValue("投诉时间"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(3);
			// 往单元格里面写入值
			cell.setCellValue("投诉内容"); // 头部
			cell.setCellStyle(style);
			

			
			
			for (int i = 0; i < exportlist.size(); i++) { // 循环导出数据
				Complaint complaint = exportlist.get(i);
				// 第四步，创建单元格，并设置值
				// if (string.getId() == stu.getStationId()) {
				row = sheet.createRow((int) exportRow);

				// 学员编号
				if (complaint.getStudentId() != null) {
					row.createCell((short) 0).setCellValue(complaint.getStudentId());
				} else {
					row.createCell((short) 0).setCellValue(" ");
				}
				// 投诉类型
				if (complaint.getType()  != null) {
					if(complaint.getType()==1){
						row.createCell((short) 1).setCellValue(complaint.getCoachName());
					}else if(complaint.getType()==2){
						row.createCell((short) 1).setCellValue(complaint.getInstitutionName());
					}
				} else {
					row.createCell((short) 1).setCellValue(" ");
				}
				
				// 投诉时间
				if (complaint.getCdate() != null) {
					row.createCell((short) 2).setCellValue(complaint.getCdate());
				} else {
					row.createCell((short) 2).setCellValue(" ");
				}
				//投诉内容
				if(complaint.getContent()!=null){
					row.createCell((short)3).setCellValue(complaint.getContent());
				}else{
					row.createCell((short)3).setCellValue("");
				}
				
				exportRow++;
			}
			// 第六步，将文件存到指定位置
		
			OutputStream out = response.getOutputStream();
			wb.write(out);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 上传备案修改状态
	 * @param request
	 * @param id
	 * @param isProvince
	 */
	@RequestMapping(value="/udpatedriving",method=RequestMethod.POST)
	@UserControllerLog(description = "投诉信息上传备案修改状态")
	public Result udpatedriving(HttpServletRequest request,Integer id,Integer isProvince){
		Result result = new Result();
		System.out.println("进入方法"+id+"\t"+isProvince);
		Complaint complaint = new Complaint();
		try {
			complaint.setId(id);
			complaint.setIsProvince(isProvince);
			complaintService.udpatedriving(complaint);				
		} catch (Exception e) {
			logger.error("Complaint saveOrUpdate",e);
			result.error(e);
		}
		return result;
	}
	

}
