package com.bjxc.tcp.model;

import java.io.UnsupportedEncodingException;

import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;

public class Register implements IBytes{
	private short serialNum;	//应答流水号	WORD	对应的终端注册消息的流水号
	private byte result;	//结果	BYTE	0：成功；1：车辆已被注册；2：数据库中无该车辆；3：终端已被注册；4：数据库中无该终端。只有在成功后才返回以下内容
	private String platformNum;	//平台编号	BYTE[5]	统一编号
	private String institutionNum;	//培训机构编号	BYTE[16]	统一编号
	private String terminalNum;	//计时终端编号	BYTE[16]	统一编号
	private String certPassword;	//证书口令	BYTE[12]	终端证书口令
	private String cert;	//终端证书	STRING	由计时平台向全国驾培平台申请
	
	@Override
	public byte[] getBytes() {
		ByteBuf buffer = Unpooled.buffer();
		buffer.writeShort(serialNum);
		buffer.writeByte(result);
		try {
			buffer.writeBytes(platformNum.getBytes("GBK"));
			buffer.writeBytes(institutionNum.getBytes("GBK"));
			buffer.writeBytes(terminalNum.getBytes("GBK"));
			buffer.writeBytes(certPassword.getBytes("GBK"));
			buffer.writeBytes(cert.getBytes("GBK"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		byte[] bytes = new byte[buffer.readableBytes()];
		buffer.readBytes(bytes);
		return bytes;
	}

	public Register(byte[] bytes) {
		ByteBuf copiedBuffer = Unpooled.copiedBuffer(bytes);
		serialNum = copiedBuffer.readShort();
		result = copiedBuffer.readByte();
		byte[] platformNumBytes = new byte[5];
		copiedBuffer.readBytes(platformNumBytes);
		byte[] institutionNumBytes = new byte[16];
		copiedBuffer.readBytes(institutionNumBytes);
		byte[] terminalNumBytes = new byte[16];
		copiedBuffer.readBytes(terminalNumBytes);
		byte[] certPasswordBytes = new byte[12];
		copiedBuffer.readBytes(certPasswordBytes);
		byte[] certBytes = new byte[copiedBuffer.readableBytes()];
		copiedBuffer.readBytes(certBytes);
		try {
			platformNum = new String(platformNumBytes,"GBK");
			institutionNum = new String(institutionNumBytes,"GBK");
			terminalNum = new String(terminalNumBytes,"GBK");
			certPassword = new String(certPasswordBytes,"GBK");
			cert = new String(certBytes,"GBK");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}
	
	public Register() {
		super();
	}
	public short getSerialNum() {
		return serialNum;
	}
	public void setSerialNum(short serialNum) {
		this.serialNum = serialNum;
	}
	public byte getResult() {
		return result;
	}
	public void setResult(byte result) {
		this.result = result;
	}
	public String getPlatformNum() {
		return platformNum;
	}
	public void setPlatformNum(String platformNum) {
		this.platformNum = platformNum;
	}
	public String getInstitutionNum() {
		return institutionNum;
	}
	public void setInstitutionNum(String institutionNum) {
		this.institutionNum = institutionNum;
	}
	public String getTerminalNum() {
		return terminalNum;
	}
	public void setTerminalNum(String terminalNum) {
		this.terminalNum = terminalNum;
	}
	public String getCertPassword() {
		return certPassword;
	}
	public void setCertPassword(String certPassword) {
		this.certPassword = certPassword;
	}
	public String getCert() {
		return cert;
	}
	public void setCert(String cert) {
		this.cert = cert;
	}
}
