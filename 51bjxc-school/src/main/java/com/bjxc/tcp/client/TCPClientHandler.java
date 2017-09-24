package com.bjxc.tcp.client;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.bjxc.tcp.netty.HexUtils;
import com.bjxc.tcp.netty.JSPTConstants;
import com.bjxc.tcp.netty.Message;
import com.bjxc.tcp.netty.MessageUtils;

import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;
import io.netty.channel.ChannelHandlerAdapter;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.timeout.IdleStateEvent;

public class TCPClientHandler extends ChannelHandlerAdapter {
	private static final Logger logger = LoggerFactory.getLogger(TCPClientHandler.class);

	public FinishGetDataListener mCallbac;
	private Object msg;
	private Message heartMessage = null;

	public TCPClientHandler(FinishGetDataListener handlerCallBack, Object msg) {
		this.mCallbac = handlerCallBack;
		this.msg = msg;
	}

	public interface FinishGetDataListener {
		public boolean didGetData(Message message);
	}


	@Override
	public void channelActive(ChannelHandlerContext ctx) throws Exception {
		// 设置心跳包
		heartMessage = MessageUtils.getCommonMessage(null, (short) 0x0002, JSPTConstants.JSPT_MOBILE_DEFAULT);

		if (msg instanceof String) {
			byte[] req = HexUtils.HexStringToBinary(msg.toString());
			ByteBuf message = Unpooled.buffer(req.length);
			message.writeBytes(req);
			ctx.writeAndFlush(message);

		} else if (msg instanceof Message) {

			ctx.writeAndFlush(msg);

		}

	}

	@Override
	public void userEventTriggered(ChannelHandlerContext ctx, Object evt) throws Exception {
		if (evt instanceof IdleStateEvent) {
			IdleStateEvent e = (IdleStateEvent) evt;
			switch (e.state()) {
			case WRITER_IDLE:
				ctx.writeAndFlush(heartMessage);
				logger.info("send ping to province server----------");
				break;
			default:
				break;
			}
		}
	}

	@Override
	public void channelRead(ChannelHandlerContext ctx, Object msg) throws Exception {
		Message message = (Message) msg;
		logger.info("接收TCPServer的消息：" + message.getMessageString());
		if (mCallbac != null) {
			mCallbac.didGetData(message);
		}
	}
}
