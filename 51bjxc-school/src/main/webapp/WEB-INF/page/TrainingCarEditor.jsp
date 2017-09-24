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

<title>阳光驾培-教练车信息修改</title>
</head>

<body>
	<div class="container-fluid">
		<div id="pad-wrapper" class="new-form">
			<div class="row-fluid header">
				<h3>编辑教练车信息</h3>
			</div>

			<div class="row-fluid form-wrapper">
				<form id="coachInfo" class="inline-input registerform"
					action="${ctx}/coach/saveCoach" method="post">
					<!-- left column -->
					<div class="span7 with-sidebar">
						<div class="container">

							<div class="span12 field-box">
								<label>培训机构编号：</label> 
								<input type="text" class="span9 inputxt" datatype="*" name="inscode" readonly="readonly" id="inscode" value="<sec:authentication property="principal.insId"/>"> 
								<input type="hidden" name="id" id="id" value="${car.id}"> 
								<input type="hidden" name="insId" id="insId" value="<sec:authentication property="principal.insId"/>">
							</div>
							
							<div class="span12 field-box">
								<label>车牌号：</label> <input
									type="text" class="span9 inputxt" datatype="*" name="licnum"
									id="licnum" value="${car.licnum}">
							</div>

							<div class="span12 field-box">
								<label>颜色：</label> 
								<label>
									<input type="radio" name="platecolor" id="platecolor" 
										<c:if test="${car.platecolor==1}"> checked="checked" </c:if> value="1">
									蓝色
								</label> 
								<label> 
									<input type="radio" name="platecolor" id="platecolor"
										<c:if test="${car.platecolor==2}"> checked="checked" </c:if> value="2">
									黄色
								</label>
								<label> 
									<input type="radio" name="platecolor" id="platecolor"
										<c:if test="${car.platecolor==3}"> checked="checked" </c:if>  value="3">
									黑色
								</label>
								<label> 
									<input type="radio" name="platecolor" id="platecolor"
										<c:if test="${car.platecolor==4}"> checked="checked" </c:if>  value="4">
									白色
								</label>
								<label> 
									<input type="radio" name="platecolor" id="platecolor"
										<c:if test="${car.platecolor==5}"> checked="checked" </c:if>  value="5">
									绿色
								</label>
								<label> 
									<input type="radio" name="platecolor" id="platecolor"
										<c:if test="${car.platecolor==9}"> checked="checked" </c:if>  value="9">
									其它
								</label>
							</div>

							<div class="span12 field-box">
								<label>车架号：</label> <input
									type="text" class="span9 inputxt" datatype="*" name="franum"
									id="franum" value="${car.franum}">
							</div>

							<div class="span12 field-box">
								<label>生产厂家：</label> <input
									type="text" class="span9 inputxt" datatype="*" name="manufacture"
									id="manufacture" value="${car.manufacture}">
							</div>

							<div class="span12 field-box">
								<label><span class="need">&#42;</span>发动机号：</label> <input
									type="text" class="span9 inputxt" datatype="*" name="engnum"
									id="engnum" value="${car.engnum}">
							</div>

							<div class="span12 field-box">
								<label>车辆品牌：</label> <input
									type="text" class="span9 inputxt" datatype="*"
									name="brand" id="brand" value="${car.brand}">
							</div>

							<div class="span12 field-box">
								<label><span class="need">&#42;</span>车辆型号：</label> <input type="text" class="span9 inputxt"
									datatype="*" name="model" id="model"
									value="${car.model}">
							</div>

							<div class="span12 field-box">
								<label>培训车型：</label> 
									<select id="perdritype" name="perdritype">
										<option <c:if test="${car.perdritype=='A1'}">selected="selected"</c:if> value="A1">A1</option>
										<option <c:if test="${car.perdritype=='A2'}">selected="selected"</c:if> value="A2">A2</option>
										<option <c:if test="${car.perdritype=='A3'}">selected="selected"</c:if> value="A3">A3</option>
										<option <c:if test="${car.perdritype=='B1'}">selected="selected"</c:if> value="B1">B1</option>
										<option <c:if test="${car.perdritype=='B2'}">selected="selected"</c:if> value="B2">B2</option>
										<option <c:if test="${car.perdritype=='C1'}">selected="selected"</c:if> value="C1">C1</option>
										<option <c:if test="${car.perdritype=='C2'}">selected="selected"</c:if> value="C2">C2</option>
										<option <c:if test="${car.perdritype=='C3'}">selected="selected"</c:if> value="C3">C3</option>
										<option <c:if test="${car.perdritype=='C4'}">selected="selected"</c:if> value="C4">C4</option>
										<option <c:if test="${car.perdritype=='C5'}">selected="selected"</c:if> value="C5">C5</option>
										<option <c:if test="${car.perdritype=='D'}">selected="selected"</c:if> value="D">D</option>
										<option <c:if test="${car.perdritype=='E'}">selected="selected"</c:if> value="E">E</option>
										<option <c:if test="${car.perdritype=='F'}">selected="selected"</c:if> value="F">F</option>
										<option <c:if test="${car.perdritype=='M'}">selected="selected"</c:if> value="M">M</option>
										<option <c:if test="${car.perdritype=='N'}">selected="selected"</c:if> value="N">N</option>
										<option <c:if test="${car.perdritype=='P'}">selected="selected"</c:if> value="P">P</option>
									</select>
							</div>

							<div class="span12 field-box">
								<label><span class="need">&#42;</span>购买日期：</label> <input type="text" name="buydate"
									class="form_date" data-date-format="yyyy-mm-dd" 
									value='${car.buydate}'>
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
										<img id="photo" name="photo" src="${car.photourl}" class="img-thumbnail">
										<a style="margin-top: 20px;" class="btn-glow"> 上传教练车照片 </a>
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
			/*
			if(id){
				initFormData(id);
			}*/
		});
		
		function initForm(){
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
			
		}
		
	function pad2(n) { return n < 10 ? '0' + n : n }	
	function save(){
		$('#save_btn').attr('disabled',true);
		var id=$('#coachInfo input[name="id"]').val();
		var inscode = $('#coachInfo input[name="inscode"]').val();
		var licnum = $('#coachInfo input[name="licnum"]').val();
		var platecolor = $('#coachInfo input[name="platecolor"]:checked').val();
		var manufacture = $('#coachInfo input[name="manufacture"]').val();
		var franum = $('#coachInfo input[name="franum"]').val();
		var engnum = $('#coachInfo input[name="engnum"]').val();
		var brand = $('#coachInfo input[name="brand"]').val();
		var model = $('#coachInfo input[name="model"]').val();
		var perdritype = $('#perdritype').val();
		var buydate = $('#coachInfo input[name="buydate"]').val();
		var photourl = $('img[name="photo"]').attr("src");
		
		if(engnum==""||model==""||buydate==""){
			alert("请添加完成必要信息！");
			$('#save_btn').attr('disabled',false);
			return false;
		}
		var date = new Date(buydate);
		var buydates = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
		
		var fileParam = {
			"type" :'vehimg',
			"url" :photourl,
			"level" :1
		};
		var photo=null;
		$.post('http://192.168.1.6:8000/upload/file/url',fileParam,function(urlResult) {
			if(urlResult.errorcode!=0){
				alert(urlResult.message);
				return false;
			}else{
				photo=urlResult.id;
			}
		});
		
		var params = {
			"inscode" : '2236581429084424',
			"licnum" : licnum,
			"platecolor" : platecolor,
			"manufacture" : manufacture,
			"franum" : franum,
			"photo" : photo,
			"engnum" : engnum,
			"brand" : brand,
			"model" : model,
			"perdritype" : perdritype,
			"buydate" : buydates,
		};
		var carnum;
		$.post('http://192.168.1.6:8000/country/trainingcar', params, function(result) {
			$('#save_btn').attr('disabled',false);
			carnum=result.data.carnum;
			if(result.errorcode!=0){
				alert(result.message);
				return false;
			}
			var param = {
				"id" : id,
				"inscode" : inscode,
				"licnum" : licnum,
				"platecolor" : platecolor,
				"manufacture" : manufacture,
				"franum" : franum,
				"engnum" : engnum,
				"brand" : brand,
				"model" : model,
				"perdritype" : perdritype,
				"buydates" : buydate,
				"photourl" : photourl,
				"carnum" : carnum,
			};
			$.post('${ctx}/trainingCar/saveOrUpdate', param, function(result) {
				if (result.code == 200) {
					var dialog = new GRI.Dialog({
						type : 4,
						title : '保存教练车信息',
						content : '保存成功',
						deGRIil : '',
						btnType : 3,
						extra : {
							top : 250
						},
						winSize : 1
					}, function() {
						window.location.href = "${ctx}/view/trainingCar";
					});
				} else {
					//打开错误提示框
					$('#editorModal').modal('show');
				}
				$('#save_btn').attr('disabled',false);
			});
		})
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