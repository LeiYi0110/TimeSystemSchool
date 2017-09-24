package com.bjxc.school.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.List;

import org.apache.commons.io.filefilter.FalseFileFilter;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bjxc.Page;
import com.bjxc.Result;
import com.bjxc.school.PlatformUser;
import com.bjxc.school.PlatformUserParam;
import com.bjxc.school.Security;
import com.bjxc.school.service.PlatformUserService;
import com.bjxc.web.utils.WebUtils;

@Controller
@RequestMapping(value="/platform")
public class PlatformUserController {
	private static final Logger logger = LoggerFactory.getLogger(PlatformUserController.class);
	@Resource
	private PlatformUserService platformService;
	
	@ResponseBody
	@RequestMapping(value="/list",method=RequestMethod.GET)
	@UserControllerLog(description = "帐号查询列表")    
	public Result list(HttpServletRequest request){
		Result result=new Result();
		String searchText=WebUtils.getParameterValue(request, "searchText");
		Integer insId=WebUtils.getParameterIntegerValue(request, "insId");
		Integer pageIndex=WebUtils.getParameterIntegerValue(request, "pageIndex");
		Integer pageSize=WebUtils.getParameterIntegerValue(request, "pageSize");
		String statId=request.getParameter("statId");
		Integer stationId=null;
		if(!statId.equals("null")){
			stationId=Integer.parseInt(statId);
		}
		try {
			Page<PlatformUser> page=platformService.list(searchText, insId, stationId, pageIndex, pageSize);
			//List<PlatformUser> list=platformService.list(searchText,insId,stationId);
			result.success(page.getData());
			result.put("rowCount", page.getRowCount());
		} catch (Exception e) {
			logger.error("帐号查询"+e);
			result.error(e);
		}
		return result;
	}
	
	/**
	 * 停用帐号
	 */
	@ResponseBody
	@RequestMapping(value="/{id}",method=RequestMethod.PUT)
	@UserControllerLog(description = "停用帐号")    
	public Result stopUse(@PathVariable Integer id){
		Result result = new Result();
		try {
			platformService.updateUse(id,0);
		} catch (Exception e) {
			logger.error("停用帐号",e);
			result.error(e);
		}
		return result;
	}
	
	/**
	 * 恢复帐号
	 */
	@ResponseBody
	@RequestMapping(value="/{id}",method=RequestMethod.DELETE)
	@UserControllerLog(description = "恢复帐号")    
	public Result backUse(@PathVariable Integer id){
		Result result = new Result();
		try {
			platformService.updateUse(id,1);
		} catch (Exception e) {
			logger.error("恢复帐号",e);
			result.error(e);
		}
		return result;
	}
	
