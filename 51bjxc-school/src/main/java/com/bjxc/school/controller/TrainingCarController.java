package com.bjxc.school.controller;

import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.ParseException;
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
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.bjxc.Page;
import com.bjxc.Result;
import com.bjxc.school.Examiner;
import com.bjxc.school.TrainingCar;
import com.bjxc.school.service.InstitutionInfoService;
import com.bjxc.school.service.TrainingCarService;
import com.bjxc.school.utils.ReaderExcelUtils;
import com.bjxc.web.utils.WebUtils;

@Controller
@RequestMapping(value="/trainingCar")
public class TrainingCarController {
	private static final Logger logger = LoggerFactory.getLogger(TrainingCarController.class);
	@Resource 
	private TrainingCarService carService;
	
	@ResponseBody
	@RequestMapping(value="/list",method=RequestMethod.GET)
	@UserControllerLog(description = "获取教练车列表")    
	public Result getList(String searchText,Integer insId,Integer pageIndex,Integer pageSize){
		Result result = new Result();
		try {
			Page<TrainingCar> page=null;
			page=carService.getList(searchText,insId,pageIndex,pageSize);
			result.success(page.getData());
			result.put("rowCount", page.getRowCount());
		} catch (Exception e) {
			logger.error("TrainingCar search",e);
			result.error(e);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/{id}",method=RequestMethod.GET)
	@UserControllerLog(description = "获取教练车")    
	public Result findOne(@PathVariable Integer id,HttpServletRequest request){
		Result result = new Result();	
		try {
			TrainingCar car=carService.getOne(id);
			result.success(car);
		} catch (Exception e) {
			logger.error("TrainingCar findOne",e);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/updateorsave",method=RequestMethod.POST)
	@UserControllerLog(description = "保存或更新教练车")    
	public Result saveOrUpdate(HttpServletRequest request,String buydate,String franum,String licnum,Integer id,Integer platecolor,String manufacture,String brand,String model
			,String perdritype,Integer photo,String carnum,String engnum,String remarks,Integer insId) throws ParseException{
		TrainingCar car = new TrainingCar();
		String inscode=WebUtils.getParameterValue(request, "inscode");
		String photourl =WebUtils.getParameterValue(request, "photourl");
		Integer isProvince = WebUtils.getParameterIntegerValue(request, "isProvince");
		Result result = new Result();
		try {
			if(buydate !=null){
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
				Date day=sdf.parse(buydate);
				car.setBuydate(day);
			}
			car.setInscode(inscode);
			car.setFranum(franum);
			car.setLicnum(licnum);
			car.setInsId(insId);
			car.setEngnum(engnum);
			car.setPlatecolor(platecolor);
			car.setManufacture(manufacture);
			car.setRemarks(remarks);
			car.setBrand(brand);
			car.setModel(model);
			car.setPerdritype(perdritype);
			car.setPhotourl(photourl);
			car.setPhoto(photo);
			car.setCarnum(carnum);	
			if(id!=null){
				car.setId(id);
				car.setIsProvince(isProvince);
				carService.update(car);
			}else {
				carService.adds(car);
			}
		} catch (Exception e) {
			logger.error("TrainingCar saveOrUpdate",e);
			result.error(e);
		}
		return result;
	}
	
	private ReaderExcelUtils reu = new ReaderExcelUtils();
	@Resource
	private InstitutionInfoService institutionService;
	/**
	 * 读取教练车Excel文件,将数据存入数据库
	 * 
	 * @param data
	 *            数据
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "static-access" })
	@ResponseBody
	@RequestMapping(value = "/InsertTrainingCarToDB", method = RequestMethod.POST)
	@UserControllerLog(description = "从Excel导入教练车")    
	public Result InsertToDataBase(HttpServletRequest request) throws Exception {
		Result result = new Result();
		Date date = new Date();
		long time = date.getTime();
		List errorList=new ArrayList();
		try {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			MultipartFile file = multipartRequest.getFile("upTrainingCarfile");
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
				 * 教练车
				 */
				it = dataListMap.iterator();
				while (it.hasNext()) {
					Map oneMap = (Map) it.next();
					if (oneMap.get("sheetName" + nameStrs[sheetIndex]) == null) {
						continue;
					} else {
						count[sheetIndex]++; // 字符串中的日期格式
						DateFormat to_type = new SimpleDateFormat("yyyyMMdd");

						TrainingCar trainingCar = new TrainingCar();
						String insIdEx = oneMap.get("培训机构编号").toString() != "" ? oneMap.get("培训机构编号").toString() : null;
						Integer insId = institutionService.getInsId(insIdEx);// 得到对应的培训机构id
						trainingCar.setInscode(insId.toString());
						trainingCar.setFranum(oneMap.get("车架号").toString());
						trainingCar.setEngnum(oneMap.get("发动机号").toString());
						trainingCar.setLicnum(oneMap.get("车辆牌号").toString());
						Integer plateColorEx = oneMap.get("车牌颜色").toString().trim() != ""
								? Integer.parseInt(oneMap.get("车牌颜色").toString().trim()) : null;
						trainingCar.setPlatecolor(plateColorEx);
						Integer photoEx = oneMap.get("照片文件ID").toString().trim() != ""
								? Integer.parseInt(oneMap.get("照片文件ID").toString().trim()) : null;
						trainingCar.setPhoto(photoEx);
						trainingCar.setManufacture(oneMap.get("生产厂家").toString());
						trainingCar.setBrand(oneMap.get("车辆品牌").toString());
						trainingCar.setModel(oneMap.get("车辆型号").toString());
						trainingCar.setPerdritype(oneMap.get("培训车型").toString());
						Date buyDateEx = oneMap.get("购买日期").toString().trim() != ""
								? to_type.parse(oneMap.get("购买日期").toString().trim()) : null;
						trainingCar.setBuydate(buyDateEx);
						trainingCar.setCarnum(oneMap.get("教练车编号").toString());
						
						try {
							carService.addByExcel(trainingCar);
						} catch (Exception e) {
							if(("本驾校已存在车牌号为 " + trainingCar.getLicnum() + " 的教练车").equals(e.getMessage())){
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
				logger.error("TrainingCarController field list", e);
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
			logger.error("TrainingCarController field list", e);
			result.error(e);
		} catch (Exception e) {
			logger.error("TrainingCarController field list", e);
			result.error(e);
		}
		return result;
	}
	@ResponseBody
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	@UserControllerLog(description = "删除教练车")    
	public Result deletes(Integer id){
		Result result = new Result();
		TrainingCar  car= new TrainingCar();
		try {
			if(id!=null){
				car.setId(id);
				carService.deletes(car);
			}
			result.success();
		} catch (Exception e) {
			logger.error("TrainingCar findOne",e);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/exportCar",method=RequestMethod.GET)
	public void exportCar(String insCode,HttpServletResponse response) throws UnsupportedEncodingException{
		response.setCharacterEncoding("UTF-8");
		String fileName = "教练车信息.xls";
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
			sheet = wb.createSheet("教练车列表");
			HSSFRow row = sheet.createRow(0);
			HSSFCell cell = null;
			HSSFCellStyle style = wb.createCellStyle();
			style.setWrapText(true);// 设置自动换行
			f.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);// 粗体显示
			style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
			sheet.autoSizeColumn(1, true);
			style.setFont(f);
			sheet.autoSizeColumn(1);
			int count=0;
			cell = row.createCell(count++);
			cell.setCellValue("培训机构编号"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("教练车编号"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("车架号"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("发动机号"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("车辆牌号"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("车牌颜色"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("生产厂家"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("车辆品牌"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("车辆型号"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("培训车型"); 
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("购买日期"); 
			cell.setCellStyle(style);
			List<TrainingCar> list=carService.getAll(insCode);
			for (int i = 0; i < list.size(); i++) {
				TrainingCar car=list.get(i);
				row = sheet.createRow((int) exportRow);
				count=0;
				row.createCell(count++).setCellValue(car.getInscode()==null?" ":car.getInscode());
				row.createCell(count++).setCellValue(car.getCarnum()==null?" ":car.getCarnum());
				row.createCell(count++).setCellValue(car.getFranum()==null?" ":car.getFranum());
				row.createCell(count++).setCellValue(car.getEngnum()==null?" ":car.getEngnum());
				row.createCell(count++).setCellValue(car.getLicnum()==null?" ":car.getLicnum());
				row.createCell(count++).setCellValue(car.getPlatecolor()==null?" ":car.getPlatecolor()+"");
				row.createCell(count++).setCellValue(car.getManufacture()==null?" ":car.getManufacture());
				row.createCell(count++).setCellValue(car.getBrand()==null?" ":car.getBrand());
				row.createCell(count++).setCellValue(car.getModel()==null?" ":car.getModel());
				row.createCell(count++).setCellValue(car.getPerdritype()==null?" ":car.getPerdritype());
				row.createCell(count++).setCellValue(car.getBuydate()==null?" ":car.getBuydate()+"");
				exportRow++;
			}
			OutputStream out = response.getOutputStream();
			wb.write(out);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
