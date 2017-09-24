<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<meta name="theme" content="page" />
<link type="text/css" href="${ctx}/resources/css/compiled/new-form.css" rel="stylesheet" />
<link href="${ctx}/resources/css/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
<link href="${ctx}/resources/js/form-prompt/style.css" type="text/css" rel="stylesheet" media="all" />
<script src="${ctx}/resources/uploadify/jquery.uploadify.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/classType/<sec:authentication property="principal.insId"/>"></script>
<script type="text/javascript" src="${ctx}/resources/js/serviceStation/<sec:authentication property="principal.insId"/>"></script>
<title>阳光驾培-学员信息报错处理</title>
</head>
<body>
	<div class="container-fluid">
		<div id="pad-wrapper" class="new-form">
			<div class="row-fluid header">
				<h3>学员信息报错处理</h3>
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
						<form id="ediorForm" class="inline-input registerform" action="${ctx}/coach/addOrUpd" method="post">

							<div class="span12 field-box">
								<label><span class="need">&#42;</span>姓名：</label> 
									<input type="text" class="span9" datatype="*" name="name" id="name" value="${referee.name}"> 
									<input type="hidden" name="id" id="id" value="${param.id}">
									<input type="hidden" name="refereeId" id="refereeId" value="${referee.id}">
									<input type="hidden" name="insId" value="<sec:authentication property="principal.insId"/>">
							</div>

							<div class="span12 field-box">
								<label><span class="need">&#42;</span>性别：</label> 
								<label> <input type="radio" name="sex" value="1" <c:if test="${referee.sex==1}">checked="checked"</c:if>>
									男
								</label> 
								<label> <input type="radio" name="sex" value="2" <c:if test="${referee.sex==2}">checked="checked"</c:if>>
									女
								</label>
							</div>

							<div class="span12 field-box">
								<label><span class="need">&#42;</span>电话号码：</label> <input type="text" class="span9" datatype="*"
									name="mobile" id="mobile" value="${referee.mobile}">
							</div>

							<div class="span12 field-box">
								<label><span class="need">&#42;</span>证件类型：</label> 
								<label><input type="radio" name="cradtype" value="1" checked="checked">身份证</label>
								<label><input type="radio" name="cradtype" value="2"> 护照</label> 
								<label><input type="radio" name="cradtype" value="3"> 军官证</label>
								<label><input  type="radio" name="cradtype" value="4"> 其它</label>
							</div>

							<div class="span12 field-box">
								<label><span class="need">&#42;</span>证件号：</label> <input type="text" class="span9" datatype="*"
									name="idcard" id="idcard" value="${referee.idcard}">
							</div>

							<div class="span12 field-box">
								<label><span class="need">&#42;</span>地址：</label> <input type="text" class="span9" datatype="*"
									name="address" id="address" value="${referee.address}">
							</div>
							
							<div class="span12 field-box">
								<label>业务类型：</label>
								
								<label><input  type="radio" name="busitype" value="0" checked="checked"> 初领</label> 
								<label><input  type="radio" name="busitype" value="1"> 增领</label>
								<label> <input  type="radio" name="busitype" value="2"> 其它</label>
							</div>
							<div class="span12 field-box">
								<label>学员编号：</label>
								 <input type="text" class="span9" datatype="*"
									name="stunum" id="stunum" value="">
							</div>

							<div class="span12 field-box">
								<label>培训车型：</label>
								<label><input  type="radio" name="traintype" value="C1" checked="checked"> C1</label> 
								<label><input  type="radio" name="traintype" value="C2"> C2</label>
							</div>
							
							<div class="span12 field-box">
								<label>状态：</label> 
								<label><input type="radio" name="status" value="1" checked="checked"> 报名</label> 
								<label><input type="radio" name="status" value="2"> 学习中</label> 
								<label><input type="radio" name="status" value="3"> 拿到驾照</label>
								<label><input type="radio" name="status" value="-1"> 失效 </label> 
							</div>
							
							<div class="span12 field-box">
								<label>培训班型：</label>
								<input type="hidden" id="classType" value="${referee.classType}">
								<select class="span5" name="classTypeId">
								
								</select>
							</div>
							<div class="span12 field-box">
									<label><span class="need">&#42;</span>学费：</label> 
								
								<span class="span3 small" >
									应付：
									<input class="small" type="number" value="${referee.price}" name="tuition" placeholder="0.0">
								</span>
								<span class="span3 small">
									已付：
									<input class="small" type="number" value="${referee.money}" name="alreadyPay" placeholder="0.0">
								</span>
								<span class="span3 small">
									欠付：
									<input class="small" type="number" name="arrearage" placeholder="0.0">
								</span>
							</div>
							<div class="span12 field-box">
								<label><span class="need">&#42;</span>服务网点：</label>
								<select class="span5" name="stationId">
								
								</select>
							</div>
							<div class="span12 field-box">
								<label>驾驶证号：</label> <input class="span9" type="text" name="drilicnum">
							</div>
							
							<div class="span12 field-box">
								<label>初次领证日期：</label> 
								<input  type="text" name="fstdrilicdate"  class="form_date" data-date-format="yyyy-mm-dd"  readonly="readonly">
							</div>

							<div class="span12 field-box">
								<label>原准驾车型：</label> <input class="span9" type="text" name="perdritype">
							</div>
							<div class="span12 field-box">
								<label>报名时间：</label> <input type="text" name="applydate"  class="form_date" data-date-format="yyyy-mm-dd" readonly="readonly" value="${referee.createTime}">
							</div>
							<div class="span12 field-box">
								<label>推荐人：</label> <input type="text" name="refereeMobile" value="${referee.refereeMobile}">
							</div>
							<div class="span12 field-box">
								<label>是否处理：</label> <input type="checkbox" name="isWrong" value="0">
							</div>
							
							<div class="span11 field-box actions">
								<input id="save_btn" type="button" class="btn-glow primary" value="处理"
									onclick="save()" /> <span>&nbsp;</span>
							</div>
						</form>
					</div>
				</div>


				<!-- side right column -->
				<div class="span3 form-sidebar pull-right">
					<div class="rk_swfupload">
						<div class="col-md-3 ">
							<div class="rk_swfupload">
								<div style="height: 60px; width: 100px; display: inline-block;">
									<img id="photo" name="photo" src=""
										class="img-thumbnail">
										<a style="margin-top:20px;" class="btn-glow">
											上传学员照片
										</a>
								</div>
								<div class="swfobj">
									<div id="upload_buton_img"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		var current_action = "${ctx}/view/studentEditor";
		var id = '${param.id}';
		var statId= <sec:authentication property="principal.stationId"/>;
		$(document).ready(function() {
			initForm();
			if(id){
				initFormData(id);
			}
		});
		
		function initForm(){
			var newTime = getNowFormatDate();
			$('#ediorForm input[name="applydate"]').val(newTime);

			$('#ediorForm select[name="classTypeId"]').append("<option value=''>请选择班型</option>");
			var classType=$("#classType").val();
			$(classTypes).each(function(item){
				if(this.id==classType){
					$('#ediorForm select[name="classTypeId"]').append("<option value='" + this.id + "' selected='selected'>" + this.name + "</option>");
				}
				$('#ediorForm select[name="classTypeId"]').append("<option value='" + this.id + "'>" + this.name + "</option>");
			});
			

			$('#ediorForm select[name="stationId"]').append("<option value=''>请选择服务网点</option>");
			$(serviceStations).each(function(item){
				$('#ediorForm select[name="stationId"]').append("<option value='" + this.id + "'>" + this.name + "</option>");
			});
			if(statId){
				$('#ediorForm select[name="stationId"]').val(statId);
			}
			
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
		
		/**
		 *	展示编辑表单界面
		 *	新增、修改都需要调用该方法打开表单
		 */
		function initFormData(id) {
			if (id) {
				//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
				$.getJSON("${ctx}/student/" + id,function(result) {
					console.log(result);
					if (result.code == 200) {
						var data = result.data;
						$('#ediorForm input[name="id"]').val(data.id);
						$('#ediorForm input[name="userId"]').val(data.userId);
						$('#ediorForm input[name="insId"]').val(data.insId);
						$('#ediorForm input[name="name"]').val(data.name);
						$('#ediorForm input[name="mobile"]').val(data.mobile);
						$('#ediorForm input[name="cradtype"][value=' + data.cradtype + ']').attr("checked",true);
						$('#ediorForm input[name="idcard"]').val(data.idcard);
						$('#ediorForm input[name="nationality"]').val(data.nationality);
						$('#ediorForm input[name="sex"][value=' + data.sex + ']').attr("checked",true);
						$('#ediorForm input[name="address"]').val(data.address);
						$('img[name="photo"]').attr("src",data.photo);
						$('#ediorForm input[name="fingerprint"]').val(data.fingerprint);
						$('#ediorForm input[name="busitype"][value=' + data.busitype + ']').attr("checked",true);
						$('#ediorForm input[name="drilicnum"]').val(data.drilicnum);
						$('#ediorForm input[name="fstdrilicdate"]').val(data.fstdrilicdate);
						$('#ediorForm input[name="perdritype"]').val(data.perdritype);
						$('#ediorForm input[name="traintype"][value=' + data.traintype + ']').attr("checked",true);
						$('#ediorForm input[name="applydate"]').val(data.applydate);
						$('#ediorForm input[name="status"][value=' + data.status + ']').attr("checked",true);
						$('#ediorForm input[name="stunum"]').val(data.stunum);
						$('#ediorForm select[name="stationId"]').val(data.stationId);
						$('#ediorForm select[name="classTypeId"]').val(data.classTypeId);
						$('#ediorForm input[name="tuition"]').val(data.tuition);
						$('#ediorForm input[name="alreadyPay"]').val(data.alreadyPay);
						$('#ediorForm input[name="arrearage"]').val(data.arrearage);
					}
				});
			}
			/* $('#editorModal').modal('show'); */
		}
		//保存
		function save() {
			$('#save_btn').attr('disabled',true);
			//从form中取参数值
			var id = $('#ediorForm input[name="id"]').val();
			var isWrong = $('#ediorForm input[name="isWrong"]:checked').val();
			//定义提交到服务端的数据对象
			var params = {
				'id' : id,
				"isWrong" : isWrong
			};
			//发送数据到后端保存
			$.post('${ctx}/student/studentHandle', params, function(result) {
				if (result.code == 200) {
					var dialog = new GRI.Dialog({
						type : 4,
						title : '处理学员信息报错',
						content : '处理成功',
						deGRIil : '',
						btnType : 3,
						extra : {
							top : 250
						},
						winSize : 1
					}, function() {
			
						if(!id || id != ''){
							window.location.href = "${ctx}/view/studentBaocuo";
						}
					});
				} else {
					//打开错误提示框
					$('#editorModal').modal('show');
				}
				$('#save_btn').attr('disabled',false);
			});
		}
		
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
	</script>
</body>
</html>