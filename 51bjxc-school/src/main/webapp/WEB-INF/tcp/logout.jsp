<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<meta name="theme" content="school" />
<title>TCP-平台登出</title>
<style>
.form-horizontal{ width:400px; margin:0 auto; margin-top:50px; }
.form-horizontal .control-label{ text-align:right; }
.form-horizontal .btn{ display:block; margin:0 auto; }
</style>
<script type="text/javascript" src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/tcp.js"></script>
</head>
  
<body>
	<div style="padding: 24px">
		<form class="form-horizontal" action="${ctx}/TCPClient/logout" method="post" id="formId">
		  <div class="control-group">
		    <label class="control-label">平台编号:</label>
		    <div class="controls">
		      <input type="text" name="platformNum" placeholder="BYTE[5]" value="A0041"/>
		    </div>
		  </div>
		  <div class="control-group">
		    <label class="control-label">密码:</label>
		    <div class="controls">
		      <input type="text" name="pwd" placeholder="BYTE[8]" value="12345678"/>
		    </div>
		  </div>
		  <div class="control-group">
		      <input type="button" class="btn btn-success" value="登出" onclick="submitForm(this)" />
		  </div>
		  <div class="result_div"></div>
		</form>
	</div>
	<script type="text/javascript" src="${ctx}/resources/js/tcp.js"></script>
</body>
</html>
