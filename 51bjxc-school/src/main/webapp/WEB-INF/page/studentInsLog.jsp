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
				<h3>学员信息-学车进度</h3>
				<!-- 
				<div class="span10 pull-left">
					<a class="btn-flat success pull-right" style="margin-left:10px;"  href="#" onclick="showAddStudentSubjectPanel()">新增学车记录</a>
                </div>
				 -->
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
							<a href="#"  class="active" style="color:#000">
								学车进度
							</a>
						</li>
						<li>
							<a href="${ctx}/view/studentRecording?id=${param.id}">
								学时记录
							</a>
						</li>
					</ul>
				</div>
				<!-- left column -->
				<div class="span10 ">
					<div class="container">
							
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
		</div>
	</div>



	<!-- add panel 弹出的编辑界面-->
	<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="editorModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">增加学员进度</h4>
				</div>
				<div class="modal-body">
					<div class="span5">
						<form id="addForm">
							<div class="field-box success">
								<label>科目:</label> 
								<label><input type="radio" value="0" name="subjectId" checked="checked">科目一录入</label>
								<label><input type="radio" value="1" name="subjectId">科目一学习考试</label>
								<label><input type="radio" value="2" name="subjectId">科目二学习考试</label>
								<label><input type="radio" value="3" name="subjectId">科目三学习考试</label>
								<label><input type="radio" value="4" name="subjectId">科目四学习考试</label>
							</div>
						</form>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onClick="addStudentSubject();">保存</button>
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
				'thText' : '姓名',
				'number' : false,
				'colAlign' : 'left',
				'thAlign' : 'left',
				'needOrder' : false,
				'precision' : 0,
			},
			'content' : {
				'thText' : ' ',
				'number' : false,
				'colAlign' : 'left',
				'thAlign' : 'center',
				'needOrder' : false,
				'precision' : 0
			},
			'category' : {
				'thText' : '类别',
				'number' : false,
				'colAlign' : 'center',
				'thAlign' : 'center',
				'needOrder' : false,
				'precision' : 0,
				'render' : function(value, cellmeta, record, rowIndex,
						columnIndex) {
					var td =[];
					td.push('<div  style="text-align:center;width:100%">');
					if(value == 1){
						 td.push('教学');
					}else if(value == 2){
						 td.push('教务');
					}else if(value == 2){
						 td.push('其它');
					}
					td.push('</div>');
					return td.join('');
				}
			},
			'createTime' : {
				'thText' : '开始时间',
				'number' : false,
				'colAlign' : 'left',
				'thAlign' : 'left',
				'needOrder' : false,
				'precision' : 0
			}
		};
		//ajax的数据请求参数
		config['page'] = {
			'url' : '${ctx}/student/getStudentInsLog',
			'size' : 100,
			'ifRealPage' : 0
		};
		//初始化 并通过ajax加载数据
		dataTable = MTA.Data.loadAjaxPageTable(config);
	}
	
	function completeSubject(subjectId){
		//弹出提示框 让用户确认删除
		var dialog = new GRI.Dialog({
			type : 4,
			title : '科目',
			content : '确定学员已通过吗？',
			deGRIil : '',
			btnType : 1,
			extra : {
				top : 250
			},
			winSize : 1
		}, function() {
			var datas={
					subjectId:subjectId,
					studentId:studentId
				};
				$.post("${ctx}/studentSubject/completeSubject",datas,function (result) {
					if (result.code==200) {
						buildDataTable();
					}
				});
		});
	}
	
	function showAddStudentSubjectPanel(){
		$('#addModal').modal('show');
	}
	
	function addStudentSubject(){
		var subjectId = $('#addForm input[name="subjectId"]:checked').val();
		var datas={
				subjectId:subjectId,
				insId:insId,
				studentId:studentId
			};
			$.post("${ctx}/studentSubject/add",datas,function (result) {
				if (result.code==200) {
					$('#addModal').modal('hide');
					buildDataTable();
				}else{
					var dialog = new GRI.Dialog({
						type : 4,
						title : '异常',
						content : result.message,
						deGRIil : '',
						btnType :3,
						extra : {
							top : 250
						},
						winSize : 1
					}, function() {
					});
				}
			});
		
	}
	
	
</script>
</body>
</html>