<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ include file="/meta/meta-tag.jsp"%>


<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-教练车管理</title>
<script src="${ctx}/resources/uploadify/jquery.uploadify.js"></script>
<link type="text/css"
	href="${ctx}/resources/css/bootstrap-datetimepicker.min.css"
	rel="stylesheet" />
<script type="text/javascript"
	src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript"
	src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery-form.js"></script>
</head>
<body>
	<div class="container-fluid new-admin">
		<div class="select-top">
		<sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
			<a class="select-btn" data-toggle="modal" onClick="showEditorModel();"><span class="add"></span>新增</a> 
			<a class="select-btn" data-toggle="modal" onClick="UpdateEditorModel();"><span class="update"></span>修改</a> 
			<a class="select-btn " onClick="deletes()"><span class="del"></span>删除</a>
			<a class="select-btn" onClick="uploadRecord()"><span class="spare"></span>备案</a> 
			<a class="select-btn" onClick="uploadAll()"><span class="spare"></span>批量备案</a> 
			<a class="select-btn" id="uploadCoachExcId" onclick="clickFile()"><span class="Import"></span>导入</a>
			<a class="select-btn" onclick="exportFile();"><span class="Export"></span>导出</a>
		</sec:authorize>
		
		<sec:authorize access="hasRole('ROLE_SCHOOL_SERVICE')">
			<sec:authorize access="hasRole('ROLE_UserOperation_81')">
				<a class="select-btn" data-toggle="modal" onClick="showEditorModel();"><span class="add"></span>新增</a> 
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_82')">
				<a class="select-btn" data-toggle="modal" onClick="UpdateEditorModel();"><span class="update"></span>修改</a>
			</sec:authorize>	
			<sec:authorize access="hasRole('ROLE_UserOperation_83')"> 
				<a class="select-btn " onClick="deletes()"><span class="del"></span>删除</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_84')">
				<a class="select-btn" onClick="uploadRecord()"><span class="spare"></span>备案</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_85')"> 
				<a class="select-btn" onClick="uploadAll()"><span class="spare"></span>批量备案</a> 
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_86')">
				<a class="select-btn" id="uploadCoachExcId" onclick="clickFile()"><span class="Import"></span>导入</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_87')">
				<a class="select-btn" onclick="exportFile();"><span class="Export"></span>导出</a>
			</sec:authorize>
		</sec:authorize>
		</div>
	</div>

	<div class="TermSearch">
		<form>
			<input class="input1 win200" type="text" id="search"
				placeholder="车牌号/车辆品牌/培训车型">
			<buuton class="btn-flat primary"
				onClick="searchQuery();return false;">搜 索</buuton>
		</form>
	</div>
	<div style="display: none">
		<form method="POST" enctype="multipart/form-data" id="uploadExcId"
			action="${ctx}/trainingCar/InsertTrainingCarToDB">
			<input id="upfile" type="file" name="upTrainingCarfile"
				onchange="clickAjaxSubmit()" /> <input type="button"
				id="ajaxUploadId" />
		</form>
	</div>

	<!-- <a class="btn-flat small" style="margin-right: 50px;" onClick="searchQuery();return false;">查询</a>  -->

	<div class="sub_content">
		<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
		<div id="table_list" class="gri_wrapper"></div>
	</div>


	<!-- 
