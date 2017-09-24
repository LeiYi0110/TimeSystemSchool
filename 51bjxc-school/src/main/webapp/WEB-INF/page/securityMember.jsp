<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-安全员管理</title>
<link type="text/css" href="${ctx}/resources/css/compiled/new-form.css" rel="stylesheet" />
<link href="${ctx}/resources/css/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen" />
<link href="${ctx}/resources/js/form-prompt/style.css" type="text/css" rel="stylesheet" media="all" />
<script type="text/javascript" src="${ctx}/resources/js/form-prompt/Validform_v5.3.2_min.js"></script>
<script src="${ctx}/resources/uploadify/jquery.uploadify.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery-form.js"></script>
<link type="text/css" href="${ctx}/resources/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
</head>
<body>
	<div class="container-fluid new-admin">
		<div class="select-top">
		<sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
			<a class="select-btn" data-toggle="modal" onclick="addModal()"><span class="add"></span>新增</a>
			<a class="select-btn" data-toggle="modal" data-target="#editSecurity" onclick="editModal()"><span class="edit" ></span>修改</a>
			<a class="select-btn" onclick="deletes();"><span class="del"></span>删除</a>
			<a class="select-btn" onClick="upRecord()"><span class="spare"></span>备案</a>
			<a class="select-btn" onClick="uploadAll()"><span class="spare"></span>批量备案</a>
			<a class="select-btn" id="uploadCoachExcId" onclick="clickFile()"><span class="Import"></span>导入</a>
			<a class="select-btn" onclick="exportFile();"><span class="Export"></span>导出</a>
		</sec:authorize>
		
		<sec:authorize access="hasRole('ROLE_SCHOOL_SERVICE')">
			<sec:authorize access="hasRole('ROLE_UserOperation_24')">
				<a class="select-btn" data-toggle="modal" onclick="addModal()"><span class="add"></span>新增</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_25')">
				<a class="select-btn" data-toggle="modal" data-target="#editSecurity" onclick="editModal()"><span class="edit" ></span>修改</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_26')">
				<a class="select-btn" onclick="deletes();"><span class="del"></span>删除</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_27')">
				<a class="select-btn" onClick="upRecord()"><span class="spare"></span>备案</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_28')">
				<a class="select-btn" onClick="uploadAll()"><span class="spare"></span>批量备案</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_29')">
				<a class="select-btn" id="uploadCoachExcId" onclick="clickFile()"><span class="Import"></span>导入</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_30')">
				<a class="select-btn" onclick="exportFile();"><span class="Export"></span>导出</a>
			</sec:authorize>
		</sec:authorize>
		</div>
	</div>
	 <div class="TermSearch">
 	 <form>
	 <input class="input1 win200" type="text" id="search" placeholder="身份证号/手机号码/安全员姓名搜索">
	 <buuton class="btn-flat primary" onClick="searchQuery();return false;">搜 索</buuton>
	 </form>
	 </div>
	 
	 <div style="display: none">
		<form method="POST" enctype="multipart/form-data" id="uploadExcId"
			action="${ctx}/security/InsertSecurityToDB">
			<input id="upfile" type="file" name="upSecurityfile"
				onchange="clickAjaxSubmit()" /> <input type="button"
				id="ajaxUploadId" />
		</form>
	</div>
	<div class="row-fluid">
		<div class="sub_content">
			<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
			<div id="table_list" class="gri_wrapper"></div>
		</div>
	</div>
	<!-- 新增-->
	<div class="modal fade colsform" id="addSecurity" tabindex="-1" role="dialog" aria-hidden="true">	
		<form id="addSecurityInfo" class="form-horizontal valid-form">
			<h4>新增安全员</h4>
			<input type="hidden" id="coachIdd" value="">
			<div class="modal-content">
				<div class="left">
					<div class="row1">
						<div class="form-controll">
							<label>机构编号:</label>
							<input type="text" name="inscodey" value='<sec:authentication property="principal.insCode"/>'>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>姓名:</label>
							<input type="text" name="name" datatype="*" nullmsg="姓名不能为空" sucmsg=" ">
							<input type="hidden" name="id" id="id" value="">
							<input type="hidden" name="insId" id="insId" value="<sec:authentication property="principal.insId"/>">
						</div>
						<div class="form-controll">
							<label>性别:</label>
							<input type="radio" name="sex" value="1" checked datatype="*" nullmsg="性别不能为空" sucmsg=" "> 男
							<input type="radio" name="sex" value="2" datatype="*" nullmsg="性别不能为空" sucmsg=" "> 女
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>身份证号:</label>
							<input type="text" name="idcard" datatype="*" nullmsg="身份证号码不能为空" sucmsg=" ">
						</div>
						<div class="form-controll">
							<label>手机号码:</label>
							<input type="text" name="mobile" datatype="*" nullmsg="手机号码不能为空" sucmsg=" ">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>驾驶证号:</label>
							<input type="text" name="drilicence">
						</div>
						<div class="form-controll">
							<label style="width:105px;">驾驶证初领日期:</label>
							<input type="text" name="fstdrilicdate"  class="form_date" style="width:172px;" data-date-format="yyyy-mm-dd" readonly="readonly" >
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>准驾车型:</label>
							<select id="dripermitted" name="dripermitted">
								<option  value="A1">A1</option>
								<option  value="A2">A2</option>
								<option  value="A3">A3</option>
								<option  value="B1">B1</option>
								<option  value="B2">B2</option>
								<option  value="C1">C1</option>
								<option  value="C2">C2</option>
								<option  value="C3">C3</option>
								<option  value="C4">C4</option>
								<option  value="C5">C5</option>
								<option  value="D">D</option>
								<option  value="E">E</option>
								<option  value="F">F</option>
								<option  value="M">M</option>
								<option  value="N">N</option>
								<option  value="P">P</option>
							</select>
						</div>
						<div class="form-controll">
							<label>准教车型:</label>
							<select id="teachpermitted" name="teachpermitted">
										<option  value="A1">A1</option>
										<option  value="A2">A2</option>
										<option  value="A3">A3</option>
										<option  value="B1">B1</option>
										<option  value="B2">B2</option>
										<option  value="C1">C1</option>
										<option  value="C2">C2</option>
										<option  value="C3">C3</option>
										<option  value="C4">C4</option>
										<option  value="C5">C5</option>
										<option  value="D">D</option>
										<option  value="E">E</option>
										<option  value="F">F</option>
										<option  value="M">M</option>
										<option  value="N">N</option>
										<option  value="P">P</option>
									</select>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>入职时间:</label>
							<input type="text" name="hiredate"  class="form_date" data-date-format="yyyy-mm-dd" readonly="readonly" datatype="*" nullmsg="入职时间不能为空" sucmsg=" ">
						</div>
						<div class="form-controll">
							<label>供职状态:</label>
							<input type="radio" name="employstatus" value="0" checked datatype="*" nullmsg="供职状态不能为空" sucmsg=" ">在职
							<input type="radio" name="employstatus" value="1" datatype="*" nullmsg="供职状态不能为空" sucmsg=" "> 离职
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>离职时间:</label>
							<input type="text" name="leavedate"  class="form_date" data-date-format="yyyy-mm-dd" readonly="readonly">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll wid90">
							<label>联系地址:</label>
							<textarea name="address"></textarea>
						</div>
					</div>
				</div>

				<div class="right">
					<div class="rk_swfupload">
						<div style="height: 60px; width: 100px; display: inline-block;">
							<span class="pic">个人相片<img id="sPhoto" name="sPhoto" src="" class="img-thumbnail upload-img"></span>
							
							<a style="margin-top:20px; width:100px;" class="btn btn-success">上传</a>
						</div>
						<div class="swfobj swfobj-position">
							<div id="upload_buton_img"></div>
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
	<!-- 修改-->
	<div class="modal fade colsform" id="updateSecurity" tabindex="-1" role="dialog" aria-hidden="true">	
		<form id="updateSecurityInfo" class="form-horizontal valid-form">
			<h4>修改安全员</h4>
			<input type="hidden" id="coachIdd" value="">
			<div class="modal-content">
				<div class="left">
					<div class="row1">
						<input type="hidden" name="secunum" id="secunumId"/>
						<input type="hidden" id="isCountryId"/><!-- 是否全国备案 -->
						<div class="form-controll">
							<label>姓名:</label>
							<input type="text" name="name" datatype="*" nullmsg="姓名不能为空" sucmsg=" ">
							<input type="hidden" name="id" id="id" value="">
							<input type="hidden" name="insId" id="insId" value="<sec:authentication property="principal.insId"/>">
						</div>
						<div class="form-controll">
							<label>性别:</label>
							<input type="radio" name="sex" value="1" checked datatype="*" nullmsg="性别不能为空" sucmsg=" "> 男
							<input type="radio" name="sex" value="2" datatype="*" nullmsg="性别不能为空" sucmsg=" "> 女
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>身份证号:</label>
							<input type="text" name="idcard" datatype="*" nullmsg="身份证号不能为空" sucmsg=" ">
						</div>
						<div class="form-controll">
							<label>手机号码:</label>
							<input type="text" name="mobile" datatype="*" nullmsg="手机号码不能为空" sucmsg=" ">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>驾驶证号:</label>
							<input type="text" name="drilicence">
						</div>
						<div class="form-controll">
							<label style="width:105px;">驾驶证初领日期:</label>
							<input type="text" name="fstdrilicdate"  class="form_date" style="width:172px;" data-date-format="yyyy-mm-dd" readonly="readonly" >
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>准驾车型:</label>
							<select id="dripermitted" name="dripermitted">
								<option  value="A1">A1</option>
								<option  value="A2">A2</option>
								<option  value="A3">A3</option>
								<option  value="B1">B1</option>
								<option  value="B2">B2</option>
								<option  value="C1">C1</option>
								<option  value="C2">C2</option>
								<option  value="C3">C3</option>
								<option  value="C4">C4</option>
								<option  value="C5">C5</option>
								<option  value="D">D</option>
								<option  value="E">E</option>
								<option  value="F">F</option>
								<option  value="M">M</option>
								<option  value="N">N</option>
								<option  value="P">P</option>
							</select>
						</div>
						<div class="form-controll">
							<label>准教车型:</label>
							<select id="teachpermitted" name="teachpermitted">
										<option  value="A1">A1</option>
										<option  value="A2">A2</option>
										<option  value="A3">A3</option>
										<option  value="B1">B1</option>
										<option  value="B2">B2</option>
										<option  value="C1">C1</option>
										<option  value="C2">C2</option>
										<option  value="C3">C3</option>
										<option  value="C4">C4</option>
										<option  value="C5">C5</option>
										<option  value="D">D</option>
										<option  value="E">E</option>
										<option  value="F">F</option>
										<option  value="M">M</option>
										<option  value="N">N</option>
										<option  value="P">P</option>
									</select>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>入职时间:</label>
							<input type="text" name="hiredate"  class="form_date" data-date-format="yyyy-mm-dd" readonly="readonly" datatype="*" nullmsg="入职时间不能为空" sucmsg=" ">
						</div>
						<div class="form-controll">
							<label>供职状态:</label>
							<input type="radio" name="employstatus" value="0" checked datatype="*" nullmsg="供职状态不能为空" sucmsg=" ">在职
							<input type="radio" name="employstatus" value="1" datatype="*" nullmsg="供职状态不能为空" sucmsg=" "> 离职
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>离职时间:</label>
							<input type="text" name="leavedate"  class="form_date" data-date-format="yyyy-mm-dd" readonly="readonly">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll wid90">
							<label>联系地址:</label>
							<textarea name="address"></textarea>
						</div>
					</div>
				</div>
				<div class="right">
					<div class="rk_swfupload">
						<div style="height: 60px; width: 100px; display: inline-block;">
							<span class="pic">个人相片<img id="photo" name="photo" src="" class="img-thumbnail upload-img"></span>
							
							<a style="margin-top:20px; width:100px;" class="btn btn-success">上传</a>
						</div>
						<div class="swfobj swfobj-position">
							<div id="upload_buton_img1"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="update();">保存</button>
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
	<!-- 查看详情-->
	<div class="modal fade colsform" id="viewSecurity" tabindex="-1" role="dialog" aria-hidden="true">	
		<form id="viewSecurityInfo" class="form-horizontal valid-form">
			<h4>安全员信息</h4>
			<input type="hidden" id="coachIdd" value="">
			<div class="modal-content">
				<div class="left">
					<div class="row1">
						<div class="form-controll">
							<label>姓名:</label>
							<input type="text" name="name" disabled>
							<input type="hidden" name="id" id="id" value="">
							<input type="hidden" name="insId" id="insId" value="<sec:authentication property="principal.insId"/>">
						</div>
						<div class="form-controll">
							<label>性别:</label>
							<input type="radio" name="sex" value="1" checked disabled> 男
							<input type="radio" name="sex" value="2" disabled> 女
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>身份证号:</label>
							<input type="text" name="idcard" disabled>
						</div>
						<div class="form-controll">
							<label>手机号码:</label>
							<input type="text" name="mobile" disabled>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>驾驶证号:</label>
							<input type="text" name="drilicence" disabled>
						</div>
						<div class="form-controll">
							<label style="width:105px;">驾驶证初领日期:</label>
							<input type="text" name="fstdrilicdate"  class="form_date" style="width:172px;" data-date-format="yyyy-mm-dd" readonly="readonly" disabled>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>准驾车型:</label>
							<select id="dripermitted" name="dripermitted" disabled>
								<option  value="A1">A1</option>
								<option  value="A2">A2</option>
								<option  value="A3">A3</option>
								<option  value="B1">B1</option>
								<option  value="B2">B2</option>
								<option  value="C1">C1</option>
								<option  value="C2">C2</option>
								<option  value="C3">C3</option>
								<option  value="C4">C4</option>
								<option  value="C5">C5</option>
								<option  value="D">D</option>
								<option  value="E">E</option>
								<option  value="F">F</option>
								<option  value="M">M</option>
								<option  value="N">N</option>
								<option  value="P">P</option>
							</select>
						</div>
						<div class="form-controll">
							<label>准教车型:</label>
							<select id="teachpermitted" name="teachpermitted" disabled>
										<option  value="A1">A1</option>
										<option  value="A2">A2</option>
										<option  value="A3">A3</option>
										<option  value="B1">B1</option>
										<option  value="B2">B2</option>
										<option  value="C1">C1</option>
										<option  value="C2">C2</option>
										<option  value="C3">C3</option>
										<option  value="C4">C4</option>
										<option  value="C5">C5</option>
										<option  value="D">D</option>
										<option  value="E">E</option>
										<option  value="F">F</option>
										<option  value="M">M</option>
										<option  value="N">N</option>
										<option  value="P">P</option>
									</select>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>入职时间:</label>
							<input type="text" name="hiredate"  class="form_date" data-date-format="yyyy-mm-dd" readonly="readonly" disabled>
						</div>
						<div class="form-controll">
							<label>供职状态:</label>
							<input type="radio" name="employstatus" value="0" disabled>在职
							<input type="radio" name="employstatus" value="1" disabled> 离职
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>离职时间:</label>
							<input type="text" name="leavedate"  class="form_date" data-date-format="yyyy-mm-dd" readonly="readonly" disabled>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll wid90">
							<label>联系地址:</label>
							<textarea name="address" disabled></textarea>
						</div>
					</div>
				</div>
				<div class="right">
					<div class="rk_swfupload">
						<div style="height: 60px; width: 100px; display: inline-block;">
							<span class="pic">个人相片<img id="photo" name="photo" src="" class="img-thumbnail upload-img"></span>
						</div>
						<div class="swfobj swfobj-position">
							<div id="upload_buton_img1"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			</div>
		</form>
	</div>
	<script type="text/javascript">
		var recordUrl=<custom:properties name='bjxc.user.province'/>;
		//标识当前页面的url 用来设置当前菜单标识
		var dataTable = null;
		var insId= '<sec:authentication property="principal.insId"/>';
		var insName = '<sec:authentication property="principal.insName"/>';
		var statId= '<sec:authentication property="principal.stationId"/>';
		var secunum=null;
		
		function clickFile(){
			$("#upfile").click();
		}
		function clickAjaxSubmit(){
			$('#ajaxUploadId').click();
		}
		
		//初始化 
		$(document).ready(function() {
			//初始化界面  完成后调用buildData方法
			MTA.Report.initialize(null, 'buildData');
			
			//ajax 方式上传文件操作
			$('#ajaxUploadId').click(function(){
		           if(checkData()){
		               $('#uploadExcId').ajaxSubmit({
		                   url:'${ctx}/security/InsertSecurityToDB',
		                   dataType: 'json',  
		                   success: function resutlMsg(result){
			            	   $("#upfile").val("");
			            	   if(result.code==200){
			            		   layer.alert("导入数据成功!")
			            		  buildDataTable();
			            	   }else{
			            		   $("#innerListId").empty();
			            		   var errorList=result.errorList;
			            		   var html ='';
			            		   for(var i=0;i<errorList.length;i++){
			            			   html+=errorList[i]+'<br/>';
			            		   }
			            		   $("#innerListId").append(html);
			            		   $("#errorId").modal('show');
			            	   }
			               },
		                   error: function errorMsg(result){
			            	   $("#upfile").val("");
			            	   layer.alert(result.message);
			               }
		               });
		           }  
		       });
		});
		//JS校验form表单信息  
	    function checkData(){
	       var fileDir = $("#upfile").val();  
	       var suffix = fileDir.substr(fileDir.lastIndexOf("."));  
	       if("" == fileDir){  
	    	   layer.alert("选择需要导入的Excel文件！");  
	           return false;  
	       }  
	       if(".xls" != suffix && ".xlsx" != suffix ){  
	    	   layer.alert("选择Excel格式的文件导入！");  
	           return false; 
	       }  
	       return true;  
	    }

		function buildData() {
			MTA.Util.setParams('insId', insId);
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
				
				'secunum' : {
					'thText' : '安全员编号',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<span data-id="');
							td.push(record.id);
							td.push('">');
							td.push(record.secunum);
						td.push('</span>');
						return td.join('');
					}
				},
				'xxx' : {
					'thText' : '机构编号',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						var ins=$("#insCodex").val();
						td.push(ins);
						return td.join('');
					}
				},
				'name' : {
					'thText' : '姓名',
					'number' : false,
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
						} else{
							td.push('否 ');
						}
						return td.join('');
					}
				},
				'mobile' : {
					'thText' : '联系方式',
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
				'hiredate' : {
					'thText' : '入职时间',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'teachpermitted' : {
					'thText' : '准教车型',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'employstatus' : {
					'thText' : '供职状态',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						td = [];
						td.push('<ul class="info">');
							td.push('<li>');
								if (value ==  0) {
									td.push('在职');
								} else if (value == 1) {
									td.push('离职');
								}
							td.push('</li>');
						td.push('</ul>');
						return td.join('');
					}
				},
				'id' : {
					'thText' : '查看详情',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'width' : '150px',
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						$("#batch").append(record.id+",");
						td.push('<button class="btn btn-success" onclick="viewModal('+ value +')">查看详情</button>');
						td.push('<ul class="actions">');
						td.push('</ul>');
						return td.join('');
					}
				}
			};
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/security/list',
				'size' : 10,
				'ifRealPage' : 1
			};
			//初始化 并通过ajax加载数据
			dataTable = MTA.Data.loadAjaxPageTable(config);
		}
		
		function uploadAll() {
			var batchId=$("#batch").text().split(",");
			console.log(batchId);
			for(var i=0;i<batchId.length-1;i++){
				record(batchId[i]);
			}
		}
		
		function upRecord() {
			/* 获取id */
			var id = sessionStorage.getItem('tabId');
			if(id === null || id === undefined){
				layer.alert('未选择目标');
			}else{
				record(id);
			}
		}
	
		function record(id) {
			$.getJSON("${ctx}/security/" + id, function(result) {
				var data = result.data;
				//弹出提示框 让用户确认删除
				var dialog = new GRI.Dialog({
					type : 4,
					title : '上传备案',
					content : '确定上传【' + data.name + '】安全员备案吗？',
					deGRIil : '',
					btnType : 1,
					extra : {
						top : 250
					},
					winSize : 1
				}, function() {
					var id = data.id;
					var isCountry = data.isCountry;
					if (isCountry != null && isCountry == 1) {
						//定义提交到服务端的数据对象
						var fileParam = {
							"type" : 'securityguardimg',
							"url" : data.photoUrl,
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
								var countryFstdrilicdate;
								if (data.fingerprint != null) {
									var date = new Date(data.fingerprint);
									var countryFstdrilicdate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2(date.getDate())
								}
								//入职时间
								var countryHiredate;
								if (data.hiredate != null) {
									var date = new Date(data.hiredate);
									var countryHiredate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2(date.getDate())
								}
								//离职时间
								var countryLeavedate;
								if (data.leavedate != null) {
									var date = new Date(data.leavedate);
									var countryLeavedate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2(date.getDate())
								}
								//定义提交到服务端的数据对象
								var params = {
									'inscode' : insCode,
									'secunum' : data.secunum,
									'name' : data.name,
									'sex' : data.sex,
									'idcard' : data.idcard,
									'mobile' : data.mobile,
									'address' : data.address,
									'photo' : urlResult.data.id,
									'fingerprint' : null,
									'drilicence' : data.drilicence,
									'fstdrilicdate' : countryFstdrilicdate,
									'dripermitted' : data.dripermitted,
									'teachpermitted' : data.teachpermitted,
									'employstatus' : data.employstatus,
									'hiredate' : countryHiredate,
									'leavedate' : countryLeavedate
								};
								//发送数据到后端保存
								$.post(recordUrl + '/province/securityguard', params, function(results) {
									if (results.errorcode == 0) {
										//定义提交到服务端的数据对象
										var params = {
											"id" : id,
											"isProvince" : 1
										};
										$.post('${ctx}/security/saveOrUpdate', params, function(result) {
											if (result.code == 200) {
												//隐藏表单
												$('#addSecurity').modal('hide');
												layer.alert("保存成功")
												//刷新表单
												buildDataTable();
											} else {
												layer.alert("保存失败")
												//打开错误提示框
												$('#editorModal').modal('show');
											}
											$('#save_btn').attr('disabled', false);
										});
									} else {
										layer.alert(results.message)
									}
								});
							} else {
								layer.alert(urlResult.message)
							}
						});
					} else {
						layer.open({
							title : '提示',
							maxWidth : 900,
							content : '<h4 style="color:red; text-align:center;font-size:20px;">温馨提示</h4>' +
								'<div style="text-align:center;">该安全员没有国家平台备案的安全员编号,不能上传省平台备案!</br>(在计时平台对接前录入的学员不需要备案)</div>'
						});
					}
				});
			});
		}
	
		//新增安全员
		function save(){
			//时间判断函数
			function pad2(n) { return n < 10 ? '0' + n : n }
			var id = $('#addSecurityInfo input[name="id"]').val();
			var name = $('#addSecurityInfo input[name="name"]').val();
			var sex = $('#addSecurityInfo input[name="sex"]:checked').val();
			var idcard = $('#addSecurityInfo input[name="idcard"]').val();
			var mobile = $('#addSecurityInfo input[name="mobile"]').val();
			var address = $('#addSecurityInfo textarea[name="address"]').val();
			var drilicence = $('#addSecurityInfo input[name="drilicence"]').val();
			var fstdrilicdate = $('#addSecurityInfo input[name="fstdrilicdate"]').val();
			//驾驶证初领日期
		 	var countryFstdrilicdate;
			if(fstdrilicdate!=""){
				var date = new Date(fstdrilicdate);
				var countryFstdrilicdate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
			}
			var dripermitted = $('#addSecurityInfo select[name="dripermitted"]').val();
			var teachpermitted = $('#addSecurityInfo select[name="teachpermitted"]').val();
			var employstatus = $('#addSecurityInfo input[name="employstatus"]:checked').val();
			var hiredate = $('#addSecurityInfo input[name="hiredate"]').val();
			//入职日期
		 	var countryHiredate;
			if(hiredate!=""){
				var date = new Date(hiredate);
				var countryHiredate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
			}
			var leavedate = $('#addSecurityInfo input[name="leavedate"]').val();
			//离职日期
		 	var countryLeavedate;
			if(leavedate!=""){
				var date = new Date(leavedate);
				var countryLeavedate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
			}
			// 校验表单是否通过
			if( $("#addSecurity .valid-form").Validform().check() != true ){
				
				return
			}
			
			var photoUrl = $('img[name="sPhoto"]').attr("src");
			if(photoUrl==""||photoUrl==null){
				layer.alert("个人相片不能为空");
				return
			}
			/*计时系统用户登录 自动备案*/
				//定义提交到服务端的数据对象
				var fileParam = {
					"type" :'securityguardimg',
					"url" :photoUrl,
					"level" :1
				};
				var photoReturnId=null;
				
				//发送数据到后端保存
				$.post(recordUrl+'/upload/file/url',fileParam,function(urlResult) {
					if (urlResult.errorcode == 0) {
						photoReturnId=urlResult.data.id;
					//定义提交到服务端的数据对象
					var param = {
						"inscode" : insCode,//"2236581429084424",
						"name" : name,
						"sex" : sex,
						"idcard" : idcard,
						"mobile" : mobile,
						"address" : address,
						"photo" : photoReturnId,
						"photoUrl":photoUrl,
						"fingerprint" :null,
						"drilicence" : drilicence,
						"fstdrilicdate" : countryFstdrilicdate,
						"dripermitted" : dripermitted,
						"teachpermitted" : teachpermitted,
						"employstatus" : employstatus,
						"hiredate" : countryHiredate,
						"leavedate" : countryLeavedate
					};
					//发送数据到后端保存
					$.post(recordUrl+'/country/securityguard',param,function(result) {
						if(result.message!=""){
								layer.alert(result.message);
							}
						if (result.errorcode == 0) {
							//定义提交到服务端的数据对象
							var params = {
								"id" : id,
								"insId" :insId,
								"name" : name,
								"sex" : sex,
								"idcard" : idcard,
								"mobile" : mobile,
								"address" : address,
								"drilicence" : drilicence,
								"fstdrilicdate" : fstdrilicdate,
								"dripermitted" : dripermitted,
								"teachpermitted" : teachpermitted,
								"employstatus" : employstatus,
								"hiredate" : hiredate,
								"leavedate" : leavedate,
								"photo" : photoReturnId,
								"photoUrl":photoUrl,
								"secunum":result.data.secunum,
								"photoUrl":photoUrl,
								"isCountry":1
							};
							$.post('${ctx}/security/saveOrUpdate', params, function(result) {
								if (result.code == 200) {
									//隐藏表单
									$('#addSecurity').modal('hide');
									layer.alert("保存成功")
									//刷新表单
									buildDataTable();
								} else {
									layer.alert("保存失败")
									//打开错误提示框
									$('#editorModal').modal('show');
								}
								$('#save_btn').attr('disabled',false);
							});
							}else{
								layer.alert(result.message)
							}
						});
					}else{
						layer.alert(urlResult.message)
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
		$('#upload_buton_img').uploadify({
			'swf' : 'http://upload.91ygxc.com/resources/swfupload.swf',
			'uploader' : 'http://upload.91ygxc.com/FileUpload',
			'height' : '30',
			'width' : '120',
			'fileTypeExts' : '*.jpg;*.JPG;*.jpeg;*.JPEG;*.png;*.PNG;*.gif;*.GIF',
			'fileObjName' : 'file_upload',
			'onUploadSuccess' : function(file, data, response) {
				var datajson = eval("(" + data + ")");
				$("#sPhoto").attr('src', datajson.data.s);
				console.log(data);
			}
		});
		$('#upload_buton_img1').uploadify({
			'swf' : 'http://upload.91ygxc.com/resources/swfupload.swf',
			'uploader' : 'http://upload.91ygxc.com/FileUpload',
			'height' : '30',
			'width' : '120',
			'fileTypeExts' : '*.jpg;*.JPG;*.jpeg;*.JPEG;*.png;*.PNG;*.gif;*.GIF',
			'fileObjName' : 'file_upload',
			'onUploadSuccess' : function(file, data, response) {
				var datajson = eval("(" + data + ")");
				$("#photo").attr('src', datajson.data.s);
				console.log(data);
			}
		});
		function editModal(){
			//重置表单
			var tool = new toolCtrl();
		    tool.clearForm();
			/* 获取id */
			var id = sessionStorage.getItem('tabId');
			if(id === null || id === undefined){
				layer.alert('未选择目标');
			}else{
				if (id) {
					//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
					$.getJSON("${ctx}/security/" + id,function(result) {
						console.log(result);
						if (result.code == 200) {
							var data = result.data;
							$('#updateSecurityInfo input[name="id"]').val(data.id);
							//$('#updateSecurityInfo input[name="inscode"]').val(data.insId);
							$('#updateSecurityInfo input[name="name"]').val(data.name);
							$('#updateSecurityInfo input[name="sex"][value=' + data.sex + ']').prop("checked",true);
							$('#updateSecurityInfo input[name="idcard"]').val(data.idcard);
							$('#updateSecurityInfo input[name="mobile"]').val(data.mobile);
							$('#updateSecurityInfo textarea[name="address"]').val(data.address);
							$('#updateSecurityInfo input[name="drilicence"]').val(data.drilicence);
							$('#updateSecurityInfo input[name="fstdrilicdate"]').val(data.fstdrilicdate);
							$('#updateSecurityInfo select[name="dripermitted"]').val(data.dripermitted);
							$('#updateSecurityInfo select[name="teachpermitted"]').val(data.teachpermitted);
							$('#updateSecurityInfo input[name="employstatus"][value=' + data.employstatus + ']').prop("checked",true);
							$('#updateSecurityInfo input[name="hiredate"]').val(data.hiredate);
							$('#updateSecurityInfo input[name="leavedate"]').val(data.leavedate);
							$('img[name="photo"]').attr("src",data.photoUrl);
							$('#secunumId').val(data.secunum);
							$('#isCountryId').val(data.isCountry);
							
						}
						$('#updateSecurity').modal('show');
					});
				}
			}	
		}
		//修改安全员
		function update(){
			//时间判断函数
			function pad2(n) { return n < 10 ? '0' + n : n }
			var id = $('#updateSecurityInfo input[name="id"]').val();
			var name = $('#updateSecurityInfo input[name="name"]').val();
			var sex = $('#updateSecurityInfo input[name="sex"]:checked').val();
			var idcard = $('#updateSecurityInfo input[name="idcard"]').val();
			var mobile = $('#updateSecurityInfo input[name="mobile"]').val();
			var address = $('#updateSecurityInfo textarea[name="address"]').val();
			var drilicence = $('#updateSecurityInfo input[name="drilicence"]').val();
			var fstdrilicdate = $('#updateSecurityInfo input[name="fstdrilicdate"]').val();
			//驾驶证初领日期
		 	var countryFstdrilicdate;
			if(fstdrilicdate!=""){
				var date = new Date(fstdrilicdate);
				var countryFstdrilicdate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
			}
			var dripermitted = $('#updateSecurityInfo select[name="dripermitted"]').val();
			var teachpermitted = $('#updateSecurityInfo select[name="teachpermitted"]').val();
			var employstatus = $('#updateSecurityInfo input[name="employstatus"]:checked').val();
			var hiredate = $('#updateSecurityInfo input[name="hiredate"]').val();
			//入职日期
		 	var countryHiredate;
			if(hiredate!=""){
				var date = new Date(hiredate);
				var countryHiredate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
			}
			var leavedate = $('#updateSecurityInfo input[name="leavedate"]').val();
			//离职日期
		 	var countryLeavedate;
			if(leavedate!=""){
				var date = new Date(leavedate);
				var countryLeavedate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
			}
			//安全员编号
			var secunum=$("#secunumId").val();
			// 校验表单是否通过
			if( $("#updateSecurity .valid-form").Validform().check() != true ){
				
				return
			}
			var photoUrl = $('img[name="photo"]').attr("src");
			if(photoUrl==""||photoUrl==null){
				layer.alert("个人相片不能为空");
				return
			}
			var isCountry=$('#isCountryId').val();
			/*计时系统用户登录 自动备案*/
			if(isTimeSystem() && isCountry!=null && isCountry==1){
				//定义提交到服务端的数据对象
				var fileParam = {
					"type" :'securityguardimg',
					"url" :photoUrl,
					"level" :2
				};
				var photoReturnId=null;
				//发送数据到后端保存
				$.post(recordUrl+'/upload/file/url',fileParam,function(urlResult) {
						if (urlResult.errorcode == 0) {
							photoReturnId=urlResult.data.id;
						//定义提交到服务端的数据对象
						var param = {
							"inscode" : insCode,//"2236581429084424",
							"secunum":secunum,
							"name" : name,
							"sex" : sex,
							"idcard" : idcard,
							"mobile" : mobile,
							"address" : address,
							"photo" : photoReturnId,
							"fingerprint" :null,
							"drilicence" : drilicence,
							"fstdrilicdate" : countryFstdrilicdate,
							"dripermitted" : dripermitted,
							"teachpermitted" : teachpermitted,
							"employstatus" : employstatus,
							"hiredate" : countryHiredate,
							"leavedate" : countryLeavedate
						};
						//发送数据到后端保存
						$.post(recordUrl+'/province/securityguard',param,function(result) {
							if (result.errorcode == 0) {
								//定义提交到服务端的数据对象
								var params = {
									"id" : id,
									"insId" :insId,
									"name" : name,
									"sex" : sex,
									"idcard" : idcard,
									"mobile" : mobile,
									"address" : address,
									"drilicence" : drilicence,
									"fstdrilicdate" : fstdrilicdate,
									"dripermitted" : dripermitted,
									"teachpermitted" : teachpermitted,
									"employstatus" : employstatus,
									"hiredate" : hiredate,
									"leavedate" : leavedate,
									"photo" : photoReturnId,
									"secunum": secunum,//"9073256753174430",//result.data.secunum,
									"photoUrl":photoUrl,
									"isProvince":1
								};
								$.post('${ctx}/security/saveOrUpdate', params, function(result) {
									if (result.code == 200) {
										//隐藏表单
										$('#updateSecurity').modal('hide');
										layer.alert("保存成功")
										//刷新表单
										buildDataTable();
									} else {
										layer.alert("保存失败")
										//打开错误提示框
										$('#editorModal').modal('show');
									}
									$('#save_btn').attr('disabled',false);
								});
							}else{
								layer.alert(result.message)
							}
						});
					}else{
						layer.alert(urlResult.message)
					}
				});
			}else{
				//定义提交到服务端的数据对象
				var params = {
					"id" : id,
					"insId" :insId,
					"name" : name,
					"sex" : sex,
					"idcard" : idcard,
					"mobile" : mobile,
					"address" : address,
					"drilicence" : drilicence,
					"fstdrilicdate" : fstdrilicdate,
					"dripermitted" : dripermitted,
					"teachpermitted" : teachpermitted,
					"employstatus" : employstatus,
					"hiredate" : hiredate,
					"leavedate" : leavedate,
					"secunum": secunum,//"9073256753174430",//result.data.secunum,
					"photoUrl":photoUrl,
					"isProvince":0
				};
				$.post('${ctx}/security/saveOrUpdate', params, function(result) {
					if (result.code == 200) {
						//隐藏表单
						$('#updateSecurity').modal('hide');
						layer.alert("保存成功")
						//刷新表单
						buildDataTable();
					} else {
						layer.alert("保存失败")
						//打开错误提示框
						$('#editorModal').modal('show');
					}
					$('#save_btn').attr('disabled',false);
				});
			}
	}  	
		
		
	function changeStatus(id) {
		window.location.href="${ctx}/trainingCar/"+id+"?"+id;
	}
	function addModal(){
		$('#addSecurityInfo input[name="sex"][value="1"]').prop("checked",true);
		$('#addSecurityInfo select[name="dripermitted"]').val('A1');
		$('#addSecurityInfo select[name="teachpermitted"]').val('A1');
		var tool = new toolCtrl();
	    tool.clearForm();
	    $('#addSecurity').modal('show');
	}
	
	
	function deletes(){
		var id=sessionStorage.getItem('tabId')
		if(id === null || id === undefined){
			layer.alert('未选择目标');
		}else{
		$.getJSON("${ctx}/security/" + id, function(result) {
			if (result.code == 200) {
				var data = result.data;
				if (data.employstatus == 0) {
					var gnl = confirm("阳光驾培温馨提示,您确定要更改状态吗?");
					if (gnl == true) {
						var isProvince=data.isProvince;
						/*计时系统用户登录 自动备案*/
						/* if(isProvince==1){ */
							//备案到省
							var secunum=$("#secunumId").val();
							var param={"secunum":data.secunum};
							$.post(recordUrl+"/province/securityguard/delete",param,function(result){
								if(result.errorcode == 0){
									//定义提交到服务端的数据对象
									var params = {
										'id' : id
									};
									//发送数据到后端保存
								 	$.post('${ctx}/security/updatestatus', params,
											function(result) {
												if (result.code == 200) {
													//保存成功 刷新列表
													layer.alert('更改成功');
												}else{
													layer.alert('更改失败,错误代码'+result.code)
												}
												buildDataTable();
											}); 
									return true;
								}else{
									//layer.alert('更改失败,错误代码'+result.code)
									layer.alert(result.message);
								}
							});
						}else{
								layer.alert("尚未省备案！");
								return false;
							}
					} else {
						return false
					}
				} else {
					layer.alert("已更改")
				}
			/* }; */
		})
	}
	}
	//查看详情
	function viewModal(id){
		//重置表单
		var tool = new toolCtrl();
	    tool.clearForm();
		//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
		$.getJSON("${ctx}/security/" + id,function(result) {
			console.log(result);
			if (result.code == 200) {
				var data = result.data;
				$('#viewSecurityInfo input[name="id"]').val(data.id);
				$('#viewSecurityInfo input[name="inscode"]').val(data.insId);
				$('#viewSecurityInfo input[name="name"]').val(data.name);
				$('#viewSecurityInfo input[name="sex"][value=' + data.sex + ']').prop("checked",true);
				$('#viewSecurityInfo input[name="idcard"]').val(data.idcard);
				$('#viewSecurityInfo input[name="mobile"]').val(data.mobile);
				$('#viewSecurityInfo textarea[name="address"]').val(data.address);
				$('#viewSecurityInfo input[name="drilicence"]').val(data.drilicence);
				$('#viewSecurityInfo input[name="fstdrilicdate"]').val(data.fstdrilicdate);
				$('#viewSecurityInfo select[name="dripermitted"]').val(data.dripermitted);
				$('#viewSecurityInfo select[name="teachpermitted"]').val(data.teachpermitted);
				$('#viewSecurityInfo input[name="employstatus"][value=' + data.employstatus + ']').prop("checked",true);
				$('#viewSecurityInfo input[name="hiredate"]').val(data.hiredate);
				$('#viewSecurityInfo input[name="leavedate"]').val(data.leavedate);
				$('#viewSecurityInfo img[name="photo"]').attr("src",data.photoUrl);
			}
			$('#viewSecurity').modal('show');
		});
	}
	function exportFile(){
		window.location.href="${ctx}/security/exportSecurity?insId="+insId;
	}
	</script>
</body>
</html>