<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
<meta name="theme" content="school" />
<script type="text/javascript" src="${ctx}/resources/js/serviceStation/<sec:authentication property="principal.insId"/>"></script>
<link type="text/css" href="${ctx}/resources/css/daterangepicker.min.css" rel="stylesheet" />
<script src='${ctx}/resources/js/moment.min.js'></script>
<script src="${ctx}/resources/js/jquery.daterangepicker.min.js"></script>

<title>阳光驾培-学员转网点管理</title>
</head>
<body>
	<div class="container-fluid">
		<div id="pad-wrapper">
			<div class="table-wrapper products-table">
				<div class="row-fluid head">
					<div class="span12">
						<h4>学员转网点管理</h4>
					</div>
				</div>
				<!-- 搜索 -->
				<div class="row-fluid filter-block">
					<div class="pull-right">
						<span id="two-inputs">
		                	<input id="time1" size="20" value="" readonly="readonly"> 到 <input id="time2" size="20" value=""readonly="readonly">
		                </span>
						
						<select id="status" name="status">
							<option value="-1">全部</option>
							<option value="0">待确认</option>
							<option value="1">已确认</option>
							<option value="2">转出</option>
							<option value="3">转入</option>
						</select>
						<a class="btn-flat small" style="margin-right: 50px;"
							onClick="searchQuery();return false;">查询</a> 
							<a class="btn-flat success new-product" onclick="showEditorModel();">+ 转出学员</a>
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
					<h4 class="modal-title" id="myModalLabel">学员转店申请</h4>
				</div>
				<div class="modal-body">
					<div class="" align="center">
						<form id="ediorForm">
							<input type="hidden" name="id" value="">
							<table>
								<tr height="40">
									<td width="80"><label>学员名称:</label></td> 
									<td><input class="" type="text" name="name">
										<input class="" type="hidden" name="studentId">
									</td>
								</tr>
								<tr height="40">
									<td><label>电话号码:</label> </td> 
									<td><input class="" type="text" onblur="getStudentByMobile()" name="mobile"></td>
								</tr>
								<tr height="40">
									<td><label>当前门店:</label> </td> 
									<td><input class="" type="text"  name="fromStation">
										<input type="hidden"  name="stationId">
									</td>
								</tr>
								<tr height="40">
									<td><label>接收门店:</label></td> 
									<td> 
										<select id="toStation" name="toStation">
											
										</select>
									</td> 
								</tr>
							</table>
						</form>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onClick="save();">发送申请</button>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
	var id= '<sec:authentication property="principal.id"/>';
	var insId= '<sec:authentication property="principal.insId"/>';
	var statId= '<sec:authentication property="principal.stationId"/>';
		//标识当前页面的url 用来设置当前菜单标识
		var dataTable = null;
		//初始化 
		$(document).ready(function() {
			//初始化界面  完成后调用buildData方法
			MTA.Report.initialize(null, 'buildData');
		});

		function buildData() {
			$("#time1").val(''); 
			$("#time2").val(''); 
			buildDataTable();
		}
		/**
		*	搜索
		*/
		function searchQuery() {
			var status = $("#status").val();
			var endTime = $("#time2").val();
			var startTime = $("#time1").val();
			MTA.Util.setParams('status', status);
			MTA.Util.setParams('stationId',statId);
			if(startTime.trim()!="" && endTime.trim()!=""){
				MTA.Util.setParams('startTime',startTime);
				MTA.Util.setParams('endTime',endTime);
			}
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
				'studentName' : {
					'thText' : '学员名称',
					'number' : false,
					'colAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
				},
				'fromStationName' : {
					'thText' : '当前网点',
					'number' : false,
					'colAlign' : 'left',
					'thAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
				},
				'classTypeName' : {
					'thText' : '班型',
					'number' : false,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
				},
				'toStationName' : {
					'thText' : '接收网点',
					'number' : false,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
				},
				'functionary' : {
					'thText' : '申请人',
					'number' : false,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
				},
				'createTime' : {
					'thText' : '申请时间',
					'number' : false,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
				},
				'status' : {
					'thText' : '申请状态',
					'number' : false,
					'colAlign' : 'left',
					'thAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						if(value == 0){
							td.push("待确认");
						}
						if(value == 1){
							td.push("已接收");
						}
						if(value == 2){
							td.push("拒绝接收");
						}
						return td.join('');
					}
				},
				'id' : {
					'thText' : '  ',
					'number' : false,
					'colAlign' : 'right',
					'thAlign' : 'right',
					'needOrder' : false,
					'precision' : 0,
					'width' : '150px',
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						if(record.status == 0 && statId != record.fromStation){
							td.push('<ul class="actions">');
							td.push('<li>');
							td.push('<a  title="接收学员" onClick="receive('+ record.studentId + ',' + record.id + ',\''
									+ record.studentName +'\')">');
							td.push('接收');
							td.push('</a>');
							td.push('</li>');
							td.push('<li>');
							td.push('<a title="拒绝接收学员"  onClick="refuse(' + record.id + ',\''
									+ record.studentName +'\')">');
							td.push('拒绝');
							td.push('</a>');
							td.push('</li>');
							td.push('</ul>');
						}
						return td.join('');
					}
				}
			};
			var url = '${ctx}/studentChangeStation/list?insId='+insId;
			if(statId === 'null'){
				url = '${ctx}/studentChangeStation/list?insId='+insId;
			}else{
				url = '${ctx}/studentChangeStation/list?insId='+insId+'&stationId='+statId;
			}
			//ajax的数据请求参数
			config['page'] = {
				'url' : url,
				'size' : 1000,
				'ifRealPage' : 0
			};
			//初始化 并通过ajax加载数据
			dataTable = MTA.Data.loadAjaxPageTable(config);
		}
		/**
		*	接收学员
		*/
		function receive(studentId,ids,studentName)  {
			//弹出提示框 让用户确认停用
			var dialog = new GRI.Dialog({
				type : 4,
				title : '接收学员',
				content : '确定接收【'+studentName+'】学员吗？',
				deGRIil : '',
				btnType : 1,
				extra : {
					top : 250
				},
				winSize : 1
			}, function() {
				//用户点了停用的确认信息
				$.ajax({
					type : "post",
					url : "${ctx}/studentChangeStation/manage/" + ids + "/1/"+studentId,
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
		
		/**
		*	接收学员
		*/
		function refuse(ids,studentName)  {
			//弹出提示框 让用户确认
			var dialog = new GRI.Dialog({
				type : 4,
				title : '拒绝接收学员',
				content : '确定拒绝接收【'+studentName+'】学员吗？',
				deGRIil : '',
				btnType : 1,
				extra : {
					top : 250
				},
				winSize : 1
			}, function() {
				//用户点了停用的确认信息
				$.ajax({
					type : "post",
					url : "${ctx}/studentChangeStation/manage/" + ids + "/2",
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
		/**
		*	展示编辑表单界面
		*	新增、修改都需要调用该方法打开表单
		*/
		function showEditorModel() {
			//练车场地选择
			$('#ediorForm select[name="toStation"]').append("<option value=''>请选择</option>");
			$(serviceStations).each(function(item){
				$('#ediorForm select[name="toStation"]').append("<option value='" + this.id + "'>" + this.name + "</option>");
			});
			
			//重置表单
			$('#ediorForm input[name="name"]').val('');
			$('#ediorForm input[name="mobile"]').val('');
			$('#ediorForm input[name="fromStation"]').val('');
			
			$('#editorModal').modal('show');
		}
		
		/**
		*	学生姓名和电话号码查询
		**/
		function getStudentByMobile(){
			var name = $('#ediorForm input[name="name"]').val();
			var mobile = $('#ediorForm input[name="mobile"]').val();
			var params = {
					name:name,
					mobile:mobile,
					insId:insId
			}
			$.post('${ctx}/student/getStudentByMobile', params, function (result) {
				if(result.code==200){
					$('#ediorForm input[name="name"]').val(result.data.name);
					$('#ediorForm input[name="studentId"]').val(result.data.id);
					$('#ediorForm input[name="mobile"]').val(result.data.mobile);
					$('#ediorForm input[name="stationId"]').val(result.data.stationId);
					$('#ediorForm input[name="fromStation"]').val(result.data.stationName);
				}else{
					new GRI.Dialog({
						type : 4,
						title : '查询学员信息',
						content : result.message,
						deGRIil : '',
						btnType : 3,
						extra : {
							top : 250
						},
						winSize : 1
					});
				}
			});	
		}
		
		//保存
		function save() {
			//从form中取参数值
			var studentId = $('#ediorForm input[name="studentId"]').val();
			var fromStation = $('#ediorForm input[name="stationId"]').val();
			var toStation = $('#ediorForm select[name="toStation"]').val();
			
			//定义提交到服务端的数据对象
			var params = {
				'createUserId' : id,
				'studentId' : studentId,
				'fromStation' : fromStation,
				'toStation' : toStation
			};
			//发送数据到后端保存
			$.post('${ctx}/studentChangeStation', params, function (result) {
				 if (result.code==200) {
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