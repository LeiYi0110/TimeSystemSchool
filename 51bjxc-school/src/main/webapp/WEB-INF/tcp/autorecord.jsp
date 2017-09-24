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
		<form class="form-horizontal" action="${ctx}/TCPClient/autoRecord" method="post" id="formId">
		  <div class="control-group">
		    <label class="control-label">学员编号:</label>
		    <div class="controls">
		      <input type="text" name="stuNum"/>
		    </div>
		  </div>
		  <div class="control-group">
		    <label class="control-label">教练编号:</label>
		    <div class="controls">
		      <input type="text" name="coachNum"/>
		    </div>
		  </div>
		  <div class="control-group">
		    <label class="control-label">当天学时记录总数（不填表示所有记录）:</label>
		    <div class="controls">
		      <input type="text" name="recordCount"/>
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
