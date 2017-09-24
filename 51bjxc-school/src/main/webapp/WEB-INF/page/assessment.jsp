<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-考核员管理</title>
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
			<a class="select-btn" data-toggle="modal" data-target="#editExaminer" onclick="editModal()"><span class="edit" ></span>修改</a>
			<a class="select-btn" onclick="deletes()"><span class="del"></span>删除</a>
			<a class="select-btn" onClick="upRecord()"><span class="spare"></span>备案</a>
			<a class="select-btn" onClick="uploadAll()"><span class="spare"></span>批量备案</a>
			<a class="select-btn" id="uploadCoachExcId" onclick="clickFile()"><span class="Import"></span>导入</a>
			<a class="select-btn" onclick="exportFile();" ><span class="Export"></span>导出</a>
		</sec:authorize>
		
		<sec:authorize access="hasRole('ROLE_SCHOOL_SERVICE')">
			<sec:authorize access="hasRole('ROLE_UserOperation_17')">
				<a class="select-btn" data-toggle="modal" onclick="addModal()"><span class="add"></span>新增</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_18')">
				<a class="select-btn" data-toggle="modal" data-target="#editExaminer" onclick="editModal()"><span class="edit" ></span>修改</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_19')">
				<a class="select-btn" onclick="deletes()"><span class="del"></span>删除</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_20')">
				<a class="select-btn" onClick="upRecord()"><span class="spare"></span>备案</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_21')">
				<a class="select-btn" onClick="uploadAll()"><span class="spare"></span>批量备案</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_22')">
				<a class="select-btn" id="uploadCoachExcId" onclick="clickFile()"><span class="Import"></span>导入</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_23')">
				<a class="select-btn" onclick="exportFile();" ><span class="Export"></span>导出</a>
			</sec:authorize>
		</sec:authorize>
		</div>
	</div>
	<div class="TermSearch">
 	 <form>
	 <input class="input1 win200" type="text" id="search" placeholder="身份证号/手机号码/考核员姓名搜索">
	 <buuton class="btn-flat primary" onClick="searchQuery();return false;">搜 索</buuton>
	 </form>
	</div>
	<div style="display: none">
		<form method="POST" enctype="multipart/form-data" id="uploadExcId"
			action="${ctx}/examiner/InsertExaminerToDB">
			<input id="upfile" type="file" name="upExaminerfile"
				onchange="clickAjaxSubmit()" /> <input type="button"
				id="ajaxUploadId" />
		</form>
	</div>
	<!-- 列表 -->
	<div class="row-fluid">
		<div class="sub_content">
			<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
			<div id="table_list" class="gri_wrapper"></div>
		</div>
	</div>
	<!-- 新增-->
	<div class="modal fade colsform" id="addExaminer" tabindex="-1" role="dialog" aria-hidden="true">	
		<form id="addExaminerInfo" class="form-horizontal valid-form">
			<h4>新增考核员</h4>
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
							<input type="text" name="drilicence" datatype="*" nullmsg="驾驶证号不能为空" sucmsg=" ">
						</div>
						<div class="form-controll">
							<label style="width:105px;">驾驶证初领日期:</label>
							<input type="text" name="fstdrilicdate"  class="form_date" style="width:172px;" data-date-format="yyyy-mm-dd"
							  readonly="readonly"	datatype="*" nullmsg="驾驶证初领日期不能为空" sucmsg=" ">
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
							<label>职业资格证号:</label>
							<input type="text" name="occupationno" value="">
						</div>
						<div class="form-controll">
							<label>职业资格等级:</label>
							<input type="radio" name="occupationlevel" value="1" checked> 一级
							<input type="radio" name="occupationlevel" value="2"> 二级
							<input type="radio" name="occupationlevel" value="3"> 三级
							<input type="radio" name="occupationlevel" value="4"> 四级
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>入职时间:</label>
							<input type="text" name="hiredate"  class="form_date" data-date-format="yyyy-mm-dd" readonly="readonly" datatype="*" nullmsg="入职时间不能为空" sucmsg=" ">
						</div>
						<div class="form-controll">
							<label>供职状态:</label>
							<input type="radio" name="employstatus" value="0" checked datatype="*" nullmsg="供职不能为空" sucmsg=" ">在职
							<input type="radio" name="employstatus" value="1" datatype="*" nullmsg="供职不能为空" sucmsg=" "> 离职
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
	<div class="modal fade colsform" id="updateExaminer" tabindex="-1" role="dialog" aria-hidden="true">	
		<form id="updateExaminerInfo" class="form-horizontal valid-form">
			<h4>修改考核员</h4>
			<input type="hidden" id="coachIdd" value="">
			<div class="modal-content">
				<div class="left">
					<div class="row1">
						<input type="hidden" name="examnum" id="examnumId" >
						<input type="hidden" name="iscountry" /><!-- 全国备案 -->
						<div class="form-controll">
							<label>姓名:</label>
							<input type="text" name="name" value="" datatype="*" nullmsg="姓名不能为空" sucmsg=" ">
							<input type="hidden" name="id" id="id" >
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
							<input type="text" name="drilicence" datatype="*" nullmsg="驾驶证号不能为空" sucmsg=" ">
						</div>
						<div class="form-controll">
							<label style="width:105px;">驾驶证初领日期:</label>
							<input type="text" name="fstdrilicdate"  class="form_date" style="width:172px;" data-date-format="yyyy-mm-dd"
								readonly="readonly" datatype="*" nullmsg="驾驶证初领日期不能为空" sucmsg=" ">
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
							<label>职业资格证号:</label>
							<input type="text" name="occupationno" value="">
						</div>
						<div class="form-controll">
							<label>职业资格等级:</label>
							<input type="radio" name="occupationlevel" value="1" checked> 一级
							<input type="radio" name="occupationlevel" value="2"> 二级
							<input type="radio" name="occupationlevel" value="3"> 三级
							<input type="radio" name="occupationlevel" value="4"> 四级
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>入职时间:</label>
							<input type="text" name="hiredate"  class="form_date" data-date-format="yyyy-mm-dd" readonly="readonly"
								datatype="*" nullmsg="入职时间不能为空" sucmsg=" ">
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
					<button type="button" class="btn btn-primary" onclick="update();">修改</button>
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
	<div class="modal fade colsform" id="viewExaminer" tabindex="-1" role="dialog" aria-hidden="true">	
		<form id="viewExaminerInfo" class="form-horizontal valid-form">
			<h4>考核员信息</h4>
			<input type="hidden" id="coachIdd" value="">
			<div class="modal-content">
				<div class="left">
					<div class="row1">
						<div class="form-controll">
							<label>姓名:</label>
							<input type="text" name="name" value="" disabled>
							<input type="hidden" name="id" id="id" >
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
							<input type="text" name="fstdrilicdate"  class="form_date" style="width:172px;" data-date-format="yyyy-mm-dd"
								readonly="readonly" disabled>
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
							<label>职业资格证号:</label>
							<input type="text" name="occupationno" value="" disabled>
						</div>
						<div class="form-controll">
							<label>职业资格等级:</label>
							<input type="radio" name="occupationlevel" value="1" checked disabled> 一级
							<input type="radio" name="occupationlevel" value="2" disabled> 二级
							<input type="radio" name="occupationlevel" value="3" disabled> 三级
							<input type="radio" name="occupationlevel" value="4" disabled> 四级
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>入职时间:</label>
							<input type="text" name="hiredate"  class="form_date" data-date-format="yyyy-mm-dd" readonly="readonly" disabled>
						</div>
						<div class="form-controll">
							<label>供职状态:</label>
							<input type="radio" name="employstatus" value="0" checked disabled>在职
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
	function pad2(n) { return n < 10 ? '0' + n : n }
	var date = new Date();
	var time = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate()) + pad2( date.getHours() ) + pad2( date.getMinutes() ) + pad2( date.getSeconds() )
		//标识当前页面的url 用来设置当前菜单标识
		var dataTable = null;
		var insId= '<sec:authentication property="principal.insId"/>';
		var insName = '<sec:authentication property="principal.insName"/>';
		var statId= '<sec:authentication property="principal.stationId"/>';
		
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
		        	   if(statId!='null'){
		        		   var param={"stationId":statId};
		        	   }else{
		        		   var param={"stationId":-1};//数据库默认值
		        	   }
		               $('#uploadExcId').ajaxSubmit({
		                   url:'${ctx}/examiner/InsertExaminerToDB',
		                   data:param,
		                   dataType: 'json',  
		                   success: function resutlMsg(result){
			            	   $("#upfile").val("");
			            	   if(result.code==200){
			            		   layer.alert("导入数据成功!")
				            		//保存成功 刷新列表
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
				
				'examnum' : {
					'thText' : '考核员编号',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<span data-id="');
							td.push(record.id);
							td.push('">');
							td.push(record.examnum);
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
				'sex' : {
					'thText' : '性别',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						td = [];
						td.push('<ul class="info">');
							td.push('<li>');
								if (value ==  1) {
									td.push('男');
								} else if (value == 2) {
									td.push('女');
								}
							td.push('</li>');
						td.push('</ul>');
						return td.join('');
					}
				},
				'mobile' : {
					'thText' : '电话号码',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'idcard' : {
					'thText' : '身份证号',
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
					'thText' : ' ',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'width' : '150px',
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						$("#batch").append(record.id+",");
						td.push('<button class="btn btn-success" onClick="viewModal('+record.id+');">查看详情</button>');
						td.push('<ul class="actions">');
						td.push('</ul>');
						return td.join('');
					}
				}
			};
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/examiner/list?insId='+insId,
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
			$.getJSON("${ctx}/examiner/" + id, function(result) {
				var data = result.data;
				//弹出提示框 让用户上传备案
				var dialog = new GRI.Dialog({
					type : 4,
					title : '上传备案',
					content : '确定上传【' + data.name + '】考核员备案吗？',
					deGRIil : '',
					btnType : 1,
					extra : {
						top : 250
					},
					winSize : 1
				}, function() {
					//时间判断函数
					function pad2(n) {
						return n < 10 ? '0' + n : n
					}
					//驾驶证初领日期
					var fstdrilicdate;
					if (data.fstdrilicdate != null) {
						var date = new Date(data.fstdrilicdate);
						var fstdrilicdate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2(date.getDate())
					}
					//入职日期
					var hiredate;
					if (data.hiredate != null) {
						var date = new Date(data.hiredate);
						var hiredate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2(date.getDate())
					}
					//离职日期
					var leavedate;
					if (data.leavedate != null) {
						var date = new Date(data.leavedate);
						var leavedate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2(date.getDate())
					}
					var isCountry = data.isCountry;
					/*计时系统用户登录 自动备案
					if(isTimeSystem()){//是否计时系统用户登录,是否全国备案*/
					if (isCountry != null && isCountry == 1) {
						//定义提交到服务端的数据对象
						var fileParam = {
							"type" : 'examinerimg',
							"url" : data.photourl,
							"level" : 2
						};
						//发送数据到后端保存
						$.post(recordUrl + '/upload/file/url', fileParam, function(urlResult) {
							if (urlResult.errorcode == 0) {
								//定义提交到服务端的数据对象
								var params = {
									'inscode' : insCode,
									'name' : data.name,
									'sex' : data.sex,
									'idcard' : data.idcard,
									'mobile' : data.mobile,
									'address' : data.address,
									'photo' : urlResult.data.id,
									'fingerprint' : data.fingerprint,
									'drilicence' : data.drilicence,
									'fstdrilicdate' : fstdrilicdate,
									'dripermitted' : data.dripermitted,
									'teachpermitted' : data.teachpermitted,
									'employstatus' : data.employstatus,
									'hiredate' : hiredate,
									'leavedate' : leavedate,
									'occupationno' : data.occupationno,
									'occupationlevel' : data.occupationlevel,
									"examnum" : data.examnum
								};
								//发送数据到后端保存
								$.post(recordUrl + '/province/examiner', params, function(results) {
									if (results.errorcode == 0) {
										//定义提交到服务端的数据对象
										var params = {
											"id" : id,
											"isProvince" : 1
										};
										$.post('${ctx}/examiner/saveOrUpdate', params, function(result) {
											if (result.code == 200) {
												//隐藏表单
												$('#addExaminer').modal('hide');
												//打开错误提示框
												layer.alert("备案成功");
												//刷新表单
												buildDataTable();
											} else {
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
								'<div style="text-align:center;">该考核员没有国家平台备案的考核员编号,不能上传省平台备案!</br>(在计时平台对接前录入的学员不需要备案)</div>'
						});
					}
				});
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
		
		
		function save(){
			//时间判断函数
			function pad2(n) { return n < 10 ? '0' + n : n }
			
			var id = $('#addExaminerInfo input[name="id"]').val();
			var name = $('#addExaminerInfo input[name="name"]').val();
			var sex = $('#addExaminerInfo input[name="sex"]:checked').val();
			var idcard = $('#addExaminerInfo input[name="idcard"]').val();
			var mobile = $('#addExaminerInfo input[name="mobile"]').val();
			var address = $('#addExaminerInfo textarea[name="address"]').val();
			var drilicence = $('#addExaminerInfo input[name="drilicence"]').val();
			//驾驶证初领日期
			var fstdrilicdate = $('#addExaminerInfo input[name="fstdrilicdate"]').val();
			var countryFstdrilicdate;
			if(fstdrilicdate!=""){
				var date = new Date(fstdrilicdate);
				var countryFstdrilicdate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
			}    
			var dripermitted = $('#addExaminerInfo select[name="dripermitted"]').val();
			var teachpermitted = $('#addExaminerInfo select[name="teachpermitted"]').val();
			var employstatus = $('#addExaminerInfo input[name="employstatus"]:checked').val();
			//入职时间
			var hiredate = $('#addExaminerInfo input[name="hiredate"]').val();
			var countryHiredate;
			if(hiredate!=""){
				var date = new Date(hiredate);
				var countryHiredate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
			}
		    //离职时间
			var leavedate = $('#addExaminerInfo input[name="leavedate"]').val();
		    var countryLeavedate;
			if(leavedate!=""){
				var date = new Date(leavedate);
				var countryLeavedate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
			}
			var photoUrl = $('img[name="sPhoto"]').attr("src");
			if(photoUrl==""||photoUrl==null){
				layer.alert("个人相片不能为空");
				return
			}
			var occupationno = $('#addExaminerInfo input[name="occupationno"]').val();
			var occupationlevel = $('#addExaminerInfo input[name="occupationlevel"]:checked').val();
			// 校验表单是否通过
			if( $("#addExaminer .valid-form").Validform().check() != true ){
				
				return
			}
			/*计时系统用户登录 自动备案
			if(isTimeSystem()){*/
				//定义提交到服务端的数据对象
				var fileParam = {
					"type" :'examinerimg',
					"url" :photoUrl,
					"level" :1
				};
				var photoReturnId=null;
				
				//发送数据到后端保存
				$.post(recordUrl+'/upload/file/url',fileParam,function(urlResult) {
					if (urlResult.errorcode == 0) {
					//返回的图片id
					photoReturnId=urlResult.data.id;
					//定义提交到服务端的数据对象
					var param = {
						"inscode" : insCode,
						"name" : name,
						"sex" : sex,
						"idcard" : idcard,
						"mobile" : mobile,
						"address" : address,
						"photo" : photoReturnId,
						"fingerprint":null,//没有要求指纹图片
						"drilicence" : drilicence,
						"fstdrilicdate" :countryFstdrilicdate,
						"occupationno" : occupationno,
						"occupationlevel" : occupationlevel,
						"dripermitted" : dripermitted,
						"teachpermitted" : teachpermitted,
						"employstatus" : employstatus,
						"hiredate" : countryHiredate,
						"leavedate" : countryLeavedate
					};
					//发送数据到后端保存
					$.post(recordUrl+'/country/examiner',param,function(result) {
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
								"occupationno" : occupationno,
								"occupationlevel" :occupationlevel,
								"photourl":photoUrl,
								"examnum": result.data.examnum,
								"isCountry":1
							};
							$.post('${ctx}/examiner/saveOrUpdate', params, function(result) {
								if (result.code == 200) {
									//隐藏表单
									$('#addExaminer').modal('hide');
									//打开错误提示框
									layer.alert("保存成功")
									//刷新表单
									buildDataTable();
								} else {
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
			/* }else{
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
					"occupationno" : occupationno,
					"occupationlevel" :occupationlevel,
					"photourl":photoUrl,
					"isCountry":0
				};
				$.post('${ctx}/examiner/saveOrUpdate', params, function(result) {
					if (result.code == 200) {
						//隐藏表单
						$('#addExaminer').modal('hide');
						//打开错误提示框
						layer.alert("保存成功")
						//刷新表单
						buildDataTable();
					} else {
						//打开错误提示框
						$('#editorModal').modal('show');
					}
					$('#save_btn').attr('disabled',false);
				});
			} */
			
		} 
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
					$.getJSON("${ctx}/examiner/" + id,function(result) {
						console.log(result);
						if (result.code == 200) {
							var data = result.data;
							$('#updateExaminerInfo input[name="id"]').val(data.id);
							$('#updateExaminerInfo input[name="inscode"]').val(data.inscode);
							$('#updateExaminerInfo input[name="name"]').val(data.name);
							$('#updateExaminerInfo input[name="sex"][value=' + data.sex + ']').attr("checked",true);
							$('#updateExaminerInfo input[name="idcard"]').val(data.idcard);
							$('#updateExaminerInfo input[name="mobile"]').val(data.mobile);
							$('#updateExaminerInfo textarea[name="address"]').val(data.address);
							$('#updateExaminerInfo input[name="drilicence"]').val(data.drilicence);
							$('#updateExaminerInfo input[name="fstdrilicdate"]').val(data.fstdrilicdate);
							$('#updateExaminerInfo select[name="dripermitted"]').val(data.dripermitted);
							$('#updateExaminerInfo select[name="teachpermitted"]').val(data.teachpermitted);
							$('#updateExaminerInfo input[name="employstatus"][value=' + data.employstatus + ']').attr("checked",true);
							$('#updateExaminerInfo input[name="hiredate"]').val(data.hiredate);
							$('#updateExaminerInfo input[name="leavedate"]').val(data.leavedate);
							$('img[name="photo"]').attr("src",data.photourl);
							$('#updateExaminerInfo input[name="occupationno"]').val(data.occupationno);
							$('#updateExaminerInfo input[name="occupationlevel"][value=' + data.occupationlevel + ']').attr("checked",true);
							$('#updateExaminerInfo input[name="iscountry"]').val(data.isCountry);
							$('#examnumId').val(data.examnum);
						}
					});
				}
				$('#updateExaminer').modal('show');
			}	
		}
		function update(){
			
			//时间判断函数
			function pad2(n) { return n < 10 ? '0' + n : n }
			
			var id = $('#updateExaminerInfo input[name="id"]').val();
			var photoUrl = $('#updateExaminerInfo input[name="photo"]').val();
			var name = $('#updateExaminerInfo input[name="name"]').val();
			var sex = $('#updateExaminerInfo input[name="sex"]:checked').val();
			var idcard = $('#updateExaminerInfo input[name="idcard"]').val();
			var mobile = $('#updateExaminerInfo input[name="mobile"]').val();
			var address = $('#updateExaminerInfo textarea[name="address"]').val();
			var drilicence = $('#updateExaminerInfo input[name="drilicence"]').val();
			//驾驶证初领日期
			var fstdrilicdate = $('#updateExaminerInfo input[name="fstdrilicdate"]').val();
			var countryFstdrilicdate;
			if(fstdrilicdate!=""){
				var date = new Date(fstdrilicdate);
				var countryFstdrilicdate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
			}    
			var dripermitted = $('#updateExaminerInfo select[name="dripermitted"]').val();
			var teachpermitted = $('#updateExaminerInfo select[name="teachpermitted"]').val();
			var employstatus = $('#updateExaminerInfo input[name="employstatus"]:checked').val();
			//入职时间
			var hiredate = $('#updateExaminerInfo input[name="hiredate"]').val();
			var countryHiredate;
			if(hiredate!=""){
				var date = new Date(hiredate);
				var countryHiredate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
			}
		    //离职时间
			var leavedate = $('#updateExaminerInfo input[name="leavedate"]').val();
		    var countryLeavedate;
			if(leavedate!=""){
				var date = new Date(leavedate);
				var countryLeavedate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
			}
			var occupationno = $('#updateExaminerInfo input[name="occupationno"]').val();
			var occupationlevel = $('#updateExaminerInfo input[name="occupationlevel"]:checked').val();
			var examnum=$("#examnumId").val();
			// 校验表单是否通过
			if( $("#updateExaminer .valid-form").Validform().check() != true ){
				
				return
			}
			//定义提交到服务端的数据对象
			var params = {
				"id" : id,
				"insId" : insId,
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
				"occupationno" : occupationno,
				"occupationlevel" :occupationlevel,
				"photourl":photoUrl,
			};
			$.post('${ctx}/examiner/saveOrUpdate', params, function(result) {
				if (result.code == 200) {
					//隐藏表单
					$('#updateExaminer').modal('hide');
					layer.alert("保存成功")
					//刷新表单
					buildDataTable();
				} else {
					//打开错误提示框
					layer.alert("保存失败")
					$('#editorModal').modal('show');
				}
				$('#save_btn').attr('disabled',false);
			});
		} 
		function changeStatus(id) {
			window.location.href="${ctx}/trainingCar/"+id+"?"+id;
		}
		//打开新增窗体
		function addModal(){
			//重置表单
			var tool = new toolCtrl();
		    tool.clearForm();
			$('#addExaminer').modal('show');
		}
		
		//删除
		function deletes(){
			var id=sessionStorage.getItem('tabId')
			if(id === null || id === undefined){
				layer.alert('未选择目标');
			}else{
			$.getJSON("${ctx}/examiner/" + id, function(result) {
				if (result.code == 200) {
					var data = result.data;
					if (data.employstatus == 0) {
						var gnl = confirm("阳光驾培温馨提示,您确定要删除吗?");
						if (gnl == true) {
							var isProvince=data.isProvince;
							/*计时系统用户登录 自动备案*/
							/* if(isProvince==1){ */
								//备案到省
								var examnum=$("#examnumId").val();
								var param={"examnum":data.examnum};
								$.post(recordUrl+"/province/examiner/delete",param,function(result){
									if(result.errorcode == 0){
										//定义提交到服务端的数据对象
										var params = {
											'id' : id
										};
										//发送数据到后端保存
									 	$.post('${ctx}/examiner/updatestatus', params,
												function(result) {
													if (result.code == 200) {
														//保存成功 刷新列表
														layer.alert('删除成功');	 
														buildDataTable();
													}else{
														layer.alert('删除失败,错误代码'+result.code)
													}
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
		function viewModal(id){
			//重置表单
			var tool = new toolCtrl();
		    tool.clearForm();
			//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
			$.getJSON("${ctx}/examiner/" + id,function(result) {
				console.log(result);
				if (result.code == 200) {
					var data = result.data;
					$('#viewExaminerInfo input[name="id"]').val(data.id);
					$('#viewExaminerInfo input[name="inscode"]').val(data.inscode);
					$('#viewExaminerInfo input[name="name"]').val(data.name);
					$('#viewExaminerInfo input[name="sex"][value=' + data.sex + ']').attr("checked",true);
					$('#viewExaminerInfo input[name="idcard"]').val(data.idcard);
					$('#viewExaminerInfo input[name="mobile"]').val(data.mobile);
					$('#viewExaminerInfo textarea[name="address"]').val(data.address);
					$('#viewExaminerInfo input[name="drilicence"]').val(data.drilicence);
					$('#viewExaminerInfo input[name="fstdrilicdate"]').val(data.fstdrilicdate);
					$('#viewExaminerInfo select[name="dripermitted"]').val(data.dripermitted);
					$('#viewExaminerInfo select[name="teachpermitted"]').val(data.teachpermitted);
					$('#viewExaminerInfo input[name="employstatus"][value=' + data.employstatus + ']').attr("checked",true);
					$('#viewExaminerInfo input[name="hiredate"]').val(data.hiredate);
					$('#viewExaminerInfo input[name="leavedate"]').val(data.leavedate);
					$('#viewExaminerInfo img[name="photo"]').attr("src",data.photourl);
					$('#viewExaminerInfo input[name="occupationno"]').val(data.occupationno);
					$('#viewExaminerInfo input[name="occupationlevel"][value=' + data.occupationlevel + ']').attr("checked",true);
					
				}
				$('#viewExaminer').modal('show');
			});
		}
		function exportFile(){
			window.location.href="${ctx}/examiner/exportExaminer?insId="+insId;
		}
	</script>
</body>
</html>