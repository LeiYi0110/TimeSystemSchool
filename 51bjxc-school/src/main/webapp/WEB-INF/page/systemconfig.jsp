<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<meta name="theme" content="school" />
<title>系统参数配置</title>
<style>
.form-horizontal{ width:400px; margin:0 auto; margin-top:50px; }
.form-horizontal .control-label{ text-align:right; }
.form-horizontal .btn{ display:block; margin:0 auto; }
</style>
<script type="text/javascript" src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
</head>
  
<body>

	<div class="container-fluid new-admin">
		<div class="select-top">
		<sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
			<a class="select-btn" onclick="update()"><span class="spare"></span>修改</a>
		</sec:authorize>
		
		<sec:authorize access="hasRole('ROLE_SCHOOL_SERVICE')">
			<sec:authorize access="hasRole('ROLE_UserOperation_205')">
				<a class="select-btn" onclick="update()"><span class="spare"></span>修改</a>
			</sec:authorize>
		</sec:authorize>
		</div>
	</div>
	
	<div id="table_list"></div>
	
		<div class="modal fade colsform " tabindex="-1" id="updateModal"
		role="dialog" aria-hidden="true" style="width:370px; margin-left:-185px;">
		<form class="form-horizontal" id="updateForm">
			<h4>系统参数设置</h4>
			<div class="modal-content">
					<div class="row1">
						<div class="form-controll"  style="margin-right: auto; width: 100%;">
							<label>参数名称:</label> <input type="text" name="flagName" id="flagName" readonly="readonly">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll"  style="margin-right: auto; width: 100%;">
							<label>参数值(1,0):</label> <input type="text" name="flagValue" id="flagValue" />
						</div>
					</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" onClick="updatesave();">修改</button>
			</div>
		</form>
	</div>
	<input type="hidden" name="id" id="id">
	
<script type="text/javascript">
var insCode = '<sec:authentication property="principal.insCode"/>';
//初始化 
$(document).ready(function() {
	//初始化界面  完成后调用buildData方法
	MTA.Report.initialize(null, 'buildData');
});
function buildData() {
	buildDataTable();
}

function update(){
	//重置表单
	var id=sessionStorage.getItem('tabId')
	
	if(id === null || id === undefined){
		alert('未选择目标');
	}else{
		//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
		$.getJSON("${ctx}/systemconfig/" + id,function(result) {
			if (result.code == 200) {
				var data = result.data;
				$('input[name="id"]').val(data.id);
				$('#updateForm input[name="flagName"]').val(data.flagName);
				$('#updateForm input[name="flagValue"]').val(data.flagValue);
			}
		});
		$('#updateModal').modal('show');
	}
	
}
function updatesave(){
	//从form中取参数值
	var id = $('input[name="id"]').val();
	var flagName = $('#updateForm input[name="flagName"]').val();
	var flagValue = $('#updateForm input[name="flagValue"]').val();
	var param = {
			'id' : id,
			'flagName' : flagName,
			'flagValue' : flagValue,
			'Inscode':insCode
	};
	
	//发送数据到后端保存
	$.post('${ctx}/systemconfig/update', param,function(result){
				if (result.code == 200) {
					//保存成功 刷新列表
					buildDataTable();
					//关闭编辑的表单
					layer.alert('保存成功')
					$('#updateModal').modal('hide');
				}else{
					layer.alert('保存失败')
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
		'id' : {
			'thText' : '参数编号',
			'number' : false,
			'needOrder' : false,
			'precision' : 0,
			'render' : function(value, cellmeta, record, rowIndex,
					columnIndex) {
				var td = [];
				td.push('<span data-id='+record.id+'>'+value+'</span>');
				return td.join('');
			}
		},
		'inscode' : {
			'thText' : '机构编号',
			'number' : false,
			'needOrder' : false,
			'precision' : 0,
		},
		'flagName' : {
			'thText' : '参数名称',
			'number' : false,
			'needOrder' : false,
			'precision' : 0,
		},
		'flagValue' : {
			'thText' : '参数值',
			'number' : false,
			'needOrder' : false,
			'precision' : 0,
		},
		'remark' : {
			'thText' : '参数说明',
			'number' : false,
			'needOrder' : false,
			'precision' : 0,
		}	
	};
	//ajax的数据请求参数
	config['page'] = {
		'url' : '${ctx}/systemconfig/getlist?Inscode='+insCode,
		'size' : 1000,
		'ifRealPage' : 0
	};
	//初始化 并通过ajax加载数据
	dataTable = MTA.Data.loadAjaxPageTable(config);
}

</script>

</body>
</html>
