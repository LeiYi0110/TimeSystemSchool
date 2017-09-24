package com.bjxc.tcp.controller;

import com.bjxc.Result;
import com.bjxc.json.JacksonBinder;
import com.bjxc.school.NotificationMessage;
import com.bjxc.school.service.NotificationMessageService;
import com.bjxc.school.socket.RecordChangeMsgController;
import com.bjxc.tcp.model.*;
import com.bjxc.tcp.netty.HexUtils;
import com.bjxc.tcp.netty.JSPTConstants;
import com.bjxc.tcp.netty.Message;
import com.bjxc.tcp.netty.MessageUtils;
import com.bjxc.tcp.service.TCPClientService;
import com.bjxc.tcp.service.TCPClientService.ServiceGetDataListener;
import com.bjxc.web.utils.WebUtils;
import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;

//import com.bjxc.school.tcp.TCPClient;

@RestController
@RequestMapping(value="/TCPClient")
public class TCPClientController  implements ServiceGetDataListener{

	private static final Logger logger = LoggerFactory.getLogger(TCPClientController.class);
	private static JacksonBinder binder = JacksonBinder.buildNormalBinder();

	@Autowired
	private TCPClientService tcpClientService;
	@Resource
	private NotificationMessageService service;

	@RequestMapping(value="/Test",method=RequestMethod.GET)
	public Result test()
	{
		tcpClientService.getDataListener = this;
		Result result = tcpClientService.sendToTCPServer("7E800100003D0000013012345343002C3C000B0064373032303243563730303000000000000000000000000000003630303030303333353530393930343831313139393402D5E34531353738D1A7E27E");
		return result;
	}

	@RequestMapping(value="/bindDevice",method=RequestMethod.POST)
	public Result bindDevice(String deviceNum,String mobile,HttpServletRequest request){
		Result result = new Result();
		try {
			if(StringUtils.isEmpty(deviceNum)||StringUtils.isEmpty(mobile)){
				throw new Exception("终端编号或者手机号不能为空");
			}
			request.getSession().setAttribute("deviceNum", deviceNum);
			request.getSession().setAttribute("mobile", mobile);
			result.setMessage("绑定成功");
		} catch (Exception e) {
			result.error(e);
		}
		return result;
	}

	@RequestMapping(value="/login",method=RequestMethod.POST)
	public Result login(HttpServletRequest request){

		tcpClientService.getDataListener = this;

		String deviceNum="8976135099525149";//(String) request.getSession().getAttribute("deviceNum");
		String mobile= "00000000000";//(String) request.getSession().getAttribute("mobile");


		String num=WebUtils.getParameterValue(request, "platformNum");
		String psw=WebUtils.getParameterValue(request, "pwd");
		Integer code=WebUtils.getParameterIntegerValue(request, "code");
		Login login = new Login();
		login.setNum(num);
		login.setPassword(psw);
		login.setCode(code);

		Message commonMessage = MessageUtils.getCommonMessage(login, (short)0X01F0, JSPTConstants.JSPT_MOBILE_DEFAULT);	//需要转发的消息
		Message packageMessage = MessageUtils.packageMessage(commonMessage, (short)-1, JSPTConstants.JSPT_MOBILE_DEFAULT);	//通过-1到达转发的Action，通过手机号查找转发通道

		//		Message defaultMessage = MessageUtils.getWebDefaultMessage(login, (short)0X01FF0, mobile, deviceNum, "平台登录");
		Result result = tcpClientService.sendToTCPServer(packageMessage);
		return result;
	}

	@RequestMapping(value="/logout",method=RequestMethod.POST)
	public Result setParams(HttpServletRequest request){
		String deviceNum="8976135099525149";//(String) request.getSession().getAttribute("deviceNum");
		String mobile= "00000000000";//(String) request.getSession().getAttribute("mobile");
		tcpClientService.getDataListener = this;

		String num=WebUtils.getParameterValue(request, "platformNum");
		String psw=WebUtils.getParameterValue(request, "pwd");
		Logout logout = new Logout();
		logout.setNum(num);
		logout.setPassword(psw);

		Message commonMessage = MessageUtils.getCommonMessage(logout, (short)0X01F1, mobile);
		Message packageMessage = MessageUtils.packageMessage(commonMessage, (short)-1, "88899990000");

		//		Message defaultMessage = MessageUtils.getWebDefaultMessage(logout, (short)0X01FF1, mobile, deviceNum, "平台登出");
		Result result = tcpClientService.sendToTCPServer(packageMessage);
		return result;
	}


