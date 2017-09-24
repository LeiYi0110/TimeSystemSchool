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
import com.bjxc.school.Coach;
import com.bjxc.school.Security;
import com.bjxc.school.Student;
import com.bjxc.school.TrainingCar;
import com.bjxc.school.service.InstitutionInfoService;
import com.bjxc.school.service.SecurityService;
import com.bjxc.school.utils.ReaderExcelUtils;
import com.bjxc.web.utils.WebUtils;

/**
 * 安全员管理新增、修改、删除
 * @author Administrator
 *
 */
@RestController
@RequestMapping(value="/security")
public class SecurityController {
	private static final Logger logger = LoggerFactory.getLogger(SecurityController.class);
	@Resource
	private SecurityService securityService;
	
	/**
	 *安全员  姓名的模糊搜索
	 */
	@RequestMapping(value="/list",method=RequestMethod.GET)
	@UserControllerLog(description = "Security列表")
	public Result pageQuery(@RequestParam("insId")Integer insId,@RequestParam(value="searchText", required=false)String searchText,Integer pageIndex,Integer pageSize){
		Result result = new Result();
		try {
			Page<Security> page = securityService.pageQuery(insId,searchText,pageIndex,pageSize);
			result.success(page.getData());
			result.put("rowCount", page.getRowCount());
		} catch (Exception e) {
			logger.error("Security field list",e);
			result.error(e);
		}
		return result;
	}
	@RequestMapping(value="/{id}",method=RequestMethod.GET)
	@UserControllerLog(description = "Security信息")
	public Result get(@PathVariable Integer id,HttpServletRequest request){
		Assert.notNull(id,"id is null");
		Result result = new Result();
		try {
			Security security=securityService.get(id);
			result.success(security);
		} catch (Exception e) {
			logger.error("Security get",e);
		}
		return result;
	}
	
