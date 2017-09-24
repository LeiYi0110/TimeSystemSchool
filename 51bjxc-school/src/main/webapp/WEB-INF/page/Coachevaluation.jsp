<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<link type="text/css" href="${ctx}/resources/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
<script type="text/javascript" src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<meta name="theme" content="school" />
<title>阳光驾培-评价信息管理</title>
</head>
<body>
	<div class="container-fluid new-admin">
		<div class="select-top">
		<a class="select-btn" data-toggle="modal" href="#addP"><span class="add"></span>新增</a>
		<sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
			<a class="select-btn" href="${ctx}/comment/exportcommlist?insId=<sec:authentication property="principal.insId"/>"><span class="add"></span>导出</a>
			<sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
			<a class="select-btn" onClick="upRecord()"><span class="spare"></span>备案</a>
			</sec:authorize>
		</sec:authorize>
		
		<sec:authorize access="hasRole('ROLE_SCHOOL_SERVICE')">
			<sec:authorize access="hasRole('ROLE_UserOperation_177')">
				<a class="select-btn" href="${ctx}/comment/exportcommlist?insId=<sec:authentication property="principal.insId"/>"><span class="add"></span>导出</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_178')">
				<a class="select-btn" onClick="upRecord()"><span class="spare"></span>备案</a>
			</sec:authorize>
		</sec:authorize>
		</div>
	</div>
		<div class="TermSearch">
		<form>
			 <input type="text" id="search" placeholder="教练姓名">
			<input class="form_date" type="text" id="createTime" data-date-format="yyyy-mm-dd" placeholder="年/月/日">
			<buuton class="btn-flat primary " onClick="searchQuery();return false;">搜 索</buuton>
		</form>
	</div>
	
	
	<div class="row-fluid">
		<div class="sub_content">
			<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
			<div id="table_list" class="gri_wrapper"></div>

		</div>
	</div>
	<div class="modal fade colsform" id="recordss" tabindex="-1"
		role="dialog" aria-hidden="true">
		<h4>查看详情</h4>
		<input type="hidden" id="id" name="id">
		<div class="sub_content">
			<div class="tab-scroll" id="record" class="ViewTrainees-list">
				<table>
					<thead>
						<tr>
							<th>日期</th>
							<th>学员编号</th>
							<th>学员姓名</th>
							<th>评价等级</th>
							<th>评价内容</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>

			</div>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal"
				onclick="modal">关闭</button>
		</div>
	</div>
	
	<div class="modal fade colsform  in" tabindex="-1" id="addP" role="dialog" aria-hidden="false" style="width: 370px; margin-left: -185px;">
		<form class="form-horizontal valid-form">
			<h4>评价教练</h4>
			<div class="modal-content">
			    <div class="row1">
					<div class="form-controll" style="margin-right: auto; width: 100%;">
						<label>学员编号:</label> <input type="text" name="studentNum" datatype="*" nullmsg="学员编号不能为空" sucmsg=" ">
					<span class="Validform_checktip"></span></div>
				</div>
				<div class="row1">
					<div class="form-controll" style="margin-right: auto; width: 100%;">
						<label>学员姓名:</label> <input type="text" name="studentName" datatype="*" nullmsg="学员姓名不能为空" sucmsg=" ">
					<span class="Validform_checktip"></span></div>
				</div>
				
				<div class="row1">
					<div class="form-controll" style="margin-right: auto; width: 100%;">
						<label>学员身份证号:</label> <input type="text" name="identifier" datatype="*" nullmsg="学员身份证号不能为空" sucmsg=" ">
					<span class="Validform_checktip"></span></div>
				</div>
				
				<div class="row1">
					<div class="form-controll" style="margin-right: auto; width: 100%;">
						<label>教练员编号:</label> <input type="text" name="coachNum" datatype="*" nullmsg="教练员编号不能为空" sucmsg=" ">
					<span class="Validform_checktip"></span></div>
				</div>
				<div class="row1">
					<div class="form-controll" style="margin-right: auto; width: 100%;">
						<label>教练名字姓名:</label> <input type="text" name="coachName" datatype="*" nullmsg="教练姓名不能为空" sucmsg=" ">
					<span class="Validform_checktip"></span></div>
				</div>
				
				<div class="row1">
					<div class="form-controll" style="margin-right: auto; width: 100%;">
						<label>星级:</label> <input type="text" name="start" datatype="*" nullmsg="星级不能为空" sucmsg=" ">
					<span class="Validform_checktip"></span></div>
				</div>
				<div class="row1">
					<div class="form-controll" style="margin-right: auto; width: 100%;">
						<label>内容:</label> <textarea  name="comment" datatype="*" nullmsg="内容不能为空" sucmsg=" "></textarea>
					<span class="Validform_checktip"></span></div>
				</div>
				
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" id="add-btn">保存</button>
			</div>
		</form>
	</div>
	
	<script type="text/javascript">
		var recordUrl=<custom:properties name='bjxc.user.province'/>;
		//标识当前页面的url 用来设置当前菜单标识
		var dataTable = null;
		var insId = '<sec:authentication property="principal.insId"/>';
		var insName = '<sec:authentication property="principal.insName"/>';
		var statId = '<sec:authentication property="principal.stationId"/>';
		$(document).ready(function() {
			//初始化界面  完成后调用buildData方法
			MTA.Report.initialize(null, 'buildData');
			
			$("#add-btn").click(function(){
				// 校验表单是否通过
				if( $("#addStudent .valid-form").Validform().check() == true ){
					var formdata = $("#addP form").serializeArray();
					$.post('${ctx}/comment/addCoachComment',formdata,function(res){
						if(res.code === 200){
							layer.alert('添加成功');
							buildDataTable();
							$("#addP").modal('hide');
						}else{
							layer.alert('添加失败');
						}
					});
				}
			});
			
		});

		function buildData() {
			buildDataTable();
		}
		/**
		 *	搜索
		 */
		function searchQuery() {
			var search = $("#search").val();
			var createTime = $("#createTime").val();
			MTA.Util.setParams('searchText', search);
			MTA.Util.setParams('searchText', createTime);
			if(isTimeSystem()){
				//时间判断函数
				function pad2(n) { return n < 10 ? '0' + n : n }
				var searchdate;
				if(createTime!=""){
					var date = new Date(createTime);
					searchdate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
				}else{
					layer.alert("日期为空")
					return;
				}
				var params={
						'inscode':insCode,
						'querydate':searchdate
						
				}
			 	$.post(recordUrl+'/province/evaluationquery/get',params,function(result) {
					if (result.errorcode == 0) {
						var _html = "<div class='tab-scroll' style='width:100%;'><table><thead><tr><th>学员编号</th><th>评价对象编号</th><th>评价对象类型:1教练员 2:培训机构</th><th>总体满意度</th><th>培训部分</th><th>评价时间</th><th>评价用语列表</th><th>个性化评价</th></tr></thead><tbody>";
						for(var i=0; i<result.data.evaluationarray.length; i++){
							_html += '<tr>';
							for( key in result.data.evaluationarray[i]){
								_html += '<td align="center">';
								_html += result.data.evaluationarray[i][key];
								_html += '</td>';
							}
							_html += '</tr>'
						 }
						_html += '</tbody></table></div>'
						 layer.open({
							title : '提示',
							maxWidth : 1650,
							content : _html
						}); 
					}else{
						layer.alert(result.message)
					}
				});
			}
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
				'createTime' : {
					'thText' : '评论时间',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<span data-id="');
							td.push(record.id);
							td.push('">');
							td.push(record.createTime);
						td.push('</span>');
						return td.join('');
					}
				},
				'servicename' : {
					'thText' : '隶属报名处',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,

				},
				'idcard' : {
					'thText' : '身份证号码',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,

				},
				'studentName' : {
					'thText' : '学员姓名',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,

				},
				'coachname' : {
					'thText' : '教练名称',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				
				},
				'starttime' : {
					'thText' : '培训开始时间',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'endtime' : {
					'thText' : '培训结束时间',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},

				'duration' : {
					'thText' : '课时时长',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'star' : {
					'thText' : '评价等级',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						td = [];
						if (value == 1) {
							td.push('一星');
						} else if (value == 2) {
							td.push('二星');
						} else if (value == 3) {
							td.push('三星');
						} else if (value == 4) {
							td.push('四星');
						} else if (value == 5) {
							td.push('五星');
						}
						return td.join('');
					}
				},
				'comment' : {
					'thText' : '评价内容',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'isCommProvince' : {
					'thText' : '是否备案',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						td = [];
						if (value == 0) {
							td.push('未备案');
						} else if (value == 1) {
							td.push('已备案 ');
						}
						return td.join('');
					}
				},
				'status' : {
					'thText' : '是否有效',
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						td = [];
						if (value == 0) {
							td.push('无效');
						} else if (value == 1) {
							td.push('有效');
						}
						return td.join('');
					}
				}
			};
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/comment/commlist?insId=' + insId,
				'size' : 10,
				'ifRealPage' : 1
			};
			//初始化 并通过ajax加载数据
			dataTable = MTA.Data.loadAjaxPageTable(config);
		}
		/* 查看评论 */
		function recordd(id) {
			var params = {
				'id' : id
			}
			$('#record tbody tr').remove();
			$.ajax({
				url : '${ctx}/comment/coachdetails',
				data : params,
				type : 'GET',
				dataType : 'JSON',
				success : function(res) {
					var start = 6;
					var html = '';
					for (var j = 0; j < res.data.length; j++) {
						html += '<tr>';
						html += '<td>' + res.data[j].createTime + '</td>';
						html += '<td>' + res.data[j].stuId + '</td>';
						html += '<td>' + res.data[j].studentName + '</td>';
						if (res.data[j].star == 1) {
							html += '<td>一星</td>';
						} else if (res.data[j].star == 2) {
							html += '<td>二星</td>';
						} else if (res.data[j].star == 3) {
							html += '<td>三星</td>';
						} else if (res.data[j].star == 4) {
							html += '<td>四星</td>';
						} else if (res.data[j].star == 5) {
							html += '<td>五星</td>';
						}
						html += '<td>' + res.data[j].comment + '</td>';
						html += '</tr>'
					}
					$('#record tbody').append(html);
					$('#recordss').modal('show');
				},
				error : function(returndata) {
					layer.alert(returndata);
				}

			});
		}
		$('.form_date').datetimepicker({
	        language:  'zh-CN',
	        weekStart: 1,
	        todayBtn:  1,
			autoclose: 1,
			todayHighlight: 0,
			startView: 2,
			minView: 2,
			forceParse: 0
	   }).on("changeDate",function(){
		   $('.form_date + .Validform_checktip').html('');
		   $('.form_date').removeClass('Validform_error');
	   });
		/**
		*	备案到省平台
		*/
		function upRecord() {
			/* 获取id */
			var id = sessionStorage.getItem('tabId');
			if(id === null || id === undefined){
				layer.alert('未选择目标');
			}else{
				//定义提交到服务端的数据对象
				var params = {
					"id" : id,
				};
				$.getJSON("${ctx}/comment/getComm",params,function(result) {
					if(result.code==200){
						var data = result.data;
						//if(data.coaIsCountry!=null && data.coaIsCountry==1){
							//if(data.stuIsCountry!=null && data.stuIsCountry==1){
								//弹出提示框 让用户确认删除
								var dialog = new GRI.Dialog({
									type : 4,
									title : '上传备案',
									content : '确定上传学员【' + data.studentName + '】的评价信息备案吗？',
									deGRIil : '',
									btnType : 1,
									extra : {
										top : 250
									},
									winSize : 1
								}, function() {
								 	//时间判断函数
								 	function pad2(n) { return n < 10 ? '0' + n : n }
								 	//评价时间
								 	var evaluatetime;
									if(data.createTime!=null){
										var date = new Date(data.createTime);
										var evaluatetime = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate()) + pad2( date.getHours() ) + pad2( date.getMinutes() ) + pad2( date.getSeconds() )
									}
									//定义提交到服务端的数据对象
									var params = {
											'stunum' : data.stunum,//,//1150332662558240
											'evalobject' : data.coachnum,//,5321301526210134
											'type' :1,
											'overall' :data.star,
											'part' :data.reserSubjectId,
											'evaluatetime' : evaluatetime,
											'srvmanner' :"",
											'teachlevel':""
									};
									//发送数据到后端保存
									$.post(recordUrl+'/province/evaluation',params,function(result) {
										if (result.errorcode == 0) {
											var param={"id":id,"isCommProvince":1};
											$.post('${ctx}/comment/coachStatus',param,function(result) {
												if(result.code==200){
													//保存成功 刷新列表
											     	buildDataTable();
											     	layer.alert("备案成功")
												}else{
													layer.alert(result.message);
												}
											});
										}else{
											layer.alert(result.message)
										}
									});
								});
							/* }else{
								layer.open({
								  title: '提示',
								  maxWidth:900,
								  content: '<h4 style="color:red; text-align:center;font-size:20px;">温馨提示</h4>'+
								  '<div style="text-align:center;">该评价中的学员没有国家平台备案的学员编号,不能上传省平台备案!</br>(在计时平台对接前录入的学员不需要备案)</div>'
								});
							}
						}else{
							layer.open({
							  title: '提示',
							  maxWidth:900,
							  content: '<h4 style="color:red; text-align:center;font-size:20px;">温馨提示</h4>'+
							  '<div style="text-align:center;">该评价中的教练没有国家平台备案的教练编号,不能上传省平台备案!</br>(在计时平台对接前录入的学员不需要备案)</div>'
							});
						} */
					}
				});
			}
		}
	</script>
</body>
</html>