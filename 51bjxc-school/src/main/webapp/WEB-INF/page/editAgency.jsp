<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-demo</title>
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
				<input type="text" name="district" id="district" value="" datatype="*">
				<input type="hidden" name="id" id="id" value="" >
				<input type="hidden" name="insId" id="insId" value="<sec:authentication property="principal.insId"/>
				">
			</div>
			<div class="form-controll">
				<label>
					培训机构名称：
				</label>
				<input type="text"  datatype="*" name="name" id="name" value=""  >
			</div>
		</div>
		<div class="row1">
			<div class="form-controll">
				<label>
					培训机构简称：
				</label>
				<input type="text" datatype="*" name="shortName" id="shortName" value=""  ></div>
			<div class="form-controll">
				<label>
					经营许可证编号：
				</label>
				<input type="text"  datatype="*" name="licnum" id="licnum" value="" >
			</div>
		</div>
		<div class="row1">	
			<div class="form-controll">
				<label>
					经营许可日期：
				</label>
				<input type="text"  datatype="*"  name="licetime" id="licetime" value="" class="form_date" data-date-format="yyyy-mm-dd" ></div>
			<div class="form-controll">
				<label>
					<span class="need"></span>
					营业执照注册号：
				</label>
				<input type="text"  datatype="*" name="business" id="business" value="" >
			</div>
		</div>
		<div class="row1">
			<div class="form-controll">
				<label>
					统一社会信用代码：
				</label>
				<input type="text"  datatype="*" name="creditcode" id="creditcode" value="" ></div>
			<div class="form-controll">
				<label>
					培训机构地址：
				</label>
				<input type="text"  datatype="*" name="address" id="address" value="" >
			</div>
		</div> 
		<div class="row1">
			<div class="form-controll">
				<label>
					邮政编码：
				</label>
				<input type="text"  datatype="*" name="postcode" id="postcode" ></div>

			<div class="form-controll">
				<label>
					法人代表：
				</label>
				<input type="text"  datatype="*" name="legal" id="legal" value="" >
			</div>
		</div>
		<div class="row1">
			<div class="form-controll">
				<label>
					联系人：
				</label>
				<input type="text"  datatype="*" name="contact" id="contact" value="" ></div>
			<div class="form-controll">
				<label>
					联系电话：
				</label>
				<input type="text"  datatype="*" name="phone" id="phone" value="" >
			</div>
		</div>
		<div class="row1">
			<div class="form-controll">
				<label>
					经营状态：
				</label>
				<select id="busistatus" name="busistatus" datatype="*" >
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
				<select id="level" name="level" datatype="*" >
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
				<input type="text" name="praticefield" value=''  datatype="*"></div>
			<div class="form-controll">
				<label>
					教练员总数：
				</label>
				<input type="text"  datatype="*" name="coachnumber" id="coachnumber" value="" >
			</div>
		</div>	
		<div class="row1">
			<div class="form-controll">
				<label>
					考核员总数：
				</label>
				<input type="text" name="grasupvnum" value='' datatype="*"></div>
			<div class="form-controll">
				<label>
					安全员总数：
				</label>
				<input type="text" name="safmngnum" value='' datatype="*" >
			</div>
		</div>
		<div class="row1">
			<div class="form-controll">
				<label>
					教练车总数：
				</label>
				<input type="text" name="tracarnum" value=''  datatype="*"></div>
			<div class="form-controll">
				<label>教室总面积：</label>
				<input type="text" name="classroom" value=''  >
			</div>
		</div>
		<div class="row1">
			<div class="form-controll">
				<label>理论教室面积：</label>
				<input type="text" name="thclassroom" value=''  >
			</div>
		</div>
		<div class="row1">
			<div class="form-controll">
				<label>驾培机构编号：</label>
				<input type="text" name="inscode" value='' readonly="readonly" >
			</div>
		</div>
		<div class="row1">
			<div class="form-controll" style="width: 100%;">
				<label style="margin-bottom: 50px;">
					经营范围：
				</label>
				<input type="checkbox" datatype="*" name="busiscope" value="A1" style="margin: 0 3px 0 0;" >A1
				<span style="padding-right: 5px;">
					<input type="checkbox" name="busiscope" value="A2" style="margin: 0 3px 0 0;" >A2</span>
				<span style="padding-right: 5px;">
					<input type="checkbox" name="busiscope" value="A3" style="margin: 0 3px 0 0;" >A3</span>
				<span style="padding-right: 5px;">
					<input type="checkbox" name="busiscope" value="B1" style="margin: 0 3px 0 0;" >B1</span>
				<span style="padding-right: 5px;">
					<input type="checkbox" name="busiscope" value="B2" style="margin: 0 3px 0 0;" >B2</span>
				<span style="padding-right: 5px;">
					<input type="checkbox" name="busiscope" value="C1" style="margin: 0 3px 0 0;" >C1</span>
				<span style="padding-right: 5px;">
					<input type="checkbox" name="busiscope" value="C2" style="margin: 0 3px 0 0;" >C2</span>
				<span style="padding-right: 5px;">
					<input type="checkbox" name="busiscope" value="C3" style="margin: 0 3px 0 0;" >C3</span>
				<span style="padding-right: 5px;">
					<input type="checkbox" name="busiscope" value="C4" style="margin: 0 3px 0 0;" >C4</span>
				<span style="padding-right: 5px;">
					<input type="checkbox" name="busiscope" value="C5" style="margin: 0 3px 0 0;" >C5</span>
				<span style="padding-right: 5px;">
					<input type="checkbox" name="busiscope" value="D" style="margin: 0 3px 0 0;" >D</span>
				<span style="padding-right: 5px;">
					<input type="checkbox" name="busiscope" value="E" style="margin: 0 3px 0 0;" >E</span>
				<span style="padding-right: 5px;">
					<input type="checkbox" name="busiscope" value="F" style="margin: 0 3px 0 0;" >F</span>
				<span tyle="padding-right: 5px;">
					<input type="checkbox" name="busiscope" value="M" style="margin: 0 3px 0 0;" >M</span>
				<span style="padding-right: 5px;">
					<input type="checkbox" name="busiscope" value="N" style="margin: 0 3px 0 0;" >N</span>
				<span style="padding-right: 5px;">
					<input type="checkbox" name="busiscope" value="P" style="margin: 0 3px 0 0;" >P</span>
			</div>
		</div>
		<div id="btn-wrap" style="display:; text-align: center;">
			<input id="save_btn" type="button" class="btn-flat primary" value="提 交" onclick="save()" />
			<!-- <input class="btn-flat white" type="button" value="取 消" onclick="cancel()"/> -->
		</div>
	</form>
