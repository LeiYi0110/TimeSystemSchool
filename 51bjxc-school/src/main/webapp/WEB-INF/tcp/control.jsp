<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<meta name="theme" content="school" />
<title>TCP-终端控制</title>
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
	<form class="form-horizontal" action="${ctx}/TCPClient/terminalOrder" method="post" id="formId">
		  <div class="control-group">
		    <label class="control-label">命令字:</label>
		    <div class="controls">
		      <input type="text" name="orderName" placeholder="BYTE" value="1"/>
		    </div>
		  </div>
		  <div class="control-group">
		    <label class="control-label">命令参数:</label>
		    <div class="controls">
		      <input type="text" name="orderParam" value=";updateserver;test;test123;192.200.13.1;3340;3341;80100;1.1.1;0.4.2;" style="width: 500px;height: 50px;"/>
		    </div>
		  </div>
		  <div class="control-group">
		      <input type="button" class="btn btn-success" value="发送" onclick="submitForm(this)" />
		  </div>
		  <div class="result_div"></div>
		</form>
	</div>
</body>
</html>
