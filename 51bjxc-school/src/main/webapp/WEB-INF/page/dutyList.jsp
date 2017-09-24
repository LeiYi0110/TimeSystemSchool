<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-预约管理</title>
<link type="text/css" href="${ctx}/resources/css/daterangepicker.min.css" rel="stylesheet" />
<script src='${ctx}/resources/js/moment.min.js'></script>
<script src="${ctx}/resources/js/jquery.daterangepicker.min.js"></script>
</head>
<body>
	<div class="container-fluid">
		<div id="pad-wrapper">
			<div class="table-wrapper products-table">
				<div class="row-fluid head">
					<div class="span12">
						<h4>预约管理</h4>
					</div>
				</div>
				<!-- 搜索 -->
				<div class="row-fluid filter-block">
					<div class="pull-right">
					<span id="two-inputs">
                <input id="time1" size="20" value="" readonly="readonly"> 到 <input id="time2" size="20" value=""readonly="readonly">
                </span>
						<input type="text" class="search" placeholder="search" id="search" />
						<a class="btn-flat small" style="margin-right: 50px;"
							onClick="searchQuery();return false;">查询</a>
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
	
	
	<!-- Modal 弹出的编辑界面-->
	<div class="modal fade" id="editorModal" tabindex="-1" role="dialog"
		aria-labelledby="editorModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span>
					</button>
					<!-- <h4 class="modal-title" id="myModalLabel">帐号管理</h4> -->
				</div>
				<div class="modal-body">
					<div class="span5">
						<form id="ediorForm">
							<input type="hidden" id="coachId" value="">
							<input type="hidden" id="time" value="">
							<input type="hidden" id="day" value="">
							<input type="hidden" id="subjectId" value="">
							<div class="field-box">
								<label>时段开关:</label> 
								<label><input type="radio" id="status" name="status" value="3">开</label>
								<label><input type="radio" id="status" name="status" value="0">关</label>
							</div>
							<div class="field-box">
								<label>指定学员:</label> 
								<ul>
									<li><input type="text" id="tt" autocomplete="off" value="" class="text" /></li>
									<li><input type="text" id="stuId" value="" class="hidden" /></li>
								</ul>
							</div>
						</form>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onClick="save();">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		var name = '${param.name}';
		//标识当前页面的url 用来设置当前菜单标识
		var dataTable = null;
		var insId = '<sec:authentication property="principal.insId"/>';
		var insName = '<sec:authentication property="principal.insName"/>';
		var statId = '<sec:authentication property="principal.stationId"/>';
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
			var time1=$("#time1").val();
			var time2=$("#time2").val();
			if(time1.trim()!=""&&time2.trim()!=""){
				MTA.Util.setParams('date1', time1);
				MTA.Util.setParams('date2', time2);
			}
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
				'day' : {
					'thText' : '日期',
					'number' : false,
					'colAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
				},
				'name' : {
					'thText' : '教练',
					'number' : false,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
				},
				'f6s' : {
					'thText' : '6:00-7:00',
					'number' : true,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<ul class="info">');
						td.push('<li>');
						td.push('<a onClick="showEditorModel(' + record.f6 + ',\''+record.f6s +'\','
							+ record.coachId + ','+record.subject+',\''+record.day+'\','+record.f6i+',6)">');
						td.push(record.f6s);
						td.push('</li>');
						if(record.f6m!=null){
							td.push('<li>');
							td.push('电话:  ');
							td.push(record.f6m);
							td.push('</a>');
							td.push('</li>');
						}
						td.push('</ul>');
						return td.join('');
					}
				},
				'f7s' : {
					'thText' : '7:00-8:00',
					'number' : true,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<ul class="info">');
						td.push('<li>');
						td.push('<a onClick="showEditorModel(' + record.f7 + ',\''+record.f7s +'\','
							+ record.coachId + ','+record.subject+',\''+record.day+'\','+record.f7i+',7)">');
						td.push(record.f7s);
						td.push('</li>');
						if(record.f7m!=null){
							td.push('<li>');
							td.push('电话:  ');
							td.push(record.f7m);
							td.push('</a>');
							td.push('</li>');
						}
						td.push('</ul>');
						return td.join('');
					}
				},
				'f8s' : {
					'thText' : '8:00-9:00',
					'number' : true,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<ul class="info">');
						td.push('<li>');
						td.push('<a onClick="showEditorModel(' + record.f8 + ',\''+record.f8s +'\','
							+ record.coachId + ','+record.subject+',\''+record.day+'\','+record.f8i+',8)">');
						td.push(record.f8s);
						td.push('</li>');
						if(record.f8m!=null){
							td.push('<li>');
							td.push('电话:  ');
							td.push(record.f8m);
							td.push('</a>');
							td.push('</li>');
						}
						td.push('</ul>');
						return td.join('');
					}
				},
				'f9s' : {
					'thText' : '9:00-10:00',
					'number' : true,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<ul class="info">');
						td.push('<li>');
						td.push('<a onClick="showEditorModel(' + record.f9 + ',\''+record.f9s +'\','
							+ record.coachId + ','+record.subject+',\''+record.day+'\','+record.f9i+',9)">');
						td.push(record.f9s);
						td.push('</li>');
						if(record.f9m!=null){
							td.push('<li>');
							td.push('电话:  ');
							td.push(record.f9m);
							td.push('</a>');
							td.push('</li>');
						}
						td.push('</ul>');
						return td.join('');
					}
				},
				'f10s' : {
					'thText' : '10:00-11:00',
					'number' : true,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<ul class="info">');
						td.push('<li>');
						td.push('<a onClick="showEditorModel(' + record.f10 + ',\''+record.f10s +'\','
							+ record.coachId + ','+record.subject+',\''+record.day+'\','+record.f10i+',10)">');
						td.push(record.f10s);
						td.push('</li>');
						if(record.f10m!=null){
							td.push('<li>');
							td.push('电话:  ');
							td.push(record.f10m);
							td.push('</a>');
							td.push('</li>');
						}
						td.push('</ul>');
						return td.join('');
					}
				},
				'f11s' : {
					'thText' : '11:00-12:00',
					'number' : true,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<ul class="info">');
						td.push('<li>');
						td.push('<a onClick="showEditorModel(' + record.f11 + ',\''+record.f11s +'\','
							+ record.coachId + ','+record.subject+',\''+record.day+'\','+record.f11i+',11)">');
						td.push(record.f11s);
						td.push('</li>');
						if(record.f11m!=null){
							td.push('<li>');
							td.push('电话:  ');
							td.push(record.f11m);
							td.push('</a>');
							td.push('</li>');
						}
						td.push('</ul>');
						return td.join('');
					}
				},
				'f12s' : {
					'thText' : '12:00-13:00',
					'number' : true,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<ul class="info">');
						td.push('<li>');
						td.push('<a onClick="showEditorModel(' + record.f12 + ',\''+record.f12s +'\','
							+ record.coachId + ','+record.subject+',\''+record.day+'\','+record.f12i+',12)">');
						td.push(record.f12s);
						td.push('</li>');
						if(record.f12m!=null){
							td.push('<li>');
							td.push('电话:  ');
							td.push(record.f12m);
							td.push('</a>');
							td.push('</li>');
						}
						td.push('</ul>');
						return td.join('');
					}
				},
				'f13s' : {
					'thText' : '13:00-14:00',
					'number' : true,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<ul class="info">');
						td.push('<li>');
						td.push('<a onClick="showEditorModel(' + record.f13 + ',\''+record.f13s +'\','
							+ record.coachId + ','+record.subject+',\''+record.day+'\','+record.f13i+',13)">');
						td.push(record.f13s);
						td.push('</li>');
						if(record.f13m!=null){
							td.push('<li>');
							td.push('电话:  ');
							td.push(record.f13m);
							td.push('</a>');
							td.push('</li>');
						}
						td.push('</ul>');
						return td.join('');
					}
				},
				'f14s' : {
					'thText' : '14:00-15:00',
					'number' : true,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<ul class="info">');
						td.push('<li>');
						td.push('<a onClick="showEditorModel(' + record.f14 + ',\''+record.f14s +'\','
							+ record.coachId + ','+record.subject+',\''+record.day+'\','+record.f14i+',14)">');
						td.push(record.f14s);
						td.push('</li>');
						if(record.f14m!=null){
							td.push('<li>');
							td.push('电话:  ');
							td.push(record.f14m);
							td.push('</a>');
							td.push('</li>');
						}
						td.push('</ul>');
						return td.join('');
					}
				},
				'f15s' : {
					'thText' : '15:00-16:00',
					'number' : true,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<ul class="info">');
						td.push('<li>');
						td.push('<a onClick="showEditorModel(' + record.f15 + ',\''+record.f15s +'\','
							+ record.coachId + ','+record.subject+',\''+record.day+'\','+record.f15i+',15)">');
						td.push(record.f15s);
						td.push('</li>');
						if(record.f15m!=null){
							td.push('<li>');
							td.push('电话:  ');
							td.push(record.f15m);
							td.push('</a>');
							td.push('</li>');
						}
						td.push('</ul>');
						return td.join('');
					}
				},
				'f16s' : {
					'thText' : '16:00-17:00',
					'number' : true,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<ul class="info">');
						td.push('<li>');
						td.push('<a onClick="showEditorModel(' + record.f16 + ',\''+record.f16s +'\','
							+ record.coachId + ','+record.subject+',\''+record.day+'\','+record.f16i+',16)">');
						td.push(record.f16s);
						td.push('</li>');
						if(record.f16m!=null){
							td.push('<li>');
							td.push('电话:  ');
							td.push(record.f16m);
							td.push('</a>');
							td.push('</li>');
						}
						td.push('</ul>');
						return td.join('');
					}
				},
				'f17s' : {
					'thText' : '17:00-18:00',
					'number' : true,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<ul class="info">');
						td.push('<li>');
						td.push('<a onClick="showEditorModel(' + record.f17 + ',\''+record.f17s +'\','
							+ record.coachId + ','+record.subject+',\''+record.day+'\','+record.f17i+',17)">');
						td.push(record.f17s);
						td.push('</li>');
						if(record.f17m!=null){
							td.push('<li>');
							td.push('电话:  ');
							td.push(record.f17m);
							td.push('</a>');
							td.push('</li>');
						}
						td.push('</ul>');
						return td.join('');
					}
				},
				'f18s' : {
					'thText' : '18:00-19:00',
					'number' : true,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<ul class="info">');
						td.push('<li>');
						td.push('<a onClick="showEditorModel(' + record.f18 + ',\''+record.f18s +'\','
							+ record.coachId + ','+record.subject+',\''+record.day+'\','+record.f18i+',18)">');
						td.push(record.f18s);
						td.push('</li>');
						if(record.f18m!=null){
							td.push('<li>');
							td.push('电话:  ');
							td.push(record.f18m);
							td.push('</a>');
							td.push('</li>');
						}
						td.push('</ul>');
						return td.join('');
					}
				},
				'f19s' : {
					'thText' : '19:00-20:00',
					'number' : true,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<ul class="info">');
						td.push('<li>');
						td.push('<a onClick="showEditorModel(' + record.f19 + ',\''+record.f19s +'\','
							+ record.coachId + ','+record.subject+',\''+record.day+'\','+record.f19i+',19)">');
						td.push(record.f19s);
						td.push('</li>');
						if(record.f19m!=null){
							td.push('<li>');
							td.push('电话:  ');
							td.push(record.f19m);
							td.push('</a>');
							td.push('</li>');
						}
						td.push('</ul>');
						return td.join('');
					}
				},
				'f20s' : {
					'thText' : '20:00-21:00',
					'number' : true,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<ul class="info">');
						td.push('<li>');
						td.push('<a onClick="showEditorModel(' + record.f20 + ',\''+record.f20s +'\','
							+ record.coachId + ','+record.subject+',\''+record.day+'\','+record.f20i+',20)">');
						td.push(record.f20s);
						td.push('</li>');
						if(record.f20m!=null){
							td.push('<li>');
							td.push('电话:  ');
							td.push(record.f20m);
							td.push('</a>');
							td.push('</li>');
						}
						td.push('</ul>');
						return td.join('');
					}
				},
				'f21s' : {
					'thText' : '21:00-22:00',
					'number' : true,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<ul class="info">');
						td.push('<li>');
						td.push('<a onClick="showEditorModel(' + record.f21 + ',\''+record.f21s +'\','
							+ record.coachId + ','+record.subject+',\''+record.day+'\','+record.f21i+',21)">');
						td.push(record.f21s);
						td.push('</li>');
						if(record.f21m!=null){
							td.push('<li>');
							td.push('电话:  ');
							td.push(record.f21m);
							td.push('</a>');
							td.push('</li>');
						}
						td.push('</ul>');
						return td.join('');
					}
				},
			};
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/coach/getDutyList?insId='+insId+'&stationId='+statId+'&searchText='+name,
				'size' : 10,
				'ifRealPage' : 1
			};
			//初始化 并通过ajax加载数据
			dataTable = MTA.Data.loadAjaxPageTable(config);
		}
	
		/**
		 *	通过coachId找到stationId
		 */
		function showEditorModel(status,name,coachId,subjectId,day,stuId,time) {
			//重置表单
			$('#stuId').val(stuId);
			$("#day").val(day);
			$("#time").val(time);
			$("#coachId").val(coachId);
			$("#subjectId").val(subjectId);
			$('input[name="status"][value="0"]').removeAttr("checked"); 
			$('input[name="status"][value="3"]').removeAttr("checked");
			$("#tt").val('');
			$("#tt").removeAttr("readonly"); 
			if(status==-1||status==0){
				$('input[name="status"][value="0"]').attr("checked",true); 
				$('#tt').attr("readonly","readonly")
			}else{
				$('input[name="status"][value="3"]').attr("checked",true);
				if(name.trim()!='空闲'){
					$("#tt").val(name);
				}
			}
			$('#editorModal').modal('show');
		}
		
		$("input[name=status]").click(function() {
   			var status=$('input:radio[name="status"]:checked').val();
   			if(status==0){
   				$("#tt").val('');
   				$('#tt').attr("readonly","readonly")
   			}else{
   				$("#tt").removeAttr("readonly"); 
   			}
		});
		
		$(function(){
			$("#tt").bigAutocomplete({
				url:'${ctx}/student/getCoachStu',
				callback:function(data){
					$("#stuId").val(data.result);
				}
			});
		});
		
		//保存
		function save() {
			//从form中取参数值
			var coachId = $('#coachId').val();
			var time = $('#time').val();
			var day = $('#day').val();
			var subjectId = $('#subjectId').val();
			var status = $('input[name="status"]:checked').val();
			var stuId = $('#stuId').val();
			if((stuId==null||stuId=='')&&status!=0){
				stuId=0;
				status=1;
			}
			//定义提交到服务端的数据对象
			var params = {
				'subjectId' : subjectId,
				'coachId' : coachId,
				'time' : time,
				'day' : day,
				'status' : status,
				'stuId' : stuId
			};
			//发送数据到后端保存
			$.post('${ctx}/coach/saveDuty', params, function(result) {
				if (result.code == 200) {
					//保存成功 刷新列表
					dataTable.refresh();
					//关闭编辑的表单
					$('#editorModal').modal('hide');
				}
			});
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