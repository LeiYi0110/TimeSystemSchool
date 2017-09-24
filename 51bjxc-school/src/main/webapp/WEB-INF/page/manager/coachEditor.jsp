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
<script type="text/javascript" src="${ctx}/resources/js/Areas"></script>

<title>阳光驾培-教练信息修改</title>
</head>

<body>
	<div class="container-fluid">
		<div id="pad-wrapper" class="new-form">
			<div class="row-fluid header">
				<h3>编辑教练信息</h3>
			</div>

			<div class="row-fluid form-wrapper">
				<form id="coachInfo" class="inline-input registerform"
					action="${ctx}/coach/saveCoach" method="post">
					<!-- left column -->
					<div class="span7 with-sidebar">
						<div class="container">

							<div class="span12 field-box">
								<label><span class="need">&#42;</span>姓名：</label> 
								<input type="text" class="span9 inputxt" datatype="*" name="name" id="name" value="${coach.name}"> 
								<input type="hidden" name="id" id="id" value="${param.id}"> 
								<input type="hidden" name="insId" id="insId" value="<sec:authentication property="principal.insId"/>">
							</div>

							<div class="span12 field-box">
								<label><span class="need">&#42;</span>性别：</label> 
								<label>
									<input type="radio" name="sex" id="sex" value="1">
									男
								</label> 
								<label> 
									<input type="radio" name="sex" id="sex" value="2">
									女
								</label>
							</div>

							<div class="span12 field-box">
								<label>计时收费：</label> <label id="label1">
								<input type="checkbox" name="firstAfterSchooL" id="firstAfterSchooL"
									value="firstAfterSchooL">
									先学后付&nbsp; </label> 
								<input id="timeCharges" class="span12 small" type="text" value="" name="timeCharges" placeholder="0" style="display: none;">
							</div>

							<div class="span12 field-box">
								<label><span class="need">&#42;</span>手机号码：</label> <input
									type="text" class="span9 inputxt" datatype="*" name="mobile"
									id="mobile" value="">
							</div>

							<div class="span12 field-box">
								<label><span class="need">&#42;</span>教练员编号：</label> <input
									type="text" class="span9 inputxt" datatype="*" name="coachnum"
									id="coachnum" value="">
							</div>

							<div class="span12 field-box">
								<label><span class="need">&#42;</span>身份证：</label> <input
									type="text" class="span9 inputxt" datatype="*" name="idcard"
									id="idcard" value="" onblur="addBirth()">
							</div>

							<div class="span12 field-box">
								<label>生日：</label> <input type="text" name="birth"
									class="form_date" data-date-format="yyyy-mm-dd"
									value=''>
							</div>

							<div class="span12 field-box">
								<label><span class="need">&#42;</span>驾驶证号：</label> <input
									type="text" class="span9 inputxt" datatype="*"
									name="drilicence" id="drilicence" value="">
							</div>

							<div class="span12 field-box">
								<label>地址：</label> <input type="text" class="span9 inputxt"
									datatype="*" name="address" id="address"
									value="">
							</div>

							<div class="span12 field-box">
								<label><span class="need">&#42;</span>准驾车型：</label> 
								<label><input type="radio" name="dripermitted" id="dripermitted" value="c1">
									C1&nbsp; </label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
								<label><input type="radio" name="dripermitted" id="dripermitted" value="c2">
									&nbsp;C2
								</label>
							</div>

							<div class="span12 field-box">
								<label><span class="need">&#42;</span>准教车型：</label> 
								<label><input type="radio" name="teachpermitted" id="teachpermitted" value="c1">
									&nbsp;C1 </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
								<label> <input type="radio" name="teachpermitted" id="teachpermitted" value="c2">
									&nbsp;C2
								</label>
							</div>
							<div class="span12 field-box">
								<label>联业资格等级：</label> <label><input type="radio"
									name="occupationlevel" id="occupationlevel" value="1">一级</label>
								<label><input type="radio" name="occupationlevel"
									id="occupationlevel" value="2">二级</label>
								<label><input type="radio" name="occupationlevel"
									id="occupationlevel" value="3">三级</label>
								<label><input type="radio" name="occupationlevel"
									id="occupationlevel" value="4">四级</label>
							</div>
							<div class="span12 field-box">
								<label><span class="need">&#42;</span>带教科目：</label> <select
									id="subject" name="subject">
									<option value="2">科目二</option>
									<option value="3">科目三</option>
									<option value="0">全科目</option>
								</select>
							</div>

							<div class="span12 field-box">
								<label>领证时间：</label> <input type="text" name="receiveTime"
									class="form_date" data-date-format="yyyy-mm-dd"
									value=''>
							</div>

							<div class="span12 field-box">
								<label>开始驾车时间：</label> <input type="text" name="drivingTime"
									class="form_date" data-date-format="yyyy-mm-dd"
									value=''>
							</div>

							<div class="span12 field-box">
								<label>入职时间：</label> <input type="text" name="hiredate"
									class="form_date" data-date-format="yyyy-mm-dd"
									value=''>
							</div>

							<div class="span12 field-box">
								<label>离职时间：</label> <input type="text" name="leavedate"
									class="form_date" data-date-format="yyyy-mm-dd"
									value=''>
							</div>

							<div class="span12 field-box">
								<label><span class="need">&#42;</span>驾校网点：</label> <select
									id="area" name="area">

								</select> <input type="hidden" value="" id="nowstation" name="nowstation">
								<select id="station" name="station">

								</select>
							</div>

							<div class="span12 field-box">
								<label><span class="need">&#42;</span>练车场地：</label> <input
									type="hidden" id="drivingFied" value="">
								<select id="drivingFieldId" name="drivingFieldId">

								</select>
							</div>

							<div class="span12 field-box">
								<label><span class="need">&#42;</span>教练车品牌：</label> <input
									type="text" class="span9" name="carBrand" id="carBrand"
									value="">
							</div>

							<div class="span12 field-box">
								<label><span class="need">&#42;</span>教练车车牌：</label> <input
									type="text" class="span9" name="carPlate" id="carPlate"
									value="">
							</div>

							<div class="span12 field-box">
								<label>星级：</label> <label><input type="radio"
									name="star" id="star" value="1">一星</label>
								<label><input type="radio" name="star" id="star"
									value="2">
									二星</label> <label><input type="radio" name="star" id="star"
									value="3">三星
								</label> <label><input type="radio" name="star" id="star"
									value="4">四星
								</label> <label><input type="radio" name="star" id="star"
									value="5" checked="checked">五星</label>
							</div>

							<div class="span12 field-box">
								<label><span class="need">&#42;</span>供职状态：</label> <label>
									<input type="radio" name="employstatus" id="employstatus"
									value="0" checked="checked">
									在职
								</label> <label> <input type="radio" name="employstatus"
									id="employstatus" value="1">
									离职
								</label>
							</div>

							<div class="span12 field-box">
								<label><span class="need">&#42;</span>语言：</label> <label>
									<input type="radio" name="language" id="language" value="0"
									checked="checked">
									全会
								</label> <label> <input type="radio" name="language"
									id="language" value="1">
									普通话
								</label> <label> <input type="radio" name="language"
									id="language" value="2">
									粤语
								</label>
							</div>

							<div class="span11 field-box actions">
								<input id="save_btn" type="button" class="btn-glow primary" value="保存"
									onclick="save()" />
								<input type="reset" value="取消" class="reset" />
							</div>

						</div>
					</div>


					<!-- side right column-->
					<div class="span3 form-sidebar pull-right">
						<div class="rk_swfupload">
							<div class="col-md-3 ">
								<div class="rk_swfupload">
									<div style="height: 60px; width: 100px; display: inline-block;">
										<img id="photo" name="photo" src="" class="img-thumbnail">
										<a style="margin-top: 20px;" class="btn-glow"> 上传教练照片 </a>
									</div>
									<div class="swfobj">
										<div id="upload_buton_img"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var current_action = "${ctx}/view/mg/coachEditor"; 
		var id = '${param.id}';
		var insId = '<sec:authentication property="principal.insId"/>';
		$(document).ready(function() {
			initForm();
			if(id){
				initFormData(id);
			}
		});
		
		function initForm(){
			//地区
			$('#coachInfo select[name="area"]').append("<option value=''>请选择</option>");
			$(areas).each(function(item){
				if(this.area != '市辖区'){
					$('#coachInfo select[name="area"]').append("<option value='" + this.area + "'>" + this.area + "</option>");
				}
			});
			//网点
			$("#coachInfo select[name='area']").change(function() {
				var value = $(this).val();
				if (value == '0') {
					$("#coachInfo select[name='station']").empty()
					$("#coachInfo select[name='station']").append("<option value='0'>请选择</option>");
				}
				else {
					var params = {
						area : value,
						insId : insId
					};
					$("#coachInfo select[name='station']").empty();
					$("#coachInfo select[name='station']").append("<option value='0'>请选择</option>");
					$.post('${ctx}/serviceStation/findByArea', params, function(result) {
						if (result.code == 200) {
							for (var i = 0; i < result.data.length; i++) {
								$("#coachInfo select[name='station']").append("<option value='" + result.data[i].id + "'>" + result.data[i].name + "</option>");
							}
						}
					});
				}
			});
			
			
			//练车场地选择
			$('#coachInfo select[name="drivingFieldId"]').append("<option value=''>请选择</option>");
			$().each(function(item){
				$('#coachInfo select[name="drivingFieldId"]').append("<option value='" + this.id + "'>" + this.name + "</option>");
			});
			
			$('.form_date').datetimepicker({
		        language:  'zh-CN',
		        weekStart: 1,
		        todayBtn:  1,
				autoclose: 1,
				todayHighlight: 0,
				startView: 2,
				minView: 2,
				forceParse: 0
		   });
			

			$('#upload_buton_img').uploadify({
				'swf' : 'http://upload.91ygxc.com/resources/swfupload.swf',
				'uploader' : 'http://upload.91ygxc.com/FileUpload',
				'height' : '100',
				'width' : '100',
				'fileTypeExts' : '*.jpg;*.JPG;*.jpeg;*.JPEG;*.png;*.PNG;*.gif;*.GIF',
				'fileObjName' : 'file_upload',
				'onUploadSuccess' : function(file, data, response) {
					var datajson = eval("(" + data + ")");
					$("#photo").attr('src', datajson.data.s);
					console.log(data);
				}
			});
			
			var nowstation = $("#nowstation").val();
			if(nowstation != null){
				var params = {
						id : nowstation,
						insId : insId
				};
				$.post('${ctx}/serviceStation/findStationArea',params, function(results) {
					if (results.code == 200) {
						$('#coachInfo select[name="area"]').val(results.data.area);
						var params = {
								area : results.data.area,
								insId : insId
							};
							$("#coachInfo select[name='station']").empty();
							$("#coachInfo select[name='station']").append("<option value='0'>请选择</option>");
							$.post('${ctx}/serviceStation/findByArea', params, function(result) {
								if (result.code == 200) {
									for (var i = 0; i < result.data.length; i++) {
										$("#coachInfo select[name='station']").append("<option value='" + result.data[i].id + "'>" + result.data[i].name + "</option>");
										if(results.data.id == result.data[i].id ){
											$('#coachInfo select[name="station"]').val(results.data.id);
										}
									}
								}
							});
						
					}
				});
			}
			
			var drivingFied = $("#drivingFied").val();
			if(drivingFied != null){
				$('#coachInfo select[name="drivingFieldId"]').val(drivingFied);
			}
		}
		
		
		/**
		 *	展示编辑表单界面
		 *	新增、修改都需要调用该方法打开表单
		 */
		function initFormData(id) {
			if (id) {
				//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
				$.getJSON("${ctx}/coach/" + id,function(result) {
					console.log(result);
					if (result.code == 200) {
						var data = result.data;
						
						$('#coachInfo input[name="id"]').val(data.id);
						$('#coachInfo input[name="userId"]').val(data.userId);
						$('#coachInfo input[name="insId"]').val(data.insId);
						$('#coachInfo input[name="name"]').val(data.name);
						$('#coachInfo input[name="mobile"]').val(data.mobile);
						$('#coachInfo input[name="idcard"]').val(data.idcard);
						$('#coachInfo input[name="sex"][value=' + data.sex + ']').attr("checked",true);
						$('#coachInfo input[name="address"]').val(data.address);
						$('img[name="photo"]').attr("src",data.photo);
						$('#coachInfo input[name="fingerprint"]').val(data.fingerprint);
						$('#coachInfo input[name="drilicence"]').val(data.drilicence);
						$('#coachInfo input[name="receiveTime"]').val(data.receiveTime);
						$('#coachInfo input[name="dripermitted"][value=' + data.dripermitted + ']').attr("checked",true);
						$('#coachInfo input[name="teachpermitted"][value=' + data.teachpermitted + ']').attr("checked",true);
						$('#coachInfo input[name="occupationlevel"][value=' + data.occupationlevel + ']').attr("checked",true);
						$('#coachInfo input[name="employstatus"][value=' + data.employstatus + ']').attr("checked",true);
						$('#coachInfo input[name="subject"][value=' + data.subject + ']').attr("checked",true);
						$('#coachInfo input[name="language"][value=' + data.language + ']').attr("checked",true);
						$('#coachInfo input[name="birth"]').val(data.birth);
						$('#coachInfo input[name="hiredate"]').val(data.hiredate);
						$('#coachInfo input[name="leavedate"]').val(data.leavedate);
						$('#coachInfo input[name="drivingTime"]').val(data.drivingTime);
						$('#coachInfo input[name="coachnum"]').val(data.coachnum);
						$('#coachInfo input[name="carBrand"]').val(data.carBrand);
						$('#coachInfo input[name="carPlate"]').val(data.carPlate);
						$('#coachInfo input[name="star"][value=' + data.star + ']').attr("checked",true);
						$('#coachInfo select[name="station"]').val(data.stationId);
						
						var params = {
								id : data.stationId,
								insId : insId
						};
						$.post('${ctx}/serviceStation/findStationArea',params, function(results) {
							if (results.code == 200) {
								$('#coachInfo select[name="area"]').val(results.data.area);
								var params = {
										area : results.data.area,
										insId : insId
									};
									$("#coachInfo select[name='station']").empty();
									$("#coachInfo select[name='station']").append("<option value='0'>请选择</option>");
									$.post('${ctx}/serviceStation/findByArea', params, function(result) {
										if (result.code == 200) {
											for (var i = 0; i < result.data.length; i++) {
												$("#coachInfo select[name='station']").append("<option value='" + result.data[i].id + "'>" + result.data[i].name + "</option>");
												if(results.data.id == result.data[i].id ){
													$('#coachInfo select[name="station"]').val(results.data.id);
												}
											}
										}
									});
								
							}
						});
						
						$('#coachInfo select[name="drivingFieldId"]').val(data.drivingFieldId);
						if(data.price != null){
							$('#coachInfo input[name="firstAfterSchooL"][value="firstAfterSchooL"]').attr("checked",true);
							$('#coachInfo input[name="timeCharges"]').val(data.price/100);
							$('#coachInfo input[name="timeCharges"]').toggle();
						}
					}
				});
			}
		}
		
	function save(){
		//时间判断函数
		function pad2(n) { return n < 10 ? '0' + n : n }
		//从form中取参数值
		//var id = $('#coachInfo input[name="id"]').val();
		//var insId = $('#coachInfo input[name="insId"]').val();
		var name = $('#coachInfo input[name="name"]').val();
		var mobile = $('#coachInfo input[name="mobile"]').val();
		var idcard = $('#coachInfo input[name="idcard"]').val();
		var timeCharges = $('#coachInfo input[name="timeCharges"]').val();
		var sex = $('#coachInfo input[name="sex"]:checked').val();
		var address = $('#coachInfo input[name="address"]').val();
		var photo = $('img[name="photo"]').attr("src");
		var fingerprint = $('#coachInfo input[name="fingerprint"]').val();
		var drilicence = $('#coachInfo input[name="drilicence"]').val();
		var receiveTime = $('#coachInfo input[name="receiveTime"]').val();
		//驾驶证初领日期
		var countryFstdrilicdate;
		if(receiveTime!=""){
			var date = new Date(receiveTime);
			var countryFstdrilicdate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
		}  
		var dripermitted = $('#coachInfo input[name="dripermitted"]:checked').val();
		var teachpermitted = $('#coachInfo input[name="teachpermitted"]:checked').val();
		var occupationlevel = $('#coachInfo input[name="occupationlevel"]:checked').val();
		var employstatus = $('#coachInfo input[name="employstatus"]:checked').val();
		var firstAfterSchooL = $('#coachInfo input[name="firstAfterSchooL"]:checked').val();
		
		var subject = $('#coachInfo input[name="subject"]').val();
		var birth = $('#coachInfo input[name="birth"]').val();
		var hiredate = $('#coachInfo input[name="hiredate"]').val();
		//入职时间
		var countryHiredate;
		if(hiredate!=""){
			var date = new Date(hiredate);
			var countryHiredate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
		}
		var drivingTime = $('#coachInfo input[name="drivingTime"]').val();
		var leavedate = $('#coachInfo input[name="leavedate"]').val();
		//离职时间
		var countryLeavedate;
		if(leavedate!=""){
			var date = new Date(leavedate);
			var countryLeavedate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
		}
		var coachnum = $('#coachInfo input[name="coachnum"]').val();
		var carBrand = $('#coachInfo input[name="carBrand"]').val();
		var carPlate = $('#coachInfo input[name="carPlate"]').val();
		var star = $('#coachInfo input[name="star"]:checked').val();
		var stationId = $('#coachInfo select[name="station"]').val();
		var language = $('#coachInfo input[name="language"]:checked').val();
		var drivingFieldId = $('#coachInfo select[name="drivingFieldId"]').val();//练车场地ID
		if(name==""||mobile==""||idcard==""||subject==""||drilicence==""||dripermitted==""||teachpermitted==""||stationId==""||employstatus==""){
			alert("请添加完成必要信息！");
			return false;
		}
		//定义提交到服务端的数据对象
		/* var fileParam = {
			"type" :'coachimg',
			"url" :photo,
			"level" :1
		};
		//发送数据到后端保存
		$.post('http://192.168.1.6:8000/upload/file/url',fileParam,function(urlResult) {
			if (urlResult.errorcode == 0) {
				//定义提交到服务端的数据对象
				 var param = {
					"inscode" :"2236581429084424",
					"name" : name,
					"sex" : sex,
					"idcard" : idcard,
					"mobile" : mobile,
					"address" : address,
					"photo" :urlResult.data.id,
					"fingerprint" : fingerprint,
					"drilicence" : drilicence,
					"fstdrilicdate" : countryFstdrilicdate,
					"occupationno":"",
					"occupationlevel" : occupationlevel,
					"dripermitted" : dripermitted,
					"teachpermitted" : teachpermitted,
					"employstatus" : employstatus,
					"hiredate" : countryHiredate,
					"leavedate" : countryLeavedate
				};
				
				//发送数据到后端保存
				$.post('http://192.168.1.6:8000/country/coach',param,function(result) {
					if (result.errorcode == 0) { */
						//定义提交到服务端的数据对象
						var params = {
							"id" : id,
							"insId" :1,
							"name" : name,
							"mobile" : mobile,
							"idcard" : idcard,
							"sex" : sex,
							"address" : address,
							"photo" : photo,
							"fingerprint" : fingerprint,
							"drilicence" : drilicence,
							"receiveTime" : receiveTime,
							"dripermitted" : dripermitted,
							"teachpermitted" : teachpermitted,
							"occupationlevel" : occupationlevel,
							"employstatus" : employstatus,
							"subject" : subject,
							"birth" : birth,
							"hiredate" : hiredate,
							"leavedate" : leavedate,
							"coachnum" :result.data.coachnum,
							"carBrand" : carBrand,
							"carPlate" : carPlate,
							"star" : star,
							"stationId" : stationId,
							"drivingTime" : drivingTime,
							"drivingFieldId" : drivingFieldId,
							"language" : language,
							"timeCharges" : timeCharges,
							"firstAfterSchooL":firstAfterSchooL
						};
						$.post('${ctx}/coach', params, function(results) {
							if (results.code == 200) {
								var dialog = new GRI.Dialog({
									type : 4,
									title : '保存教练信息',
									content : '保存成功',
									deGRIil : '',
									btnType : 3,
									extra : {
										top : 250
									},
									winSize : 1
								}, function() {
									if(!id || id != ''){
										window.location.href = "${ctx}/view/mg/coachView?id="+results.data.id;
									}
								});
							} else {
								//打开错误提示框
								$('#editorModal').modal('show');
							}
							$('#save_btn').attr('disabled',false);
						});
				/*  }else{
					alert(result.message)
				}
			}); 
			}
		}); */
	} 
		
		//日期插件
	function getNowFormatDate() {
	    var date = new Date();
	    var seperator1 = "-";
	    var year = date.getFullYear();
	    var month = date.getMonth() + 1;
	    var strDate = date.getDate();
	    if (month >= 1 && month <= 9) {
	       month = "0" + month;
	    }
	    if (strDate >= 0 && strDate <= 9) {
	    	strDate = "0" + strDate;
	    }
	    var currentdate = year + seperator1 + month + seperator1 + strDate;
	    return currentdate;
	 }
	
	var isChecked;
	if($('#firstAfterSchooL').is(':checked')) {
		isChexked = true;
	}else{
		isChexked = false;
	}
	$("#label1").click(function(){
		if(isChexked){
			$("#timeCharges").hide();
			isChexked = false;
		}else{
			$("#timeCharges").show();	
			isChexked = true ;
		}
	})
	
		

</script>

</body>
</html>