	/**
	 * 查询帐号
	 */
	@ResponseBody
	@RequestMapping(value="/{id}",method=RequestMethod.GET)
	@UserControllerLog(description = "查询帐号")    
	public Result findInfo(@PathVariable Integer id){
		Result result = new Result();
		try {
			PlatformUser user=platformService.userInfo(id);
			result.success(user);
		} catch (Exception e) {
			logger.error("停用帐号",e);
			result.error(e);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(method=RequestMethod.POST)
	@UserControllerLog(description = "新增或修改帐号")
	public Result save(PlatformUserParam user,HttpServletRequest request){
		Result result = new Result();
		Md5PasswordEncoder md5PasswordEncoder = new Md5PasswordEncoder();
		boolean enablePasswork = true;
		if(StringUtils.isBlank(user.getPassword())){
			enablePasswork = false;
		}
		String password = md5PasswordEncoder.encodePassword(user.getPassword(),"");
		String station=request.getParameter("station");
		
		System.out.println(station);
		if(station!=null&&!station.equals("null")){
			user.setStationId(Integer.parseInt(station));
		}
		user.setPassword(password);
		if(user.getUrole()==2){
			user.setStationId(null);
		}
		try {
			if(user.getId()==null){
				platformService.insertUser(user);
			}else {
				if(!enablePasswork){
					user.setPassword(platformService.getPlatformUser(user.getId()).getPassword());
				}
				platformService.updateUser(user);
			}
		} catch (Exception e) {
			logger.error("新增或修改帐号",e);
			result.error(e);
		}
		return result;
	}
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/exportPlatform", method = RequestMethod.GET)
	@UserControllerLog(description = "其他成员管理信息")
	public Result exportPlatform(HttpServletResponse response) throws UnsupportedEncodingException{
		response.setCharacterEncoding("UTF-8");
		String fileName = "其他成员管理信息.xls";
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
			List<PlatformUser> exportlist = platformService.exceporPlatformUser();
			sheet = wb.createSheet("其他成员管理信息");
			HSSFRow row = sheet.createRow(0);
			HSSFCell cell = null;
			HSSFCellStyle style = wb.createCellStyle();
			style.setWrapText(true);// 设置自动换行
			// 第一个参数代表列id(从0开始),第2个参数代表宽度值
			sheet.setColumnWidth(0, 4500);
			sheet.setColumnWidth(1, 4500);
			sheet.setColumnWidth(2, 4500);
			sheet.setColumnWidth(3, 4500);
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
			cell.setCellValue("其他成员管理信息"); // 头部
			cell.setCellStyle(style);
			for (int i = 0; i < exportlist.size(); i++) { // 循环导出数据
				PlatformUser platform = exportlist.get(i);
				// 第四步，创建单元格，并设置值
				// if (string.getId() == stu.getStationId()) {
				row = sheet.createRow((int) exportRow);

				// 管理者名称
				if (platform.getUserName() != null) {
					row.createCell((short) 0).setCellValue(platform.getUserName());
				} else {
					row.createCell((short) 0).setCellValue(" ");
				}
				//账户级别
				if(platform.getUrole()!=null){
					if(platform.getUrole()==2){
						row.createCell((short)1).setCellValue("一级管理员");
					}else{
						row.createCell((short)1).setCellValue("网点管理员");
					}
					
				}else{
					row.createCell((short)1).setCellValue("");
				}
				//电话
				if(platform.getMobile()!=null){
					row.createCell((short)2).setCellValue(platform.getMobile());
				}else{
					row.createCell((short)2).setCellValue("");
				}
				// 大区
				if (platform.getArea() != null) {
					row.createCell((short) 3).setCellValue(platform.getArea());
				} else {
					row.createCell((short) 3).setCellValue(" ");
				}
				// 网点
				if (platform.getStationName() != null) {
					row.createCell((short) 4).setCellValue(platform.getStationName());
				} else {
					row.createCell((short) 4).setCellValue(" ");
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
	
	@ResponseBody
	@RequestMapping(value = "/updatepwd", method = RequestMethod.POST)
	@UserControllerLog(description = "密码修改")
	public Result updatepwd(Integer id, String newPassword2True, String phomeTrue, String oldPasswordTrue) {
		Result result = new Result();
		PlatformUser user = new PlatformUser();
		PlatformUser user2 = platformService.userInfo(id);
		Md5PasswordEncoder md5PasswordEncoder = new Md5PasswordEncoder();
		String passwordone= md5PasswordEncoder.encodePassword(oldPasswordTrue, "");
		
		String passwordtow = md5PasswordEncoder.encodePassword(newPassword2True, "");
		String  pwd=user2.getPassword();
		try {
			if (id != null) {
				if(passwordtow!=null){
					if (pwd==passwordone || pwd.equals(passwordone)) {
						user.setPassword(passwordtow);
					}else{
						result.error("旧密码输入错误");
						return result;
					}
					user.setMobile(phomeTrue);
					user.setId(id);
					platformService.updatepwd(user);
				}/*else{
					user.setMobile(phomeTrue);
					user.setId(id);
					platformService.updatepwd(user);
				}*/
			}
			result.success(user);
		} catch (Exception e) {
			result.error(e);
		}
		return result;
	}
	
}
