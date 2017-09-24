<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<meta name="theme" content="school" />
<title>TCP-设置终端参数</title>
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
		<form class="form-horizontal" action="${ctx}/TCPClient/setTerminalParams" method="post" id="formId">
		  <div class="control-group">
		    <label class="control-label">参数总数:</label>
		    <div class="controls">
		      <input type="text" name="sum"/> 
		    </div>
		  </div>
		  <div class="control-group">
		    <label class="control-label">分包参数个数:</label>
		    <div class="controls">
		      <input type="text" name="number" id="number"/>
		    </div>
		  </div>
		  <div id="iiput"></div>
		  <div class="control-group">
		      <input type="button" class="btn btn-success" value="登录" onclick="submitForm(this)" />
		  </div>
		  <div class="result_div"></div>
		</form>
	</div>
<script type="text/javascript">
	$("#number").blur(function(){
		var count=$("#number").val();
		$("#iiput").empty();
		for(var i=0 ; i<count ; i++){
			$("#iiput").append('<div class="control-group"> <label class="control-label">参数 '+(i+1)+' ID:</label> <div class="controls"> <input type="text" name="id'+i+'"/> </div> </div>');
			$("#iiput").append('<div class="control-group"> <label class="control-label">参数 '+(i+1)+' 长度类型(1,2,4,8):</label> <div class="controls"> <input type="text" name="len'+i+'"/> </div> </div>');
			$("#iiput").append('<div class="control-group"> <label class="control-label">参数 '+(i+1)+' 值:</label> <div class="controls"> <input type="text" name="value'+i+'"/> </div> </div>');
		}
	});
</script>
</body>
</html>
