<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<meta name="theme" content="school" />
<title>TCP-命令上报学时记录</title>
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
		<form class="form-horizontal" action="${ctx}/TCPClient/uploadRecord" method="post" id="formId">
		  <div class="control-group">
		    <label class="control-label">查询方式:</label>
		    <div class="controls">
		      <input type="text" name="type" placeholder="1：按时间上传；2：按条数上传"/>
		    </div>
		  </div>
		  <div class="control-group">
		    <label class="control-label">查询起始时间:</label>
		    <div class="controls">
		      <input type="text" name="startTime" placeholder="YYMMDDhhmmss"/>
		    </div>
		  </div>
		  <div class="control-group">
		    <label class="control-label">查询终止时间:</label>
		    <div class="controls">
		      <input type="text" name="endTime" placeholder="YYMMDDhhmmss"/>
		    </div>
		  </div>
		  <div class="control-group">
		    <label class="control-label">查询条数:</label>
		    <div class="controls">
		      <input type="text" name="number" placeholder="WORD"/>
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
