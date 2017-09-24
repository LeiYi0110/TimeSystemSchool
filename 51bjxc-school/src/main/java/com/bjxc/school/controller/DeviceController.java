package com.bjxc.school.controller;

import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.bjxc.Page;
import com.bjxc.Result;
import com.bjxc.school.Device;
import com.bjxc.school.service.DeviceService;
import com.bjxc.school.service.InstitutionInfoService;
import com.bjxc.school.utils.ReaderExcelUtils;
import com.bjxc.tcp.netty.HexUtils;
import com.bjxc.web.utils.WebUtils;

@RestController
@RequestMapping(value = "/device")
public class DeviceController {
	private static final Logger logger = LoggerFactory.getLogger(DeviceController.class);
	@Resource
	private DeviceService deviceService;
	private ReaderExcelUtils reu = new ReaderExcelUtils();
	@Resource
	private InstitutionInfoService institutionService;

	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	@UserControllerLog(description = "获取终端列表")
	public Result getList(String searchText, Integer pageIndex, Integer pageSize, Integer insId,
			HttpServletResponse response) {
		response.setCharacterEncoding("UTF-8");
		Result result = new Result();
		try {
			int rowCount = deviceService.totaldevice(searchText, insId);
			Page<Device> page = deviceService.getList(searchText, pageIndex, pageSize, insId);
			page.setRowCount(rowCount);
			result.put("rowCount", rowCount);
			result.success(page.getData());
		} catch (Exception e) {
			logger.error("device search", e);
			result.error(e);
		}
		return result;
	}
	
	@RequestMapping(value="/findLocal/{id}",method=RequestMethod.GET)
	@UserControllerLog(description="查找终端位置")
	public Result findLocal(@PathVariable Integer id){
		Result result = new Result();
		try {
			result.success(deviceService.findLocal(id));
		} catch (Exception e) {
			logger.error("device findLocal", e);
			result.error(e);
		}
		return result;
	}

	
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	@UserControllerLog(description = "获取终端信息")
	public Result getOne(@PathVariable Integer id) {
		Result result = new Result();
		try {
			Device one = deviceService.getOne(id);

			result.success(one);
		} catch (Exception e) {
			logger.error("device one search", e);
			result.error(e);
		}
		return result;
	}

	
	@RequestMapping(value = "/getCar", method = RequestMethod.POST)
	@UserControllerLog(description = "获取车辆信息")
	public Result getCar(Integer insId, HttpServletRequest request) {
		Result result = new Result();
		try {
			String name = request.getParameter("keyword");
			List<Map> list = deviceService.getCar(name, insId);
			result.success(list);
		} catch (Exception e) {
			logger.error("car search", e);
			result.error(e);
		}
		return result;
	}

	
	@RequestMapping(value = "/addDevassign", method = RequestMethod.GET)
	@UserControllerLog(description = "获取绑定信息")
	public Result addDevassign(String devnum, String sim, String carnum) {
		Result result = new Result();
		try {
			deviceService.addDevassign(devnum, sim, carnum);
		} catch (Exception e) {
			logger.error("Devassign api", e);
			result.error(e);
		}
		return result;
	}

	
	@RequestMapping(value = "/deleteDevassign", method = RequestMethod.GET)
	@UserControllerLog(description = "删除绑定信息")
	public Result deleteDevassign(Integer id) {
		Result result = new Result();
		try {
			deviceService.deleteDevassign(id);
		} catch (Exception e) {
			logger.error("Devassign api", e);
			result.error(e);
		}
		return result;
	}

	
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@UserControllerLog(description = "保存或更新设备信息")
	public Result saveOrUpdate(HttpServletRequest request) {
		Result result = new Result();
		Integer id = WebUtils.getParameterIntegerValue(request, "id");
		Integer insId = WebUtils.getParameterIntegerValue(request, "insId");
		Integer termtype = WebUtils.getParameterIntegerValue(request, "termtype");
		String vender = WebUtils.getParameterValue(request, "vender");
		String model = WebUtils.getParameterValue(request, "model");
		String imei = WebUtils.getParameterValue(request, "imei");
		String sn = WebUtils.getParameterValue(request, "sn");
		String devnum = WebUtils.getParameterValue(request, "devnum");
		String passwd = WebUtils.getParameterValue(request, "passwd");
		String key = WebUtils.getParameterValue(request, "key");
		Integer isProvince = WebUtils.getParameterIntegerValue(request, "isProvince");
		String installDateStr = WebUtils.getParameterValue(request, "installDate");

		Device one = new Device();
		one.setInsId(insId);
		one.setTermtype(termtype);
		one.setVender(vender);
		one.setModel(model);
		one.setImei(imei);
		one.setSn(sn);
		one.setDevnum(devnum);
		one.setPasswd(passwd);
		one.setKey(key);
		one.setIsProvince(isProvince);

		if (installDateStr != null && !"".equals(installDateStr)) {
			try {
				one.setInstallDate(new SimpleDateFormat("yyyy-MM-dd").parse(installDateStr));
			} catch (ParseException e) {
				// e.printStackTrace();
			}
		}

		if (id != null) {
			one.setId(id);
			deviceService.update(one);
		} else {
			deviceService.add(one);
		}

		return result;
	}

	

