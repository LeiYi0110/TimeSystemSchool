package com.bjxc.tcp.netty;

import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.ByteToMessageDecoder;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MessageDecoder extends ByteToMessageDecoder {
	private static final Logger logger = LoggerFactory.getLogger(MessageDecoder.class);
	@Override
	protected void decode(ChannelHandlerContext ctx, ByteBuf buf,
			List<Object> out) throws Exception {
		if(buf.readableBytes() <1){
			return;
		}
		byte[] req = new byte[buf.readableBytes()];
	
		buf.readBytes(req);
		
		byte[] tranReq = transferred(req);
		
		if(validate(tranReq)){
			byte[] newReq = this.trime(tranReq);
			Message message = this.decodeMessage(newReq);
			out.add(message);
		}
	}
	
	/**
	 * 鐏忓棙绉烽幁顖欑秼鏉╂稖顢戞潪顒佸床
	 * @param msg
	 * @return
	 */
	private byte[] transferred(byte[] msg){

		//鏉烆兛绠熸潻妯哄斧
		ByteBuf tranBuf = Unpooled.buffer();
		for(int i=0;i < msg.length;i++ ){
			byte vl = msg[i];
			if(vl == 0x7d){
				byte afvl = msg[i+1];
				if(afvl == 0x02){
					tranBuf.writeByte(0x7e);
					i++;
				}else if(afvl == 0x01){
					tranBuf.writeByte(0x7d);
					i++;
				}else{
					tranBuf.writeByte(vl);
				}
			}else{
				tranBuf.writeByte(vl);
			}
		}

		byte[] tranReq = new byte[tranBuf.readableBytes()];
		tranBuf.readBytes(tranReq);
		return tranReq;
	}
	
	/**
	 * 鏉堝啴鐛欏☉鍫熶紖
	 * @param msg
	 * @return
	 */
	private boolean validate(byte[] msg){
		byte check = msg[msg.length-1];
		byte bcheck = msg[0];
		for(int i=1;i < msg.length-1;i++ ){
			byte bv = msg[i];
			bcheck = (byte) (bcheck ^ bv);
		}
		if(bcheck != check){
			logger.warn("check byte not equal!!!");
			return false;
		}
		return true;
	}
	
	/**
	 * 缁夎骞撻弽锟犵崣閻礁鐡ч懞鍌︾礉閻㈢喐鍨氶崣顏呮箒濞戝牊浼呮径杈剧礉濞戝牊浼呮担鎾舵畱byte閺佹壆绮�
	 * @param msg
	 * @return
	 */
	private byte[] trime(byte[] msg){
		ByteBuf newBuf = Unpooled.buffer();
		for(int i=0;i < msg.length-1;i++ ){
			newBuf.writeByte(msg[i]);
		}
		byte[] newReq = new byte[newBuf.readableBytes()];
		newBuf.readBytes(newReq);
		return newReq;
	}
	
	private Message decodeMessage(byte[] msg){
		ByteBuf buf = Unpooled.buffer();
		buf.writeBytes(msg);
		Message  message = new Message();
		Header	header = new Header();
		message.setHeader(header);
		
		header.setVersion(buf.readByte());
		
		header.setId(buf.readShort());
		//鐠佸墽鐤嗗☉鍫熶紖娴ｆ挸鐫橀幀锟�
		short property = buf.readShort();
		this.setProerty(header,property);
		
		byte[] mobileBytes = new byte[8];
		buf.readBytes(mobileBytes);
//		System.out.println(HexUtils.bcd2Str(mobileBytes).length());
//		System.out.println(HexUtils.bcd2Str(mobileBytes));
		header.setMobile(HexUtils.bcd2Str(mobileBytes));
		//header.setMobile(buf.readLong());
		header.setNumber(buf.readShort());
		
		header.setBackup(buf.readByte());
		if(header.isSubPackage()){
			//閺堝鍨庨崠鍛繆閹垽绱濋幍宥堫嚢閸欐牗绉烽幁顖滄畱閸掑棗瀵樻い锟�
			header.setPackageSize(buf.readShort());
			header.setPackageIndex(buf.readShort());
		}
		
		byte[] body = new byte[buf.readableBytes()];
		buf.readBytes(body);
		message.setBody(body);
		
		
		return message;
	}
	/**
	 * 闁俺绻冪憴锝囩垳property鐏炵偞锟斤拷  閺屻儳婀呴崝鐘茬槕閺傜懓绱￠敍灞剧Х閹垶鏆辨惔锔肩礉閺勵垰鎯侀崚鍡楀瘶
	 * @param header
	 * @param property
	 */
	private void setProerty(Header header,short property){
		header.setProperty(property);
		short a = 1 << 13;
		//short a = 1 << 12;
		if((property & a) == a){
			//濞戝牊浼呴張澶婂瀻閸栵拷
			//鐟欙綁鍣村☉鍫熶紖閸栧懎鐨濋悩鍫曘��
			header.setSubPackage(true);
		}
		//閸旂姴鐦戦弬鐟扮础
		//0x400 : 10000000000
		//0x1c00 : 1110000000000
		if((property & 0x400) == 0x400){
			//闁插洨鏁ゆ禍鍝汼A閸旂姴鐦�
			header.setEncrypt("RSA");
		}else if((property & 0x1c00) == 0){
			//濞屸剝婀佺紓鏍垳
			header.setEncrypt(null);
		}
		//1023 111111111
		short length = (short)(property & 1023);
		//short length = (short)(property - a);
		header.setLength(length);
		
		
		
	}

}