	@RequestMapping(value="/saveOrUpdate",method=RequestMethod.POST)
	@UserControllerLog(description = "Security新增或修改")
	public Result saveOrUpdate(Security security,HttpServletRequest request){
		Result result = new Result();
		try {
			if(security.getId()!=null){
				securityService.update(security);
			}else {
				securityService.add(security);
			}
		} catch (Exception e) {
			logger.error("Security saveOrUpdate",e);
			result.error(e);
		}
		return result;
	}
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/exportSecurity", method = RequestMethod.GET)
	@UserControllerLog(description = "Security导出excel")
	public Result exportSecurity(Integer insId,HttpServletResponse response) throws UnsupportedEncodingException{
		response.setCharacterEncoding("UTF-8");
		String fileName = "安全员基本信息.xls";
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
			List<Security> exportlist = securityService.exceporSecurity(insId);
			sheet = wb.createSheet("安全员信息");
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
			sheet.setColumnWidth(9, 4500);
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
				Security security = exportlist.get(i);
				// 第四步，创建单元格，并设置值
				// if (string.getId() == stu.getStationId()) {
				row = sheet.createRow((int) exportRow);

				// 培训机构Id
				if (security.getInsId() != null) {
					row.createCell((short) 0).setCellValue(security.getInsId());
				} else {
					row.createCell((short) 0).setCellValue(" ");
				}
				//安全员姓名
				if(security.getName()!=null){
					row.createCell((short)1).setCellValue(security.getName());
				}else{
					row.createCell((short)1).setCellValue("");
				}
				// 性别
				if (security.getSex() != null) {
					if (security.getSex() == 1) {
						row.createCell((short) 2).setCellValue("男");
					} else if (security.getSex() == 2) {
						row.createCell((short) 2).setCellValue("女");
					}
				} else {
					row.createCell((short) 2).setCellValue(" ");
				}
				// 电话
				if (security.getMobile() != null) {
					row.createCell((short) 3).setCellValue(security.getMobile());
				} else {
					row.createCell((short) 3).setCellValue(" ");
				}
				//身份证号码
				if(security.getIdcard()!=null){
					row.createCell((short)4).setCellValue(security.getIdcard());
				}else{
					row.createCell((short)4).setCellValue("");
				}
				//供职状态
				if(security.getEmploystatus()!=null){
					if (security.getEmploystatus() == 0) {
						row.createCell((short) 5).setCellValue("在职");
					} else if (security.getEmploystatus() == 1) {
						row.createCell((short) 5).setCellValue("离职");
					}
				}else{
					row.createCell((short) 5).setCellValue(" ");
				}

				//入职日期
				if(security.getHiredate()!=null){
					row.createCell((short) 6).setCellValue(new SimpleDateFormat("yyyy-MM-dd").format(security.getHiredate()));
				}else{
					row.createCell((short) 6).setCellValue(" ");
				}
				//离职日期
				if(security.getLeavedate()!=null){
					row.createCell((short) 7).setCellValue(new SimpleDateFormat("yyyy-MM-dd").format(security.getLeavedate()));
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
	 * 读取Excel文件,将数据存入数据库
	 * 
	 * @param data
	 *            数据
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "static-access" })
	@ResponseBody
	@RequestMapping(value = "/InsertSecurityToDB", method = RequestMethod.POST)
	@UserControllerLog(description = "Security读取excel")
	public Result InsertToDataBase(HttpServletRequest request) throws Exception {
		Result result = new Result();
		Date date = new Date();
		long time = date.getTime();
		List errorList=new ArrayList();
		try {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			MultipartFile file = multipartRequest.getFile("upSecurityfile");
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
				 * 安全员
				 */
				it = dataListMap.iterator();
				while (it.hasNext()) {
					Map oneMap = (Map) it.next();
					if (oneMap.get("sheetName" + nameStrs[sheetIndex]) == null) {
						continue;
					} else {
						count[sheetIndex]++; // 字符串中的日期格式
						DateFormat to_type = new SimpleDateFormat("yyyyMMdd");

						Security security = new Security();
						String insIdEx = oneMap.get("培训机构编号").toString() != "" ? oneMap.get("培训机构编号").toString() : null;
						Integer insId = institutionService.getInsId(insIdEx);// 得到对应的培训机构id
						security.setInsId(insId);
						security.setName(oneMap.get("姓名").toString().trim());
						// 性别(空值就设置为 男 )
						Integer sexEx = oneMap.get("性别").toString().trim() != ""
								? Integer.parseInt(oneMap.get("性别").toString().trim()) : 1;
						security.setSex(sexEx);
						security.setIdcard(oneMap.get("身份证号").toString());
						security.setMobile(oneMap.get("手机号码").toString());
						Integer photoEx = oneMap.get("照片文件ID").toString().trim() != ""
								? Integer.parseInt(oneMap.get("照片文件ID").toString().trim()) : null;
						security.setPhoto(photoEx);
						Integer fingerprintEx = oneMap.get("指纹图片ID").toString().trim() != ""
								? Integer.parseInt(oneMap.get("指纹图片ID").toString().trim()) : null;
						security.setFingerprint(fingerprintEx);
						security.setAddress(oneMap.get("联系地址").toString());
						security.setDrilicence(oneMap.get("驾驶证号").toString());
						security.setFstdrilicdate(oneMap.get("驾驶证初领日期").toString());
						security.setDripermitted(oneMap.get("准驾车型").toString());
						security.setTeachpermitted(oneMap.get("准教车型").toString());
						Integer employStatusEx = oneMap.get("供职状态").toString().trim() != ""
								? Integer.parseInt(oneMap.get("供职状态").toString().trim()) : null;
						security.setEmploystatus(employStatusEx);
						Date hireDateEx = oneMap.get("入职时间").toString().trim() != ""
								? to_type.parse(oneMap.get("入职时间").toString().trim()) : null;
						security.setHiredate(hireDateEx);
						Date leaveDateEx = oneMap.get("离职时间").toString().trim() != ""
								? to_type.parse(oneMap.get("离职时间").toString().trim()) : null;
						security.setLeavedate(leaveDateEx);
						security.setSecunum(oneMap.get("安全员编号").toString());

						try {
							securityService.addByExcel(security);
						} catch (Exception e) {
							if(("本驾校已存在身份证号为 " + security.getIdcard() + " 的安全员").equals(e.getMessage())){
								logger.error(e.getMessage());
								if(errorList.size()<5){
									errorList.add(e.getMessage());
								}
							}else{
								logger.error(e.getMessage());
								if(errorList.size()<5){
									errorList.add("本驾校已存在电话号为 " + security.getMobile() + " 的安全员");
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
				logger.error("SecurityController field list", e);
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
			logger.error("SecurityController field list", e);
			result.error(e);
		} catch (Exception e) {
			logger.error("SecurityController field list", e);
			result.error(e);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/updatestatus", method = RequestMethod.POST)
	@UserControllerLog(description = "Security更新状态")
	public Result updatestatus(Integer id){
		Result result = new Result();
		Security security = new Security();
		try {
			if(id!=null){
				security.setId(id);
			  	securityService.updatestatus(security);	
			}
			result.success();
		} catch (Exception e) {
			logger.error("Security get",e);
		}
		return result;
	}
	
}
