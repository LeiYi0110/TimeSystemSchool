<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-培训流程</title>
<script type="text/javascript" src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=4O6x7Ox8vHvQeQgnMAPOolXiYkudOdZr"></script>
<script src="${ctx}/resources/uploadify/jquery.uploadify.js"></script>
</head>
<body>
	<div class="TermSearch">
		学员姓名：<input class="input1 win200" type="text" placeholder="输入学员姓名" style="width:150px;" id="search">
		学员编号：<input class="input1 win200" type="text" placeholder="输入学员编号" style="width:150px;" id="search">
		学员身份证：<input class="input1 win200" type="text" placeholder="输入学员身份证" style="width:150px;" id="search">
		
		<button class="btn-flat primary" onClick="searchQuery();return false;">搜 索</button>
		<!-- <button class="btn-flat primary" onClick="searchPhoto();return false;">照 片 审 核</button> -->
	</div>
		
	<div class="row-fluid">
		<div class="sub_content">
			<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
			<div id="table_list" class="gri_wrapper"></div>
		</div>
	</div>

<script type="text/javascript">
//标识当前页面的url 用来设置当前菜单标识
		var dataTable = null;
		var recordUrl = <custom:properties name="bjxc.user.province"/>;
		var insId= '<sec:authentication property="principal.insId"/>';
		var insName = '<sec:authentication property="principal.insName"/>';
		var statId= '<sec:authentication property="principal.stationId"/>';
		var insCode = '<sec:authentication property="principal.insCode"/>';
		
		var recordId = sessionStorage.getItem("recordId");
		//初始化 
		$(document).ready(function() {
			//初始化界面  完成后调用buildData方法
			MTA.Report.initialize(null, 'buildData');
		});
		/**
		*	搜索
		*/
		function searchQuery() {
			var search = $("#search").val();
			MTA.Util.setParams('search', search);
			buildDataTable();
		}
		function buildData() {
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
				'stunum' : {'thText' : '学员编号'},
				'studentName' : {'thText' : '学员姓名'},
				'idcard' : {'thText' : '身份证号'},
				'mobile' : {'thText' : '手机号码'},
				'createTime' : {'thText' : '记录时间'},
				'content' : { 'thText' : '记录事件' },
			};
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/student/getStudentLog',
				'size' : 1000,
				'ifRealPage' : 0
			};
			//初始化 并通过ajax加载数据
			dataTable = MTA.Data.loadAjaxPageTable(config);
		}
</script>
</body>
</html>