	/**
	 * 读取Excel文件,将数据存入数据库
	 * 
	 * @param data
	 *            数据
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "static-access" })
	
	@RequestMapping(value = "/InsertDeviceToDB", method = RequestMethod.POST)
	@UserControllerLog(description = "读取Excel文件,将数据存入数据库")
	public Result InsertToDataBase(HttpServletRequest request) throws Exception {
		Result result = new Result();
		Date date = new Date();
		long time = date.getTime();
		List errorList = new ArrayList();
		try {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			MultipartFile file = multipartRequest.getFile("upDevicefile");
			if (file.isEmpty()) {
				throw new Exception("文件为空！");
			}
			// 文件名字
			String fileName = file.getOriginalFilename();
			// 输入流
			InputStream in = file.getInputStream();
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
				 * 计时终端
				 */
				it = dataListMap.iterator();
				while (it.hasNext()) {
					Map oneMap = (Map) it.next();
					if (oneMap.get("sheetName" + nameStrs[sheetIndex]) == null) {
						continue;
					} else {
						count[sheetIndex]++;
						Device device = new Device();
						Integer termTypeEx = oneMap.get("计时终端类型").toString().trim() != ""
								? Integer.parseInt(oneMap.get("计时终端类型").toString().trim()) : null;
						device.setTermtype(termTypeEx);
						device.setVender(oneMap.get("生产厂家").toString());
						device.setModel(oneMap.get("终端型号").toString());
						device.setImei(oneMap.get("终端IMEI号或设备MAC地址").toString().trim());
						device.setSn(oneMap.get("终端出厂序列号").toString().trim());
						device.setDevnum(oneMap.get("终端编号").toString().trim());

						try {
							deviceService.addByExcel(device);
						} catch (Exception e) {
							if (("本驾校已存在终端IMEI号或设备MAC地址为 " + device.getImei() + " 的计时终端").equals(e.getMessage())) {
								logger.error(e.getMessage());
								if (errorList.size() < 5) {
									errorList.add(e.getMessage());
								}
							} else {
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
				logger.error("CoachReaderExcelToDBController field list", e);
				result.error(e);
			}
			if (errorList.size() > 0) {
				if (errorList.size() == 5) {
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
			logger.error("DeviceController field list", e);
			result.error(e);
		} catch (Exception e) {
			logger.error("DeviceController field list", e);
			result.error(e);
		}
		return result;
	}

	
	@RequestMapping(value = "/deletes", method = RequestMethod.POST)
	@UserControllerLog(description = "删除终端数据")
	public Result deletes(Integer id) {
		Result result = new Result();
		Device device = new Device();
		try {
			if (id != null) {
				device.setId(id);
				deviceService.deletes(device);
				deviceService.deleteDevassign(id);
			}
			result.success(device);
		} catch (Exception e) {
			logger.error("car search", e);
			result.error(e);
		}
		return result;
	}

	
	@RequestMapping(value = "/exportDevice", method = RequestMethod.GET)
	@UserControllerLog(description = "导出终端数据")
	public void exportDevice(String insCode, HttpServletResponse response) throws UnsupportedEncodingException {
		response.setCharacterEncoding("UTF-8");
		String fileName = "计时终端列表.xls";
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
			sheet = wb.createSheet("计时终端列表");
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
			int count = 0;
			cell = row.createCell(count++);
			cell.setCellValue("终端编号");
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("计时终端类型");
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("生产厂家");
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("终端型号");
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("终端IMEI号或设备MAC地址");
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("终端出厂序列号");
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("培训机构编号");
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("终端证书口令");
			cell.setCellStyle(style);
			cell = row.createCell(count++);
			cell.setCellValue("终端证书");
			cell.setCellStyle(style);
			List<Device> list = deviceService.getAll();
			for (int i = 0; i < list.size(); i++) {
				Device device = list.get(i);
				row = sheet.createRow((int) exportRow);
				count = 0;
				row.createCell(count++).setCellValue(device.getDevnum() == null ? " " : device.getDevnum());
				row.createCell(count++).setCellValue(device.getTermtype() == null ? " " : device.getTermtype() + "");
				row.createCell(count++).setCellValue(device.getVender() == null ? " " : device.getVender());
				row.createCell(count++).setCellValue(device.getModel() == null ? " " : device.getModel());
				row.createCell(count++).setCellValue(device.getImei() == null ? " " : device.getImei());
				row.createCell(count++).setCellValue(device.getSn() == null ? " " : device.getSn());
				row.createCell(count++).setCellValue(insCode);
				row.createCell(count++).setCellValue(device.getPasswd() == null ? " " : device.getPasswd());
				row.createCell(count++).setCellValue(device.getKey() == null ? " " : device.getKey());
				exportRow++;
			}
			OutputStream out = response.getOutputStream();
			wb.write(out);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/carlist",method=RequestMethod.GET)
	public Result getCarList(Integer insId,String searchText){
		Assert.notNull(insId,"insId是空的");
		if("".equals(searchText)){
			searchText=null;
		}
		Result result=new Result();
		try {
			Map map=deviceService.getCarList(insId,searchText);
			result.success((List<Device>) map.get("deviceList"));
			result.put("onlineNum", map.get("onlineNum"));
			result.put("offlineNum", map.get("offlineNum"));
		} catch (Exception e) {
			logger.error(e.getMessage());
			result.error(e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value="/carbylicnum",method=RequestMethod.GET)
	public Result getCarByLicNum(String licNum){
		Assert.notNull(licNum,"licNum是空的");
		Result result=new Result();
		try {
			Device device=deviceService.getCarByLicNum(licNum);
			result.success(device);
		} catch (Exception e) {
			logger.error(e.getMessage());
			result.error(e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value="/inttobinary",method=RequestMethod.GET)
	public Result intToBinary(int intsta){
		Result result=new Result();
		try {
			String str=HexUtils.bytes2BinaryStr(HexUtils.int2byte(intsta));
			str = new StringBuffer(str).reverse().toString();
			result.success(str);
		} catch (Exception e) {
			logger.error(e.getMessage());
			result.error(e.getMessage());
		}
		return result;
	}
}
