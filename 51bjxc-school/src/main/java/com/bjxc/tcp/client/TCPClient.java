package com.bjxc.tcp.client;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.bjxc.tcp.client.TCPClientHandler.FinishGetDataListener;
import com.bjxc.tcp.netty.HexUtils;
import com.bjxc.tcp.netty.Message;
import com.bjxc.tcp.netty.MessageDecoder;
import com.bjxc.tcp.netty.MessageEncode;

import io.netty.bootstrap.Bootstrap;
import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;
import io.netty.channel.ChannelFuture;
import io.netty.channel.ChannelInitializer;
import io.netty.channel.ChannelOption;
import io.netty.channel.EventLoopGroup;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.SocketChannel;
import io.netty.channel.socket.nio.NioSocketChannel;
import io.netty.handler.codec.DelimiterBasedFrameDecoder;



@Service
public class TCPClient {
	private static final Logger logger = LoggerFactory.getLogger(TCPClient.class);
	
	
	//private int port = 8585;
	//private String host = "112.74.129.7";
	private String host;
	private int port;
	
	/*
	private int port = 8181;
	private String host = "114.55.89.156";
	*/

	private ChannelFuture future = null;
	
	private boolean isDecode = true;
	
	private ScheduledExecutorService executor = Executors.newScheduledThreadPool(1);
	
	public FinishGetDataListener handlerCallBack;
	
	private Object msg;

	public TCPClient(FinishGetDataListener handlerCallBack, Object msg, String host, int port)
	{
		this.handlerCallBack = handlerCallBack;
		this.msg = msg;
		this.host = host;
		this.port = port;
	}
	public void connect(final String host, final int port) throws Exception {
		// 配置服务器端NIO线程组
		EventLoopGroup group = new NioEventLoopGroup();
		try {
			Bootstrap bootstarp = new Bootstrap();
			bootstarp.group(group).channel(NioSocketChannel.class).option(ChannelOption.TCP_NODELAY, true)
					.handler(new ChannelInitializer<SocketChannel>() {

						@Override
						protected void initChannel(SocketChannel channel) throws Exception {
							ByteBuf delimiter = Unpooled.copiedBuffer(HexUtils.HexStringToBinary("7e"));
							channel.pipeline().addLast(new DelimiterBasedFrameDecoder(1024, delimiter));
							
							if (isDecode) {
								channel.pipeline().addLast(new MessageDecoder());
							}
							channel.pipeline().addLast(new MessageEncode());
							TCPClientHandler tcpClientHandler =  new TCPClientHandler(handlerCallBack,msg);
							channel.pipeline().addLast(tcpClientHandler);
						}

					});
			logger.info(host + ":" + port);
			// 绑定端口 同步等 待
			future = bootstarp.connect(host, port).sync();

			// 等 待服务端监听端口关闭
			future.channel().closeFuture().sync();
		}catch(Throwable ex){
			logger.error("client start",ex);
		} finally {
			// 退出释放线程池
			// group.shutdownGracefully();
			// 所有资源释放完成之后，清空资源，再次发起重连操作
			executor.execute(new Runnable() {
				public void run() {
					try {
						TimeUnit.SECONDS.sleep(1);
						try {
							connect(host, port);// 发起重连操作
						} catch (Exception e) {
							logger.error("", e);
						}
					} catch (InterruptedException e) {
						logger.error("", e);
					}
				}
			});
		}
	}

	/**
	 * 将消息发送给省平台服务端
	 * 
	 * @param msg
	 */
	public void writeAndFlush(Message msg) {
		System.out.println("messageLength------------"+msg.getBody().length);
		this.future.channel().writeAndFlush(msg);
	}
	
	public void writeAndFlush(String msg){
		byte[] req = HexUtils.HexStringToBinary(msg);
		ByteBuf message = Unpooled.buffer(req.length);
		message.writeBytes(req);
		this.future.channel().writeAndFlush(message);
	}
	

	public void start() throws Exception {
		connect(host,port);
	}

	public void setPort(int port) {
		this.port = port;
	}

	public void setHost(String host) {
		this.host = host;
	}
	

	
	

}
