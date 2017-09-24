<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>

<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-理论课上报</title>
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
			<a class="select-btn" data-toggle="modal" onclick="addReport();"><span class="add"></span>上报人数</a>
		</div>
	</div>
	<div class="TermSearch" id="termSearch">
		<span>已选人数:</span> <input class="input1 win200" style="width: 30px"  type="text" id="outNumber" value="0" readonly="readonly"><h4></h4>
	 </div>
	<!-- 列表 -->
	<div class="row-fluid">
		<div class="sub_content">
			<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
			<div id="table_list" class="gri_wrapper"></div>
		</div>
	</div>
	<script type="text/javascript">
		var recordUrl=<custom:properties name='bjxc.user.province'/>;
		var insId= '<sec:authentication property="principal.insId"/>';
		var insName = '<sec:authentication property="principal.insName"/>';
		var statId= '<sec:authentication property="principal.stationId"/>';
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
				'checkbox' : {
					'thText' : '<input type="checkbox" id="quanxuan" onclick="quanxuan()"> 全选',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						console.log(record);
						var td = [];
						td.push('<span data-id="');
							td.push(record.id);
							td.push('">');
							td.push('<input type="checkbox" class="data-id" value="'+ record.id +'" onclick="selected();">');
						td.push('</span>');
						return td.join('');
					}
				},	
				'studentName' : {
					'thText' : '学员姓名',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<span data-id="');
							td.push(record.id);
							td.push('">');
							td.push(record.studentName);
						td.push('</span>');
						return td.join('');
					}
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
				'applydate' : {
					'thText' : '报名时间',
					'number' : true,
					'needOrder' : false,
					'precision' : 0,
				}
			};
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/schedulingTheory/reportList',
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
		//上报人数
		function addReport(){
			
			var arrId = [];
			$('table input[class="data-id"]:checked').each(function(){     
				arrId.push($(this).val());//向数组中添加元素  
			 });
			if(arrId.length == 0){
				layer.alert("请选择");
				return;
			}
			var params = {
					"ids":arrId,
					"insId":insId,
					"stationId":statId,
					"repNumber":arrId.length
				}; 
			$.post("${ctx}/schedulingTheory/theoryUpdate",params,function (result) {
				if (result.code==200) {
					$("#termSearch h4").text("本次上报时间:"+result.data.createtime+"  上报人数："+result.data.repNumber+"人"); 
					buildDataTable();
				}
			});
			
		}
		function quanxuan(){
			if($("input[id='quanxuan']").is(':checked')){
				$('table input[class="data-id"]').prop("checked",true);
			}else{
				$('table input[class="data-id"]').prop("checked",false);
			}	
			var arrId = [];
			$('table input[class="data-id"]:checked').each(function(){     
				arrId.push($(this).val());//向数组中添加元素  
			 });
			$("#outNumber").val(arrId.length)
		}
		//已选中人数
		function selected(){
			var arrId = [];
			$('table input[class="data-id"]:checked').each(function(){     
				arrId.push($(this).val());//向数组中添加元素  
			 });
			$("#outNumber").val(arrId.length);
			
		}
		initForm();
		function initForm(){
			//定义提交到服务端的数据对象
			var param= {
				"insId":insId,
				"stationId":statId
			}
			//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
			$.getJSON("${ctx}/schedulingTheory/getTheoryReportInfo",param,function (result) {
				 if (result.code==200) {
					 var data = result.data;
					 $("#termSearch h4").text("上次上报时间:"+data.createtime+"  上报人数："+data.repNumber+"人"); 
				}
			});
		}
	</script>
     
</body>
</html>