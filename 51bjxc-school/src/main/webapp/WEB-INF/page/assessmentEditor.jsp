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

<title>阳光驾培-考核员信息修改</title>
</head>

<body>
	<div class="container-fluid">
		<div id="pad-wrapper" class="new-form">
			<div class="row-fluid header">
				<h3>编辑考核员信息</h3>
			</div>

			<div class="row-fluid form-wrapper">
				<form id="coachInfo" class="inline-input registerform"
					action="${ctx}/coach/saveCoach" method="post">
					<!-- left column -->
					<div class="span7 with-sidebar">
						<div class="container">

							<div class="span12 field-box">
								<label><span class="need">&#42;</span>培训机构编号：</label> 
								<input type="text" class="span9 inputxt" datatype="*" name="inscode" id="inscode" value=""> 
								<input type="hidden" name="id" id="id" value="${param.id}"> 
								<input type="hidden" name="insId" id="insId" value="<sec:authentication property="principal.insId"/>">
							</div>
							
							<div class="span12 field-box">
								<label><span class="need">&#42;</span>姓名：</label> <input
									type="text" class="span9 inputxt" datatype="*" name="name"
									id="name" value="">
							</div>

							<div class="span12 field-box">
								<label><span class="need">&#42;</span>性别：</label> 
								<label>
									<input type="radio" name="sex" value="1">
									男
								</label> 
								<label> 
									<input type="radio" name="sex" value="2">
									女
								</label>
							</div>

							<div class="span12 field-box">
								<label><span class="need">&#42;</span>身份证号：</label> <input
									type="text" class="span9 inputxt" datatype="*" name="idcard"
									id="idcard" value="">
							</div>

							<div class="span12 field-box">
								<label><span class="need">&#42;</span>手机号：</label> <input
									type="text" class="span9 inputxt" datatype="*" name="mobile"
									id="mobile" value="">
							</div>

							<div class="span12 field-box">
								<label><span class="need"></span>联系地址：</label> <input
									type="text" class="span9 inputxt" datatype="*" name="address"
									id="address" value="">
							</div>

							<div class="span12 field-box">
								<label>驾驶证号：</label> <input
									type="text" class="span9 inputxt" datatype="*"
									name="drilicence" id="drilicence" value="">
							</div>
							<div class="span12 field-box">
								<label><span class="need">&#42;</span>驾驶证初领日期：</label> <input type="text" name="fstdrilicdate"
									class="form_date" data-date-format="yyyy-mm-dd" readonly="readonly"
									value=''>
							</div>
							<div class="span12 field-box">
								<label>职业资格证号：</label> <input
									type="text" class="span9 inputxt" datatype="*"
									name="occupationno" id="occupationno" value="">
							</div>

							<div class="span12 field-box">
								<label>职业资格证等级：</label> 
								<label>
									<input type="radio" name="occupationlevel" id="occupationlevel"  value="1">
									一级
								</label> 
								<label> 
									<input type="radio" name="occupationlevel" id="occupationlevel" value="2">
									二级
								</label>
								<label> 
									<input type="radio" name="occupationlevel" id="occupationlevel" value="3">
									三级
								</label>
								<label> 
									<input type="radio" name="occupationlevel" id="occupationlevel" value="4">
									四级
								</label>
							</div>
							<div class="span12 field-box">
								<label>准驾车型：</label> 
									<select id="dripermitted" name="dripermitted">
										<option  value="A1">A1</option>
										<option  value="A2">A2</option>
										<option  value="A3">A3</option>
										<option  value="B1">B1</option>
										<option  value="B2">B2</option>
										<option  value="C1">C1</option>
										<option  value="C2">C2</option>
										<option  value="C3">C3</option>
										<option  value="C4">C4</option>
										<option  value="C5">C5</option>
										<option  value="D">D</option>
										<option  value="E">E</option>
										<option  value="F">F</option>
										<option  value="M">M</option>
										<option  value="N">N</option>
										<option  value="P">P</option>
									</select>
							</div>
							<div class="span12 field-box">
								<label>准教车型：</label> 
									<select id="teachpermitted" name="teachpermitted">
										<option  value="A1">A1</option>
										<option  value="A2">A2</option>
										<option  value="A3">A3</option>
										<option  value="B1">B1</option>
										<option  value="B2">B2</option>
										<option  value="C1">C1</option>
										<option  value="C2">C2</option>
										<option  value="C3">C3</option>
										<option  value="C4">C4</option>
										<option  value="C5">C5</option>
										<option  value="D">D</option>
										<option  value="E">E</option>
										<option  value="F">F</option>
										<option  value="M">M</option>
										<option  value="N">N</option>
										<option  value="P">P</option>
									</select>
							</div>
							<div class="span12 field-box">
								<label><span class="need">&#42;</span>供职状态：</label> 
								<label>
									<input type="radio" name="employstatus"  value="0">
									在职
								</label> 
								<label> 
									<input type="radio" name="employstatus" value="1">
									离职
								</label>
							</div>
							
							<div class="span12 field-box">
								<label><span class="need">&#42;</span>入职时间日期：</label> <input type="text" name="hiredate"
									class="form_date" data-date-format="yyyy-mm-dd" readonly="readonly"
									value=''>
							</div>
							<div class="span12 field-box">
								<label>离职时间日期：</label> <input type="text" name="leavedate"
									class="form_date" data-date-format="yyyy-mm-dd" readonly="readonly"
									value=''>
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
										<img id="photourl" name="photourl" src="" class="img-thumbnail">
										<a style="margin-top: 20px;" class="btn-glow">上传照片</a>
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

		var current_action = "${ctx}/view/mg/assessmentEditor"; 
		var id = '${param.id}';
		var insId = '<sec:authentication property="principal.insId"/>';
		$(document).ready(function() {
			initForm();
			if(id){
				initFormData(id);
			}
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
					$("#photourl").attr('src', datajson.data.s);
					console.log(data);
				}
			});
			
		}

		/**
		 *	展示编辑表单界面
		 *	新增、修改都需要调用该方法打开表单
		 */
		function initFormData(id) {
			if (id) {
				//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
				$.getJSON("${ctx}/examiner/" + id,function(result) {
					console.log(result);
					if (result.code == 200) {
						var data = result.data;
						$('#coachInfo input[name="id"]').val(data.id);
						$('#coachInfo input[name="inscode"]').val(data.inscode);
						$('#coachInfo input[name="name"]').val(data.name);
						$('#coachInfo input[name="sex"][value=' + data.sex + ']').attr("checked",true);
						$('#coachInfo input[name="idcard"]').val(data.idcard);
						$('#coachInfo input[name="mobile"]').val(data.mobile);
						$('#coachInfo input[name="address"]').val(data.address);
						$('#coachInfo input[name="drilicence"]').val(data.drilicence);
						$('#coachInfo input[name="fstdrilicdate"]').val(data.fstdrilicdate);
						$('#coachInfo select[name="dripermitted"]').val(data.dripermitted);
						$('#coachInfo select[name="teachpermitted"]').val(data.teachpermitted);
						$('#coachInfo input[name="employstatus"][value=' + data.employstatus + ']').attr("checked",true);
						$('#coachInfo input[name="hiredate"]').val(data.hiredate);
						$('#coachInfo input[name="leavedate"]').val(data.leavedate);
						$('img[name="photourl"]').attr("src",data.photourl);
						$('#coachInfo input[name="occupationno"]').val(data.occupationno);
						$('#coachInfo input[name="occupationlevel"][value=' + data.occupationlevel + ']').attr("checked",true);
					}
				});
			}
			/* $('#editorModal').modal('show'); */
		}	
		
	function save(){
		//时间判断函数
		function pad2(n) { return n < 10 ? '0' + n : n }
		
		var id = $('#coachInfo input[name="id"]').val();
		var inscode=$('#coachInfo input[name="inscode"]').val();
		var name = $('#coachInfo input[name="name"]').val();
		var sex = $('#coachInfo input[name="sex"]:checked').val();
		var idcard = $('#coachInfo input[name="idcard"]').val();
		var mobile = $('#coachInfo input[name="mobile"]').val();
		var address = $('#coachInfo input[name="address"]').val();
		var drilicence = $('#coachInfo input[name="drilicence"]').val();
		//驾驶证初领日期
		var fstdrilicdate = $('#coachInfo input[name="fstdrilicdate"]').val();
		var countryFstdrilicdate;
		if(fstdrilicdate!=""){
			var date = new Date(fstdrilicdate);
			var countryFstdrilicdate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
		}    
		var dripermitted = $('#coachInfo select[name="dripermitted"]').val();
		var teachpermitted = $('#coachInfo select[name="teachpermitted"]').val();
		var employstatus = $('#coachInfo input[name="employstatus"]:checked').val();
		//入职时间
		var hiredate = $('#coachInfo input[name="hiredate"]').val();
		var countryHiredate;
		if(hiredate!=""){
			var date = new Date(hiredate);
			var countryHiredate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
		}
	    //离职时间
		var leavedate = $('#coachInfo input[name="leavedate"]').val();
	    var countryLeavedate;
		if(leavedate!=""){
			var date = new Date(leavedate);
			var countryLeavedate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
		}
		var photoUrl = $('img[name="photourl"]').attr("src");
		var occupationno = $('#coachInfo input[name="occupationno"]').val();
		var occupationlevel = $('#coachInfo input[name="occupationlevel"]:checked').val();
		if(inscode==""||name==""||sex==""||idcard==""|| mobile==""||employstatus==""||hiredate==""){
			alert("请添加完成必要信息！");
			return false;
		}
		//定义提交到服务端的数据对象
		var fileParam = {
			"type" :'examinerimg',
			"url" :photoUrl,
			"level" :1
		};
		//发送数据到后端保存
		$.post('http://192.168.1.6:8000/upload/file/url',fileParam,function(urlResult) {
			if (urlResult.errorcode == 0) {
			//定义提交到服务端的数据对象
			var param = {
				"inscode" : inscode,
				"name" : name,
				"sex" : sex,
				"idcard" : idcard,
				"mobile" : mobile,
				"address" : address,
				"photo" :urlResult.data.id ,
				"drilicence" : drilicence,
				"fstdrilicdate" :countryFstdrilicdate,
				"occupationno" : occupationno,
				"occupationlevel" : occupationlevel,
				"dripermitted" : dripermitted,
				"teachpermitted" : teachpermitted,
				"employstatus" : employstatus,
				"hiredate" : countryHiredate,
				"leavedate" : countryLeavedate
			};
			//发送数据到后端保存
			$.post('http://192.168.1.6:8000/country/examiner',param,function(result) {
				if (result.errorcode == 0) {
					//定义提交到服务端的数据对象
					var params = {
						"id" : id,
						"inscode" : inscode,
						"name" : name,
						"sex" : sex,
						"idcard" : idcard,
						"mobile" : mobile,
						"address" : address,
						"drilicence" : drilicence,
						"fstdrilicdate" : fstdrilicdate,
						"dripermitted" : dripermitted,
						"teachpermitted" : teachpermitted,
						"employstatus" : employstatus,
						"hiredate" : hiredate,
						"leavedate" : leavedate,
						"photo" : 1,
						"fingerprint" :"",
						"occupationno" : occupationno,
						"occupationlevel" :occupationlevel,
						"photourl":photoUrl,
						"examnum":result.data.examnum
					};
					$.post('${ctx}/examiner/saveOrUpdate', params, function(result) {
						if (result.code == 200) {
							var dialog = new GRI.Dialog({
								type : 4,
								title : '保存考核员信息',
								content : '保存成功',
								deGRIil : '',
								btnType : 3,
								extra : {
									top : 250
								},
								winSize : 1
							}, function() {
								if(!id || id != ''){
									window.location.href = "${ctx}/view/assessment";
								}
							});
						} else {
							//打开错误提示框
							$('#editorModal').modal('show');
						}
						$('#save_btn').attr('disabled',false);
					});
				}else{
					alert(result.message)
				}
			});
			}
		});
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