package com.bjxc.school.controller;

import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileUploadBase;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.bjxc.Page;
import com.bjxc.Result;
import com.bjxc.school.Examiner;
import com.bjxc.school.Security;
import com.bjxc.school.TrainingCar;
import com.bjxc.school.service.ExaminerService;
import com.bjxc.school.service.InstitutionInfoService;
import com.bjxc.school.utils.ReaderExcelUtils;
import com.bjxc.web.utils.WebUtils;

/**
 * 考核员管理新增、修改、删除
 * @author Administrator
 *
 */
@RestController
@RequestMapping(value="/examiner")
public class ExaminerController {
	private static final Logger logger = LoggerFactory.getLogger(ExaminerController.class);
	@Resource
	private ExaminerService examinerService;
	
	/**
	 *安全员  姓名的模糊搜索
	 */
	@RequestMapping(value="/list",method=RequestMethod.GET)
	@UserControllerLog(description = "考核员  保存或修改")
	public Result pageQuery(Integer insId,String searchText,Integer pageIndex,Integer pageSize){
		Result result = new Result();
		try {
			Page<Examiner> page = examinerService.pageQuery(insId,searchText,pageIndex,pageSize);
			
			result.success(page.getData());
			result.put("rowCount", page.getRowCount());
		} catch (Exception e) {
			logger.error("Examiner field list",e);
			result.error(e);
		}
		return result;
	}
	@RequestMapping(value="/{id}",method=RequestMethod.GET)
	@UserControllerLog(description = "获取考核员信息")
	public Result get(@PathVariable Integer id,HttpServletRequest request){
		Assert.notNull(id,"id is null");
		Result result = new Result();
		try {
			Examiner security=examinerService.get(id);
			result.success(security);
		} catch (Exception e) {
			logger.error("Examiner get",e);
		}
		return result;
	}
	
