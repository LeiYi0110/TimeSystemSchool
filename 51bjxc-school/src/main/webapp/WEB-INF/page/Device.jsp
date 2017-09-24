<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-计时终端管理</title>
<script type="text/javascript" src="${ctx}/resources/js/jquery-form.js"></script>
<script src="${ctx}/resources/uploadify/jquery.uploadify.js"></script>
<link type="text/css" href="${ctx}/resources/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
<script type="text/javascript" src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script src="http://webapi.amap.com/maps?v=1.3&key=85e0a18ddc6ebb0ecb7efb35e8b73cbd"></script>
<script type="text/javascript" src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<%@ include file="/meta/meta-tag.jsp"%>
</head>
<body>
	<div class="container-fluid new-admin">
		<div class="select-top">
		<sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
			<a class="select-btn" onclick="showEditorModel();"><span class="add"></span>新增</a> 
			<a class="select-btn" onclick="updateEditorModel();"><span class="edit"></span>修改</a> 
			<a class="select-btn " onClick="deletes()"><span class="del"></span>删除</a> 
			<a class="select-btn" onClick="uploadevice()"><span class="spare"></span>备案</a>
			<a class="select-btn" data-toggle="modal" onclick="uploadAll();"><span class="spare"></span>批量备案</a>
			<a class="select-btn" onClick="bindingcar()"><span class="spare"></span>绑定教练车</a>
			<a class="select-btn" onClick="uploadbindingcar()"><span class="spare"></span>备案绑定信息</a>
			<a class="select-btn" id="uploadCoachExcId" onclick="clickFile()"><span class="Import"></span>导入</a>
			<a class="select-btn" onclick="exportFile();"><span class="Export"></span>导出</a>
		</sec:authorize>
		
		<sec:authorize access="hasRole('ROLE_SCHOOL_SERVICE')">
			<sec:authorize access="hasRole('ROLE_UserOperation_89')">
				<a class="select-btn" onclick="showEditorModel();"><span class="add"></span>新增</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_90')"> 
				<a class="select-btn" onclick="updateEditorModel();"><span class="edit"></span>修改</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_91')"> 
				<a class="select-btn " onClick="deletes()"><span class="del"></span>删除</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_92')"> 
				<a class="select-btn" onClick="uploadevice()"><span class="spare"></span>备案</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_93')">
				<a class="select-btn" data-toggle="modal" onclick="uploadAll();"><span class="spare"></span>批量备案</a>
			</sec:authorize>	
			<sec:authorize access="hasRole('ROLE_UserOperation_94')">
				<a class="select-btn" onClick="bindingcar()"><span class="spare"></span>绑定教练车</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_95')">
				<a class="select-btn" onClick="uploadbindingcar()"><span class="spare"></span>备案绑定信息</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_96')">
				<a class="select-btn" id="uploadCoachExcId" onclick="clickFile()"><span class="Import"></span>导入</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_97')">
				<a class="select-btn" onclick="exportFile();"><span class="Export"></span>导出</a>
			</sec:authorize>
		</sec:authorize>
		</div>
	</div>
	<div class="TermSearch">
		<form>
			 <input
				class="input1 win200" type="text" id="search"
				placeholder="计时终端类型/生产厂家/终端型号/安装日期">
			<buuton class="btn-flat primary"
				onClick="searchQuery();return false;">搜 索</buuton>
		</form>
	</div>
	<div style="display: none">
		<form method="POST" enctype="multipart/form-data" id="uploadExcId"
			action="${ctx}/device/InsertDeviceToDB">
			<input id="upfile" type="file" name="upDevicefile"
				onchange="clickAjaxSubmit()" /> <input type="button"
				id="ajaxUploadId" />
		</form>
	</div>

	<!-- <a class="btn-flat small" style="margin-right: 50px;" onClick="searchQuery();return false;">查询</a>  -->

	<div class="sub_content">
		<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
		<div id="table_list" class="gri_wrapper"></div>
	</div>
	
	<!-- <a class="brand" href="/bjxc-school/school"><img src="/bjxc-school/resources/img/logo.png" style="height:40px;"/>
			<span id="insid-label">&#28145;&#22323;&#24066;&#37239;&#21830;&#26102;&#20195;&#31185;&#25216;&#26377;&#38480;&#20844;&#21496;</span>
			批量备案id，临时用
			<div style="display:none" id="batch"></div>
	</a> -->

        <input type="hidden" name="id" id="id">
	<div class="modal fade colsform " tabindex="-1" id="editorModal"
		role="dialog" aria-hidden="true" style="width: 370px; margin-left:-185px;">
		<form class="form-horizontal valid-form" id="ediorForm">
			<h4>计时终端管理</h4>
			<div class="modal-content">
					<div class="row1">
						<div class="form-controll" style="margin-right: auto; width: 100%;">
						<label>计时终端类型:</label> 
						<input type="radio" name="termtype" value="1" style="margin:0 3px 0 0;" checked="checked" datatype="*" nullmsg="请选择计时终端类型" sucmsg=" ">车载计程
						<input type="radio" name="termtype" value="2" style="margin:0 3px 0 0;">课堂教学
						<span><input type="radio" name="termtype" value="3" style="margin:0 3px 0 0;">模拟训练</span>
						</div>
				    </div>
				    <div class="row1">
						<div class="form-controll" style="margin-right: auto; width: 100%;">
							<label>终端出厂序列号:</label> <input type="text" name="sn" datatype="*" nullmsg="终端出厂序列号不能为空" sucmsg=" ">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll" style="margin-right: auto; width: 100%;">
							<label>生产厂家:</label> <input type="text" id="vender" name="vender" datatype="*" nullmsg="生产厂家不能为空" sucmsg=" ">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll" style="margin-right: auto; width: 100%;">
							<label>终端型号:</label> <input type="text" name="model" datatype="*" nullmsg="终端型号不能为空" sucmsg=" ">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll" style="margin-right: auto; width: 100%;" >
							<label>IMEI号或设备MAC地址:</label> <input type="text" class="input-imei" name="imei" datatype="*" nullmsg="IMEI号或设备MAC地址不能为空" sucmsg=" ">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll" style="margin-right: auto; width: 100%;" >
							<label>安装日期:</label> <input type="text" class="form_date input1 win90" id="installDateId96"
								data-date-format="yyyy-mm-dd" placeholder="请选择安装日期" readonly="readonly" name="installDate" >
						</div>
					</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" onClick="saves();">保存</button>
			</div>
		</form>
	</div>


	<!-- 终端位置 -->
	<div class="modal fade colsform log-spare" id="place" tabindex="-1" role="dialog" aria-hidden="true" style="width:1000px;margin-left:-500px;">
		<h4>实时位置</h4>
		<div id="locus-map" style="height:450px;"></div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		</div>
	</div>

 
 <!-- 修改 -->
	<div class="modal fade colsform " tabindex="-1" id="updateModal"
		role="dialog" aria-hidden="true" style="width:370px; margin-left:-185px;">
		<form class="form-horizontal" id="updateForm">
			<h4>计时终端管理</h4>
			<div class="modal-content">
					<div class="row1">
						<div class="form-controll" style="margin-right: auto; width: 100%;">
						<label>计时终端类型:</label> 
						<span style="padding-right:5px;"><input type="radio" name="utermtype" value="1" style="margin:0 3px 0 0;">车载计程</span>
						<span style="padding-right:5px;"><input type="radio" name="utermtype" value="2" style="margin:0 3px 0 0;">课堂教学</span>
						<span><input type="radio" name="utermtype" value="3" style="margin:0 3px 0 0;">模拟训练</span>
						</div>
						</div>
							<div class="row1">
						<div class="form-controll"  style="margin-right: auto; width: 100%;">
							<label>计时终端编号:</label> <input type="text" name="udevnum" id="udevnum" readonly="readonly">
						</div>
					</div>
						<div class="row1">
						<div class="form-controll"  style="margin-right: auto; width: 100%;">
							<label>终端出厂序列号:</label> <input type="text" name="usn">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll"  style="margin-right: auto; width: 100%;">
							<label>生产厂家:</label> <input type="text" id="uvender"
								name="uvender">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll"  style="margin-right: auto; width: 100%;">
							<label>终端型号:</label> <input type="text" name="umodel">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll"  style="margin-right: auto; width: 100%;">
							<label>IMEI号或设备MAC地址:</label> <input type="text" name="uimei">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll" style="margin-right: auto; width: 100%;" >
							<label>安装日期:</label> <input type="text" class="form_date input1 win90" id="installDateId155"
								data-date-format="yyyy-mm-dd" placeholder="请选择安装日期" readonly="readonly" name="installDate155" >
						</div>
					</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" onClick="updates();">修改</button>
			</div>
		</form>
	</div>
	<div class="modal fade colsform" id="errorId" tabindex="-1" role="dialog"  aria-hidden="true">
		<div class="modal-content">
			<div class="modal-content" id="innerListId"></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
	
	<div class="modal fade colsform " tabindex="-1" id="bindcar"
		role="dialog" aria-hidden="true" style="width:370px; margin-left:-185px;">
		<form class="form-horizontal" id="updateForm">
			<h4>绑定教练车</h4>
			<div class="modal-content">
					<div class="row1">
						<div class="form-controll"  style="margin-right: auto; width: 100%;">
							<label>计时终端编号:</label> <input type="text" name="devnumss" readonly="readonly">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll"  style="margin-right: auto; width: 100%;">
							<label>sim:</label> <input type="text" name="simss">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll"  style="margin-right: auto; width: 100%;">
							<label>教练车编号:</label> <input type="text" name="carnum">
						</div>
					</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" onClick="bind();">绑定</button>
			</div>
		</form>
	</div>
	<div class="modal fade colsform" id="errorId" tabindex="-1" role="dialog"  aria-hidden="true">
		<div class="modal-content">
			<div class="modal-content" id="innerListId"></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		var recordUrl = <custom:properties name='bjxc.user.province'/>;
		//标识当前页面的url 用来设置当前菜单标识
		var insId = '<sec:authentication property="principal.insId"/>';
		var insCode = '<sec:authentication property="principal.insCode"/>';
	
		function clickFile() {
			$("#upfile").click();
		}
		function clickAjaxSubmit() {
			$('#ajaxUploadId').click();
		}
	
		var dataTable = null;
		//初始化 
		$(document).ready(function() {
			//初始化界面  完成后调用buildData方法
			MTA.Report.initialize(null, 'buildData');
	
			//ajax 方式上传文件操作
			$('#ajaxUploadId').click(function() {
				if (checkData()) {
					$('#uploadExcId').ajaxSubmit({
						url : '${ctx}/device/InsertDeviceToDB',
						dataType : 'json',
						success : function resutlMsg(result) {
							$("#upfile").val("");
							if (result.code == 200) {
								alert("导入数据成功!")
								//保存成功 刷新列表
								buildDataTable();
							}
							else {
								$("#innerListId").empty();
								var errorList = result.errorList;
								var html = '';
								for (var i = 0; i < errorList.length; i++) {
									html += errorList[i] + '<br/>';
								}
								$("#innerListId").append(html);
								$("#errorId").modal('show');
							}
						},
						error : function errorMsg() {
							$("#upfile").val("");
							alert(result.message);
						}
					});
				}
			});
		});
		//JS校验form表单信息  
		function checkData() {
			var fileDir = $("#upfile").val();
			var suffix = fileDir.substr(fileDir.lastIndexOf("."));
			if ("" == fileDir) {
				alert("选择需要导入的Excel文件！");
				return false;
			}
			if (".xls" != suffix && ".xlsx" != suffix) {
				alert("选择Excel格式的文件导入！");
				return false;
			}
			return true;
		}
	
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
		var insId = '<sec:authentication property="principal.insId"/>';
		var insCode = '<sec:authentication property="principal.insCode"/>';
		function buildDataTable() {
			var config = {
				'container' : 'table_list'
			};
			//定义列表的列
			config['allFields'] = {
				'devnum' : {
					'thText' : '计时终端编号',
					'number' : false,
					'colAlign' : 'left',
					'thAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
						columnIndex) {
						var td = [];
						td.push('<span data-id="');
						td.push(record.id);
						td.push('">');
						td.push(record.devnum);
						td.push('</span>');
						return td.join('');
					}
				},
				'termtype' : {
					'thText' : '计时终端类型',
					'number' : false,
					'colAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
						columnIndex) {
						td = [];
						if (value == 1) {
							td.push('车载计程计时终端');
						}
						else if (value == 2) {
							td.push('课堂教学计时终端');
						}
						else if (value == 3) {
							td.push('模拟训练计时终端');
						}
						return td.join('');
					}
				},
				'vender' : {
					'thText' : '生产厂家',
					'number' : false,
					'colAlign' : 'left',
					'thAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
				},
				'model' : {
					'thText' : '终端型号',
					'number' : false,
					'colAlign' : 'left',
					'thAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
				},
				'installDate' : {
					'thText' : '安装日期',
					'number' : false,
					'colAlign' : 'left',
					'thAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
				},
				'imei' : {
					'thText' : '终端IMEI号或设备MAC地址',
					'number' : false,
					'colAlign' : 'left',
					'thAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
				},
				'sn' : {
					'thText' : '终端出厂序列号',
					'number' : false,
					'colAlign' : 'left',
					'thAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
				},
				'licnum' : {
					'thText' : '绑定教练车',
					'number' : false,
					'colAlign' : 'left',
					'thAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
				},
				'isProvince' : {
					'thText' : '是否省备案',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
						columnIndex) {
						td = [];
						if (value == 1) {
							td.push('是');
						}
						else {
							td.push('否 ');
						}
						return td.join('');
					}
				},
				'id' : {
					'thText' : '操作',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'width' : '150px',
					'render' : function(value, cellmeta, record, rowIndex,
						columnIndex) {
						if (record.isProvince != 1) {
							$("#batch").append(record.id + ",");
						}
						var td = [];
						if (record.licnum != null) {
							td.push("<button class='btn btn-success' onClick='offbind(" + record.signid + ","
								+ record.devnum + "," + record.sim + "," + record.carnum + ");'>解除绑定</button>");
							
						}
						td.push("<button class='btn btn-success' onClick='findLocal(" + record.id + ");'>终端位置</button>");
						return td.join('');
					}
				}
			};
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/device/list?insId=' + insId,
				'size' : 10,
				'ifRealPage' : 1
			};
			//初始化 并通过ajax加载数据
			dataTable = MTA.Data.loadAjaxPageTable(config);
		}
	
		/**
		 *	显示终端实时位置
		 */
		function findLocal(id) {
			$.get('${ctx}/device/findLocal/'+id,function(result){
				console.log(result);
				place([ result.data.longtitude, result.data.latitude ]);
			})
			
		}
	
		function place(position) {
			$("#place").modal('show');
			var t1 = window.setTimeout(function() {
			var map = new AMap.Map("locus-map", {});
			/* 生成地图  */
			map.setZoomAndCenter(15, position);
	
			new AMap.Marker({
				map : map,
				position : position,
				icon : new AMap.Icon({
					size: new AMap.Size(32,32),  //图标大小
           	 		image: "http://img.91ygxc.com/2017/01/18/54306951-359d-46c5-ab7b-18d36a419c3e_s.png"
					//imageOffset : new AMap.Pixel(0, -60)
				})
			});
			window.clearTimeout(t1);
		}, 350);
	}

		/**
		 *	展示编辑表单界面
		 *	新增、修改都需要调用该方法打开表单
		 */
		function showEditorModel() {
			//重置表单
			 var tool = new toolCtrl();
	           tool.clearForm();
			$('input[name="id"]').val('');
			$('#ediorForm input[name="vender"]').val('');
			$('#ediorForm input[name="model"]').val('');
			$('#ediorForm input[name="imei"]').val('');
			$('#ediorForm input[name="licnum"]').val('');
			$('#ediorForm input[name="sn"]').val('');
			$('#ediorForm input[name="termtype"][value=1]').prop("checked",true);
			$('#carId').val('');

			$('#editorModal').modal('show');
		}

		$(function() {
			$("#licnum").bigAutocomplete({
				url : '${ctx}/device/getCar?insId=' + insId,
				callback : function(data) {
					$("#carId").val(data.result);
				}
			});
		});
		//保存
		function saves() {
			
			if( $("#editorModal .valid-form").Validform().check() == true ){  
			//从form中取参数值
			var id = $('#ediorForm input[name="id"]').val();
			var vender = $('#ediorForm input[name="vender"]').val();
			var model = $('#ediorForm input[name="model"]').val();
			var imei = $('#ediorForm input[name="imei"]').val();
			var sn = $('#ediorForm input[name="sn"]').val();
			var carId = $('#carId').val();
			var termtype = $('#ediorForm input[name="termtype"]:checked').val();
			var installDate=$('#installDateId96').val();
			if (vender == "" || model == "" || imei == "" || sn == ""
					|| carId == "" || termtype == "") {
				alert("请填写完所有必要信息！");
				return false;
			}
			
			//自动备案判断
			if(isTimeSystem()){
			var param = {
				'termtype' : termtype,
				'vender' : vender,
				'model' : model,
				'imei' : imei,
				'sn' : sn,
			};
 
			$.post(recordUrl+'/country/device', param, function(result) {
			/* console.log(result);
			console.log(result.message=="");
				if(result.message!=""){
					layer.alert(result.message);
				} */
				if (result.errorcode == 0) {
					 var params = {					
						'id' : id,
						'insId':insId,
						'termtype' : termtype,
						'vender' : vender,
						'model' : model,
						'imei' : imei,
						'sn' : sn,
						'devnum': result.data.devnum,
						'key': result.data.key,
						'passwd': result.data.passwd,
						'carId' : carId,
						'installDate':installDate
						}; 
					//发送数据到后端保存
					 $.post('${ctx}/device/saveOrUpdate', params, function(results) {
						if (results.code == 200) {
							//关闭编辑的表单
							layer.alert("保存成功");
							$('#editorModal').modal('hide');
						}else{
							layer.alert('保存失败')
						}	
						buildDataTable();
					});  
				} else {
					layer.alert(result.message);
				}
			}) 
		}else{
			 var params = {					
						'id' : id,
						'insId':insId,
						'termtype' : termtype,
						'vender' : vender,
						'model' : model,
						'imei' : imei,
						'sn' : sn			
						}; 
					//发送数据到后端保存
					 $.post('${ctx}/device/saveOrUpdate', params, function(
							results) {
						if (results.code == 200) {
							//关闭编辑的表单
							layer.alert('保存成功');
							$('#editorModal').modal('hide');
						}else{
							layer.alert('保存失败')
						}	
						buildDataTable();
					});
				}
			}
		}

		function updateEditorModel(id) {
			//重置表单
			var id=sessionStorage.getItem('tabId')
			
			if(id === null || id === undefined){
				alert('未选择目标');
			}else{
			$('input[name="id"]').val('');
			$('input[name="utermtype"][value="1"]').removeAttr("checked");
			$('input[name="utermtype"][value="2"]').removeAttr("checked");
			$('input[name="utermtype"][value="3"]').removeAttr("checked");	
			$('#updateForm input[name="utermtype"]:checked').val();
			$('#updateForm input[name="udevnum"]').val('');
			$('#updateForm input[name="uvender"]').val('');
			$('#updateForm input[name="umodel"]').val('');
			$('#updateForm input[name="uimei"]').val('');
			$('#updateForm input[name="ulicnum"]').val('');
			$('#updateForm input[name="usn"]').val('');
			$('#carId').val('');
			$("#installDateId155").val('');
			if (id) {
				//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
				$.getJSON("${ctx}/device/" + id,
								function(result) {
									if (result.code == 200) {
										var data = result.data;
										$('input[name="id"]').val(
												data.id);
										$('#updateForm input[name="uvender"]')
												.val(data.vender);
										$('#updateForm input[name="umodel"]')
												.val(data.model);
										$('#updateForm input[name="uimei"]')
												.val(data.imei);
										$('#updateForm input[name="udevnum"]')
										.val(data.devnum);
										$('#updateForm input[name="ulicnum"]')
												.val(data.licnum);
										$('#carId').val(data.carId);
										$('#updateForm input[name="usn"]').val(
												data.sn);
										$("#updateForm	input[name='utermtype'][value="
												+ data.termtype + "]")
										.prop("checked", true);
										$("#installDateId155").val(data.installDate);
									}
									
								});
			}
			$('#updateModal').modal('show');
		}
	}

		//修改
		function updates() {
			//从form中取参数值
			var id = $('input[name="id"]').val();
			var vender = $('#updateForm input[name="uvender"]').val();
			var model = $('#updateForm input[name="umodel"]').val();
			var imei = $('#updateForm input[name="uimei"]').val();
			var sn = $('#updateForm input[name="usn"]').val();
			var carId = $('#carId').val();
			var termtype = $('#updateForm input[name="utermtype"]:checked').val();
			var installDate=$('#installDateId155').val();

			var param = {
					'id' : id,
					'termtype' : termtype,
					'vender' : vender,
					'model' : model,
					'imei' : imei,	
					'sn' : sn,
					'carId' : carId,
					'installDate':installDate
				};
					//发送数据到后端保存
					$.post('${ctx}/device/saveOrUpdate', param,
							function(result) {
								if (result.code == 200) {
									//保存成功 刷新列表
									buildDataTable();
									//关闭编辑的表单
									layer.alert('保存成功')
									$('#updateModal').modal('hide');
								}else{
									layer.alert('保存失败')
								}
							});
					
		}
		
		
		
		
		function deletes(){
			var id = sessionStorage.getItem('tabId');
			if(id === null || id === undefined){
				alert('未选择目标');
			}else{
				if(isTimeSystem()){			
			$.getJSON("${ctx}/device/" + id, function(result) {
				if (result.code == 200) {
					var data = result.data;
						var gnl = confirm("阳光驾培温馨提示,您确定要删除吗?");
						if (gnl == true) {
							//定义提交到服务端的数据对象
							var params = {
								'devnum' :data.devnum 
							};
							//发送数据到后端保存
							$.post(recordUrl+'/province/device/delete', params,
									function(provinceresult) {
										if (provinceresult.errorcode == 0) {
											var paramd={
												'id':id	
											}
											$.post('${ctx}/device/deletes', paramd, function(result) {
												if (result.code == 200) {
													layer.alert('删除成功');	
													//保存成功 刷新列表
													buildDataTable();
												}else{
													layer.alert('删除失败')
												}	
											});
										}else{
											layer.alert('删除上传省备案失败')
										}
									});
							return true;
						} else {
							return false
						}
				}
			})
		}else{
			if (id === null || id === undefined) {
				alert('未选择目标');
			} else {
				var gnl = confirm("阳光驾培温馨提示,您确定要删除吗?");
				if (gnl == true) {
					//定义提交到服务端的数据对象
					var paramf = {
						'id' : id
					}
					$.post('${ctx}/device/deletes', paramf, function(
							result) {
						if (result.code == 200) {
							layer.alert('删除成功');
							//保存成功 刷新列表
							buildDataTable();
						} else {
							layer.alert('删除失败')
						}
					});
					return true;
				} else {
					return false
				}
			}
		}
	}
} 
		
		function bindingcar(){
			var id = sessionStorage.getItem('tabId');
			if(id === null || id === undefined){
				layer.alert('未选择目标');
			}else{
				$('#bindcar input[name="id"]').val("");
				$('#bindcar input[name="id"]').val(id);
				$('#bindcar input[name="devnumss"]').val("");
				$('#bindcar input[name="simss"]').val("");
				$('#bindcar input[name="licnumss"]').val("");
				$.getJSON("${ctx}/device/" + id, function(result) {
					if (result.code == 200) {
						console.log(result);
						$('#bindcar input[name="devnumss"]').val(result.data.devnum);
						$('#bindcar').modal('show');
					}
				})
			}
		}
		
		function bind(){
			var devnum=$('#bindcar input[name="devnumss"]').val();
			var sim=$('#bindcar input[name="simss"]').val();
			var carnum=$('#bindcar input[name="carnum"]').val();
			var param={
				'devnum' : devnum,
				'sim' : sim,
				'carnum' : carnum,
			};
			$.post(recordUrl+"/province/devassign",param,function(result){	<!--省平台绑定-->
				console.log(result);
				if(result.errorcode==0){
					$.get("${ctx}/device/addDevassign",param,function(results){
						
						if(results.code==200){
							layer.alert('绑定成功！');
							//保存成功 刷新列表
							buildDataTable();
							$('#bindcar').modal('hide');
						}else{
							console.log(results);
							layer.alert('绑定失败！');
						}
						
					})
				}else{
					layer.alert(result.message);
				}
			})
		}
		
		function offbind(id,devnum,sim,carnum){
			var param={
				'devnum' : devnum,
				'sim' : sim,
				'carnum' : carnum,
			};
			$.post(recordUrl+"/province/devrembinding",param,function(result){
				if(result.errorcode==0){
					$.get("${ctx}/device/deleteDevassign?id="+id,function(results){
						if(results.code==200){
							layer.alert('解绑成功！');
							//保存成功 刷新列表
							buildDataTable();
						}else{
							console.log(results);
							layer.alert('解绑失败！');
						}
					});
				}else{
					layer.alert(result.message);
				}
			});
		}
		
		function exportFile() {
			window.location.href = "${ctx}/device/exportDevice?insCode="+insCode;
		}
		
		//备案
		function uploadevice(){
			var id = sessionStorage.getItem('tabId');
			if(id === null || id === undefined){
				layer.alert('未选择目标');
			}else{
				$.getJSON("${ctx}/device/" + id, function(result) {
					if (result.code == 200) {
						var data = result.data;
							if(data.isCountry == 1){							
							var gnl = confirm("阳光驾培温馨提示,您确定要备案吗?");
							if (gnl == true) {
								//定义提交到服务端的数据对象
								var params = {
									'devnum' :data.devnum,
									'termtype' :data.termtype,
									'vender' :data.vender,
									'model':data.model,
									'imei':data.imei,
									'sn':data.sn,
									'inscode':insCode,
									'key':data.key,
									'password':data.passwd,
									'installDate':data.installDate
								};
								//发送数据到后端保存
								$.post(recordUrl+'/province/device', params,
										function(provinceresult) {
											if (provinceresult.errorcode == 0) {
												var paramd={
													'id':id,
													'isProvince':1
													 													 
												}
												$.post('${ctx}/device/saveOrUpdate', paramd, function(result) {
													if (result.code == 200) {
														layer.alert('备案成功');	
														//保存成功 刷新列表
														buildDataTable();
													}else{
														layer.alert('备案失败')
													}	
												});
											}else{
												alert(provinceresult.message)
											}
										});
								return true;
							} else {
								return false
							}
							
						}else{
							layer.open({
								  title: '提示',
								  maxWidth:900,
								  content: '<h4 style="color:red; text-align:center;font-size:20px;">温馨提示</h4>'+
								  '<div style="text-align:center;">该计时终端没有国家平台备案的计时终端编号,不能上传省平台备案!</br>(在计时平台对接前录入的计时终端不需要备案)</div>'
								});
						}
					}
				})	
			}
	}
	function uploadbindingcar(){
			var id = sessionStorage.getItem('tabId');
			if(id === null || id === undefined){
				layer.alert('未选择目标');
			}else{
				$.getJSON("${ctx}/device/" + id, function(result) {
					if (result.code == 200) {
						var data = result.data;
							if(data.isCountry == 1){							
							var gnl = confirm("阳光驾培温馨提示,您确定要备案吗?");
							if (gnl == true) {
								//定义提交到服务端的数据对象
								var param={
									'devnum' : data.devnum,
									'sim' : data.sim,
									'carnum' : data.carnum
								};
								$.post(recordUrl+"/province/devassign",param,function(result){	<!--省平台绑定-->
									console.log(result);
									if(result.errorcode==0){
										$.get("${ctx}/device/addDevassign",param,function(results){
											
											if(results.code==200){
												layer.alert('绑定成功！');
												//保存成功 刷新列表
												buildDataTable();
												$('#bindcar').modal('hide');
											}else{
												console.log(results);
												layer.alert('绑定失败！');
											}
											
										})
									}else{
										layer.alert(result.message);
									}
								})
								return true;
							} else {
								return false
							}
							
						}else{
							layer.open({
								  title: '提示',
								  maxWidth:900,
								  content: '<h4 style="color:red; text-align:center;font-size:20px;">温馨提示</h4>'+
								  '<div style="text-align:center;">该计时终端没有国家平台备案的计时终端编号,不能上传省平台备案!</br>(在计时平台对接前录入的计时终端不需要备案)</div>'
								});
						}
					}
				})	
			}
	}
	
	function uploadAll() {
		var batchId=$("#batch").text().split(",");
		console.log(batchId);
		for(var i=0;i<batchId.length-1;i++){
			uploadevice(batchId[i]);
		}
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
	</script>
</body>
</html>