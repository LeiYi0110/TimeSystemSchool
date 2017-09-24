<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
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
			<a class="select-btn" data-toggle="modal" href="${ctx}/comment/exportshcoolcomm?insId=<sec:authentication property="principal.insId"/>"><span
				class="edit"></span>导出</a>
			<sec:authorize access="hasRole('ROLE_TIME_SYSTEM')">
				<a class="select-btn" onClick="upRecord()"><span class="spare"></span>备案</a>
			</sec:authorize>
		</sec:authorize>
		
		<sec:authorize access="hasRole('ROLE_SCHOOL_SERVICE')">
			<sec:authorize access="hasRole('ROLE_UserOperation_174')">
					<a class="select-btn" data-toggle="modal" href="${ctx}/comment/exportshcoolcomm?insId=<sec:authentication property="principal.insId"/>"><span
						class="edit"></span>导出</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_TIME_SYSTEM')">
				<sec:authorize access="hasRole('ROLE_UserOperation_175')">
					<a class="select-btn" onClick="upRecord()"><span class="spare"></span>备案</a>
				</sec:authorize>
			</sec:authorize>
		</sec:authorize>
		</div>
	</div>
	<div class="TermSearch">
		<form>
			<input class="form_date" type="text" id="search" data-date-format="yyyy-mm-dd"
				placeholder="年/月/日">
			<buuton class="btn-flat primary "
				onClick="searchQuery();return false;">搜 索</buuton>
		</form>
	</div>
	<div class="row-fluid">
		<div class="sub_content">
			<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
			<div id="table_list" class="gri_wrapper"></div>

		</div>
	</div>
	
	<div class="modal fade colsform  in" tabindex="-1" id="addP" role="dialog" aria-hidden="false" style="width: 370px; margin-left: -185px;">
		<form class="form-horizontal valid-form">
			<h4>评价驾校</h4>
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
						<label>身份证号:</label> <input type="text" name="identifierNo" datatype="*" nullmsg="身份证号不能为空" sucmsg=" ">
					<span class="Validform_checktip"></span></div>
				</div>
				<div class="row1">
					<div class="form-controll" style="margin-right: auto; width: 100%;">
						<label>驾校名称:</label> <input type="text" name="institutionName" datatype="*" nullmsg="驾校名称不能为空" sucmsg=" ">
					<span class="Validform_checktip"></span></div>
				</div>
				<div class="row1">
					<div class="form-controll" style="margin-right: auto; width: 100%;">
						<label>星级:</label> <input type="text" name="start" datatype="/^\d[1-5]{1}$/" nullmsg="星级不能为空" sucmsg=" " errormsg="1-5之间">
					<span class="Validform_checktip"></span></div>
				</div>
				<div class="row1">
					<div class="form-controll" style="margin-right: auto; width: 100%;">
						<label>内容:</label> <textarea  name="coment" datatype="*" nullmsg="内容不能为空" sucmsg=" "></textarea>
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
					$.post('${ctx}/comment/addSchoolComment',formdata,function(res){
						if(res.code === 200){
							layer.alert('添加成功');
							buildDataTable();
							$("#addP").modal('hide');
						}else{
							layer.alert('添加失败');
						}
					});
				}
			})
		});
		function buildData() {
			buildDataTable();
		}
		/**
		 *	搜索
		 */
		function searchQuery() {
			var search = $("#search").val();
			
				//时间判断函数
				function pad2(n) { return n < 10 ? '0' + n : n }
				var searchdate;
				if(search!=""){
					var date = new Date(search);
					var searchdate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
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
						var _html = "<div class='tab-scroll' style='width:100%;'><table><thead><tr><th>学员编号</th><th>评价对象编号</th><th>评价对象类型:1:教练员 2培训机构</th><th>总体满意度</th><th>培训部分</th><th>评价时间</th><th>评价用语列表</th><th>个性化评价</th></tr></thead><tbody>";
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
			
			
			//buildDataTable();
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
				'evaluatetime' : {
					'thText' : '评价时间',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<span data-id="');
							td.push(record.id);
							td.push('">');
							td.push(record.evaluatetime);
						td.push('</span>');
						return td.join('');
					}
				},
				'insName' : {
					'thText' : '驾校名称',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'stuName' : {
					'thText' : '学员姓名',
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
				'tationname' : {
					'thText' : '隶属报名处',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'overall' : {
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
				'teachlevel' : {
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
				'isValid' : {
					'thText' : '是否有效',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						td = [];
						if (value == 0) {
							td.push('无效');
						} else if (value == 1) {
							td.push('有效 ');
						}
						return td.join('');
					}
				}
			};
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/comment/shcoolcomm?insId=' + insId,
				'size' : 10,
				'ifRealPage' : 1
			};
			//初始化 并通过ajax加载数据
			dataTable = MTA.Data.loadAjaxPageTable(config);
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
				$.getJSON("${ctx}/comment/" + id,function(result) {
					if(result.code==200){
						var data = result.data;
						
						if(data.stuIsCountry!=null&&data.stuIsCountry==1){//看学员是否已经全国备案
							//弹出提示框 让用户确认删除
							var dialog = new GRI.Dialog({
								type : 4,
								title : '上传备案',
								content : '确定上传学员编号【' + data.studentId + '】的投诉信息备案吗？',
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
								if(data.evaluatetime!=null){
									var date = new Date(data.evaluatetime);
									var evaluatetime = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate()) + pad2( date.getHours() ) + pad2( date.getMinutes() ) + pad2( date.getSeconds() )
								}
								//定义提交到服务端的数据对象
								var params = {
										'stunum' :data.stunum,//'5113559050455096',
										'evalobject' : insCode,
										'type' :2,
										'overall' :data.overall,
										'part' : data.part,
										'evaluatetime' : evaluatetime,
										'srvmanner' : data.srvmanner,
										'teachlevel':data.teachlevel
								};
								//发送数据到后端保存
								$.post(recordUrl+'/province/evaluation',params,function(result) {
									if (result.errorcode == 0) {
										var param={"id":id,"isCommProvince":1};
										$.post('${ctx}/comment/evalStatus',param,function(result) {
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
						}else{
							layer.open({
							  title: '提示',
							  maxWidth:900,
							  content: '<h4 style="color:red; text-align:center;font-size:20px;">温馨提示</h4>'+
							  '<div style="text-align:center;">该学员没有国家平台备案的学员编号,不能上传省平台备案!</br>(在计时平台对接前录入的学员不需要备案)</div>'
							});
						}
					}
				});
			}
		}
	</script>
</body>
</html>