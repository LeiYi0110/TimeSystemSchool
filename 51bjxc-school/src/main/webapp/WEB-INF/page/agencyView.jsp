<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-修改机构信息</title>
<script src="${ctx}/resources/uploadify/jquery.uploadify.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
</head>
<body>
	<div class="container-fluid new-admin">
		<div class="select-top"></div>
	</div>
	<div class="modal-content institution-form agency" id="editInstitutionInfo" style="width:1050px;  max-height:none; padding:25px;">
	<form id="institutionInfo" class="valid-form">
		<div class="row1">
			<div class="form-controll">
				<label>
					区县行政区划代码：
				</label>
				<input type="text" name="district" id="district" value="" datatype="*" disabled="disabled"> 
				<input type="hidden" name="id" id="id" value="" >
				<input type="hidden" name="insId" id="insId" value="<sec:authentication property="principal.insId"/>
				">
			</div>
			<div class="form-controll">
				<label>
					培训机构名称：
				</label>
				<input type="text"  datatype="*" name="name" id="name" value=""  disabled="disabled">
			</div>
		</div>
		<div class="row1">
			<div class="form-controll">
				<label>
					培训机构简称：
				</label>
				<input type="text" datatype="*" name="shortName" id="shortName" value=""  disabled="disabled"></div>
			<div class="form-controll">
				<label>
					经营许可证编号：
				</label>
				<input type="text"  datatype="*" name="licnum" id="licnum" value="" disabled="disabled">
			</div>
		</div>
		<div class="row1">	
			<div class="form-controll">
				<label>
					经营许可日期：
				</label>
				<input type="text"  datatype="*"  name="licetime" id="licetime" value="" class="form_date" data-date-format="yyyy-mm-dd" disabled="disabled"></div>
			<div class="form-controll">
				<label>
					<span class="need"></span>
					营业执照注册号：
				</label>
				<input type="text"  datatype="*" name="business" id="business" value="" disabled="disabled">
			</div>
		</div>
		<div class="row1">
			<div class="form-controll">
				<label>
					统一社会信用代码：
				</label>
				<input type="text"  datatype="*" name="creditcode" id="creditcode" value="" disabled="disabled"></div>
			<div class="form-controll">
				<label>
					培训机构地址：
				</label>
				<input type="text"  datatype="*" name="address" id="address" value="" disabled="disabled">
			</div>
		</div> 
		<div class="row1">
			<div class="form-controll">
				<label>
					邮政编码：
				</label>
				<input type="text"  datatype="*" name="postcode" id="postcode" disabled="disabled"></div>

			<div class="form-controll">
				<label>
					法人代表：
				</label>
				<input type="text"  datatype="*" name="legal" id="legal" value="" disabled="disabled">
			</div>
		</div>
		<div class="row1">
			<div class="form-controll">
				<label>
					联系人：
				</label>
				<input type="text"  datatype="*" name="contact" id="contact" value="" disabled="disabled"></div>
			<div class="form-controll">
				<label>
					联系电话：
				</label>
				<input type="text"  datatype="*" name="phone" id="phone" value="" disabled="disabled">
			</div>
		</div>
		<div class="row1">
			<div class="form-controll">
				<label>
					经营状态：
				</label>
				<select id="busistatus" name="busistatus" datatype="*" disabled="disabled">
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
				<label>
					分类等级：
				</label>
				<select id="level" name="level" datatype="*" disabled="disabled">
					<option  value="1">A1</option>
					<option  value="2">A2</option>
					<option  value="3">A3</option>
				</select>
			</div>
		</div>
		<div class="row1">
			<div class="form-controll">
				<label>
					教练场总面积：
				</label>
				<input type="text" name="praticefield" value=''  datatype="*" disabled="disabled"></div>
			<div class="form-controll">
				<label>
					教练员总数：
				</label>
				<input type="text"  datatype="*" name="coachnumber" id="coachnumber" value="" disabled="disabled">
			</div>
		</div>	
		<div class="row1">
			<div class="form-controll">
				<label>
					考核员总数：
				</label>
				<input type="text" name="grasupvnum" value='' datatype="*" disabled="disabled"></div>
			<div class="form-controll">
				<label>
					安全员总数：
				</label>
				<input type="text" name="safmngnum" value='' datatype="*" disabled="disabled">
			</div>
		</div>
		<div class="row1">
			<div class="form-controll">
				<label>
					教练车总数：
				</label>
				<input type="text" name="tracarnum" value=''  datatype="*" disabled="disabled"></div>
			<div class="form-controll">
				<label>教室总面积：</label>
				<input type="text" name="classroom" value='' disabled="disabled">
			</div>
		</div>
		<div class="row1">
			<div class="form-controll">
				<label>理论教室面积：</label>
				<input type="text" name="thclassroom" value='' disabled="disabled">
			</div>
		</div>
		<div class="row1">
			<div class="form-controll" style="width: 100%;">
				<label style="margin-bottom: 50px;">
					经营范围：
				</label>
				<input type="checkbox" datatype="*" name="busiscope" value="A1" style="margin: 0 3px 0 0;" disabled="disabled">A1
				<span style="padding-right: 5px;">
					<input type="checkbox" name="busiscope" value="A2" style="margin: 0 3px 0 0;" disabled="disabled">A2</span>
				<span style="padding-right: 5px;">
					<input type="checkbox" name="busiscope" value="A3" style="margin: 0 3px 0 0;" disabled="disabled">A3</span>
				<span style="padding-right: 5px;">
					<input type="checkbox" name="busiscope" value="B1" style="margin: 0 3px 0 0;" disabled="disabled">B1</span>
				<span style="padding-right: 5px;">
					<input type="checkbox" name="busiscope" value="B2" style="margin: 0 3px 0 0;" disabled="disabled">B2</span>
				<span style="padding-right: 5px;">
					<input type="checkbox" name="busiscope" value="C1" style="margin: 0 3px 0 0;" disabled="disabled">C1</span>
				<span style="padding-right: 5px;">
					<input type="checkbox" name="busiscope" value="C2" style="margin: 0 3px 0 0;" disabled="disabled">C2</span>
				<span style="padding-right: 5px;">
					<input type="checkbox" name="busiscope" value="C3" style="margin: 0 3px 0 0;" disabled="disabled">C3</span>
				<span style="padding-right: 5px;">
					<input type="checkbox" name="busiscope" value="C4" style="margin: 0 3px 0 0;" disabled="disabled">C4</span>
				<span style="padding-right: 5px;">
					<input type="checkbox" name="busiscope" value="C5" style="margin: 0 3px 0 0;" disabled="disabled">C5</span>
				<span style="padding-right: 5px;">
					<input type="checkbox" name="busiscope" value="D" style="margin: 0 3px 0 0;" disabled="disabled">D</span>
				<span style="padding-right: 5px;">
					<input type="checkbox" name="busiscope" value="E" style="margin: 0 3px 0 0;" disabled="disabled">E</span>
				<span style="padding-right: 5px;">
					<input type="checkbox" name="busiscope" value="F" style="margin: 0 3px 0 0;" disabled="disabled">F</span>
				<span tyle="padding-right: 5px;">
					<input type="checkbox" name="busiscope" value="M" style="margin: 0 3px 0 0;" disabled="disabled">M</span>
				<span style="padding-right: 5px;">
					<input type="checkbox" name="busiscope" value="N" style="margin: 0 3px 0 0;" disabled="disabled">N</span>
				<span style="padding-right: 5px;">
					<input type="checkbox" name="busiscope" value="P" style="margin: 0 3px 0 0;" disabled="disabled">P</span>
			</div>
		</div>
	</form>
</div>
<script type="text/javascript">
		var recordUrl=<custom:properties name='bjxc.user.province'/>;
		var insId= '<sec:authentication property="principal.insId"/>';
		var id = '${param.id}';
		initForm(id);
		//重置表单
		function initForm(id){
		//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
		$.getJSON("${ctx}/institutionInfo/" + id, function (result) {
			 if (result.code==200) {
				 	var data = result.data;
				 	$('#institutionInfo input[name="id"]').val(data.id);
					$('#institutionInfo input[name="district"]').val(data.district);
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
		
</script>		
</body>
</html>