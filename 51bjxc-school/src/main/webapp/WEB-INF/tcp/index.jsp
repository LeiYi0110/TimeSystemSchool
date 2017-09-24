<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-demo</title>
<style>
.tcp-control{ padding:24px; }
.tcp-control .row1{ margin:20px 0; }
.tcp-control .row1 h3{ font-size:22px; height:22px; }
.tcp-control input{ margin-left:5px; margin-right:15px; }
</style>
<script src="${ctx}/resources/uploadify/jquery.uploadify.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>

<script type="text/javascript">
	$("#number").blur(function(){
		var count=$("#number").val();
		$("#iiput").empty();
		for(var i=0 ; i<count ; i++){
			$("#iiput").append('参数 '+(i+1)+' ID:<input type="text" name="id'+i+'"/>');
			$("#iiput").append('参数 '+(i+1)+' 长度类型(1,2,4,8):<input type="text" name="len'+i+'"/>');
			$("#iiput").append('参数 '+(i+1)+' 值:<input type="text" name="value'+i+'"/>');
		}
	});

	function submitForm(button) {
		var form = $(button).parent();
		var url = form.attr('action');
		console.log(url);
		var method = form.attr('method');
		method = method ? method : "GET";
		console.log(method);
		var param = {};
		$(form).find('input').each(function() {
			var value = $(this).val();
			var name = $(this).attr("name");
			var restful = $(this).attr("restful");
			if (restful) {
				console.log("restful:" + restful)
				url = url.replace('{' + restful + '}', value);
			}
			else {
				param[name] = value;
			}
		});
		param.deviceNum=$("#always input[name='deviceNum']").val();
		param.mobile=$("#always input[name='mobile']").val();
		$.ajax({
			type : method,
			url : url,
			data : param,
			dataType : "text",
			success : function(data) {
				console.log(data);
				$(form).find(".result_div").text(data);
			}
		});
	}
	
	
	
	function fileTypeChange(value,fileId) {
		
		$("#"+ fileId).val(value);
	
	}
	
</script>

