<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<meta name="theme" content="school" />
<title>TCP-设置禁训状态</title>
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
		<form class="form-horizontal" action="${ctx}/TCPClient/unableTraining" method="post" id="formId">
		  <div class="control-group">
		    <label class="control-label">禁训状态:</label>
		    <div class="controls">
		      <input type="text" name="type" placeholder="1：可用，默认值；2：禁用" value="1"/>
		    </div>
		  </div>
		  <div class="control-group">
		    <label class="control-label">提示消息长度:</label>
		    <div class="controls">
		      <input type="text" name="len" placeholder="BYTE" value="2" />
		    </div>
		  </div>
		  <div class="control-group">
		    <label class="control-label">提示消息内容:</label>
		    <div class="controls">
		      <input type="text" name="content" placeholder="STRING(n)" value="可用"/>
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
