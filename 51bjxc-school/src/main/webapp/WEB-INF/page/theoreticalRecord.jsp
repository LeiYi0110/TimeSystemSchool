<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>

<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-理论排班记录</title>
<link type="text/css" href="${ctx}/resources/css/compiled/new-form.css" rel="stylesheet" />
<link href="${ctx}/resources/css/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen" />
<link href="${ctx}/resources/js/form-prompt/style.css" type="text/css" rel="stylesheet" media="all" />
<script type="text/javascript" src="${ctx}/resources/js/form-prompt/Validform_v5.3.2_min.js"></script>
<script src="${ctx}/resources/uploadify/jquery.uploadify.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery-form.js"></script>
</head>
<body>
	<div class="container-fluid new-admin">
		<div class="select-top">
			<a class="select-btn" onclick="exportFile();"><span class="Export"></span>导出</a>
		</div>
	</div>
	 <div class="TermSearch">
 	 <form>
	 <input type="text" class="form_date input1 win90" id="time1"
					data-date-format="yyyy-mm-dd" placeholder="请选择开始日期" readonly="readonly" style="width:95px;">
	 <buuton class="btn-flat primary" onClick="searchQuery();return false;">搜 索</buuton>
	 </form>
	 </div> 
	<!-- 列表 -->
	<div class="row-fluid">
		<div class="sub_content">
			<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
			<div id="table_list" class="gri_wrapper"></div>
		</div>
	</div>
	<script type="text/javascript">
		var insId= '<sec:authentication property="principal.insId"/>';
		var insName = '<sec:authentication property="principal.insName"/>';
		var statId= '<sec:authentication property="principal.stationId"/>';
		/**
		 * 
		 * 获取当前时间
		 */
		function p(s) {
		    return s < 10 ? '0' + s: s;
		}

		var myDate = new Date();
		//获取当前年
		var year=myDate.getFullYear();
		//获取当前月
		var month=myDate.getMonth()+1;
		//获取当前日
		var date=myDate.getDate(); 
		
		var now=year+'-'+p(month)+"-"+p(date);
		$("#time1").val(now);
		MTA.Util.setParams('classDate', now);
		MTA.Util.setParams('stationId', statId);
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
			var time1 = $("#time1").val();
			MTA.Util.setParams('classDate', time1);
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
				'classDate' : {
					'thText' : '上课日期',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<span data-id="');
							td.push(record.id);
							td.push('">');
							td.push(record.classDate);
						td.push('</span>');
						return td.join('');
					}
				},	
				'studentName' : {
					'thText' : '学员姓名',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'mobile' : {
					'thText' : '电话号码',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'idcard' : {
					'thText' : '身份证号码',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'recordnum' : {
					'thText' : '流水号',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'endTime' : {
					'thText' : '提交时间',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'remarks' : {
					'thText' : '备注',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				}
			};
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/schedulingTheory/recordList',
				'size' : 10,
				'ifRealPage' : 1
			};
			//初始化 并通过ajax加载数据
			dataTable = MTA.Data.loadAjaxPageTable(config);
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
		function exportFile(){
			var classDate = $("#time1").val();
			window.location.href="${ctx}/schedulingTheory/exporTrecordList?&stationId="+statId+'&classDate='+classDate;
		}
	</script>
     
</body>
</html>