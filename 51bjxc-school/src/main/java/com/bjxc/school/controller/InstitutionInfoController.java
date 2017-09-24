package com.bjxc.school.controller;

import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.awt.Color;  
import java.awt.Font;
import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.ServletException;
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
import com.bjxc.school.Complaint;
import com.bjxc.school.Examiner;
import com.bjxc.school.InstitutionInfo;
import com.bjxc.school.Security;
import com.bjxc.school.Student;
import com.bjxc.school.TrainingCar;
import com.bjxc.school.service.InstitutionInfoService;
import com.bjxc.school.service.SecurityService;
import com.bjxc.school.utils.ReaderExcelUtils;
import com.bjxc.web.utils.WebUtils;  

/**
 * 培训机构管理新增、修改、删除
 * @author Administrator
 *
 */
@RestController
@RequestMapping(value="/institutionInfo")
public class InstitutionInfoController {
	private static final Logger logger = LoggerFactory.getLogger(InstitutionInfoController.class);
	@Resource
	private InstitutionInfoService institutionInfoService;
	
	@ResponseBody
	@RequestMapping(value="/{insId}",method=RequestMethod.GET)
	@UserControllerLog(description = "培训机构新增")
	public Result get(@PathVariable("insId") Integer insId,HttpServletRequest request){
		Assert.notNull(insId,"id is null");
		Result result = new Result();
		try {
			InstitutionInfo institutionInfo=institutionInfoService.get(insId);
			result.success(institutionInfo);
		} catch (Exception e) {
			logger.error("InstitutionInfo get",e);
		}
		return result;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@ResponseBody
	@RequestMapping(value="/generalSituation",method=RequestMethod.GET)
	@UserControllerLog(description = "培训机构 generalSituation")
	public Result getGeneralSituation(@RequestParam("insId") Integer insId,@RequestParam("staId")Integer staId,HttpServletRequest request,
			HttpServletResponse response){
		Assert.notNull(insId,"id is null");
		Result result = new Result();
		try {
			Map map=new HashMap();
			map.put("insId",insId);
			map.put("staId",staId);
			institutionInfoService.getGeneralSituation(map);
			Integer[] count={Integer.parseInt(map.get("stuCount").toString()),
					Integer.parseInt(map.get("todayStuCount").toString()),
					Integer.parseInt(map.get("yesterdayStuCount").toString()),
					Integer.parseInt(map.get("monthStuCount").toString()),
					Integer.parseInt(map.get("notAcceptedOneStuCount").toString()),
					Integer.parseInt(map.get("notSubjectOneStuCount").toString()),
					Integer.parseInt(map.get("subjectOneStuCount").toString()),
					Integer.parseInt(map.get("subjectTwoStuCount").toString()),
					Integer.parseInt(map.get("subjectThreeStuCount").toString()),
					Integer.parseInt(map.get("subjectFourStuCount").toString()),
					Integer.parseInt(map.get("allStuCount").toString())
			};
			
			String[] title={"当前在学学员数","今天新增学员数","昨天新增学员数","本月新增学员数","报名未受理",
					"已受理未上课","科目一学习中","科目二学习中","科目三学习中","科目四学习中"};
	        result.put("title",title);
			result.success(count);
		} catch (Exception e) {
			logger.error("InstitutionInfo getGeneralSituation",e);
		}
		return result;
	}
	
	/**
	 * 机构新增、修改
	 * @param institutionInfo
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/saveOrUpdate",method=RequestMethod.POST)
	@UserControllerLog(description = "培训机构新增、修改")
	public Result saveOrUpdate(InstitutionInfo institutionInfo,HttpServletRequest request){
		Result result = new Result();
		try {
			if(institutionInfo.getId()!=null){
				institutionInfoService.update(institutionInfo);
			}else {
				institutionInfoService.add(institutionInfo);
			}
		} catch (Exception e) {
			logger.error("InstitutionInfo saveOrUpdate",e);
			result.error(e);
		}
		return result;
	}
	/**
	 * 导出机构信息
	 * @param id
	 * @param response
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/exportInsInfo", method = RequestMethod.GET)
	@UserControllerLog(description = "培训机构导出机构信息")
	public Result exportIns(HttpServletResponse response) throws UnsupportedEncodingException{
		response.setCharacterEncoding("UTF-8");
		String fileName = "培训机构信息.xls";
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
			List<InstitutionInfo> list=institutionInfoService.getAll();
			sheet = wb.createSheet("培训机构信息");
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
			int count=0;
			// 获取第一行的每一个单元格
			
			cell = row.createCell(count++);
			cell.setCellValue("培训机构编号"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("区县行政区划代码"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("培训机构名称"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("培训机构简称"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("经营许可证编号"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("经营许可日期"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("营业执照注册号"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("统一社会信用代码"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("地址"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("邮政编码"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("法人代表"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("联系人"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("联系电话"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("经营范围"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("经营状态"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("分类等级"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("教练员总数"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("考核员总数"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("安全员总数"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("教练车总数"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("教室总面积"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("理论教室面积"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("教练场总面积"); 
			cell.setCellStyle(style);
			
			for (int i = 0; i < list.size(); i++) {
				InstitutionInfo ins=list.get(i);
				row = sheet.createRow((int) exportRow);
				count=0;
				row.createCell(count++).setCellValue(ins.getInscode()==null?" ":ins.getInscode());
				row.createCell(count++).setCellValue(ins.getDistrict()==null?" ":ins.getDistrict());
				row.createCell(count++).setCellValue(ins.getName()==null?" ":ins.getName());
				row.createCell(count++).setCellValue(ins.getShortName()==null?" ":ins.getShortName());
				row.createCell(count++).setCellValue(ins.getLicnum()==null?" ":ins.getLicnum());
				row.createCell(count++).setCellValue(ins.getLicetime()==null?" ":ins.getLicetime());
				row.createCell(count++).setCellValue(ins.getBusiness()==null?" ":ins.getBusiness());
				row.createCell(count++).setCellValue(ins.getCreditcode()==null?" ":ins.getCreditcode());
				row.createCell(count++).setCellValue(ins.getAddress()==null?" ":ins.getAddress());
				row.createCell(count++).setCellValue(ins.getPostcode()==null?" ":ins.getPostcode());
				row.createCell(count++).setCellValue(ins.getLegal()==null?" ":ins.getLegal());
				row.createCell(count++).setCellValue(ins.getContact()==null?" ":ins.getContact());
				row.createCell(count++).setCellValue(ins.getPhone()==null?" ":ins.getPhone());
				row.createCell(count++).setCellValue(ins.getBusiscope()==null?" ":ins.getBusiscope());
				row.createCell(count++).setCellValue(ins.getBusistatus()==null?" ":ins.getBusistatus());
				row.createCell(count++).setCellValue(ins.getLevel()==null?" ":ins.getLevel()+"");
				row.createCell(count++).setCellValue(ins.getCoachnumber()==null?" ":ins.getCoachnumber()+"");
				row.createCell(count++).setCellValue(ins.getGrasupvnum()==null?" ":ins.getGrasupvnum()+"");
				row.createCell(count++).setCellValue(ins.getSafmngnum()==null?" ":ins.getSafmngnum()+"");
				row.createCell(count++).setCellValue(ins.getTracarnum()==null?" ":ins.getTracarnum()+"");
				row.createCell(count++).setCellValue(ins.getClassroom()==null?" ":ins.getClassroom()+"");
				row.createCell(count++).setCellValue(ins.getThclassroom()==null?" ":ins.getThclassroom()+"");
				row.createCell(count++).setCellValue(ins.getPraticefield()==null?" ":ins.getPraticefield()+"");
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
	@RequestMapping(value = "/InsertInstitutionInfoToDB", method = RequestMethod.POST)
	@UserControllerLog(description = "培训机构 读取Excel文件,将数据存入数据库")
	public Result InsertToDataBase(HttpServletRequest request) throws Exception {
		Result result = new Result();
		Date date = new Date();
		long time = date.getTime();
		List errorList=new ArrayList();
		try {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			MultipartFile file = multipartRequest.getFile("upInstitutionInfofile");
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
				 * 培训机构
				 */
				it = dataListMap.iterator();
				while (it.hasNext()) {
					Map oneMap = (Map) it.next();
					if (oneMap.get("sheetName" + nameStrs[sheetIndex]) == null) {
						continue;
					} else {
						count[sheetIndex]++;

						InstitutionInfo institution = new InstitutionInfo();
						institution.setName(oneMap.get("培训机构名称").toString());// 培训机构名称
						institution.setShortName(oneMap.get("培训机构简称").toString());// 培训机构简称
						institution.setLicnum(oneMap.get("经营许可证编号").toString());// 经营许可证编号
						institution.setLicetime(oneMap.get("经营许可日期").toString());// 经营许可日期
						institution.setBusiness(oneMap.get("营业执照注册号").toString());// 营业执照注册号
						institution.setCreditcode(oneMap.get("统一社会信用代码").toString());// 统一社会信用代码
						institution.setAddress(oneMap.get("培训机构地址").toString());// 培训机构地址
						institution.setLegal(oneMap.get("法人代表").toString());// 法人代表
						Integer busiStatusEx = oneMap.get("经营状态").toString().trim() != ""
								? Integer.valueOf(oneMap.get("经营状态").toString().trim()) : null;
						institution.setBusistatus(busiStatusEx.toString());// 经营状态
						institution.setContact(oneMap.get("联系人").toString());// 联系人
						institution.setPhone(oneMap.get("联系电话").toString());// 联系电话
						institution.setInscode(oneMap.get("培训机构编号").toString());// 培训机构编号
						
						/*
						 * CreateTime Province City Area introduction
						 */
						institution.setDistrict(oneMap.get("区县行政区划代码").toString());// 区县行政区划代码
						// 邮政编码

						institution.setBusiscope(oneMap.get("经营范围").toString());// 经营范围
						Integer levelEx = oneMap.get("分类等级").toString().trim() != ""
								? Integer.valueOf(oneMap.get("分类等级").toString().trim()) : null;
						institution.setLevel(levelEx);// 分类等级
						Integer coachNumberEx = oneMap.get("教练员总数").toString().trim() != ""
								? Integer.valueOf(oneMap.get("教练员总数").toString().trim()) : null;
						institution.setCoachnumber(coachNumberEx);//教练总人数
						//考核员总人数
						Integer grasupvNumEx = oneMap.get("考核员总数").toString().trim() != ""
								? Integer.valueOf(oneMap.get("考核员总数").toString().trim()) : null;
						institution.setGrasupvnum(grasupvNumEx);
						//安全员总人数
						Integer safmngNumEx = oneMap.get("安全员总数").toString().trim() != ""
								? Integer.valueOf(oneMap.get("安全员总数").toString().trim()) : null;
						institution.setSafmngnum(safmngNumEx);
						//教练车总数
						Integer tracarNumEx = oneMap.get("教练车总数").toString().trim() != ""
								? Integer.valueOf(oneMap.get("教练车总数").toString().trim()) : null;
						institution.setTracarnum(tracarNumEx);
						Integer classRoomEx = oneMap.get("教室总面积").toString().trim() != ""
								? Integer.valueOf(oneMap.get("教室总面积").toString().trim()) : null;
						institution.setClassroom(classRoomEx);// 教室总面积
						Integer thClassRoomEx = oneMap.get("理论教室面积").toString().trim() != ""
								? Integer.valueOf(oneMap.get("理论教室面积").toString().trim()) : null;
						institution.setThclassroom(thClassRoomEx);// 理论教室面积
						Integer praticeFieldEx = oneMap.get("教练场总面积").toString().trim() != ""
								? Integer.valueOf(oneMap.get("教练场总面积").toString().trim()) : null;
						institution.setPraticefield(praticeFieldEx);// 教练场总面积
						
						try {
							institutionInfoService.addByExcel(institution);
						} catch (Exception e) {
							if(("已存在统一编号为 " + institution.getInscode() + " 的培训机构").equals(e.getMessage())){
								logger.error(e.getMessage());
								if(errorList.size()<5){
									errorList.add(e.getMessage());
								}
							}else{
								logger.error(e.getMessage());
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
				logger.error("InstitutionInfoController field list", e);
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
			logger.error("InstitutionInfoController field list", e);
			result.error(e);
		} catch (Exception e) {
			logger.error("InstitutionInfoController field list", e);
			result.error(e);
		}
		return result;
	}
	/**
	 *机构 姓名的模糊搜索
	 */
	@RequestMapping(value="/list",method=RequestMethod.GET)
	@UserControllerLog(description = "培训机构 姓名的模糊搜索")
	public Result pageQuery(@RequestParam(value="searchText", required=false)String searchText,Integer pageIndex,Integer pageSize){
		Result result = new Result();
		try {
		
			Page<InstitutionInfo> page = institutionInfoService.pageQuery(searchText,pageIndex,pageSize);
			result.success(page.getData());
			result.put("rowCount", page.getRowCount());
		} catch (Exception e) {
			logger.error("InstitutionInfo field list",e);
			result.error(e);
		}
		return result;
	}
	
	//省备案信息更新
	@ResponseBody
	@RequestMapping(value="/updateStatus",method=RequestMethod.POST)
	@UserControllerLog(description = "培训机构 省备案信息更新")
	public Result updatestatus(Integer id){
		Result result = new Result();
		Assert.notNull(id,"id is null");
		try {
			institutionInfoService.updateProvinceStatus(id);
			result.success();
		} catch (Exception e) {
			logger.error(e.getMessage());
			result.error(e);
		}
		return result;
	}
	
}
