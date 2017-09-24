<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-报名管理</title>
</head>
<body>
	<div class="container-fluid">
		<div id="pad-wrapper">
			<div class="table-wrapper products-table">
				<div class="row-fluid head">
					<div class="span12">
						<h4>报名管理</h4>
					</div>
				</div>
				<!-- 搜索 -->
				<div class="row-fluid filter-block">
					<div class="pull-right">
						<select id="status">
							<option selected="selected" value="0">报名未处理</option>
							<option value="1">报名已处理</option>
							<option value="3">全部学员</option>
						</select>
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


	
	<script type="text/javascript">
		//标识当前页面的url 用来设置当前菜单标识
		var dataTable = null;
		var insId= '<sec:authentication property="principal.insId"/>';
		var insName = '<sec:authentication property="principal.insName"/>';
		var statId= '<sec:authentication property="principal.stationId"/>';
		//初始化 
		$(document).ready(function() {
			//初始化界面  完成后调用buildData方法
			MTA.Report.initialize(null, 'buildData');
		});
		/**
		*	搜索
		*/
		function searchQuery() {
			var status = $("#status").val();
			MTA.Util.setParams('status', status);
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
				'name' : {
					'thText' : '姓名',
					'number' : false,
					'colAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
				},
				'sex' : {
					'thText' : '性别',
					'number' : false,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						td = [];
						if (value == 2) {
							td.push('女');
						} else if (value == 1) {
							td.push('男 ');
						}
						return td.join('');
					}
				},
				'mobile' : {
					'thText' : '手机号',
					'number' : false,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
				},
				'idcard' : {
					'thText' : '身份证',
					'number' : true,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
				},
				'createTime' : {
					'thText' : '报名时间',
					'number' : false,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
				},
				'typeName' : {
					'thText' : '报名班型',
					'number' : false,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
				},
				'price' : {
					'thText' : '班型费用',
					'number' : false,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
				},
				'statuss' : {
					'thText' : '是否支付',
					'number' : false,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						td = [];
						if (value == 0) {
							td.push('未支付');
						} else if (value == 1) {
							td.push('已支付 ');
						}
						return td.join('');
					}
				},
				'money' : {
					'thText' : '已支付金额',
					'number' : false,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
				},
				'payment' : {
					'thText' : '支付方式',
					'number' : false,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
				},
				'status' : {
					'thText' : '状态',
					'number' : false,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						td = [];
						if (value == 0) {
							td.push('<div style="text-align:center">');
							td.push('未处理');
							td.push('</div>');
						} else if (value == 1) {
							td.push('<div style="text-align:center">');
							td.push('已处理 ');
							td.push('</div>');
						}
						return td.join('');
					}
				},
				'id' : {
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
						if(record.status==0){
							td.push('<ul class="actions">');
							td.push('<li>');
							td.push('<a class="btn-flat primary"  onClick="remove(' + record.id + ',\'' + record.name + '\')">');
							td.push('处理成功');
							td.push('</a>');
							td.push('</li>');
						}else if(record.status==1&&record.stuId==null){
							td.push('<ul class="actions">');
							td.push('<li>');
							td.push('信息未录入');
							td.push('</a>');
							td.push('</li>');
						}
						return td.join('');
					}
				}
			};
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/referee/list?insId='+insId,
				'size' : 10,
				'ifRealPage' : 0
			};
			//初始化 并通过ajax加载数据
			dataTable = MTA.Data.loadAjaxPageTable(config);
		}
		/**
		*	删除数据
		*/
		function remove(id, name) {
			//弹出提示框 让用户确认删除
			var dialog = new GRI.Dialog({
				type : 4,
				title : '处理成功',
				content : '确定要录入【' + name + '】信息吗？',
				deGRIil : '',
				btnType : 1,
				extra : {
					top : 250
				},
				winSize : 1
			}, function() {
				//用户点了 删除的确认信息
				location.href = "${ctx}/referee/" + id;
			});
		}
	</script>
</body>
</html>