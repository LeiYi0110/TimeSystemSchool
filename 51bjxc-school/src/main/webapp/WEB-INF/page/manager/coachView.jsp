<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp"%>
<html>
<head>
<meta name="theme" content="school" />
<link type="text/css" href="${ctx}/resources/css/compiled/new-form.css" rel="stylesheet" />
<link href="${ctx}/resources/css/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen" />
<link href="${ctx}/resources/js/form-prompt/style.css" type="text/css" rel="stylesheet" media="all" />
<script type="text/javascript" src="${ctx}/resources/js/form-prompt/Validform_v5.3.2_min.js"></script>
<script src="${ctx}/resources/uploadify/jquery.uploadify.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/drivingFied/<sec:authentication property="principal.insId"/>"></script>
<script type="text/javascript" src="${ctx}/resources/js/serviceStation/<sec:authentication property="principal.insId"/>"></script>
<script type="text/javascript" src="${ctx}/resources/js/Areas"></script>

<title>阳光驾培-教练信息修改</title>
</head>

<body>
	<div class="container-fluid">
		<div id="pad-wrapper" class="new-form">
			<div class="row-fluid header">
				<h3>编辑教练信息</h3>
				<div class="span7 pull-left">
					<a class="btn-flat success pull-right" style="margin-left:10px;"  href="${ctx}/view/mg/coachEditor?id=${param.id}">编辑教练信息</a>
                </div>
			</div>

			<div class="row-fluid form-wrapper">
					<!-- left column -->
					<div class="span7 with-sidebar">
						<div class="container">

							<div class="span12 field-box">
								<label>姓名：</label> 
								<div id="name"></div>
							</div>

							<div class="span12 field-box">
								<label>性别：</label> 
								<div id="sex"></div>
							</div>

							<div class="span12 field-box">
								<label>计时收费：</label> <label id="label1">
								<input type="checkbox" name="firstAfterSchooL" id="firstAfterSchooL"
									value="firstAfterSchooL">
									先学后付&nbsp; </label> 
								<input id="timeCharges" class="span12 small" type="text" name="timeCharges" placeholder="0"
								readonly="readonly" style="display: none;">

							</div>

							<div class="span12 field-box">
								<label>手机号码：</label>
								<div id="mobile"></div>
							</div>

							<div class="span12 field-box">
								<label>教练员编号：</label> 
								<div id="coachnum"></div>
							</div>

							<div class="span12 field-box">
								<label>身份证：</label> 
								<div id="idcard"></div>
							</div>

							<div class="span12 field-box">
								<label>生日：</label> 
								<div id="birth"></div>
							</div>

							<div class="span12 field-box">
								<label>驾驶证号：</label> 
								<div id="drilicence"></div>
							</div>

							<div class="span12 field-box">
								<label>地址：</label> 
								<div id="address"></div>
							</div>

							<div class="span12 field-box">
								<label>准驾车型：</label> 
								<div id="dripermitted"></div>
							</div>

							<div class="span12 field-box">
								<label>准教车型：</label> 
								<div id="teachpermitted"></div>
							</div>
							<div class="span12 field-box">
								<label>联业资格等级：</label> 
								<div id="occupationlevel"></div>
							</div>
							<div class="span12 field-box">
								<label>带教科目：</label> 
								<div id="subject"></div>
							</div>

							<div class="span12 field-box">
								<label>领证时间：</label> 
								<div id="receiveTime"></div>
							</div>

							<div class="span12 field-box">
								<label>开始驾车时间：</label> 
								<div id="drivingTime"></div>
							</div>

							<div class="span12 field-box">
								<label>入职时间：</label>
								 <div id="hiredate"></div>
							</div>

							<div class="span12 field-box">
								<label>离职时间：</label> 
								<div id="leavedate"></div>
							</div>

							<div class="span12 field-box">
								<label>驾校网点：</label> 
								<div id="station"></div>
							</div>

							<div class="span12 field-box">
								<label>练车场地：</label> 
								<div id="drivingFieldId"></div>
							</div>

							<div class="span12 field-box">
								<label>教练车品牌：</label> 
								<div id="carBrand"></div>
							</div>

							<div class="span12 field-box">
								<label>教练车车牌：</label> 
								<div id="carPlate"></div>
							</div>

							<div class="span12 field-box">
								<label>星级：</label> 
								<div id="star"></div>
							</div>

							<div class="span12 field-box">
								<label>供职状态：</label> 
								<div id="employstatus"></div>
							</div>

							<div class="span12 field-box">
								<label>语言：</label> 
								<div id="language"></div>
							</div>

						</div>
					</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var current_action = "${ctx}/view/mg/coachView"; 
		var id = '${param.id}';
		$(document).ready(function() {
			if(id){
				initFormData(id);
			}
		});
		
		/**
		 *	展示编辑表单界面
		 *	新增、修改都需要调用该方法打开表单
		 */
		function initFormData(id) {
			if (id) {
				//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
				$.getJSON("${ctx}/coach/" + id,function(result) {
					if (result.code == 200) {
						var data = result.data;
						/* $('#id').text(data.id);
						$('#userId').text(data.userId);
						$('#insId"]').text(data.insId); */
						$('#timeCharges').val(data.price/100);
						if(data.price != null){
							$('#firstAfterSchooL"][value="firstAfterSchooL"]').attr("checked",true);
							$("#timeCharges").toggle();
						}
						$('#name').text(data.name);
						$('#mobile').text(data.mobile);
						if(data.idcard != null){
							$('#idcard').text(data.idcard);
						}
						if(data.sex == 1){
							$('#sex').text("男");
						}else if(data.sex == 2){
							$('#sex').text("女");
						}
						if(data.address != null){
							$('#address').text(data.address);
						}
						if(data.fingerprint == 0){
							$('#fingerprint').text("初领");
						}else if(data.fingerprint == 1){
							$('#fingerprint').text("增领");
						}else if(data.fingerprint == 2){
							$('#fingerprint').text("其它");
						}
						$('#drilicence').text(data.drilicence);
						$('#receiveTime').text(data.receiveTime);
						$('#dripermitted').text(data.dripermitted);
						$('#teachpermitted').text(data.teachpermitted);
						if(data.occupationleve != null){
							$('#occupationlevel').text(data.occupationlevel+"级");
						} else {
							$('#occupationlevel').text("0级");
						}
						if(data.employstatus == 0){
							$('#employstatus').text("在职");
						}else if(data.employstatus == 1){
							$('#employstatus').text("离职");
						}
						if(data.subject == 0){
							$('#subject').text("全科");
						}else if(data.subject == 2){
							$('#subject').text("科目2");
						}else if(data.subject == 3){
							$('#subject').text("科目3");
						}
						if(data.birth != null){
							$('#birth').text(data.birth);
						}
						if(data.hiredate != null){
							$('#hiredate').text(data.hiredate);
						}
						if(data.leavedate != null){
							$('#leavedate').text(data.leavedate);
						}
						if(data.drivingTime != null){
							$('#drivingTime').text(data.drivingTime);
						}
						if(data.coachnum != null){
							$('#coachnum').text(data.coachnum);
						}
						$('#carBrand').text(data.carBrand);
						$('#carPlate').text(data.carPlate);
						if(data.language == 0){
							$('#language').text("全会");
						}else if(data.language == 1){
							$('#language').text("普通话");
						}else if(data.language == 2){
							$('#language').text("粤语");
						}
						if(data.star == 1){
							$('#star').text("1星");
						}else if(data.star == 2){
							$('#star').text("2星");
						}else if(data.star == 3){
							$('#star').text("3星");
						}else if(data.star == 4){
							$('#star').text("4星");
						}else if(data.star == 5){
							$('#star').text("5星");
						}else{
							$('#star').text("0星");
						}
						//练车场地选择
						$(serviceStations).each(function(item){
							if(data.stationId == this.id){
								$('#station').text(this.name);
							}
						});
						
						//练车场地选择
						$(drivingFieds).each(function(item){
							if(data.drivingFieldId == this.id){
								$('#drivingFieldId').text( this.name);
							}
						});
						
						
					}
				});
			}
		}
		
	
		

</script>

</body>
</html>