package com.bjxc.school.security;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;

public class MD5PasswordTestCase {
	private static final Logger logger = LoggerFactory.getLogger(MD5PasswordTestCase.class);
	
	@Test
	public void builderPassword(){

		Md5PasswordEncoder md5PasswordEncoder = new Md5PasswordEncoder();
		String password = md5PasswordEncoder.encodePassword("123456","");
		logger.info(password);
	}
	
	@Test
	public void test(){
		int insId=1;          //比如这是条件
		int  seq =9;          //这是自增值
		for(int i=0 ; i<1; i++){
			if(insId==1){
			  seq++;
			}else{
				seq=1;
			}
		}
		 String str = String.format("%04d", seq);   //最后插入的值
		 System.out.println(str);
	}
}
