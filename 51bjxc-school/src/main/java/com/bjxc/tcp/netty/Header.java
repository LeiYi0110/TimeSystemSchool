package com.bjxc.tcp.netty;

public class Header  {
	//閺勵垰鎯佸鏌ュ閺夛拷
	private boolean security;
	private byte version=(byte)128;//閻楀牊婀伴崣锟� 128
	private short	 id;//濞戝牊浼匢D
	private short property;//濞戝牊浼呮担鎾崇潣閹拷 2鐎涙濡�
	private String mobile;//缂佸牏顏幍瀣簚閸欙拷  8鐎涙濡�
	private short number;//濞戝牊浼呭ù浣规寜閸欙拷
	private byte backup;//妫板嫮鏆�娣団剝浼�
	private int length;//閸栧懘鏆辨惔锟�
	private String encrypt;//閸旂姴鐦戦弬鐟扮础
	private boolean subPackage = false;//閹峰棗鍨庨崠鍛畱婢堆冪毈
	private short packageSize;//閹峰棗鍨庨崠鍛畱婢堆冪毈
	private short packageIndex;//閹峰棗鍨庨崠鍛畱妞ゅ搫绨崣锟�
	
	
	
	public static short maxLength = 20;
	public boolean isSecurity() {
		return security;
	}
	public void setSecurity(boolean security) {
		this.security = security;
	}
	public byte getVersion() {
		return version;
	}
	public void setVersion(byte version) {
		this.version = version;
	}
	public short getId() {
		return id;
	}
	public void setId(short id) {
		this.id = id;
	}
	public short getProperty() {
		return property;
	}
	public void setProperty(short property) {
		this.property = property;
		
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		
		while (mobile.length() < 16) {
			mobile = "0" + mobile;
			
		}
		this.mobile = mobile;
	}
	public short getNumber() {
		return number;
	}
	public void setNumber(short number) {
		this.number = number;
	}
	public byte getBackup() {
		return backup;
	}
	public void setBackup(byte backup) {
		this.backup = backup;
	}
	public int getLength() {
		return length;
	}
	
	
	public void setLength(int length) {
		this.length = length;
	}
	public String getEncrypt() {
		return encrypt;
	}
	
	public void setPackageIndex(short packageIndex) {
		this.packageIndex = packageIndex;
	}
	public void setPackageSize(short packageSize) {
		this.packageSize = packageSize;
	}
	public short getPackageSize() {
		return packageSize;
	}
	public short getPackageIndex() {
		return packageIndex;
	}
	public boolean isSubPackage() {
		return subPackage;
	}
	public void setEncrypt(String encrypt) {
		this.encrypt = encrypt;
	}
	public void setSubPackage(boolean subPackage) {
		this.subPackage = subPackage;
	}
	
	
	

	
	
}
