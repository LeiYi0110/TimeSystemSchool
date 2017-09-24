<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>>
<%@ include file="/meta/meta-tag.jsp" %>
<%
String deviceNum=(String) request.getSession().getAttribute("deviceNum");
String mobile=(String) request.getSession().getAttribute("mobile");

%>
<html>
<head>
<meta name="theme" content="school" />
<title>TCP-绑定终端</title>
<style>
.form-horizontal{ width:400px; margin:0 auto; margin-top:50px; }
.form-horizontal .control-label{ text-align:right; }
.form-horizontal .btn{ display:block; margin:0 auto; }
</style>
<script type="text/javascript" src="${ctx}/resources/js/tcp.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
</head>
  
<body>
	<div style="padding: 24px">
		<form class="form-horizontal" action="${ctx}/TCPClient/bindDevice" method="post" id="formId">
		  <div class="control-group">
		    <label class="control-label">终端编号:</label>
		    <div class="controls">
		      <input type="text" name="deviceNum" value="<%= deviceNum %>"/>
		    </div>
		  </div>
		  <div class="control-group">
		    <label class="control-label">手机号:</label>
		    <div class="controls">
		      <input type="text" name="mobile" value="<%= mobile%>"/>
		    </div>
		  </div>
		  <div class="control-group">
		      <input type="button" class="btn btn-success" value="绑定" onclick="submitForm(this)" />
		  </div>
		  <div class="result_div"></div>
		</form>
	</div>
</body>
</html>
