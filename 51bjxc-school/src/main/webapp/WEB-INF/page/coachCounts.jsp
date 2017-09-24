<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta name="theme" content="school" />
<script type="text/javascript" src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<link type="text/css" href="${ctx}/resources/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
<style type="text/css">
	.div_top p{
		margin: 98px 0px 0px 10px;
		font-size: 18px;
		font-family: "微软雅黑"
	}
	.div_Survey p{
		margin: 30px 0px 0px 485px;
		font-size: 18px;
		font-family: "微软雅黑"
	}
	.div_Survey .div_bk{
		background-image:url(${ctx}/resources/img/logo-number.png);
	}
</style>
</head>
<body>
 <div>
 	<div class="container-fluid new-admin">
		<div class="select-top">
			<a class="select-btn" data-toggle="modal" onclick="">
				<span class="add"></span>导出
			</a>
		</div>
		<div class="TermSearch">
			<form id="formId">
				<input id="timeId" onblur="checkBuildData()" onchange="change()" class="form_date input1 win90" readonly="readonly" data-date-format="yyyy-mm" type="text">
				<select id="selectingStationId" onchange="buildData()">
					<option value="-1" checked="">全部</option>
				</select>
			</form>
		</div>
	</div>
	
 </div>
 <!-- 列表 -->
	<div class="row-fluid">
		<div class="sub_content">
			<div id="table_list" class="gri_wrapper">
			</div>
		</div>
	</div>
<script type="text/javascript">
	var current_action = "${ctx}/view/studentCounts";
	var insId= <sec:authentication property="principal.insId"/>;
	var dataTable = null;
	var date=getNowFormatDate();
	$("#timeId").val(date);
	
	var stationId=$("#selectingStationId :checked").val();
	var coaMonth=null;//月份
	var timeVal=null;
	$(document).ready(function() {
		if(insId!=null){
			var param={"insId":insId};
			$.get('${ctx}/coach/getStations',param,function(result){
				if(result.code==200){
					if(result.data!=null){
						for (var i = 0; i < result.data.length; i++) {
							$("#selectingStationId").append("<option value='" + result.data[i].id + "'>" + result.data[i].name + "</option>");
						}
					}
				}else{
					alert(result.message);
				}
			});
		}		
		//初始化界面  完成后调用buildData方法
		MTA.Report.initialize(null, 'buildData');
		timeVal=$("#timeId").val();
	});
	
	function buildData() {
		var dateStr=getNowFormatDate();
		var date=getDate(dateStr+"-20");
		var dateVal =getDate($("#timeId").val()+"-20");//用户选择的日期
		if(dateVal>date){
			$("#timeId").val(dateStr);
			return;
		}
		
		stationId=$("#selectingStationId :checked").val();
		if($("#timeId").val()!=''){
			coaMonth=parseInt(dateVal.getMonth())+1;
		}else{
			var date = new Date();
			coaMonth=parseInt(date.getMonth()) + 1;//月份
			var formatDate=getNowFormatDate();
			$("#timeId").val(formatDate);
		}
		timeVal=$("#timeId").val();
		
		MTA.Util.setParams('insId', insId);
		if(stationId && stationId != ''){
			MTA.Util.setParams('stationId', stationId);
		}else{
			MTA.Util.setParams('stationId', null);
		}
		if(coaMonth && coaMonth != ''){
			MTA.Util.setParams('coaMonth', coaMonth);
		}else{
			MTA.Util.setParams('coaMonth', parseInt(date.getMonth()) + 1);
			var date=getNowFormatDate();
			$("#timeId").val(date);
		}
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
			'coaName' : {
				'thText' : '教练名称',
				'number' : false,
				'needOrder' : false,
				'precision' : 0,
			},
			'coaCarPlate' : {
				'thText' : '教练车车牌',
				'number' : false,
				'needOrder' : false,
				'precision' : 0,
			},
			'subjTwoCount' : {
				'thText' : '科二带考学员数',
				'number' : true,
				'needOrder' : false,
				'precision' : 0,
			},
			'twoPercentStr' : {
				'thText' : '科二考试合格率',
				'number' : false,
				'needOrder' : false,
				'precision' : 0,
			},
			'subjThreeCount' : {
				'thText' : '科三带考学员数',
				'number' : true,
				'needOrder' : false,
				'precision' : 0,
			},
			'threePercentStr' : {
				'thText' : '科三考试合格率',
				'number' : false,
				'needOrder' : false,
				'precision' : 0,
			},
			'passPercentStr' : {
				'thText' : '综合合格率',
				'number' : false,
				'needOrder' : false,
				'precision' : 0,
			},
			'teachingCount' : {
				'thText' : '教学时长',
				'number' : true,
				'needOrder' : false,
				'precision' : 0,
			},
			'stuCount' : {
				'thText' : '招生数量',
				'number' : true,
				'needOrder' : false,
				'precision' : 0,
			}
		};
		
		//ajax的数据请求参数
		config['page'] = {
			'url' : '${ctx}/coach/coachSituation',
			'size' : 10,
			'ifRealPage' : 1
		};
		//初始化 并通过ajax加载数据
		dataTable = MTA.Data.loadAjaxPageTable(config);
	}
	function change(){
		var dateVal =getDate($("#timeId").val()+"-20");
		coaMonth=parseInt(dateVal.getMonth())+1;
		var readyDateVal=getDate(timeVal==null?"":timeVal+"-20");
		readyMonth=parseInt(readyDateVal.getMonth())+1;
		if(readyMonth==coaMonth){
			return;
		}
		buildData();
	}
	
	function checkBuildData(){
		if(timeVal==$("#timeId").val()){
			return ;
		}
		buildData();
	}
	
	$(function(){
		$('.form_date').datetimepicker({
	        language:  'zh-CN',
	        weekStart: 1,
	        todayBtn:  1,
			autoclose: 1,
			format:'yyyy-mm',
			todayHighlight: 0,
			startView: 4,
			minView: 3,
			forceParse: 0
	   });
	})
	//格式化日期
	function getNowFormatDate() {
	    var date = new Date();
	    var seperator1 = "-";
	    var year = date.getFullYear();
	    var month = date.getMonth() + 1;
	    if (month >= 1 && month <= 9) {
	       month = "0" + month;
	    }
	    var currentdate = year + seperator1 + month;
	    return currentdate;
	 }
	//把字符转换为日期	
	function getDate(strDate) {
        var date = eval('new Date(' + strDate.replace(/\d+(?=-[^-]+$)/,
         function (a) { return parseInt(a, 10) - 1; }).match(/\d+/g) + ')');
        return date;
    }
</script>
</body>
</html>