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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.bjxc.Page;
import com.bjxc.Result;
import com.bjxc.school.Coach;
import com.bjxc.school.DrivingField;
import com.bjxc.school.ServiceStation;
import com.bjxc.school.Student;
import com.bjxc.school.TrainingCar;
import com.bjxc.school.service.DrivingFieldService;
import com.bjxc.web.utils.WebUtils;
import com.sun.mail.handlers.text_html;

/**
 * 练车场地管理 新增 修改、删除
 * 
 * @author cras
 */
@RestController
@RequestMapping(value = "/drivingField")
public class DrivingFieldController {
	private static final Logger logger = LoggerFactory.getLogger(DrivingFieldController.class);
	@Resource
	private DrivingFieldService drivingFieldService;

	/**
	 * 练车场地列表 支持对练车场地地址、名称的模糊搜索
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	@UserControllerLog(description = "练车场地列表 支持对练车场地地址、名称的模糊搜索")
	public Result list(@RequestParam(value = "searchText", required = false) String searchText, Integer insId,
			Integer pageIndex, Integer pageSize, HttpServletRequest request) {
		Result result = new Result();
		try {
			Page<DrivingField> page = null;
			page = drivingFieldService.getPagelist(searchText, insId, pageIndex, pageSize);
			result.success(page.getData());
			result.put("rowCount", page.getRowCount());
		} catch (Exception e) {
			logger.error("drving field list", e);
			result.error(e);
		}
		return result;
	}

	/**
	 * 按ID找练车场地信息
	 * 
	 * @param id
	 *            练车场地ID必填
	 * @return
	 */
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	@UserControllerLog(description = "按ID找练车场地信息")
	public Result get(@PathVariable("id") Integer id) {
		Result result = new Result();
		try {
			Assert.notNull(id, "not found Id");
			DrivingField drivingField = drivingFieldService.get(id);
			result.success(drivingField);
		} catch (Exception e) {
			logger.error("driving field get ", e);
			result.error(e);
		}
		return result;
	}

	/**
	 * 保存练车场地信息，前端传有ID参数为修改，没有ID信息为新增
	 * 
	 * @param request
	 * web请求对象
	 */
	@RequestMapping(method = RequestMethod.POST)
	@UserControllerLog(description = "保存练车场地信息")
	public Result save(HttpServletRequest request) {
		String name = WebUtils.getParameterValue(request, "name");
		String address = WebUtils.getParameterValue(request, "address");
		String location = WebUtils.getParameterValue(request, "location");
		String area = WebUtils.getParameterValue(request, "area");
		String seq = WebUtils.getParameterValue(request, "seq");
		String vehicletype = WebUtils.getParameterValue(request, "vehicletype");
		Integer totalvehnum = WebUtils.getParameterIntegerValue(request, "totalvehnum");
		Integer curvehnum = WebUtils.getParameterIntegerValue(request, "curvehnum");
		Integer insId = WebUtils.getParameterIntegerValue(request, "insId");
		Integer id = WebUtils.getParameterIntegerValue(request, "id");
		Integer areaId = WebUtils.getParameterIntegerValue(request, "areaId");
		Integer type = WebUtils.getParameterIntegerValue(request, "type");	
		String inscode = WebUtils.getParameterValue(request, "inscode");
		String isProvince = WebUtils.getParameterValue(request, "isProvince");
		
		Integer seqInt = 1;
		if(null != seq && !"".equals(seq)){
			seqInt = Integer.valueOf(seq);
		}
		
		Integer isProvinceInt = 1; //默认自动备案
//		if(null != isProvince && !"".equals(isProvince)){
//			isProvinceInt = Integer.valueOf(isProvince);
//		}
		
		Result result = new Result();
		try {
			DrivingField tdrivingField = new DrivingField();
			tdrivingField.setName(name);
			tdrivingField.setArea(area);
			tdrivingField.setVehicletype(vehicletype);
			tdrivingField.setTotalvehnum(totalvehnum);
			tdrivingField.setCurvehnum(curvehnum);
			tdrivingField.setInsId(insId);
			tdrivingField.setAddress(address);
			tdrivingField.setLocation(location);
			tdrivingField.setAreaId(areaId);
			tdrivingField.setType(type);
			tdrivingField.setSeqint(seqInt);
			tdrivingField.setSeq(seq);
			tdrivingField.setInscode(inscode);
			tdrivingField.setIsProvince(isProvinceInt);
			if (id == null) {
				drivingFieldService.add(tdrivingField);
				logger.info("添加教学区域成功：id="+id+";seq="+seq+";name="+name);
			} else {
				tdrivingField.setId(id);
				drivingFieldService.update(tdrivingField);
				logger.info("修改教学区域成功：id="+id+";seq="+seq+";name="+name);
			}
			result.success();
		} catch (Throwable ex) {
			logger.error("保存教学区域失败.", ex);
			result.error(ex);
		}
		return result;
	}

