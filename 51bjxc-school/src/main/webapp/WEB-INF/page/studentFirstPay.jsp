<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
<meta name="theme" content="school" />
<link type="text/css" href="${ctx}/resources/css/daterangepicker.min.css" rel="stylesheet" />
<script src='${ctx}/resources/js/moment.min.js'></script>
<script src="${ctx}/resources/js/jquery.daterangepicker.min.js"></script>
<title>阳光驾培-先付后学班管理</title>
</head>
<body>
	<div class="container-fluid">
		<div id="pad-wrapper">
			<div class="table-wrapper products-table">
				<div class="row-fluid head">
					<div class="span12">
						<h4>先付后学班管理</h4>
					</div>
				</div>
				<!-- 搜索 -->
				<div class="row-fluid filter-block">
					<div class="pull-right">
						<span id="two-inputs">
		                	<input id="time1" size="20" value="" readonly="readonly"> 到 <input id="time2" size="20" value=""readonly="readonly">
		                </span>
						
						<select id="status" name="status">
							<option value="">常规订单</option>
							<option value="2">已付费订单</option>
							<option value="-1">未付费订单</option>
						</select>
						
						<input type="text" class="search" placeholder="电话号码  姓名 证件号" id="search" />
						
						<a class="btn-flat small" style="margin-right: 50px;" onClick="searchQuery();return false;">查询</a>
					</div>
				</div>
				<!-- 列表 -->
				<div class="row-fluid">
					<div class="sub_content">
						<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
						<div id="table_list" class="gri_wrapper"></div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<!-- coach panel 弹出的编辑界面-->
	<div class="modal fade" id="studentModal" tabindex="-1" role="dialog" aria-labelledby="editorModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">录入学员编号</h4>
				</div>
				<div class="modal-body">
					<div class="span5">
						<form id="studentForm">
							<input type="hidden" name="studentId" id="studentId" value="">
							学员编号：<input type="text" name="stunum" id="stunum" value="">
						</form>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onClick="changeStudent();">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
    	var current_action = "${ctx}/view/studentFistPay";
	
		//标识当前页面的url 用来设置当前菜单标识
		var dataTable = null;
		var insId= <sec:authentication property="principal.insId"/>;
		//初始化 
		$(document).ready(function() {
			//初始化界面  完成后调用buildData方法
			MTA.Report.initialize(null, 'buildData');
		});

		function buildData() {
			MTA.Util.setParams('insId', insId);
			
			buildDataTable();
		}
		/**
		 *	搜索
		 */
		function searchQuery() {
			var search = $("#search").val();
			var startTime = $("#time1").val();
			var endTime = $("#time2").val();
			var status = $("#status").val();
			MTA.Util.setParams('startTime', startTime);
			MTA.Util.setParams('endTime', endTime);
			MTA.Util.setParams('status', status);
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
				'studentName' : {
					'thText' : '学员姓名',
					'number' : false,
					'colAlign' : 'left',
					'thAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<ul class="info">');
							td.push('<li>');
								td.push(value);
							td.push('</li>');
							td.push('<li>');
							td.push('电话:  ');
								td.push(record.studentMobile);
							td.push('</li>');
						td.push('</ul>');
						return td.join('');
					}
				},
				'day' : {
					'thText' : '日期',
					'number' : false,
					'colAlign' : 'left',
					'thAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
				},
				'time' : {
					'thText' : '时段',
					'number' : false,
					'colAlign' : 'left',
					'thAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						if(value != null){
							td.push(value+":00-"+(value+1)+":00");
						}
						return td.join('');
					}
				},
				'coachName' : {
					'thText' : '教练姓名 ',
					'number' : true,
					'colAlign' : 'left',
					'thAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<ul class="info">');
							td.push('<li>');
								td.push(value);
							td.push('</li>');
							td.push('<li>');
							td.push('电话:  ');
								td.push(record.coachMobile);
							td.push('</li>');
						td.push('</ul>');
						return td.join('');
					}
				},
				'totalFee' : {
					'thText' : '费用/元',
					'number' : true,
					'colAlign' : 'left',
					'thAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
				},
				'infoStatus' : {
					'thText' : '付费情况',
					'number' : false,
					'colAlign' : 'left',
					'thAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						if(value == -1){
							td.push('申请退费');
						}else if(value == 2){
							td.push('已退费');
						}
						return td.join('');
					}
				},
				'updateTime' : {
					'thText' : '退费申请时间',
					'number' : true,
					'colAlign' : 'left',
					'thAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
				},
				'infoId' : {
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
						if(record.reserveStatus == -1){
							td.push('<a title="退费完成"  onClick="refuse(' + value + ',\''
									+ record.studentName +'\')">');
							td.push('退费完成');
							td.push('</a>');
						}
						return td.join('');
					}
				}
			};
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/studentReservePay/list?insId='+insId+'&payType=2',
				'size' : 10,
				'ifRealPage' : 1
			};
			//初始化 并通过ajax加载数据
			dataTable = MTA.Data.loadAjaxPageTable(config);
		}
		
		function refuse(infoId,studentName){
			var dialog = new GRI.Dialog({
				type : 4,
				title : '退费管理',
				content : '确定【'+studentName+'】学员退费吗？',
				deGRIil : '',
				btnType : 1,
				extra : {
					top : 250
				},
				winSize : 1
			},function() {
				$.ajax({
					type : "post",
					url : "${ctx}/studentReservePay/update/" + infoId,
					data : "{}",
					contentType : "application/json; charset=utf-8",
					dataType : "json",
					success : function(data) {
						if(data.code==200){
							buildData();
						}
					},
					error : function(msg) {
						alert(msg);
					}
				}); 
			});
		}
		
		function showChangeStudentStunum(id){
			$('#studentForm input[name="studentId"]').val(studentId);
			$('#studentForm input[name="stunum"]').val();
			
			$('#studentModal').modal('show');
		}
		
		
		
		
		
		
		
		</script>
		<script type="text/javascript">	
		//日历日期多选
	    $('#two-inputs').dateRangePicker({
	        language:'cn',
			separator : ' to ',
			getValue: function()
			{
				if ($('#time1').val() && $('#time2').val() )
					return $('#time1').val() + ' to ' + $('#time2').val();
				else
					return '';
			},
			setValue: function(s,s1,s2)
			{
				$('#time1').val(s1);
				$('#time2').val(s2);
			}
		});
	</script>
</body>
</html>