<a class="btn-flat small" style="margin-right: 50px;"
							onClick="searchQuery();return false;">查询</a> -->
	<!-- 新增 -->
	<div class="modal fade colsform " tabindex="-1" id="editorModal"
		role="dialog" aria-hidden="true">
		<form class="form-horizontal valid-form" id="ediorForm">
			<input type="hidden" name="id" />
			<h4>车辆管理</h4>
			<div class="modal-content" style="overflow: hidden;">
				<div class="left">
					<div class="row1">
						<div class="form-controll">
							<label>车架号：</label> <input type="text" name="franum" id="franum">
						</div>
						<div class="form-controll">
							<label>生产厂家：</label> <input type="text" name="manufacture"
								id="manufacture" datatype="*" nullmsg="生产厂家不能为空" sucmsg=" ">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>车牌号：</label> <input type="text" name="licnum" id="licnum"
								datatype="*" nullmsg="车牌号不能为空" sucmsg=" ">
						</div>
						<div class="form-controll">
							<label>车辆品牌：</label> <input type="text" name="brand" id="brand"
								datatype="*" nullmsg="车辆品牌不能为空" sucmsg=" ">
						</div>
					</div>

					<div class="row1">
						<div class="form-controll">
							<label>发动机号：</label> <input type="text" name="engnum" id="engnum">
						</div>
						<div class="form-controll">
							<label>培训车型：</label> <select name="perdritype" id="perdritype"
								datatype="*" nullmsg="培训车型不能为空" sucmsg=" " style="width: 174px;">
								<option value=" ">请选择</option>
								<option value="A1">A1</option>
								<option value="A2">A2</option>
								<option value="A3">A3</option>
								<option value="B1">B1</option>
								<option value="B2">B2</option>
								<option value="C1">C1</option>
								<option value="C2">C2</option>
								<option value="C3">C3</option>
								<option value="C4">C4</option>
								<option value="C5">C5</option>
								<option value="D">D</option>
								<option value="E">E</option>
								<option value="F">F</option>
								<option value="M">M</option>
								<option value="N">N</option>
								<option value="P">P</option>
							</select>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>车辆型号：</label> <input type="text" name="model" id="model"
								datatype="*" nullmsg="车辆型号不能为空" sucmsg=" ">
						</div>
						<div class="form-controll">
							<label>颜色：</label> <input type="radio" name="platecolor"
								id="platecolor" value="1" datatype="*" nullmsg="请选择车辆 颜色"
								sucmsg=" " style="margin: 0 2px 0 0;" checked="checked">蓝色
							<input type="radio" name="platecolor" id="platecolor" value="2"
								style="margin: 0 2px 0 0;">黄色 <input type="radio"
								name="platecolor" id="platecolor" value="3"
								style="margin: 0 2px 0 0;">黑色 <br> <input
								type="radio" name="platecolor" id="platecolor" value="4"
								style="margin: 0 2px 0 0;">白色 <input type="radio"
								name="platecolor" id="platecolor" value="5"
								style="margin: 0 2px 0 0;">绿色 <input type="radio"
								name="platecolor" id="platecolor" value="9"
								style="margin: 0 2px 0 0;">其它
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>购买日期：</label> <input type="text" name="buydate"
								class="form_date" data-date-format="yyyy-mm-dd" datatype="*"
								nullmsg="购买日期不能为空" sucmsg=" " readonly="readonly">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll wid90">
							<label>备注:</label>
							<textarea name="remarks"></textarea>
						</div>
					</div>
				</div>
				<div class="right">
					<div class="rk_swfupload">
						<div style="height: 60px; width: 100px; display: inline-block;">
							<span class="pic">车辆图片<img id="photourl" name="photourl"
								src="" class="img-thumbnail upload-img"></span> <a
								style="margin-top: 20px; width: 100px;" class="btn btn-success">上传</a>
						</div>
						<div class="swfobj swfobj-position">
							<div id="upload_buton_img"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" onClick="saves()">保存</button>
			</div>
			<input type="hidden" name="insId" id="insId"
				value="<sec:authentication property="principal.insId"/>"> <input
				type="hidden" name="photo" id="photo"> <input type="hidden"
				name="carnum" id="carnum">
		</form>
	</div>


	<!-- 修改 -->
	<div class="modal fade colsform " tabindex="-1" id="updateModal"
		role="dialog" aria-hidden="true">
		<form class="form-horizontal" id="updateForm">
			<input type="hidden" name="id" />
			<h4>车辆管理</h4>
			<div class="modal-content" style="overflow: hidden;">
				<div class="left">
					<div class="row1">
						<div class="form-controll">
							<label>教练车编号:</label> <input type="text" datatype="*"
								name="ucarnum" id="ucarnum" readonly="readonly"> <input
								type="hidden" name="isProvince" value="" />
						</div>
						<div class="form-controll">
							<label>车牌号：</label> <input type="text" datatype="*"
								name="ulicnum" id="ulicnum">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>车架号：</label> <input type="text" name="ufranum"
								id="ufranum">
						</div>
						<div class="form-controll">
							<label>生产厂家：</label> <input type="text" name="umanufacture"
								id="umanufacture">
						</div>

					</div>
					<div class="row1">
						<div class="form-controll">
							<label>发动机号：</label> <input type="text" datatype="*"
								name="uengnum" id="uengnum">
						</div>
						<div class="form-controll">
							<label>车辆品牌：</label> <input type="text" datatype="*"
								name="ubrand" id="ubrand">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>车辆型号：</label> <input type="text" datatype="*"
								name="umodel" id="umodel">
						</div>
						<div class="form-controll">
							<label>培训车型：</label> <select name="uperdritype" id="uperdritype"
								style="width: 174px;">
								<option value="0">请选择</option>
								<option value="A1">A1</option>
								<option value="A2">A2</option>
								<option value="A3">A3</option>
								<option value="B1">B1</option>
								<option value="B2">B2</option>
								<option value="C1">C1</option>
								<option value="C2">C2</option>
								<option value="C3">C3</option>
								<option value="C4">C4</option>
								<option value="C5">C5</option>
								<option value="D">D</option>
								<option value="E">E</option>
								<option value="F">F</option>
								<option value="M">M</option>
								<option value="N">N</option>
								<option value="P">P</option>
							</select>
						</div>
					</div>

					<div class="row1">
						<div class="form-controll">
							<label>购买日期：</label><input type="text" name="ubuydate"
								id="ubuydate" class="form_date" data-date-format="yyyy-mm-dd"
								readonly="readonly">
						</div>
						<div class="form-controll">
							<label>颜色：</label> <span style="padding-right: 5px;"><input
								type="radio" name="uplatecolor" id="uplatecolor" value="1"
								style="margin: 0 2px 0 0;"> 蓝色</span> <span
								style="padding-right: 5px;"><input type="radio"
								name="uplatecolor" id="uplatecolor" value="2"
								style="margin: 0 2px 0 0;"> 黄色 </span> <span><input
								type="radio" name="uplatecolor" id="uplatecolor" value="3"
								style="margin: 0 2px 0 0;">黑色 </span> <br> <span
								style="padding-right: 5px;"><input type="radio"
								name="uplatecolor" id="uplatecolor" value="4"
								style="margin: 0 2px 0 0;"> 白色 </span> <span
								style="padding-right: 5px;"><input type="radio"
								name="uplatecolor" id="uplatecolor" value="5"
								style="margin: 0 2px 0 0;"> 绿色</span> <span><input
								type="radio" name="uplatecolor" id="uplatecolor" value="9"
								style="margin: 0 2px 0 0;">其它</span>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll wid90">
							<label>备注:</label>
							<textarea name="uremarks" id="uremarks"></textarea>
						</div>
					</div>
				</div>
				<div class="right">
					<div class="rk_swfupload">
						<div style="height: 60px; width: 100px; display: inline-block;">
							<span class="pic">车辆图片<img id="uphotourl" name="uphotourl"
								src="" class="img-thumbnail upload-img"></span> <a
								style="margin-top: 20px; width: 100px;" class="btn btn-success">上传</a>
						</div>
						<div class="swfobj swfobj-position">
							<div id="aupload_buton_img"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" onClick="updates()">修改</button>
			</div>
			<input type="hidden" name="ucarnum" id="ucarnum">
		</form>
	</div>





	<!-- 详情 -->
	<div class="modal fade colsform " tabindex="-1" id="details"
		role="dialog" aria-hidden="true">
		<form class="form-horizontal" id="detailsForm">
			<h4>车辆管理</h4>
			<div class="modal-content" style="overflow: hidden;">
				<div class="left">
					<div class="row1">
						<div class="form-controll">
							<label>车架号：</label> <input type="text" name="franum"
								readonly="readonly">
						</div>
						<div class="form-controll">
							<label>教练车编号:</label> <input type="text" datatype="*"
								name="carnum" id="carnum" readonly="readonly">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>车牌号：</label> <input type="text" class="span9 inputxt"
								datatype="*" name="licnum" id="licnum" readonly="readonly">
						</div>
						<div class="form-controll">
							<label>生产厂家：</label> <input type="text" name="manufacture"
								readonly="readonly">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>发动机号：</label> <input type="text" datatype="*"
								name="engnum" readonly="readonly">
						</div>
						<div class="form-controll">
							<label>车辆品牌：</label> <input type="text" datatype="*" name="brand"
								readonly="readonly">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>车辆型号：</label> <input type="text" datatype="*" name="model"
								readonly="readonly">
						</div>
						<div class="form-controll">
							<label>培训车型：</label> <select style="width: 174px;"
								name="perdritype" id="perdritype" disabled>
								<option value="0">请选择</option>
								<option value="A1">A1</option>
								<option value="A2">A2</option>
								<option value="A3">A3</option>
								<option value="B1">B1</option>
								<option value="B2">B2</option>
								<option value="C1">C1</option>
								<option value="C2">C2</option>
								<option value="C3">C3</option>
								<option value="C4">C4</option>
								<option value="C5">C5</option>
								<option value="D">D</option>
								<option value="E">E</option>
								<option value="F">F</option>
								<option value="M">M</option>
								<option value="N">N</option>
								<option value="P">P</option>
							</select>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>购买日期：</label> <input type="text" name="buydate"
								id="buydate" class="form_date" data-date-format="yyyy-mm-dd"
								readonly="readonly">
						</div>
						<div class="form-controll">
							<label>颜色：</label> <span style="padding-right: 5px;"><input
								type="radio" name="platecolor" value="1"
								style="margin: 0 3px 0 0;"> 蓝色</span> <span
								style="padding-right: 5px;"><input type="radio"
								name="platecolor" value="2" style="margin: 0 3px 0 0;">
								黄色 </span> <span style="padding-right: 5px;"><input type="radio"
								name="platecolor" value="3" style="margin: 0 3px 0 0;">黑色
							</span> <br> <span style="padding-right: 5px;"><input
								type="radio" name="platecolor" value="4"
								style="margin: 0 3px 0 0;"> 白色 </span> <span
								style="padding-right: 5px;"><input type="radio"
								name="platecolor" value="5" style="margin: 0 3px 0 0;">
								绿色</span> <span><input type="radio" name="platecolor" value="9">其它</span>

						</div>
					</div>
					<div class="row1">
						<div class="form-controll wid90">
							<label>备注:</label>
							<textarea name="remarks" readonly="readonly"></textarea>
						</div>
					</div>
				</div>
				<div class="rk_swfupload">
					<div style="height: 60px; width: 100px; display: inline-block;">
						<span class="pic">车辆相片<img id="tphotourl" name="tphotourl"
							src="" class="img-thumbnail upload-img"></span>
					</div>

				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>

			</div>
		</form>
	</div>
	<div class="modal fade colsform" id="errorId" tabindex="-1"
		role="dialog" aria-hidden="true">
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
		var dataTable = null;
		var insId = '<sec:authentication property="principal.insId"/>';
		var insCode = '<sec:authentication property="principal.insCode"/>';
		var insName = '<sec:authentication property="principal.insName"/>';
		var statId = '<sec:authentication property="principal.stationId"/>';
		function clickFile() {
			$("#upfile").click();
		}
		function clickAjaxSubmit() {
			$('#ajaxUploadId').click();
		}
	
		//初始化 
		$(document).ready(function() {
			//初始化界面  完成后调用buildData方法
			MTA.Report.initialize(null, 'buildData');
	
			//ajax 方式上传文件操作
			$('#ajaxUploadId').click(function() {
				if (checkData()) {
					if (statId != 'null') {
						var param = {
							"stationId" : statId
						};
					} else {
						var param = {
							"stationId" : -1
						}; //数据库默认值
					}
					$('#uploadExcId').ajaxSubmit({
						url : '${ctx}/trainingCar/InsertTrainingCarToDB',
						data : param,
						dataType : 'json',
						success : function resutlMsg(result) {
							$("#upfile").val("");
							if (result.code == 200) {
								alert("导入数据成功!")
								//保存成功 刷新列表
								buildDataTable();
							} else {
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
						error : function errorMsg(result) {
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
		function buildDataTable() {
			var config = {
				'container' : 'table_list'
			};
			//定义列表的列
			config['allFields'] = {
				'carnum' : {
					'thText' : '车辆编号',
					'number' : false,
					'colAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
						columnIndex) {
						var td = [];
						td.push('<span data-id="');
						td.push(record.id);
						td.push('">');
						td.push(record.carnum);
						td.push('</span>');
						return td.join('');
					}
				},
				'licnum' : {
					'thText' : '车牌号',
					'number' : false,
					'colAlign' : 'left',
					'thAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
				},
				'brand' : {
					'thText' : '车辆品牌',
					'number' : false,
					'colAlign' : 'left',
					'thAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
				},
				'platecolor' : {
					'thText' : '车辆颜色',
					'number' : false,
					'colAlign' : 'left',
					'thAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
						columnIndex) {
						td = [];
						if (value == 1) {
							td.push('<div style="text-align:left">');
							td.push('蓝色');
							td.push('</div>');
						} else if (value == 2) {
							td.push('<div style="text-align:left">');
							td.push('黄色');
							td.push('</div>');
						} else if (value == 3) {
							td.push('<div style="text-align:left">');
							td.push('黑色');
							td.push('</div>');
						} else if (value == 4) {
							td.push('<div style="text-align:left">');
							td.push('白色');
							td.push('</div>');
						} else if (value == 5) {
							td.push('<div style="text-align:left">');
							td.push('绿色');
							td.push('</div>');
						} else if (value == 9) {
							td.push('<div style="text-align:left">');
							td.push('其它');
							td.push('</div>');
						}
						return td.join('');
					}
				},
				'perdritype' : {
					'thText' : '培训车型',
					'number' : false,
					'colAlign' : 'left',
					'thAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
				},
				'franum' : {
					'thText' : '车架号',
					'number' : false,
					'colAlign' : 'left',
					'thAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
				},
				'manufacture' : {
					'thText' : '生产厂家',
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
						} else {
							td.push('否 ');
						}
						return td.join('');
					}
				},
				'id' : {
					'thText' : '操作',
					'thAlign' : 'left',
					'number' : false,
					'colAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
					'width' : '150px',
					'render' : function(value, cellmeta, record, rowIndex,
						columnIndex) {
						var td = [];
						$("#batch").append(record.id+",");
						var sRecord = JSON.stringify(record);
						td.push('<ul class="actions">');
						td.push('<li>');
						td.push('<a class="btn btn-success" onClick="details('
							+ record.id + ')">');
						td.push('详情');
						td.push('</a>');
						td.push('</li>');
						td.push('</ul>');
						return td.join('');
					}
				}
			};
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/trainingCar/list?insId=' + insId,
				'size' : 10,
				'ifRealPage' : 1
			};
			//初始化 并通过ajax加载数据
			dataTable = MTA.Data.loadAjaxPageTable(config);
		}
	
		//详情
		function details(id) {
			//重置表单
			$('#detailsForm input[name="id"]').val();
			$('#detailsForm input[name="inscode"]').val();
			$('#detailsForm input[name="licnum"]').val();
			$('#detailsForm input[name="platecolor"]:checked').val();
			$('#detailsForm input[name="manufacture"]').val();
			$('#detailsForm input[name="franum"]').val();
			$('#detailsForm input[name="engnum"]').val();
			$('#detailsForm textarea[name="remarks"]').val();
			$('#detailsForm input[name="carnum"]').val();
			$('#detailsForm input[name="brand"]').val();
			$('#detailsForm input[name="ucarnum"]').val();
			$('#detailsForm input[name="model"]').val();
			$('#detailsForm select[name="perdritype"]').val();
			$('#detailsForm input[name="buydate"]').val();
			$('img[name="tphotourl"]').attr("src");
			if (id) {
				//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
				$.getJSON(
					'${ctx}/trainingCar/' + id,
					function(result) {
						if (result.code == 200) {
							var data = result.data;
							$('#detailsForm input[name="id"]').val(
								data.id);
							$('#detailsForm input[name="inscode"]')
								.val(data.inscode);
							$('#detailsForm input[name="model"]')
								.val(data.model);
							$(
								'#detailsForm input[name="manufacture"]')
								.val(data.manufacture);
							$('#detailsForm input[name="licnum"]')
								.val(data.licnum);
							$(
								'#detailsForm textarea[name="remarks"]')
								.val(data.remarks);
							$('#detailsForm input[name="franum"]')
								.val(data.franum);
							$('#detailsForm input[name="carnum"]')
								.val(data.carnum);
							$('#detailsForm input[name="engnum"]')
								.val(data.engnum);
							$('#detailsForm input[name="brand"]')
								.val(data.brand);
							$('#detailsForm input[name="buydate"]')
								.val(data.buydate);
							$('#detailsForm input[name="sn"]').val(
								data.sn);
							$(
								"#detailsForm	input[name='platecolor'][value="
								+ data.platecolor + "]")
								.attr("checked", true);
							$(
								'#detailsForm select[name="perdritype"]')
								.val(data.perdritype);
							$('img[name="tphotourl"]').attr("src",
								data.photourl);
						}
					});
			}
			$('#details').modal('show');
		}
	
		//新增
		function showEditorModel() {
			//重置表单
			var tool = new toolCtrl();
			tool.clearForm();
			$('#ediorForm input[name="id"]').val();
			$('#ediorForm input[name="inscode"]').val();
			$('#ediorForm input[name="licnum"]').val();
			$('#ediorForm input[name="platecolor"]:checked').val();
			$('#ediorForm input[name="manufacture"]').val();
			$('#ediorForm input[name="franum"]').val();
			$('#ediorForm textarea[name="remarks"]').val();
			$('#ediorForm input[name="carnum"]').val();
			$('#ediorForm input[name="engnum"]').val();
			$('#ediorForm input[name="brand"]').val();
			$('#ediorForm input[name="model"]').val();
			$('#ediorForm select[name="perdritype"]').val();
			$('#ediorForm input[name="buydate"]').val();
			$('img[name="photourl"]').attr("src", " ");
			$('#editorModal').modal('show');
		}
		function saves() {
			if ($("#editorModal .valid-form").Validform().check() == true) {
				//从form中取参数值
				var id = $('#ediorForm input[name="id"]').val();
				var inscode = $('#ediorForm input[name="inscode"]').val();
				var licnum = $('#ediorForm input[name="licnum"]').val();
				var platecolor = $(
					'#ediorForm input[name="platecolor"]:checked').val();
				var manufacture = $('#ediorForm input[name="manufacture"]')
					.val();
				var franum = $('#ediorForm input[name="franum"]').val();
				var remarks = $('#ediorForm textarea[name="remarks"]').val();
				var carnum = $('#ediorForm input[name="carnum"]').val();
				var engnum = $('#ediorForm input[name="engnum"]').val();
				var brand = $('#ediorForm input[name="brand"]').val();
				var model = $('#ediorForm input[name="model"]').val();
				var perdritype = $('#ediorForm select[name="perdritype"]')
					.val();
				var buydate = $('#ediorForm input[name="buydate"]').val();
				var photourl = $('#ediorForm img[name="photourl"]').attr("src");
	
				if (model == "" || buydate == "") {
					alert("请添加完成必要信息！");
					$('#save_btn').attr('disabled', false);
					return false;
				}
	
				var buydates = new Date(buydate).pattern('yyyyMMdd')
				if (isTimeSystem()) {
					//定义提交到服务端的数据对象
					var fileParam = {
						"type" : 'vehimg',
						"url" : photourl,
						"level" : 1
					};
	
					$.post(recordUrl + '/upload/file/url', fileParam, function(result) {
						console.log("result.data.id" + result.data.id);
						if (result.errorcode == 0) {
							var param = {
								'inscode' : insCode,
								'franum' : franum,
								'engnum' : engnum,
								'licnum' : licnum,
								'platecolor' : platecolor,
								'photo' : result.data.id,
								'manufacture' : manufacture,
								'brand' : brand,
								'model' : model,
								'perdritype' : perdritype,
								'buydate' : buydates
							};
							$.post(recordUrl + '/country/trainingcar', param, function(resultsd) {
								if(resultsd.message!=""){
									layer.alert(resultsd.message);
								}
								if (resultsd.errorcode == 0) {
									var params = {
										'id' : id,
										'inscode' : insCode,
										'insId' : insId,
										'licnum' : licnum,
										'platecolor' : platecolor,
										'manufacture' : manufacture,
										'franum' : franum,
										'remarks' : remarks,
										'carnum' : resultsd.data.carnum,
										//'carnum' : carnum,
										'engnum' : engnum,
										'brand' : brand,
										'model' : model,
										'perdritype' : perdritype,
										'buydate' : buydate,
										'photo' : resultsd.data.id,
										//'photo' : id,
										'photourl' : photourl
									};
	
									//发送数据到后端保存
									$.post('${ctx}/trainingCar/updateorsave', params, function(result) {
										if (result.code == 200) {
											//关闭编辑的表单
											var tool = new toolCtrl();
											tool
												.clearForm();
											//保存成功 刷新列表
											layer
												.alert('保存成功');
											buildDataTable();
											$(
												'#editorModal')
												.modal(
													'hide');
										} else {
											layer
												.alert('保存失败')
										}
									});
								}/*  else {
									alert(resultsd.message)
								} */
							});
						} else {
							alert(result.message)
						}
					})
				} else {
					var params = {
						'id' : id,
						'inscode' : insCode,
						'insId' : insId,
						'licnum' : licnum,
						'platecolor' : platecolor,
						'manufacture' : manufacture,
						'franum' : franum,
						'remarks' : remarks,
						'carnum' : carnum,
						'engnum' : engnum,
						'brand' : brand,
						'model' : model,
						'perdritype' : perdritype,
						'buydate' : buydate,
						'photo' : id,
						'photourl' : photourl
					};
	
					//发送数据到后端保存
					$.post('${ctx}/trainingCar/updateorsave', params, function(result) {
						if (result.code == 200) {
							//关闭编辑的表单
							var tool = new toolCtrl();
							tool.clearForm();
							//保存成功 刷新列表
							layer.alert('保存成功');
							buildDataTable();
							$('#editorModal').modal('hide');
						} else {
							layer.alert('保存失败')
						}
					});
				}
			}
		}
		//修改填充数据
		function UpdateEditorModel(id) {
			var id = sessionStorage.getItem('tabId')
			if (id === null || id === undefined) {
				alert('未选择目标');
			} else {
				//重置表单 
				$('#updateForm input[name="id"]').val();
				$('#updateForm input[name="uinscode"]').val();
				$('#updateForm input[name="ulicnum"]').val();
				$('#updateForm input[name="uplatecolor"]:checked').val();
				$('#updateForm input[name="umanufacture"]').val();
				$('#updateForm input[name="ufranum"]').val();
				$('#updateForm textarea[name="uremarks"]').val();
				$('#updateForm input[name="ucarnum"]').val();
				$('#updateForm input[name="uengnum"]').val();
				$('#updateForm input[name="ubrand"]').val();
				$('#updateForm input[name="ucarnum"]').val();
				$('#updateForm input[name="umodel"]').val();
				$('#updateForm select[name="uperdritype"]').val();
				$('#updateForm input[name="ubuydate"]').val();
				$('#updateForm input[name="isProvince"]').val();
	
				$('#updateForm img[name="uphotourl"]').attr("src");
				if (id) {
					//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
					$.getJSON('${ctx}/trainingCar/' + id, function(result) {
						if (result.code == 200) {
							var data = result.data;
							var date = new Date(data.buydate)
								.pattern('yyyy-MM-dd')
							$('#updateForm input[name="id"]').val(data.id);
							$('#updateForm input[name="uinscode"]').val(data.inscode);
							$('#updateForm input[name="umodel"]').val(data.model);
							$('#updateForm input[name="umanufacture"]').val(data.manufacture);
							$('#updateForm input[name="isProvince"]').val(data.isProvince);
							$('#updateForm input[name="ulicnum"]').val(
								data.licnum);
							$('#updateForm input[name="ufranum"]').val(
								data.franum);
							$('#updateForm textarea[name="uremarks"]').val(
								data.remarks);
							$('#updateForm input[name="ucarnum"]').val(
								data.carnum);
							$('#updateForm input[name="uengnum"]').val(
								data.engnum);
							$('#updateForm input[name="ubrand"]').val(
								data.brand);
							$('#updateForm input[name="ubuydate"]').val(
								data.buydate);
							$('#updateForm input[name="usn"]').val(data.sn);
							$(
								"#updateForm	input[name='uplatecolor'][value="
								+ data.platecolor + "]").attr(
								"checked", true);
							$('#updateForm select[name="uperdritype"]').val(
								data.perdritype);
							$('img[name="uphotourl"]').attr("src",
								data.photourl);
						}
					});
				}
				$('#updateModal').modal('show');
			}
		}
	
		//修改
		function updates() {
			//从form中取参数值
			var id = $('#updateForm input[name="id"]').val();
			var inscode = $('#updateForm input[name="uinscode"]').val();
			var licnum = $('#updateForm input[name="ulicnum"]').val();
			var platecolor = $('#updateForm input[name="uplatecolor"]:checked').val();
			var manufacture = $('#updateForm input[name="umanufacture"]').val();
			var franum = $('#updateForm input[name="ufranum"]').val();
			var carnum = $('#updateForm input[name="ucarnum"]').val();
			var remarks = $('#updateForm textarea[name="uremarks"]').val();
			var engnum = $('#updateForm input[name="uengnum"]').val();
			var brand = $('#updateForm input[name="ubrand"]').val();
			var isProvince = $('#updateForm input[name="isProvince"]').val();
			var model = $('#updateForm input[name="umodel"]').val();
			var perdritype = $('#updateForm select[name="uperdritype"]').val();
			var buydate = $('#updateForm input[name="ubuydate"]').val();
			var photourl = $('#updateForm img[name="uphotourl"]').attr("src");
	
			var date = new Date(buydate);
			var buydates = date.getFullYear().toString() + (date.getMonth() + 1) + (date.getDate());
	
			var buydated = new Date(buydate).pattern('yyyyMMdd');
			//定义提交到服务端的数据对象
			var paramd = {
				'id' : id,
				'inscode' : inscode,
				'licnum' : licnum,
				'platecolor' : platecolor,
				'manufacture' : manufacture,
				'franum' : franum,
				'remarks' : remarks,
				'carnum' : carnum,
				'engnum' : engnum,
				'brand' : brand,
				'model' : model,
				'perdritype' : perdritype,
				'buydate' : buydate,
				'photourl' : photourl,
				'isProvince' : isProvince
			};
			$.ajax({
				url : "${ctx}/trainingCar/updateorsave",
				type : "post",
				data : paramd,
				success : function(data) {
					if (data.code == 200) {
						layer.alert('保存成功');
						$('#updateModal').modal('hide');
						buildDataTable();
					} else {
						layer.alert('保存失败');
					}
				}
			});
		}
		
		function uploadAll() {
			var batchId=$("#batch").text().split(",");
			console.log(batchId);
			for(var i=0;i<batchId.length-1;i++){
				record(batchId[i]);
			}
		}
	
		//上传备案
		function uploadRecord() {
			/* 获取id */
			var id = sessionStorage.getItem('tabId');
			if (id === null || id === undefined) {
				layer.alert('未选择目标');
			} else {
				record(id);
			}
		}
	
		function record(id) {
			//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
			$.getJSON('${ctx}/trainingCar/' + id, function(result) {
				if (result.code == 200) {
					var data = result.data;
					if (data.isCountry == 1) {
						//弹出提示框 让用户确认删除
						var dialog = new GRI.Dialog({
							type : 4,
							title : '上传备案',
							content : '确定上传【'
								+ data.licnum
								+ '】教练车	备案吗？',
							deGRIil : '',
							btnType : 1,
							extra : {
								top : 250
							},
							winSize : 1
						},
							function() {
								//时间判断函数
								function pad2(n) {
									return n < 10 ? '0' + n : n
								}
								var buydates = new Date(data.buydate).pattern('yyyyMMdd').toString()
								console.log(buydates)
								//定义提交到服务端的数据对象
								var fileParam = {
									"type" : 'vehimg',
									"url" : data.photourl,
									"level" : 2
								};
								//发送数据到后端保存
								$.post(recordUrl + '/upload/file/url', fileParam, function(result) {
									if (result.errorcode == 0) {
										//定义提交到服务端的数据对象							
										var params = {
											'inscode' : data.inscode,
											'carnum' : data.carnum,
											'franum' : data.franum,
											'engnum' : data.engnum,
											'licnum' : data.licnum,
											'platecolor' : data.platecolor,
											//'photo' : data.photo,
											'photo' : result.data.id,
											'manufacture' : data.manufacture,
											'brand' : data.brand,
											'model' : data.model,
											'perdritype' : data.perdritype,
											'buydate' : buydates
										};
										//发送数据到后端保存
										$.post(recordUrl + '/province/trainingcar', params, function(pResult) {
											if (pResult.errorcode == 0) {
												var paramd = {
													'id' : id,
													'isProvince' : 1
												};
												$.post('${ctx}/trainingCar/updateorsave', paramd, function(result) {
													if (result.code == 200) {
														layer.alert(pResult.message);
														buildDataTable();
													} else {
														layer.alert(pResult.message)
													}
												});
											} else {
												layer.alert(pResult.message)
											}
										});
									} else {
										layer.alert(result.message)
									}
								});
							})
					} else {
						layer.open({
							title : '提示',
							maxWidth : 900,
							content : '<h4 style="color:red; text-align:center;font-size:20px;">温馨提示</h4>'
								+ '<div style="text-align:center;">该教练车没有国家平台备案的教练车编号,不能上传省平台备案!</br>(在计时平台对接前录入的教练车不需要备案)</div>'
						});
					}
				}
			});
		}
	
		function exportFile() {
		window.location.href = "${ctx}/trainingCar/exportCar?insCode="+insCode;
	}
		//删除上传国家
		function deletes() {
			var id = sessionStorage.getItem('tabId');
			if (id === null || id === undefined) {
				alert('未选择目标');
			} else {
				$.getJSON("${ctx}/trainingCar/" + id, function(result) {
					if (result.code == 200) {
						var data = result.data;
						/* if (data.isProvince != 1) {
							layer.alert('尚未省备案！');
							return false;
						} */
						var gnl = confirm("阳光驾培温馨提示,您确定要删除吗?");
						if (gnl == true) {
							//定义提交到服务端的数据对象
							var params = {
								'carnum' : data.carnum
							};
							//发送数据到后端保存
							$.post(recordUrl + '/province/trainingcar/delete', params, function(provinceresult) {
								if (provinceresult.errorcode == 0) {
									var paramd = {
										'id' : id
									}
									$.post('${ctx}/trainingCar/deletes', paramd, function(result) {
										if (result.code == 200) {
											layer.alert('删除成功');
											//保存成功 刷新列表
											buildDataTable();
										} else {
											layer.alert('删除失败')
										}
									});
								} else {
									if(provinceresult.message.includes("删除条件对象不存在")){
										layer.alert('该教练车尚未备案');
									}else{
										layer.alert('删除上传省备案失败');
									}
								}
							});
							return true;
						} else {
							return false
						}
					}
				})
			}
		}
		/* 
		//删除测试
		 	function deletes() {
				var id = sessionStorage.getItem('tabId');
				if (id === null || id === undefined) {
					alert('未选择目标');
				} else {
					var gnl = confirm("阳光驾培温馨提示,您确定要删除吗?");
					if (gnl == true) {
						//定义提交到服务端的数据对象
						var paramd = {
							'id' : id
						}
						$.post('${ctx}/trainingCar/deletes', paramd, function(
								result) {
							if (result.code == 200) {
								layer.alert('删除成功');
								//保存成功 刷新列表
								
							} else {
								layer.alert('删除失败')
							}
							buildDataTable();
						});
						return true;
					} else {
						return false
					}
	
				}
			}
		 */
		$('.form_date').datetimepicker({
			language : 'zh-CN',
			weekStart : 1,
			todayBtn : 1,
			autoclose : 1,
			todayHighlight : 0,
			startView : 2,
			minView : 2,
			forceParse : 0
		}).on("changeDate", function() {
			$('.form_date + .Validform_checktip').html('');
			$('.form_date').removeClass('Validform_error');
		});
	
		$('#upload_buton_img')
			.uploadify(
				{
					'swf' : 'http://upload.91ygxc.com/resources/swfupload.swf',
					'uploader' : 'http://upload.91ygxc.com/FileUpload',
					'height' : '30',
					'width' : '120',
					'fileTypeExts' : '*.jpg;*.JPG;*.jpeg;*.JPEG;*.png;*.PNG;*.gif;*.GIF',
					'fileObjName' : 'file_upload',
					'onUploadSuccess' : function(file, data, response) {
						var datajson = eval("(" + data + ")");
						$("#photourl").attr('src', datajson.data.s);
						console.log(data);
					}
				});
		$('#aupload_buton_img')
			.uploadify(
				{
					'swf' : 'http://upload.91ygxc.com/resources/swfupload.swf',
					'uploader' : 'http://upload.91ygxc.com/FileUpload',
					'height' : '30',
					'width' : '120',
					'fileTypeExts' : '*.jpg;*.JPG;*.jpeg;*.JPEG;*.png;*.PNG;*.gif;*.GIF',
					'fileObjName' : 'file_upload',
					'onUploadSuccess' : function(file, data, response) {
						var datajson = eval("(" + data + ")");
						$("#uphotourl").attr('src', datajson.data.s);
						console.log(data);
					}
				});
	</script>
</body>
</html>