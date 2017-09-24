<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-学员投诉驾校</title>
</head>
<body>
	<div class="container-fluid new-admin">
		<div class="select-top">
			<a class="select-btn" data-toggle="modal" onclick="updateModal()"><span class="update"></span>处理意见</a>
			<a class="select-btn" onclick="exportFile();" ><span class="Export"></span>导出</a>
			<a class="select-btn" data-toggle="modal" onclick="addModal();"><span class="add"></span>录入投诉</a>
		</div>
	</div>
	<!-- 列表 -->
	<div class="row-fluid">
		<div class="sub_content">
			<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
			<div id="table_list" class="gri_wrapper"></div>
		</div>
	</div>
	<!-- <div class="container-fluid">
		<div id="pad-wrapper">
			<div class="table-wrapper products-table">
				<div class="row-fluid head">
					<div class="span12">
						<h4>投诉信息管理</h4>
					</div>
				</div>
				搜索
				<div class="pull-left">
					投诉类型:<select id="type" name="type">
										<option  value="1">教练员</option>
										<option  value="2">培训机构</option>
							  </select>
					</div>		 
				<div class="row-fluid filter-block">
					
					 
					<div class="pull-right">
					 
						<input type="text" class="search" placeholder="学员编号" id="search" />
						<a class="btn-flat small" style="margin-right: 50px;" onClick="searchQuery();return false;">查询</a>
						<a class="btn-flat small" style="margin-right: 50px;" href="javascript:void(0);">导出</a>
					</div>
				</div>
			</div>
		</div>
	</div> -->
	
	<!-- Model 弹出的编辑界面-->
	<div class="modal fade" id="editorModal" tabindex="-1" role="dialog"
		aria-labelledby="editorModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">处理投诉信息</h4>
				</div>
				<div class="modal-body">
					<div class="span5">
						<form id="ediorForm">
							<input type="hidden" name="id" value="">
							
							<div class="field-box success">
								<label>学员编号:</label> 
								<input type="text" class="span5" id="studentId" name="studentId" value="" readonly="readonly">
							</div>
							<div class="field-box success">
								<label>投诉类型:</label> 
								<select id="modelType" name="modelType" readonly="readonly">
									<option  value="1">教练员</option>
									<option  value="2">培训机构</option>
								</select>
							</div>
							<div class="field-box success">
								<label><br/>学员姓名或培训机构名称:</label> <input class="span5" type="text" name="name" readonly="readonly"> 
								<input class="span5" type="hidden" name="objectId">
							</div>
							<div class="field-box success">
								<label>投诉时间:</label> <input class="span5" type="text" name="cdate" readonly="readonly">
							</div>
							<div class="field-box success">
								<label>投诉内容:</label><textarea rows="2" cols="10" name="content"></textarea>
							</div>
							<div class="field-box success">
								<label>处理意见:</label><textarea rows="2" cols="10" name="schopinion"></textarea>
							</div>
						</form>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onClick="save();">保存</button>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		//标识当前页面的url 用来设置当前菜单标识
		var dataTable = null;
		var insId= '<sec:authentication property="principal.insId"/>';
		var insName = '<sec:authentication property="principal.insName"/>';
		var statId= '<sec:authentication property="principal.stationId"/>';
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
			var type = $("#type").val();
			var search = $("#search").val();
			MTA.Util.setParams('searchText', search);
			MTA.Util.setParams('type', type);
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
				'studentId' : {
					'thText' : '学员编号',
					'number' : false,
					'colAlign' : 'left',
					'thAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
				},
				'name': {
					'thText' : '教练姓名或培训机构名称',
					'number' : false,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
				},
				'type' : {
					'thText' : '投诉类型',
					'number' : false,
					'colAlign' : 'left',
					'thAlign' : 'left',
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
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
				},
				'content' : {
					'thText' : '投诉内容',
					'number' : false,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
				},
				'id' : {
					'thText' : ' ',
					'thAlign' : 'right',
					'number' : false,
					'colAlign' : 'right',
					'needOrder' : false,
					'precision' : 0,
					'width' : '150px',
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						var sRecord = JSON.stringify(record);
						td.push('<ul class="actions">');
						td.push('<li>');
						td.push('<a onClick="showEditorModel(' + record.id + ' )">');
						td.push('处理');
						td.push('</a>');
						td.push('</li>');
						td.push('<li>');
						td.push("<input class='btn-flat primary' type='button' onClick='upRecord("+ sRecord + ")' value='上传备案'>");					
						td.push('</li>');
						td.push('</ul>');
						return td.join('');
					}
				}
			};
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/complaint/list',
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
			$('#ediorForm input[name="id"]').val('');
			$('#ediorForm select[name="modelType"]').val('');
			$('#ediorForm input[name="studentId"]').val('');
			$('#ediorForm input[name="name"]').val('');
			$('#ediorForm input[name="cdate"]').val('');
			$('#ediorForm textarea[name="content"]').val('');
			$('#ediorForm textarea[name="schopinion"]').val('');
			$('#ediorForm textarea[name="objectId"]').val('');
			if (id) {
				//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
				$.getJSON("${ctx}/complaint/" + id, function (result) {
					 if (result.code==200) {
						 	var data = result.data;
						 	$('#ediorForm input[name="id"]').val(data.id);
						 	$('#ediorForm select[name="modelType"]').val(data.type);
						 	$('#ediorForm input[name="studentId"]').val(data.studentId);
							$('#ediorForm input[name="name"]').val(data.name);
							$('#ediorForm input[name="cdate"]').val(data.cdate);
							$('#ediorForm textarea[name="content"]').val(data.content);
							$('#ediorForm textarea[name="schopinion"]').val(data.schopinion);
							$('#ediorForm textarea[name="objectId"]').val(data.objectId);
					}
				});
			}
			$('#editorModal').modal('show');
		}
		//保存
		function save() {
			//从form中取参数值
			var id = $('#ediorForm input[name="id"]').val();
			var modelType = $('#ediorForm select[name="modelType"]').val();
			var studentId = $('#ediorForm input[name="studentId"]').val();
			var name=$('#ediorForm input[name="name"]').val();
			var cdate=$('#ediorForm input[name="cdate"]').val();
			var content=$('#ediorForm textarea[name="content"]').val();
			var schopinion=$('#ediorForm textarea[name="schopinion"]').val();
			var objectId=$('#ediorForm textarea[name="objectId"]').val();
			if(schopinion==""){
				alert("请填写处理意见！");
				return false;
			}
			
			//定义提交到服务端的数据对象
			var params = {
				'id' : id,
				'type' : modelType,
				'studentId' : studentId,
				'name' : name,
				'cdate' : cdate,
				'content' : content,
				'schopinion' : schopinion
			};
			//发送数据到后端保存
			$.post('${ctx}/complaint/saveOrUpdate',params, function(result) {
				if (result.code == 200) {
					 //保存成功 刷新列表
			     	dataTable.refresh();
					 //关闭编辑的表单
					$('#editorModal').modal('hide');
				}
			});
		}
		/**
		*	展示编辑表单界面
		*	新增、修改都需要调用该方法打开表单
		*/
		function upRecord(records) {
			console.log(records);
			//弹出提示框 让用户确认删除
			var dialog = new GRI.Dialog({
				type : 4,
				title : '上传备案',
				content : '确定上传学员编号【' + records.studentId + '】的投诉信息备案吗？',
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
				if(records.cdate!=null){
					var date = new Date(records.cdate);
					var cdate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate()) + pad2( date.getHours() ) + pad2( date.getMinutes() ) + pad2( date.getSeconds() )
				}
				//定义提交到服务端的数据对象
				var params = {
						'stunum' :'5113559050455096',
						'type' : records.type,
						'objenum' :'2383114336134796',
						'cdate' : cdate,
						'content' : records.content,
						'depaopinion' : records.schopinion,
						'schopinion' : records.schopinion
				};
				//发送数据到后端保存
				$.post('http://192.168.1.6:8000/province/complaint',params,function(result) {
					if (result.errorcode == 0) {
						 //保存成功 刷新列表
				     	dataTable.refresh();
					}else{
						alert(result.message)
					}
				});
			});
		}

		function changeStatus(id) {
			window.location.href="${ctx}/trainingCar/"+id+"?"+id;
		}
	</script>
</body>
</html>