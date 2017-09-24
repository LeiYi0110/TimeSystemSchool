package com.bjxc.tcp.model;

public class DownTransportMessageBody extends TransportMessageBody{

	public DownTransportMessageBody() {
		super();
		this.setMessageType((byte)0x13);
	}

	public DownTransportMessageBody(byte[] bytes) {
		super(bytes);
		this.setMessageType((byte)0x13);
	}

}
