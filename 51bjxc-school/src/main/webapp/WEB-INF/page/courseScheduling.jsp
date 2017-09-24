<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>

<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-理论课排班</title>
<link type="text/css" href="${ctx}/resources/css/compiled/new-form.css" rel="stylesheet" />
<link href="${ctx}/resources/css/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen" />
<link href="${ctx}/resources/js/form-prompt/style.css" type="text/css" rel="stylesheet" media="all" />
<script type="text/javascript" src="${ctx}/resources/js/form-prompt/Validform_v5.3.2_min.js"></script>
<script src="${ctx}/resources/uploadify/jquery.uploadify.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery-form.js"></script>
</head>
<body>
	<div class="container-fluid new-admin">
		<div class="select-top">
				<a class="select-btn" data-toggle="modal" onclick="addStudent();"><span class="add"></span>添加学员</a>
				<a class="select-btn" data-toggle="modal" onclick="submit();"><span class="add"></span>提交名单</a>
		</div>
	</div>
	<!-- 列表 -->
	<div class="row-fluid">
		<div class="sub_content">
			<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
			<div id="table_list" class="gri_wrapper"></div>
		</div>
	</div>
	<!-- 新增-->
	<div class="modal fade colsform" id="addClassStu" tabindex="-1" role="dialog" aria-hidden="true">	
		<form id="addclassStu" class="form-horizontal valid-form">
			<h4>添加上课学员</h4>
			<div class="modal-content">
				<div class="left">
					<div class="row1">
						<div class="form-controll">
							<label>上课日期:</label>
							<input type="text" name="classDate"  class="form_date" data-date-format="yyyy-mm-dd" readonly="readonly"
							 datatype="*" nullmsg="上课日期不能为空" sucmsg=" ">
						</div>
						<div class="form-controll">
							<label>学员姓名:</label>
							<input type="text" name="name" id="name" onblur="clean();" autocomplete="off" datatype="*" nullmsg="学员姓名不能为空" sucmsg=" ">
							<input type="hidden" name="id" id="id">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>电话号码:</label>
							<input type="text" name="mobile" datatype="*" nullmsg="电话号码不能为空" sucmsg=" " readonly="readonly">
						</div>
						<div class="form-controll">
							<label>流水号:</label>
							<input type="text" name="recordnum" datatype="*" nullmsg="流水号不能为空" sucmsg=" " readonly="readonly">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll wid90">
							<label>备注:</label>
							<textarea id="remarks"></textarea>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="saveInfo();">保存</button>
			</div>
		</form>
	</div>
	<script type="text/javascript">
		var recordUrl=<custom:properties name='bjxc.user.province'/>;
		var insId= '<sec:authentication property="principal.insId"/>';
		var insName = '<sec:authentication property="principal.insName"/>';
		var statId= '<sec:authentication property="principal.stationId"/>';
		MTA.Util.setParams('stationId', statId);
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
				'classDate' : {
					'thText' : '上课日期',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						 var date = record.classDate;    //此处也可以写成 17/07/2014 一样识别    也可以写成 07-17-2014  但需要正则转换   
						 var day = new Date(Date.parse(date));   //需要正则转换的则 此处为 ： var day = new Date(Date.parse(date.replace(/-/g, '/')));  
						 var today = new Array('星期日','星期一','星期二','星期三','星期四','星期五','星期六');  
						 var week = today[day.getDay()];
						td.push('<span class="tab-date" data-id="'+ record.id +'">')
							td.push(record.classDate+"</br>"+week);
						td.push('</span >');
						return td.join('');
					}
				},	
				'studentName' : {
					'thText' : '学员姓名',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'mobile' : {
					'thText' : '电话号码',
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
				'recordnum' : {
					'thText' : '流水号',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'remarks' : {
					'thText' : '备注',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						if(value==null){
							value="";
						}
						td.push('<input class="tab-input-text" type="text" value="'+value+'">');
						return td.join('');
					}
				}
			};
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/schedulingTheory/schedulingList',
				'size' : 10,
				'ifRealPage' : 1
				
			};
			config['callback'] = function(){
				$('.tab-date').datetimepicker({
			        language:  'zh-CN',
			        weekStart: 1,
			        todayBtn:  1,
					autoclose: 1,
					todayHighlight: 0,
					startView: 2,
					minView: 2,
					forceParse: 0
			   }).on('changeDate',function(ev){
					/* 获取id */
					var id=$(this).attr('data-id');
				  	var classDate=new Date(ev.date).pattern('yyyy-MM-dd');
				  	var params = {
							"id":id,
							"classDate":classDate
					};
					$.post("${ctx}/schedulingTheory/update",params,function (result) {
						if (result.code==200) {
							buildDataTable();
						}
					});
				   $(this).html(new Date(ev.date).pattern('yyyy-MM-dd'));
				 
			   });
				
				$(".tab-input-text").change(function(){
					/* 获取id */
					var id = sessionStorage.getItem('tabId');
					var params = {
							"id":id,
							"remarks":$(this).val()
						}; 
					$.post("${ctx}/schedulingTheory/update",params,function (result) {
						if (result.code==200) {
							buildDataTable();
						}
					});
				})
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
		
		function submit(){
			var arrId = [];
			var ids= [];
			var dateId =  $(".tab-date");
			for(var i=0; i<dateId.length; i++){
				if( dateId.eq(i).html().length !== 0  ){
					arrId.push(dateId.eq(i).attr('data-id'));
				}else{
					ids.push(dateId.eq(i).attr('data-id'));
				}
			}
			//弹出提示框 让用户确认删除
			var dialog = new GRI.Dialog({
				type : 4,
				title : '确认提交上课安排名单？',
				content : '提交总人数：'+arrId.length,
				deGRIil : '',
				btnType : 1,
				extra : {
					top : 250
				},
				winSize : 1
			}, function() {
				var params = {
						"arrId":arrId,
						"ids":ids
					}; 
				$.post("${ctx}/schedulingTheory/schedulingUpdate",params,function (result) {
					if (result.code==200) {
						buildDataTable();
					}
				});
			});
			console.log(arrId);
			console.log(ids);	
		}
		function addStudent(){
			var tool = new toolCtrl();
            tool.clearForm();
			$('#addClassStu').modal('show');
		}
		function saveInfo(){
			var classDate = $('#addclassStu input[name="classDate"]').val();
			var name = $('#addclassStu input[name="name"]').val();
			var id=$("#addclassStu input[name='id']").val();
			var mobile = $('#addclassStu input[name="mobile"]').val();
			var recordnum = $('#addclassStu input[name="recordnum"]').val();
			var remarks = $('#remarks').val();
			// 校验表单是否通过
			if( $("#addClassStu .valid-form").Validform().check() != true ){
				return
			}
			var params={
					"id":id,
					"classDate":classDate,
					"remarks":remarks
			};
			$.post("${ctx}/schedulingTheory/addSchedulingStu",params,function (result) {
				if (result.code==200) {
					$('#addClassStu').modal('hide');
					buildDataTable();
				}
			});
		}
		$(function(){
			$("#name").bigAutocomplete({
				url:'${ctx}/schedulingTheory/getByStudent?insId='+insId+'&stationId='+statId,
				callback:function(data){
					$("#addclassStu input[name='id']").val(data.id);
					$('#addclassStu input[name="mobile"]').val(data.mobile);
					$('#addclassStu input[name="recordnum"]').val(data.recordnum);
				}
			});
		});
		//清除表单数据
		function clean(){
			$("#addclassStu input[name='id']").val('');
			$('#addclassStu input[name="mobile"]').val('');
			$('#addclassStu input[name="recordnum"]').val('');
		}
	</script>
     
</body>
</html>