	@RequestMapping(value="/setTerminalParams",method=RequestMethod.POST)
	public Result setTerminalParams(HttpServletRequest request){
		String deviceNum=(String) request.getSession().getAttribute("deviceNum");
		String mobile=(String) request.getSession().getAttribute("mobile");
		tcpClientService.getDataListener = this;
		Integer number=WebUtils.getParameterIntegerValue(request, "number");
		Terminal terminal = new Terminal();
		terminal.setParameterCount(Byte.parseByte(number+""));
		terminal.setParameterNumber(Byte.parseByte(number+""));
		ArrayList<ParamDS> arrayList = new ArrayList<ParamDS>();
		for (int i = 0; i < number; i++) {
			String sid=request.getParameter("id"+i);
			String slen=request.getParameter("len"+i);
			String svalue=request.getParameter("value"+i);
			int id = HexUtils.parse(sid);
			if(slen.equals("1")){
				byte[] bytes = {Byte.parseByte(svalue)};
				arrayList.add(new ParamDS((int)id,(byte)1, bytes));
			}else if(slen.equals("2")){
				arrayList.add(new ParamDS((int)id,(byte)2, MessageUtils.getShort2byte(Short.parseShort(svalue))));
			}else if(slen.equals("4")){
				arrayList.add(new ParamDS((int)id,(byte)4, MessageUtils.getInt2byte(Integer.parseInt(svalue))));
			}else if(slen.equals("8")){
				arrayList.add(new ParamDS((int)id,(byte)8, MessageUtils.getString2byte(svalue)));
			}
		}
		terminal.setParamList(arrayList);

		Message commonMessage = MessageUtils.getCommonMessage(terminal, (short)0x8103, JSPTConstants.JSPT_PLATFORMNO_BCD);
		Message packageMessage = MessageUtils.packageMessage(commonMessage, (short)-1, mobile);

		//		Message defaultMessage = MessageUtils.getWebDefaultMessage(terminal, (short)0x88103, mobile, deviceNum, "设置终端参数");
		Result result = tcpClientService.sendToTCPServer(packageMessage);
		return result;
	}

	@RequestMapping(value="/queryTerminalParams",method=RequestMethod.POST)
	public Result queryTerminalParams(HttpServletRequest request){
		String deviceNum=(String) request.getSession().getAttribute("deviceNum");
		String mobile=(String) request.getSession().getAttribute("mobile");
		Result result = new Result();
		if(!"".equals(mobile)){
			System.out.println("mobile:"+mobile);
			tcpClientService.getDataListener = this;

			Message commonMessage = MessageUtils.getCommonMessage(null, (short)0x8104, JSPTConstants.JSPT_PLATFORMNO_BCD);
			Message packageMessage = MessageUtils.packageMessage(commonMessage, (short)-1, mobile);

			//		Message defaultMessage = MessageUtils.getWebDefaultMessage(null, (short)0x88104, mobile, deviceNum, "查询终端参数");
			result = tcpClientService.sendToTCPServer(packageMessage);
		}else{
			result.error("没有绑定手机号");
		}
		return result;
	}

	@RequestMapping(value="/queryTerminalCurrentParams",method=RequestMethod.POST)
	public Result queryTerminalCurrentParams(HttpServletRequest request){
		String deviceNum=(String) request.getSession().getAttribute("deviceNum");
		String mobile=(String) request.getSession().getAttribute("mobile");
		Result result = new Result();
		if(!"".equals(mobile)){
			tcpClientService.getDataListener = this;

			String number=WebUtils.getParameterValue(request, "number");
			String params=WebUtils.getParameterValue(request, "params");
			String[] split = params.split(",");
			TerminalQuery terminalQuery = new TerminalQuery();
			terminalQuery.setParamNumber(Byte.parseByte(split.length+""));
			ArrayList<Integer> arrayList = new ArrayList<Integer>();
			for (String string : split) {
				arrayList.add(Integer.parseInt(string));
			}
			terminalQuery.setParamList(arrayList);

			Message commonMessage = MessageUtils.getCommonMessage(terminalQuery, (short)0x8106, JSPTConstants.JSPT_PLATFORMNO_BCD);
			Message packageMessage = MessageUtils.packageMessage(commonMessage, (short)-1, mobile);

			//		Message defaultMessage = MessageUtils.getWebDefaultMessage(terminalQuery, (short)0x88106, mobile, deviceNum, "查询指定终端参数");
			result = tcpClientService.sendToTCPServer(packageMessage);
		}else{
			result.error("没有绑定手机号");
		}
		return result;
	}

