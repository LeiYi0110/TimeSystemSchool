<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<meta name="theme" content="page" />
<link type="text/css" href="${ctx}/resources/css/compiled/new-form.css" rel="stylesheet" />
<title>阳光驾培-编辑学员信息</title>
</head>
<body>
	<div class="container-fluid">
		<div id="pad-wrapper" class="new-form">
			<div class="row-fluid header">
				<h3>学员信息-学时记录</h3>
			</div>

			<div class="row-fluid form-wrapper">
				<div class="span2 pull-left">
					<ul  id="dashboard-menu">
						<li>
							<a href="${ctx}/view/studentView?id=${param.id}">
								学员基本信息
							</a>
						</li>
						<li>
							<a href="${ctx}/view/studentInsLog?id=${param.id}">
								学车进度
							</a>
						</li>
						<li>
							<a href="#"  class="active" style="color:#000">
								学时记录
							</a>
						</li>
					</ul>
				</div>
				<!-- left column -->
				<div class="span7">
					<div class="container">
						<!--学车记录 列表 -->
						<div class="row-fluid">
							<div class="sub_content">
								<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
								<div id="table_list" class="gri_wrapper"></div>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
<script type="text/javascript">
	var studentId = '${param.id}';
	var insId = <sec:authentication property="principal.insId"/>;
	var stationId = <sec:authentication property="principal.stationId"/>;
	//初始化 
	$(document).ready(function() {
		//初始化界面  完成后调用buildData方法
		MTA.Report.initialize(null, 'buildData');
	});

	function buildData() {
		MTA.Util.setParams('studentId', studentId);
		MTA.Util.setParams('insId', insId);

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
				'thText' : '学员名称',
				'number' : false,
				'colAlign' : 'center',
				'thAlign' : 'center',
				'needOrder' : false,
				'precision' : 0,
			},
			'day' : {
				'thText' : '练车日期',
				'number' : false,
				'colAlign' : 'center',
				'thAlign' : 'center',
				'needOrder' : false,
				'precision' : 0
			},
			'coachName' : {
				'thText' : '教练名称',
				'number' : false,
				'colAlign' : 'center',
				'thAlign' : 'center',
				'needOrder' : false,
				'precision' : 0,
			},
			'time' : {
				'thText' : '时段',
				'number' : false,
				'colAlign' : 'center',
				'thAlign' : 'center',
				'needOrder' : false,
				'precision' : 0,
				'render' : function(value, cellmeta, record, rowIndex,
						columnIndex) {
					td = [];
					td.push(value+':00-'+value+1+":00");
					return td.join('');
				}
			},
			'subjectName' : {
				'thText' : '科目名称',
				'number' : false,
				'colAlign' : 'center',
				'thAlign' : 'center',
				'needOrder' : false,
				'precision' : 0
			}
		};
		//ajax的数据请求参数
		config['page'] = {
			'url' : '${ctx}/studentRecording/list?id='+studentId,
			'size' : 100,
			'ifRealPage' : 0
		};
		//初始化 并通过ajax加载数据
		dataTable = MTA.Data.loadAjaxPageTable(config);
	}
</script>
</body>
</html>