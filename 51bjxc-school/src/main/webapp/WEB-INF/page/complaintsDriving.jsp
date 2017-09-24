<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/meta/meta-tag.jsp"%>
<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-学员投诉驾校</title>
<script src="${ctx}/resources/uploadify/jquery.uploadify.js"></script>
<link type="text/css" href="${ctx}/resources/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
<script type="text/javascript" src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery-form.js"></script>
<title>阳光驾培-学员投诉驾校</title>
</head>
<body>
	<div class="container-fluid new-admin">
		<div class="select-top">
			<!-- <a class="select-btn" data-toggle="modal" onclick="showEditorModel()"><span class="update"></span>处理意见</a> -->
		<sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
			<sec:authorize access="hasRole('ROLE_TIME_SYSTEM')">
				<a class="select-btn" onClick="upRecord()"><span class="spare"></span>备案</a>
			</sec:authorize>
			<a class="select-btn" onclick="exportFile();" ><span class="Export"></span>导出</a>
			<sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
				<a class="select-btn" data-toggle="modal" onclick="addModal();"><span class="add"></span>录入投诉</a>
			</sec:authorize>
		</sec:authorize>
		
		<sec:authorize access="hasRole('ROLE_SCHOOL_SERVICE')">
			<sec:authorize access="hasRole('ROLE_UserOperation_180')">
				<sec:authorize access="hasRole('ROLE_TIME_SYSTEM')">
					<a class="select-btn" onClick="upRecord()"><span class="spare"></span>备案</a>
				</sec:authorize>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_181')">
				<a class="select-btn" onclick="exportFile();" ><span class="Export"></span>导出</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_182')">
				<a class="select-btn" data-toggle="modal" onclick="addModal();"><span class="add"></span>录入投诉</a>
			</sec:authorize>
		</sec:authorize>
		</div>
	</div>
	
	<div class="TermSearch">
		<form>
			<!-- <input class="input1 win200" type="text" id="searchText" placeholder="教练名称 " style="width:200px;"/> -->
			<input id="startTime" class="form_date input1 win99" type="text" data-date-format="yyyy-mm-dd" placeholder="查询开始日期" readonly="readonly" style="width:200px;">	
			<input id="endTime" class="input1 win99 form_date"  type="text" data-date-format="yyyy-mm-dd" placeholder="查询结束日期" data-date-format="yyyy-mm-dd" style="width:200px;" readonly="readonly"/>
			<button class="btn-flat primary" onClick="searchFunction();return false;">搜索</button>
		</form>
	</div>
	
	
	<!-- 列表 -->
	<div class="row-fluid">
		<div class="sub_content">
			<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
			<div id="table_list" class="gri_wrapper"></div>
		</div>
	</div>
	<!-- 新增-->
	<div class="modal fade colsform" id="Add" tabindex="-1" role="dialog" aria-hidden="true">	
		<form id="addComplaintsDriving" class="form-horizontal valid-form">
			<h4>录入投诉信息</h4>
			<input type="hidden" id="coachIdd" value="">
			<div class="modal-content">
				<div class="left">
					<div class="row1">
						<div class="form-controll">
							<label>学员编号:</label>
							<input type="text" name="stunum" datatype="*"  nullmsg="学员编号不能为空" sucmsg=" ">
							<input type="hidden" name="id" id="id" value="">
							<input type="hidden" name="insId" id="insId" value="
							<sec:authentication property="principal.insId"/>">
						</div>
						<div class="form-controll">
							<label>学员姓名:</label>
							<input type="text" name="studentName" datatype="*" errormsg="学员姓名" nullmsg="学员姓名不能为空" sucmsg=" ">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>学员身份证号:</label>
							<input type="text" name="identifierNo" datatype="*"  nullmsg="身份证号不能为空" sucmsg=" ">
							<input type="hidden" name="id" id="id" value="">
						</div>
						<div class="form-controll">
							<label>培训机构名称:</label>
							<input type="text" name="insName" datatype="*" errormsg="培训机构名称" nullmsg="培训机构名称不能为空" sucmsg=" ">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll wid90">
							<label>投诉内容:</label>
							<textarea name="content" datatype="*" nullmsg="投诉内容不能为空" sucmsg=" "></textarea>
						</div>
					</div>
				</div>
			</div>	
			<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="saveInfo();">保存</button>
			</div>
		</form>
	</div>
	<!-- 处理-->
	<div class="modal fade colsform" id="editorModal" tabindex="-1" role="dialog" aria-hidden="true">	
		<form id="opinion" class="form-horizontal valid-form">
			<h4>处理意见</h4>
			<input type="hidden" id="id" name="id" value="">
			<div class="modal-content">
				<div class="left">
					<div class="row1">
						<div class="form-controll wid90">
							<label>管理部门处理意见:</label>
							<textarea name="depaopinion"></textarea>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll wid90">
							<label>培训机构处理意见:</label>
							<textarea name="schopinion"></textarea>
						</div>
					</div>
				</div>
			</div>	
			<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="updateInfo();">保存</button>
			</div>
		</form>
	</div>
	<script type="text/javascript">
		//标识当前页面的url 用来设置当前菜单标识
		var dataTable = null;
		var recordUrl = <custom:properties name='bjxc.user.province'/>;
		var insId= '<sec:authentication property="principal.insId"/>';
		var insName = '<sec:authentication property="principal.insName"/>';
		var statId= '<sec:authentication property="principal.stationId"/>';
		var insCode = '<sec:authentication property="principal.insCode"/>';
		//初始化 
		$(document).ready(function() {
			
			/* MTA.Util.setParams('searchText', "");  */
			MTA.Util.setParams('startTime', 0);
			MTA.Util.setParams('endTime', 0); 
			
			//初始化界面  完成后调用buildData方法
			MTA.Report.initialize(null, 'buildData');
		});

		function buildData() {
			buildDataTable();
		}
		
		function searchFunction(){
			
			/* var searchText = $("#searchText").val(); */
			var startTime = $("#startTime").val()== '' ? 0 : (new Date(Date.parse($("#startTime").val())).getTime());
			var endTime = $("#endTime").val()== '' ? 0 : (new Date(Date.parse($("#endTime").val())).getTime());
			
			/* MTA.Util.setParams('searchText', searchText);  */
			MTA.Util.setParams('startTime', startTime);
			MTA.Util.setParams('endTime', endTime); 
			
			buildDataTable();
		}
		
		
		/**
		*	搜索
		*/		
		function searchQuery() {
			var search = $("#search").val();
			//时间判断函数
			function pad2(n) { return n < 10 ? '0' + n : n }
			var searchdate;
			if(search!=""){
				var date = new Date(search);
				var searchdate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
			}  
			var params={
					'inscode':insCode,
					'querydate':searchdate
					
			}
		 	$.post(recordUrl+'/province/complaintquery/get',params,function(result) {
				if (result.errorcode == 0) {
					var _html = "<div class='tab-scroll' style='width:1500px;'><table><thead><tr><th>学员编号</th><th>投诉对象类型:1教练员  2培训机构</th><th>投诉对象编号</th><th>投诉时间</th><th>投诉内容</th><th>管理部门处理意见</th><th>培训机构处理意见</th></tr></thead><tbody>";
					for(var i=0; i<result.data.complaintarray.length; i++){
						_html += '<tr>';
						for( key in result.data.complaintarray[i]){
							_html += '<td>';
							_html += result.data.complaintarray[i][key];
							_html += '</td>';
						}
						_html += '</tr>'
					 }
					_html += '</tbody></table></div>'
					 layer.open({
						title : '提示',
						maxWidth : 1650,
						content : _html					
					}); 
				}else{
					layer.alert('信息不完整')
				}
				
				}); 
		}
		/**
		*	构建列表
		*/
		function buildDataTable() {

			var config = {
				'container' : 'table_list'
			};
			//定义列表的列
			config['allFields'] = {
				'stunum' : {
					'thText' : '学员编号',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<span data-id="');
							td.push(record.id);
							td.push('">');
							td.push(record.stunum);
						td.push('</span>');
						return td.join('');
					}
				},
				'studentName': {
					'thText' : '学员名字',
				},
				'idcard': {
					'thText' : '学员身份证',
				},
				'institutionName': {
					'thText' : '培训机构名称',
				},
				'type' : {
					'thText' : '投诉类型',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						td = [];
						td.push('<ul class="info">');
							td.push('<li>');
								if (value ==  1) {
									td.push('教练员');
								} else if (value == 2) {
									td.push('培训机构');
								}
							td.push('</li>');
						td.push('</ul>');
						return td.join('');
					}
				},
				'cdate' : {
					'thText' : '投诉时间',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'content' : {
					'thText' : '投诉内容',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'isProvince' : {
					'thText' : '是否备案',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						td = [];
						if (value == 0) {
							td.push('未备案');
						} else if (value == 1) {
							td.push('已备案 ');
						}
						return td.join('');
					}
				},
				'id' : {
					'thText' : ' ',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'width' : '150px',
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						var sRecord = JSON.stringify(record);
						/* td.push('<ul class="actions">');
						td.push('<li>');
						td.push('<a onClick="showEditorModel(' + record.id + ' )">');
						td.push('处理');
						td.push('</a>');
						td.push('</li>');
						td.push('<li>');
						td.push("<input class='btn-flat primary' type='button' onClick='upRecord("+ sRecord + ")' value='上传备案'>");					
						td.push('</li>');
						td.push('</ul>'); */
						return td.join('');
					}
				},
				'status' :{
					'thText' : '处理结果',
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						var text = "";
						if(Number(record.insReserveCount) == 0){
							//text ='无效投诉无需处理/';
						}
						if(Number(value) == 0){
							text +='未处理';
						}else{
							text +='已处理';
						}
						td.push(text);
						return td.join('');
					}
				},
				
				'isValid' :{
					'thText' : '是否有效',
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						var text = "";
						if(Number(record.isValid) == 0){
							text ='无效';
						}
						else
						{
							text = '有效';	
						}
						td.push(text);
						return td.join('');
					}
				}
				
			};
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/complaint/list?type=2',
				'size' : 10,
				'ifRealPage' : 1,
			};
			//初始化 并通过ajax加载数据
			dataTable = MTA.Data.loadAjaxPageTable(config);
		}
		
		/**
			*	展示编辑表单界面
			*	新增、修改都需要调用该方法打开表单
		*/
		function showEditorModel(id) {
			//重置表单
			var tool = new toolCtrl();
		    tool.clearForm();
		    /* 获取id */
			var id = sessionStorage.getItem('tabId');
			if(id === null || id === undefined){
				layer.alert('未选择目标');
			}else{
				//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
				$.getJSON("${ctx}/complaint/" + id, function (result) {
					 if (result.code==200) {
					 	var data = result.data;
					 	$('#opinion input[name="id"]').val(data.id);
						$('#opinion textarea[name="schopinion"]').val(data.schopinion);
						$('#opinion textarea[name="depaopinion"]').val(data.depaopinion);
					}
				});
				$('#editorModal').modal('show');
			}
		}
		//保存
		function updateInfo() {
			//从form中取参数值
			var id = $('#opinion input[name="id"]').val();
			var content=$('#opinion textarea[name="content"]').val();
			var schopinion=$('#opinion textarea[name="schopinion"]').val();
			var depaopinion=$('#opinion textarea[name="depaopinion"]').val();
			if(schopinion==""){
				alert("请填写处理意见！");
				return false;
			}
			
			//定义提交到服务端的数据对象
			var params = {
				'id' : id,
				'type' : 2,
				'depaopinion' : depaopinion,
				'schopinion' : schopinion
			};
			//发送数据到后端保存
			$.post('${ctx}/complaint/saveOrUpdate',params, function(result) {
				if (result.code == 200) {
					 //关闭编辑的表单
					$('#editorModal').modal('hide');
					 //保存成功 刷新列表
			     	buildDataTable();
				}else{
					layer.alert(result.message);
				}
			});
		}
		
		/**
		*	备案到省平台
		*/
		function upRecord() {
			/* 获取id */
			var id = sessionStorage.getItem('tabId');
			if(id === null || id === undefined){
				layer.alert('未选择目标');
			}else{
				$.getJSON("${ctx}/complaint/" + id,function(result) {
					if(result.code==200){
						var data = result.data;
						//弹出提示框 让用户确认删除
						var dialog = new GRI.Dialog({
							type : 4,
							title : '上传备案',
							content : '确定上传学员编号【' + data.studentId + '】的投诉信息备案吗？',
							deGRIil : '',
							btnType : 1,
							extra : {
								top : 250
							},
							winSize : 1
						}, function() {
						 	//时间判断函数
						 	function pad2(n) { return n < 10 ? '0' + n : n }
						 	//投诉时间
						 	var cdate;
							if(data.cdate!=null){
								var date = new Date(data.cdate);
								var cdate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate()) + pad2( date.getHours() ) + pad2( date.getMinutes() ) + pad2( date.getSeconds() )
							}
							//定义提交到服务端的数据对象
							var params = {
									'stunum' : data.stunum,//'5113559050455096',
									'type' : data.type,
									'objenum' :insCode,	//data.objectId,//'2383114336134796',
									'cdate' : cdate,
									'content' : data.content,
									'depaopinion' : data.depaopinion,
									'schopinion' : data.schopinion
							};
							//发送数据到后端保存
							$.post(recordUrl+'/province/complaint',params,function(result) {
								if (result.errorcode == 0) {
									
									var paramd={
										'id':id,
										'isProvince':1
									}
								 //备案完成后修改备案状态
						 		$.post('${ctx}/complaint/udpatedriving',paramd, function(result) {
										if (result.code == 200) {
											
											 //保存成功 刷新列表				 
									     	buildDataTable();
									     	layer.alert("备案成功")
										}else{
											layer.alert("备案失败")
										}
									});
								}else{
									layer.alert("信息完整性不够")
								}
							});
						});
					}
				});
			}
		}
	
		function changeStatus(id) {
			window.location.href="${ctx}/trainingCar/"+id+"?"+id;
		}
		function exportFile(){
			window.location.href="${ctx}/complaint/exportComplaint?type="+2;
		}
		function addModal(){
			//重置表单
			var tool = new toolCtrl();
		    tool.clearForm();
			$('#Add').modal('show');
		}
		//保存
		function saveInfo() {
			//从form中取参数值
			var studentId = $('#addComplaintsDriving input[name="studentId"]').val();
			var objectId = $('#addComplaintsDriving input[name="coachId"]').val();
			var content=$('#addComplaintsDriving textarea[name="content"]').val();
			var institutionName = $('#addComplaintsDriving input[name="insName"]').val();
			// 校验表单是否通过
			if( $("#Add .valid-form").Validform().check() != true ){
				
				return
			}
			//定义提交到服务端的数据对象
			var params = {
				'type' : 2,
				'studentName' : $('#addComplaintsDriving input[name="studentName"]').val(),
				'stunum' : $('#addComplaintsDriving input[name="stunum"]').val(),
				'content' : content,
				'institutionName': institutionName
			};
			//发送数据到后端保存
			$.post('${ctx}/complaint/saveOrUpdate',params, function(result) {
				if (result.code == 200) {
					 //关闭编辑的表单
					$('#Add').modal('hide');
					 //保存成功 刷新列表
			     	buildDataTable();
				}
			});
		}
		$('.form_date').datetimepicker({
			language : 'zh-CN',
			weekStart : 1,
			todayBtn : 1,
			autoclose : 1,
			todayHighlight : 0,
			startView : 2,
			minView : 2,
			forceParse : 0
		}).on("changeDate", function() {
			$('.form_date + .Validform_checktip').html('');
			$('.form_date').removeClass('Validform_error');
		});
	</script>
</body>
</html>