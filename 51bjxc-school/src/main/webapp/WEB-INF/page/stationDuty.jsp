<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-网点排班</title>
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
		<sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
			<a class="select-btn" onclick="exportFile();"><span class="Export"></span>导出</a>
		</sec:authorize>
		
		<sec:authorize access="hasRole('ROLE_SCHOOL_SERVICE')">
			<sec:authorize access="hasRole('ROLE_UserOperation_162')">
				<a class="select-btn" onclick="exportFile();"><span class="Export"></span>导出</a>
			</sec:authorize>
		</sec:authorize>
		</div>
	</div>
	<div class="TermSearch">
		<form>
			<sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
				<select id="areaId">
				</select>
				<select id="stationId">
				</select>
			</sec:authorize>
			<input class="input1 win200" type="text" id="searchText"
				value="${coachName}" placeholder="教练名称 ">
			<input type="hidden" value="${coachId}" id="coachId">
			<input id="startTime" class="input1 win200 inputDate"  type="text" placeholder="查询开始日期" data-date-format="yyyy-mm-dd"/>
			<input id="endTime" class="input1  win200 inputDate"  type="text" placeholder="查询结束日期" data-date-format="yyyy-mm-dd"/>
			<button class="btn-flat primary" onClick="searchQuery();return false;">搜索</button>
			
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
    	var current_action = "${ctx}/view/student";
	
		//标识当前页面的url 用来设置当前菜单标识
		var dataTable = null;
		var insId= <sec:authentication property="principal.insId"/>;
		var stationId= <sec:authentication property="principal.stationId"/>;
		var subjectid = $("#subjectid").val();
		MTA.Util.setParams('subjectid', subjectid); 
		if(stationId == null){
			stationId=0;
		}
		//初始化 
		$(document).ready(function() {
			initSelected();
			//初始化界面  完成后调用buildData方法
			MTA.Report.initialize(null, 'buildData');
			//ajax 方式上传文件操作
		});
		
		/*初始化网点，片区下拉框*/
		function initSelected(){
			$('#stationId').append("<option value='0'>全部网点</option>");
			$(serviceStations).each(function(item){
				$('#stationId').append("<option value='" + this.id + "'>" + this.name + "</option>");
			});
			
			$('#areaId').append("<option value='0'>全部片区</option>");
			$(areas).each(function(item){
				$('#areaId').append("<option value='" + this.id + "'>" + this.name + "</option>");
			});
			$('#areaId').change(function(){
				var thisValue = $(this).val();
				$('#stationId').empty();
				$('#stationId').append("<option value='0'>全部网点</option>");
				$(serviceStations).each(function(){
					if(Number($('#areaId').val()) === 0 || Number($('#areaId').val()) === this.areaId){
						$('#stationId').append("<option value='" + this.id + "'>" + this.name + "</option>");
					}
				});
			});
		}
		
		function buildData() {
			MTA.Util.setParams('insId', insId);
			var coachId=$("#coachId").val();
			if(stationId && stationId != ''){
				MTA.Util.setParams('stationId', stationId);
			}
			if(coachId && coachId != ''){
				MTA.Util.setParams('coachId', coachId);
			}
			buildDataTable();
		}
		/**
		 *	搜索
		 */
		function searchQuery() {
			
			var time1 = $("#time1").val();
			var time2 = $("#time2").val();
			var search = $("#searchText").val();
			var subjectid = $("#subjectid").val();
			MTA.Util.setParams('subjectid', subjectid); 
			MTA.Util.setParams('searchText', search); 
			MTA.Util.setParams('time1', time1);
			MTA.Util.setParams('time2', time2); 
			
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
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						var day = new Date(record.day).pattern('yyyy-MM-dd');
						td.push(day);
						return td.join('');
					}
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
						td.push('<a>');
						td.push(record.f6s);
						td.push('</li>');
						if(record.f6m!=null){
							td.push('<li>');
							td.push('电话:  ');
							td.push(record.f6m);
							td.push('</a>');
							td.push('</li>');
						}
						//操作人 
						if(!!record.f6o){
							td.push('<li>');
							td.push('<a>');
							td.push('操作人:  ');
							td.push(record.f6o);
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
						td.push('<a>');
						td.push(record.f7s);
						td.push('</li>');
						if(record.f7m!=null){
							td.push('<li>');
							td.push('电话:  ');
							td.push(record.f7m);
							td.push('</a>');
							td.push('</li>');
						}
						//操作人 
						if(!!record.f7o){
							td.push('<li>');
							td.push('<a>');
							td.push('操作人:  ');
							td.push(record.f7o);
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
						td.push('<a>');
						td.push(record.f8s);
						td.push('</li>');
						if(record.f8m!=null){
							td.push('<li>');
							td.push('电话:  ');
							td.push(record.f8m);
							td.push('</a>');
							td.push('</li>');
						}
						//操作人 
						if(!!record.f8o){
							td.push('<li>');
							td.push('<a>');
							td.push('操作人:  ');
							td.push(record.f8o);
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
						td.push('<a>');
						td.push(record.f9s);
						td.push('</li>');
						if(record.f9m!=null){
							td.push('<li>');
							td.push('电话:  ');
							td.push(record.f9m);
							td.push('</a>');
							td.push('</li>');
						}
						//操作人 
						if(!!record.f9o){
							td.push('<li>');
							td.push('<a>');
							td.push('操作人:  ');
							td.push(record.f9o);
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
						td.push('<a>');
						td.push(record.f10s);
						td.push('</li>');
						if(record.f10m!=null){
							td.push('<li>');
							td.push('电话:  ');
							td.push(record.f10m);
							td.push('</a>');
							td.push('</li>');
						}
						//操作人 
						if(!!record.f10o){
							td.push('<li>');
							td.push('<a>');
							td.push('操作人:  ');
							td.push(record.f10o);
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
						td.push('<a>');
						td.push(record.f11s);
						td.push('</li>');
						if(record.f11m!=null){
							td.push('<li>');
							td.push('电话:  ');
							td.push(record.f11m);
							td.push('</a>');
							td.push('</li>');
						}
						//操作人 
						if(!!record.f11o){
							td.push('<li>');
							td.push('<a>');
							td.push('操作人:  ');
							td.push(record.f11o);
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
						td.push('<a>');
						td.push(record.f12s);
						td.push('</li>');
						if(record.f12m!=null){
							td.push('<li>');
							td.push('电话:  ');
							td.push(record.f12m);
							td.push('</a>');
							td.push('</li>');
						}
						//操作人 
						if(!!record.f12o){
							td.push('<li>');
							td.push('<a>');
							td.push('操作人:  ');
							td.push(record.f12o);
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
						td.push('<a>');
						td.push(record.f13s);
						td.push('</li>');
						if(record.f13m!=null){
							td.push('<li>');
							td.push('电话:  ');
							td.push(record.f13m);
							td.push('</a>');
							td.push('</li>');
						}
						//操作人 
						if(!!record.f13o){
							td.push('<li>');
							td.push('<a>');
							td.push('操作人:  ');
							td.push(record.f13o);
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
						td.push('<a>');
						td.push(record.f14s);
						td.push('</li>');
						if(record.f14m!=null){
							td.push('<li>');
							td.push('电话:  ');
							td.push(record.f14m);
							td.push('</a>');
							td.push('</li>');
						}
						//操作人 
						if(!!record.f14o){
							td.push('<li>');
							td.push('<a>');
							td.push('操作人:  ');
							td.push(record.f14o);
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
						td.push('<a>');
						td.push(record.f15s);
						td.push('</li>');
						if(record.f15m!=null){
							td.push('<li>');
							td.push('电话:  ');
							td.push(record.f15m);
							td.push('</a>');
							td.push('</li>');
						}
						//操作人 
						if(!!record.f15o){
							td.push('<li>');
							td.push('<a>');
							td.push('操作人:  ');
							td.push(record.f15o);
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
						td.push('<a>');
						td.push(record.f16s);
						td.push('</li>');
						if(record.f16m!=null){
							td.push('<li>');
							td.push('电话:  ');
							td.push(record.f16m);
							td.push('</a>');
							td.push('</li>');
						}
						//操作人 
						if(!!record.f16o){
							td.push('<li>');
							td.push('<a>');
							td.push('操作人:  ');
							td.push(record.f16o);
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
						td.push('<a>');
						td.push(record.f17s);
						td.push('</li>');
						if(record.f17m!=null){
							td.push('<li>');
							td.push('电话:  ');
							td.push(record.f17m);
							td.push('</a>');
							td.push('</li>');
						}
						//操作人 
						if(!!record.f17o){
							td.push('<li>');
							td.push('<a>');
							td.push('操作人:  ');
							td.push(record.f17o);
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
						td.push('<a>');
						td.push(record.f18s);
						td.push('</li>');
						if(record.f18m!=null){
							td.push('<li>');
							td.push('电话:  ');
							td.push(record.f18m);
							td.push('</a>');
							td.push('</li>');
						}
						//操作人 
						if(!!record.f18o){
							td.push('<li>');
							td.push('<a>');
							td.push('操作人:  ');
							td.push(record.f18o);
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
						td.push('<a>');
						td.push(record.f19s);
						td.push('</li>');
						if(record.f19m!=null){
							td.push('<li>');
							td.push('电话:  ');
							td.push(record.f19m);
							td.push('</a>');
							td.push('</li>');
						}
						//操作人 
						if(!!record.f19o){
							td.push('<li>');
							td.push('<a>');
							td.push('操作人:  ');
							td.push(record.f19o);
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
						td.push('<a>');
						td.push(record.f20s);
						td.push('</li>');
						if(record.f20m!=null){
							td.push('<li>');
							td.push('电话:  ');
							td.push(record.f20m);
							td.push('</a>');
							td.push('</li>');
						}
						//操作人 
						if(!!record.f20o){
							td.push('<li>');
							td.push('<a>');
							td.push('操作人:  ');
							td.push(record.f20o);
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
						td.push('<a>');
						td.push(record.f21s);
						td.push('</li>');
						if(record.f21m!=null){
							td.push('<li>');
							td.push('电话:  ');
							td.push(record.f21m);
							td.push('</a>');
							td.push('</li>');
						}
						//操作人 
						if(!!record.f21o){
							td.push('<li>');
							td.push('<a>');
							td.push('操作人:  ');
							td.push(record.f21o);
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
				'url' : ('${ctx}/coach/getStationDuty?' 
						+ "areaId=" + $("#areaId").val()
						+ "&stationId=" + $("#stationId").val()
						+ ($("#startTime").val()== '' ? '' : ("&startTime=" + new Date(Date.parse($("#startTime").val())).getTime()))
						+ ($("#endTime").val() == '' ? '' : ("&endTime=" + new Date(Date.parse($("#endTime").val())).getTime())) 
						) ,
				'size' : 10,
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
		  	if($("#startTime").val() != '' && $("#endTime").val() != ''){
		  		var startTime = new Date(Date.parse($("#startTime").val())).getTime();
		  		var endTime = new Date(Date.parse($("#endTime").val())).getTime();
		  		if(startTime > endTime){
		  			$("#endTime").val("");
		  		}
		  	} 
	   	});

		//导出排班记录
		function exportFile(){
			var startLongTime = $("#startTime").val() == "" ? 0 : new Date(Date.parse($("#startTime").val())).getTime();
			var endLongTime = $("#endTime").val() == "" ? 0 : new Date(Date.parse($("#endTime").val())).getTime();
			window.location.href="${ctx}/coach/exportCoachStationDuty?stationId="
					+ stationId
					+ "&coachId=0&startTime="
					+ startLongTime
					+ "&searchText=" + $("#searchText").val()
					+ "&endTime=" + endLongTime;
		}
		
		
	</script>
</body>
</html>