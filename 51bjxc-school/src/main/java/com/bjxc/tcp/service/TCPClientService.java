package com.bjxc.tcp.service;

import java.net.URLEncoder;
import java.util.Date;
import java.util.Map;

import javax.servlet.ServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bjxc.Result;
import com.bjxc.json.JacksonBinder;
import com.bjxc.school.LocationInfo2;
import com.bjxc.school.NotificationMessage;
import com.bjxc.school.WebPhoto;
import com.bjxc.school.service.HttpClientService;
import com.bjxc.school.socket.RecordChangeMsgController;
import com.bjxc.tcp.model.*;
import com.bjxc.tcp.client.TCPClient;
import com.bjxc.tcp.client.TCPClientHandler.FinishGetDataListener;
import com.bjxc.tcp.controller.TCPClientController;
import com.bjxc.tcp.netty.HexUtils;
import com.bjxc.tcp.netty.Message;
import com.bjxc.tcp.netty.MessageUtils;
import com.bjxc.web.utils.WebUtils;

import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;

@Service
public class TCPClientService implements FinishGetDataListener {
	private static final Logger logger = LoggerFactory.getLogger(TCPClientService.class);
	private static JacksonBinder binder = JacksonBinder.buildNormalBinder();

	@Autowired
	private HttpClientService httpClientService;

	@Value("${bjxc.message.server}")
	private String messageServer;

	@Value("${bjxc.tcp.host}")
	private String tcpServerHost;

	@Value("${bjxc.tcp.port}")
	private Integer tcpServerPort;

	public interface ServiceGetDataListener {
		public boolean didGetData(Object object);
	}

	public ServiceGetDataListener getDataListener;

	public Result sendToTCPServer(Object msg) {
		Result result = new Result();
		TCPClientThread thread = new TCPClientThread(this, msg);
		thread.start();
		return result;
	}

	private class TCPClientThread extends Thread {
		public TCPClientThread(FinishGetDataListener listener, Object msg) {
			this.listener = listener;
			this.msg = msg;
		}

		private FinishGetDataListener listener;
		private Object msg;

		public void run() {
			try {
				TCPClient client = new TCPClient(listener, msg, tcpServerHost, tcpServerPort.intValue());
				client.handlerCallBack = listener;
				client.start();
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}

		}
	}