</div>
<script type="text/javascript">
		var recordUrl=<custom:properties name='bjxc.user.province'/>;
		var insId= '<sec:authentication property="principal.insId"/>';
		var id = '${param.id}';
		if(id!=null && id!=""){
			initForm(id);
			//重置表单
			function initForm(id){
			//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
			$.getJSON("${ctx}/institutionInfo/" + id, function (result) {
				 if (result.code==200) {
					 	var data = result.data;
					 	$('#institutionInfo input[name="id"]').val(data.id);
					 	$('#institutionInfo input[name="inscode"]').val(data.inscode);
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
		
		function save(){
			var id=$('#institutionInfo input[name="id"]').val();
			var district=$('#institutionInfo input[name="district"]').val();
			var name=$('#institutionInfo input[name="name"]').val();
			var shortName=$('#institutionInfo input[name="shortName"]').val();
			var licnum=$('#institutionInfo input[name="licnum"]').val();
			var licetime=$('#institutionInfo input[name="licetime"]').val();
			var business=$('#institutionInfo input[name="business"]').val();
			var creditcode=$('#institutionInfo input[name="creditcode"]').val();
			var inscode=$('#institutionInfo input[name="inscode"]').val();
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
			//时间判断函数
			function pad2(n) { return n < 10 ? '0' + n : n }
			//驾驶证初领日期
			var licetimes;
			if(licetime!=""){
				var date = new Date(licetime);
				var licetimes = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
			}  
			// 校验表单是否通过
			if( $("#editInstitutionInfo .valid-form").Validform().check() != true ){
				
				return
			}
			//自动备案判断
			if(id==null||id==""){
				//定义提交到服务端的数据对象
				 var param = {
					"district" :district,
					"name" : name,
					"shortname" : shortName,
					"licnum" : licnum,
					"licetime" : licetimes,
					"business" :business, //urlResult.data.id,
					"creditcode" : creditcode,
					"address" : address,
					"postcode" : postcode,
					"legal":legal,
					"contact" : contact,
					"phone" : phone,
					"inscode" : inscode,
					"busiscope" : busiscope,
					"busistatus" : busistatus,
					"level" : level,
					"coachnumber" : coachnumber,
					"grasupvnum":grasupvnum,
					"safmngnum":safmngnum,
					"tracarnum":tracarnum,
					"classroom":classroom,
					"thclassroom":thclassroom,
					"praticefield":praticefield
				};
				//发送数据到后端保存
				$.post(recordUrl+'/country/institution',param,function(result) {
					if(result.message!=""){
						layer.alert(result.message);
					}
					if (result.errorcode == 0) {
						//定义提交到服务端的数据对象
						var params = {
							"id" : id,
							"district" :district,
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
							"inscode" : inscode,
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
							'inscode':result.data.inscode
						};
						$.post('${ctx}/institutionInfo/saveOrUpdate', params, function(result) {
							if (result.code == 200) {
								//打开错误提示框
								window.location.href="${ctx}/view/agency";
							} else {
								//打开错误提示框
								layer.alert('提交失败');
							}
						});
					}else{
						alert("信息正确不够");
					}
				});
			}else{
				//定义提交到服务端的数据对象
				var params = {
					"id" : id,
					"district" :district,
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
					"inscode" : inscode,
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
					'inscode':inscode
				};
				$.post('${ctx}/institutionInfo/saveOrUpdate', params, function(result) {
					if (result.code == 200) {
						//打开错误提示框
						window.location.href="${ctx}/view/agency";
					} else {
						//打开错误提示框
						layer.alert('提交失败');
					}
				});
			}
		}
		
</script>		
</body>
</html>