<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<meta name="theme" content="school" />

<title>阳光驾培-报名信息查询</title>
<link href="${ctx}/resources/css/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen" />
<script src="${ctx}/resources/uploadify/jquery.uploadify.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/classType/<sec:authentication property="principal.insId"/>"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery-form.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/serviceStation/<sec:authentication property="principal.insId"/>"></script>
<script type="text/javascript" src="${ctx}/resources/js/Area/<sec:authentication property="principal.insId"/>"></script>

</head>
<body>
	<div class="container-fluid new-admin">
		<div class="select-top">
		</div>
	</div>

	<div class="TermSearch">
		<form>
			<input class="input1 win200" type="text" id="searchText" placeholder="名称/培训车型">
			<input id="startTime" class="input1 win200 inputDate"  type="text" placeholder="查询开始日期" data-date-format="yyyy-mm-dd"/>
			<input id="endTime" class="input1  win200 inputDate"  type="text" placeholder="查询结束日期" data-date-format="yyyy-mm-dd"/>
			
			<buuton class="btn-flat primary"
				onClick="searchQuery();return false;">搜 索</buuton>
		</form>
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

		//初始化 
		$(document).ready(function() {
			//初始化界面  完成后调用buildData方法
			
			MTA.Util.setParams('startTime', 0);
			MTA.Util.setParams('endTime', 0);
			MTA.Util.setParams('searchText', '');
			
			
			MTA.Report.initialize(null, 'buildData');
		});
		/**
		*	搜索
		*/
		function searchQuery() {
			var searchText = $("#searchText").val();
			var startTime = $("#startTime").val() == '' ? 0 : (new Date(Date.parse($("#startTime").val())).getTime());
			var endTime = $("#endTime").val() == '' ? 0 : (new Date(Date.parse($("#endTime").val())).getTime());
			
			MTA.Util.setParams('startTime', startTime);
			MTA.Util.setParams('endTime', endTime);
			MTA.Util.setParams('searchText', searchText);
			
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
				'name' : {
					'thText' : '姓名',
				},
				'sex' : {
					'thText' : '性别',
					'number' : false,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						td = [];
						if (value == 2) {
							td.push('女');
						} else if (value == 1) {
							td.push('男 ');
						}
						return td.join('');
					}
				},
				'mobile' : {
					'thText' : '手机号',
				},
				'idcard' : {
					'thText' : '身份证',
				},
				'createTime' : {
					'thText' : '报名时间',
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						td = [];
						var text = "";
						td.push('<div style="text-align:center">');

						if(!!Number(value) || Number(value) == 0){
							text = "";
						}else{
							var time = new Date(value);
							text = time.getFullYear() + "-" + (time.getMonth() + 1) + "-" + time.getDate();
						}
						
						td.push(text);
						td.push('</div>');
						return td.join('');
					}
				},
				'paymode' : {
					'thText' : '报名班型',
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						td = [];
						var type = "";
						td.push('<div style="text-align:center">');
						if (value == 1) {
							type = "传统班";
						} else if (value == 2) {
							type = "计时班-先付后学";
						} else if(value == 3){
							type = "计时班-先学后付";
						}
						td.push(type);
						td.push('</div>');
						return td.join('');
					}
				},
				'trainType' : {
					'thText' : '培训车型',
				},
				'price' : {
					'thText' : '班型费用',
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						td = [];
						if (!!value) {
							td.push('<div style="text-align:center">');
							td.push(value/100);
							td.push('</div>');
						}
						return td.join('');
					}
				},
				'status' : {
					'thText' : '状态',
					'number' : false,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						td = [];
						if (value == 0) {
							td.push('<div style="text-align:center">');
							td.push('未处理');
							td.push('</div>');
						} else if (value == 1) {
							td.push('<div style="text-align:center">');
							td.push('已处理 ');
							td.push('</div>');
						}
						return td.join('');
					}
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
						if(record.status==0){
							td.push('<ul class="actions">');
							td.push('<li>');
							td.push('<a class="btn-flat primary"  onClick="remove(' + record.id + ',\'' + record.name + '\')">');
							td.push('处理成功');
							td.push('</a>');
							td.push('</li>');
						}else if(record.status==1 && record.stuId==null){
							td.push('<ul class="actions">');
							td.push('<li>');
							td.push('信息未录入');
							td.push('</a>');
							td.push('</li>');
						}
						return td.join('');
					}
				}
			};
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/referee/studentRefereeList',
				'ifRealPage' : 1
			};
			//初始化 并通过ajax加载数据
			dataTable = MTA.Data.loadAjaxPageTable(config);
		}
		
		
		//日期插件 
		$(".inputDate").datetimepicker({
	        language:  'zh-CN',
	        weekStart: 1,
	        todayBtn:  1,
			autoclose: 1,
			todayHighlight: 0,
			startView: 2,
			minView: 2,
			forceParse: 0
	   	}).on('changeDate', function(ev){
		  	/* if($("#startTime").val() != '' && $("#endTime").val() != ''){
		  		var startTime = new Date(Date.parse($("#startTime").val())).getTime();
		  		var endTime = new Date(Date.parse($("#endTime").val())).getTime();
		  		if(startTime > endTime){
		  			$("#endTime").val("");
		  		}
		  	}  */
	   	});
		
	</script>
</body>
</html>