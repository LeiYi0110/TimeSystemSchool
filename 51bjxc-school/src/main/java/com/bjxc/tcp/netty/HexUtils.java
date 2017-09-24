package com.bjxc.tcp.netty;

public class HexUtils {
	private static String hexStr = "0123456789ABCDEF";
	private static String[] binaryArray = { "0000", "0001", "0010", "0011",
			"0100", "0101", "0110", "0111", "1000", "1001", "1010", "1011",
			"1100", "1101", "1110", "1111" };

	public static void main(String[] args) {
		String str = "二进制与十六进制互转测试";
		System.out.println("源字符串：\n" + str);

		String hexString = BinaryToHexString(str.getBytes());
		System.out.println("转换为十六进制：\n" + hexString);
		System.out.println("转换为二进制：\n" + bytes2BinaryStr(str.getBytes()));

		byte[] bArray = HexStringToBinary(hexString);
		System.out
				.println("将str的十六进制文件转换为二进制再转为String：\n" + new String(bArray));

	}

	/**
	 * 
	 * @param str
	 * @return 转换为二进制字符串
	 */
	public static String bytes2BinaryStr(byte[] bArray) {

		String outStr = "";
		int pos = 0;
		for (byte b : bArray) {
			// 低四位
			pos = b & 0x0F;
			outStr = binaryArray[pos] + outStr;
			// 高四位
			pos = (b & 0xF0) >> 4;
			outStr = binaryArray[pos] + outStr;
		}
		return outStr;

	}

	/**
	 * 
	 * @param bytes
	 * @return 将二进制转换为十六进制字符输出
	 */
	public static String BinaryToHexString(byte[] bytes) {

		String result = "";
		String hex = "";
		for (int i = 0; i < bytes.length; i++) {
			// 字节高4位
			hex = String.valueOf(hexStr.charAt((bytes[i] & 0xF0) >> 4));
			// 字节低4位
			hex += String.valueOf(hexStr.charAt(bytes[i] & 0x0F));
			result += hex + " ";
		}
		return result;
	}

	/**
	 * 
	 * @param hexString
	 * @return 将十六进制转换为字节数组
	 */
	public static byte[] HexStringToBinary(String hexString) {
		if (hexString == null || hexString.equals("")) {
			return null;
		}
		hexString = hexString.toUpperCase();
		int length = hexString.length() / 2;
		char[] hexChars = hexString.toCharArray();
		byte[] d = new byte[length];
		for (int i = 0; i < length; i++) {
			int pos = i * 2;
			d[i] = (byte) (charToByte(hexChars[pos]) << 4 | charToByte(hexChars[pos + 1]));
		}
		return d;

	}
	
	public static int parse(String s) throws NumberFormatException
	{
		if(!s.startsWith("0x"))
			throw new NumberFormatException();
		int number=0,n=0;
		for(int i=2;i<s.length();i++)
		{
			char c=s.charAt(i);
			switch(c)
			{
				case '1':
					n=1;break;
				case '2':
					n=2;break;
				case '3':
					n=3;break;
				case '4':
					n=4;break;
				case '5':
					n=5;break;
				case '6':
					n=6;break;
				case '7':
					n=7;break;
				case '8':
					n=8;break;
				case '9':
					n=9;break;
				case '0':
					n=0;break;
				case 'a':
				case 'A':
					n=10;break;
				case 'b':
				case 'B':
					n=11;break;
				case 'c':
				case 'C':
					n=12;break;
				case 'd':
				case 'D':
					n=13;break;
				case 'e':
				case 'E':
					n=14;break;
				case 'f':
				case 'F':
					n=15;break;
				default:
					throw new NumberFormatException();
			}
			number=number*16+n;
		}
		return number;
	}

	private static byte charToByte(char c) {
		return (byte) hexStr.indexOf(c);
	}

	/**
	 * 将byte转换为一个长度为8的byte数组，数组每个值代表bit
	 */
	public static byte[] getBooleanArray(byte b) {
		byte[] array = new byte[8];
		for (int i = 7; i >= 0; i--) {
			array[i] = (byte) (b & 1);
			b = (byte) (b >> 1);
		}
		return array;
	}

	/**
	 * 把byte转为字符串的bit
	 */
	public static String byteToBit(byte b) {
		return "" + (byte) ((b >> 7) & 0x1) + (byte) ((b >> 6) & 0x1)
				+ (byte) ((b >> 5) & 0x1) + (byte) ((b >> 4) & 0x1)
				+ (byte) ((b >> 3) & 0x1) + (byte) ((b >> 2) & 0x1)
				+ (byte) ((b >> 1) & 0x1) + (byte) ((b >> 0) & 0x1);
	}

	public static byte[] shortToBytes(short num) {
		byte[] b = new byte[2];

		for (int i = 0; i < 2; i++) {
			b[i] = (byte) (num >>> (i * 8));
		}

		return b;
	}
	
	public static String bcd2Str(byte[] bytes) {  
        StringBuffer temp = new StringBuffer(bytes.length * 2);  
        for (int i = 0; i < bytes.length; i++) {  
            temp.append((byte) ((bytes[i] & 0xf0) >>> 4));  
            temp.append((byte) (bytes[i] & 0x0f));  
        }  
        return temp.toString().substring(0, 1).equalsIgnoreCase("0") ? temp  
                .toString().substring(1) : temp.toString();  
    } 
	
	public static byte[] str2Bcd(String asc) {  
        int len = asc.length();  
        int mod = len % 2;  
        if (mod != 0) {  
            asc = "0" + asc;  
            len = asc.length();  
        }  
        byte abt[] = new byte[len];  
        if (len >= 2) {  
            len = len / 2;  
        }  
        byte bbt[] = new byte[len];  
        abt = asc.getBytes();  
        int j, k;  
        for (int p = 0; p < asc.length() / 2; p++) {  
            if ((abt[2 * p] >= '0') && (abt[2 * p] <= '9')) {  
                j = abt[2 * p] - '0';  
            } else if ((abt[2 * p] >= 'a') && (abt[2 * p] <= 'z')) {  
                j = abt[2 * p] - 'a' + 0x0a;  
            } else {  
                j = abt[2 * p] - 'A' + 0x0a;  
            }  
            if ((abt[2 * p + 1] >= '0') && (abt[2 * p + 1] <= '9')) {  
                k = abt[2 * p + 1] - '0';  
            } else if ((abt[2 * p + 1] >= 'a') && (abt[2 * p + 1] <= 'z')) {  
                k = abt[2 * p + 1] - 'a' + 0x0a;  
            } else {  
                k = abt[2 * p + 1] - 'A' + 0x0a;  
            }  
            int a = (j << 4) + k;  
            byte b = (byte) a;  
            bbt[p] = b;  
        }  
        return bbt;  
    }  
	
	public static byte[] int2byte(int res) {
		byte[] targets = new byte[4];  
		  
		targets[0] = (byte) (res & 0xff);// 最低位   
		targets[1] = (byte) ((res >> 8) & 0xff);// 次低位   
		targets[2] = (byte) ((res >> 16) & 0xff);// 次高位   
		targets[3] = (byte) (res >>> 24);// 最高位,无符号右移。   
		return targets;   
	}
	
}