	@RequestMapping(value="/terminalOrder",method=RequestMethod.POST)
	public Result terminalOrder(HttpServletRequest request){
		String deviceNum=(String) request.getSession().getAttribute("deviceNum");
		String mobile=(String) request.getSession().getAttribute("mobile");
		Result result = new Result();
		if(!"".equals(mobile)){
			tcpClientService.getDataListener = this;

			String orderName=WebUtils.getParameterValue(request, "orderName");
			String orderParam=WebUtils.getParameterValue(request, "orderParam");
			TerminalOrder terminalOrder = new TerminalOrder();
			terminalOrder.setOrderCode(Byte.parseByte(orderName));
			terminalOrder.setOrder(orderParam);

			Message commonMessage = MessageUtils.getCommonMessage(terminalOrder, (short)0x8105, JSPTConstants.JSPT_PLATFORMNO_BCD);
			Message packageMessage = MessageUtils.packageMessage(commonMessage, (short)-1, mobile);

			//		Message defaultMessage = MessageUtils.getWebDefaultMessage(terminalOrder, (short)0x88105, mobile, deviceNum, "终端控制");
			result = tcpClientService.sendToTCPServer(packageMessage);
		}else{
			result.error("没有绑定手机号");
		}
		return result;
	}

	@RequestMapping(value="/locationQuery",method=RequestMethod.POST)
	public Result query(HttpServletRequest request){
		String deviceNum=(String) request.getSession().getAttribute("deviceNum");
		String mobile=(String) request.getSession().getAttribute("mobile");
		Result result = new Result();
		if(!"".equals(mobile)){
			tcpClientService.getDataListener = this;

			Message commonMessage = MessageUtils.getCommonMessage(null, (short)0x8201, JSPTConstants.JSPT_PLATFORMNO_BCD);
			Message packageMessage = MessageUtils.packageMessage(commonMessage, (short)-1, mobile);

			//		Message defaultMessage = MessageUtils.getWebDefaultMessage(null, (short)0x88201, mobile, deviceNum, "位置信息查询");
			result = tcpClientService.sendToTCPServer(packageMessage);
		}else{
			result.error("没有绑定手机号");
		}
		return result;
	}

	@RequestMapping(value="/locationTrack",method=RequestMethod.POST)
	public Result track(HttpServletRequest request){
		String deviceNum=(String) request.getSession().getAttribute("deviceNum");
		String mobile=(String) request.getSession().getAttribute("mobile");
		Result result = new Result();
		if(!"".equals(mobile)){
			tcpClientService.getDataListener = this;

			String interval=WebUtils.getParameterValue(request, "interval");
			Integer validity=WebUtils.getParameterIntegerValue(request, "validity");
			LocationTemporary locationTemporary = new LocationTemporary();
			locationTemporary.setTimeInterval(Short.parseShort(interval));
			locationTemporary.setTimeValidity(validity);

			Message commonMessage = MessageUtils.getCommonMessage(locationTemporary, (short)0x8202, JSPTConstants.JSPT_PLATFORMNO_BCD);
			Message packageMessage = MessageUtils.packageMessage(commonMessage, (short)-1, mobile);

			//		Message defaultMessage = MessageUtils.getWebDefaultMessage(locationTemporary, (short)0x882022, mobile, deviceNum, "临时位置跟踪");
			result = tcpClientService.sendToTCPServer(packageMessage);
		}else{
			result.error("没有绑定手机号");
		}
		return result;
	}
	
	
	@RequestMapping(value="/autoRecord",method=RequestMethod.POST)
	public Result autoRecord(HttpServletRequest request){
		String deviceNum=(String) request.getSession().getAttribute("deviceNum");
		String mobile=(String) request.getSession().getAttribute("mobile");
		Result result = new Result();
		if(!"".equals(mobile)){
			tcpClientService.getDataListener = this;
			
			String stuNum=WebUtils.getParameterValue(request, "stuNum");
			String coachNum=WebUtils.getParameterValue(request, "coachNum");
			Integer recordCount=WebUtils.getParameterIntegerValue(request, "recordCount");
			
			ResponseAutoRecord responseAutoRecord = new ResponseAutoRecord();
			responseAutoRecord.setStudentNum(stuNum);
			responseAutoRecord.setCoachNum(coachNum);
			if(recordCount!=null){
				responseAutoRecord.setCount(recordCount);
			}else{
				responseAutoRecord.setCount(0);
			}
			
			Message commonMessage = MessageUtils.getCommonMessage(responseAutoRecord, (short)-2, JSPTConstants.JSPT_PLATFORMNO_BCD);
			Message packageMessage = MessageUtils.packageMessage(commonMessage, (short)-1, mobile);
			result = tcpClientService.sendToTCPServer(packageMessage);
		}else{
			result.error("没有绑定手机号");
		}
		return result;
	}
	
	
	
