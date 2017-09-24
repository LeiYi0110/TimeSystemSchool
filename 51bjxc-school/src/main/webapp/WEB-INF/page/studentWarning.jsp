<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-学时预警管理</title>
</head>
<body>
	<div class="TermSearch">
 	 <form>
	 <input class="input1 win200" type="text" id="search" placeholder="身份证号/手机号码/学员姓名搜索">
	 <buuton class="btn-flat primary" onClick="searchQuery();return false;">搜 索</buuton>
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
				'mondayOne' : {
					'thText' : '日期范围',
					'number' : true,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<span data-id="');
							td.push('">');
							td.push(record.mondayOne+'至'+record.mondayDay);
						td.push('</span>');
						return td.join('');
					}
				},	
				'name' : {
					'thText' : '学员姓名',
					'number' : true,
					'needOrder' : false,
					'precision' : 0
				},	
				'traintype' : {
					'thText' : '培训车型',
					'number' : true,
					'needOrder' : false,
					'precision' : 0
				},
				'coachName' : {
					'thText' : '教练名称',
					'number' : true,
					'needOrder' : false,
					'precision' : 0
				},
				'classTypeName' : {
					'thText' : '班型',
					'number' : true,
					'needOrder' : false,
					'precision' : 0
				},
				'classhour' : {
					'thText' : '课时限制(小时/周)',
					'number' : true,
					'needOrder' : false,
					'precision' : 0
				},
				'reservation' : {
					'thText' : '已上课时(小时/周)',
					'number' : true,
					'needOrder' : false,
					'precision' : 0
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
				'url' : '${ctx}/student/WarningList',
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