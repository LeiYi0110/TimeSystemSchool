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


<title>阳光驾培-编辑培训机构信息</title>
</head>

<body>
<div class="container-fluid new-admin">
		<div class="select-top">
		<sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
			<a class="select-btn"onclick="edit()"><span class="edit"></span>修改</a>
			<sec:authorize access="hasRole('ROLE_TIME_SYSTEM')">
				<a class="select-btn" data-toggle="modal" onClick="upRecord()"><span class="spare"></span>备案</a>
			</sec:authorize>
		</sec:authorize>
		
		<sec:authorize access="hasRole('ROLE_SCHOOL_SERVICE')">
			<sec:authorize access="hasRole('ROLE_UserOperation_35')">
				<a class="select-btn"onclick="edit()"><span class="edit"></span>修改</a>
			</sec:authorize>
			
				<sec:authorize access="hasRole('ROLE_TIME_SYSTEM')">
				<sec:authorize access="hasRole('ROLE_UserOperation_36')">
					<a class="select-btn" data-toggle="modal" onClick="upRecord()"><span class="spare"></span>备案</a>
				</sec:authorize>
				</sec:authorize>
		</sec:authorize>		
		</div>
</div>

			<div class="modal-content institution-form" style=" overflow: hidden; max-height:none; padding:25px;">
				<form id="institutionInfo">
							<div class="row1">
							   <div class="form-controll">
								<label><span class="need">&#42;</span>培训机构编号：</label> 
								<input type="text" datatype="*" name="inscode" id="inscode" value="" disabled> 
								<input type="hidden" name="id" id="id" value="" > 
								<input type="hidden" name="insId" id="insId" value="<sec:authentication property="principal.insId"/>">
								</div>
								<div class="form-controll">
								<label>
									<span class="need">&#42;</span>培训机构名称：
								</label>
									<input type="text"  datatype="*" name="name" id="name" value="" disabled >
								</div>
								<div class="form-controll">
								<label>
									<span class="need">&#42;</span>培训机构简称：
								</label> 
									<input type="text" datatype="*" name="shortName" id="shortName" value="" disabled >
								</div>
							    <div class="form-controll">
							    	<label>
							    		<span class="need">&#42;</span>经营许可证编号：
							  		</label>
							    	<input type="text"  datatype="*" name="licnum" id="licnum" value="" disabled>
								</div>
								<div class="form-controll">
									<label>
										<span class="need">&#42;</span>经营许可日期：
									</label>
									<input type="text"  datatype="*"  name="licetime" id="licetime" value="" class="form_date" data-date-format="yyyy-mm-dd" disabled>
								</div>
								<div class="form-controll">
									<label>
										<span class="need"></span><span class="need">&#42;</span>营业执照注册号：
									</label>
									<input type="text"  datatype="*" name="business" id="business" value="" disabled>
								</div>
							
							    <div class="form-controll">
							    	<label><span class="need">&#42;</span>统一社会信用代码：</label>
							    		<input type="text"  datatype="*" name="creditcode" id="creditcode" value="" disabled>
								</div>
								<div class="form-controll">
									<label><span class="need">&#42;</span>培训机构地址：</label>
									<input type="text"  datatype="*" name="address" id="address" value="" disabled>
								</div>
								<div class="form-controll">
									<label><span class="need">&#42;</span>邮政编码：</label>
									<input type="text"  datatype="*" name="postcode" id="postcode" disabled>
								</div>
							
							    <div class="form-controll">
							    	<label><span class="need">&#42;</span>法人代表：</label>
							    	<input type="text"  datatype="*" name="legal" id="legal" value="" disabled>
								</div>
								<div class="form-controll">
								<label><span class="need">&#42;</span>联系人：</label>
								<input type="text"  datatype="*" name="contact" id="contact" value="" disabled>
								</div>
								<div class="form-controll">
									<label><span class="need">&#42;</span>联系电话：</label>
									<input type="text"  datatype="*" name="phone" id="phone" value="" disabled>
								</div>
							
								<div class="form-controll">
								<label><span class="need">&#42;</span>经营状态：</label> 
									<select id="busistatus" name="busistatus" disabled >
										<option  value="1">营业</option>
										<option  value="2">停业</option>
										<option  value="3">整改</option>
										<option  value="4">停业整顿</option>
										<option  value="5">歇业</option>
										<option  value="6">注销</option>
										<option  value="9">其他</option>
									</select>
								</div>
								<div class="form-controll">
								<label><span class="need">&#42;</span>分类等级：</label> 
									<select id="level" name="level" disabled >
										<option  value="1">A1</option>
										<option  value="2">A2</option>
										<option  value="3">A3</option>
									</select>
								</div>
								<div class="form-controll">
							    	<label><span class="need">&#42;</span>教练场总面积：</label>
							    	<input type="text" name="praticefield" value='' disabled >
								</div>
							    <div class="form-controll">
							    	<label><span class="need">&#42;</span>教练员总数：</label> 
									<input type="text"  datatype="*" name="coachnumber" id="coachnumber" value="" disabled>
								</div>
								<div class="form-controll">
									<label><span class="need">&#42;</span>考核员总数：</label>
									<input type="text" name="grasupvnum" value='' disabled>
								</div>
								<div class="form-controll">
								<label><span class="need">&#42;</span>安全员总数：</label>
									<input type="text" name="safmngnum" value='' disabled >
								</div>
						
							    <div class="form-controll">
							    	<label><span class="need">&#42;</span>教练车总数：</label>
							    	<input type="text" name="tracarnum" value='' disabled >
								</div>
								<div class="form-controll">
									<label>教室总面积：</label>
									<input type="text" name="classroom" value='' disabled >
								</div>
								<div class="form-controll">
									<label>理论教室面积：</label>
									<input type="text" name="thclassroom" value='' disabled >
								</div>
							
							 <div class="form-controll" style="width: 100%;">
							    <label style="margin-bottom: 10px;"><span class="need">&#42;</span>经营范围：</label> 
									<span
									style="padding-right: 5px;"><input type="checkbox"
									name="busiscope" value="A1" style="margin: 0 3px 0 0;" disabled>
									A1</span> <span style="padding-right: 5px;"><input
									type="checkbox" name="busiscope" value="A2"
									style="margin: 0 3px 0 0;" disabled> A2</span> <span
									style="padding-right: 5px;"><input type="checkbox"
									name="busiscope" value="A3" style="margin: 0 3px 0 0;" disabled>
									A3</span> <span style="padding-right: 5px;"><input
									type="checkbox" name="busiscope" value="B1"
									style="margin: 0 3px 0 0;" disabled> B1</span> <span
									style="padding-right: 5px;"><input type="checkbox"
									name="busiscope" value="B2" style="margin: 0 3px 0 0;" disabled>
									B2</span><span
									style="padding-right: 5px;"><input type="checkbox"
									name="busiscope" value="C1" style="margin: 0 3px 0 0;" disabled>
									C1</span> <span style="padding-right: 5px;"><input
									type="checkbox" name="busiscope" value="C2"
									style="margin: 0 3px 0 0;" disabled> C2</span> <span
									style="padding-right: 5px;"><input type="checkbox"
									name="busiscope" value="C3" style="margin: 0 3px 0 0;" disabled>
									C3</span> <span style="padding-right: 5px;"><input
									type="checkbox" name="busiscope" value="C4"
									style="margin: 0 3px 0 0;" disabled> C4</span> <span
									style="padding-right: 5px;"><input type="checkbox"
									name="busiscope" value="C5" style="margin: 0 3px 0 0;" disabled>
									C5</span> <span style="padding-right: 5px;"><input
									type="checkbox" name="busiscope" value="D"
									style="margin: 0 3px 0 0;" disabled> D</span> <span
									style="padding-right: 5px;"><input type="checkbox"
									name="busiscope" value="E" style="margin: 0 3px 0 0;" disabled>
									E</span> <span style="padding-right: 5px;"><input
									type="checkbox" name="busiscope" value="F"
									style="margin: 0 3px 0 0;" disabled> F</span> <span
									style="padding-right: 5px;"><input type="checkbox"
									name="busiscope" value="M" style="margin: 0 3px 0 0;" disabled>
									M</span> <span style="padding-right: 5px;"><input
									type="checkbox" name="busiscope" value="N"
									style="margin: 0 3px 0 0;" disabled> N</span> <span
									style="padding-right: 5px;"><input type="checkbox"
									name="busiscope" value="P" style="margin: 0 3px 0 0;" disabled>
									P</span>
								</div>
								<div class="form-controll" style="width:90%;margin-bottom: 20px;">
									<label>备注：</label>
									<textarea type="text" name="insRemark" value=''  disabled style="width:65%; height:75px;" ></textarea>
								</div>
							</div>
							<div id="btn-wrap" style="display:none; text-align: center;">
								<input id="save_btn" type="button" class="btn-flat primary" value="提 交" onclick="save()" />
								<input class="btn-flat white" type="button" value="取 消" onclick="cancel()"/>
							</div>							
				</form>
			</div>


	<script type="text/javascript">
		var recordUrl=<custom:properties name='bjxc.user.province'/>;
		var insId= '<sec:authentication property="principal.insId"/>';
		initForm();
		//重置表单
		function initForm(){
		//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
		$.getJSON("${ctx}/institutionInfo/" + insId, function (result) {
			 if (result.code==200) {
				 	var data = result.data;
				 	$('#institutionInfo input[name="id"]').val(data.id);
					$('#institutionInfo input[name="inscode"]').val(data.inscode);
					$('#institutionInfo input[name="name"]').val(data.name);
					$('#institutionInfo input[name="shortName"]').val(data.shortName);
					$('#institutionInfo input[name="licnum"]').val(data.licnum);
					$('#institutionInfo input[name="licetime"]').val(data.licetime);
					$('#institutionInfo input[name="business"]').val(data.business);
					$('#institutionInfo input[name="creditcode"]').val(data.creditcode);
					$('#institutionInfo input[name="address"]').val(data.address);
					$('#institutionInfo input[name="postcode"]').val(data.postcode);
					$('#institutionInfo input[name="legal"]').val(data.legal);
					$('#institutionInfo input[name="contact"]').val(data.contact);
					$('#institutionInfo input[name="phone"]').val(data.phone);
					var arr = data.busiscope.split(',');
					$('#institutionInfo input[name="busiscope"]').each(function(){
						for(var i=0; i<arr.length; i++){
							if($(this).val() === arr[i]){
								$(this).prop("checked",true);
							}
						}
					 });
					$('#institutionInfo select[name="busistatus"]').val(data.busistatus);
					$('#institutionInfo select[name="level"]').val(data.level);
					$('#institutionInfo input[name="coachnumber"]').val(data.coachnumber);
					$('#institutionInfo input[name="grasupvnum"]').val(data.grasupvnum);
					$('#institutionInfo input[name="safmngnum"]').val(data.safmngnum);
					$('#institutionInfo input[name="tracarnum"]').val(data.tracarnum);
					$('#institutionInfo input[name="classroom"]').val(data.classroom);
					$('#institutionInfo input[name="thclassroom"]').val(data.thclassroom);
					$('#institutionInfo input[name="praticefield"]').val(data.praticefield);
					$('#institutionInfo textarea[name="insRemark"]').val(data.remark);
			}
		});
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
	   }).on("changeDate",function(){
		   $('.form_date + .Validform_checktip').html('');
		   $('.form_date').removeClass('Validform_error');
	   });		
			

	function edit(){
		
		$('#btn-wrap').show();
		$("input,select,textarea").each(function(){
			$(this).prop('disabled',false);
			$("#inscode").prop('disabled',true);
		})
		
	}
	
	
	function save(){
		var id=$('#institutionInfo input[name="id"]').val();
		var inscode=$('#institutionInfo input[name="inscode"]').val();
		var name=$('#institutionInfo input[name="name"]').val();
		var shortName=$('#institutionInfo input[name="shortName"]').val();
		var licnum=$('#institutionInfo input[name="licnum"]').val();
		var licetime=$('#institutionInfo input[name="licetime"]').val();
		var business=$('#institutionInfo input[name="business"]').val();
		var creditcode=$('#institutionInfo input[name="creditcode"]').val();
		var address=$('#institutionInfo input[name="address"]').val();
		var postcode=$('#institutionInfo input[name="postcode"]').val();
		var legal=$('#institutionInfo input[name="legal"]').val();
		var contact=$('#institutionInfo input[name="contact"]').val();
		var phone=$('#institutionInfo input[name="phone"]').val();
		var busiscope=$('#institutionInfo select[name="busiscope"]').val();
		var busiscopes = '';
		$('#institutionInfo input[name="busiscope"]:checked').each(function() {
			busiscopes += ($(this).val() + ',')});
		var busiscope = busiscopes.substring(0, busiscopes.length - 1);
		var busistatus=$('#institutionInfo select[name="busistatus"]').val();
		var level=$('#institutionInfo select[name="level"]').val();
		var coachnumber=$('#institutionInfo input[name="coachnumber"]').val();
		var grasupvnum=$('#institutionInfo input[name="grasupvnum"]').val();
		var safmngnum=$('#institutionInfo input[name="safmngnum"]').val();
		var tracarnum=$('#institutionInfo input[name="tracarnum"]').val();
		var classroom=$('#institutionInfo input[name="classroom"]').val();
		var thclassroom=$('#institutionInfo input[name="thclassroom"]').val();
		var praticefield=$('#institutionInfo input[name="praticefield"]').val();
		var insRemark=$('#institutionInfo textarea[name="insRemark"]').val();
		//定义提交到服务端的数据对象
		var params = {
			"id" : id,
			"inscode" :inscode,
			"name" : name,
			"shortName" : shortName,
			"licnum" : licnum,
			"licetime" : licetime,
			"business" : business,
			"creditcode" : creditcode,
			"address" : address,
			"postcode" :postcode,
			"legal" : legal,
			"contact" : contact,
			"phone" : phone,
			"busiscope" : busiscopes,
			"busistatus" :busistatus,
			"level":level,
			"coachnumber":coachnumber,
			"grasupvnum":grasupvnum,
			"safmngnum":safmngnum,
			"tracarnum":tracarnum,
			"classroom":classroom,
			"thclassroom":thclassroom,
			"praticefield":praticefield,
			"remark":insRemark
		};
		$.post('${ctx}/institutionInfo/saveOrUpdate', params, function(result) {
			if (result.code == 200) {
				initForm(id)
				$('#btn-wrap').hide();
				$("input,select,textarea").each(function(){
					$(this).prop('disabled',true);
				});
				initForm(id);
				layer.alert('提交成功');
			} else {
				//打开错误提示框
				layer.alert('提交失败');
			}
		});
	}
	function cancel(){
		$('#btn-wrap').hide();
		$("input,select,textarea").each(function(){
			$(this).prop('disabled',true);
		});
	}	
	/**
	*	展示编辑表单界面
	*	新增、修改都需要调用该方法打开表单
	*/
	function upRecord() {
		var id=$('#institutionInfo input[name="id"]').val();
		$.getJSON("${ctx}/institutionInfo/" + id,function(result) {
			var data = result.data;
			//弹出提示框 让用户确认删除
			var dialog = new GRI.Dialog({
				type : 4,
				title : '上传备案',
				content : '确定上传【' + data.name + '】培训机构备案吗？',
				deGRIil : '',
				btnType : 1,
				extra : {
					top : 250
				},
				winSize : 1
			}, function() {
			 	//时间判断函数
				function pad2(n) { return n < 10 ? '0' + n : n }
				//驾驶证初领日期
				var provinceLicetime;
				if(data.licetime!=null){
					var date = new Date(data.licetime);
					var provinceLicetime = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
				}
				
				//定义提交到服务端的数据对象
				var params = {
						"inscode" :data.inscode,// "2236581429084424"
						"name" :data.name,
						"shortname" :data.shortName,
						"licnum" :data.licnum,
						"licetime" : provinceLicetime,
						"business" :data.business,
						"creditcode" :data.creditcode,
						"address" :data.address,
						"postcode" :"443500",
						"legal" : data.legal,
						"contact" : data.contact,
						"phone" : data.phone,
						"busiscope" : data.busiscope,
						"busistatus" :data.busistatus,
						"level":data.level,
						"coachnumber":data.coachnumber,
						"grasupvnum":data.grasupvnum,
						"safmngnum":data.safmngnum,
						"tracarnum":data.tracarnum,
						"classroom":data.classroom,
						"thclassroom":data.thclassroom,
						"praticefield":data.praticefield,
						"district":420528
				};
				//发送数据到后端保存
				$.post(recordUrl+'/province/institution',params,function(results) {
					if (results.errorcode == 0) {
						 //保存成功 刷新列表
						layer.alert('备案成功');
					}else{
						alert(results.message)
					}	
				});
		
		});
	});
}
</script>

</body>
</html>