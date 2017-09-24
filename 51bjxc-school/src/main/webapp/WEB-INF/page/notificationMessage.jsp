<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp"%>
<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-消息列表</title>
<script src="${ctx}/resources/uploadify/jquery.uploadify.js"></script>
<script type="text/javascript"
	src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript"
	src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript"
	src="${ctx}/resources/js/classType/<sec:authentication property="principal.insId"/>"></script>
<script type="text/javascript"
	src="${ctx}/resources/js/serviceStation/<sec:authentication property="principal.insId"/>"></script>
<script type="text/javascript" src="${ctx}/resources/js/Area/<sec:authentication property="principal.insId"/>"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery-form.js"></script>
<link type="text/css" href="${ctx}/resources/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />

</head>
<body>




	

 
	<!-- 列表 -->
	<div class="row-fluid">
		<div class="sub_content">
			<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
			<div id="table_list" class="gri_wrapper"></div>
		</div>  
	</div>
	 
	

<script type="text/javascript">
	var recordUrl=<custom:properties name='bjxc.user.province'/>;
	var insCode = '<sec:authentication property="principal.insCode"/>';

	
		//标识当前页面的url 用来设置当前菜单标识
		var dataTable = null;
		var insId= <sec:authentication property="principal.insId"/>;
		var stationId= <sec:authentication property="principal.stationId"/>;

		//初始化 
		$(document).ready(function() {
			//初始化界面  完成后调用buildData方法
			MTA.Report.initialize(null, 'buildDataTable');
			
			//ajax 方式上传文件操作

		});



		/**
		 *	构建列表
		 */
		function buildDataTable() {

			var config = {
				'container' : 'table_list'
			};
			//定义列表的列
			config['allFields'] = {

				'content' : {
					'thText' : '消息内容',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<ul class="info">');
							td.push('<li>');
							td.push(value);
							td.push('<li>');
						td.push('</ul>');
						return td.join('');
					}
				},
				
				'createtime' : {
					'thText' : '消息时间',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<ul class="info">');
							td.push('<li>');
							td.push(value);
							td.push('<li>');
						td.push('</ul>');
						return td.join('');
					}
				}
			

			};
			
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/notificationMsg/list',
				'size' : 1000,
				'ifRealPage' : 0
			};
			//初始化 并通过ajax加载数据
			dataTable = MTA.Data.loadAjaxPageTable(config);
		}
		
		
		
		
		
		/**
		*	展示编辑表单界面
		*	新增、修改都需要调用该方法打开表单
		*/
		
		
		
	</script>
</body>
</html>