</head>
<body>
	<div class="tcp-control">
		<div style="width: 100%; height: 15%;">
			<h1 align="center">tcp终端管理</h1>
		</div>
		<div style="width: 100%; margin-top: 10px;">
			<div class="row1">
				<div style="width: 100%;">
					<div id="always">
						终端编号:<input type="text" name="deviceNum" value="6674636183406951"/> 
						手机号:<input type="text" name="mobile" value="15099998888"/>
					</div>
				</div>
			</div>
			<div class="row1">
				<h3>平台登录</h3>
				<form action="TCPClient/login" method="post">
					平台编号:<input type="text" name="district" placeholder="BYTE[5]"/> 
					密码:<input type="text" name="name" placeholder="BYTE[8]"/> <br>
					平台接入码:<input type="text" name="licnum" placeholder="DWORD"/> <br>
					<input type="button" class="btn btn-success" value="执行" onclick="submitForm(this)" />
					<div class="result_div"></div>
				</form>
			</div>
			<div class="row1">
				<h3>平台登出</h3>
				<form action="TCPClient/logout" method="post">
					平台编号:<input type="text" name="district" placeholder="BYTE[5]"/> 
					密码:<input type="text" name="name" placeholder="BYTE[8]"/>
					<input type="button" class="btn btn-success" value="执行" onclick="submitForm(this)" />
					<div class="result_div"></div>
				</form>
			</div>
			<div class="row1">
				<h3>设置终端参数</h3>
				<form action="TCPClient/setTerminalParams" method="post">
					参数总数:<input type="text" name="sum"/> 
					分包参数个数:<input type="text" name="number" id="number"/><br>
					<h5>参数项列表:</h5>
					<div id="iiput"></div><br>
					<input type="button" class="btn btn-success" value="执行" onclick="submitForm(this)" />
					<div class="result_div"></div>
				</form>
			</div>
			<div class="row1">
				<h3>查询终端参数</h3>
				<form action="TCPClient/queryTerminalParams" method="post">
					<input type="button" class="btn btn-success" value="查询" onclick="submitForm(this)" />
					<div class="result_div"></div>
				</form>
			</div>
			<div class="row1">
				<h3>查询指定终端参数</h3>
				<form action="TCPClient/queryTerminalCurrentParams" method="post">
					参数总数:<input type="text" name="number" placeholder="BYTE"/> 
					参数ID列表:<input type="text" name="params" placeholder="逗号分隔"/>
					<input type="button" class="btn btn-success" value="查询" onclick="submitForm(this)" />
					<div class="result_div"></div>
				</form>
			</div>
			<div class="row1">
				<h3>终端控制</h3>
				<form action="TCPClient/terminalOrder" method="post">
					命令字:<input type="text" name="orderName" placeholder="BYTE"/> 
					命令参数:<input type="text" name="orderParam"/>
					<input type="button" class="btn btn-success" value="查询" onclick="submitForm(this)" />
					<div class="result_div"></div>
				</form>
			</div>
			<div class="row1">
				<h3>位置信息查询</h3>
				<form action="TCPClient/locationQuery" method="post">
					<input type="button" class="btn btn-success" value="查询" onclick="submitForm(this)" />
					<div class="result_div"></div>
				</form>
			</div>
			<div class="row1">
				<h3>临时位置跟踪控制</h3>
				<form action="TCPClient/locationTrack" method="post">
					时间间隔:<input type="text" name="interval" placeholder="WORD"/> 
					位置跟踪有效期:<input type="text" name="validity" placeholder="DWORD"/>
					<input type="button" class="btn btn-success" value="查询" onclick="submitForm(this)" />
					<div class="result_div"></div>
				</form>
			</div>
			<div class="row1">
				<h3>命令上报学时记录</h3>
				<form action="TCPClient/uploadRecord" method="post">
					查询方式:<input type="text" name="type" placeholder="1：按时间上传；2：按条数上传"/> 
					查询起始时间:<input type="text" name="startTime" placeholder="YYMMDDhhmmss"/><br>
					查询终止时间:<input type="text" name="endTime" placeholder="YYMMDDhhmmss"/> 
					查询条数:<input type="text" name="number" placeholder="WORD"/>
					<input type="button" class="btn btn-success" value="查询" onclick="submitForm(this)" />
					<div class="result_div"></div>
				</form>
			</div>
			<div class="row1">
				<h3>立即拍照</h3>
				<form action="TCPClient/getPhoto" method="post">
					上传模式:<input type="text" name="type" placeholder="BYTE"/> 
					摄像头通道号:<input type="text" name="cameraNum" placeholder="BYTE"/><br>
					图片尺寸:<input type="text" name="size" placeholder="BYTE"/>
					<input type="button" class="btn btn-success" value="查询" onclick="submitForm(this)" />
					<div class="result_div"></div>
				</form>
			</div>
			<div class="row1">
				<h3>查询照片</h3>
				<form action="TCPClient/queryPhoto" method="post">
					查询方式:<input type="text" name="type" placeholder="1：按时间查询"/> <br>
					查询开始时间:<input type="text" name="startTime" placeholder="YYMMDDhhmmss"/>
					查询结束时间:<input type="text" name="endTime" placeholder="YYMMDDhhmmss"/>
					<input type="button" class="btn btn-success" value="查询" onclick="submitForm(this)" />
					<div class="result_div"></div>
				</form>
			</div>
			<div class="row1">
				<h3>上传指定照片</h3>
				<form action="TCPClient/uploadPhoto" method="post">
					照片编号:<input type="text" name="num" placeholder="BYTE[10]"/> 
					<input type="button" class="btn btn-success" value="查询" onclick="submitForm(this)" />
					<div class="result_div"></div>
				</form>
			</div>
			<div class="row1">
				<h3>设置计时终端应用参数</h3>
				<form action="TCPClient/setTimeTerminalParams" method="post">
					参数编号:<input type="text" name="paramId" placeholder="BYTE"/>
					定时拍照时间间隔:<input type="text" name="getPhotoInterval" placeholder="BYTE"/> <br>
					照片上传设置:<input type="text" name="uploadSetting" placeholder="BYTE"/> 
					是否报读附加消息:<input type="text" name="hasExtalMsg" placeholder="BYTE"/> <br>
					熄火后停止学时计时的延时时间:<input type="text" name="stopStudingTimeDelay" placeholder="BYTE"/> 
					熄火后GNSS数据包上传间隔:<input type="text" name="GNSSInterval" placeholder="WORD"/> <br>
					熄火后教练自动登出的延时时间:<input type="text" name="autoLogoutDelay" placeholder="WORD"/> 
					重新验证身份时间:<input type="text" name="reValidate" placeholder="WORD"/> <br>
					教练跨校教学:<input type="text" name="enableCrossSchoolTeaching" placeholder="BYTE"/> 
					学员跨校学习:<input type="text" name="enableCrossSchoolStuding" placeholder="BYTE"/> <br>
					响应平台同类消息时间间隔:<input type="text" name="answerInterval" placeholder="WORD"/>
					<input type="button" class="btn btn-success" value="查询" onclick="submitForm(this)" />
					<div class="result_div"></div>
				</form>
			</div>
			<div class="row1">
				<h3>设置禁训状态</h3>
				<form action="TCPClient/unableTraining" method="post">
					禁训状态:<input type="text" name="type" placeholder="1：可用，默认值；2：禁用"/>
					提示消息长度:<input type="text" name="len" placeholder="BYTE"/> <br>
					提示消息内容:<input type="text" name="content" placeholder="STRING(n)"/>
					<input type="button" class="btn btn-success" value="查询" onclick="submitForm(this)" />
					<div class="result_div"></div>
				</form>
			</div>
			<div class="row1">
				<h3>查询计时终端应用参数</h3>
				<form action="http://localhost:8080/bjxc-school/TCPClient/queryTimeTerminalParams" method="post">
					<input type="button" class="btn btn-success" value="查询" onclick="submitForm(this)" />
					<div class="result_div"></div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>