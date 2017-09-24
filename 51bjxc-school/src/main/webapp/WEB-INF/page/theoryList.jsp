<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>

<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-理论名单</title>
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
		<sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
			<a class="select-btn" onclick="exportFile();"><span class="Export"></span>导出</a>
		</sec:authorize>
		<sec:authorize access="hasRole('ROLE_SCHOOL_SERVICE')">
			<sec:authorize access="hasRole('ROLE_UserOperation_167')">
				<a class="select-btn" onclick="exportFile();"><span class="Export"></span>导出</a>
			</sec:authorize>
		</sec:authorize>
		</div>
	</div>
	 <div class="TermSearch">
 	 <form>
 	 	<select id="selectingDistrictId" onchange="changeArea();return false;">
		  	 <option value="-1">选择片区</option>
		 </select>
		 <select id="selectingStationId" >
		  	 <option value="-1">全部网点</option>
		 </select>
		 <input id="dateId" class="form_date input1 win90" readonly="readonly" data-date-format="yyyy-mm-dd" type="text">
		 <button class="btn-flat primary" onClick="searchQuery();return false;">搜 索</button>
	 </form>
	 </div>
	 
	<!-- 列表 -->
	<div class="row-fluid">
		<div class="sub_content">
			<div id="table_list" class="gri_wrapper"></div>
		</div>
	</div>
	<script type="text/javascript">
		var recordUrl=<custom:properties name='bjxc.user.province'/>;
		var insName = '<sec:authentication property="principal.insName"/>';
		var statId= '<sec:authentication property="principal.stationId"/>';
		var selectedTime = 0;
		
		function changeArea(){
			var areaId=$("#selectingDistrictId").val();
			
			var param={"areaId":areaId,"insId":insId};
			$.get('${ctx}/theoryreportinfo/getstationbyareaid',param,function(result){
				if(result.code==200){
					if(result.data!=null){
						$("#selectingStationId").empty();
						$("#selectingStationId").append('<option value="-1">全部网点</option>');
						for (var i = 0; i < result.data.length; i++) {
							$("#selectingStationId").append("<option value='" + result.data[i].id + "'>" + result.data[i].name + "</option>");
						}
					}
				}else{
					layer.alert(result.message);
				}
			});
		}
		//初始化 
		$(document).ready(function() {
			var param={"insId":insId};
			$.get('${ctx}/theoryreportinfo/getareas',param,function(result){
				if(result.code==200){
					if(result.data!=null){
						$("#selectingDistrictId").empty();
						$("#selectingDistrictId").append('<option value="-1">选择片区</option>');
						for (var i = 0; i < result.data.length; i++) {
							$("#selectingDistrictId").append("<option value='" + result.data[i].id + "'>" + result.data[i].name + "</option>");
						}
					}
				}else{
					layer.alert(result.message);
				}
			});
			$.get('${ctx}/theoryreportinfo/getstations',param,function(result){
				if(result.code==200){
					if(result.data!=null){
						$("#selectingStationId").empty();
						$("#selectingStationId").append('<option value="-1">全部网点</option>');
						for (var i = 0; i < result.data.length; i++) {
							$("#selectingStationId").append("<option value='" + result.data[i].id + "'>" + result.data[i].name + "</option>");
						}
					}
				}else{
					layer.alert(result.message);
				}
			});
			$("#dateId").val(getNowFormatDate());
			//初始化界面  完成后调用buildData方法
			MTA.Report.initialize(null, 'buildData');
		});
		function buildData() {
			var areaId= $("#selectingDistrictId").val();
			var staId=$("#selectingStationId").val();
			var date=$("#dateId").val();
			
			MTA.Util.setParams('insId', insId);
			MTA.Util.setParams('areaId', areaId);
			MTA.Util.setParams('staId', staId);
			
			if(date!=''){
				MTA.Util.setParams('classDateStr', date);
			}
			buildDataTable();
		}
		/**
		*	搜索
		*/
		function searchQuery() {
			buildData();
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
					'thText' : '日期',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push(getNowFormatDateFromDate(getDate(value)));
						return td.join('');
					}
				},
				'stationName' : {
					'thText' : '网点名称',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'stuName' : {
					'thText' : '学员姓名',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'stuMobile' : {
					'thText' : '电话号码',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'stuIdCard' : {
					'thText' : '身份证号',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'stuRecNum' : {
					'thText' : '流水号',
					'number' : true,
					'needOrder' : false,
					'precision' : 0,
				},
				'endTime' : {
					'thText' : '提交日期',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push(getNowFormatDateFromDate(getDate(value)));
						return td.join('');
					}
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
				'url' : '${ctx}/schedulingTheory/schetheorylist?insId='+insId,
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
			var dialog = new GRI.Dialog({
				type : 4,
				title : '导出',
				content : '确定要导出【理论上课名单】到excel表格吗?',
				deGRIil : '',
				btnType : 1,
				extra : {
					top : 250
				},
				winSize : 1
				},function(){
					var areaId=$("#selectingDistrictId").val();
					var areaName=$("#selectingDistrictId :selected").text();
					if(areaName=='选择片区'){
						areaName="全部片区";
					}
					var staId=$("#selectingStationId").val();
					var staName=$("#selectingStationId :selected").text();
					var classDate=$("#dateId").val();
					/* var param={
						'insId':insId,
						'areaId':areaId,
						'beginCreateTiStr': beginCreateTime,
						'endCreateTiStr': endCreateTime,
						'areaName':areaName
					}; */
					window.location.href="${ctx}/schedulingTheory/exportschetheory?insId="+insId+"&areaId="+areaId+"&areaName="+areaName+"&staId="+staId
							+"&staName="+staName+"&classDateStr="+classDate;
				});
		}
		//格式化日期
		function getNowFormatDate() {
		    var date = new Date();
		    var seperator1 = "-";
		    var year = date.getFullYear();
		    var month = date.getMonth() + 1;
		    var strDate = date.getDate();
		    if (month >= 1 && month <= 9) {
		       month = "0" + month;
		    }
		    if (strDate >= 0 && strDate <= 9) {
		    	strDate = "0" + strDate;
		    }
		    var currentdate = year + seperator1 + month + seperator1 + strDate;
		    return currentdate;
		}
		function getNowFormatDateFromDate(date) {
			if(date!=null){
		    var seperator1 = "-";
		    var year = date.getFullYear();
		    var month = date.getMonth() + 1;
		    var strDate = date.getDate();
		    if (month >= 1 && month <= 9) {
		       month = "0" + month;
		    }
		    if (strDate >= 0 && strDate <= 9) {
		    	strDate = "0" + strDate;
		    }
		    var currentdate = year + seperator1 + month + seperator1 + strDate;
		    return currentdate;
			}
		}
		//把字符转换为日期	
		function getDate(strDate) {
			if(strDate!=null){
	        var date = eval('new Date(' + strDate.replace(/\d+(?=-[^-]+$)/,
	         function (a) { return parseInt(a, 10) - 1; }).match(/\d+/g) + ')');
	        return date;
			}
	    }
	</script>
     
</body>
</html>