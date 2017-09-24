<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-考试管理</title>
<script src="${ctx}/resources/js/jquery.form.js"></script>
</head>
<body>
<div class="container-fluid">
		<div id="pad-wrapper">
			<div class="table-wrapper products-table">
				<div class="row-fluid head">
					<div class="span12">
						<h4>考试管理</h4>
						<input type="hidden" id="insId" name="insId" value="">
					</div>
				</div>
				<div class="row-fluid filter-block">
					<div class="pull-left">
						科目一：<form enctype="multipart/form-data" class="postForm">
							<!-- <input type="hidden" name="subject" id="subject" value="1">
							<input type="text" id="insId1" name="insId" value=""> -->
							<input id="upfile" type="file" name="upfile">
							<input type="button" onClick="sss(1)" value="提交">
						</form>
					</div>
				</div>
				<div class="row-fluid filter-block">
					<div class="pull-left">
						科目二：<form enctype="multipart/form-data" class="postForm">
							<!-- <input type="hidden" name="subject" id="subject" value="2">
							<input type="text" id="insId2" name="insId" value=""> -->
							<input id="upfile" type="file" name="upfile">
							<input type="button" onClick="sss(2)" value="提交">
						</form>
					</div>
				</div>
				<div class="row-fluid filter-block">
					<div class="pull-left">
						科目三：<form enctype="multipart/form-data" class="postForm">
							<!-- <input type="hidden" name="subject" id="subject" value="3">
							<input type="text" id="insId3" name="insId" value=""> -->
							<input id="upfile" type="file" name="upfile">
							<input type="button" onClick="sss(3)" value="提交">
						</form>
					</div>
				</div>
				<div class="row-fluid filter-block">
					<div class="pull-left">
						科目四：<form enctype="multipart/form-data" class="postForm">
							<!-- <input type="hidden" name="subject" id="subject" value="4">
							<input type="text" id="insId4" name="insId" value=""> -->
							<input id="upfile" type="file" name="upfile">
							<input type="button" onClick="sss(4)" value="提交">
						</form>
					</div>
				</div>
				<div class="row-fluid">
					<div class="sub_content">
						<div id="table_list" class="gri_wrapper">
							<table>
								<thead>
									<tr>
										<th>姓名</th>
										<th>身份证号</th>
										<th>流水号</th>
										<th>科目</th>
										<th>考试日期</th>
										<th>考试成绩</th>
										<th>考试结果</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody></tbody>
								
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		var insId= '<sec:authentication property="principal.insId"/>';
		$(document).ready(function() {
			$("#insId").val(insId);
		});
		function sss(index){
			var insId= $("#insId").val();
			var indexs=index-1;
			var data = new FormData($(".postForm" )[indexs]);
			$.ajax({  
	          url: '${ctx}/exam/importScore?insId='+insId+'&subject='+index, 
	          //url: '${ctx}/exam/importScore',
	          type: 'POST',  
	          data: data,  
	          async: false,  
	          cache: false,  
	          contentType: false, 
	          dataType: 'JSON', 
	          processData: false,  
	          success: function (res) {
	            var tBody = $('#table_list tbody');
	            var html = '';
	          	for(var i=0; i<res.data.length; i++){
	          		html += '<tr>';
	          		html += '<td>'+res.data[i].姓名+'</td>';
	          		html += '<td>'+res.data[i].证件号码+"</td>";
	          		html += '<td>'+res.data[i].流水号+"</td>";
	          		html += '<td>'+res.data[i].科目+"</td>";
	          		html += '<td>'+res.data[i].考试日期+"</td>";
	          		html += '<td>'+res.data[i].考试成绩+"</td>";
	          		html += '<td>'+res.data[i].考试结果+"</td>";
	          		html += '</tr>';
	          	}
	          	tBody.append(html);
	          },  
	          error: function (returndata) {  
	          	alert(returndata.code);  
	          }  
	     }); 
		}
		
	</script>
	<!-- <div class="container-fluid">
		<div id="pad-wrapper">
			<div class="table-wrapper products-table">
				<div class="row-fluid head">
					<div class="span12">
						<h4>考试管理</h4>
					</div>
				</div>
				<div class="row-fluid filter-block">
					<div class="pull-right">
						<input type="text" class="search" placeholder="search" id="search" />
						<a class="btn-flat small" style="margin-right: 50px;" onClick="searchQuery();return false;">查询</a>
						<form method="POST"  enctype="multipart/form-data" id="form1" action="${ctx}/exam/importScore">
							<input type="hidden" name="subject" id="subject" value="1">
							<input id="upfile" type="file" name="upfile">
							<input type="submit" value="提交">
						</form>
					</div>
				</div>
				<div class="row-fluid">
					<div class="sub_content">
						<div id="table_list" class="gri_wrapper"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	<div class="modal fade" id="editorModal" tabindex="-1" role="dialog" aria-labelledby="editorModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">教练选择</h4>
				</div>
				<div class="modal-body">
					<div class="span5">
						<form id="ediorForm">
							<input type="hidden" name="id" id="id" value="">
							<input type="hidden" name="subjectId" id="subjectId" value="">
							<input type="hidden" name="studentId" id="studentId" value="">
							<div class="field-box success">
								<label>新教练:</label> 
								<select id="coach" name="coach">
									<option selected="selected" value="null">请选择</option>
								</select>
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
		//标识当前页面的url 用来设置当前菜单标识
		var dataTable = null;
		var insId= '<sec:authentication property="principal.insId"/>';
		var insName = '<sec:authentication property="principal.insName"/>';
		var statId= '<sec:authentication property="principal.stationId"/>';
		var insCode= '<sec:authentication property="principal.insCode"/>';
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
				'stuName' : {
					'thText' : '姓名',
					'number' : false,
					'colAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
				},
				'area' : {
					'thText' : '大区',
					'number' : false,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
				},
				'stationName' : {
					'thText' : '网点',
					'number' : false,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
				},
				'coachName' : {
					'thText' : '带考教练',
					'number' : false,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
				},
				'subjectId' : {
					'thText' : '考试科目',
					'number' : false,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						td = [];
						if (value == 2) {
							td.push('<div style="text-align:center">');
							td.push('科目二');
							td.push('</div>');
						} else if (value == 3) {
							td.push('<div style="text-align:center">');
							td.push('科目三');
							td.push('</div>');
						} else if (value == 1) {
							td.push('<div style="text-align:center">');
							td.push('科目一');
							td.push('</div>');
						} else if (value == 4) {
							td.push('<div style="text-align:center">');
							td.push('科目四');
							td.push('</div>');
						}
						return td.join('');
					}
				},
				'examTime' : {
					'thText' : '考试时间',
					'number' : false,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
				},
				'pass' : {
					'thText' : '是否通过',
					'number' : false,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						td = [];
						if (value == 1) {
							td.push('<div style="text-align:center">');
							td.push('通过');
							td.push('</div>');
						} else if (value == 0) {
							td.push('<div style="text-align:center">');
							td.push('未通过');
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
						td.push('<ul class="actions">');
						td.push('<li>');
						td.push('<a class="btn-flat primary" onClick="showEditorModel('+ record.id + ',' + record.subjectId + ',' 
							+ record.stationId + ',' + record.studentID + ')">');
						td.push('通过');
						td.push('</a>');
						td.push('</li>');
						td.push('<li>');
						td.push('<a class="btn-flat danger" onClick="changeStatus('+ record.id+',\''+record.stuName+'\')">');
						td.push('未通过');
						td.push('</a>');
						td.push('</li>');
						td.push('</ul>');
						return td.join('');
					}
				}
			};
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/exam/list?insId='+insId,
				'size' : 1000,
				'ifRealPage' : 0
			};
			//初始化 并通过ajax加载数据
			dataTable = MTA.Data.loadAjaxPageTable(config);
		}
		
		function changeStatus(id, name) {
			//弹出提示框 让用户确认删除
			var dialog = new GRI.Dialog({
				type : 4,
				title : '没有通过考试',
				content : '确定【' + name + '】没有通过考试吗？',
				deGRIil : '',
				btnType : 1,
				extra : {
					top : 250
				},
				winSize : 1
			}, function() {
				//用户点了 删除的确认信息
				var param = {'status':0};
				$.post("${ctx}/exam/"+id,param,function (data) {
					if(data.code==200){
						buildDataTable();
					}
				});
			});
		}
		
		/**
		*	展示编辑表单界面
		*	新增、修改都需要调用该方法打开表单
		*/
		function showEditorModel(id,subjectId,stationId,studentId) {
			//重置表单
			$('#coach').empty();
			$("select[name='coach']").append("<option value='null'>请选择</option>");
			$('#id').val(id);
			$('#subjectId').val(subjectId);
			$('#studentId').val(studentId);
			var datas={
				insId:insId,
				subjectId:subjectId + 1,
				stationId:stationId
			};
			$.getJSON("${ctx}/coach/getInsCoach",datas,function (result) {
				if (result.code==200) {
					var data = result.data;
					for(var i=0; i<data.length; i++){
						$("select[name='coach']").append("<option value='"+data[i].id+"'>"+data[i].name+"</option>");
					}
				}
			});
			$('#editorModal').modal('show');
		}
		
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
			var id = $('#id').val();
			var subjectId = $('#subjectId').val();
			var coach = $('#coach').val();
			var studentId = $('#studentId').val();
			if(coach=='null'){
				alert("教练不能为空！");
				return false;
			}
			//定义提交到服务端的数据对象
			var params = {
				'insId':insId,
				'subjectId' : subjectId,
				'coach' : coach,
				'studentId' : studentId,
				'status' : 1
			};
			//发送数据到后端保存
			$.post('${ctx}/exam/'+id, params, function (result) {
				 if (result.code==200) {
					 //保存成功 刷新列表
			     	dataTable.refresh();
					 //关闭编辑的表单
					$('#editorModal').modal('hide');
				}
			});
		}
	</script> -->
</body>
</html>