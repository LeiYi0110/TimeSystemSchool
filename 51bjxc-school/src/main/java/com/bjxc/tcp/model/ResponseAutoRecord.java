package com.bjxc.tcp.model;

import java.io.UnsupportedEncodingException;

import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;

/**
 * 查询终端参数应答消息体数据格式
 * 
 * 消息ID：-2。
 * 查询终端参数应答消息体数据格式见表B.19。
 * @author dev
 *
 */
public class ResponseAutoRecord  extends TransportObject{

	private String StudentNum;
	private String coachNum;
	private int count;
	
	@Override
	public byte[] getBytes() {
		ByteBuf buffer = Unpooled.buffer();
		try{
			buffer.writeBytes(StudentNum.getBytes("GBK"));
			buffer.writeBytes(coachNum.getBytes("GBK"));
			buffer.writeInt(count);
		}catch(Exception e){
			
		}
		
		byte[] result = new byte[buffer.readableBytes()];
		buffer.readBytes(result);
		return result;
	}

	public String getStudentNum() {
		return StudentNum;
	}

	public void setStudentNum(String studentNum) {
		StudentNum = studentNum;
	}

	public String getCoachNum() {
		return coachNum;
	}

	public void setCoachNum(String coachNum) {
		this.coachNum = coachNum;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	
}
