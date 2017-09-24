<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<style>
	#uploadPhoto  .form-controll { width:360px; }
	#uploadPhoto label{ width:160px; }
	#uploadVideo  .form-controll { width:360px; }
	#uploadVideo label{ width:160px; }
	#Batch-img .img-item{ float:left; width:155px; margin-right:15px; margin-bottom:15px; text-align:center; }
	#Batch-img .img-item:nth-of-type(5n){ margin-right:0; }
	#Batch-img .img-item img{ display:block; width:100%; height:100%; }
</style>
<meta name="theme" content="school" />
<title>阳光驾培-学时管理</title>
<script type="text/javascript" src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=4O6x7Ox8vHvQeQgnMAPOolXiYkudOdZr"></script>
<script src="${ctx}/resources/uploadify/jquery.uploadify.js"></script>
</head>
<body>


	<div class="TermSearch">
		<input class="input1 win200" type="text" placeholder="输入学员姓名" style="width:150px;" id="stuname">
		<input type="text" class="form_date input1 win90" data-date-format="yyyy-mm-dd" placeholder="请选择日期" readonly="readonly" id="day">
		<select id="subjectId">
		  	<option value="">请选择培训阶段</option>
		  	<option value="1">第一部分</option>
		  	<option value="2">第二部分</option>
		  	<option value="3">第三部分</option>
		  	<option value="4">第四部分</option>
		</select>
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
			var stuname = $("#stuname").val();
			var day = $("#day").val();
			var subjectId = $("#subjectId").val();
			var inspass = $("#inspass").val();
			var propass = $("#propass").val();
			
			MTA.Util.setParams('propass', propass);
			MTA.Util.setParams('inspass', inspass);
			MTA.Util.setParams('stuname', stuname);
			MTA.Util.setParams('day', day);
			MTA.Util.setParams('subjectId', subjectId);
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
				'studentnum' : {'thText' : '学员编号'},
				'stuname' : {'thText' : '学员姓名'},
				'subjectId' : {
					'thText' : '培训部分',
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						td = [];
						if (value == 1) {
							td.push('第一部分');
						} else if (value == 2) {
							td.push('第二部分');
						} else if (value == 3) {
							td.push('第三部分');
						} else if (value == 4) {
							td.push('第四部分');
						}else{
							td.push(value);
						}
						return td.join('');
					}
				},
				'parttime' : {'thText' : '培训学时'},
				'partmile' : {'thText' : '培训里程'},
				'mtime' : {
					'thText' : '大纲规定学时',
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						td = [];
						if (value == 1) {
							td.push('720');
						} else if (value == 2) {
							td.push('960');
						} else if (value == 3) {
							td.push('1440');
						} else if (value == 4) {
							td.push('600');
						}else{
							td.push(value);
						}
						return td.join('');
					}
				},
				'mmile' : {
					'thText' : '大纲规定里程',
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						td = [];
						if (value == 1) {
							td.push('0');
						} else if (value == 2) {
							td.push('0');
						} else if (value == 3) {
							td.push('>=300');
						} else if (value == 4) {
							td.push('0');
						}else{
							td.push(value);
						}
						return td.join('');
					}
				}
			};
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/trainingLog/graduation',
				'size' : 1000,
				'ifRealPage' : 0
			};
			//初始化 并通过ajax加载数据
			dataTable = MTA.Data.loadAjaxPageTable(config);
		}
		

</script>
</body>
</html>