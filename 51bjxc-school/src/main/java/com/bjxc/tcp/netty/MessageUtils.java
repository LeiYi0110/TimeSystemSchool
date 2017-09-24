package com.bjxc.tcp.netty;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

import com.bjxc.tcp.model.DownTransportMessageBody;
import com.bjxc.tcp.model.ExtendMessageBody;
import com.bjxc.tcp.model.IBytes;
import com.bjxc.tcp.model.TransportObject;
import com.bjxc.tcp.model.UpTransportMessageBody;

//import antlr.collections.List;
import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;

public class MessageUtils {

	public static short number = 0;
	public static short id = 1;
	

	public static synchronized short getCurrentMessageId(){
		return id++;
	}

	
	public static synchronized short getCurrentMessageNumber(){
		return number++;
	}
	


	/**
	 * 娑撳秵鏁幐锟�
	 * @param ctx
	 * @param number
	 * @param id
	 * @return
	 */
	public static Message notFountMessage(short id ,short number, String mobile){
		//return createDefaultMessage(id,number,(byte)3);
		return createDefaultMessage(number,id,(byte)3,mobile);
	}
	
	/**
	 * 閺堝鏁婄拠锟�
	 * @param ctx
	 * @param number
	 * @param id
	 * @return
	 */
	public static Message errorMessage(short id ,short number,String mobile){
		//return createDefaultMessage(id,number,(byte)2);
		return createDefaultMessage(number,id,(byte)2,mobile);
	}
	
	/**
	 * 婢跺嫮鎮婃径杈Е
	 * @param ctx
	 * @param number
	 * @param id
	 * @return
	 */
	public static Message failMessage(short id ,short number,String mobile){
		//return createDefaultMessage(id,number,(byte)1);
		return createDefaultMessage(number,id,(byte)1,mobile);
	}
	
	/**
	 * 婢跺嫮鎮婇幋鎰
	 * @param ctx
	 * @param number
	 * @param id
	 * @return
	 */
	public static Message successMessage(short id ,short number,String mobile){
		//return createDefaultMessage(id,number,(byte)0);
		return createDefaultMessage(number,id,(byte)0,mobile);
	}
	
	public static Message createDefaultMessage(short number,short id ,byte result,String mobile){
		Message message = new Message();
		message.getHeader().setNumber(MessageUtils.getCurrentMessageNumber());
		//message.getHeader().setId(MessageUtils.getCurrentMessageId());
		message.getHeader().setId((short)0x8001);
		message.getHeader().setMobile(mobile);
		ByteBuf hbuf = Unpooled.buffer();
		hbuf.writeShort(number);
		hbuf.writeShort(id);
		hbuf.writeByte(result);
		byte[] body = new byte[hbuf.readableBytes()];
		hbuf.readBytes(body);
		message.setBody(body);
		return message;
	}
	
	
	
	public static List<Message> dividePackage(Message message)
	{
		List<Message> list = new ArrayList<Message>();
		
		short messageBodyMaxLength = (short)(Message.maxLength - Header.maxLength - 200);
		int packageCount = message.getBody().length/messageBodyMaxLength + 1;
		
		ByteBuf hbuf = Unpooled.copiedBuffer(message.getBody());
		
		for(int i = 0; i < packageCount; i++)
		{
			Message divideMessage = new Message();
			Header header = new Header();
			header.setId(message.getHeader().getId());
			
			header.setMobile(message.getHeader().getMobile());
			header.setNumber(message.getHeader().getNumber());
			header.setPackageSize((short)packageCount);
			header.setPackageIndex((short)(i + 1));
			header.setSubPackage(true);
			
			
			
			
			
			int bodyLength = messageBodyMaxLength;
			
			if (i == packageCount - 1) {
				bodyLength = message.getBody().length - i*messageBodyMaxLength;
			}
			
			byte[] body = new byte[bodyLength];
			
			hbuf.readBytes(body);
			
			header.setProperty((short)(bodyLength + (short)Math.pow(2, 13)));
			
			divideMessage.setHeader(header);
			divideMessage.setBody(body);
			
			list.add(divideMessage);
			
			
		}
		
		return list;
	}
	
