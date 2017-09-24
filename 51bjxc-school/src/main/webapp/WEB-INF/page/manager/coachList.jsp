<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>

<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-教练管理</title>
<link type="text/css" href="${ctx}/resources/css/compiled/new-form.css" rel="stylesheet" />
<link href="${ctx}/resources/css/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen" />
<link href="${ctx}/resources/js/form-prompt/style.css" type="text/css" rel="stylesheet" media="all" />
<script type="text/javascript" src="${ctx}/resources/js/form-prompt/Validform_v5.3.2_min.js"></script>
<script src="${ctx}/resources/uploadify/jquery.uploadify.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/drivingFied/<sec:authentication property="principal.insId"/>"></script>
<script type="text/javascript" src="${ctx}/resources/js/Area/<sec:authentication property="principal.insId"/>"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery-form.js"></script>
</head>
<body>
	<div class="container-fluid new-admin">
		<div class="select-top">
			<sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
				<a class="select-btn" data-toggle="modal" onclick="addCoach();"><span class="add"></span>新增</a>
				<a class="select-btn" data-toggle="modal" onclick="editModal()"><span class="edit" ></span>修改</a>
				<a class="select-btn " onclick="deletes()"><span class="del"></span>删除</a>
				<sec:authorize access="hasRole('ROLE_TIME_SYSTEM')">
					<a class="select-btn" data-toggle="modal" onclick="uploadRecord();"><span class="spare"></span>备案</a>
					<a class="select-btn" data-toggle="modal" onclick="uploadAll();"><span class="spare"></span>批量备案</a>
				</sec:authorize>
				<a class="select-btn" id="uploadCoachExcId" onclick="clickFile()"><span class="Import"></span>导入</a>
				<a class="select-btn" onclick="exportFile();"><span class="Export"></span>导出</a>
			</sec:authorize>
			
			<sec:authorize access="hasRole('ROLE_SCHOOL_SERVICE')">
			
				
				<sec:authorize access="hasRole('ROLE_UserOperation_10')">
					<a class="select-btn" data-toggle="modal" onclick="addCoach();"><span class="add"></span>新增</a>
				</sec:authorize>
				<sec:authorize access="hasRole('ROLE_UserOperation_11')">
					<a class="select-btn" data-toggle="modal" onclick="editModal()"><span class="edit" ></span>修改</a>
				</sec:authorize>
				<sec:authorize access="hasRole('ROLE_UserOperation_12')">
					<a class="select-btn " onclick="deletes()"><span class="del"></span>删除</a>
				</sec:authorize>
				
				<sec:authorize access="hasRole('ROLE_TIME_SYSTEM')">
					<sec:authorize access="hasRole('ROLE_UserOperation_13')">
						<a class="select-btn" data-toggle="modal" onclick="uploadRecord();"><span class="spare"></span>备案</a>
					</sec:authorize>
					<sec:authorize access="hasRole('ROLE_UserOperation_16')">
						<a class="select-btn" data-toggle="modal" onclick="uploadAll();"><span class="spare"></span>批量备案</a>
					</sec:authorize>				
				</sec:authorize>
				<sec:authorize access="hasRole('ROLE_UserOperation_14')">
					<a class="select-btn" id="uploadCoachExcId" onclick="clickFile()"><span class="Import"></span>导入</a>
				</sec:authorize>
				 
			
				
				<sec:authorize access="hasRole('ROLE_UserOperation_15')">
					<a class="select-btn" onclick="exportFile();"><span class="Export"></span>导出</a>
				</sec:authorize>
			</sec:authorize>
			
			
		</div>
	</div>
	 <div class="TermSearch">
 	 <form>
	 <input class="input1 win200" type="text" id="search" placeholder="身份证号/手机号码/教练姓名搜索">
	 <buuton class="btn-flat primary" onClick="searchQuery();return false;">搜 索</buuton>
	 </form>
	 </div>
	 
	 <div style="display: none">
		<form method="POST" enctype="multipart/form-data" id="uploadExcId"
			action="${ctx}/coach/InsertCoachToDB">
			<input id="upfile" type="file" name="upCoachfile"
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
	<input type="hidden" name="iscountry" />
	<input type="hidden" name="isprovince" />
	<!-- 新增-->
	<div class="modal fade colsform" id="AddCoach" tabindex="-1" role="dialog" aria-hidden="true">	
		<form id="addCoachInfo" class="form-horizontal valid-form">
			<h4>新增教练员</h4>
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
							<input type="text" name="name" datatype="*" errormsg="姓名" nullmsg="姓名不能为空" sucmsg=" ">
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
							<input type="text" name="idcard" datatype="*" nullmsg="身份证不能为空" sucmsg=" ">
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
							<label style="width:110px;">驾驶证初领日期:</label>
							<input type="text" name="receiveTime"  class="form_date" style="width:172px;" data-date-format="yyyy-mm-dd" readonly="readonly"
							datatype="*" nullmsg="初领日期不能为空" sucmsg=" ">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>准驾车型:</label>
							<input type="radio" name="dripermitted" id="dripermitted" value="C1" checked datatype="*" nullmsg="准驾车型不能为空" sucmsg=" ">C1&nbsp;
							<input type="radio" name="dripermitted" id="dripermitted" value="C2" datatype="*" nullmsg="准驾车型不能为空" sucmsg=" ">&nbsp;C2
						</div>
						<div class="form-controll">
							<label>准教车型:</label>
							<input type="radio" name="teachpermitted" id="teachpermitted" value="C1" checked datatype="*" nullmsg="准教车型不能为空" sucmsg=" ">&nbsp;C1
							<input type="radio" name="teachpermitted" id="teachpermitted" value="C2" datatype="*" nullmsg="准教车型不能为空" sucmsg=" ">&nbsp;C2
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label style="height: 40px; line-height: 25px;">片区 :<br>服务网点:</label>
							<select id="area" name="area" datatype="*" nullmsg="片区不能为空" sucmsg=" ">
							</select>
							
							<select id="station" name="station" datatype="*" nullmsg="服务网点能为空" sucmsg=" ">
								<option value="" >请选择</option>
							</select>
						</div>
						<div class="form-controll">
							<label>片区 :<br>练车场地:</label>
							<select id="areas" name="areas" datatype="*" nullmsg="片区不能为空" sucmsg=" ">
							</select>
							<select id="drivingFieldId" name="drivingFieldId" datatype="*" nullmsg="练车场地不能为空" sucmsg=" ">
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
							<label>教练车品牌:</label>
							<input type="text" name="carBrand">
						</div>
						<div class="form-controll">
							<label>教练车车牌:</label>
							<input type="text" name="carPlate">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>带教科目:</label>
							<select name="subject">
  								<option value ="2">科目二</option>
  								<option value ="3">科目三</option>
  								<option value ="0">全科目</option>
							</select>
						</div>
						<div class="form-controll">
							<label>语言:</label>
							<input type="radio" name="language" id="language" value="0" checked="checked">全会
							<input type="radio" name="language" id="language" value="1">普通话
							<input type="radio" name="language" id="language" value="2">粤语
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>供职状态:</label>
							<select name="employstatus" datatype="*" nullmsg="供职状态不能为空" sucmsg=" ">
  								<option value ="0">在职</option>
  								<option value ="1">离职</option>
							</select>
						</div>
						<div class="form-controll">
							<label>入职时间:</label>
							<input type="text" name="hiredate"  class="form_date" data-date-format="yyyy-mm-dd" readonly="readonly"
							 datatype="*" nullmsg="入职时间不能为空" sucmsg=" ">
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
								<span class="pic">个人相片<img id="savePhotoId" name="sPhoto" src="" class="img-thumbnail upload-img" ></span>
								<a style="margin-top:20px; width:100px;" class="btn btn-success">上传</a>
							</div>
							<div class="swfobj swfobj-position">
								<div for="ifileId" id="upload_buton_img"></div>
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
	<!-- 修改-->
	<div class="modal fade colsform" id="editCoach" tabindex="-1" role="dialog" aria-hidden="true">	
		<form id="coachInfo" class="form-horizontal valid-form">
			<h4>修改教练员</h4>
			<div class="modal-content">
				<div class="left">
					<div class="row1">
						<input type="hidden" name="coachnum" />
						<div class="form-controll">
							<label>姓名:</label>
							<input type="text" name="name" datatype="*" errormsg="姓名" nullmsg="姓名不能为空" sucmsg=" ">
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
							<input type="text" name="idcard" datatype="*" nullmsg="身份证不能为空" sucmsg=" ">
							<input type="hidden" name="idcard2" value="">
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
							<label style="width:110px;">驾驶证初领日期:</label>
							<input type="text" name="receiveTime"  class="form_date" style="width:172px;" data-date-format="yyyy-mm-dd" readonly="readonly"
							datatype="*" nullmsg="初领日期不能为空" sucmsg=" ">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>准驾车型:</label>
							<input type="radio" name="dripermitted" id="dripermitted" value="C1" checked datatype="*" nullmsg="准驾车型不能为空" sucmsg=" ">C1&nbsp;
							<input type="radio" name="dripermitted" id="dripermitted" value="C2" datatype="*" nullmsg="准驾车型不能为空" sucmsg=" ">&nbsp;C2
						</div>
						<div class="form-controll">
							<label>准教车型:</label>
							<input type="radio" name="teachpermitted" id="teachpermitted" value="C1" checked datatype="*" nullmsg="准教车型不能为空" sucmsg=" ">&nbsp;C1
							<input type="radio" name="teachpermitted" id="teachpermitted" value="C2" datatype="*" nullmsg="准教车型不能为空" sucmsg=" ">&nbsp;C2
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label style="height: 40px; line-height: 25px;">片区 :<br>服务网点:</label>
							<select id="area" name="area" datatype="*" nullmsg="片区不能为空" sucmsg=" ">
							</select>
							
							<select id="station" name="station" datatype="*" nullmsg="服务网点不能为空" sucmsg=" ">

							</select>
						</div>
						
						<div class="form-controll">
							<label>片区 :<br>练车场地:</label>
							<select id="areas" name="areas" datatype="*" nullmsg="片区不能为空" sucmsg=" ">
							</select>
							<select id="drivingFieldId" name="drivingFieldId" datatype="*" nullmsg="练车场地不能为空" sucmsg=" ">
								
							</select>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>职业资格证号:</label>
							<input type="text" name="occupationno">
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
							<label>教练车品牌:</label>
							<input type="text" name="carBrand">
						</div>
						<div class="form-controll">
							<label>教练车车牌:</label>
							<input type="text" name="carPlate">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>带教科目:</label>
							<select name="subject">
  								<option value ="2">科目二</option>
  								<option value ="3">科目三</option>
  								<option value ="0">全科目</option>
							</select>
						</div>
						<div class="form-controll">
							<label>语言:</label>
							<input type="radio" name="language" id="language" value="0" checked="checked">全会
							<input type="radio" name="language" id="language" value="1">普通话
							<input type="radio" name="language" id="language" value="2">粤语
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>供职状态:</label>
							<select name="employstatus" datatype="*" nullmsg="供职状态不能为空" sucmsg=" ">
  								<option value ="0">在职</option>
  								<option value ="1">离职</option>
							</select>
						</div>
						<div class="form-controll">
							<label>入职时间:</label>
							<input type="text" name="hiredate"  class="form_date" data-date-format="yyyy-mm-dd" readonly="readonly"
								datatype="*" nullmsg="入职时间不能为空" sucmsg=" ">
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
					<button type="button" class="btn btn-primary" onclick="updateInfo();">保存</button>
			</div>
		</form>
	</div>
	<!-- 查看详情 -->
	<div class="modal fade colsform" id="viewCoach" tabindex="-1" role="dialog" aria-hidden="true">	
		<form id="viewCnfo" class="form-horizontal">
			<h4>查看详情</h4>
			<div class="modal-content">
				<div class="left">
					<div class="row1">
						<div class="form-controll">
							<label>姓名:</label>
							<input type="text" name="dName" disabled>
							<input type="hidden" name="dId" id="id" value="" disabled>
							<input type="hidden" name="insId" id="insId" value="<sec:authentication property="principal.insId"/>">
						</div>
						<div class="form-controll">
							<label>性别:</label>
							<input type="radio" name="dSex" value="1" checked disabled> 男
							<input type="radio" name="dSex" value="2" disabled> 女
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>身份证号:</label>
							<input type="text" name="dIdcard" disabled>
						</div>
						<div class="form-controll">
							<label>手机号码:</label>
							<input type="text" name="dMobile" disabled>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>驾驶证号:</label>
							<input type="text" name="dDrilicence" disabled>
						</div>
						<div class="form-controll">
							<label style="width:105px;">驾驶证初领日期:</label>
							<input type="text" name="dReceiveTime"  class="form_date" style="width:172px;" data-date-format="yyyy-mm-dd" readonly="readonly" disabled="disabled">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>准驾车型:</label>
							<input type="radio" name="dDripermitted" id="dDripermitted" value="C1" checked disabled>C1&nbsp;
							<input type="radio" name="dDripermitted" id="dDripermitted" value="C2" disabled>&nbsp;C2
						</div>
						<div class="form-controll">
							<label>准教车型:</label>
							<input type="radio" name="dTeachpermitted" id="dTeachpermitted" value="C1" checked disabled>&nbsp;C1
							<input type="radio" name="dTeachpermitted" id="dTeachpermitted" value="C2" disabled>&nbsp;C2
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label style="height: 40px;">片区 :<br>服务网点:</label>
							<select id="dArea" name="area" disabled>
							</select>
							
							<select id="station" name="station" disabled>
								<option value="">请选择</option>
							</select>
						</div>
						<div class="form-controll">
							<label>片区 :<br>练车场地:</label>
							<select id="areas" name="areas" disabled>
							</select>
							<select id="drivingFieldId" name="drivingFieldId" disabled>

							</select>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>职业资格证号:</label>
							<input type="text" name="dOccupationno" value="" disabled>
						</div>
						<div class="form-controll">
							<label>职业资格等级:</label>
							<input type="radio" name="dOccupationlevel" value="1" checked disabled> 一级
							<input type="radio" name="dOccupationlevel" value="2" disabled> 二级
							<input type="radio" name="dOccupationlevel" value="3" disabled> 三级
							<input type="radio" name="dOccupationlevel" value="4" disabled> 四级
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>教练车品牌:</label>
							<input type="text" name="dCarBrand" disabled>
						</div>
						<div class="form-controll">
							<label>教练车车牌:</label>
							<input type="text" name="dCarPlate" disabled>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>带教科目:</label>
							<select name="dSubject" disabled>
  								<option value ="2">科目二</option>
  								<option value ="3">科目三</option>
  								<option value ="0">全科目</option>
							</select>
						</div>
						<div class="form-controll">
							<label>语言:</label>
							<input type="radio" name="dLanguage" id="dLanguage" value="0" checked="checked" disabled>全会
							<input type="radio" name="dLanguage" id="dLanguage" value="1" disabled>普通话
							<input type="radio" name="dLanguage" id="dLanguage" value="2" disabled>粤语
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>供职状态:</label>
							<select name="dEmploystatus" disabled>
  								<option value ="0">在职</option>
  								<option value ="1">离职</option>
							</select>
						</div>
						<div class="form-controll">
							<label>入职时间:</label>
							<input type="text" name="dHiredate"  class="form_date" data-date-format="yyyy-mm-dd" readonly="readonly" disabled="disabled">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>离职时间:</label>
							<input type="text" name="dLeavedate"  class="form_date" data-date-format="yyyy-mm-dd" readonly="readonly" disabled="disabled">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll wid90">
							<label>联系地址:</label>
							<textarea name="dAddress" disabled></textarea>
						</div>
					</div>
				</div>
				<div class="right">
					<div class="rk_swfupload">
						<span class="pic">个人相片<img id="dPhoto" name="dPhoto" src="" class="img-thumbnail upload-img"></span>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			</div>
		</form>
	</div>
	
	
	<!-- Modal 弹出的编辑界面-->
	<div class="modal fade" id="editorModal" tabindex="-1" role="dialog"
		aria-labelledby="editorModalLabel" aria-hidden="true" style="z-index:2000;width:360px;">
		<div class="modal-dialog">	
				<div class="modal-body" style="padding:0 0 0 30px;">			
						<form id="ediorForm">
							<input type="hidden" id="coachId" value="">
							<input type="hidden" id="time" value="">
							<input type="hidden" id="day" value="">
							<input type="hidden" id="subjectId" value="">
							<div class="row-fluid" style="padding-top:40px;">
								<div class="span3">时段开关:</div>
								<div class="span2"><input type="radio" id="status" name="status" value="3">开</div>
								<div class="span2"><input type="radio" id="status" name="status" value="0">关</div>
							</div>
							<div class="row-fluid">
								<div class="span3">指定学员:</div>
								<div class="span9"><input type="text" id="tt" autocomplete="off" value="" class="text" /></div>
							    <div class="span9"><input type="text" id="stuId" value="" class="hidden" /></div>
							</div>
						</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onClick="save();">保存</button>
				</div>
			</div>
		</div>
	<div class="modal fade colsform" id="Scheduling" tabindex="-1" role="dialog" aria-hidden="true">	
		<h4>排班记录</h4>
		<div class="sub_content">
			<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
			<div id="Scheduling_list" class="">
				<table class="gri_stable">
					<thead>
						<tr>
							<th class="tab-button" data-date-format="yyyy-mm-dd" readonly="readonly">
								<span>选择日期</span>
							</th>
							<th>2016-11-09</th>
							<th>2016-11-10</th>
							<th>2016-11-11</th>
							<th>2016-11-12</th>
							<th>2016-11-13</th>
							<th>2016-11-14</th>
							<th>2016-11-15</th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-success" data-dismiss="model" id="exportStationDutyFile">导出排班表</button>
			<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		</div>
	</div>
	<div class="modal fade colsform" id="ViewStudent" tabindex="-1" role="dialog" aria-hidden="true">	
		<h4>查看学员</h4>
		<div class="sub_content">
			<div id="ViewTrainees"  class="ViewTrainees-list">
			  <table>
			 <thead>
				<tr>
					<th>学员姓名</th>
				   <th>手机号码</th>
				   <th>培训车型</th>
				   <th>班型</th>
				   <th>培训进度</th>
				</tr>
			</thead>
			<tbody></tbody>
			  
			 </table>
		   </div>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		</div>
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
		var recordUrl=<custom:properties name='bjxc.user.province'/>;
		var insId= '<sec:authentication property="principal.insId"/>';
		var insName = '<sec:authentication property="principal.insName"/>';
		var statId= '<sec:authentication property="principal.stationId"/>';
		var insCode = '<sec:authentication property="principal.insCode"/>';
		var selectedTime = 0;
		
		function clickFile(){
			$("#upfile").click();
		}
		function clickAjaxSubmit(){
			$('#ajaxUploadId').click();
		}
		
		//标识当前页面的url 用来设置当前菜单标识
		var dataTable = null;
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
		                   url:'${ctx}/coach/InsertCoachToDB',
		                   data:param,
		                   dataType:'json',
		                   success: function resutlMsg(result){
			            	   $("#upfile").val("");
			            	   if(result.code==200){
			            		   layer.alert("导入数据成功!")
			            		   //保存成功 刷新列表
				   			       dataTable.refresh();
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
				
				'coachnum' : {
					'thText' : '教练员编号',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<span data-id="');
							td.push(record.id);
							td.push('">');
							td.push(record.coachnum);
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
						} else {
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
					'number' : true,
					'needOrder' : false,
					'precision' : 0,
				},
				'dripermitted' : {
					'thText' : '备案状态',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'stationName' : {
					'thText' : '隶属报名处',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'dripermitted' : {
					'thText' : '准驾车型',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'carPlate' : {
					'thText' : '教练车车牌',
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
						$("#batch").append(record.id+",");
						td.push('<button class="btn btn-success" onClick="details('+record.id+');">详情</button>');
						td.push('<button class="btn btn-success" onclick="viewStu('+record.id+',\''+record.insId+'\')">查看学员</button>');
						td.push('<button class="btn btn-success" onclick="paiban('+record.id+',\''+record.name+'\')">排班表</button>');
						return td.join('');
					}
				}
			};
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/coach/list?insId='+insId+'&stationId='+statId,
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
		
		function uploadRecord() {
			/* 获取id */
			var id = sessionStorage.getItem('tabId');
			if(id === null || id === undefined){
				layer.alert('未选择目标');
			}else{
				record(id);
			}
		}
	
		function record(id) {
			//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
			$.getJSON("${ctx}/coach/getcoach/" + id, function(result) {
				if (result.code == 200) {
					var data = result.data;
					//弹出提示框 让用户确认删除
					var dialog = new GRI.Dialog({
						type : 4,
						title : '上传备案',
						content : '确定上传【' + data.name + '】教练信息备案吗？',
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
						if (data.receiveTime != null) {
							var date = new Date(data.receiveTime);
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
						var photoUrl = data.photo;
						if (photoUrl == "" || photoUrl == null) {
							layer.alert("个人相片为空");
							return
						}
						var id = data.id;
						var isCountry = data.isCountry;
						/*计时系统用户登录 自动备案到省(已全国备案作为前提)*/
						if (isTimeSystem()) {
							if (isCountry != null && isCountry == 1) {
								//定义提交到服务端的数据对象
								var fileParam = {
									"type" : 'examinerimg',
									"url" : photoUrl,
									"level" : 2
								};
								//发送数据到后端保存
								$.post(recordUrl + '/upload/file/url', fileParam, function(urlResult) {
									if (urlResult.errorcode == 0) {
	
										//定义提交到服务端的数据对象
										var params = {
											'inscode' : insCode,
											'coachnum' : data.coachnum,
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
											'occupationlevel' : data.occupationlevel
										};
										//发送数据到后端保存
										$.post(recordUrl + '/province/coach', params, function(result) {
											if (result.errorcode == 0) {
												//定义提交到服务端的数据对象
												var params = {
													"id" : id,
													"isprovince" : 1
												};
												$.post('${ctx}/coach/saveCoach', params, function(results) {
													console.log("request");
													if (results.code == 200) {
														if (!id || id != '') {
															$('#editCoach').modal('hide');
															//保存成功 刷新列表
	
														}
														buildDataTable();
														layer.alert(result.message);
													} else {
														//打开错误提示框
														layer.alert(results.message);
													}
													$('#save_btn').attr('disabled', false);
												});
											} else {
												//layer.alert("信息正确性不完整,备案失败")
												layer.alert(result.message);
											}
										});
									} else {
										layer.alert("相片不能为空");
									}
								});
							} else {
								layer.open({
									title : '提示',
									maxWidth : 900,
									content : '<h4 style="color:red; text-align:center;font-size:20px;">温馨提示</h4>' +
										'<div style="text-align:center;">该教练没有国家平台备案的教练编号,不能上传省平台备案!</br>(在计时平台对接前录入的学员不需要备案)</div>'
								});
							}
						}
	
					});
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
				$("#savePhotoId").attr('src', datajson.data.s);
				console.log(file,data);
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
		var id = '${param.id}';
		$(document).ready(function() {
			initForm();
			/*if(id){
				initFormData(id);
			}*/
		});
		function initForm(){
			//地区
			$('#addCoachInfo select[name="area"]').append("<option value=''>请选择</option>");
			$(areas).each(function(item){
				if(this.area != '市辖区'){
					$('#addCoachInfo select[name="area"]').append("<option value='" + this.id + "'>" + this.name + "</option>");
				}
			});
			//网点
			$("#addCoachInfo select[name='area']").change(function() {
				var value = $(this).val();
				if (value == '') {
					$("#addCoachInfo select[name='station']").empty()
					$("#addCoachInfo select[name='station']").append("<option value=''>请选择</option>");
				}
				else {
					var params = {
						id : value,
						insId : insId
					};
					$("#addCoachInfo select[name='station']").empty();
					$("#addCoachInfo select[name='station']").append("<option value=''>请选择</option>");
					$.post('${ctx}/serviceStation/findByArea', params, function(result) {
						if (result.code == 200) {
							for (var i = 0; i < result.data.length; i++) {
								$("#addCoachInfo select[name='station']").append("<option value='" + result.data[i].id + "'>" + result.data[i].name + "</option>");
							}
						}
					});
				}
			});
			//练车场地地区
			$('#addCoachInfo select[name="areas"]').append("<option value=''>请选择</option>");
			$(areas).each(function(item){
				if(this.area != '市辖区'){
					$('#addCoachInfo select[name="areas"]').append("<option value='" + this.name + "'>" + this.name + "</option>");
				}
			});
			//练车场地
			$("#addCoachInfo select[name='areas']").change(function() {
				var value = $(this).val();
				if (value == '') {
					$("#addCoachInfo select[name='drivingFieldId']").empty()
					$("#addCoachInfo select[name='drivingFieldId']").append("<option value=''>请选择</option>");
				}
				else {
					var params = {
						name : value,
						insId : insId
					};
					$("#addCoachInfo select[name='drivingFieldId']").empty();
					$("#addCoachInfo select[name='drivingFieldId']").append("<option value=''>请选择</option>");
					$.post('${ctx}/drivingField/findByDriving', params, function(result) {
						if (result.code == 200) {
							for (var i = 0; i < result.data.length; i++) {
								$("#addCoachInfo select[name='drivingFieldId']").append("<option value='" + result.data[i].id + "'>" + result.data[i].name + "</option>");
							}
						}
					});
				}
			});
			/* //练车场地选择
			$('#addCoachInfo select[name="drivingFieldId"]').append("<option value=''>请选择</option>");
			$(drivingFieds).each(function(item){
				$('#addCoachInfo select[name="drivingFieldId"]').append("<option value='" + this.id + "'>" + this.name + "</option>");
			}); */
			
			//地区
			$('#coachInfo select[name="area"]').append("<option value=''>请选择</option>");
			$(areas).each(function(item){
				if(this.area != '市辖区'){
					$('#coachInfo select[name="area"]').append("<option value='" + this.id + "'>" + this.name + "</option>");
				}
			});
			//网点
			$("#coachInfo select[name='area']").change(function() {
				var value = $(this).val();
				if (value == '0') {
					$("#coachInfo select[name='station']").empty()
					$("#coachInfo select[name='station']").append("<option value='0'>请选择</option>");
				}
				else {
					var params = {
						id : value,
						insId : insId
					};
					$("#coachInfo select[name='station']").empty();
					$("#coachInfo select[name='station']").append("<option value=''>请选择</option>");
					$("#coachInfo select[name='drivingFieldId']").empty();
					$("#coachInfo select[name='drivingFieldId']").append("<option value='0'>请选择</option>");
					$.post('${ctx}/serviceStation/findByArea', params, function(result) {
						if (result.code == 200) {
							for (var i = 0; i < result.data.length; i++) {
								$("#coachInfo select[name='station']").append("<option value='" + result.data[i].id + "'>" + result.data[i].name + "</option>");
							}
						}
					});
				}
			});
			//练车场地地区
			$('#coachInfo select[name="areas"]').append("<option value=''>请选择</option>");
			$(areas).each(function(item){
				if(this.area != '市辖区'){
					$('#coachInfo select[name="areas"]').append("<option value='" + this.name + "'>" + this.name + "</option>");
				}
			});
			//练车场地
			$("#coachInfo select[name='areas']").change(function() {
				var value = $(this).val();
				if (value == '') {
					$("#coachInfo select[name='drivingFieldId']").empty()
					$("#coachInfo select[name='drivingFieldId']").append("<option value=''>请选择</option>");
				}
				else {
					var params = {
						name : value,
						insId : insId
					};
					$("#coachInfo select[name='drivingFieldId']").empty();
					$("#coachInfo select[name='drivingFieldId']").append("<option value=''>请选择</option>");
					$.post('${ctx}/drivingField/findByDriving', params, function(result) {
						if (result.code == 200) {
							for (var i = 0; i < result.data.length; i++) {
								$("#coachInfo select[name='drivingFieldId']").append("<option value='" + result.data[i].id + "'>" + result.data[i].name + "</option>");
							}
						}
					});
				}
			});
			/* //练车场地选择
			$('#coachInfo select[name="drivingFieldId"]').append("<option value=''>请选择</option>");
			$(drivingFieds).each(function(item){
				$('#coachInfo select[name="drivingFieldId"]').append("<option value='" + this.id + "'>" + this.name + "</option>");
			}); */
			
			/*
			$(drivingFieds).each(function(item){
				$('#coachInfo select[name="drivingFieldId"]').append("<option value='" + this.id + "'>" + this.name + "</option>");
			});
			*/
			//详情地区
			$('#viewCnfo select[name="area"]').append("<option value=''>请选择</option>");
			$(areas).each(function(item){
				if(this.area != '市辖区'){
					$('#viewCnfo select[name="area"]').append("<option value='" + this.id + "'>" + this.name + "</option>");
				}
			});
		
			//练车场地地区
			$('#viewCnfo select[name="areas"]').append("<option value=''>请选择</option>");
			$(areas).each(function(item){
				if(this.area != '市辖区'){
					$('#viewCnfo select[name="areas"]').append("<option value='" + this.name + "'>" + this.name + "</option>");
				}
			});
			//练车场地
			$("#viewCnfo select[name='areas']").change(function() {
				var value = $(this).val();
				if (value == '') {
					$("#viewCnfo select[name='drivingFieldId']").empty()
					$("#viewCnfo select[name='drivingFieldId']").append("<option value=''>请选择</option>");
				}
				else {
					var params = {
						name : value,
						insId : insId
					};
					$("#viewCnfo select[name='drivingFieldId']").empty();
					$("#viewCnfo select[name='drivingFieldId']").append("<option value=''>请选择</option>");
					$.post('${ctx}/drivingField/findByDriving', params, function(result) {
						if (result.code == 200) {
							for (var i = 0; i < result.data.length; i++) {
								$("#viewCnfo select[name='drivingFieldId']").append("<option value='" + result.data[i].id + "'>" + result.data[i].name + "</option>");
							}
						}
					});
				}
			});
			var nowstation = $("#nowstation").val();
			if(nowstation != null){
				var params = {
						id : nowstation,
						insId : insId
				};
				$.post('${ctx}/serviceStation/findStationArea',params, function(results) {
					if (results.code == 200) {
						$('#coachInfo select[name="area"]').val(results.data.area);
						var params = {
								area : results.data.area,
								insId : insId
						};
						$("#coachInfo select[name='station']").empty();
						$("#coachInfo select[name='station']").append("<option value=''>请选择</option>");
						$("#coachInfo select[name='drivingFieldId']").empty();
						$("#coachInfo select[name='drivingFieldId']").append("<option value=''>请选择</option>");
						$.post('${ctx}/serviceStation/findByArea', params, function(result) {
							if (result.code == 200) {
								for (var i = 0; i < result.data.length; i++) {
									$("#coachInfo select[name='station']").append("<option value='" + result.data[i].id + "'>" + result.data[i].name + "</option>");
									if(results.data.id == result.data[i].id ){
										$('#coachInfo select[name="station"]').val(results.data.id);
									}
								}
							}
						});
						
					}
				});
			}
			
			var drivingFied = $("#drivingFied").val();
			if(drivingFied != null){
				$('#coachInfo select[name="drivingFieldId"]').val(drivingFied);
			}
		}
		
		/**
		 *	展示编辑表单界面
		 *	根据id需要调用该方法打开表单
		 */
		function editModal() {
			//$('#editorUserInfo select[name="area"]').val('');
			$('#coachInfo input[name="sex"][value="1"]').prop("checked",true);
			$('#coachInfo input[name="dripermitted"][value="C1"]').prop("checked",true);
			$('#coachInfo input[name="teachpermitted"][value="C1"]').prop("checked",true);
			$('#coachInfo input[name="occupationlevel"][value="1"]').prop("checked",true);
			$('#coachInfo input[name="language"][value="0"]').prop("checked",true);
			$('#coachInfo select[name="subject"]').val('2');
			$('#coachInfo select[name="employstatus"]').val('0');
			$('#coachInfo select[name="area"]').val('');
			$('#coachInfo select[name="station"]').val('');
			$('#coachInfo select[name="drivingFieldId"]').val('');
			$('#coachInfo input[name="leavedate"]').prop("disabled",true);
			var tool = new toolCtrl();
            tool.clearForm();
			var id=sessionStorage.getItem('tabId')
			if(id === null || id === undefined){
				layer.alert('未选择目标');
			}else{
				//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
				$.getJSON("${ctx}/coach/" + id,function(result) {
					console.log(result);
					if (result.code == 200) {
						var data = result.data;
						$('#coachInfo input[name="id"]').val(data.id);
						$('#coachInfo input[name="userId"]').val(data.userId);
						$('#coachInfo input[name="insId"]').val(data.insId);
						$('#coachInfo input[name="name"]').val(data.name);
						$('#coachInfo input[name="mobile"]').val(data.mobile);
						$('#coachInfo input[name="idcard"]').val(data.idcard);
						$('#coachInfo input[name="idcard2"]').val(data.idcard);
						$('#coachInfo input[name="sex"][value=' + data.sex + ']').prop("checked",true);
						$('#coachInfo textarea[name="address"]').val(data.address);
						$('img[name="photo"]').attr("src",data.photo);
						$('#coachInfo input[name="fingerprint"]').val(data.fingerprint);
						$('#coachInfo input[name="drilicence"]').val(data.drilicence);
						$('#coachInfo input[name="receiveTime"]').val(data.receiveTime);
						$('#coachInfo input[name="dripermitted"][value=' + data.dripermitted + ']').prop("checked",true);
						$('#coachInfo input[name="teachpermitted"][value=' + data.teachpermitted + ']').prop("checked",true);
						$('#coachInfo input[name="occupationlevel"][value=' + data.occupationlevel + ']').prop("checked",true);
						if(data.occupationlevel==1){
							$('#coachInfo input[name="leavedate"]').prop("disabled",false);
						}else{
							$('#coachInfo input[name="leavedate"]').prop("disabled",true);
						}
						$('#coachInfo select[name="employstatus"]').val(data.employstatus);
						$('#coachInfo select[name="subject"]').val(data.subject);
						/* $('#coachInfo select[name="subject"][value=' + data.subject + ']').prop("checked",true); */
						$('#coachInfo input[name="language"][value=' + data.language + ']').prop("checked",true);
						$('#coachInfo input[name="birth"]').val(data.birth);
						$('#coachInfo input[name="hiredate"]').val(data.hiredate);
						$('#coachInfo input[name="leavedate"]').val(data.leavedate);
						$('#coachInfo input[name="drivingTime"]').val(data.drivingTime);
						$('#coachInfo input[name="coachnum"]').val(data.coachnum);
						$('#coachInfo input[name="carBrand"]').val(data.carBrand);
						$('#coachInfo input[name="carPlate"]').val(data.carPlate);
						$('#coachInfo input[name="star"][value=' + data.star + ']').attr("checked",true);
						$('#coachInfo select[name="station"]').val(data.stationId);
						$('#coachInfo input[name="occupationno"]').val(data.occupationno);
						$('input[name="iscountry"]').val(data.isCountry);
						$('input[name="isprovince"]').val(data.isProvince);
						var params = {
								id : data.stationId,
								insId : insId
						};
						
						$.post('${ctx}/serviceStation/findStationArea',params, function(results) {
							if (results.code == 200) {
								$('#coachInfo select[name="area"]').val(results.data.areaId);
								var params = {
										id :results.data.areaId,
										insId : insId
									};
									$("#coachInfo select[name='station']").empty();
									$("#coachInfo select[name='station']").append("<option value='0'>请选择</option>");
									$.post('${ctx}/serviceStation/findByArea', params, function(result) {
										if (result.code == 200) {
											for (var i = 0; i < result.data.length; i++) {
												$("#coachInfo select[name='station']").append("<option value='" + result.data[i].id + "'>" + result.data[i].name + "</option>");
												if(results.data.id == result.data[i].id ){
													$('#coachInfo select[name="station"]').val(results.data.id);
												}
											}
										}
									});
							}
						});
						$.get('${ctx}/drivingField/'+data.drivingFieldId, function(drResult) {
							if (drResult.code == 200) {
								$.get('${ctx}/ttracharea/'+drResult.data.areaId, function(teResult) {
									if(teResult.code == 200){
										$('#coachInfo select[name="areas"]').val(teResult.data.name);
										var areas=$('#coachInfo select[name="areas"]').val();
										if(areas==null || areas==""){
											$('#coachInfo select[name="areas"]').val('');
										}
										if (teResult.data.name == '') {
											$("#coachInfo select[name='drivingFieldId']").empty()
											$("#coachInfo select[name='drivingFieldId']").append("<option value=''>请选择</option>");
										}
										else {
											var params = {
												name : teResult.data.name,
												insId : insId
											};
											$("#coachInfo select[name='drivingFieldId']").empty();
											$("#coachInfo select[name='drivingFieldId']").append("<option value=''>请选择</option>");
											$.post('${ctx}/drivingField/findByDriving', params, function(drResults) {
												if (drResults.code == 200) {
													for (var i = 0; i < drResults.data.length; i++) {
														$("#coachInfo select[name='drivingFieldId']").append("<option value='" + drResults.data[i].id + "'>" + drResults.data[i].name + "</option>");
														if(drResult.data.id== drResults.data[i].id ){
															$('#coachInfo select[name="drivingFieldId"]').val(drResult.data.id);
														}
													}
												}
											});
										}
				
									}
								})
							}
						});
						if(data.price != null){
							$('#coachInfo input[name="firstAfterSchooL"][value="firstAfterSchooL"]').attr("checked",true);
							$('#coachInfo input[name="timeCharges"]').val(data.price/100);
							$('#coachInfo input[name="timeCharges"]').toggle();
						}
						$('#editCoach').modal('show');
					}
				});
				
			}
		}
		/*新增教练信息保存 */
		function saveInfo(){
			
			//时间判断函数
			function pad2(n) { return n < 10 ? '0' + n : n }
			//从form中取参数值
			//var id = $('#coachInfo input[name="id"]').val();
			var insId = $('#coachInfo input[name="insId"]').val();
			var name = $('#addCoachInfo input[name="name"]').val();
			var mobile = $('#addCoachInfo input[name="mobile"]').val();
			var idcard = $('#addCoachInfo input[name="idcard"]').val();
			var sex = $('#addCoachInfo input[name="sex"]:checked').val();
			var timeCharges = $('#addCoachInfo input[name="timeCharges"]').val();
			var address = $('#addCoachInfo textarea[name="address"]').val();
			var photo = $('img[name="sPhoto"]').attr("src");
			if(photo==""||photo==null){
				layer.alert("个人相片不能为空");
				return
			}
			var fingerprint = $('#addCoachInfo input[name="fingerprint"]').val();
			var drilicence = $('#addCoachInfo input[name="drilicence"]').val();
			var receiveTime = $('#addCoachInfo input[name="receiveTime"]').val();
			var occupationno = $('#addCoachInfo input[name="occupationno"]').val();
			//驾驶证初领日期
			var countryFstdrilicdate;
			if(receiveTime!=""){
				var date = new Date(receiveTime);
				var countryFstdrilicdate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
			}  
			var dripermitted = $('#addCoachInfo input[name="dripermitted"]:checked').val();
			var teachpermitted = $('#addCoachInfo input[name="teachpermitted"]:checked').val();
			var occupationlevel = $('#addCoachInfo input[name="occupationlevel"]:checked').val();
			var employstatus = $('#addCoachInfo select[name="employstatus"]').val();
			var firstAfterSchooL = $('#addCoachInfo input[name="firstAfterSchooL"]:checked').val();
			var subject = $('#addCoachInfo select[name="subject"]').val();
			var birth = $('#addCoachInfo input[name="birth"]').val();
			var hiredate = $('#addCoachInfo input[name="hiredate"]').val();
			//入职时间
			var countryHiredate;
			if(hiredate!=""){
				var date = new Date(hiredate);
				var countryHiredate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
			}
			var drivingTime = $('#addCoachInfo input[name="drivingTime"]').val();
			var leavedate = $('#addCoachInfo input[name="leavedate"]').val();
			//离职时间
			var countryLeavedate;
			if(leavedate!=""){
				var date = new Date(leavedate);
				var countryLeavedate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
			}
			var coachnum = $('#addCoachInfo input[name="coachnum"]').val();
			var carBrand = $('#addCoachInfo input[name="carBrand"]').val();
			var carPlate = $('#addCoachInfo input[name="carPlate"]').val();
			var star = $('#addCoachInfo input[name="star"]:checked').val();
			var area = $('#addCoachInfo select[name="area"]').val();
			var stationId = $('#addCoachInfo select[name="station"]').val();
			var drivingFieldId = $('#addCoachInfo select[name="drivingFieldId"]').val();
			var language = $('#addCoachInfo input[name="language"]:checked').val();
			var drivingFieldId = $('#addCoachInfo select[name="drivingFieldId"]').val();//练车场地ID
			// 校验表单是否通过
			if( $("#AddCoach .valid-form").Validform().check() != true ){
				
				return
			}
			
			/* if(isTimeSystem()){ */
				//定义提交到服务端的数据对象
				var fileParam = {
					"type" :'coachimg',
					"url" :photo,
					"level" :1
				};
				var photoReturnId=null;
				//发送数据到后端保存 
				$.post(recordUrl+'/upload/file/url',fileParam,function(urlResult) {
					if (urlResult.errorcode == 0) {
						//返回的图片的id
						photoReturnId=urlResult.data.id;
						//定义提交到服务端的数据对象
						 var param = {
							"inscode" :insCode,
							"name": name,
							"sex" : sex,
							"idcard" : idcard,
							"mobile" : mobile,
							"address" : address,
							"photo" : photoReturnId,//220279,
							"fingerprint" : fingerprint,
							"drilicence" : drilicence,
							"fstdrilicdate" : countryFstdrilicdate,
							"occupationno":occupationno,
							"occupationlevel" : occupationlevel,
							"dripermitted" : dripermitted,
							"teachpermitted" : teachpermitted,
							"employstatus" : employstatus,
							"hiredate" : countryHiredate,
							"leavedate" : countryLeavedate
						};
						
						//发送数据到后端保存
						$.post(recordUrl+'/country/coach',param,function(result) {
							if(result.message!=""){
								layer.alert(result.message);
							}
							if (result.errorcode == 0) {
								//定义提交到服务端的数据对象
								var params = {
									"insId" :insId,
									"name" : name,
									"mobile" : mobile,
									"idcard" : idcard,
									"sex" : sex,
									"address" : address,
									"photo" : photo,
									"photoId":photoReturnId,
									"fingerprint" : fingerprint,
									"drilicence" : drilicence,
									"receiveTime" : receiveTime,
									"dripermitted" : dripermitted,
									"teachpermitted" : teachpermitted,
									"occupationno":occupationno,
									"occupationlevel" : occupationlevel,
									"employstatus" : employstatus,
									"subject" : subject,
									"birth" : birth,
									"hiredate" : hiredate,
									"leavedate" : leavedate,
									"coachnum" :result.data.coachnum,
									"carBrand" : carBrand,
									"carPlate" : carPlate,
									"star" : star,
									"stationId" : stationId,
									"drivingTime" : drivingTime,
									"drivingFieldId" : drivingFieldId,
									"language" : language,
									"timeCharges" : timeCharges,
									"firstAfterSchooL":firstAfterSchooL,
									"iscountry":1
								};
								$.post('${ctx}/coach/saveCoach', params, function(results) {
									if (results.code == 200) {
										if(!id || id != ''){
											$('#AddCoach').modal('hide');
											 //保存成功 刷新列表
									     	
										}
										buildDataTable();
										layer.alert("保存成功");
									} else {
										//打开错误提示框
										 layer.alert(results.message);
									}
									$('#save_btn').attr('disabled',false);
								});
						  }else{
							layer.alert(result.message);
						}
					}); 
					}else{
						layer.alert("相片为空或错误")
					}
				});
		}
		//修改
		function updateInfo(){
			console.log("update");
			//时间判断函数
			function pad2(n) { return n < 10 ? '0' + n : n }
			//从form中取参数值
			var id = $('#coachInfo input[name="id"]').val();
			var insId = $('#coachInfo input[name="insId"]').val();
			var name = $('#coachInfo input[name="name"]').val();
			var mobile = $('#coachInfo input[name="mobile"]').val();
			var idcard = $('#coachInfo input[name="idcard"]').val();
			var idcard2 = $('#coachInfo input[name="idcard2"]').val();
			var sex = $('#coachInfo input[name="sex"]:checked').val();
			var timeCharges = $('#coachInfo input[name="timeCharges"]').val();
			var address = $('#coachInfo textarea[name="address"]').val();
			var photo = $('img[name="photo"]').attr("src");
			var fingerprint = $('#coachInfo input[name="fingerprint"]').val();
			var drilicence = $('#coachInfo input[name="drilicence"]').val();
			var receiveTime = $('#coachInfo input[name="receiveTime"]').val();
			var occupationno = $('#coachInfo input[name="occupationno"]').val();
			//驾驶证初领日期
			var countryFstdrilicdate;
			if(receiveTime!=""){
				var date = new Date(receiveTime);
				var countryFstdrilicdate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
			}  
			var dripermitted = $('#coachInfo input[name="dripermitted"]:checked').val();
			var teachpermitted = $('#coachInfo input[name="teachpermitted"]:checked').val();
			var occupationlevel = $('#coachInfo input[name="occupationlevel"]:checked').val();
			var employstatus = $('#coachInfo select[name="employstatus"]').val();
			var firstAfterSchooL = $('#coachInfo input[name="firstAfterSchooL"]:checked').val();
			var subject = $('#coachInfo select[name="subject"]').val();
			var birth = $('#coachInfo input[name="birth"]').val();
			var hiredate = $('#coachInfo input[name="hiredate"]').val();
			//入职时间
			var countryHiredate;
			if(hiredate!=""){
				var date = new Date(hiredate);
				var countryHiredate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
			}
			var drivingTime = $('#coachInfo input[name="drivingTime"]').val();
			var leavedate = $('#coachInfo input[name="leavedate"]').val();
			//离职时间
			var countryLeavedate;
			if(leavedate!=""){
				var date = new Date(leavedate);
				var countryLeavedate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
			}
			var coachnum = $('#coachInfo input[name="coachnum"]').val();
			var carBrand = $('#coachInfo input[name="carBrand"]').val();
			var carPlate = $('#coachInfo input[name="carPlate"]').val();
			var star = $('#coachInfo input[name="star"]:checked').val();
			var area = $('#coachInfo select[name="area"]').val();
			var stationId = $('#coachInfo select[name="station"]').val();
			var drivingFieldId = $('#coachInfo select[name="drivingFieldId"]').val();
			var language = $('#coachInfo input[name="language"]:checked').val();
			var drivingFieldId = $('#coachInfo select[name="drivingFieldId"]').val();//练车场地ID
			// 校验表单是否通过
			 if( $("#editCoach .valid-form").Validform().check() != true ){
				
				return
			} 
			if(idcard!=idcard2){
				var fileParam = {
					"type" :'coachimg',
					"url" :photo,
					"level" :1
				};
				var photoReturnId=null;
				//发送数据到后端保存 
				$.post(recordUrl+'/upload/file/url',fileParam,function(urlResult) {
					if (urlResult.errorcode == 0) {
						//返回的图片的id
						photoReturnId=urlResult.data.id;
						//定义提交到服务端的数据对象
						 var param = {
							"inscode" :insCode,
							"name": name,
							"sex" : sex,
							"idcard" : idcard,
							"mobile" : mobile,
							"address" : address,
							"photo" : photoReturnId,//220279,
							"fingerprint" : fingerprint,
							"drilicence" : drilicence,
							"fstdrilicdate" : countryFstdrilicdate,
							"occupationno":occupationno,
							"occupationlevel" : occupationlevel,
							"dripermitted" : dripermitted,
							"teachpermitted" : teachpermitted,
							"employstatus" : employstatus,
							"hiredate" : countryHiredate,
							"leavedate" : countryLeavedate
						};
						
						//发送数据到后端保存
						$.post(recordUrl+'/country/coach',param,function(result) {
							if (result.errorcode != 0) {
								layer.alert(result.message);
								return false;
							}
							coachnum=result.data.coachnum;
						})
				}
			});
			}
			
			
			//定义提交到服务端的数据对象
			var params = {
				"id" : id,
				"insId" :insId,
				"name" : name,
				"mobile" : mobile,
				"idcard" : idcard,
				"sex" : sex,
				"address" : address,
				"photo" : photo,
				"fingerprint" : fingerprint,
				"drilicence" : drilicence,
				"receiveTime" : receiveTime,
				"dripermitted" : dripermitted,
				"teachpermitted" : teachpermitted,
				"occupationno":occupationno,
				"occupationlevel" : occupationlevel,
				"employstatus" : employstatus,
				"subject" : subject,
				"birth" : birth,
				"hiredate" : hiredate,
				"leavedate" : leavedate,
				"coachnum" :coachnum, //result.data.coachnum
				"carBrand" : carBrand,
				"carPlate" : carPlate,
				"star" : star,
				"stationId" : stationId,
				"drivingTime" : drivingTime,
				"drivingFieldId" : drivingFieldId,
				"language" : language,
				"timeCharges" : timeCharges,
				"firstAfterSchooL":firstAfterSchooL
			};
			$.post('${ctx}/coach/saveCoach', params, function(results) {
				console.log("request");
				if (results.code == 200) {
					if(!id || id != ''){
						$('#editCoach').modal('hide');
						 //保存成功 刷新列表
					}
					buildDataTable();
					layer.alert("保存成功");
				} else {
					//打开错误提示框
					layer.alert(results.message);
				}
				$('#save_btn').attr('disabled',false);
			});
		} 
		//删除
		function deletes(){
			var id=sessionStorage.getItem('tabId')
			if(id === null || id === undefined){
				layer.alert('未选择目标');
			}else{
				$.getJSON("${ctx}/coach/" + id,function(result) {
					var param={
						'coachnum':result.data.coachnum
					};
					$.post(recordUrl+'/province/coach/delete',param,function(resulte) {
						console.log(resulte);
						if(resulte.errorcode==1){
							layer.alert(resulte.message); 
							return false;
						}
						$.ajax({
							url:'${ctx}/coach/'+id,
							type:'delete',
							success: function(results) {
								layer.alert("删除成功！");
								console.log(results);
								buildDataTable();
							}
						})
					});
					
				})
			}
			
		}
		
		/**
		 *	展示编辑表单界面
		 *	修改都需要调用该方法打开表单
		 */
		function details(id) {
			//$('#editorUserInfo select[name="area"]').val('');
			$('#viewCnfo input[name="sex"][value="1"]').prop("checked",true);
			$('#viewCnfo input[name="dripermitted"][value="C1"]').prop("checked",true);
			$('#viewCnfo input[name="teachpermitted"][value="C1"]').prop("checked",true);
			$('#viewCnfo input[name="occupationlevel"][value="1"]').prop("checked",true);
			$('#viewCnfo input[name="language"][value="0"]').prop("checked",true);
			$('#viewCnfo select[name="subject"]').val('2');
			$('#viewCnfo select[name="employstatus"]').val('0');
			$('#viewCnfo select[name="area"]').val('');
			$('#viewCnfo select[name="station"]').val('');
			$('#viewCnfo select[name="drivingFieldId"]').val('');
			$('#viewCnfo input[name="leavedate"]').prop("disabled",true);
			var tool = new toolCtrl();
            tool.clearForm();
			if (id) {
				//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
				$.getJSON("${ctx}/coach/" + id,function(result) {
					console.log(result);
					if (result.code == 200) {
						var data = result.data;
						$('img[name="dPhoto"]').attr("src",data.photo);
						$('#viewCnfo input[name="DId"]').val(data.id);
						$('#viewCnfo input[name="userId"]').val(data.userId);
						$('#viewCnfo input[name="insId"]').val(data.insId);
						$('#viewCnfo input[name="dName"]').val(data.name);
						$('#viewCnfo input[name="dMobile"]').val(data.mobile);
						$('#viewCnfo input[name="dIdcard"]').val(data.idcard);
						$('#viewCnfo input[name="dSex"][value=' + data.sex + ']').prop("checked",true);
						$('#viewCnfo textarea[name="dAddress"]').val(data.address);
						$('#viewCnfo input[name="dFingerprint"]').val(data.fingerprint);
						$('#viewCnfo input[name="dDrilicence"]').val(data.drilicence);
						$('#viewCnfo input[name="dReceiveTime"]').val(data.receiveTime);
						$('#viewCnfo input[name="dDripermitted"][value=' + data.dripermitted + ']').prop("checked",true);
						$('#viewCnfo input[name="dTeachpermitted"][value=' + data.teachpermitted + ']').prop("checked",true);
						$('#viewCnfo input[name="dOccupationlevel"][value=' + data.occupationlevel + ']').prop("checked",true);
						$('#viewCnfo select[name="dEmploystatus"]').val(data.employstatus);
						$('#viewCnfo select[name="dSubject"]').val(data.subject);
						/* $('#viewCnfo select[name="dSubject"]option[value="'+ data.subject +'"]').prop("checked",true); */
						$('#viewCnfo input[name="dLanguage"][value=' + data.language + ']').prop("checked",true);
						$('#viewCnfo input[name="dBirth"]').val(data.birth);
						$('#viewCnfo input[name="dHiredate"]').val(data.hiredate);
						$('#viewCnfo input[name="dLeavedate"]').val(data.leavedate);
						$('#viewCnfo input[name="dDrivingTime"]').val(data.drivingTime);
						$('#viewCnfo input[name="dCoachnum"]').val(data.coachnum);
						$('#viewCnfo input[name="dCarBrand"]').val(data.carBrand);
						$('#viewCnfo input[name="dCarPlate"]').val(data.carPlate);
						$('#viewCnfo input[name="dStar"][value=' + data.star + ']').attr("checked",true);
						$('#viewCnfo select[name="dStation"]').val(data.stationId);
						$('#viewCnfo input[name="dOccupationno"]').val(data.occupationno);
						var params = {
								id : data.stationId,
								insId : insId
						};
						
						$.post('${ctx}/serviceStation/findStationArea',params, function(results) {
							if (results.code == 200) {
								
								$('#viewCnfo select[name="area"]').val(results.data.areaId);
								var params = {
										id :results.data.areaId,
										insId : insId
									};
									$("#viewCnfo select[name='station']").empty();
									$("#viewCnfo select[name='station']").append("<option value='0'>请选择</option>");
									$.post('${ctx}/serviceStation/findByArea', params, function(result) {
										if (result.code == 200) {
											for (var i = 0; i < result.data.length; i++) {
												$("#viewCnfo select[name='station']").append("<option value='" + result.data[i].id + "'>" + result.data[i].name + "</option>");
												if(results.data.id == result.data[i].id ){
													$('#viewCnfo select[name="station"]').val(results.data.id);
												}
											}
										}
									});
							}
						});
						
						$.get('${ctx}/drivingField/'+data.drivingFieldId, function(drResult) {
							if (drResult.code == 200) {
								$.get('${ctx}/ttracharea/'+drResult.data.areaId, function(teResult) {
									if(teResult.code == 200){
										$('#viewCnfo select[name="areas"]').val(teResult.data.name);
										var areas=$('#viewCnfo select[name="areas"]').val();
										if(areas==null || areas==""){
											$('#viewCnfo select[name="areas"]').val('');
										}
										if (teResult.data.name == '') {
											$("#viewCnfo select[name='drivingFieldId']").empty()
											$("#viewCnfo select[name='drivingFieldId']").append("<option value=''>请选择</option>");
										}
										else {
											var params = {
												name : teResult.data.name,
												insId : insId
											};
											$("#viewCnfo select[name='drivingFieldId']").empty();
											$("#viewCnfo select[name='drivingFieldId']").append("<option value=''>请选择</option>");
											$.post('${ctx}/drivingField/findByDriving', params, function(drResults) {
												if (drResults.code == 200) {
													for (var i = 0; i < drResults.data.length; i++) {
														$("#viewCnfo select[name='drivingFieldId']").append("<option value='" + drResults.data[i].id + "'>" + drResults.data[i].name + "</option>");
														if(drResult.data.id== drResults.data[i].id ){
															$('#viewCnfo select[name="drivingFieldId"]').val(drResult.data.id);
														}
													}
												}
											});
										}
				
									}
								})
							}
						});
						
						if(data.price != null){
							$('#viewCnfo input[name="firstAfterSchooL"][value="firstAfterSchooL"]').attr("checked",true);
							$('#viewCnfo input[name="timeCharges"]').val(data.price/100);
							$('#viewCnfo input[name="timeCharges"]').toggle();
						}
						$('#viewCoach').modal('show');
					}
				});
			}
		}
		/* 排班表 */
		function paiban(id,name){
			$('#Scheduling_list tbody tr').remove();
			var date = new Date().getTime();
			var arrDate = [];
			var sDate;
			for(var i=0; i<7; i++){
				sDate = new Date(date).pattern('yyyy-MM-dd');
				arrDate.push(sDate);
				date += 86400000;
			}
			var tableTh = $('#Scheduling_list th');
			for(var i=1; i<tableTh.length; i++){
				tableTh[i].innerHTML = arrDate[i-1];
			}
			$("#coachIdd").val(id);
			$("#Scheduling h4").text("【"+name+"】的排班记录"); 
			var params={
				'coachId':id
			}
			selectedTime = new Date().getTime();
			setDuty(params);
		}
		
		function setDuty(params){
			$('#Scheduling_list tbody tr').remove();
			$.ajax({
				url: '${ctx}/coach/getDutyList',
				data : params,
				type : 'GET',
				dataType: 'JSON', 
				success: function (res) {
					var start = 6;
					var html = '';
					for(var j=6; j<22; j++){
						html += '<tr>';
						html += '<td><span>'+ j+':00-' + (j+1) + ':00' + '</span></td>';
						for(var i=0; i<res.data.length; i++){
							if(res.data[i] === null){
								html += '<td><span>未生成</span></td>';
							}else{
								var aa = res.data[i]['f'+j] + ",'" + res.data[i]['f'+j+'s'] + "'" + ",'" + res.data[i].coachId + "'" + ",'" + res.data[i].subject + "'" + ",'" + res.data[i].day + "'" + ",'" + res.data[i]['f'+j+'i'] + "'" + "," + j;
								html += '<td><span onclick="showEditorModel('+aa+')">' + res.data[i]['f'+j+'s'] + '</span></td>';
							}
							
						}
						html += '</tr>'
					}
					$('#Scheduling_list tbody').append(html);
					$('#Scheduling').modal('show');
				},
				error: function (returndata) {  
					layer.alert(returndata);  
	          }  
			});
		}
		
		$('.tab-button').datetimepicker({
	        language:  'zh-CN',
	        weekStart: 1,
	        todayBtn:  1,
			autoclose: 1,
			todayHighlight: 0,
			startView: 2,
			minView: 2,
			forceParse: 0
	   }).on('changeDate', function(ev){
		   
		   
		   /* 时间被改变是的回调 */
		   	var date = new Date(ev.date).getTime();
			var arrDate = [];
			var sDate;
			for(var i=0; i<7; i++){
				sDate = new Date(date).pattern('yyyy-MM-dd');
				arrDate.push(sDate);
				date += 86400000;
			}
			var tableTh = $('#Scheduling_list th');
			for(var i=1; i<tableTh.length; i++){
				tableTh[i].innerHTML = arrDate[i-1];
			}
			var coachid=$("#coachIdd").val();
			var date=new Date(ev.date).pattern('yyyy-MM-dd');
			var params={
				'coachId' : coachid,
				'date' : date
			};
			
			selectedTime = new Date(ev.date).getTime();
			
			setDuty(params);
			//alert(ev.date);
	   });
	   
		
		function showEditorModel(status,name,coachId,subjectId,day,stuId,time) {
			//重置表单
			$('#stuId').val(stuId);
			$("#day").val(day);
			$("#time").val(time);
			$("#coachId").val(coachId);
			$("#subjectId").val(subjectId);
			$('input[name="status"][value="0"]').removeAttr("checked"); 
			$('input[name="status"][value="3"]').removeAttr("checked");
			$("#tt").val('');
			$("#tt").removeAttr("readonly"); 
			if(status==-1||status==0){
				$('input[name="status"][value="0"]').attr("checked",true); 
				$('#tt').attr("readonly","readonly")
			}else{
				$('input[name="status"][value="3"]').attr("checked",true);
				if(name.trim()!='空闲'){
					$("#tt").val(name);
				}
			}
			$('#editorModal').modal('show');
		}    
		
		$("input[name=status]").click(function() {
   			var status=$('input:radio[name="status"]:checked').val();
   			if(status==0){
   				$("#tt").val('');
   				$('#tt').attr("readonly","readonly")
   			}else{
   				$("#tt").removeAttr("readonly"); 
   			}
		});
		
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
			var coachId = $('#coachId').val();
			var time = $('#time').val();
			var day = $('#day').val();
			var subjectId = $('#subjectId').val();
			var status = $('input[name="status"]:checked').val();
			var stuId = $('#stuId').val();
			if((stuId=="null"||stuId==''||stuId==null)&&status!=0){
				stuId=0;
				status=1;
			}
			//定义提交到服务端的数据对象
			var params = {
				'subjectId' : subjectId,
				'coachId' : coachId,
				'time' : time,
				'day' : day,
				'status' : status,
				'stuId' : stuId
			};
			//发送数据到后端保存
			$.post('${ctx}/coach/saveDuty', params, function(result) {
				if (result.code == 200) {
					//保存成功 刷新列表
					//关闭编辑的表单
					var param={
						'coachId' : coachId
					};
					setDuty(param);
					$('#editorModal').modal('hide');
				}else{
					layer.alert(result.message);
				}
				buildDataTable();
			});
		}
		/* 查看所有学员 */
		function viewStu(id,insId){
			var params={
					'insId':insId,
					'coachId':id,
					
				}
			$('#ViewTrainees tbody tr').remove();
			$.ajax({
				url: '${ctx}/student/getCoachlist',
				data :params,
				type : 'GET',
				dataType: 'JSON', 
				success: function (res) {
					var start = 6;
					var html = '';
					for(var j=0; j<res.data.length; j++){
						html += '<tr>';
						
							html += '<td>'+res.data[j].name+'</td>';
							html += '<td>'+res.data[j].mobile+'</td>';
							html += '<td>'+res.data[j].traintype+'</td>';
							html += '<td>'+res.data[j].classTypeName+'</td>';
							if(res.data[j].status==0){
								html += '<td>科目一录入</td>';
							}else if(res.data[j].status==1){
								html += '<td>科目一</td>';
							}else if(res.data[j].status==2){
								html += '<td>科目二</td>';
							}else if(res.data[j].status==3){
								html += '<td>科目三</td>';
							}else if(res.data[j].status==4){
								html += '<td>科目四</td>';
							}
						html += '</tr>'
					}
					$('#ViewTrainees tbody').append(html);
					$('#ViewStudent').modal('show');
				},
				error: function (returndata) {  
					layer.alert(returndata);  
	          }  
			});
			
		}
		function addCoach(){
			$('img[name="sPhoto"]').attr("src","");
			//$('#editorUserInfo select[name="area"]').val('');
			$('#addCoachInfo input[name="sex"][value="1"]').prop("checked",true);
			$('#addCoachInfo input[name="dripermitted"][value="C1"]').prop("checked",true);
			$('#addCoachInfo input[name="teachpermitted"][value="C1"]').prop("checked",true);
			$('#addCoachInfo input[name="occupationlevel"][value="1"]').prop("checked",true);
			$('#addCoachInfo input[name="language"][value="0"]').prop("checked",true);
			$('#addCoachInfo select[name="subject"]').val('2');
			$('#addCoachInfo select[name="employstatus"]').val('0');
			$('#addCoachInfo select[name="area"]').val('');
			$('#addCoachInfo select[name="station"]').val('');
			$('#addCoachInfo select[name="drivingFieldId"]').val('');
			$('#addCoachInfo input[name="leavedate"]').prop("disabled",true);
			//$('#viewCnfo input[name="dOccupationlevel"][value=' + data.occupationlevel + ']').prop("checked",true);
			var tool = new toolCtrl();
            tool.clearForm();
			$('#AddCoach').modal('show');
		}
		function exportFile(){
			var stationId = statId;
			if(Number.isNaN(Number(stationId))){
				stationId = 0;
			}
			window.location.href="${ctx}/coach/exportCoachlist?insId="+insId+"&stationId="+stationId;
		}
		//离职时间的禁用，开启
		$("#addCoachInfo select[name='employstatus']").change(function() {
			var value = $(this).val();
			if(value=="1"){
				$('#addCoachInfo input[name="leavedate"]').prop("disabled",false);
			}else{
				$('#addCoachInfo input[name="leavedate"]').val("");
				$('#addCoachInfo input[name="leavedate"]').prop("disabled",true);
			}
		});
		//离职时间的禁用，开启
		$("#coachInfo select[name='employstatus']").change(function() {
			var value = $(this).val();
			if(value=="1"){
				$('#coachInfo input[name="leavedate"]').prop("disabled",false);
			}else{
				$('#coachInfo input[name="leavedate"]').val("");
				$('#coachInfo input[name="leavedate"]').prop("disabled",true);
			}
		});
		
		$("#exportStationDutyFile").click(function(){
			var coachId = $("#coachIdd").val();
			var stationId = statId;
			if(Number.isNaN(Number(statId))){
				stationId = 0;
			}
			var startLongTime = new Date(selectedTime).getTime();
			var endTime = new Date(selectedTime);
			endTime.setDate(endTime.getDate()+7);
			var endLongTime = endTime.getTime();
			window.location.href="${ctx}/coach/exportCoachStationDuty?stationId="
					+ stationId
					+ "&coachId="
					+ coachId
					+ "&startTime="
					+ startLongTime
					+ "&endTime=" + endLongTime;
		});
		
	</script>
     
</body>
</html>