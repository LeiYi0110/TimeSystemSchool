<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp"%>
<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-学员管理</title>
<script src="${ctx}/resources/uploadify/jquery.uploadify.js"></script>
<script type="text/javascript"
	src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript"
	src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript"
	src="${ctx}/resources/js/classType/<sec:authentication property="principal.insId"/>"></script>
<script type="text/javascript"
	src="${ctx}/resources/js/serviceStation/<sec:authentication property="principal.insId"/>"></script>
<script type="text/javascript" src="${ctx}/resources/js/Area/<sec:authentication property="principal.insId"/>"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery-form.js"></script>
<link type="text/css" href="${ctx}/resources/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />

</head>
<body>
	<div class="container-fluid new-admin">
		<div class="select-top">
			<sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
				<a class="select-btn" data-toggle="modal" onclick="showStuModal()"><span class="add"></span>新增</a>
				<!-- 网点端隐藏修改 、删除-->
				<a class="select-btn" data-toggle="modal"  onclick="isID()"><span class="edit" ></span>修改</a>
				<a class="select-btn" onclick="deletes()"><span class="del"></span>删除</a>
				<a class="select-btn" onClick="searchNum('1')"><span class="spare"></span>查询学员编号</a>
				<a class="select-btn" onClick="upRecord()"><span class="spare"></span>备案</a>
				<a class="select-btn" onClick="uploadAll()"><span class="spare"></span>批量备案</a>
				<a class="select-btn" onclick="changeStation()"><span class="shift"></span>转店</a>
				<a class="select-btn"><span class="Refund"></span>退费</a>
				<!-- 网点端隐藏导入、导入模板、导出 -->
				<sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
				<a class="select-btn"><span class="tpl"></span>导入模板</a>
				<a class="select-btn" id="uploadStuExcId" onclick="clickFile()"><span class="Import"></span>导入</a>
				<a class="select-btn" onclick="exportFile();"><span class="Export"></span>导出</a>
				</sec:authorize>
				<a class="select-btn" href="${ctx}/institutionInfo/exportInsInfo?id=1"><span class="Export"></span>培训机构导出</a>
			</sec:authorize>
			
			<sec:authorize access="hasRole('ROLE_SCHOOL_SERVICE')">
				<sec:authorize access="hasRole('ROLE_UserOperation_130')">
						<a class="select-btn" data-toggle="modal" onclick="showStuModal()"><span class="add"></span>新增</a>
				</sec:authorize>
						<!-- 网点端隐藏修改 、删除-->
				<sec:authorize access="hasRole('ROLE_UserOperation_131')">
						<a class="select-btn" data-toggle="modal"  onclick="isID()"><span class="edit" ></span>修改</a>
				</sec:authorize>
				<sec:authorize access="hasRole('ROLE_UserOperation_132')">
						<a class="select-btn" onclick="deletes()"><span class="del"></span>删除</a>
					</sec:authorize>
					<sec:authorize access="hasRole('ROLE_UserOperation_133')">
						<a class="select-btn" onClick="searchNum('1')"><span class="spare"></span>查询学员编号</a>
					</sec:authorize>
					<sec:authorize access="hasRole('ROLE_UserOperation_134')">
						<a class="select-btn" onClick="upRecord()"><span class="spare"></span>备案</a>
					</sec:authorize>
					<sec:authorize access="hasRole('ROLE_UserOperation_135')">
						<a class="select-btn" onClick="uploadAll()"><span class="spare"></span>批量备案</a>
					</sec:authorize>
					<sec:authorize access="hasRole('ROLE_UserOperation_136')">
						<a class="select-btn" onclick="changeStation()"><span class="shift"></span>转店</a>
					</sec:authorize>
					<sec:authorize access="hasRole('ROLE_UserOperation_137')">
						<a class="select-btn"><span class="Refund"></span>退费</a>
					</sec:authorize>
					<sec:authorize access="hasRole('ROLE_UserOperation_138')">
						<!-- 网点端隐藏导入、导入模板、导出 -->
						<%-- <sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')"> --%>
						<a class="select-btn"><span class="tpl"></span>导入模板</a>
					</sec:authorize>
					<sec:authorize access="hasRole('ROLE_UserOperation_139')">
						<a class="select-btn" id="uploadStuExcId" onclick="clickFile()"><span class="Import"></span>导入</a>
					</sec:authorize>
					<sec:authorize access="hasRole('ROLE_UserOperation_140')">
						<a class="select-btn" onclick="exportFile();"><span class="Export"></span>导出</a>
					</sec:authorize>
					<sec:authorize access="hasRole('ROLE_UserOperation_141')">
						<%-- </sec:authorize> --%>
						<a class="select-btn" href="${ctx}/institutionInfo/exportInsInfo?id=1"><span class="Export"></span>培训机构导出</a>
					</sec:authorize>
			</sec:authorize>
		</div>
	</div>

	<div class="modal fade" id="studentNum" tabindex="-1" role="dialog" aria-labelledby="editorModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">查询学员编号</h4>
				</div>
				<div class="row1">
						<div class="form-controll wid90">
							<label>身份证:</label> <input type="text" name="idcard" value="">
						</div>
						<div class="form-controll wid90">
							<label>姓名:</label> <input type="text" name="name" value="">
						</div>
						<div class="form-controll wid90">
							<label>学员编号:</label> <input type="text" name="stunum" value="" readonly="readonly">
						</div>
					</div>
				<div class="modal-footer">
					<button type="button" id="bcountry" class="btn btn-default" onClick="searchNum(3);">备案</button>
					<button type="button" id="bcountry" class="btn btn-default" onClick="searchNum('2');">查询</button>
				</div>
			</div>
		</div>
	</div>	

	<div class="TermSearch">
		<form>
			<div class="search-left">
				
				<select id="subjectid">
					<option value="-100" checked>请选择进度</option>
					<option value="-2">报名未受理</option>
					<option value="-1">已受理未上课</option>
					<option value="1">科目一</option>
					<option value="2">科目二</option>
					<option value="3">科目三</option>
					<option value="4">科目四</option>
					<option value="5">结业</option>
					<option value="6">退费</option>
				</select>
				
				<select id="traintype">
					<option value="" checked>请选择培训车型</option>
					<option value="C1">C1</option>
					<option value="C2">C2</option>
				</select>
				<select id="sex" >
					<option value="" checked>请选择性别</option>
					<option value="1">男</option>
					<option value="2">女</option>
				</select>
				<select id="chargemode">
					<option value="" checked>请选择收费模式</option>
					<option value="">不限</option>
					<option value="1">一次性收费</option>
					<option value="2">计时收费</option>
					<option value="9">其他</option>
				</select>
				<select id="paymode">
					<option value="" checked>请选择付费模式</option>
					<option value="">不限</option>
					<option value="3">先学后付</option>
					<option value="2">先付后学</option>
					<option value="1">其他</option>
				</select></br>
				
				<input type="text" class="form_date input1 win90" id="time1"
					data-date-format="yyyy-mm-dd" placeholder="请选择开始日期" readonly="readonly" style="width:95px;">
				<input type="text" class="form_date input1 win90" id="time2"
					data-date-format="yyyy-mm-dd" placeholder="请选择结束日期" readonly="readonly" style="width:95px;">
				<input class="input1 win200" id="stationName" type="text" name="stationName" placeholder="隶属报名处" style="width:122px;">
				<input class="input1 win200" id="search" type="text"
				value="${coachName}" placeholder="身份证号/学员姓名/手机号码" style="width:240px;">
				
				 <input type="hidden" value="${coachId}" id="coachId"><br/>
				 
			</div>
			
			<buuton class="btn-flat primary d-button" onClick="searchQuery();return false;">搜 索</buuton>
		</form>
	</div>
	<div style="display: none">
		<form method="POST" enctype="multipart/form-data" id="uploadExcId"
			action="${ctx}/InsertStudentToDB">
			<input id="upfile" type="file" name="upfile"
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
	 
	<!-- 进度管理 -->
	<div class="modal fade" id="setbacks" tabindex="-1" role="dialog"
		aria-labelledby="editorModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">学员进度变更</h4>
				</div>
				<div class="modal-body">
					<div class="span5 no-margin">
						<form id="zhuangtai">
							<div class="row1">
								<input type="hidden" name="studentid" >
								<input type="hidden" name="stunumtmp" >
								<input type="hidden" name="coachId" >
								<input type="hidden" name="subjectid" >
								<label>状态：</label>
								<select id="setbacksSelect" name="status">
									<option value="-2">报名未受理</option>
									<option value="-1">已受理未上课</option>
									<option value="1">科目一学习中</option>
									<option value="2">科目二学习中</option>
									<option value="3">科目三学习中</option>
									<option value="4">科目四学习中</option>
									<option value="5">已结业</option>
								</select>
							</div>
							<div class="tab-con"></div>
							<div class="tab-con">
								<div class="row1">
									<label>流水号：</label>
									<input type="text" name="recordnum">
								</div>
							</div>
								<div class="tab-con"></div>
								<div class="tab-con">
									<div class="row1">
										<label>科目一成绩：</label>
										<input type="text" name="score1">
									</div>
								</div>
								<div class="tab-con">
									<div class="row1">
										<label>科目二成绩：</label>
										<input type="text" name="score2">
									</div>
								</div>
								<div class="tab-con">
									<div class="row1">
										<label>科目三成绩：</label>
										<input type="text" name="score3">
									</div>
								</div>
								<div class="tab-con">
									<div class="row1">
										<label>科目四成绩：</label>
										<input type="text" name="score4">
									</div>
									<div class="row1">
										<label>驾驶证号：</label>
										<input type="text" name="drilicnum">
									</div>
									<div class="row1">
										<label>发证机关编号：</label>
										<input type="text" name="organno">
									</div>
									<div class="row1">
										<label>结业证书编号：</label>
										<input type="text" name="certificateno">
									</div>
									<div class="row1">
										<label>结业证书文件：</label>
										<input name="documenturl" type="file" id="id="upload_buton_img3">								
									</div>
									<div class="row1">
										<label>结业证书文件：</label>
										<input name="signatureurl" type="file" id="id="upload_buton_img4">
									</div>
									</form>
								</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" onClick="savastatus();">保存</button>
			</div>
		</div>
	</div>
	
	<!-- coach panel 弹出的编辑界面-->
	<div class="modal fade" id="studentModal" tabindex="-1" role="dialog" aria-labelledby="editorModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">录入学员流水号</h4>
				</div>
				<div class="modal-body">
					<div class="span5">
						<form id="studentForm">
							<input type="hidden" name="studentId" id="studentId" value="">
							学员流水号：<input type="text" name="recordnum" id="recordnum" value="">
						</form>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onClick="changeStudent();">保存</button>
				</div>
			</div>
		</div>
	</div>

	
	<!-- coach panel 弹出的编辑界面-->
	<div class="modal fade" id="coachModal" tabindex="-1" role="dialog"
		aria-labelledby="editorModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">指定教练</h4>
				</div>
				<div class="modal-body">
					<div class="span5">
						<form id="coachForm">
							<input type="hidden" name="subjectId" id="subjectId" value="">
							<input type="hidden" name="studentId" id="studentId" value="">
							<div class="field-box success">
								<label>教练:</label> <select id="coach" name="coach">
									<option selected="selected">请选择</option>
								</select>
							</div>
						</form>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary"
						onClick="changeCoach();">保存</button>
				</div>
			</div>
		</div>
	</div>


	<div class="modal fade colsform" id="viewStudent" tabindex="-1"
		role="dialog" aria-hidden="true">
		<form class="form-horizontal" id="view">
			<h4>查看详情</h4>
			<div class="modal-content">
				<div class="left">
					<div class="row1">
						<div class="form-controll">
							<label>姓名:</label> <input type="text" name="name" disabled>
						</div>
						<div class="form-controll">
							<label>性别:</label> <input type="text" name="sex" disabled>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>国籍:</label> <input type="text" name="nationality" disabled>
						</div>
						<div class="form-controll">
							<label>联系地址:</label> <input type="text" name="address" disabled>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>证件类型:</label> <input type="text" name="cradtype" disabled>
						</div>
						<div class="form-controll">
							<label>证件号:</label> <input type="text" name="idcard" disabled>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>选择片区：</label>
							<select id="area" name="area" disabled="disabled">
							
							</select>
						</div>
						<div class="form-controll">
							<label>选择网点：</label>
							<select id="station" name="station" disabled="disabled">
								<option value="">请选择</option>
							</select>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>电话号码:</label> <input type="text" name="mobile" disabled>
						</div>
						<div class="form-controll">
							<label>报名时间:</label> <input type="text" name="applydate"
								class="form_date" data-date-format="yyyy-mm-dd"
								readonly="readonly" disabled>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>业务类型:</label> <input type="text" name="busitype" disabled>
						</div>
						<div class="form-controll">
							<label>班型:</label> <input name="classTypeId" type="text" disabled>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll width100">
							<label>缴费情况：</label>
							<span>应付:</span><input type="text" name="tuition" disabled>
							<span>已付:</span><input type="text" name="alreadyPay" disabled>
							<span>欠付:</span><input type="text" name="arrearage" disabled>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>支付方式:</label> <input name="paymentType" type="text"
								disabled>
						</div>
						<div class="form-controll">
							<label>驾驶证初领日期:</label> <input type="text" name="fstdrilicdate"
								class="form_date" data-date-format="yyyy-mm-dd"
								readonly="readonly" disabled>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>驾驶证号:</label> <input type="text" name="drilicnum" disabled>
						</div>
						<div class="form-controll">
							<label>培训车型:</label> <input type="text" name="traintype" disabled>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>推荐人:</label> <input type="text" name="refereeName"
								disabled>
						</div>
						<div class="form-controll">
							<label>推荐人电话:</label> <input type="text" name="refereeMobile"
								disabled>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>原准驾车型:</label> <input type="text" name="perdritype" disabled>
						</div>
						<div class="form-controll">
							<label>档案编号:</label> <input type="text" name="fileNum" disabled>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>流水号:</label> <input type="text" name="recordnum" disabled>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll wid90">
							<label>备注:</label>
							<textarea id="remark" disabled></textarea>
						</div>
					</div>
				</div>
				<div class="right">
					<div class="rk_swfupload">
						<div style="height: 60px; width: 100px; display: inline-block;">
							<span class="pic">个人相片<img name="photo" src=""
								class="img-thumbnail upload-img"></span>
						</div>

					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			</div>
		</form>
	</div>

	<div class="modal fade colsform" id="addStudent" tabindex="-1"
		role="dialog" aria-hidden="true">
		<form class="form-horizontal valid-form" id="add">
			<h4>新增学员</h4>
			<div class="modal-content">
				<div class="left">
					<div class="row1">
						<div class="form-controll">
							<label>姓名:</label> <input type="text" name="name" datatype="*" errormsg="姓名" nullmsg="姓名不能为空" sucmsg=" ">
						</div>
						<div class="form-controll">
							<label>性别:</label> <input type="radio" value="1" name="sex"checked datatype="*" nullmsg="性别不能为空" sucmsg=" "> 男 
								<input type="radio" value="2" name="sex" datatype="*" nullmsg="性别不能为空" sucmsg=" ">女
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>国籍:</label> <select name="nationality">
								<option value="中国" datatype="*" nullmsg="国籍不能为空" sucmsg=" ">中国</option>
								<option value="日本" datatype="*" nullmsg="国籍不能为空" sucmsg=" ">日本</option>
							</select>
						</div>
						<div class="form-controll">
							<label>联系地址:</label> <input type="text" name="address">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>证件类型:</label> <input type="radio" value="1"
								name="cradtype" checked datatype="*" nullmsg="证件类型不能为空" sucmsg=" "> 身份证 <input type="radio"
								value="2" name="cradtype" datatype="*" nullmsg="证件类型不能为空" sucmsg=" "> 军官证 <input type="radio"
								value="3" name="cradtype" datatype="*" nullmsg="证件类型不能为空" sucmsg=" "> 护照 <input type="radio"
								value="4" name="cradtype" datatype="*" nullmsg="证件类型不能为空" sucmsg=" "> 其他
						</div>
						<div class="form-controll">
							<label>证件号:</label> <input type="text" name="idcard" datatype="*" nullmsg="证件号不能为空" sucmsg=" ">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>选择片区：</label>
							<select id="area" name="area">
							
							</select>
						</div>
						<div class="form-controll">
							<label>选择网点：</label>
							<select id="station" name="station">
								<option value="">请选择</option>
							</select>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>电话号码:</label> <input type="text" name="mobile" datatype="*" nullmsg="电话号码不能为空" sucmsg=" ">
						</div>
						<div class="form-controll">
							<label>报名时间:</label> <input type="text" name="applydate"
								class="form_date" data-date-format="yyyy-mm-dd" readonly="readonly" datatype="*" nullmsg="报名时间不能为空" sucmsg=" ">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll select-tab">
							<label>业务类型:</label> <input type="radio" value="0"
								name="busitype" checked> 初领 <input type="radio"
								value="1" name="busitype" datatype="*" nullmsg="业务类型不能为空" sucmsg=" "> 增领 <input type="radio"
								value="2" name="busitype" datatype="*" nullmsg="业务类型不能为空" sucmsg=" "> 其他
						</div>
						<div class="form-controll">
							<label>班型:</label> <select name="classTypeId" datatype="*" nullmsg="班型不能为空" sucmsg=" ">

							</select>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll width100">
							<label>缴费情况：</label>
							<div class="input-three">
								<label>应付:
									<input type="text" name="tuition" onblur="addCalculation();" datatype="*" errormsg="请填入正确的金额" nullmsg="应付不能为空" sucmsg=" ">
								</label>
								<label>已付:
									<input type="text" name="alreadyPay" onblur="addCalculation();" datatype="*" errormsg="请填入正确的金额" nullmsg="已付不能为空" sucmsg=" ">
								</label>
								<label>欠付:
									<input type="text" name="arrearage" onblur="addCalculation();" datatype="*" errormsg="请填入正确的金额" nullmsg="欠付不能为空" sucmsg=" ">
								</label>
							</div>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>支付方式:</label> <select name="paymentType">
								<option value="0">现金</option>
								<option value="1">微信</option>
								<option value="2">支付宝</option>
								<option value="3">其他</option>
							</select>
						</div>
						<div class="form-controll">
							<label>驾驶证初领日期:</label> <input type="text" name="fstdrilicdate"
								class="form_date" data-date-format="yyyy-mm-dd" readonly="readonly">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>驾驶证号:</label> <input type="text" name="drilicnum">
						</div>
						<div class="form-controll">
							<div >
							<label>培训车型:</label> 
							<div class="tab-cons">
								<select name="traintype" datatype="*" nullmsg="培训车型不能为空" sucmsg=" ">
									<option value="C1">C1</option>
									<option value="C2">C2</option>
								</select>
							</div>
							</div>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>推荐人:</label> <input type="text" name="refereeName">
						</div>
						<div class="form-controll">
							<label>推荐人电话:</label> <input type="text" name="refereeMobile">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>原准驾车型:</label> 
							
							<select name="perdritype">
								<option value="">请选择</option>
								<option value="C1">C1</option>
								<option value="C2">C2</option>
							</select>
						</div>
						<div class="form-controll">
							<label>档案编号:</label> <input type="text"  disabled="disabled">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>流水号:</label> <input type="text" name="recordnum">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll wid90">
							<label>备注:</label>
							<textarea id="remark"></textarea>
						</div>
					</div>
				</div>
				<div class="right">
					<div class="rk_swfupload">
						<div style="height: 60px; width: 100px; display: inline-block;">
							<span class="pic">个人相片<img id="photo" name="photo1" src=""
								class="img-thumbnail upload-img"></span> <a
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
				<button type="button" class="btn btn-primary" onclick="addSub()">保存</button>
			</div>
		</form>
	</div>

	<div class="modal fade colsform" id="editStudent" tabindex="-1"
		role="dialog" aria-hidden="true">
		<form class="form-horizontal valid-form" id="update">
			<h4>修改学员信息</h4>
			<div class="modal-content">
				<div class="left">
					<div class="row1">
						<div class="form-controll">
							<label>姓名:</label> <input type="text" name="name" datatype="*" nullmsg="姓名不能为空" sucmsg=" ">
						</div>
						<div class="form-controll">
							<label>性别:</label> <input type="radio" value="1" name="sex"
								checked datatype="*" nullmsg="性别不能为空" sucmsg=" "> 男 
								<input type="radio" value="2" name="sex" datatype="*" nullmsg="性别不能为空" sucmsg=" ">女
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>国籍:</label> <select name="nationality" datatype="*" nullmsg="国籍不能为空" sucmsg=" ">
								<option value="中国">中国</option>
								<option value="日本">日本</option>
							</select>
						</div>
						<div class="form-controll">
							<label>联系地址:</label> <input type="text" name="address">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>证件类型:</label> <input type="radio" value="1"
								name="cradtype" checked datatype="*" nullmsg="证件类型不能为空" sucmsg=" "> 身份证 <input type="radio"
								value="2" name="cradtype" datatype="*" nullmsg="证件类型不能为空" sucmsg=" "> 军官证 <input type="radio"
								value="3" name="cradtype" datatype="*" nullmsg="证件类型不能为空" sucmsg=" "> 护照 <input type="radio"
								value="4" name="cradtype" datatype="*" nullmsg="证件类型不能为空" sucmsg=" "> 其他
						</div>
						<div class="form-controll">
							<label>证件号:</label> <input type="text" name="idcard" datatype="*" nullmsg="证件号不能为空" sucmsg=" ">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>选择片区：</label>
							<select id="area" name="area">
							
							</select>
						</div>
						<div class="form-controll">
							<label>选择网点：</label>
							<select id="station" name="station">
								<option value="">请选择</option>
							</select>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>电话号码:</label> <input type="text" name="mobile" datatype="*" nullmsg="电话号码不能为空" sucmsg=" ">
						</div>
						<div class="form-controll">
							<label>报名时间:</label> <input type="text" name="applydate"
								class="form_date" data-date-format="yyyy-mm-dd" readonly="readonly"
								datatype="*" nullmsg="报名时间不能为空" sucmsg=" ">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll select-tab">
							<label>业务类型:</label> <input type="radio" value="0"
								name="busitype" checked datatype="*" nullmsg="业务类型不能为空" sucmsg=" "> 初领 <input type="radio"
								value="1" name="busitype" datatype="*" nullmsg="业务类型不能为空" sucmsg=" "> 增领 <input type="radio"
								value="2" name="busitype" datatype="*" nullmsg="业务类型不能为空" sucmsg=" "> 其他
						</div>
						<div class="form-controll">
							<label>班型:</label> <select name="classTypeId" datatype="*" nullmsg="班型不能为空" sucmsg=" ">

							</select>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll width100">
							<label>缴费情况：</label>
							<span>应付:</span><input type="text" name="tuition" value="0" onblur="upCalculation();">
							<span>已付:</span><input type="text" name="alreadyPay" value="0" onblur="upCalculation();">
							<span>欠付:</span><input type="text" name="arrearage" value="0" onblur="upCalculation();">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>支付方式:</label> <select name="paymentType">
								<option value="0">现金</option>
								<option value="1">微信</option>
								<option value="2">支付宝</option>
								<option value="3">其他</option>
							</select>
						</div>
						<div class="form-controll">
							<label>驾驶证初领日期:</label> <input type="text" name="fstdrilicdate"
								class="form_date" data-date-format="yyyy-mm-dd" readonly="readonly">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>驾驶证号:</label> <input type="text" name="drilicnum">
						</div>
						<div class="form-controll">
							<label>培训车型:</label> <select name="traintype" datatype="*" nullmsg="培训车型不能为空" sucmsg=" ">
								<option value="C1">C1</option>
								<option value="C2">C2</option>
							</select>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>推荐人:</label> <input type="text" name="">
						</div>
						<div class="form-controll">
							<label>推荐人电话:</label> <input type="text" name="refereeMobile">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>原准驾车型:</label> 
							<select name="perdritype">
								<option value="">请选择</option>
								<option value="C1">C1</option>
								<option value="C2">C2</option>
							</select>
						</div>
						<div class="form-controll">
							<label>档案编号:</label> <input type="text" name="fileNum" disabled="disabled">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>流水号:</label> <input type="text" name="recordnum">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll wid90">
							<label>备注:</label>
							<textarea id="remark"></textarea>
						</div>
					</div>
				</div>
				<div class="right">
					<div class="rk_swfupload">
						<div style="height: 60px; width: 100px; display: inline-block;">
							<span class="pic">个人相片<img id="photo1" name="photo1" src=""
								class="img-thumbnail upload-img"></span> <a
								style="margin-top: 20px; width: 100px;" class="btn btn-success">上传</a>
						</div>
						<div class="swfobj swfobj-position">
							<div id="upload_buton_img1"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" onclick="update()">保存</button>
			</div>
		</form>
	</div>

	<div class="modal fade colsform" id="studentChangeStation"
		tabindex="-1" role="dialog" aria-hidden="true">
		<form class="form-horizontal" id="updateChangeStation">
			<h4>申请转店</h4>
			<div class="modal-content">
				<div class="left">
					<div class="row1">
						<div class="form-controll">
							<label>培训车型:</label> <input type="text" name="traintype" disabled>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll wid90">
							<label>培训进度:</label> <input type="text" name="jindu" disabled>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll wid90">
							<label>培训教练:</label> <input type="text" name="coachName" disabled>
						</div>
						<div class="form-controll wid90">
							<label>转出店铺:</label> <select name="stationId">
							</select>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll wid90">
							<label>备注:</label>
							<textarea id="remark"></textarea>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary"
					onclick="updateChangeStation()">保存</button>
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
	<!-- 学员进度管理 -->
	<div class="modal fade colsform" id="ViewStudentInsLog" tabindex="-1" role="dialog" aria-hidden="true">	
		<h4>学员进度</h4>
		<div class="sub_content">
			<div class="tab-scroll" id="ViewTrainees">
			 <table>
			  	<thead>
			  		<tr>
			  		<th>操作日期</th>
				   	<th>结果</th>
			  		</tr>
			  	</thead>
			  	<tbody></tbody>
			 </table>
			 
		   </div>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal" onclick="clearRow()">关闭</button>
		</div>
	</div>
	

