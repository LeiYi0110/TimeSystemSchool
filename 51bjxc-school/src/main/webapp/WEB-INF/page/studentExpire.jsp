<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-学员到期管理</title>
</head>
<body>
	<!-- 列表 -->
	<div class="row-fluid">
		<div class="sub_content">
			<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
			<div id="table_list" class="gri_wrapper"></div>
		</div>
	</div>
	<!-- <div class="container-fluid">
		<div id="pad-wrapper">
			<div class="table-wrapper products-table">
				<div class="row-fluid head">
					<div class="span12">
						<h4>学员到期信息</h4>
					</div>
				</div>
				搜索
				<div class="row-fluid filter-block">
					<div class="pull-right">
						<input type="text" class="search" placeholder="电话号码  姓名 证件号" id="search" />
						<a class="btn-flat small" style="margin-right: 50px;"
							onClick="searchQuery();return false;">查询</a>
							
							<a class="btn-flat success new-product"  href="${ctx}/view/studentEditor" target="_blank">+ 录入学员</a>
							
					</div>
				</div>
			</div>
		</div>
	</div>


	coach panel 弹出的编辑界面
	<div class="modal fade" id="coachModal" tabindex="-1" role="dialog" aria-labelledby="editorModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">指定教练</h4>
				</div>
				<div class="modal-body">
					<div class="span5">
						<form id="coachForm">
							<input type="hidden" name="subjectId" id="subjectId" value="">
							<input type="hidden" name="studentId" id="studentId" value="">
							<div class="field-box success">
								<label>教练:</label> 
								<select id="coach" name="coach">
									<option selected="selected">请选择</option>
								</select>
							</div>
						</form>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onClick="changeCoach();">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	coach panel 弹出的编辑界面
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
	</div> -->
	
	<script type="text/javascript">
    	var current_action = "${ctx}/view/student";
	
		//标识当前页面的url 用来设置当前菜单标识
		var dataTable = null;
		var insId= <sec:authentication property="principal.insId"/>;
		var stationId= <sec:authentication property="principal.stationId"/>;
		//初始化 
		$(document).ready(function() {
			//初始化界面  完成后调用buildData方法
			MTA.Report.initialize(null, 'buildData');
		});

		function buildData() {
			MTA.Util.setParams('insId', insId);
			
			if(stationId && stationId != ''){
				MTA.Util.setParams('stationId', stationId);
			}
			buildDataTable();
		}
		/**
		 *	搜索
		 */
		function searchQuery() {
			var search = $("#search").val();
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
				'stunum' : {
					'thText' : '学员编号',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'overdueTime' : {
					'thText' : '逾期剩余时间',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'name' : {
					'thText' : '学员姓名',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'sex' : {
					'thText' : '性别',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<ul class="info">');
							td.push('<li>');
								if (record.sex == 2) {
									td.push('女');
								} else if (record.sex == 1) {
									td.push('男 ');
								}
							td.push('</li>');
						td.push('</ul>');
						return td.join('');
					}
				},
				'mobile' : {
					'thText' : '学员姓名',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'traintype' : {
					'thText' : '培训车型',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'classTypeName' : {
					'thText' : '班型',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'coachName' : {
					'thText' : '教练',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'subjectId' : {
					'thText' : '培训进度',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<ul class="info">');
							if(record.subjectId >= 0 && value != 3){
								td.push('<li>');
									if(record.subjectId == 0){
										td.push('科目一录入');
									}else if(record.subjectId == 1){
										td.push('科目一');
									}else if(record.subjectId == 2){
										td.push('科目二');
									}else if(record.subjectId == 3){
										td.push('科目三');
									}else if(record.subjectId == 4){
										td.push('科目四');
									}
								td.push('</li>');
							}
						td.push('</ul>');
						return td.join('');
					}
				},
				'tuition' : {
					'thText' : '应付',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'alreadyPay' : {
					'thText' : '已付',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'arrearage' : {
					'thText' : '欠费',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'subjectTime' : {
					'thText' : '科目一时间',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				}/* ,
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
						td.push('<div style="width:100%;text-align:right;">');
						td.push('<ul class="actions">');
						if (record.stunum  == null){
							td.push('<a title="学员编号" href="#" onclick="showChangeStudentStunum(' +  record.id + ');">');
							td.push('完成受理');
							td.push('</a>');
							td.push(' | ');
						}else if(record.subjectId == null){
							td.push('<a title="学员详情信息" href="#" onclick="changeStudentStatus(' +  record.id + ',\'' + record.name + '\' ,0);">');
							td.push('科目一录入');
							td.push('</a>');
							td.push(' | ');
						}else if(record.status==2 && record.subjectId == 0){
							td.push('<a title="学员详情信息" href="#" onclick="changeStudentStatus(' +  record.id + ',\'' + record.name + '\' ,1);">');
							td.push('开始科目一');
							td.push('</a>');
							td.push(' | ');
						}else if(record.status==2 && record.subjectId == 1){
							td.push('<a title="学员详情信息" href="#" onclick="changeStudentStatus(' +  record.id + ',\'' + record.name + '\' ,2);">');
							td.push('开始科目二');
							td.push('</a>');
							td.push(' | ');
						}else if(record.status==2 && record.subjectId == 2){
							td.push('<a title="学员详情信息" href="#" onclick="changeStudentStatus(' +  record.id + ',\'' + record.name + '\' ,3);">');
							td.push('开始科目三');
							td.push('</a>');
							td.push(' | ');
						}else if(record.status==2 && record.subjectId == 3){
							td.push('<a title="学员详情信息" href="#" onclick="changeStudentStatus(' +  record.id + ',\'' + record.name + '\' ,4);">');
							td.push('开始科目四');
							td.push('</a>');
							td.push(' | ');
						}else if(record.status==2 && record.subjectId == 4){
							td.push('<a title="学员详情信息" href="#" onclick="changeStudentStatus(' +  record.id + ',\'' + record.name + '\' ,5);">');
							td.push('已拿证');
							td.push('</a>');
							td.push(' | ');
						}
						td.push('<li>');
						td.push('<a title="学员详情信息" href="${ctx}/view/studentView?id='
								+ record.id + '" target= "_blank">');
						td.push('详情');
						td.push('</a>');
						td.push('</li>');
						td.push('</ul>');
						td.push('</div>');
						return td.join('');
					}
				} */
			};
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/student/expireList',
				'size' : 10,
				'ifRealPage' : 1
			};
			//初始化 并通过ajax加载数据
			dataTable = MTA.Data.loadAjaxPageTable(config);
		}
		
		function changeStudentStatus(studentId,studentName, status) {
			var msg = '确定将 ' + studentName + ' 更改到';
				if(status == 0){
					msg += '科目一学习';
				}else if(status == 1){
					msg += '科目一学习';
				}else if(status == 2){
					msg += '科目二学习';
				}else if(status == 3){
					msg += '科目三学习';
				}else if(status == 4){
					msg += '科目四学习';
				}else if(status == 5){
					msg += '已拿证';
				}
			//弹出提示框 让用户确认删除
			var dialog = new GRI.Dialog({
				type : 4,
				title : '变更学员进度',
				content : msg,
				deGRIil : '',
				btnType : 1,
				extra : {
					top : 250
				},
				winSize : 1
			}, function() {
				var params = {
						studentId:studentId,
						status:status,
						insId:insId
				}
				
				$.post('${ctx}/student/changeStudentStatus', params, function (result) {
					if(result.code==200){
						buildDataTable();
					}else{
						new GRI.Dialog({
							type : 4,
							title : '变更学员进度',
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
			});
		}
		
		function changeCoach(){
			var subjectId = $('#coachForm input[name="subjectId"]').val();
			var studentId = $('#coachForm input[name="studentId"]').val();
			var coachId = $('#coachForm select[name="coach"]').val();
			if(!coachId){
				return;
			}
			var datas={
				subjectId:subjectId,
				studentId:studentId,
				coachId:coachId
			};
			$.post("${ctx}/studentSubject/changeCoach",datas,function (result) {
				if (result.code==200) {
					$('#coachModal').modal('hide');
					buildDataTable();
				}
			});
			
		}
		

		
		function showChangeCoachPanel(studentId,subjectId,coachId){
			$('#coachForm input[name="studentId"]').val(studentId);
			$('#coachForm input[name="subjectId"]').val(subjectId);
			$('#coachForm select[name="coach"]').empty();
				var datas={
					subjectId:subjectId,
					insId:insId
				};
				if(stationId){
					datas['stationId'] = stationId
				}
				$("select[name='coach']").append("<option value=''>请选择教练</option>");
				$.getJSON("${ctx}/coach/getInsCoach",datas,function (result) {
					if (result.code==200) {
						var data = result.data;
						for(var i=0; i<data.length; i++){
							$("select[name='coach']").append("<option value='"+data[i].id+"'>"+data[i].name+"</option>");
						}
						if(coachId){
							$('#coachForm select[name="coach"]').val(coachId);
						}
					}
				});
			$('#coachModal').modal('show');
		}
		
		function changeStudent(){
			var studentId = $('#studentForm input[name="studentId"]').val();
			var stunum = $('#studentForm input[name="stunum"]').val();
			
			if(!studentId){
				return;
			}
			
			var datas={
				studentId:studentId,
				stunum:stunum,
			};
			
			$.post("${ctx}/student/changeStudentStunum",datas,function (result) {
				alert(stunum);
				if (result.code==200) {
					$('#studentModal').modal('hide');
					buildDataTable();
				}
			});
			
		}
		
		function showChangeStudentStunum(studentId){
			$('#studentForm input[name="studentId"]').val(studentId);
			$('#studentForm input[name="stunum"]').val();
			
			$('#studentModal').modal('show');
		}
		
	</script>
</body>
</html>