	@RequestMapping(value="/uploadRecord",method=RequestMethod.POST)
	public Result uploadRecord(HttpServletRequest request){
		String deviceNum=(String) request.getSession().getAttribute("deviceNum");
		String mobile=(String) request.getSession().getAttribute("mobile");
		Result result = new Result();
		if(!"".equals(mobile)){
			tcpClientService.getDataListener = this;

			String type=WebUtils.getParameterValue(request, "type");
			String startTime=WebUtils.getParameterValue(request, "startTime");
			String endTime=WebUtils.getParameterValue(request, "endTime");
			String number=WebUtils.getParameterValue(request, "number");
			ResponseStudyingTimeOrder responseStudyingTimeOrder = new ResponseStudyingTimeOrder();
			responseStudyingTimeOrder.setQueryMode(Byte.parseByte(type));
			responseStudyingTimeOrder.setQueryNumber(Short.parseShort(number));
			responseStudyingTimeOrder.setQueryStartTime(HexUtils.str2Bcd(startTime));
			responseStudyingTimeOrder.setQueryEndTime(HexUtils.str2Bcd(endTime));

			Message downTransportMessage = MessageUtils.getDownTransportMessage(responseStudyingTimeOrder, (short)0x8205, JSPTConstants.JSPT_PLATFORMNO_BCD, deviceNum);
			Message packageMessage = MessageUtils.packageMessage(downTransportMessage, (short)-1, mobile);

			//		Message defaultMessage = MessageUtils.getWebDefaultMessage(responseStudyingTimeOrder, (short)0x8205, mobile, deviceNum,"命令上报学时");
			result = tcpClientService.sendToTCPServer(packageMessage);
		}else{
			result.error("没有绑定手机号");
		}
		return result;
	}

	@RequestMapping(value="/getPhoto",method=RequestMethod.POST)
	public Result getPhoto(HttpServletRequest request){
		String deviceNum=(String) request.getSession().getAttribute("deviceNum");
		String mobile=(String) request.getSession().getAttribute("mobile");
		Result result = new Result();
		if(!"".equals(mobile)){
			tcpClientService.getDataListener = this;

			String type=WebUtils.getParameterValue(request, "type");
			String cameraNum=WebUtils.getParameterValue(request, "cameraNum");
			String size=WebUtils.getParameterValue(request, "size");
			if(deviceNum==null && mobile==null){
				mobile=WebUtils.getParameterValue(request, "mobile");
				deviceNum=WebUtils.getParameterValue(request, "deviceNum");
			}			
			ResponsePhotoImmediately responsePhotoImmediately = new ResponsePhotoImmediately();
			responsePhotoImmediately.setUpMode(Byte.parseByte(type));
			responsePhotoImmediately.setCameraNum(Byte.parseByte(cameraNum));
			responsePhotoImmediately.setPhotoSize(Byte.parseByte(size));

			Message downTransportMessage = MessageUtils.getDownTransportMessage(responsePhotoImmediately, (short)0x8301, JSPTConstants.JSPT_PLATFORMNO_BCD, deviceNum);
			Message packageMessage = MessageUtils.packageMessage(downTransportMessage, (short)-1, mobile);

			//		Message defaultMessage = MessageUtils.getWebDefaultMessage(responsePhotoImmediately, (short)0x8301, mobile, deviceNum, "立即拍照");
			result = tcpClientService.sendToTCPServer(packageMessage);
		}else{
			result.error("没有绑定手机号");
		}
		return result;
	}

