<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>

<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-理论课人数</title>
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
		<!-- <a class="select-btn" data-toggle="modal" href="/comment/exportshcoolcomm?insId=1"><span class="edit"></span>导出</a> -->
		<sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
			<a class="select-btn" onclick="exportFile();"><span class="Export"></span>导出</a>
		</sec:authorize>
		<sec:authorize access="hasRole('ROLE_SCHOOL_SERVICE')">
			<sec:authorize access="hasRole('ROLE_UserOperation_165')">
				<a class="select-btn" onclick="exportFile();"><span class="Export"></span>导出</a>
			</sec:authorize>
		</sec:authorize>
		</div>
	</div>
	 <div class="TermSearch">
 	 <form>
		 &nbsp;&nbsp;&nbsp;上课总人数
		 <input class="input1 win90" style="color:black;" type="text" readonly="readonly" id="totalStuId" />
		 &nbsp;&nbsp;&nbsp;&nbsp;
		 <select id="selectingDistrictId">
		  	 <option value="-1">选择片区</option>
		 </select>
		 <input id="beginDateId" class="form_date input1 win90" readonly="readonly" data-date-format="yyyy-mm-dd" type="text">
		 <input id="endDateId" class="form_date input1 win90" readonly="readonly" data-date-format="yyyy-mm-dd" type="text">
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
		var insId= '<sec:authentication property="principal.insId"/>';
		var insName = '<sec:authentication property="principal.insName"/>';
		var selectedTime = 0;
		
		function searchQuery(){
			var areaId=$("#selectingDistrictId").val();
			$("#totalStuId").val(0);
			var beginCreateTime=$("#beginDateId").val();
			var endCreateTime=$("#endDateId").val();
			MTA.Util.setParams('insId', insId);
			MTA.Util.setParams('areaId', areaId);
			MTA.Util.setParams('beginCreateTiStr', beginCreateTime);
			MTA.Util.setParams('endCreateTiStr', endCreateTime);
			buildDataTable();
		}
		//初始化 
		$(document).ready(function() {
			var param={"insId":insId};
			$.get('${ctx}/theoryreportinfo/getareas',param,function(result){
				if(result.code==200){
					if(result.data!=null){
						for (var i = 0; i < result.data.length; i++) {
							$("#selectingDistrictId").append("<option value='" + result.data[i].id + "'>" + result.data[i].name + "</option>");
						}
					}
				}else{
					layer.alert(result.message);
				}
			});
			$("#beginDateId").val(getNowFormatDate(setTime()));
			$("#endDateId").val(getNowFormatDate(null));
			
			//初始化界面  完成后调用buildData方法
			MTA.Report.initialize(null, 'buildData');
		});
		function buildData() {
			var areaId=$("#selectingDistrictId").val();
			$("#totalStuId").val(0);
			var beginCreateTime=$("#beginDateId").val();
			var endCreateTime=$("#endDateId").val();
			MTA.Util.setParams('insId', insId);
			MTA.Util.setParams('areaId', areaId);
			MTA.Util.setParams('beginCreateTiStr', beginCreateTime);
			MTA.Util.setParams('endCreateTiStr', endCreateTime);
			buildDataTable();
		}
		/**
		*	构建列表
		*/
		function buildDataTable() {
			var config = {
				'container' : 'table_list'
			};
			var flagNum=0;
			//定义列表的列
			config['allFields'] = {
				'stationName' : {
					'thText' : '网点名称',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,columnIndex) {
						if(flagNum==0){
							$("#totalStuId").val(record.totalCount);
							flagNum=1;
						}
						var td = [];
						td.push('<span>');
						td.push(value);
						td.push('</span>');
						return td.join('');
					}
				},
				'repNumber' : {
					'thText' : '要求上课人数',
					'number' : true,
					'needOrder' : false,
					'precision' : 0,
				},
				'createtime' : {
					'thText' : '提交日期',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				}
			}
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/theoryreportinfo/getcourselist',
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
				content : '确定要导出【理论课人数的统计】到excel表格吗?',
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
					var beginCreateTime=$("#beginDateId").val();
					var endCreateTime=$("#endDateId").val();
					var param={
						'insId':insId,
						'areaId':areaId,
						'beginCreateTiStr': beginCreateTime,
						'endCreateTiStr': endCreateTime,
						'areaName':areaName
					};
					window.location.href="${ctx}/theoryreportinfo/theorecournum?insId="+insId+"&areaId="+areaId+"&beginCreateTiStr="+
						beginCreateTime+"&endCreateTiStr="+endCreateTime+"&areaName="+areaName;
				});
		}
		//格式化日期
		function getNowFormatDate(date) {
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
			}else{
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
		}
		//得到星期一的时间
		function setTime(){
			var now = new Date(); 
			var nowTime = now.getTime() ; 
			var day = now.getDay();
			var oneDayLong = 24*60*60*1000 ; 

			var MondayTime = nowTime - (day-1)*oneDayLong;
			var monday = new Date(MondayTime);
			return monday;
		}
	</script>
     
</body>
</html>