<script type="text/javascript">
	var recordUrl=<custom:properties name='bjxc.user.province'/>;
	var insCode = '<sec:authentication property="principal.insCode"/>';
	function clickFile(){
		$("#upfile").click();
	}
	function clickAjaxSubmit(){
		$('#ajaxUploadId').click();
	}

    	var current_action = "${ctx}/view/student";
	
		//标识当前页面的url 用来设置当前菜单标识
		var dataTable = null;
		var insId= <sec:authentication property="principal.insId"/>;
		var stationId= <sec:authentication property="principal.stationId"/>;
		var subjectid = $("#subjectid").val();
	
		MTA.Util.setParams('subjectid', subjectid); 
		var stationIds=stationId;
		if(stationId == null){
			stationId=0;
		}
		//初始化 
		$(document).ready(function() {
			//初始化界面  完成后调用buildData方法
			MTA.Report.initialize(null, 'buildData');
			
			//ajax 方式上传文件操作
			$('#ajaxUploadId').click(function(){
		           if(checkData()){
		        	   if(stationId!='null'){
		        	   	   var param={"stationId":stationId};
		        	   }else{
		        		   var param={"stationId":-1};   
		        	   }
		               $('#uploadExcId').ajaxSubmit({
		                   url:'${ctx}/InsertStudentToDB',  
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
		                   error: function errorMsg(){
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
			var coachId=$("#coachId").val();
			if(stationId && stationId != ''){
				MTA.Util.setParams('stationId', stationId);
			}
			if(coachId && coachId != ''){
				MTA.Util.setParams('coachId', coachId);
			}
			buildDataTable();
		}
		/**
		 *	搜索
		 */
		function searchQuery() {
			
			var time1 = $("#time1").val();
			var time2 = $("#time2").val();
			var search = $("#search").val();
			var subjectid = $("#subjectid").val();
			var traintype=$("#traintype").val();
			var sex=$("#sex").val();
			var stationName=$("#stationName").val();
			var paymode=$("#paymode").val();
			var chargemode=$("#chargemode").val();
			MTA.Util.setParams("paymode", paymode);
			MTA.Util.setParams("chargemode", chargemode);
			MTA.Util.setParams('stationName', stationName);
			MTA.Util.setParams('sex', sex);
			MTA.Util.setParams('traintype', traintype);
			MTA.Util.setParams('subjectid', subjectid); 
			MTA.Util.setParams('searchText', search); 
			MTA.Util.setParams('time1', time1);
			MTA.Util.setParams('time2', time2); 
			
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
				'stunum' : {
					'thText' : '学员编号',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						console.log(record);
						var td = [];
						td.push('<span data-id="');
						td.push(record.id);
						td.push('">');
						td.push(record.stunum);
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
				'stationName' : {
					'thText' : '隶属报名处',
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
				'name' : {
					'thText' : '学生姓名',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'sex' : {
					'thText' : '性别 ',
					'number' : true,
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
				'mobile' : {
					'thText' : '手机号码',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'fileNum' : {
					'thText' : '档案编号',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'traintype' : {
					'thText' : '培训车型',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'classTypeName' : {
					'thText' : '班型',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'paymode' : {
					'thText' : '付费模式',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<ul class="info">');
							td.push('<li>');
							if(value==3){
								td.push('计时班-先学后付');
							}else if(value ===2){
								td.push('计时班-先付后学');
							}else if(value===1){
								td.push('传统班-其他');
							}
							td.push('<li>');
						td.push('</ul>');
						return td.join('');
					}
				},
				'chargemode' : {
					'thText' : '收费模式',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<ul class="info">');
							td.push('<li>');
							if(value==1){
								td.push('一次性收费');
							}else if(value ===2){
								td.push('计时收费');
							}else if(value===9){
								td.push('其他');
							}
							td.push('<li>');
						td.push('</ul>');
						return td.join('');
					}
				},
				'coachName' : {
					'thText' : '教练',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
							if((record.subjectId == 2 || record.subjectId == 3) && (record.payType != 2)){
								td.push('<li>');
									td.push('教练: ');
									td.push(record.coachName);
									td.push('&nbsp;&nbsp;');
									td.push('<a href="#" onclick="showChangeCoachPanel(' + record.id +','+ record.subjectId  +','+ record.coachId + ')">');
									td.push('<i class="icon-pencil"></i>');
									td.push('</a>');
								td.push('</li>');
							}else{
								td.push('<li>');
								td.push('教练: ');
								td.push(record.coachName);
								td.push('&nbsp;&nbsp;');
								td.push('<a href="#" onclick="showChangeCoachPanel(' + record.id +','+ record.subjectId  +','+ record.coachId + ')">');
								td.push('<i class="icon-pencil"></i>');
								td.push('</a>');
							td.push('</li>');
							}
						td.push('</ul>');
						return td.join('');
					}
				},
				'status' : {
					'thText' : '培训进度 ',
					'number' : true,
					'colAlign' : 'left',
					'thAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<ul class="info">');
						/* td.push(''+record.subjectId+'---'+value+''); */
						var recordnum=record.recordnum;
						if(record.recordnum==""){
							recordnum=null;
						}
						
						if(record.recordnum==null){
							record.recordnum="";
						}
						td.push(""+record.recordnum+"");
							td.push('</li>');
							if(record.subjectId >= -2 && value != 3){
								td.push('<li>');
									td.push('科目: ');
									if(record.subjectId ==-2 && recordnum==null){
										td.push("<a onclick='updatesubjiect("+recordnum+","+record.id+","+record.coachId+","+record.subjectId+")'>报名未受理</a>");
									}else if(record.subjectId ==-1 && recordnum!=null){
										td.push("<a onclick='updatesubjiect("+recordnum+","+record.id+","+record.coachId+","+record.subjectId+")'>已受理未上课</a>");
									}else if(record.subjectId == 1){
										td.push("<a onclick='updatesubjiect("+recordnum+","+record.id+","+record.coachId+","+record.subjectId+")'>科目一</a>");
									}else if(record.subjectId == 2){
										td.push("<a onclick='updatesubjiect("+recordnum+","+record.id+","+record.coachId+","+record.subjectId+")'>科目二</a>");
									}else if(record.subjectId == 3){
										td.push("<a onclick='updatesubjiect("+recordnum+","+record.id+","+record.coachId+","+record.subjectId+")'>科目三</a>");
									}else if(record.subjectId == 4){
										td.push("<a onclick='updatesubjiect("+recordnum+","+record.id+","+record.coachId+","+record.subjectId+")'>科目四</a>");
									}else{
										td.push("<a onclick='updatesubjiect("+recordnum+","+record.id+","+record.coachId+","+record.subjectId+")'>报名未受理</a>");
									}
								
							}else if(record.subjectId == 4 && value==3){
								if(record.recordnum==""){
									var recordnum=null;
								}
								td.push("<a onclick='updatesubjiect("+recordnum+","+record.id+","+record.coachId+","+record.subjectId+")'>已拿证</a>");
							}
							td.push('</li>');
						td.push('</ul>');
						return td.join('');
					}
				},
				'arrearage' : {
					'thText' : '欠款',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'applydate' : {
					'thText' : '报名时间',
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
						td.push('<sec:authorize access="hasRole('+ROLE_SCHOOL_MANAGER+')">');
						td.push('<button class="btn btn-success" onclick="view('+ value +')">详情</button>');
						td.push('</sec:authorize>');
						td.push('<button class="btn btn-success">教学日志</button>');
						td.push('<button class="btn btn-success" onclick="schedule('+record.id+',\''+record.name+'\');">进度管理</button>');
						return td.join('');
					}
				}
			};
			
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/student/list',
				'size' : 10,
				'ifRealPage' : 1
			};
			//初始化 并通过ajax加载数据
			dataTable = MTA.Data.loadAjaxPageTable(config);
		}
		
		
		function showChangeStudentStunum(studentId){
			$('#studentForm input[name="studentId"]').val(studentId);
			$('#studentForm input[name="recordnum"]').val();
			
			$('#studentModal').modal('show');
		}
		function changeStudent(){
			var studentId = $('#studentForm input[name="studentId"]').val();
			var recordnum = $('#studentForm input[name="recordnum"]').val();
			
			if(!studentId){
				return;
			}
			
			var datas={
				studentId:studentId,
				recordnum:recordnum,
			};
			
			$.post("${ctx}/student/changeStudentStunum",datas,function (result) {
				if (result.code==200) {
					$('#studentModal').modal('hide');
					buildDataTable();
				}
			});
			
		}
		
		
		function showChangeCoachPanel(studentId,subjectId,coachId){
			$('#coachForm input[name="studentId"]').val(studentId);
			$('#coachForm input[name="subjectId"]').val(subjectId);
			$('#coachForm select[name="coach"]').empty();
				var datas={
					subjectId:subjectId,
					insId:insId
				};
				if(stationId){
					datas['stationId'] = stationId
				}
				$("select[name='coach']").append("<option value='' selected='selected'>请选择教练</option>");
				$.getJSON("${ctx}/coach/getInsCoach",datas,function (result) {
					if (result.code==200) {
						var data = result.data;
						for(var i=0; i<data.length; i++){
							$("select[name='coach']").append("<option value='"+data[i].id+"'>"+data[i].name+"</option>");
						}
						if(coachId){
							$('#coachForm select[name="coach"]').val(coachId);
						}
					}
				});
			$('#coachModal').modal('show');
		}
		

		
		function changeCoach(){
			var subjectId = $('#coachForm input[name="subjectId"]').val();
			var studentId = $('#coachForm input[name="studentId"]').val();
			
			var coachId = $('#coachForm select[name="coach"]').val();
			if(!coachId){
				return;
			}
			var datas={
				"subjectId":subjectId,
				"studentId":studentId,
				"coachId":coachId
			};
			console.log("changeCoach");
			if(isTimeSystem())
			{
				console.log("OK");
			}
		
			$.post("${ctx}/studentSubject/changeCoach",datas,function (result) {
				if (result.code==200) {
					$('#coachModal').modal('hide');
					buildDataTable();
				}
			});
			
		}
		/**
		*	展示编辑表单界面
		*	新增、修改都需要调用该方法打开表单
		*/
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
			'width' : '130',
			'fileTypeExts' : '*.jpg;*.JPG;*.jpeg;*.JPEG;*.png;*.PNG;*.gif;*.GIF',
			'fileObjName' : 'file_upload',
			'onUploadSuccess' : function(file, data, response) {
				var datajson = eval("(" + data + ")");
				$("#photo").attr('src', datajson.data.s);
				console.log(data);
			}
		});
		$('#upload_buton_img1').uploadify({
			'swf' : 'http://upload.91ygxc.com/resources/swfupload.swf',
			'uploader' : 'http://upload.91ygxc.com/FileUpload',
			'height' : '30',
			'width' : '130',
			'fileTypeExts' : '*.jpg;*.JPG;*.jpeg;*.JPEG;*.png;*.PNG;*.gif;*.GIF',
			'fileObjName' : 'file_upload',
			'onUploadSuccess' : function(file, data, response) {
				var datajson = eval("(" + data + ")");
				$("#photo1").attr('src', datajson.data.s);
				console.log(data);
			}
		});
		$('#upload_buton_img3').uploadify({
			'swf' : 'http://upload.91ygxc.com/resources/swfupload.swf',
			'uploader' : 'http://upload.91ygxc.com/FileUpload',
			'height' : '30',
			'width' : '130',
			'fileTypeExts' : '*.jpg;*.JPG;*.jpeg;*.JPEG;*.png;*.PNG;*.gif;*.GIF',
			'fileObjName' : 'file_upload',
			'onUploadSuccess' : function(file, data, response) {
				var datajson = eval("(" + data + ")");
				$("#upload_buton_img4").attr('value', datajson.data.s);
				console.log(data);
			}
		});
		$('#upload_buton_img4').uploadify({
			'swf' : 'http://upload.91ygxc.com/resources/swfupload.swf',
			'uploader' : 'http://upload.91ygxc.com/FileUpload',
			'height' : '30',
			'width' : '130',
			'fileTypeExts' : '*.jpg;*.JPG;*.jpeg;*.JPEG;*.png;*.PNG;*.gif;*.GIF',
			'fileObjName' : 'file_upload',
			'onUploadSuccess' : function(file, data, response) {
				var datajson = eval("(" + data + ")");
				$("#upload_buton_img4").attr('value', datajson.data.s);
				console.log(data);
			}
		});
		
		
		$('select[name="classTypeId"]').append("<option value=''>请选择班型</option>");
		var classType=$("#classType").val();
		$(classTypes).each(function(item){
			if(this.id==classType){
				$('select[name="classTypeId"]').append("<option value='" + this.id + "' selected='selected'>" + this.classcurr + "</option>");
			}
			$('select[name="classTypeId"]').append("<option value='" + this.id + "'>" + this.classcurr + "</option>");
		});
		
		$('#updateChangeStation select[name="stationId"]').append("<option value=''>请选择服务网点</option>");
		$(serviceStations).each(function(item){
			$('#updateChangeStation select[name="stationId"]').append("<option value='" + this.id + "'>" + this.name + "</option>");
		});
		
		function  update() {
			//时间判断函数
			function pad2(n) { return n < 10 ? '0' + n : n }
			
			var name = $('#update input[name="name"]').val();
			var sex = $('#update input[name="sex"]:checked').val();
			var nationality = $('#update select[name="nationality"]').val();
			var address = $('#update input[name="address"]').val();
			var cradtype = $('#update input[name="cradtype"]:checked').val();
			var idcard = $('#update input[name="idcard"]').val();
			var mobile = $('#update input[name="mobile"]').val();
			var applydate = $('#update input[name="applydate"]').val();
			//报名时间
			var countryApplydate;
			if(applydate!=""){
				var date = new Date(applydate);
				var countryApplydate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
			}
			var busitype = $('#update input[name="busitype"]:checked').val();
			var classTypeId = $('#update select[name="classTypeId"]').val();
			var tuition = $('#update input[name="tuition"]').val();
			var alreadyPay = $('#update input[name="alreadyPay"]').val();
			var arrearage = $('#update input[name="arrearage"]').val();
			var fstdrilicdate = $('#update input[name="fstdrilicdate"]').val();
			//驾驶证初领日期
			var countryFstdrilicdate;
			if(fstdrilicdate!=""){
				var date = new Date(fstdrilicdate);
				var countryFstdrilicdate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
			}
			var drilicnum = $('#update input[name="drilicnum"]').val();
			var traintype = $('#update select[name="traintype"]').val();
			var stunum = $('#update input[name="stunum"]').val();
			var refereeMobile = $('#update input[name="refereeMobile"]').val();
			var recordnum = $('#update input[name="recordnum"]').val();
			var perdritype = $('#update select[name="perdritype"]').val();
			var photo = $("#update img[name='photo1']").attr('src');
			var remark = $("remark").val();
			var refereeName = $('#update input[name="refereeName"]').val();
			var id = sessionStorage.getItem('tabId');
			var userId = $('#update input[name="userId"]').val();
			var paymentType = $('#update select[name="paymentType"]').val();
			var station = $('#update select[name="station"]').val();
			// 校验表单是否通过
			if( $("#editStudent .valid-form").Validform().check() != true ){
				
				return
			}
			
			 if(isTimeSystem()){
			//定义提交到服务端的数据对象
			 var fileParam = {
				"type" :'stuimg',
				"url" :photo,
				"level" :1
			};
			//发送数据到后端保存
			$.post(recordUrl+'/upload/file/url',fileParam,function(urlResult) {
				if (urlResult.errorcode == 0) {
					//定义提交到服务端的数据对象
					var param = {
						'inscode' : insCode,
						'cardtype' : cradtype,
						"idcard" : idcard,
						"nationality" :nationality,
						"name" : name,
						"sex" : sex,
						"phone" : mobile,
						"address" : address,
						"photo" :urlResult.data.id ,
						"fingerprint" : "",
						"busitype" : busitype,
						"drilicnum" : drilicnum,
						"fstdrilicdate" : countryFstdrilicdate,
						"perdritype" : perdritype,
						"traintype" : traintype,
						"applydate" : countryApplydate,
						"status" : status,
						"stationId" : stationId,
						"classTypeId" : classTypeId,
						"tuition" : tuition,
						"alreadyPay" : alreadyPay,
						"arrearage" : arrearage,
						"recordnum" : recordnum,
						"refereeMobile" : refereeMobile,
						"refereeName" : refereeName
					};
					//发送数据到后端保存
					 $.post(recordUrl+'/country/student',param,function(pResult) {
						if (pResult.errorcode == 0) { 
							var params = {
									'id' : id,
									"userId" : userId,
									"insId" : insId,
									"name" : name,
									"mobile" : mobile,
									"cradtype" : cradtype,
									"idcard" : idcard,
									"nationality" : nationality,
									"sex" : sex,
									"address" : address,
									"photo" : photo,
									"fingerprint" : "",
									"busitype" : busitype,
									"drilicnum" : drilicnum,
									"fstdrilicdate" : fstdrilicdate,
									"perdritype" : perdritype,
									"traintype" : traintype,
									"applydate" : applydate,
									"status" : 1,
									"stationId" :stationId,
									"classTypeId" : classTypeId,
									"tuition" : tuition,
									"alreadyPay" : alreadyPay,
									"arrearage" : arrearage,
									"recordnum" :recordnum,
									"refereeMobile" : refereeMobile,
									"remark" :remark,
									"paymentType" : paymentType,
									"stunum":pResult.data.stunum
								};
							$.post('${ctx}/student', params, function(result) {
								if (result.code == 200) {
									$('#editStudent').modal('hide');
									buildDataTable();
								}else{
									layer.alert(result.message);
								}  
							});
						 }else{
							alert("信息填写不正确，保存失败！");
						}
				});
			}else{
				alert("相片不能为空");
			}
			}); 
		}else{
			var params = {
					'id' : id,
					"userId" : userId,
					"insId" : insId,
					"name" : name,
					"mobile" : mobile,
					"cradtype" : cradtype,
					"idcard" : idcard,
					"nationality" : nationality,
					"sex" : sex,
					"address" : address,
					"photo" : photo,
					"fingerprint" : "",
					"busitype" : busitype,
					"drilicnum" : drilicnum,
					"fstdrilicdate" : fstdrilicdate,
					"perdritype" : perdritype,
					"traintype" : traintype,
					"applydate" : applydate,
					"status" : 1,
					"stationId" :stationId,
					"classTypeId" : classTypeId,
					"tuition" : tuition,
					"alreadyPay" : alreadyPay,
					"arrearage" : arrearage,
					"recordnum" :recordnum,
					"refereeMobile" : refereeMobile,
					"remark" :remark,
					"paymentType" : paymentType,
					"stunum":stunum
				};
			$.post('${ctx}/student', params, function(result) {
				if (result.code == 200) {
					$('#editStudent').modal('hide');
					buildDataTable();
				}else{
					layer.alert(result.message);
				}  
			});
		}
		}
		
		
		
		function changeStation() {
			/* 获取id */
			var id = sessionStorage.getItem('tabId');
			if(id === null || id === undefined){
				layer.alert('未选择目标');
				return;
			}else{
				$('#studentChangeStation').modal('show');
			}
			 $.getJSON("${ctx}/student/" + id,function(result) {
				console.log(result);
				if (result.code == 200) {		
					var data = result.data;
					$('#updateChangeStation input[name="traintype"]').val(data.traintype);
					$('#updateChangeStation input[name="coachName"]').val(data.coachName);
					$("#updateChangeStation").append("<input type='hidden' name='userId' value='"+data.userId+"'>");
					if(data.subjectId == -2 && data.status != 3){
						
						if(data.recordnum !=null){
							$('#updateChangeStation input[name="jindu"]').val("已受理未上课");
						}else{
							$('#updateChangeStation input[name="jindu"]').val("报名未受理");
						}
					}else if(data.subjectId >= 0 && data.status != 3){
							if(data.subjectId == 0){
								$('#updateChangeStation input[name="jindu"]').val("科目一录入");
							}else if(data.subjectId == 1){
								$('#updateChangeStation input[name="jindu"]').val("科目二");
							}else if(data.subjectId == 2){
								$('#updateChangeStation input[name="jindu"]').val("科目三");
							}else if(data.subjectId == 3){
								$('#updateChangeStation input[name="jindu"]').val("科目四");
							}else if(data.subjectId == 4){
								$('#updateChangeStation input[name="jindu"]').val("结业");
							}
					}
				}
			 }); 
		}
		
		function searchNum(choose){
			if(choose==1){
				$("#studentNum input[name='idcard']").val('');
				$("#studentNum input[name='stunum']").val('');
				$("#studentNum input[name='name']").val('');
				$("#studentNum").modal("show");
			} else if(choose==2) {
				var idcard=$("#studentNum input[name='idcard']").val();
				var name=$("#studentNum input[name='name']").val();
				var param={
					'cardnum':idcard,
					'name':name
				};
				$.get(recordUrl+'/stuinfoApi',param,function(result){
					console.log(result);
					$("#studentNum input[name='stunum']").val(result.data.stunum);
				});
			} else{
				var param = {
						'inscode' :insCode,
						'stunum': $("#studentNum input[name='stunum']").val()
				};
				$.post(recordUrl+'/province/transfer', param, function(results){
					if (results.errorcode == 0) {
						layer.alert('备案成功！');
					}else {
						layer.alert(results.message);
					}
				});
			}
			
		}
		
		
		function  updateChangeStation() {
			var userId = $('#updateChangeStation input[name="userId"]').val();
			var studentid = sessionStorage.getItem('tabId');
			var fromStation = $('#updateChangeStation select[name="stationId"]').val();
			var toStation= <sec:authentication property="principal.stationId"/>;
			if(fromStation==null || fromStation==""){
				layer.alert("请选择服务网点");
				return;
			}
			var params = {
					'createUserId' : userId,
					'studentId' : studentId,
					'fromStation' : fromStation,
					'toStation' : toStation
				};
		}
		
		
		function isID(){
			//重置表单
			$('#update input[name="sex"][value="1"]').prop("checked",true);
			$('#update input[name="cradtype"][value="1"]').prop("checked",true);
			$('#update input[name="busitype"][value="0"]').prop("checked",true);
			$('#update select[name="perdritype"]').prop('disabled', true);
			$('#update input[name="drilicnum"]').prop('disabled', true);
			$('#update input[name="fstdrilicdate"]').prop('disabled', true);
			$('#update select[name="nationality"]').val('中国');
			$('#update select[name="classTypeId"]').val('');
			$('#update select[name="paymentType"]').val('0');
			$('#update select[name="traintype"]').val('C1');
			$('#update select[name="perdritype"]').val('');
			var tool = new toolCtrl();
            tool.clearForm();
			/* 获取id */
			var id = sessionStorage.getItem('tabId');
			if(id === null || id === undefined){
				layer.alert('未选择目标');
				return;
			}else{
				$("#update").append("<input type='hidden' name='id' value='"+id+"'>");
				//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
				$.getJSON("${ctx}/student/" + id,function(result) {
					console.log(result);
					if (result.code == 200) {
						var data = result.data;
						$("#update").append("<input type='hidden' name='userId' value='"+data.userId+"'>");
						$('#update input[name="name"]').val(data.name);
						$('#update input[name="sex"][value=' + data.sex + ']').prop("checked",true);
						$('#update input[name="nationality"]').val(data.nationality);
						$('#update input[name="address"]').val(data.address);
						$('#update input[name="cradtype"][value=' + data.cradtype + ']').prop("checked",true);
						$('#update input[name="idcard"]').val(data.idcard);
						$('#update input[name="mobile"]').val(data.mobile);
						$('#update input[name="applydate"]').val(data.applydate);
						$('#update input[name="busitype"][value=' + data.busitype + ']').prop("checked",true);
						$('#update select[name="classTypeId"]').val(data.classTypeId);
						$('#update select[name="paymentType"]').val(data.paymentType);
						$('#update input[name="tuition"]').val(data.tuition);
						$('#update input[name="alreadyPay"]').val(data.alreadyPay);
						$('#update input[name="arrearage"]').val(data.arrearage);
						$('#update input[name="fstdrilicdate"]').val(data.fstdrilicdate);
						$('#update input[name="drilicnum"]').val(data.drilicnum);
						$('#update input[name="stunum"]').val(data.stunum);
						$('#update input[name="fileNum"]').val(data.fileNum);
						$('#update input[name="refereeMobile"]').val(data.refereeMobiles);
						$('#update input[name="recordnum"]').val(data.recordnum);
						$('#update select[name="perdritype"]').val(data.perdritype);	
						if( data.busitype === 1){
							$('#update input[name="fstdrilicdate"]').prop('disabled', false);
							$('#update select[name="perdritype"]').prop('disabled', false);
							$('#update input[name="drilicnum"]').prop('disabled', false);
						}else{
							$('#update input[name="fstdrilicdate"]').prop('disabled', true);
							$('#update select[name="perdritype"]').prop('disabled', true);
							$('#update input[name="drilicnum"]').prop('disabled', true);
						}
						$('#update img[name="photo1"]').prop("src",data.photo);
						$("#remark").val(data.remark);
						$('#update input[name="traintype"][value=' + data.traintype + ']').prop("checked",true);			
						$('#update input[name="fingerprint"]').val(data.fingerprint);				
						$('#update input[name="refereeName"]').val(data.refereeName);
						var params = {
								id : data.stationId,
								insId : insId
						};
						
						$.post('${ctx}/serviceStation/findStationArea',params, function(results) {
							if (results.code == 200) {
								$('#update select[name="area"]').val(results.data.areaId);
								var params = {
										id :results.data.areaId,
										insId : insId
									};
									$("#update select[name='station']").empty();
									$("#update select[name='station']").append("<option value='0'>请选择</option>");
									$.post('${ctx}/serviceStation/findByArea', params, function(result) {
										if (result.code == 200) {
											for (var i = 0; i < result.data.length; i++) {
												$("#update select[name='station']").append("<option value='" + result.data[i].id + "'>" + result.data[i].name + "</option>");
												if(results.data.id == result.data[i].id ){
													$('#update select[name="station"]').val(results.data.id);
												}
											}
										}
									});
							}
						});
					}
					$('#editStudent').modal('show');
				});
			}
		}
		function showStuModal(){
			$("#add img[name='photo1']").prop("src","");
			$('#add input[name="sex"][value="1"]').prop("checked",true);
			$('#add input[name="cradtype"][value="1"]').prop("checked",true);
			$('#add input[name="busitype"][value="0"]').prop("checked",true);
			$('#add select[name="perdritype"]').prop('disabled', true);
			$('#add input[name="drilicnum"]').prop('disabled', true);
			$('#add input[name="fstdrilicdate"]').prop('disabled', true);
			$('#add select[name="nationality"]').val('中国');
			$('#add select[name="classTypeId"]').val('');
			$('#add select[name="paymentType"]').val('0');
			$('#add select[name="traintype"]').val('C1');
			$('#add select[name="perdritype"]').val('');
			var tool = new toolCtrl();
            tool.clearForm();
			$('#addStudent').modal('show');
		}
		
		function addSub(){
			//时间判断函数
			function pad2(n) { return n < 10 ? '0' + n : n }
			
			var name = $('#add input[name="name"]').val();
			var sex = $('#add  input[name="sex"]:checked').val();
			var nationality = $('#add select[name="nationality"]').val();
			var address = $('#add input[name="address"]').val();
			var cradtype = $('#add input[name="cradtype"]:checked').val();
			var idcard = $('#add input[name="idcard"]').val();
			var mobile = $('#add input[name="mobile"]').val();
			var applydate = $('#add input[name="applydate"]').val();
			//报名时间
			var countryApplydate;
			if(applydate!=""){
				var date = new Date(applydate);
				var countryApplydate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
			}
			var busitype = $('#add input[name="busitype"]:checked').val();
			var classTypeId = $('#add select[name="classTypeId"]').val();
			var tuition = $('#add input[name="tuition"]').val();
			var alreadyPay = $('#add input[name="alreadyPay"]').val();
			var arrearage = $('#add input[name="arrearage"]').val();
			var fstdrilicdate = $('#add input[name="fstdrilicdate"]').val();
			//驾驶证初领日期
			var countryFstdrilicdate;
			if(fstdrilicdate!=""){
				var date = new Date(fstdrilicdate);
				var countryFstdrilicdate = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
			}
			var drilicnum = $('#add  input[name="drilicnum"]').val();
			var traintype = $('#add select[name="traintype"]').val();
			var stunum = $('#add input[name="stunum"]').val();
			var refereeMobile = $('#add input[name="refereeMobile"]').val();
			var recordnum = $('#add input[name="recordnum"]').val();
			var perdritype = $('#add select[name="perdritype"]').val();
			var photo = $("#add img[name='photo1']").attr('src');
			var remark = $("#remark").val();
			var paymentType = $('#add select[name="paymentType"]').val();
			var station=$('#add select[name="station"]').val();
			var refereeName = $('#add input[name="refereeName"]').val();
			// 校验表单是否通过
			if( $("#addStudent .valid-form").Validform().check() != true ){
				
				return
			}
			 if(isTimeSystem()){
			 //定义提交到服务端的数据对象
			var fileParam = {
				"type" :'stuimg',
				"url" :photo,
				"level" :1
			};
			//发送数据到后端保存
			$.post(recordUrl+'/upload/file/url',fileParam,function(urlResult) {
				if (urlResult.errorcode == 0) {  
					//定义提交到服务端的数据对象
					var param = {
						'inscode' : insCode,
						'cardtype' : cradtype,
						"idcard" : idcard,
						"nationality" : nationality,
						"name" : name,
						"sex" : sex,
						"phone" : mobile,
						"address" : address,
						"photo" : urlResult.data.id ,
						"fingerprint" : "",
						"busitype" : busitype,
						"drilicnum" : drilicnum,
						"fstdrilicdate" : countryFstdrilicdate,
						"perdritype" : perdritype,
						"traintype" : traintype,
						"applydate" : countryApplydate,
						"status" : status,
						"stationId" : stationId,
						"classTypeId" : classTypeId,
						"tuition" : tuition,
						"alreadyPay" : alreadyPay,
						"arrearage" : arrearage,
						"recordnum" : recordnum,
						"refereeMobile" : refereeMobile,
						"refereeName" : refereeName
					};
					//发送数据到后端保存
					 $.post(recordUrl+'/country/student',param,function(cResult) {
					 	if(cResult.message!=""){
							layer.alert(cResult.message);
						}
						if (cResult.errorcode == 0) { 
							var params = {
									"insId" : insId,
									"name" : name,
									"mobile" : mobile,
									"cradtype" : cradtype,
									"idcard" : idcard,
									"nationality" : nationality,
									"sex" : sex,
									"address" : address,
									"photo" : photo,
									"fingerprint" : "",
									"busitype" : busitype,
									"drilicnum" : drilicnum,
									"fstdrilicdate" : fstdrilicdate,
									"perdritype" : perdritype,
									"traintype" : traintype,
									"applydate" : applydate,
									"status" : 1,
									"stationId" :stationId,
									"classTypeId" : classTypeId,
									"tuition" : tuition,
									"alreadyPay" : alreadyPay,
									"arrearage" : arrearage,
									"recordnum" :recordnum,
									"refereeMobile" : refereeMobile,
									"remark" :remark,
									"paymentType":paymentType,
									"stunum":cResult.data.stunum
								};
								$.post('${ctx}/student', params, function(result) {
									if (result.code == 200) {
										
										buildDataTable();
										layer.alert("保存成功");
										$('#addStudent').modal('hide');
									}else{
										layer.alert(result.message);
									} 
								});
							 }else{
								layer.alert(cResult.message);
							}
					});
				}else{
					layer.alert("相片为空或错误");
				}
			});	 
			 }/* else{
					var params = {
							"insId" : insId,
							"name" : name,
							"mobile" : mobile,
							"cradtype" : cradtype,
							"idcard" : idcard,
							"nationality" : nationality,
							"sex" : sex,
							"address" : address,
							"photo" : photo,
							"fingerprint" : "",
							"busitype" : busitype,
							"drilicnum" : drilicnum,
							"fstdrilicdate" : fstdrilicdate,
							"perdritype" : perdritype,
							"traintype" : traintype,
							"applydate" : applydate,
							"status" : 1,
							"stationId" :stationId,
							"classTypeId" : classTypeId,
							"tuition" : tuition,
							"alreadyPay" : alreadyPay,
							"arrearage" : arrearage,
							"recordnum" :recordnum,
							"refereeMobile" : refereeMobile,
							"remark" :remark,
							"paymentType":paymentType,
							"stunum":stunum
						};
						$.post('${ctx}/student', params, function(result) {
							if (result.code == 200) {
								$('#addStudent').modal('hide');
								buildDataTable();
								layer.alert("保存成功");
							}else{
								layer.alert(result.message);
							} 
						}); 
			 } */
	} 
		
		function view(id){
			//重置表单
			$('#view img[name="photo"]').attr("src","");
			$('#view input[name="sex"][value="1"]').prop("checked",true);
			$('#view input[name="cradtype"][value="1"]').prop("checked",true);
			$('#view input[name="busitype"][value="0"]').prop("checked",true);
			$('#view select[name="perdritype"]').prop('disabled', true);
			$('#view input[name="drilicnum"]').prop('disabled', true);
			$('#view input[name="fstdrilicdate"]').prop('disabled', true);
			$('#view select[name="nationality"]').val('中国');
			$('#view select[name="classTypeId"]').val('');
			$('#view select[name="paymentType"]').val('0');
			$('#view select[name="traintype"]').val('C1');
			$('#view select[name="perdritype"]').val('');
			var tool = new toolCtrl();
            tool.clearForm();
			//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
			$.getJSON("${ctx}/student/" + id,function(result) {
				console.log(result);
				if (result.code == 200) {
					var data = result.data;
					$('#view input[name="name"]').val(data.name);
					if(data.sex==1){
						$('#view input[name="sex"]').val("男");
					}else{
						$('#view input[name="sex"]').val("女");
						}
					$('#view input[name="nationality"]').val(data.nationality);
					$('#view input[name="address"]').val(data.address);
					if(data.cradtype==1){
						$('#view input[name="cradtype"]').val("身份证");
					}else if(data.cradtype==2){
						$('#view input[name="cradtype"]').val("护照");
					}else if(data.cradtype==3){
						$('#view input[name="cradtype"]').val("军官证");
					}else{
						$('#view input[name="cradtype"]').val("其他");
					}
					
					if(data.paymentType==0){
						$('#view input[name="paymentType"]').val("现金");
					}else if(data.paymentType==1){
						$('#view input[name="paymentType"]').val("微信");
					}else if(data.paymentType==2){
						$('#view input[name="paymentType"]').val("支付宝");
					}else{
						$('#view input[name="paymentType"]').val("其他");
					}
					
					$('#view input[name="idcard"]').val(data.idcard);
					$('#view input[name="mobile"]').val(data.mobile);
					$('#view input[name="applydate"]').val(data.applydate);
					if(data.busitype==0){
						$('#view input[name="busitype"]').val("初领");
					}else if(data.busitype==1){
						$('#view input[name="busitype"]').val("增领");
					}else if(data.busitype==2){
						$('#view input[name="busitype"]').val("其他");
					}
					$('#view input[name="classTypeId"]').val(data.classTypeName);
					$('#view input[name="tuition"]').val(data.tuition);
					$('#view input[name="alreadyPay"]').val(data.alreadyPay);
					$('#view input[name="arrearage"]').val(data.arrearage);
					$('#view input[name="fstdrilicdate"]').val(data.fstdrilicdate);
					$('#view input[name="drilicnum"]').val(data.drilicnum);
					$('#view input[name="stunum"]').val(data.stunum);
					$('#view input[name="refereeMobile"]').val(data.refereeMobiles);
					$('#view input[name="recordnum"]').val(data.recordnum);
					$('#view input[name="perdritype"]').val(data.perdritype);					
					$('#view img[name="photo"]').attr("src",data.photo);
					$("#remark").val(data.remark);
					$('#view input[name="traintype"]').val(data.traintype);			
					$('#view input[name="fingerprint"]').val(data.fingerprint);				
					$('#view input[name="refereeName"]').val(data.refereeName);
					$('#view input[name="fileNum"]').val(data.fileNum);
					var params = {
							id : data.stationId,
							insId : insId
					};
					
					$.post('${ctx}/serviceStation/findStationArea',params, function(results) {
						if (results.code == 200) {
							$('#view select[name="area"]').val(results.data.areaId);
							var params = {
									id :results.data.areaId,
									insId : insId
								};
								$("#view select[name='station']").empty();
								$("#view select[name='station']").append("<option value='0'>请选择</option>");
								$.post('${ctx}/serviceStation/findByArea', params, function(result) {
									if (result.code == 200) {
										for (var i = 0; i < result.data.length; i++) {
											$("#view select[name='station']").append("<option value='" + result.data[i].id + "'>" + result.data[i].name + "</option>");
											if(results.data.id == result.data[i].id ){
												$('#view select[name="station"]').val(results.data.id);
											}
										}
									}
								});
						}
					});
				}
				$('#viewStudent').modal('show');
			});

	}

	function uploadAll() {
		var batchId = $("#batch").text().split(",");
		console.log(batchId);
		for (var i = 0; i < batchId.length - 1; i++) {
			record(batchId[i]);
		}
	}

	function upRecord() {
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
									$.post('${ctx}/student/updateisProvince', paramf, function(result) {
										if (result.code == 200) {
											layer.alert("备案成功");
											buildDataTable();
										} else {
											layer.alert("备案失败");
										}
									});
								} else {
									layer.alert("信息不正确,备案失败")
								}
							});
						} else {
							layer.alert("相片不能为空")
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

	function  updatesubjiect(a,studentid,b,c) {
			//重置表单
			var tool = new toolCtrl();
		    tool.clearForm();
			/* var val =  $('#setbacksSelect').val(); */
			$("#zhuangtai input[name='studentid']").val(studentid);
			
			$("#zhuangtai input[name='stunumtmp']").val(a);
			$("#zhuangtai input[name='coachId']").val(b);
			$("#zhuangtai input[name='subjectid']").val(c);
			$("#zhuangtai select[name='status']").val(c);
			$("#zhuangtai input[name='recordnum']").val(a);
			var i = $('#setbacksSelect option:selected').index();
			var tabCon = $('#setbacks .tab-con');
			tabCon.hide().eq(i).show();
			
			 $('#setbacksSelect').change(function(){
				var val = $(this).val();
				if(val === '-2'){
					tabCon.hide().eq(0).show();
				}else if(val === '-1'){
					tabCon.hide().eq(1).show();
				}else if(val === '1'){
					tabCon.hide().eq(2).show();
				}else if(val === '2'){
					tabCon.hide().eq(3).show();
				}else if(val === '3'){
					tabCon.hide().eq(4).show();
				}else if(val === '4'){
					tabCon.hide().eq(5).show();
				}else if(val === '5'){
					tabCon.hide().eq(6).show();
				}
			 });
			$('#setbacks').modal('show');
		}
				
		function savastatus() {
			 var status=$('#zhuangtai select[name="status"]').val();
			 var studentid=$('#zhuangtai input[name="studentid"]').val();
			 var stunumtmp = $("#zhuangtai input[name='stunumtmp']").val();
			 var recordnum = $("#zhuangtai input[name='recordnum']").val();
			 var drilicnum = $("#zhuangtai input[name='drilicnum']").val();
			 var organno= $("#zhuangtai input[name='organno']").val();
			 var certificateno= $("#zhuangtai input[name='certificateno']").val();
			 var coachId= $("#zhuangtai input[name='coachId']").val();
			 var subjectid= $("#zhuangtai input[name='subjectid']").val();
			 //documenturl  
			 var documenturl= $("#zhuangtai input[name='documenturl']").val();
			 var signatureurl= $("#zhuangtai input[name='signatureurl']").val();
			 var score;
			 if(status==0){
				 if(stunumtmp != ""){
					 layer.alert("已有学员流水号");
					 return;
				 }
			 }
			 if(status !=0){
				 if(!recordnum){
					 layer.alert("必须录入学员流水号才能继续学习！");
					 return;
				 }
			 }
			 
			/*  if(status==3 ||status==2 || status==4 || status==1){
				 if(coachId==""){
					 layer.alert("必须选择教练才能继续学习");
					 return;
				 } 
			 } */
			 
			 if(status == 2){
				 score = $("#zhuangtai input[name='score1']").val();
			 }else if(status == 3){
				 score = $("#zhuangtai input[name='score2']").val();
			 }else if(status == 4){
				 score = $("#zhuangtai input[name='score3']").val();
			 }else if(status == 5){
				 score = $("#zhuangtai input[name='score4']").val();
			 }
			 if(status == 2 || status == 3 || status == 4 || status == 5){
 				if(score<90){
 					layer.alert('成绩小于90,保存失败'); 
 					return;
				 }
			 }
			 
			 var params={
				"recordnum":recordnum,
				"studentid":studentid,
				"status":status,
				"insId":insId,
				"score":score,
				"drilicnum":drilicnum,
				"organno":organno,
				"certificateno":certificateno,
				"coachId":coachId,
				"documenturl":documenturl,
				"signatureurl":signatureurl
			 }		
			$.post("${ctx}/student/updatestatus",params,function (result) {
				if (result.code==200) {
					$('#setbacks').modal('hide');
					buildDataTable();
				}
			});
			 
		}

		$(".select-tab input[type='radio']").click(function(){
			var value = $(this).val();
			console.log(value);
			if( value === '1'){
				$('#add input[name="fstdrilicdate"]').prop('disabled', false);
				$('#add select[name="perdritype"]').prop('disabled', false);
				$('#add input[name="drilicnum"]').prop('disabled', false);
			}else{
				$('#add input[name="fstdrilicdate"]').prop('disabled', true);
				$('#add select[name="perdritype"]').val("");
				$('#add input[name="drilicnum"]').val("");
				$('#add select[name="perdritype"]').prop('disabled', true);
				$('#add input[name="drilicnum"]').prop('disabled', true);
			}
			
		})
		
		$(".select-tab input[type='radio']").click(function(){
			var value = $(this).val();
			if( value === '1'){
				$('#update input[name="fstdrilicdate"]').prop('disabled', false);
				$('#update select[name="perdritype"]').prop('disabled', false);
				$('#update input[name="drilicnum"]').prop('disabled', false);
			}else{
				$('#update input[name="fstdrilicdate"]').prop('disabled', true);
				$('#update select[name="perdritype"]').val("");
				$('#update input[name="drilicnum"]').val("");
				$('#update select[name="perdritype"]').prop('disabled', true);
				$('#update input[name="drilicnum"]').prop('disabled', true);
			}
			
		})
		function exportFile(){
			window.location.href="${ctx}/student/exportstu?insId="+insId+"&stationId="+stationIds+"&insCode="+insCode;
		}
		function addCalculation(){
			var tuition = $('#add input[name="tuition"]').val();
			tuition=parseInt(tuition)
			var alreadyPay = $('#add input[name="alreadyPay"]').val();
			alreadyPay=parseInt(alreadyPay);
			var arrearage = $('#add input[name="arrearage"]').val();
			arrearage=parseInt(arrearage)
			if(eval(tuition)>eval(alreadyPay)){
				var arrearage=tuition-alreadyPay;
			}else{
				arrearage=0;
			}
			$('#add input[name="arrearage"]').val(arrearage);
		}
		function upCalculation(){
			var tuition = $('#update input[name="tuition"]').val();
			tuition=parseInt(tuition)
			var alreadyPay = $('#update input[name="alreadyPay"]').val();
			alreadyPay=parseInt(alreadyPay);
			var arrearage = $('#update input[name="arrearage"]').val();
			arrearage=parseInt(arrearage)
			if(eval(tuition)>eval(alreadyPay)){
				var arrearage=tuition-alreadyPay;
			}else{
				arrearage=0;
			}
			$('#update input[name="arrearage"]').val(arrearage);
		}
		
		$(document).ready(function() {
			initForm();
		});
		function initForm(){
			//地区
			$('#add select[name="area"]').append("<option value=''>请选择</option>");
			$(areas).each(function(item){
				if(this.area != '市辖区'){
					$('#add select[name="area"]').append("<option value='" + this.id + "'>" + this.name + "</option>");
				}
			});
			//网点
			$("#add select[name='area']").change(function() {
				var value = $(this).val();
				if (value == '') {
					$("#add select[name='station']").empty()
					$("#add select[name='station']").append("<option value=''>请选择</option>");
				}
				else {
					var params = {
						id : value,
						insId : insId
					};
					$("#add select[name='station']").empty();
					$("#add select[name='station']").append("<option value=''>请选择</option>");
					$.post('${ctx}/serviceStation/findByArea', params, function(result) {
						if (result.code == 200) {
							for (var i = 0; i < result.data.length; i++) {
								$("#add select[name='station']").append("<option value='" + result.data[i].id + "'>" + result.data[i].name + "</option>");
							}
						}
					});
				}
			});
			
			//修改
			//地区
			$('#update select[name="area"]').append("<option value=''>请选择</option>");
			$(areas).each(function(item){
				if(this.area != '市辖区'){
					$('#update select[name="area"]').append("<option value='" + this.id + "'>" + this.name + "</option>");
				}
			});
			//网点
			$("#update select[name='area']").change(function() {
				var value = $(this).val();
				if (value == '') {
					$("#update select[name='station']").empty()
					$("#update select[name='station']").append("<option value=''>请选择</option>");
				}
				else {
					var params = {
						id : value,
						insId : insId
					};
					$("#update select[name='station']").empty();
					$("#update select[name='station']").append("<option value=''>请选择</option>");
					$.post('${ctx}/serviceStation/findByArea', params, function(result) {
						if (result.code == 200) {
							for (var i = 0; i < result.data.length; i++) {
								$("#update select[name='station']").append("<option value='" + result.data[i].id + "'>" + result.data[i].name + "</option>");
							}
						}
					});
				}
			});
		}
		$('#view select[name="area"]').append("<option value=''>请选择</option>");
		$(areas).each(function(item){
			if(this.area != '市辖区'){
				$('#view select[name="area"]').append("<option value='" + this.id + "'>" + this.name + "</option>");
			}
		});
		function schedule(studentId,name){
			$("#ViewStudentInsLog h4").text("【"+name+"】的学车进度"); 
			var params={
					'studentId':studentId,
					
				}
			$('#ViewTrainees tbody tr').remove();
			$.ajax({
				url: '${ctx}/student/getStudentInsLog',
				data :params,
				type : 'GET',
				dataType: 'JSON', 
				success: function (res) {
					var start = 6;
					var html = '';
					for(var j=0; j<res.data.length; j++){
						html += '<tr>';
						
							html += '<td>'+res.data[j].createTime+'</td>';
							html += '<td>'+res.data[j].content+'</td>';
						html += '</tr>'
					}
					$('#ViewTrainees tbody').append(html);
					$('#ViewStudentInsLog').modal('show');
				},
				error: function (returndata) {  
					layer.alert(returndata);  
	          }  
			});
		}
		
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
					$.post('${ctx}/student/deletes', paramd, function(
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
	</script>
</body>
</html>