	@RequestMapping(value="/queryPhoto",method=RequestMethod.POST)
	public Result queryPhoto(HttpServletRequest request){
		String deviceNum=(String) request.getSession().getAttribute("deviceNum");
		String mobile=(String) request.getSession().getAttribute("mobile");
		Result result = new Result();
		if(!"".equals(mobile)){
			tcpClientService.getDataListener = this;

			String type=WebUtils.getParameterValue(request, "type");
			String startTime=WebUtils.getParameterValue(request, "startTime");
			String endTime=WebUtils.getParameterValue(request, "endTime");
			ResponsePhotoQuery responsePhotoQuery = new ResponsePhotoQuery();
			responsePhotoQuery.setQueryMode(Byte.parseByte(type));
			responsePhotoQuery.setStartTime(HexUtils.str2Bcd(startTime));
			responsePhotoQuery.setEndTime(HexUtils.str2Bcd(endTime));

			Message downTransportMessage = MessageUtils.getDownTransportMessage(responsePhotoQuery, (short)0x8302, JSPTConstants.JSPT_PLATFORMNO_BCD, deviceNum);
			Message packageMessage = MessageUtils.packageMessage(downTransportMessage, (short)-1, mobile);

			//		Message defaultMessage = MessageUtils.getWebDefaultMessage(responsePhotoQuery, (short)0x8302, mobile, deviceNum, "查询照片");
			result = tcpClientService.sendToTCPServer(packageMessage);
		}else{
			result.error("没有绑定手机号");
		}
		return result;
	}

	@RequestMapping(value="/uploadPhoto",method=RequestMethod.POST)
	public Result uploadPhoto(HttpServletRequest request){
		String deviceNum=(String) request.getSession().getAttribute("deviceNum");
		String mobile=(String) request.getSession().getAttribute("mobile");
		Result result = new Result();
		if(!"".equals(mobile)){
			tcpClientService.getDataListener = this;

			String num=WebUtils.getParameterValue(request, "num");
			ResponsePhotoUploadCertain responsePhotoUploadCertain = new ResponsePhotoUploadCertain();
			responsePhotoUploadCertain.setPhotoNum(num);

			Message downTransportMessage = MessageUtils.getDownTransportMessage(responsePhotoUploadCertain, (short)0x8304, JSPTConstants.JSPT_PLATFORMNO_BCD, deviceNum);
			Message packageMessage = MessageUtils.packageMessage(downTransportMessage, (short)-1, mobile);

			//		Message defaultMessage = MessageUtils.getWebDefaultMessage(responsePhotoUploadCertain, (short)0x8304, mobile, deviceNum, "上传指定照片");
			result = tcpClientService.sendToTCPServer(packageMessage);
		}else{
			result.error("没有绑定手机号");
		}
		return result;
	}

