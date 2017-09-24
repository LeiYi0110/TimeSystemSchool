package com.bjxc.tcp.model;

public class UpTransportMessageBody extends TransportMessageBody {
	
	public UpTransportMessageBody()
	{
		this.setMessageType((byte)0x13);;
	}
	
	public UpTransportMessageBody(byte[] bytes)
	{
		super(bytes);
		this.setMessageType((byte)0x13);
		
	}

}
