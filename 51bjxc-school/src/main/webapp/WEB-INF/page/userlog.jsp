<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<meta name="theme" content="school" />
<title>用户日志</title>
<style>
.form-horizontal{ width:400px; margin:0 auto; margin-top:50px; }
.form-horizontal .control-label{ text-align:right; }
.form-horizontal .btn{ display:block; margin:0 auto; }
</style>
<script type="text/javascript" src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
</head>
  
<body>



	<div class="TermSearch">
		<form>
			 <input class="input1 win200" type="text" id="search" placeholder="用户名/时间/操作">
			<input type="button" class="btn-flat primary" onClick="searchQuery();return false;" value="搜 索" />
		</form>
	</div>
	
	<div id="table_list"></div>
	
	
	<input type="hidden" name="id" id="id">
	
<script type="text/javascript">
var insId = '<sec:authentication property="principal.insId"/>';
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
		'id' : {
			'thText' : '编号',
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
		'logUser' : {
			'thText' : '用户',
			'number' : false,
			'needOrder' : false,
			'precision' : 0,
		},
		'logEvent' : {
			'thText' : '操作',
			'number' : false,
			'needOrder' : false,
			'precision' : 0,
		},
		'logTime' : {
			'thText' : '操作时间',
			'number' : false,
			'needOrder' : false,
			'precision' : 0,
		},
		'remark' : {
			'thText' : '备注',
			'number' : false,
			'needOrder' : false,
			'precision' : 0,
		}
	};
	//ajax的数据请求参数
	config['page'] = {
		'url' : '${ctx}/userlog/getlist?insId='+insId,
		'size' : 1000,
		'ifRealPage' : 0
	};
	//初始化 并通过ajax加载数据
	dataTable = MTA.Data.loadAjaxPageTable(config);
}

</script>

</body>
</html>