	public static Message unionPackage(List<Message> list)
	{
		Header header = new Header();
		Message message = list.get(0);
		header.setId(message.getHeader().getId());
		
		header.setMobile(message.getHeader().getMobile());
		header.setNumber(message.getHeader().getNumber());
		
		//int bodySize = 0;
		Collections.sort(list);
		ByteBuf bodybuf = Unpooled.buffer();
		for(Message item : list)
		{
			//bodySize += item.getHeader().getPackageSize();
			
			
			bodybuf.writeBytes(item.getBody());
		}
		
		byte[] body = new byte[bodybuf.readableBytes()];
		
		bodybuf.readBytes(body);
		
		Message resultMessage = new Message();
		resultMessage.setHeader(header);
		resultMessage.setBody(body);
		
		return resultMessage;
	
		/*
		List<Message> list = new ArrayList<Message>();
		
		short messageBodyMaxLength = (short)(Message.maxLength - Header.maxLength);
		int packageCount = message.getBody().length/messageBodyMaxLength + 1;
		
		ByteBuf hbuf = Unpooled.copiedBuffer(message.getBody());
		
		for(int i = 0; i < packageCount; i++)
		{
			Message divideMessage = new Message();
			Header header = new Header();
			header.setId(message.getHeader().getId());
			
			header.setMobile(message.getHeader().getMobile());
			header.setNumber(message.getHeader().getNumber());
			header.setPackageSize((short)packageCount);
			header.setPackageIndex((short)(i + 1));
			header.setSubPackage(true);
			
			
			
			
			
			int bodyLength = messageBodyMaxLength;
			
			if (i == packageCount - 1) {
				bodyLength = message.getBody().length - i*messageBodyMaxLength;
			}
			
			byte[] body = new byte[bodyLength];
			
			hbuf.readBytes(body);
			
			header.setProperty((short)(bodyLength + (short)Math.pow(2, 12)));
			
			divideMessage.setHeader(header);
			divideMessage.setBody(body);
			
			list.add(divideMessage);
			
			
		}
		
		return list;
		*/
	}

