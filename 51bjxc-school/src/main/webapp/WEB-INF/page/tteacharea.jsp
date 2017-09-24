<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-片区管理</title>
</head>
<body>
	<div class="container-fluid new-admin">
		<div class="select-top">
		<sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
			<a class="select-btn" onclick="showEditorModel()"><span
				class="add"></span>新增</a> <a class="select-btn" onclick="updateModel()"><span
				class="edit"></span>修改</a> <a class="select-btn" onClick="deletes()"><span
				class="del"></span>禁用</a>
		</sec:authorize>
		
		<sec:authorize access="hasRole('ROLE_SCHOOL_SERVICE')">
			<sec:authorize access="hasRole('ROLE_UserOperation_67')">
				<a class="select-btn" onclick="showEditorModel()"><span	class="add"></span>新增</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_68')"> 
				<a class="select-btn" onclick="updateModel()"><span	class="edit"></span>修改</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_69')"> 
				<a class="select-btn" onClick="deletes()"><span	class="del"></span>禁用</a>
			</sec:authorize>
		</sec:authorize>
		</div>
	</div>

	<div class="row-fluid">
		<div class="sub_content">
			<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
			<div id="table_list" class="gri_wrapper"></div>

		</div>
	</div>


	<div class="modal fade colsform " tabindex="-1" id="editorModal"
		role="dialog" aria-hidden="true" style="width: 400px; margin-left:-200px;">
		<form class="form-horizontal" id="ediorForm">
			<input type="hidden" name="id">
			<h4>片区管理</h4>
			<div class="modal-content">
				<div class="center">
					<div class="row1">
						<div class="form-controll" style="margin-right: 0; width: auto;">
							<label style="width: 95px;">名称：</label>
							<input type="text" name="name">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll" style="margin-right: 0; width: 100%;">
							<input type="hidden" name="insId"> <input type="hidden"
								name="astatus"> <label
								style="height: 70px; width: 95px;">培训车型：</label> 
								<span style="padding-right: 5px;"><input type="checkbox" name="perdritype" value="A1" style="margin: 0 3px 0 0;"> A1</span>
							    <span style="padding-right: 5px;"><input type="checkbox" name="perdritype" value="A2" style="margin: 0 3px 0 0;"> A2</span> 
							    <span><input type="checkbox" name="perdritype" value="A3" style="margin: 0 3px 0 0;"> A3</span> </br>
							    <span style="padding-right: 5px;"><input type="checkbox" name="perdritype" value="B1" style="margin: 0 3px 0 0;"> B1</span> 
							    <span style="padding-right: 5px;"><input type="checkbox" name="perdritype" value="B2" style="margin: 0 3px 0 0;"> B2</span>
							     </br> 
							    <span style="padding-right: 5px;"><input type="checkbox" name="perdritype" value="C1" style="margin: 0 3px 0 0;"> C1</span> 
							    <span style="padding-right: 5px;"><input type="checkbox" name="perdritype" value="C2" style="margin: 0 3px 0 0;"> C2</span>
							    <span style="padding-right: 5px;"><input type="checkbox" name="perdritype" value="C3" style="margin: 0 3px 0 0;"> C3</span>
							    <span style="padding-right: 5px;"><input type="checkbox" name="perdritype" value="c4" style="margin: 0 3px 0 0;"> C4</span> 
							    <span><input type="checkbox" name="perdritype" value="c5" style="margin: 0 3px 0 0;"> C5</span> </br> 
							    <span style="padding-right: 11px;"><input type="checkbox"  name="perdritype" value="D" style="margin: 0 3px 0 0;">D </span>
							    <span style="padding-right: 11px;"><input type="checkbox" name="perdritype" value="E" style="margin: 0 3px 0 0;"> E</span> 
							    <span style="padding-right: 11px;"><input type="checkbox" name="perdritype" value="F" style="margin: 0 3px 0 0;"> F</span> 
							    <span style="padding-right: 11px;"> <input type="checkbox" name="perdritype" value="M" style="margin: 0 3px 0 0;">M </span> 
							    <span style="padding-right: 11px;"><input type="checkbox" name="perdritype" value="N" style="margin: 0 3px 0 0;"> N</span> 
							    <span><input type="checkbox" name="perdritype" value="P" style="margin: 0 3px 0 0;">P</span>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" onClick="save();">保存</button>
			</div>
		</form>
	</div>




	<!-- 修改 -->
	<div class="modal fade colsform " tabindex="-1" id="updateModal"
		role="dialog" aria-hidden="true" style="width: 400px;  margin-left:-200px;">
		<form class="form-horizontal" id="updateForm">
			<input type="hidden" name="id">
			<h4>片区管理</h4>
			<div class="modal-content">
				<div class="center">
					<div class="row1">
						<div class="form-controll" style="margin-right: 0; width: auto;">
							<label style="width: 100px;">名称：</label> <input type="text"
								name="uname">
						</div>

					</div>
					<div class="row1">
						<div class="form-controll" style="margin-right: 0; width: auto;">
							<input type="hidden" name="uastatus"> <label style="width: 100px;" marginleft:30px >培训机构编号：</label> 
							<input type="text" name="uinsId" readonly="readonly">
						</div>
						<div class="form-controll" style="margin-right: 0; width: 100%;">
							<label style="height: 70px; width: 100px;">培训车型：</label> 
							    <span style="padding-right: 5px;"><input type="checkbox" name="uperdritype" value="A1" style="margin: 0 3px 0 0;"> A1</span>
							    <span style="padding-right: 5px;"><input type="checkbox" name="uperdritype" value="A2" style="margin: 0 3px 0 0;"> A2</span> 
							    <span><input type="checkbox" name="uperdritype" value="A3" style="margin: 0 3px 0 0;"> A3</span> </br>
							    <span style="padding-right: 5px;"><input type="checkbox" name="uperdritype" value="B1" style="margin: 0 3px 0 0;"> B1</span> 
							    <span style="padding-right: 5px;"><input type="checkbox" name="uperdritype" value="B2" style="margin: 0 3px 0 0;"> B2</span>
							     </br> 
							    <span style="padding-right: 5px;"><input type="checkbox" name="uperdritype" value="C1" style="margin: 0 3px 0 0;"> C1</span> 
							    <span style="padding-right: 5px;"><input type="checkbox" name="uperdritype" value="C2" style="margin: 0 3px 0 0;"> C2</span>
							    <span style="padding-right: 5px;"><input type="checkbox" name="uperdritype" value="C3" style="margin: 0 3px 0 0;"> C3</span>
							    <span style="padding-right: 5px;"><input type="checkbox" name="uperdritype" value="c4" style="margin: 0 3px 0 0;"> C4</span> 
							    <span><input type="checkbox" name="uperdritype" value="c5" style="margin: 0 3px 0 0;"> C5</span> </br> 
							    <span style="padding-right: 11px;"><input type="checkbox"  name="uperdritype" value="D" style="margin: 0 3px 0 0;"> D </span>
							    <span style="padding-right: 11px;"><input type="checkbox" name="uperdritype" value="E" style="margin: 0 3px 0 0;">E</span> 
							    <span style="padding-right: 11px;"><input type="checkbox" name="uperdritype" value="F" style="margin: 0 3px 0 0;"> F</span> 
							    <span style="padding-right: 11px;"> <input type="checkbox" name="uperdritype" value="M" style="margin: 0 3px 0 0;">M </span> 
							    <span style="padding-right: 11px;"><input type="checkbox" name="uperdritype" value="N" style="margin: 0 3px 0 0;"> N</span> 
							    <span><input type="checkbox" name="uperdritype" value="P" style="margin: 0 3px 0 0;">P</span>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" onClick="updates();">保存</button>
			</div>
		</form>
	</div>

	<script type="text/javascript">
		//标识当前页面的url 用来设置当前菜单标识
		var dataTable = null;
		var insIdd = '<sec:authentication property="principal.insId"/>';
		var insName = '<sec:authentication property="principal.insName"/>';
		var statId = '<sec:authentication property="principal.stationId"/>';
		//初始化 
		$(document).ready(function() {
			//初始化界面  完成后调用buildData方法
			MTA.Report.initialize(null, 'buildData');
		});

		function buildData() {
			buildDataTable();
		}
		/**
		 *	搜索
		 */
		function searchQuery() {
			var search = $("#search").val();
			MTA.Util.setParams('searchText', search);
			buildDataTable();
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
				'name' : {
					'thText' : '区域名称',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<span data-id="');
						td.push(record.id);
						td.push('">');
						td.push(record.name);
						td.push('</span>');
						return td.join('');
					}
				},
				'perdritype' : {
					'thText' : '培训车型',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'astatus' : {
					'thText' : '状态',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						td = [];
						if (value == 0) {
							td.push('已禁用');
						} else if (value == 1) {
							td.push(' ');
						}
						return td.join('');
					}
				}
			};
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/ttracharea/list?insIdd=' + insIdd,
				'size' : 10,
				'ifRealPage' : 1
			};
			//初始化 并通过ajax加载数据
			dataTable = MTA.Data.loadAjaxPageTable(config);
		}

		/**
		 *	展示编辑表单界面
		 *	新增、修改都需要调用该方法打开表单
		 */
		function showEditorModel() {
			var tool = new toolCtrl();
			tool.clearForm();
			//重置表单
			$('#ediorForm input[name="id"]').val();
			$('#ediorForm input[name="perdritype"]checked').val();
			$('#ediorForm input[name="name"]').val('');
			$('#ediorForm input[name="insId"]').val('');
			$('#editorModal').modal('show');
		}
		//保存
		function save() {
			//从form中取参数值
			var sId = '';
			var id = $('#ediorForm input[name="id"]').val();
			var name = $('#ediorForm input[name="name"]').val();
			var perdritype = $('#ediorForm input[name="perdritype"]').val();
			var insId = $('#ediorForm input[name="insId"]').val('');
			$('#ediorForm input[name="perdritype"]:checked').each(function() {
				sId += ($(this).val() + ',')
			});
			var perdritype = sId.substring(0, sId.length - 1);
			//定义提交到服务端的数据对象
			var params = {
				'id' : id,
				'name' : name,
				'perdritype' : perdritype,
				'insIdd' : insIdd
			};
			console.log(params);
			//发送数据到后端保存
			$.post('${ctx}/ttracharea/saveUpdates', params, function(result) {
				if (result.code == 200) {
					//保存成功 刷新列表
				    buildDataTable();
					//关闭编辑的表单
					layer.alert('保存成功');
					$('#editorModal').modal('hide');	
			}else{
				layer.alert('保存失败')
			}
			}); 
		}
		//修改

		function updateModel() {
			var id=sessionStorage.getItem('tabId');
			if(id === null || id === undefined){
				alert('未选择目标');
			}else{
			//重置表单
			$('#updateForm input[name="id"]').val();
			$('#updateForm input[name="uperdritype"]checked').val();
			$('#updateForm input[name="uinsId"]').val();
			$('#updateForm input[name="uname"]').val('');

			if (id) {
				//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
				$.getJSON("${ctx}/ttracharea/" + id, function(result) {
					if (result.code == 200) {
						var data = result.data;
						$('#updateForm input[name="id"]').val(data.id);
						$('#updateForm input[name="uinsId"]').val(data.insId);
						$('#updateForm input[name="uname"]').val(data.name);
						var arr = data.perdritype.split(',');
						$('#updateForm input[name="uperdritype"]').each(
								function() {
									for (var i = 0; i < arr.length; i++) {
										if ($(this).val() === arr[i]) {
											$(this).prop("checked", true);
										}
									}
								});
						/* $('#ediorForm input[name="perdritype"]').val(data.perdritype); */

					}
				});
			}
			$('#updateModal').modal('show');

		}
		}
		//修改
		function updates() {
			//从form中取参数值
			var sId = '';
			var id = $('#updateForm input[name="id"]').val();
			var name = $('#updateForm input[name="uname"]').val();
			var insId = $('#updateForm input[name="uinsId"]').val();
			var perdritype = $('#updateForm input[name="uperdritype"]').val();
			$('#updateForm input[name="uperdritype"]:checked').each(function() {
				sId += ($(this).val() + ',')
			});
			var perdritype = sId.substring(0, sId.length - 1);

			//定义提交到服务端的数据对象
			var params = {
				'id' : id,
				'name' : name,
				'perdritype' : perdritype,
				'insId' : insId,
			};
			//发送数据到后端保存
			$.post('${ctx}/ttracharea/saveUpdates', params, function(result) {
				if (result.code == 200) {
					//保存成功 刷新列表
					buildDataTable();
					//关闭编辑的表单
					layer.alert('保存成功');
					$('#updateModal').modal('hide');	
			}else{
				layer.alert('保存失败')
			}

			});
		}

		//禁用
		function deletes() {
			var id=sessionStorage.getItem('tabId')
			if(id === null || id === undefined){
				alert('未选择目标');
			}else{
			$.getJSON("${ctx}/ttracharea/" + id, function(result) {
				if (result.code == 200) {
					var data = result.data;
					if (data.astatus == 1) {
						var gnl = confirm("阳光驾培温馨提示,您确定要禁用吗?");
						if (gnl == true) {
							//定义提交到服务端的数据对象
							var params = {
								'id' : id
							};
							//发送数据到后端保存
							$.post('${ctx}/ttracharea/disables', params,
									function(result) {
										if (result.code == 200) {
											//保存成功 刷新列表
											layer.alert('禁用成功');	 
											buildDataTable();
										}else{
											layer.alert('禁用失败')
										}
									});
							return true;
						} else {
							return false
						}
					} else {
						alert("该区域已被禁用")
					}
				};
			})
		}
	}
	</script>
</body>
</html>