	/**
	 * 停用停车场信息
	 * @param id
	 * 停车场ID 必传
	 * @return
	 */
	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	@UserControllerLog(description = "停用停车场信息")
	public Result remove(@PathVariable("id") Integer id) {
		Result result = new Result();
		try {
			Assert.notNull(id, "not found Id");
			drivingFieldService.updateDrivingFieldStatus(id, new Integer(0));
			result.success();
		} catch (Exception e) {
			logger.error("driving field delete ", e);
			result.error(e);
		}
		return result;
	}

	/**
	 * 导出练车场地
	 */
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/dflist", method = RequestMethod.GET)
	@UserControllerLog(description = "导出练车场地")
	public Result exportStudents(HttpServletResponse response,HttpServletRequest request) throws IOException {
		Integer insId = WebUtils.getParameterIntegerValue(request, "insId");
		response.setCharacterEncoding("UTF-8");
		String fileName = "练车场地基本信息" + ".xls";
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
			List<DrivingField> exportlist = drivingFieldService.carlist(insId);
			sheet = wb.createSheet("练车场地信息");
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
			cell.setCellValue("名称"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(1);
			cell.setCellValue("场地编号"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(2);
			cell.setCellValue("隶属片区"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(3);
			cell.setCellValue("地址"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(4);
			cell.setCellValue("面积"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(5);
			cell.setCellValue("培训车型"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(6);
			cell.setCellValue("空间坐标"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(7);
			cell.setCellValue("可容纳车梁数"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(8);
			cell.setCellValue("已容纳车辆数"); // 头部
			cell.setCellStyle(style);
			
			cell = row.createCell(9);
			cell.setCellValue("状态"); // 头部
			cell.setCellStyle(style);
			
			for (int i = 0; i < exportlist.size(); i++) { // 循环导出数据
				DrivingField stu = exportlist.get(i);
				// 第四步，创建单元格，并设置值
				row = sheet.createRow((int) exportRow);
				if (stu.getName() != null) {
					row.createCell((short) 0).setCellValue(stu.getName());
				} else {
					row.createCell((short) 0).setCellValue(" ");
				}

				// 场地编号
				if (stu.getSeq() != null) {
					row.createCell((short) 1).setCellValue(stu.getSeq());
				} else {
					row.createCell((short) 1).setCellValue(" ");
				}

				// 隶属片区
				if (stu.getTtname() != null) {
					row.createCell((short) 2).setCellValue(stu.getTtname());
				} else {
					row.createCell((short) 2).setCellValue(" ");
				}

				// 练车场地地址
				if (stu.getAddress() != null) {
					row.createCell((short) 3).setCellValue(stu.getAddress());
				} else {
					row.createCell((short) 3).setCellValue(" ");
				}

				// 练车场面积
				if (stu.getAreasize() != null) {
					row.createCell((short) 4).setCellValue(stu.getAreasize());
				} else {
					row.createCell((short) 4).setCellValue(" ");
				}

				// 培训车型
				if (stu.getVehicletype() != null) {
					row.createCell((short) 5).setCellValue(stu.getVehicletype());
				} else {
					row.createCell((short) 5).setCellValue(" ");
				}

				// 练车场坐标
				if (stu.getLocation() != null) {
					row.createCell((short) 6).setCellValue(stu.getLocation());
				} else {
					row.createCell((short) 6).setCellValue(" ");
				}

				// 教练数量
				if (stu.getTotalvehnum() != null) {
					row.createCell((short) 7).setCellValue(stu.getTotalvehnum());
				} else {
					row.createCell((short) 7).setCellValue(" ");
				}

				// 可投放车数量
				if (stu.getCurvehnum() != null) {
					row.createCell((short) 8).setCellValue(stu.getCurvehnum());
				} else {
					row.createCell((short) 8).setCellValue(" ");
				}
				//状态
				if (stu.getStatus() != null) {
					if(stu.getStatus()==0){
						row.createCell((short) 9).setCellValue("已禁用");
					}else if(stu.getStatus()==1){
						row.createCell((short) 9).setCellValue("");
					}
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

	/**
	 * 根据地点查询服务网点（通用）
	 */
	@RequestMapping(value = "/findByDriving", method = RequestMethod.POST)
	@UserControllerLog(description = "根据地点查询服务网点（通用）")
	public Result findByDriving(String name, Integer insId) {
		Result result = new Result();
		try {
			List<DrivingField> datas = drivingFieldService.findByDriving(name, insId);
			result.success(datas);
		} catch (Exception e) {
			logger.error("根据地点查询教练车场地", e);
			result.error(e);
		}
		return result;
	}
	
	/**
	 * 禁用练车场地
	 */
	@RequestMapping(value="/updatestatus",method = RequestMethod.POST)
	@UserControllerLog(description = "禁用练车场地")
	public Result updatestatus(HttpServletRequest request,Integer id,Integer isProvince) {
		Result result = new Result();
		try {
			DrivingField tdrivingField = new DrivingField();
			if (id != null) {
				tdrivingField.setId(id);
				tdrivingField.setIsProvince(isProvince);
				drivingFieldService.updatestatus(tdrivingField);
			} 
			result.success();
		} catch (Throwable ex) {
			logger.error("save Driving field ", ex);
			result.error(ex);
		}
		return result;
	}
	
	/**
	 * 更新省备案
	 */
	@RequestMapping(value="/isprovince",method = RequestMethod.GET)
	@UserControllerLog(description = "练车场地更新省备案")
	public Result isprovince(String inscode,String seq) {
		Result result = new Result();
		try {
			drivingFieldService.updateIsprovince(Integer.parseInt(seq),inscode,1);
			result.success();
		} catch (Throwable ex) {
			logger.error("save Driving field ", ex);
			result.error(ex);
		}
		return result;
	}
	
	
	/**
	 * 删除练车场地
	 */
	@RequestMapping(value="/delete",method = RequestMethod.POST)
	@UserControllerLog(description = "删除练车场地")
	public Result deletes(Integer id) {
		Result result = new Result();
		try {
			drivingFieldService.delete(id);
			result.success();
		} catch (Throwable ex) {
			logger.error("save Driving field ", ex);
			result.error(ex);
		}
		return result;
	}
	
	/**
	 * 根据地点查询服务网点（通用）
	 */
	@RequestMapping(value = "/findByIdDriving", method = RequestMethod.POST)
	@UserControllerLog(description = "根据地点查询服务网点（通用）")
	public Result findByDriving(Integer id, Integer insId) {
		Result result = new Result();
		try {
			List<DrivingField> datas = drivingFieldService.findByIdDriving(id, insId);
			result.success(datas);
		} catch (Exception e) {
			logger.error("根据地点查询教练车场地", e);
			result.error(e);
		}
		return result;
	}
	
	/**
	 * 获取自增的场地ID
	 */
	@RequestMapping(value = "/Incrementselect", method = RequestMethod.GET)
	@UserControllerLog(description = "获取自增的场地ID")
	public Result Incrementselect(Integer insId) {
		Result result = new Result();
		try {
			DrivingField drivingField = drivingFieldService.Incrementselect(insId);
			//增加drivingField为null的判断,在数据库没有一条记录的情况下,Modify by Levin 20161219
			if( drivingField == null){
				drivingField = new DrivingField();
			}
			
			String seq=drivingField.getSeq();
			if (seq == null) {
				seq = "0001";
			}
		    int sed = Integer.parseInt(seq);
		    //计时平台编号自增，跟驾校没有关系，到底是4位还是5位？按照规范是4位
			//if(drivingField.getInsId()==insId){
				sed=sed+1;
				String str = String.format("%04d", sed);   //最后插入的值*/	
				drivingField.setSeq(str);
			//}else{
			//	seq="0001";
			//	drivingField.setSeq(seq);
			//}
		
		
			result.success(drivingField);
		} catch (Exception e) {
			logger.error("driving field get ", e);
			result.error(e);
		}
		return result;
	}
	
	
	/**
	 * 根据ID查询教学区域<br/>
	 */
	@RequestMapping(value = "/getselect", method = RequestMethod.GET)
	@UserControllerLog(description = "根据ID查询教学区域")
	public Result getselect(Integer id) {
		Result result = new Result();
		try {
			Assert.notNull(id, "not found Id");
			DrivingField drivingField = drivingFieldService.get(id);
			String seq=drivingField.getSeq();
			 int sed = Integer.parseInt(seq);
			String str = String.format("%04d", sed);   //最后插入的值*/	
			drivingField.setSeq(str);
			result.success(drivingField);
		} catch (Exception e) {
			logger.error("driving field get ", e);
			result.error(e);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/getDrivingFieldByCoach" , method = RequestMethod.GET)
	public Result getDrivingFieldByCoach(Integer recordId) {
		Result result = new Result();
		try {
			Assert.notNull(recordId, "recordId not found");
			DrivingField drivingField = drivingFieldService.findByCoach(recordId);
			String seq=drivingField.getSeq();
			 int sed = Integer.parseInt(seq);
			String str = String.format("%04d", sed);   //最后插入的值*/	
			drivingField.setSeq(str);
			result.success(drivingField);
		} catch (Exception e) {
			logger.error("passTeachLog", e);
			result.error(e);
		}
		return result;
	}
}