	public static Message decodeMessage(byte[] msg){
		ByteBuf buf = Unpooled.buffer();
		buf.writeBytes(msg);
		Message  message = new Message();
		Header	header = new Header();
		message.setHeader(header);

		header.setVersion(buf.readByte());

		header.setId(buf.readShort());
		//璁剧疆娑堟伅浣撳睘鎬�
		short property = buf.readShort();
		setProerty(header,property);

		byte[] mobileBytes = new byte[8];
		buf.readBytes(mobileBytes);
//		System.out.println(HexUtils.bcd2Str(mobileBytes).length());
//		System.out.println(HexUtils.bcd2Str(mobileBytes));
		header.setMobile(HexUtils.bcd2Str(mobileBytes));
		//header.setMobile(buf.readLong());
		header.setNumber(buf.readShort());

		header.setBackup(buf.readByte());
		if(header.isSubPackage()){
			//鏈夊垎鍖呬俊鎭紝鎵嶈鍙栨秷鎭殑鍒嗗寘椤�
			header.setPackageSize(buf.readShort());
			header.setPackageIndex(buf.readShort());
		}

		byte[] body = new byte[buf.readableBytes()];
		buf.readBytes(body);
		message.setBody(body);

		System.out.println("getNumber:"+message.getHeader().getNumber());
		try {
			System.out.println("getBodyToString"+message.getBodyToString());
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return message;
	}

	private static void setProerty(Header header,short property){
		header.setProperty(property);
		short a = 1 << 13;
		//short a = 1 << 12;
		if((property & a) == a){
			//娑堟伅鏈夊垎鍖�
			//瑙ｉ噴娑堟伅鍖呭皝鐘堕」
			header.setSubPackage(true);
		}
		//鍔犲瘑鏂瑰紡
		//0x400 : 10000000000
		//0x1c00 : 1110000000000
		if((property & 0x400) == 0x400){
			//閲囩敤浜哛SA鍔犲瘑
			header.setEncrypt("RSA");
		}else if((property & 0x1c00) == 0){
			//娌℃湁缂栫爜
			header.setEncrypt(null);
		}
		//1023 111111111
		short length = (short)(property & 1023);
		//short length = (short)(property - a);
		header.setLength(length);



	}
	
	public static Message getWebDefaultMessage(TransportObject data,short transportId,String mobile,String deviceNO,String checkString){
		ExtendMessageBody extendMessageBody = new ExtendMessageBody();
		extendMessageBody.setTransportId(transportId);
		extendMessageBody.setExtendMessageProperty((short)0);
		extendMessageBody.setSeq((short)1);
		extendMessageBody.setDeviceNo(deviceNO);
		extendMessageBody.setData(data);
		
		UpTransportMessageBody upTransportMessageBody = new UpTransportMessageBody();
		upTransportMessageBody.setExtendMessageBody(extendMessageBody);
		  
		Header header = new Header();
		header.setId((short)-1);
		header.setMobile(mobile);
		header.setNumber(MessageUtils.getCurrentMessageNumber());
		
		Message message = new Message();
		message.setHeader(header);
		message.setBody(upTransportMessageBody.getBytes());
		
		return message;
	}
	
	public static Message getDefaultMessage(short messageId,IBytes body,String mobile){
		Header header = new Header();
		header.setId(messageId);
		header.setMobile(mobile);
		header.setNumber(MessageUtils.getCurrentMessageNumber());
		Message message = new Message();
		message.setHeader(header);
		if(body!=null){
			message.setBody(body.getBytes());
		}
		return message;
	}


	public static byte[] getInt2byte(int data){
		ByteBuf buffer = Unpooled.buffer();
		buffer.writeInt(data);
		byte[] result = new byte[buffer.readableBytes()];
		buffer.readBytes(result);
		return result;
	}
	
	public static byte[] getShort2byte(short data){
		ByteBuf buffer = Unpooled.buffer();
		buffer.writeShort(data);
		byte[] result = new byte[buffer.readableBytes()];
		buffer.readBytes(result);
		return result;
	}
	
	public static byte[] getString2byte(String data){
		ByteBuf buffer = Unpooled.buffer();
		try {
			buffer.writeBytes(data.getBytes("GBK"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		byte[] result = new byte[buffer.readableBytes()];
		buffer.readBytes(result);
		return result;
	}
	
	public static Integer getByte2Int(byte[] bytes){
		ByteBuf copiedBuffer = Unpooled.copiedBuffer(bytes);
		return copiedBuffer.readInt();
	}
	
	public static Short getByte2Short(byte[] bytes){
		ByteBuf copiedBuffer = Unpooled.copiedBuffer(bytes);
		return copiedBuffer.readShort();
	}

	public static String getByte2String(byte[] bytes){
		String string = "";
		try {
			string = new String(bytes, "GBK");
		}catch (Exception e){
			e.printStackTrace();
		}
		return string;
	}
	

	/**
	 * 获取普通Message
	 * @param data
	 * @param messageId
	 * @param mobile
	 * @return
	 */
	public static Message getCommonMessage(IBytes data,short messageId,String mobile) {
		Message message = new Message();
		message.setHeader(getHeader(messageId, mobile));
		if(data!=null){
			message.setBody(data.getBytes());
		}
		return message;
	}

	/**
	 * 获取下行透传Message
	 * @param data
	 * @param transportId
	 * @param mobile
	 * @return
	 */
	public static Message getDownTransportMessage(TransportObject data,short transportId,String mobile,String deviceNo){
		ExtendMessageBody extendMessageBody = new ExtendMessageBody();
		extendMessageBody.setTransportId(transportId);
		extendMessageBody.setExtendMessageProperty((short)0);
		extendMessageBody.setSeq((short)1);	//TODO:驾培包序号,从1开始，除协议中特别声明外，循环递增
		extendMessageBody.setDeviceNo(deviceNo);
		extendMessageBody.setData(data);
		
		DownTransportMessageBody downTransportMessageBody = new DownTransportMessageBody();
		downTransportMessageBody.setExtendMessageBody(extendMessageBody);
		
		Message message = new Message();
		message.setHeader(getHeader((short)0x8900,mobile));
		message.setBody(downTransportMessageBody.getBytes());
		return message;
	}
	
	/**
	 * 获取上行透传Message
	 * @param data
	 * @param transportId
	 * @param mobile
	 * @return
	 */
	public static Message getUpTransportMessage(TransportObject data,short transportId,String mobile,String deviceNo){
		ExtendMessageBody extendMessageBody = new ExtendMessageBody();
		extendMessageBody.setTransportId(transportId);
		extendMessageBody.setExtendMessageProperty((short)0);
		extendMessageBody.setSeq((short)1);	//TODO:驾培包序号,从1开始，除协议中特别声明外，循环递增
		extendMessageBody.setDeviceNo(deviceNo);
		extendMessageBody.setData(data);
		
		DownTransportMessageBody downTransportMessageBody = new DownTransportMessageBody();
		downTransportMessageBody.setExtendMessageBody(extendMessageBody);
		
		Message message = new Message();
		message.setHeader(getHeader((short)0x0900,mobile));
		message.setBody(downTransportMessageBody.getBytes());
		return message;
	}
	
	/**
	 * 把Message作为body再封装进消息里面，以便发送到特定Action进行直接转发处理，
	 * 其中外层消息除header中的id外没有什么意义（mobile也可用于查找通道）
	 * @param data
	 * @return
	 */
	public static Message packageMessage(Message message,Short messageId,String mobile){
		Header header = new Header();
		header.setId(messageId);
		header.setMobile(mobile);
		header.setNumber((short)1);
		
		Message newMessage = new Message();
		newMessage.setHeader(header);
		if(message!=null){
			newMessage.setBody(message.getBytes());
		}
		return newMessage;
	}
	
	
	/**
	 * 获取header
	 * @param messageId
	 * @param mobile
	 * @return
	 */
	public static Header getHeader(short messageId, String mobile) {
		Header header = new Header();
		header.setId(messageId);
		header.setMobile(mobile);
		header.setNumber(MessageUtils.getCurrentMessageNumber());
		return header;
	}
}
