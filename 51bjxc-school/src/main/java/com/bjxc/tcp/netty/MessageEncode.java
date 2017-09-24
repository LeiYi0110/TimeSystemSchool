package com.bjxc.tcp.netty;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.MessageToByteEncoder;

public class MessageEncode extends MessageToByteEncoder<Message> {
	private static final Logger logger = LoggerFactory.getLogger(MessageEncode.class);
	@Override
	protected void encode(ChannelHandlerContext ctx, Message msg, ByteBuf out)
			throws Exception {
		out.writeByte(msg.getFirst());
		
		byte[] body = this.encodeBody(msg);
		short bodyLength = 0;
		if(body!= null){
			bodyLength = (short) body.length;
		}else{
			body = new byte[0];
		}
		byte[] header = this.encodeHeader(msg.getHeader(), bodyLength);
		//鐏忓攧eader,body閸氬牆鍩屾稉锟界挧锟�
		ByteBuf msgBuf = Unpooled.buffer();
		byte check = 0;
		for(int i= 0;i<header.length;i++){
			msgBuf.writeByte(header[i]);
			//鏉╂稖顢戝鍌涘灗閿涘瞼鏁撻幋鎰梾妤犲瞼鐖�
			if(i==0){
				check = header[0];
			}else{
				check = (byte) (check^header[i]);
			}
		}

		for(int i= 0;i<body.length;i++){
			msgBuf.writeByte(body[i]);
			//鏉╂稖顢戝鍌涘灗閿涘瞼鏁撻幋鎰梾妤犲瞼鐖�
			check = (byte) (check^body[i]);
		}
		//鏉堟挸鍤☉鍫熶紖婢剁绐″☉鍫熶紖娴ｏ拷
		byte[] mby = new byte[msgBuf.readableBytes()];
		msgBuf.readBytes(mby);
		
		//鏉╂稖顢戞潪顑跨疅
		ByteBuf tranBuf = Unpooled.buffer();
		for(int i =0;i<mby.length;i++ ){
			byte mg = mby[i];
			if(mg == 0x7e){
				tranBuf.writeByte(0x7d);
				tranBuf.writeByte(0x02);
			}else if(mg == 0x7d){
				tranBuf.writeByte(0x7d);
				tranBuf.writeByte(0x01);
			}else{
				tranBuf.writeByte(mg);
			}
		}

		byte[] tranmby = new byte[tranBuf.readableBytes()];
		tranBuf.readBytes(tranmby);
		
		//鏉堟挸鍤☉鍫熶紖
		out.writeBytes(tranmby);
		//鏉堟挸鍤Λ锟芥宀�鐖�
		out.writeByte(check);
		out.writeByte(msg.getLast());
		

		byte[] msgByte = new byte[out.readableBytes()];
		
//		logger.info(String.valueOf(msgByte.length));
		out.readBytes(msgByte);
		out.readerIndex(0);

	}
	
	public byte[] encodeBody(Message msg){
		return msg.getBody();
	}
	
	public byte[] encodeHeader(Header header,short boyLength){
		ByteBuf hbuf = Unpooled.buffer();
		hbuf.writeByte(header.getVersion());
		hbuf.writeShort(header.getId());
		//閸ョ偛顦查惃鍕Х閹垶鍏樻稉宥呭鐎靛棴绱濇稊鐔剁瑝閸掑棗瀵�
		
		if (header.isSubPackage()) {
			hbuf.writeShort(header.getProperty());
		}
		else
		{
			hbuf.writeShort(boyLength);
		}
		
		
		
		//hbuf.writeLong(header.getMobile());
		hbuf.writeBytes(HexUtils.str2Bcd(header.getMobile()));
		
		hbuf.writeShort(header.getNumber());
		hbuf.writeByte(header.getBackup());
		
		
		if (header.isSubPackage()) {
			hbuf.writeShort(header.getPackageSize());
			hbuf.writeShort(header.getPackageIndex());
		}
		
		
		byte[] hby = new byte[hbuf.readableBytes()];
		hbuf.readBytes(hby);
		return hby;
	}
	
	

}