	@RequestMapping(value="/setTimeTerminalParams",method=RequestMethod.POST)
	public Result setTimeTerminalParams(HttpServletRequest request){
		String deviceNum=(String) request.getSession().getAttribute("deviceNum");
		String mobile=(String) request.getSession().getAttribute("mobile");
		Result result = new Result();
		if(!"".equals(mobile)){
			tcpClientService.getDataListener = this;

			String paramId=WebUtils.getParameterValue(request, "paramId");
			String getPhotoInterval=WebUtils.getParameterValue(request, "getPhotoInterval");
			String uploadSetting=WebUtils.getParameterValue(request, "uploadSetting");
			String hasExtalMsg=WebUtils.getParameterValue(request, "hasExtalMsg");
			String stopStudingTimeDelay=WebUtils.getParameterValue(request, "stopStudingTimeDelay");
			String GNSSInterval=WebUtils.getParameterValue(request, "GNSSInterval");
			String autoLogoutDelay=WebUtils.getParameterValue(request, "autoLogoutDelay");
			String reValidate=WebUtils.getParameterValue(request, "reValidate");
			String enableCrossSchoolTeaching=WebUtils.getParameterValue(request, "enableCrossSchoolTeaching");
			String enableCrossSchoolStuding=WebUtils.getParameterValue(request, "enableCrossSchoolStuding");
			String answerInterval=WebUtils.getParameterValue(request, "answerInterval");
			ResponseTimeTerminalSetParam responseTimeTerminalSetParam = new ResponseTimeTerminalSetParam();
			responseTimeTerminalSetParam.setAnswerInterval(Byte.parseByte(answerInterval));
			responseTimeTerminalSetParam.setAutoLogoutDelay(Short.parseShort(autoLogoutDelay));
			responseTimeTerminalSetParam.setEnableCrossSchoolStuding(Byte.parseByte(enableCrossSchoolStuding));
			responseTimeTerminalSetParam.setEnableCrossSchoolTeaching(Byte.parseByte(enableCrossSchoolTeaching));
			responseTimeTerminalSetParam.setGetPhotoInterval(Byte.parseByte(getPhotoInterval));
			responseTimeTerminalSetParam.setGNSSInterval(Short.parseShort(GNSSInterval));
			responseTimeTerminalSetParam.setHasExtalMsg(Byte.parseByte(hasExtalMsg));
			responseTimeTerminalSetParam.setParamId(Byte.parseByte(paramId));
			responseTimeTerminalSetParam.setReValidate(Byte.parseByte(reValidate));
			responseTimeTerminalSetParam.setStopStudingTimeDelay(Byte.parseByte(stopStudingTimeDelay));
			responseTimeTerminalSetParam.setUploadSetting(Byte.parseByte(uploadSetting));

			Message downTransportMessage = MessageUtils.getDownTransportMessage(responseTimeTerminalSetParam, (short)0x8501, JSPTConstants.JSPT_PLATFORMNO_BCD, deviceNum);
			Message packageMessage = MessageUtils.packageMessage(downTransportMessage, (short)-1, mobile);

			//		Message defaultMessage = MessageUtils.getWebDefaultMessage(responseTimeTerminalSetParam, (short)0x8501, mobile, deviceNum, "设置计时终端应用参数");
			result = tcpClientService.sendToTCPServer(packageMessage);
		}else{
			result.error("没有绑定手机号");
		}
		return result;
	}

	@RequestMapping(value="/unableTraining",method=RequestMethod.POST)
	public Result unableTraining(HttpServletRequest request){
		String deviceNum=(String) request.getSession().getAttribute("deviceNum");
		String mobile=(String) request.getSession().getAttribute("mobile");
		Result result = new Result();
		if(!"".equals(mobile)){
			tcpClientService.getDataListener = this;

			String type=WebUtils.getParameterValue(request, "type");
			String len=WebUtils.getParameterValue(request, "len");
			String content=WebUtils.getParameterValue(request, "content");
			ResponseUnableTraining responseUnableTraining = new ResponseUnableTraining();
			responseUnableTraining.setMessage(content);
			responseUnableTraining.setUnableTrainingStatus(Byte.parseByte(type));

			Message downTransportMessage = MessageUtils.getDownTransportMessage(responseUnableTraining, (short)0x8502, JSPTConstants.JSPT_PLATFORMNO_BCD, deviceNum);
			Message packageMessage = MessageUtils.packageMessage(downTransportMessage, (short)-1, mobile);

			//		Message defaultMessage = MessageUtils.getWebDefaultMessage(responseUnableTraining, (short)0x8502, mobile, deviceNum, "设置禁用状态");
			result = tcpClientService.sendToTCPServer(packageMessage);
		}else{
			result.error("没有绑定手机号");
		}
		return result;
	}

	@RequestMapping(value="/queryTimeTerminalParams",method=RequestMethod.POST)
	public Result queryTimeTerminalParams(HttpServletRequest request){
		String deviceNum=(String) request.getSession().getAttribute("deviceNum");
		String mobile=(String) request.getSession().getAttribute("mobile");
		Result result = new Result();
		if(!"".equals(mobile)){
			tcpClientService.getDataListener = this;

			Message downTransportMessage = MessageUtils.getDownTransportMessage(null, (short)0x8503, JSPTConstants.JSPT_PLATFORMNO_BCD, deviceNum);
			Message packageMessage = MessageUtils.packageMessage(downTransportMessage, (short)-1, mobile);

			//		Message defaultMessage = MessageUtils.getWebDefaultMessage(null, (short)0x88503, mobile, deviceNum,"查询计时终端参数");
			result = tcpClientService.sendToTCPServer(packageMessage);
		}else{
			result.error("没有绑定手机号");
		}
		return result;
	}

