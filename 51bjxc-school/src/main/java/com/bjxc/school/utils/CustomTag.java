package com.bjxc.school.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

/**
* 自定义标签，用于在jsp页面拿properties中的内容
* @author yy
* @date : 2016年11月14日 下午7:39:06
*/

public class CustomTag extends SimpleTagSupport {
	private String name;	//properties属性名
	
	public void doTag() throws JspException, IOException {
		if (name != null) {
			JspWriter out = getJspContext().getOut();
			Properties pps = new Properties();     
			InputStream in = CustomTag.class.getClassLoader().getResourceAsStream("bjxc.properties");
			pps.load(in);
			out.println("'"+pps.getProperty(name)+"'");
		}
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
}
