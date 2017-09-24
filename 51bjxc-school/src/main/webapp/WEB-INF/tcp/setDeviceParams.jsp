<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<meta name="theme" content="school" />
<title>TCP-设置计时终端应用参数</title>
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
		<form class="form-horizontal" action="${ctx}/TCPClient/setTimeTerminalParams" method="post" id="formId">
		  <div class="control-group">
		    <label class="control-label">参数编号:</label>
		    <div class="controls">
		      <input type="text" name="paramId" placeholder="BYTE" value="1"/>
		    </div>
		  </div>
		  <div class="control-group">
		    <label class="control-label">定时拍照时间间隔:</label>
		    <div class="controls">
		      <input type="text" name="getPhotoInterval" placeholder="BYTE"  value="16"/>
		    </div>
		  </div>
		  <div class="control-group">
		    <label class="control-label">照片上传设置:</label>
		    <div class="controls">
		      <input type="text" name="uploadSetting" placeholder="BYTE"  value="0"/>
		    </div>
		  </div>
		  <div class="control-group">
		    <label class="control-label">是否报读附加消息:</label>
		    <div class="controls">
		      <input type="text" name="hasExtalMsg" placeholder="BYTE" value="2"/>
		    </div>
		  </div>
		  <div class="control-group">
		    <label class="control-label">熄火后停止学时计时的延时时间:</label>
		    <div class="controls">
		      <input type="text" name="stopStudingTimeDelay" placeholder="BYTE" value="5"/> 
		    </div>
		  </div>
		  <div class="control-group">
		    <label class="control-label">熄火后GNSS数据包上传间隔:</label>
		    <div class="controls">
		      <input type="text" name="GNSSInterval" placeholder="WORD" value="3600"/>
		    </div>
		  </div>
		  <div class="control-group">
		    <label class="control-label">熄火后教练自动登出的延时时间:</label>
		    <div class="controls">
		      <input type="text" name="autoLogoutDelay" placeholder="WORD" value="150"/> 
		    </div>
		  </div>
		  <div class="control-group">
		    <label class="control-label">重新验证身份时间:</label>
		    <div class="controls">
		      <input type="text" name="reValidate" placeholder="WORD" value="30"/>
		    </div>
		  </div>
		  <div class="control-group">
		    <label class="control-label">教练跨校教学:</label>
		    <div class="controls">
		      <input type="text" name="enableCrossSchoolTeaching" placeholder="BYTE" value="1"/> 
		    </div>
		  </div>
		  <div class="control-group">
		    <label class="control-label">学员跨校学习:</label>
		    <div class="controls">
		      <input type="text" name="enableCrossSchoolStuding" placeholder="BYTE" value="1"/>
		    </div>
		  </div>
		  <div class="control-group">
		    <label class="control-label">响应平台同类消息时间间隔:</label>
		    <div class="controls">
		      <input type="text" name="answerInterval" placeholder="WORD" value="60"/>
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
