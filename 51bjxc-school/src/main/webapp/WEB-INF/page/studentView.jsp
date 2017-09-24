<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<meta name="theme" content="page" />
<link type="text/css" href="${ctx}/resources/css/compiled/new-form.css" rel="stylesheet" />
<title>阳光驾培-编辑学员信息</title>
</head>
<body>
	<div class="container-fluid">
		<div id="pad-wrapper" class="new-form">
			<div class="row-fluid header">
				<h3>学员信息-基本信息</h3>
				<div class="span7 pull-left">
					<a class="btn-flat success pull-right" style="margin-left:10px;"  href="${ctx}/view/studentEditor?id=${param.id}">编辑学员信息</a>
                </div>
			</div>

			<div class="row-fluid form-wrapper">
				<div class="span2 pull-left">
					<ul  id="dashboard-menu">
						<li>
							<a href="#"  class="active" style="color:#000">
							学员基本信息
							</a>
						</li>
						<c:if test="${param.id != null}">
						<li>
							<a href="${ctx}/view/studentInsLog?id=${param.id}">
								学车进度
							</a>
						</li>
						<li>
							<a href="${ctx}/view/studentRecording?id=${param.id}">
								学时记录
							</a>
						</li>
						</c:if>
					</ul>
				</div>
				<!-- left column -->
				<div class="span7 with-sidebar">
					<div class="container">
						<form id="info" class="inline-input"
							action="" method="post">
							<div class="span12 field-box">
								<label>档案编号：</label> 
								<div id="recordnum"></div>
							</div>
							<div class="span12 field-box">
								<label>姓名：</label> 
								<div id="name"></div>
							</div>

							<div class="span12 field-box">
								<label>性别：</label> 
								<div id="sex"></div>
							</div>

							<div class="span12 field-box">
								<label>电话号码：</label> 
								
								<div id="mobile"></div>
							</div>

							<div class="span12 field-box">
								<label>证件类型：</label> 
								<div id="cradtype"></div>
							</div>

							<div class="span12 field-box">
								<label>证件号：</label> 
								<div id="idcard"></div>
							</div>


							<div class="span12 field-box">
								<label>地址：</label> 
								<div id="address"></div>
							</div>
							
							
							<div class="span12 field-box">
								<label>业务类型：</label>
								<div id="busitype"></div>
							</div>
							<div class="span12 field-box">
								<label>流水号：</label>
								<div id="stunum"></div>
							</div>
							<div class="span12 field-box">
								<label>培训车型：</label>
								<div id="traintype"></div>
							</div>
							
							<div class="span12 field-box">
								<label>状态：</label> 
								<div id="status"></div>
							</div>
							
							<div class="span12 field-box">
									<label>学费：</label> 
								
								<span class="span3 small" >
									应付：
									<div id="tuition"></div>
								</span>
								<span class="span3 small">
									已付：
									<div id="alreadyPay"></div>
								</span>
								<span class="span3 small">
									欠付：
									<div id="arrearage"></div>
								</span>
							</div>

							<div class="span12 field-box">
								<label>服务网点：</label>
								<div id="stationName"></div>
								<!-- <div><input type="button" value="转网点"></div> -->
							</div>


							<div class="span12 field-box">
								<label>驾驶证号：</label>
								<div id="drilicnum"></div>
							</div>
							
							<div class="span12 field-box">
								<label>初次领证日期：</label> 
								<div id="fstdrilicdate"></div>
							</div>

							<div class="span12 field-box">
								<label>原准驾车型：</label> 
								
								<div id="perdritype"></div>
							</div>
							<div class="span12 field-box">
								<label>报名时间：</label> 
								<span id="applydate"></span>
							</div>
							<div class="span12 field-box">
								<label>推荐电话：${studentReferee.refereeMobile}</label> 
								<span id="refereeMobile"></span>
							</div>
							<div class="span12 field-box">
								<label>推荐人：</label> 
								<span id="refereeName"></span>
							</div>
						</form>
					</div>
				</div>


				<!-- side right column -->
				<div class="span3 form-sidebar pull-right">
						<div style="height: 60px; width: 80px; display: inline-block;">
								<img id="photo" name="photo" src="#" class="img-thumbnail">
						</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		var current_action = "${ctx}/view/studentEditor";
		var id = '${param.id}';
		$(document).ready(function() {
			if(id){
				initForm(id);
			}
		});
		
		/**
		 *	展示编辑表单界面
		 *	新增、修改都需要调用该方法打开表单
		 */
		function initForm(id) {
			if (id) {
				//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
				$.getJSON("${ctx}/student/" + id,function(result) {
					console.log(result);
					if (result.code == 200) {
						var data = result.data;
						//$('#ediorForm input[name="id"]').val(data.id);
						//$('#ediorForm input[name="userId"]').val(data.userId);
						//$('#ediorForm input[name="insId"]').val(data.insId);
						$('#stunum').text(data.stunum);
						$('#recordnum').text(data.recordnum);
						$('#name').text(data.name);
						$('#mobile').text(data.mobile);
						if(data.cradtype == 1){
							$('#cradtype').text("身份证");
						}else if(data.cradtype == 2){
							$('#cradtype').text("护照");
						}else if(data.cradtype == 3){
							$('#cradtype').text("军官证");
						}else if(data.cradtype == 4){
							$('#cradtype').text("其它");
						}
						
						$('#idcard').text(data.idcard);
						if(data.sex ==1){
							$('#sex').text("男");
						}else if(data.sex ==2){
							$('#sex').text("女");
						}else{
							$('#sex').text("无");
						}
						if(data.address){
							$('#address').text(data.address);
						}else{
							$('#address').text("");
						}
						
						if(data.busitype==0){
							$('#busitype').text("初领");
						}else if(data.busitype==1){
							$('#busitype').text("增领");
						}else if(data.busitype==2){
							$('#busitype').text("其它");
						}
						
						$('#photo').attr("src",data.photo);
						
						$('#fingerprint').text(data.fingerprint);
						if(data.drilicnum){
							$('#drilicnum').text(data.drilicnum);
						}else{
							$('#drilicnum').text("无");
						}
						
						if(data.fstdrilicdate){
							$('#fstdrilicdate').text(data.fstdrilicdate);
						}else{
							$('#fstdrilicdate').text("无");
						}
						if(data.perdritype){
							$('#perdritype').text(data.perdritype);
						}else{
							$('#perdritype').text("无");
						}
						$('#traintype').text(data.traintype);
						$('#applydate').text(data.applydate);
						$('#tuition').text(data.tuition);
						$('#alreadyPay').text(data.alreadyPay);
						$('#arrearage').text(data.arrearage);
						$('#refereeMobile').text(data.refereeMobiles);
						$('#refereeName').text(data.refereeName);
						if(data.stationName)
							$('#stationName').text(data.stationName);
						
						
						if(data.applydate){
							$('#applydate').text(data.applydate);
						}else{
							$('#applydate').text("");
						}
						if(data.status == -1){
							$('#status').text("失效");
						}else if(data.status == 1){
							$('#status').text("报名");
						}else if(data.status == 2){
							$('#status').text("学习中");
						}else if(data.status == 3){
							$('#status').text("拿到驾照");
						}
						if(data.recordnum){
							$('#recordnum').text(data.recordnum);
						}else{
							$('#stunum').text("无");
						}
					}
				});
			}
		}
	</script>
</body>
</html>