	public boolean didGetData(Message message) {
		try {
			if (getDataListener != null) {

				getDataListener.didGetData(message);

			}

			//
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		return true;
	}

	public void sentToWeb(String inscode, Message message) {
		try {
			// 要根据不同的消息ID进行不同界面的处理
			String tcpmsg = tcpMessage(message);
			httpClientService.doGet(messageServer +"/message?inscode=" + inscode +"&content=" + URLEncoder.encode(tcpmsg, "UTF-8"));
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}

	}
	
	/**
	 * 处理接收回来的消息区别展示
	 * @param content
	 * @return
	 */
	private String tcpMessage(Message  message){

		
		MessageModel messageModel = new MessageModel();	//使用适合解析的新message对象以便可以通过json传到网页
		messageModel.setMessageIdHexString(Integer.toHexString(message.getHeader().getId()));

		byte[] body = message.getBody();

		short messageId = message.getHeader().getId();
		
		logger.info("messageId"+Integer.toHexString(messageId));
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
						logger.info("0x0102: "+logoutCoach.toString());
						messageModel.setBody(logoutCoach);
						break;
					case (short)0x0201:	//上报学员登录
						LoginStudent loginStudent = (LoginStudent)extendMessageBody.getData();
						logger.info("0x0201 上报学员登录");
						logger.info("0x0201 : "+loginStudent.toString());
						messageModel.setBody(loginStudent);
						break;
					case (short)0x0202:	//上报学员登出
						LogoutStudent logoutStudent = (LogoutStudent)extendMessageBody.getData();
						logger.info("0x0202 上报学员登出");
						logger.info("0x0202 : "+logoutStudent.toString());
						messageModel.setBody(logoutStudent);
						break;
					case (short)0x0203:	//上报学时
						StudyingTime studyingTime = (StudyingTime) extendMessageBody.getData();
						logger.info("0x0203 上报学时");
						logger.info("0x0203 : "+studyingTime.toString());
						messageModel.setBody(studyingTime);
						break;
					case (short)0x0205:	//命令上报学时
						StudyingTimeOrder studyingTimeOrder = (StudyingTimeOrder) extendMessageBody.getData();
						logger.info("0x0205 命令上报学时");
						String[] strings = {"","查询的记录正在上传","SD卡没有找到","执行成功，但无指定记录","执行成功，稍候上报查询结果"};
						logger.info("0x0205 : "+studyingTimeOrder.getResultCode()+strings[studyingTimeOrder.getResultCode()]);
						messageModel.setBody(studyingTimeOrder);
						break;
					case (short)0x0301:	//立即拍照
						logger.info("0x0301 立即拍照");
						PhotoImmediately photoImmediately = (PhotoImmediately) extendMessageBody.getData();
						logger.info("0x0301 : "+photoImmediately.toString());
						messageModel.setBody(photoImmediately);
						break;
					case (short)0x0302:	//查询照片
						logger.info("0x0302 查询照片");
						PhotoQuery photoQuery = (PhotoQuery) extendMessageBody.getData();
						logger.info("0x0302 : "+photoQuery.toString());
						messageModel.setBody(photoQuery);
						break;
					case (short)0x0303:	//上报照片查询结果
						logger.info("0x0303 上报照片查询结果");
						PhotoUpQuery photoUpQuery = (PhotoUpQuery) extendMessageBody.getData();
						logger.info("0x0303 : "+photoUpQuery.toString());
						logger.info("0x0303 : "+photoUpQuery.getParamList().toString());
						messageModel.setBody(photoUpQuery);
						break;
					case (short)0x0304:	//上传指定照片
						logger.info("0x0304 上传指定照片");
						PhotoUploadCertain photoUploadCertain = (PhotoUploadCertain) extendMessageBody.getData();
						String[] strings1 = {"找到照片，稍候上传","没有该照片"};
						logger.info("0x0304 getResultCode: "+photoUploadCertain.getResultCode()+strings1[photoUploadCertain.getResultCode()]);
						messageModel.setBody(photoUploadCertain);
						break;
					case (short)0x0305:	//照片上传初始化
						logger.info("0x0305 照片上传初始化");
						PhotoUploadInit photoUploadInit = (PhotoUploadInit) extendMessageBody.getData();
						logger.info("0x0305 : "+photoUploadInit.toString());
						messageModel.setBody(photoUploadInit);
						break;
					case (short)0x0306:	//上传照片数据包
						logger.info("0x0306 上传照片数据包");
						PhotoFileUpload photoFileUpload = (PhotoFileUpload) extendMessageBody.getData();
						logger.info("0x0306 getPhotoNum: "+photoFileUpload.getPhotoNum());
						logger.info("0x0306 getAbsolutePath: "+photoFileUpload.getFile().getAbsolutePath());
						messageModel.setBody(photoFileUpload);
						break;
					case (short)0x0501:	//设置计时终端应用参数
						logger.info("0x0501 设置计时终端应用参数");
						TimeTerminalSetParam timeTerminalSetParam = (TimeTerminalSetParam) extendMessageBody.getData();
						logger.info("0x0501 getResultCode: "+timeTerminalSetParam.getResultCode());
						messageModel.setBody(timeTerminalSetParam);
						break;
					case (short)0x0502:	//设置禁训状态
						logger.info("0x0502 设置禁训状态");
						UnableTraining unableTraining = (UnableTraining) extendMessageBody.getData();
						logger.info("0x0502 : "+unableTraining.toString());
						messageModel.setBody(unableTraining);
						break;
					case (short)0x0503:	//查询计时终端应用参数
						logger.info("0x0503 查询计时终端应用参数");
						TimeTerminalQueryParam timeTerminalQueryParam = (TimeTerminalQueryParam) extendMessageBody.getData();
						logger.info("0x0503 : "+timeTerminalQueryParam.toString());
						messageModel.setBody(timeTerminalQueryParam);
						break;
				}
				break;
			case (short)0x0200:	//位置信息汇报
				logger.info("0x0200 位置信息汇报");
				LocationInfo locationInfo = new LocationInfo(body);
				messageModel.setBody(locationInfo);
				break;
			case (short)0X81F0:	//登录应答
				logger.info("0X81F0 登录应答");
				PhotoUploadCertain photoUploadCertain = new PhotoUploadCertain(body);
				messageModel.setBody(photoUploadCertain);
				break;
			case (short)0x0104:	//查询终端参数应答
				logger.info("0x0104 查询终端参数应答");
				ResponseTerminalQuery terminal = new ResponseTerminalQuery(body);
				messageModel.setBody(terminal);
				break;
			case (short)0x8100:	//注册应答
				logger.info("0x8100 注册应答");
				Register register = new Register(body);
				messageModel.setBody(register);
				break;
			case (short)0x0102:	//鉴权
				logger.info("0x0102终端鉴权");
				return message.getHeader().getMobile()+" 上线";
			case (short)-2:	//经处理的位置信息汇报
				logger.info("-2 经处理的位置信息汇报");
				LocationInfo2 locationInfo2 = new LocationInfo2(body);
				messageModel.setBody(locationInfo2);
				break;
			case (short)-3:	//立即拍照返回链接
				logger.info("-3 立即拍照返回链接");
				WebPhoto webPhoto = new WebPhoto(body);
				messageModel.setBody(webPhoto);
				break;
		}

		String json = binder.toJson(messageModel);
		logger.info(json);
		
		return json;
	}

}