	@RequestMapping(value="/saveOrUpdate",method=RequestMethod.POST)
	@UserControllerLog(description = "新增或修改考核员信息")
	public Result saveOrUpdate(Examiner examiner,HttpServletRequest request){
		Result result = new Result();
		try {
			if(examiner.getId()!=null){
				examinerService.update(examiner);
			}else {
				examinerService.add(examiner);
			}
		} catch (Exception e) {
			logger.error("Examiner saveOrUpdate",e);
			result.error(e);
		}
		return result;
	}
	
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/exportExaminer", method = RequestMethod.GET)
	@UserControllerLog(description = "导出考核员excel信息")
	public Result exportExaminer(Integer insId,HttpServletResponse response) throws UnsupportedEncodingException{
		response.setCharacterEncoding("UTF-8");
		String fileName = "考核员信息.xls";
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
			List<Examiner> exportlist = examinerService.exceporExaminer(insId);
			sheet = wb.createSheet("考核员信息");
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
			cell.setCellValue("培训机构Id"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(1);
			// 往单元格里面写入值
			cell.setCellValue("姓名"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(2);
			// 往单元格里面写入值
			cell.setCellValue("性别"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(3);
			// 往单元格里面写入值
			cell.setCellValue("电话号码"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(4);
			// 往单元格里面写入值
			cell.setCellValue("身份证号"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(5);
			// 往单元格里面写入值
			cell.setCellValue("供职状态"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(6);
			// 往单元格里面写入值
			cell.setCellValue("入职时间"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(7);
			// 往单元格里面写入值
			cell.setCellValue("离职时间"); // 头部
			cell.setCellStyle(style);
			
			
			for (int i = 0; i < exportlist.size(); i++) { // 循环导出数据
				Examiner examiner = exportlist.get(i);
				// 第四步，创建单元格，并设置值
				// if (string.getId() == stu.getStationId()) {
				row = sheet.createRow((int) exportRow);

				// 培训机构Id
				if (examiner.getInsId() != null) {
					row.createCell((short) 0).setCellValue(examiner.getInsId());
				} else {
					row.createCell((short) 0).setCellValue(" ");
				}
				// 姓名
				if (examiner.getInsId() != null) {
					row.createCell((short) 1).setCellValue(examiner.getName());
				} else {
					row.createCell((short) 1).setCellValue(" ");
				}
				// 性别
				if (examiner.getSex() != null) {
					if (examiner.getSex() == 1) {
						row.createCell((short) 2).setCellValue("男");
					} else if (examiner.getSex() == 2) {
						row.createCell((short) 2).setCellValue("女");
					}
				} else {
					row.createCell((short) 2).setCellValue(" ");
				}
				// 电话
				if (examiner.getMobile() != null) {
					row.createCell((short) 3).setCellValue(examiner.getMobile());
				} else {
					row.createCell((short) 3).setCellValue(" ");
				}
				//身份证号码
				if(examiner.getIdcard()!=null){
					row.createCell((short)4).setCellValue(examiner.getIdcard());
				}else{
					row.createCell((short)4).setCellValue("");
				}
				//供职状态
				if(examiner.getEmploystatus()!=null){
					if (examiner.getEmploystatus() == 0) {
						row.createCell((short) 5).setCellValue("在职");
					} else if (examiner.getEmploystatus() == 1) {
						row.createCell((short) 5).setCellValue("离职");
					}
				}else{
					row.createCell((short) 5).setCellValue(" ");
				}
				//入职日期
				if(examiner.getHiredate()!=null){
					row.createCell((short) 6).setCellValue(new SimpleDateFormat("yyyy-MM-dd").format(examiner.getHiredate()));
				}else{
					row.createCell((short) 6).setCellValue(" ");
				}

				//离职日期
				if(examiner.getLeavedate()!=null){
					row.createCell((short) 7).setCellValue(new SimpleDateFormat("yyyy-MM-dd").format(examiner.getLeavedate()));
				}else{
					row.createCell((short) 7).setCellValue(" ");
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
	
	private ReaderExcelUtils reu = new ReaderExcelUtils();
	@Resource
	private InstitutionInfoService institutionService;
	/**
	 * 读取考核员Excel文件,将数据存入数据库
	 * 
	 * @param data
	 *            数据
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "static-access" })
	@ResponseBody
	@RequestMapping(value = "/InsertExaminerToDB", method = RequestMethod.POST)
	@UserControllerLog(description = "读取考核员Excel文件,将数据存入数据库")
	public Result InsertToDataBase(HttpServletRequest request) throws Exception {
		Result result = new Result();
		Date date = new Date();
		long time = date.getTime();
		List errorList=new ArrayList();
		try {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			MultipartFile file = multipartRequest.getFile("upExaminerfile");
			if(file.isEmpty()){  
	            throw new Exception("文件为空！");  
	        }
			//文件名字
			String fileName=file.getOriginalFilename();
			//输入流
			InputStream in=file.getInputStream();
			List<Map> dataListMap = reu.ReaderExcel(in, fileName);
			Iterator it = null;
			// sheet名字数组
			String[] nameStrs = new String[0];
			if (dataListMap != null) {
				int index = dataListMap.size() - 1;
				Map namesMap = dataListMap.get(index);
				String names = namesMap.get("nameStrs").toString();
				nameStrs = names.split(",");
			}
			try {
				int number = 0;
				// sheet名数组下标
				int sheetIndex = 0;
				int[] count = new int[nameStrs.length];
				/**
				 * 考核员
				 */
				it = dataListMap.iterator();
				while (it.hasNext()) {
					Map oneMap = (Map) it.next();
					if (oneMap.get("sheetName" + nameStrs[sheetIndex]) == null) {
						continue;
					} else {
						count[sheetIndex]++;
						// 字符串中的日期格式
						DateFormat to_type = new SimpleDateFormat("yyyyMMdd");

						Examiner examiner = new Examiner();
						String insIdEx = oneMap.get("培训机构编号").toString() != "" ? oneMap.get("培训机构编号").toString() : null;
						Integer insId = institutionService.getInsId(insIdEx);
						examiner.setInsId(insId);
						examiner.setName(oneMap.get("姓名").toString());
						Integer sexEx = oneMap.get("性别").toString().trim() != ""
								? Integer.parseInt(oneMap.get("性别").toString().trim()) : 1;
						examiner.setSex(sexEx);
						examiner.setIdcard(oneMap.get("身份证号").toString());
						examiner.setMobile(oneMap.get("手机号码").toString());
						examiner.setAddress(oneMap.get("联系地址").toString());
						examiner.setDrilicence(oneMap.get("驾驶证号").toString());
						examiner.setFstdrilicdate(oneMap.get("驾驶证初领日期").toString());
						examiner.setDripermitted(oneMap.get("准驾车型").toString());
						examiner.setTeachpermitted(oneMap.get("准教车型").toString());
						Integer employStatusEx = oneMap.get("供职状态").toString().trim() != ""
								? Integer.parseInt(oneMap.get("供职状态").toString().trim()) : null;
						examiner.setEmploystatus(employStatusEx);
						Date hireDateEx = oneMap.get("入职时间").toString().trim() != ""
								? to_type.parse(oneMap.get("入职时间").toString().trim()) : null;
						examiner.setHiredate(hireDateEx);
						Date leaveDateEx = oneMap.get("离职时间").toString().trim() != ""
								? to_type.parse(oneMap.get("离职时间").toString().trim()) : null;
						examiner.setLeavedate(leaveDateEx);
						examiner.setOccupationno(oneMap.get("职业资格证号").toString());
						examiner.setOccupationlevel(oneMap.get("职业资格等级").toString());
						examiner.setExamnum(oneMap.get("考核员编号").toString().trim());
						Integer photoEx = oneMap.get("照片文件ID").toString().trim() != ""
								? Integer.parseInt(oneMap.get("照片文件ID").toString().trim()) : null;
						examiner.setPhoto(photoEx);
						Integer fingerPrintEx = oneMap.get("指纹图片ID").toString().trim() != ""
								? Integer.parseInt(oneMap.get("指纹图片ID").toString().trim()) : null;
						examiner.setFingerprint(fingerPrintEx);

						try {
							examinerService.addByExcel(examiner);
						} catch (Exception e) {
							if(("本驾校已存在身份证号为 " + examiner.getIdcard() + " 的考核员").equals(e.getMessage())){
								logger.error(e.getMessage());
								if(errorList.size()<5){
									errorList.add(e.getMessage());
								}
							}else{
								logger.error(e.getMessage());
								if(errorList.size()<5){
									errorList.add("本驾校已存在电话号为 " + examiner.getMobile() + " 的考核员");
								}
							}
						}
						number = 1;
						it.remove();
						if (count[sheetIndex] == Integer
								.parseInt(oneMap.get(nameStrs[sheetIndex] + "SheetNumber").toString())) {
							sheetIndex++;
							break;
						}
					}
				}
			} catch (Exception e) {
				logger.error("ExaminerController field list", e);
				result.error(e);
			}
			if(errorList.size()>0){
				if(errorList.size()==5){
					errorList.add("...");
				}
				result.error("");
				result.put("errorList", errorList);
			}
			Date date2 = new Date();
			long time2 = date2.getTime();
			long longs = time2 - time;
			System.out.println(longs);
		} catch (FileUploadBase.FileSizeLimitExceededException e) {
			logger.error("ExaminerController field list", e);
			result.error(e);
		} catch (Exception e) {
			logger.error("ExaminerController field list", e);
			result.error(e);
		}
		return result;
	}
	
	//删除
	@RequestMapping(value="/updatestatus",method=RequestMethod.POST)
	@UserControllerLog(description = "删除考核员数据")
	public Result updatestatus(Integer id){
		Result result = new Result();
		Examiner examiner= new Examiner();
		try {
			if(id!=null){
				examiner.setId(id);
				examinerService.updatestutas(examiner);
			}
			result.success(examiner);
		} catch (Exception e) {
			result.error(e);
		}
		return result;
	}
	
}