	@RequestMapping(value="/tcpmessage",method=RequestMethod.POST)
	public Result tcpMessage(HttpServletRequest request){
		String deviceNum=(String) request.getSession().getAttribute("deviceNum");
		String mobile=(String) request.getSession().getAttribute("mobile");
		tcpClientService.getDataListener = this;

		String content=WebUtils.getParameterValue(request, "content");
		byte[] req = HexUtils.HexStringToBinary(content);
		ByteBuf message = Unpooled.buffer(req.length);
		message.writeBytes(req);
		byte[] req2 = new byte[message.readableBytes()];
		message.readBytes(req2);
		Message decodeMessage = MessageUtils.decodeMessage(req2);

		MessageModel messageModel = new MessageModel();	//使用适合解析的新message对象以便可以通过json传到网页
		messageModel.setMessageIdHexString(Integer.toHexString(decodeMessage.getHeader().getId()));

		byte[] body = decodeMessage.getBody();

		short messageId = decodeMessage.getHeader().getId();
		switch (messageId){	//判断是普通消息还是透传消息
			case (short)0x0900:	//透传消息
				UpTransportMessageBody upTransportMessageBody = new UpTransportMessageBody(body);
				ExtendMessageBody extendMessageBody = upTransportMessageBody.getExtendMessageBody();
			switch(extendMessageBody.getTransportId()){
				case (short)0x0101:	//上报教练员登录
					LoginCoach loginCoach = (LoginCoach)extendMessageBody.getData();
					messageModel.setBody(loginCoach);
					logger.info("0x0101 上报教练员登录");
					break;
				case (short)0x0102:	//上报教练员登出
					LogoutCoach logoutCoach = (LogoutCoach)extendMessageBody.getData();
					logger.info("0x0102 上报教练员登出");
					System.out.println("0x0102: "+logoutCoach.toString());
					messageModel.setBody(logoutCoach);
					break;
				case (short)0x0201:	//上报学员登录
					LoginStudent loginStudent = (LoginStudent)extendMessageBody.getData();
					logger.info("0x0201 上报学员登录");
					System.out.println("0x0201 : "+loginStudent.toString());
					messageModel.setBody(loginStudent);
					break;
				case (short)0x0202:	//上报学员登出
					LogoutStudent logoutStudent = (LogoutStudent)extendMessageBody.getData();
					logger.info("0x0202 上报学员登出");
					System.out.println("0x0202 : "+logoutStudent.toString());
					messageModel.setBody(logoutStudent);
					break;
				case (short)0x0203:	//上报学时
					StudyingTime studyingTime = (StudyingTime) extendMessageBody.getData();
					logger.info("0x0203 上报学时");
					System.out.println("0x0203 : "+studyingTime.toString());
					messageModel.setBody(studyingTime);
					break;
				case (short)0x0205:	//命令上报学时
					StudyingTimeOrder studyingTimeOrder = (StudyingTimeOrder) extendMessageBody.getData();
					logger.info("0x0205 命令上报学时");
					String[] strings = {"","查询的记录正在上传","SD卡没有找到","执行成功，但无指定记录","执行成功，稍候上报查询结果"};
					System.out.println("0x0205 : "+studyingTimeOrder.getResultCode()+strings[studyingTimeOrder.getResultCode()]);
					messageModel.setBody(studyingTimeOrder);
					break;
				case (short)0x0301:	//立即拍照
					System.out.println("0x0301 立即拍照");
					PhotoImmediately photoImmediately = (PhotoImmediately) extendMessageBody.getData();
					System.out.println("0x0301 : "+photoImmediately.toString());
					messageModel.setBody(photoImmediately);
					break;
				case (short)0x0302:	//查询照片
					System.out.println("0x0302 查询照片");
					PhotoQuery photoQuery = (PhotoQuery) extendMessageBody.getData();
					System.out.println("0x0302 : "+photoQuery.toString());
					messageModel.setBody(photoQuery);
					break;
				case (short)0x0303:	//上报照片查询结果
					System.out.println("0x0303 上报照片查询结果");
					PhotoUpQuery photoUpQuery = (PhotoUpQuery) extendMessageBody.getData();
					System.out.println("0x0303 : "+photoUpQuery.toString());
					System.out.println("0x0303 : "+photoUpQuery.getParamList().toString());
					messageModel.setBody(photoUpQuery);
					break;
				case (short)0x0304:	//上传指定照片
					System.out.println("0x0304 上传指定照片");
					PhotoUploadCertain photoUploadCertain = (PhotoUploadCertain) extendMessageBody.getData();
					String[] strings1 = {"找到照片，稍候上传","没有该照片"};
					System.out.println("0x0304 getResultCode: "+photoUploadCertain.getResultCode()+strings1[photoUploadCertain.getResultCode()]);
					messageModel.setBody(photoUploadCertain);
					break;
				case (short)0x0305:	//照片上传初始化
					System.out.println("0x0305 照片上传初始化");
					PhotoUploadInit photoUploadInit = (PhotoUploadInit) extendMessageBody.getData();
					System.out.println("0x0305 : "+photoUploadInit.toString());
					messageModel.setBody(photoUploadInit);
					break;
				case (short)0x0306:	//上传照片数据包
					System.out.println("0x0306 上传照片数据包");
					PhotoFileUpload photoFileUpload = (PhotoFileUpload) extendMessageBody.getData();
					System.out.println("0x0306 getPhotoNum: "+photoFileUpload.getPhotoNum());
					System.out.println("0x0306 getAbsolutePath: "+photoFileUpload.getFile().getAbsolutePath());
					messageModel.setBody(photoFileUpload);
					break;
				case (short)0x0501:	//设置计时终端应用参数
					System.out.println("0x0501 设置计时终端应用参数");
					TimeTerminalSetParam timeTerminalSetParam = (TimeTerminalSetParam) extendMessageBody.getData();
					System.out.println("0x0501 getResultCode: "+timeTerminalSetParam.getResultCode());
					messageModel.setBody(timeTerminalSetParam);
					break;
				case (short)0x0502:	//设置禁训状态
					System.out.println("0x0502 设置禁训状态");
					UnableTraining unableTraining = (UnableTraining) extendMessageBody.getData();
					System.out.println("0x0502 : "+unableTraining.toString());
					messageModel.setBody(unableTraining);
					break;
				case (short)0x0503:	//查询计时终端应用参数
					System.out.println("0x0503 查询计时终端应用参数");
					TimeTerminalQueryParam timeTerminalQueryParam = (TimeTerminalQueryParam) extendMessageBody.getData();
					System.out.println("0x0503 : "+timeTerminalQueryParam.toString());
					messageModel.setBody(timeTerminalQueryParam);
					break;
				}
				break;
			case (short)0x0200:	//位置信息汇报
					System.out.println("0x0200 位置信息汇报");
				LocationInfo locationInfo = new LocationInfo(body);
				messageModel.setBody(locationInfo);
				break;
			case (short)0X81F0:	//登录应答
				System.out.println("0X81F0 登录应答");
				PhotoUploadCertain photoUploadCertain = new PhotoUploadCertain(body);
				messageModel.setBody(photoUploadCertain);
				break;
			case (short)0x0104:	//查询终端参数应答
				System.out.println("0x0104 查询终端参数应答");
				ResponseTerminalQuery terminal = new ResponseTerminalQuery(body);
				messageModel.setBody(terminal);
				break;
			case (short)0x8100:	//注册应答
				System.out.println("0x8100 注册应答");
				Register register = new Register(body);
				messageModel.setBody(register);
				break;
		}

		String json = binder.toJson(messageModel);
		NotificationMessage notificationMessage = new NotificationMessage();
		notificationMessage.setContent(json);
		notificationMessage.setInscode("5851633716061642");
		notificationMessage.setCreatetime(new Date());

		RecordChangeMsgController.notificationMessage = notificationMessage;

		RecordChangeMsgController.isSend = 1;

		service.addMesage(notificationMessage);

		Result result = new Result();
		return result;
	}

	public boolean didGetData(Object object){
		try{
			Message message = (Message)object;
			tcpClientService.sentToWeb("5851633716061642",message);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}
}
