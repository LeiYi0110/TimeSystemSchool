<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ include file="/meta/meta-tag.jsp"%>
<html>
<head>
<meta name="theme" content="school" />
<link type="text/css" href="${ctx}/resources/css/daterangepicker.min.css" rel="stylesheet" />
<script src='${ctx}/resources/js/moment.min.js'></script>
<script src="${ctx}/resources/js/jquery.daterangepicker.min.js"></script>
<script src="${ctx}/resources/uploadify/jquery.uploadify.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery-form.js"></script>
<title>阳光驾培-学员转机构管理</title>
</head>
<body>
	<div class="container-fluid new-admin">
		<div class="select-top">
		<sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
			<a class="select-btn" onclick="changeInstitution()"><span class="shift"></span>转机构</a>
		</sec:authorize>	
			<sec:authorize access="hasRole('ROLE_SCHOOL_SERVICE')">
				<sec:authorize access="hasRole('ROLE_UserOperation_171')">
					<a class="select-btn" onclick="changeInstitution()"><span class="shift"></span>转机构</a>
				</sec:authorize>
			</sec:authorize>
		</div>
	</div>
	
		<div class="TermSearch">
		<form>
			 <input
				class="input1 win200" type="text" id="search"
				placeholder="姓名/身份证号">
			<buuton class="btn-flat primary" onClick="searchQuery();return false;">搜 索</buuton>
		</form>
	</div>
	
	<div class="row-fluid">
		<div class="outline">
			<!-- 头部  -->
			<ul id="myTab" class="nav nav-tabs">
              <li class="active"><a href="#turnOut" data-toggle="tab">转出记录</a></li>
              <li class=""><a href="#overTo" data-toggle="tab">转入记录</a></li>
            </ul>
 
			<div class="tab-content">
			  <!-- 转出的容器 -->
			  <div class="tab-pane active" id="turnOut">
			  <!-- 转出记录列表 -->
				<div class="row-fluid">
					<div class="sub_content">
						<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
						<div id="table_list" class="gri_wrapper" style="padding:0px;"></div>
					</div>
				</div>
			  </div>
			  <!-- 转入的容器 -->
			  <div class="tab-pane" id="overTo">
				 <!-- 转入记录列表 -->
				<div class="row-fluid">
					<div class="sub_content">
						<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
						<div id="table_toList" class="gri_wrapper" style="padding:0px;"></div>
					</div>
				</div>
			  </div>
			</div>
		</div>
	</div>
	<!-- 新增-->
	<div class="modal fade colsform" id="add" tabindex="-1" role="dialog" aria-hidden="true">	
		<form id="addStudentInstitution" class="form-horizontal valid-form">
			<h4>转机构</h4>
			<input type="hidden" id="coachIdd" value="">
			<div class="modal-content">
				<div class="left">
					<div class="row1">
						<div class="form-controll">
							<label>身份证号码:</label>
							<input type="text" id="idcard" name="idcard" datatype="*"  nullmsg="身份证号不能为空" sucmsg=" " >
							<input type="hidden" name="id" id="id" value="">
							<input type="hidden" name="insId" id="insId" value="
							<sec:authentication property="principal.insId"/>">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>学员姓名:</label>
							<input type="text" id="studentName" name="studentName" datatype="*"  nullmsg="学员名称不能为空" sucmsg=" " >
						</div>
					</div>
							<div class="row1">
						<div class="form-controll">
							<label>新培训机构编号:</label>
							<input type="text" id="newinscode" name="newinscode" datatype="*"  nullmsg="新培训机构编号不能为空" sucmsg=" " >
						</div>
					</div>
				</div>
			</div>	
			<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="save();">保存</button>
			</div>
		</form>
	</div>
	<script type="text/javascript">
	var id= '<sec:authentication property="principal.id"/>';
	var insId= '<sec:authentication property="principal.insId"/>';
	var statId= '<sec:authentication property="principal.stationId"/>';
		//标识当前页面的url 用来设置当前菜单标识
		var dataTable = null;
		//初始化 
		$(document).ready(function() {
			//初始化界面  完成后调用buildData方法
			MTA.Util.setParams('insId', insId);
			MTA.Report.initialize(null, 'buildData');
		});

		function buildData() {
			$("#time1").val(''); 
			$("#time2").val(''); 
			buildDataTable();
			buildDataTable1();
		}
		/**
		*	搜索
		*/
		function searchQuery() {
			var search = $("#search").val();
			MTA.Util.setParams('searchText', search);
			buildDataTable();
			buildDataTable1();
		}
		/**
		*	转出记录构建列表
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
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<span data-id="');
						td.push(record.id);
						td.push('">');
						td.push(record.stunum);
						td.push('</span>');
						return td.join('');
					}
				},
				'studentName' : {
					'thText' : '学员姓名',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'idcard' : {
					'thText' : '学员身份证号',
					'number' : false,
					'needOrder' : false, 
					'precision' : 0,
				},
				'sex' : {
					'thText' : '学员性别',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<ul class="info">');
							td.push('<li>');
							if(value==1){
								td.push('男');
							}else if(value ===2){
								td.push('女');
							}
							td.push('<li>');
						td.push('</ul>');
						return td.join('');
					}
				},
				'toInsId' : {
					'thText' : '新机构编号',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'insName' : {
					'thText' : '新机构名称',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'createTime' : {
					'thText' : '操作时间',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				}
			};
			var url = '${ctx}/studentChangeStation/list?insId='+insId;
			if(statId === 'null'){
				url = '${ctx}/studentChangeStation/list?insId='+insId;
			}else{
				url = '${ctx}/studentChangeStation/list?insId='+insId+'&stationId='+statId;
			}
			//ajax的数据请求参数
			config['page'] = {
				'url' : "${ctx}/studentInstitution/list",
				'size' : 1000,
				'ifRealPage' : 0
			};
			//初始化 并通过ajax加载数据
			dataTable = MTA.Data.loadAjaxPageTable(config);
		}
		
		
		
		/**
		*	转入记录构建列表
		*/
		function buildDataTable1() {

			var config = {
				'container' : 'table_toList'
			};
			//定义列表的列
			config['allFields'] = {
				'stunum' : {
					'thText' : '学员编号',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<span data-id="');
						td.push(record.id);
						td.push('">');
						td.push(record.stunum);
						td.push('</span>');
						return td.join('');
					}
				},
				'studentName' : {
					'thText' : '学员姓名',
					'number' : false,
					'needOrder' : false, 
					'precision' : 0,
				},
				'idcard' : {
					'thText' : '学员身份证号',
					'number' : false,
					'needOrder' : false, 
					'precision' : 0,
				},
				'sex' : {
					'thText' : '学员性别',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<ul class="info">');
							td.push('<li>');
							if(value==1){
								td.push('男');
							}else if(value ===2){
								td.push('女');
							}
							td.push('<li>');
						td.push('</ul>');
						return td.join('');
					}
				},
				'fromInsId' : {
					'thText' : '原机构编号构编号',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'insName' : {
					'thText' : '原机构名称',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'createTime' : {
					'thText' : '操作时间',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'id' : {
					'thText' : '操作',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'width' : '150px',
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<button class="btn btn-success" onclick="upRecord('+ record.studentId +')">备案</button>');
						return td.join('');
					}
				}
			};
			var url = '${ctx}/studentChangeStation/list?insId='+insId;
			if(statId === 'null'){
				url = '${ctx}/studentChangeStation/list?insId='+insId;
			}else{
				url = '${ctx}/studentChangeStation/list?insId='+insId+'&stationId='+statId;
			}
			//ajax的数据请求参数
			config['page'] = {
				'url' : "${ctx}/studentInstitution/toList",
				'size' : 1000,
				'ifRealPage' : 0
			};
			//初始化 并通过ajax加载数据
			dataTable = MTA.Data.loadAjaxPageTable(config);
		}
		/**
		*	接收学员
		*/
		function receive(studentId,ids,studentName)  {
			//弹出提示框 让用户确认停用
			var dialog = new GRI.Dialog({
				type : 4,
				title : '接收学员',
				content : '确定接收【'+studentName+'】学员吗？',
				deGRIil : '',
				btnType : 1,
				extra : {
					top : 250
				},
				winSize : 1
			}, function() {
				//用户点了停用的确认信息
				$.ajax({
					type : "post",
					url : "${ctx}/studentChangeStation/manage/" + ids + "/1/"+studentId,
					data : "{}",
					contentType : "application/json; charset=utf-8",
					dataType : "json",
					success : function(data) {
						if(data.code==200){
							buildData();
						}
					},
					error : function(msg) {
						alert(msg);
					}
				}); 
			});
		}
	
		function upRecord(id) {
			//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
			$.getJSON("${ctx}/student/" + id, function(result) {
				var data = result.data;
				if (data.isCountry == 1) {
					//弹出提示框 让用户确认删除
					var dialog = new GRI.Dialog({
						type : 4,
						title : '上传备案',
						content : '确定上传【' + data.name + '】学员信息备案吗？',
						deGRIil : '',
						btnType : 1,
						extra : {
							top : 250
						},
						winSize : 1
					}, function() {
						var fileParam = {
							"type" : 'stuimg',
							"url" : data.photo,
							"level" : 2
						};
						//发送数据到后端保存
						$.post(recordUrl + '/upload/file/url', fileParam, function(urlResult) {
							if (urlResult.errorcode == 0) {
								//时间判断函数
								function pad2(n) {
									return n < 10 ? '0' + n : n
								}
								//驾驶证初领日期
								var provinceFstdrilicdate;
								if (data.fingerprint != null) {
									var date = new Date(data.fingerprint);
									var provinceFstdrilicdate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2(date.getDate())
								}
								//报名时间
								var provinceApplydate;
								if (data.applydate != "") {
									var date = new Date(data.applydate);
									var provinceApplydate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2(date.getDate())
								}
								//定义提交到服务端的数据对象
								var params = {
									'inscode' : insCode,
									'stunum' : data.stunum,
									'cardtype' : data.cradtype,
									"idcard" : data.idcard,
									"nationality" : data.nationality,
									"name" : data.name,
									"sex" : data.sex,
									"phone" : data.mobile,
									"address" : data.address,
									"photo" : urlResult.data.id,
									"fingerprint" : data.fingerprint,
									"busitype" : data.busitype,
									"drilicnum" : data.drilicnum,
									"fstdrilicdate" : provinceFstdrilicdate,
									"perdritype" : data.perdritype,
									"traintype" : data.traintype,
									"applydate" : provinceApplydate
								};
								//发送数据到后端保存
								$.post(recordUrl + '/province/student', params, function(results) {
									if (results.errorcode == 0) {
										var paramf = {
											'id' : id,
											'isProvince' : 1
										}
										//$.post('${ctx}/student/updateisProvince', paramf, function(result) {
											if (results.code == 200) {
												layer.alert("备案成功");
												//buildDataTable();
											} else {
												layer.alert("备案失败");
											}
										//});
									} else {
										layer.alert(results.message)
									}
								});
							} else {
								layer.alert(urlResult.message);
							}
						});
					});
				} else {
					layer.open({
						title : '提示',
						maxWidth : 900,
						content : '<h4 style="color:red; text-align:center;font-size:20px;">温馨提示</h4>' +
							'<div style="text-align:center;">该学员没有国家平台备案的学员编号,不能上传省平台备案!</br>(在计时平台对接前录入的学员不需要备案)</div>'
					});
				}
			});
		}
	
		/**
		*	接收学员
		*/
		function refuse(ids,studentName)  {
			//弹出提示框 让用户确认
			var dialog = new GRI.Dialog({
				type : 4,
				title : '拒绝接收学员',
				content : '确定拒绝接收【'+studentName+'】学员吗？',
				deGRIil : '',
				btnType : 1,
				extra : {
					top : 250
				},
				winSize : 1
			}, function() {
				//用户点了停用的确认信息
				$.ajax({
					type : "post",
					url : "${ctx}/studentChangeStation/manage/" + ids + "/2",
					data : "{}",
					contentType : "application/json; charset=utf-8",
					dataType : "json",
					success : function(data) {
						if(data.code==200){
							buildData();
						}
					},
					error : function(msg) {
						alert(msg);
					}
				});
			});
		}
		/**
		*	展示编辑表单界面
		*	新增、修改都需要调用该方法打开表单
		*/
		function showEditorModel() {
			//练车场地选择
			$('#ediorForm select[name="toStation"]').append("<option value=''>请选择</option>");
			$(serviceStations).each(function(item){
				$('#ediorForm select[name="toStation"]').append("<option value='" + this.id + "'>" + this.name + "</option>");
			});
			//重置表单
			$('#ediorForm input[name="name"]').val('');
			$('#ediorForm input[name="mobile"]').val('');
			$('#ediorForm input[name="fromStation"]').val('');
			
			$('#editorModal').modal('show');
		}
		
	    /**
		*	学生姓名和电话号码查询
		**/
		function getStudentByMobile(){
			var name = $('#ediorForm input[name="name"]').val();
			var mobile = $('#ediorForm input[name="mobile"]').val();
			var params = {
					name:name,
					mobile:mobile,
					insId:insId
			}
			$.post('${ctx}/student/getStudentByMobile', params, function (result) {
				if(result.code==200){
					$('#ediorForm input[name="name"]').val(result.data.name);
					$('#ediorForm input[name="studentId"]').val(result.data.id);
					$('#ediorForm input[name="mobile"]').val(result.data.mobile);
					$('#ediorForm input[name="stationId"]').val(result.data.stationId);
					$('#ediorForm input[name="fromStation"]').val(result.data.stationName);
				}else{
					new GRI.Dialog({
						type : 4,
						title : '查询学员信息',
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
		}
		
		//保存
		function save() {
			//从form中取参数值
		
			var recordUrl =<custom:properties name='bjxc.user.province'/>;
			//标识当前页面的url 用来设置当前菜单标识
			var insCode = '<sec:authentication property="principal.insCode"/>';
			
			var idcard= $('#idcard').val();
			var studentName= $('#studentName').val();
			var newinscode=$('#newinscode').val();
			// 校验表单是否通过
			if( $("#add .valid-form").Validform().check() != true ){
				
				return
			}
		/* 	buildDataTable();
			buildDataTable1();
			$('#add').modal('hide'); */
        
$.getJSON("${ctx}/studentInstitution/studentService?idcard="+idcard, function(stureult) {
	if (stureult.code == 200) {
		var params = {
				'cardnum' :idcard,
				'name':studentName
			};			
		$.get(recordUrl+'/stuinfoApi', params, function(result) {
			if (result.errorcode == 0) {
				var paramd = {
						'inscode' :newinscode,
						'stunum':result.data.stunum
					};
		 	$.post(recordUrl+'/province/transfer', paramd, function(results) {
				if (results.errorcode == 0) {
								var paramf = {
										'stunum':result.data.stunum
									};
								$.post(recordUrl+'/province/stuinfoquery/get', paramf, function(resultf) {
									if (resultf.errorcode == 0) {
										//  var paramg = {
										//		'stunum':result.data.stunum
										//	};
									//$.post(recordUrl+'/province/traininfo/get', paramg, function(resultg) {
										//	if (resultg.errorcode == 0) {  
												var paramq = {
														'createUserId' : id,
														'studentId' : stureult.data.id,
														'fromInsId' : insId,
														'toInsId' : newinscode
													};
												$.post('${ctx}/studentInstitution/saveOrUpdate', paramq, function (resultd) {
													 if (resultd.code==200) {
															layer.alert('备案成功')
															buildDataTable();
															buildDataTable1();
															$('#add').modal('hide');
												}else{
													layer.alert('备案失败1')	
													return;
												}
											});	
										/* 		}else{
													layer.alert('备案失败2')
												}	
											}); */
										}else{
											layer.alert('备案失败3')
											return;
										}	
									});										
								}else{
									layer.alert('备案失败4')
									return;
								}	
							});	 						
						}else{
							layer.alert('备案失败5')
							return;
						}	
					});
				}     
			})	
		}
		
		
		function changeInstitution(){
			var tool = new toolCtrl();
            tool.clearForm();
            $('#add').modal('show');
		}
		function getStudentName(){
			var studentId = $('#addStudentInstitution input[name="studentId"]').val();
			//定义提交到服务端的数据对象
			var params = {
				'id' : studentId,
				'insId' : insId
			};
			//发送数据到后端保存
			$.get('${ctx}/student/getByStudent',params,function (result) {
				 if (result.code==200) {
					 if(result.data!=null){
						 $('#addStudentInstitution input[name="studentName"]').val(result.data.name);
					 }else{
						 $('#addStudentInstitution input[name="studentName"]').val("没有该学员");
					 }
				}
			});
		}
		function getInstitutionName(){
			var institutionId = $('#addStudentInstitution input[name="insIds"]').val();
			//发送数据到后端保存
			$.get('${ctx}/institutionInfo/'+institutionId,function (result) {
				 if (result.code==200) {
					 if(result.data!=null){
						 $('#addStudentInstitution input[name="insName"]').val(result.data.name);
					 }else{
						 $('#addStudentInstitution input[name="insName"]').val("没有该培训机构");
					 }
				}
			});
		}
	</script>
	<script type="text/javascript">	
		//日历日期多选
	    $('#two-inputs').dateRangePicker({
	        language:'cn',
			separator : ' to ',
			
			getValue: function()
			{
				if ($('#time1').val() && $('#time2').val() )
					return $('#time1').val() + ' to ' + $('#time2').val();
				else
					return '';
			},
			setValue: function(s,s1,s2)
			{
				$('#time1').val(s1);
				$('#time2').val(s2);
			}
		});
				
	</script>
</body>
</html>