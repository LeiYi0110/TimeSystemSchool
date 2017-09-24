<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-教学大纲管理</title>
</head>
<body>
	<div class="container-fluid">
		<div id="pad-wrapper">
			<div class="table-wrapper products-table">
				<div class="row-fluid head">
					<div class="span12">
						<h4>教学大纲管理</h4>
					</div>
				</div>
				<!-- 搜索 -->
				<div class="row-fluid filter-block">
					<div class="pull-right">
						培训车型:<select id="cartype" name="cartype" onchange="searchQuery();return false;">
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
				</div>
				<!-- 列表 -->
				<div class="row-fluid">
					<div class="sub_content">
						<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
						<div id="table_list" class="gri_wrapper"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal 弹出的编辑界面-->
	<div class="modal fade" id="editorModal" tabindex="-1" role="dialog"
		aria-labelledby="editorModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">教学大纲</h4>
				</div>
				<div class="modal-body">
					<div class="" align="center">
						<form id="ediorForm">
							<input type="hidden" name="id" value="">
							<table>
								<tr height="40">
									<td width="80"><label><span class="need">&#42;</span>科目:</label></td> 
									<td><select id="subjectId" name="subjectId" readonly="readonly">
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
									</select></td>
								</tr>
								<tr height="40">
									<td width="80"><label><span class="need">&#42;</span>科目:</label></td> 
									<td><select id="subjectId" name="subjectId" readonly="readonly">
										<option  value="1">科目一</option>
										<option  value="2">科目二</option>
										<option  value="3">科目三</option>
										<option  value="4">科目四</option>
									</select></td>
								</tr>
								<tr height="40">
									<td><label><span class="need">&#42;</span>课时:</label> </td> <td>
									<input class="" type="text"  name="courseNum"></td>
								</tr>
							</table>
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
			var cartype = $("#cartype").val();
			MTA.Util.setParams('cartype',cartype);
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
				'cartype' : {
					'thText' : '车型',
					'number' : false,
					'colAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
				},
				'subjectId' : {
					'thText' : '科目',
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
									td.push('科目一');
								} else if (value == 2) {
									td.push('科目二');
								}else if(value == 3){
									td.push('科目三');
								}else if(value == 4){
									td.push('科目四');
								}
							td.push('</li>');
						td.push('</ul>');
						return td.join('');
					}
				},
				'courseNum' : {
					'thText' : '学时数(小时)',
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
						td.push('<ul class="actions">');
						td.push('<li>');
						td.push('<a onClick="showEditorModel(' + record.id + ' )">');
						td.push('编辑');
						td.push('</a>');
						td.push('</li>');
						td.push('</ul>');
						return td.join('');
					}
				}
			};
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/eachoutline/list',
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
		function showEditorModel(id) {
			//重置表单
			$('#ediorForm input[name="id"]').val('');
			$('#ediorForm select[name="cartype"]').val('');
			$('#ediorForm select[name="subjectId"]').val('');
			$('#ediorForm input[name="courseNum"]').val('');
			if (id) {
				//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
				$.getJSON("${ctx}/eachoutline/" + id, function (result) {
					 if (result.code==200) {
						 	var data = result.data;
							$('#ediorForm input[name="id"]').val(data.id);
							$('#ediorForm select[name="cartype"]').val(data.cartype);
							$('#ediorForm select[name="subjectId"]').val(data.subjectId);
							$('#ediorForm input[name="courseNum"]').val(data.courseNum);
					 }
				});
			}
			$('#editorModal').modal('show');
		}
		//保存
		function save() {
			//从form中取参数值
			var id = $('#ediorForm input[name="id"]').val();
			var cartype = $('#ediorForm input[name="cartype"]:checked').val();
			var subjectId = $('#ediorForm input[name="subjectId"]:checked').val();
			var courseNum = $('#ediorForm input[name="courseNum"]').val();
			//定义提交到服务端的数据对象
			var params = {
				'id' : id,
				'cartype' : cartype,
				'subjectId' : subjectId,
				'courseNum' : courseNum
			};
			//发送数据到后端保存
			$.post('${ctx}/eachoutline/saveOrUpdate', params, function (result) {
				 if (result.code==200) {
					 //保存成功 刷新列表
			     	dataTable.refresh();
					 //关闭编辑的表单
					$('#editorModal').modal('hide');
				}
			});
		}
		function changeStatus(id) {
			window.location.href="${ctx}/trainingCar/"+id+"?"+id;
		}
	</script>
</body>
</html>