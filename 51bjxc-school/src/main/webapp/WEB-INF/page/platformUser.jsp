<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-帐号管理</title>
<script src="${ctx}/resources/uploadify/jquery.uploadify.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/admin.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/operationItemByTree"></script>
<script type="text/javascript" src="${ctx}/resources/js/platformUserAuth"></script>
<style>
#auth .auth-title{ padding: 8px; font-size:16px; background-color: #f3f3f3;  }
.item-title{ overflow:hidden; border:1px solid #dcdcdc; padding:0 20px;  }
.item-title h5{ font-size:16px; height:20px; line-height:20px; }
.auth-con{ overflow:hidden; margin-bottom:15px;  }
.auth-item{ float:left; margin-right:15px; }
.auth-item input{ margin-top:0; }
</style>
</head>
<body>
	<div class="container-fluid new-admin">
		<div class="select-top">
		<sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
			<a class="select-btn" data-toggle="modal" onclick="showSaveModel()"><span class="add"></span>新增</a>
			<a class="select-btn" data-toggle="modal" onclick="showEditorModel()"><span class="edit" ></span>修改</a>
			<a class="select-btn " onclick="showEditorModel();"><span class="del"></span>删除</a>
			<a class="select-btn" href="${ctx}/platform/exportPlatform"><span class="Export"></span>导出</a>
		</sec:authorize>
		
		<sec:authorize access="hasRole('ROLE_SCHOOL_SERVICE')">
			<sec:authorize access="hasRole('ROLE_UserOperation_197')">
				<a class="select-btn" data-toggle="modal" onclick="showSaveModel()"><span class="add"></span>新增</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_198')">
				<a class="select-btn" data-toggle="modal" onclick="showEditorModel()"><span class="edit" ></span>修改</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_199')">
				<a class="select-btn " onclick="showEditorModel();"><span class="del"></span>删除</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_200')">
				<a class="select-btn" href="${ctx}/platform/exportPlatform"><span class="Export"></span>导出</a>
			</sec:authorize>
		</sec:authorize>
		</div>
	</div>
	<div class="TermSearch">
 	 <form>
	 <input class="input1 win200" type="text" id="search" placeholder="手机号码">
	 <buuton class="btn-flat primary" onClick="searchQuery();return false;">搜 索</buuton>
	 </form>
	</div>
	<!-- 列表 -->
	<div class="row-fluid">
		<div class="sub_content">
			<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
			<div id="table_list" class="gri_wrapper"></div>
		</div>
	</div>
	<!-- 编辑-->
	<div class="modal fade colsform" id="editorUser" tabindex="-1" role="dialog" aria-hidden="true">	
		<form id="editorUserInfo" class="form-horizontal valid-form">
			<h4>编辑用户</h4>
			<input type="hidden" id="coachIdd" value="">
			<div class="modal-content">
				<div class="left">
				<div class="row1">
						<div class="form-controll">
							<label>姓名:</label>
							<input type="text" name="userName" datatype="*" errormsg="姓名有误" nullmsg="姓名不能为空" sucmsg=" ">
						</div>
						<div class="form-controll">
							<label>联系方式:</label>
							<input type="text" name="mobile" datatype="*" errormsg="联系方式有误" nullmsg="联系不能为空" sucmsg=" ">
					  	</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>密码:</label>
							<input type="password" name="password" value="" placeholder="请输入密码" style="float: left;width: 160px;">
							<input type="hidden" name="id" value="">
						</div>
						<div class="form-controll">
							<label style="height: 50px;">隶属组织:</label>
							<div class="tab-con">
							<select id="area" name="area" style="margin-bottom: 5px;">
								<option value="" selected="selected">请选择</option>
									<c:forEach items="${requestScope.areaList}" var="area">
										<c:if test="${area.name!='市辖区'}">
											<option value="${area.id}">${area.name}</option>
										</c:if>
									</c:forEach>
							 </select>
							 </div>
							 <!-- 客服主任 -->
							<div class="tab-con">
								<select id="trainYard" name="trainYard">
									<option value="" selected="selected">请选择</option>
								</select>
							</div>
							<!-- 网点 -->
							<div class="tab-con">
								<select id="station" name="station">
									<option value="" selected="selected">请选择</option>
								</select>		
							</div>
							<!-- 机构端 -->
							<div class="tab-con">
								<input type="text" name="currentInsName" readonly="readonly" value="<sec:authentication property="principal.insName"/>"/>
							</div>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll select-tab" style="width:100%;">
							<label>角色:</label>
								<span style="padding-right:5px;"><input type="radio" name="urole" id="urole" value="2" checked style="margin:0 3px 0 0;">管理员</span>
								<!-- <span style="padding-right:5px;"><input type="radio" name="urole" id="urole" value="4" checked style="margin:0 3px 0 0;">片区管理员</span> -->
								<span style="padding-right:5px;"><input type="radio" name="urole" id="urole" value="3" checked style="margin:0 3px 0 0;">普通用户</span>
								<!-- <span style="padding-right:5px;margin-left:115px;"><input type="radio" name="urole" id="urole" value="5" checked style="margin:0 3px 0 0;">教练队长</span> -->					
							<input type="hidden" id=role value="">
						</div>
					</div>
					<div class="row1" id="auth">
						<!-- 这里堆 -->
						
					</div>
					
				</div>
				<div class="right">
					<div class="rk_swfupload">
						<div style="height: 60px; width: 100px; display: inline-block;">
							<span class="pic">个人相片<img id="photo" name="photo" src="" class="img-thumbnail upload-img"></span>
							
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
	
	<!--查看详情 -->
	<div class="modal fade colsform" id="viewUser" tabindex="-1" role="dialog" aria-hidden="true" style="width: 1000px;">	
		<form id="viewUserInfo" class="form-horizontal valid-form">
			<h4>用户信息</h4>
			<input type="hidden" id="coachIdd" value="">
			<div class="modal-content" style="overflow: hidden;height:220px;">
				<div class="left" style="width: auto;">
				<div class="row1">
						<div class="form-controll">
							<label>姓名:</label>
							<input type="text" name="userName" disabled>
						</div>
					</div>
					<div class="row1">
					 <div class="form-controll">
							<label>联系方式:</label>
							<input type="text" name="mobile" disabled>
					  </div>
					</div>
					
					<div class="row1">
						<div class="form-controll select-tab">
							<label>角色:</label>
								<span style="padding-right:5px;" onclick=""><input type="radio" name="urole" id="urole" value="2" checked style="margin:0 3px 0 0;" disabled >机构管理员</span>
								<span style="padding-right:5px;" onclick=""><input type="radio" name="urole" id="urole" value="4" checked style="margin:0 3px 0 0;" disabled >片区管理员</span><br/>
								<span style="padding-right:5px;" onclick=""><input type="radio" name="urole" id="urole" value="3" checked style="margin:0 3px 0 0;" disabled >网点管理员</span>
								<!-- <span style="padding-right:5px;margin-left:115px;" onclick=""><input type="radio" name="urole" id="urole" value="5" style="margin:0 3px 0 20px;" disabled >教练队长</span> -->
							<input type="hidden" id=role value="">
						</div>
					</div>
					<div class="row1">
					<div class="form-controll">
							<label style="height: 50px;">隶属组织:</label>
							<div class="tab-con">
							<select id="area" name="area" style="margin-bottom: 5px;" disabled>
								<option value="" selected="selected">请选择</option>
									<c:forEach items="${requestScope.areaList}" var="area">
										<c:if test="${area.name!='市辖区'}">
											<option value="${area.id}">${area.name}</option>
										</c:if>
									</c:forEach>
							 </select>
							 </div>
							 <!-- 客服主任 -->
							<div class="tab-con">
								<select id="trainYard" name="trainYard" disabled>
									<option value="" selected="selected">请选择</option>
								</select>
							</div>
							<!-- 网点 -->
							<div class="tab-con">
								<select id="station" name="station" disabled>
									<option value="" selected="selected">请选择</option>
								</select>		
							</div>
							<!-- 机构端 -->
							<div class="tab-con">
								<input type="text" name="currentInsName" readonly="readonly" value="<sec:authentication property="principal.insName"/>"/>
							</div>
						</div>
					</div>
				</div>
				<div class="right">
					<div class="rk_swfupload">
						<div style="height: 60px; width: 100px; display: inline-block;">
							<span class="pic">个人相片<img id="photo" name="photo" src="" class="img-thumbnail upload-img"></span>
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
	<script type="text/javascript">
		var dataTable = null;
		var insId= '<sec:authentication property="principal.insId"/>';
		var insName = '<sec:authentication property="principal.insName"/>';
		var statId= '<sec:authentication property="principal.stationId"/>';
		var userUrole=<sec:authentication property="principal.role"/>;
		//初始化 
		$(document).ready(function() {
			//初始化界面  完成后调用buildData方法
			if(statId!="null"){
				$("#searchDiv").hide();
			}
			MTA.Report.initialize(null, 'buildData');
			
			/* 渲染权限菜单  */
			console.log(operationItemsByTree);
			/* var html = "";
			for( var i=0; i<operationItemsByTree.length; i++ ){
				html += '<div class="auth-con"><div class="auth-title">' + operationItemsByTree[i].itemName + '</div>';
				for( var j=0; j<operationItemsByTree[i].child.length; j++ ){
					html += '<div class="item-title"><h5>' + operationItemsByTree[i].child[j].itemName + '</h5>';
					for( var k=0; k<operationItemsByTree[i].child[j].child.length; k++ ){
						html += '<label class="auth-item">' + operationItemsByTree[i].child[j].child[k].itemName  
						+ '<input type="checkbox" name="operationAuth" value="' + operationItemsByTree[i].child[j].child[k].id + '"></label>';
					}
					html += '</div>';
				}
				html += '</div>';
			}
			$("#auth").html(html);
			 */
			
			$.ajax({
				url : '${ctx}/roleManger/roleAuth/3',
				type : 'get',
				success : function(result){
					if(result.code == 200){
						var html = "";
						for( var i=0; i < operationItemsByTree.length; i++ ){
							
							var flag = false;
							for(var o = 0 ;o < result.data.length ;o++){
								if(Number(result.data[o].operationItemId) == Number(operationItemsByTree[i].id)){
									flag = true;
								}
							}
							if(!flag){
								continue;
							}
							html += '<div class="auth-con"><div class="auth-title">' + operationItemsByTree[i].itemName + '</div>';
							for( var j=0; j<operationItemsByTree[i].child.length; j++ ){
								
								var flag = false;
								for(var oj = 0 ;oj < result.data.length ;oj++){
									if(Number(result.data[oj].operationItemId) == Number(operationItemsByTree[i].child[j].id)){
										flag = true;
									}
								}
								if(!flag){
									continue;
								}
								
								html += '<div class="item-title"><h5>' + operationItemsByTree[i].child[j].itemName + '</h5>';
								for( var k=0; k<operationItemsByTree[i].child[j].child.length; k++ ){
									html += '<label class="auth-item">' + operationItemsByTree[i].child[j].child[k].itemName  
									+ '<input type="checkbox" name="operationAuth" value="' + operationItemsByTree[i].child[j].child[k].id + '"></label>';
								}
								html += '</div>';
							}
							html += '</div>';
						}
						$("#auth").html(html);
					}
				}
				
			});
			
			 
			 $('input:radio[name=urole]').change(function(){
				var value = $(this).val();
				if(Number(value) == 3){
					$("#auth").show();
				}else{
					$("#auth").hide();
				}
			 });

		});
		function buildData() {
			buildDataTable();
		}
		
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
				'userName' : {
					'thText' : '管理者名称',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<span data-id="');
							td.push(record.id);
							td.push('">');
							td.push(record.userName);
						td.push('</span>');
						return td.join('');
					}
				},
				'urole' : {
					'thText' : '属性',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						td = [];
						if (value == 2) {
							td.push('机构管理员');
						} else if (value == 3) {
							td.push('网点管理员');
						}else if(value==4){
							td.push('片区管理员');
						}else if(value==5){
							td.push('教练队长');
						}
						return td.join('');
					}
				},
				'mobile' : {
					'thText' : '电话',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'area' : {
					'thText' : '大区',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'stationName' : {
					'thText' : '网点',
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
						td.push('<ul class="actions">');
						if(record.status==1){
							td.push('<li>');
							td.push('<a class="btn btn-success" onClick="showViewModel(' + record.id + ' )">');
							td.push('查看');
							td.push('</a>');
							td.push('</li>');
							td.push('<li>');
							td.push('<a class="btn btn-success" onClick="remove(' + record.id + ',\'' + record.userName + '\')">');
							td.push('停用');
							td.push('</a>');
							td.push('</li>');
						}else{
							td.push('<li>');
							td.push('<a class="btn btn-success" onClick="back(' + record.id + ',\'' + record.userName + '\')">');
							td.push('恢复');
							td.push('</li>');
						}
						td.push('</ul>');
						return td.join('');
					}
				}
			};
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/platform/list?insId='+insId+'&statId='+statId,
				'size' : 10,
				'ifRealPage' : 1
			};
			//初始化 并通过ajax加载数据
			dataTable = MTA.Data.loadAjaxPageTable(config);
		}
		/**
		*	删除数据
		*/
		function remove(id, name) {
			//弹出提示框 让用户确认删除
			var dialog = new GRI.Dialog({
				type : 4,
				title : '恢复帐号',
				content : '确定停止使用【' + name + '】吗？',
				deGRIil : '',
				btnType : 1,
				extra : {
					top : 250
				},
				winSize : 1
			}, function() {
				//用户点了 删除的确认信息
				$.ajax({
					type : "PUT",
					url : "${ctx}/platform/" + id,
					data : "{}",
					contentType : "application/json; charset=utf-8",
					dataType : "json",
					success : function(data) {
						if(data.code==200){
							buildDataTable();
						}
					},
					error : function(msg) {
						layer.alert(msg);
					}
				});
			});
		}
		function back(id, name) {
			//弹出提示框 让用户确认删除
			var dialog = new GRI.Dialog({
				type : 4,
				title : '停用帐号',
				content : '确定恢复使用【' + name + '】吗？',
				deGRIil : '',
				btnType : 1,
				extra : {
					top : 250
				},
				winSize : 1
			}, function() {
				//用户点了 删除的确认信息
				$.ajax({
					type : "DELETE",
					url : "${ctx}/platform/" + id,
					data : "{}",
					contentType : "application/json; charset=utf-8",
					dataType : "json",
					success : function(data) {
						if(data.code==200){
							buildDataTable();
						}
					},
					error : function(msg) {
						layer.alert(msg);
					}
				});
			});
		}
		
		/**
		*	展示编辑表单界面
		*	新增、修改都需要调用该方法打开表单
		*/
		function showEditorModel() {
			//重置表单
			$('img[name="photo"]').attr("src");
			var tool = new toolCtrl();
	            tool.clearForm();
	            
			$('#editorUserInfo input[name="password"]').val(''); 
			$('#editorUserInfo input[name="urole"][value="4"]').prop("checked",true);
			$('#editorUserInfo select[name="area"]').val('');
			$('#editorUserInfo select[name="station"]').val('');
			$('#editorUserInfo select[name="trainYard"]').val(''); 
			if(statId!="null"){
				$('.error').hide();
			}
			
			/* 获取id */
			var id = sessionStorage.getItem('tabId');
			if(id === null || id === undefined){
				layer.alert('未选择目标');
			}else{
				if (id) {
					//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
					$.getJSON("${ctx}/platform/" + id, function (result) {
						 if (result.code==200) {
							 	var data = result.data;
								$('#editorUserInfo input[name="id"]').val(data.id);
								$('#editorUserInfo input[name="userName"]').val(data.userName);
								$('#editorUserInfo input[name="mobile"]').val(data.mobile);
								//$('#editorUserInfo input[name="password"]').val(data.password); 
								$('img[name="photo"]').attr("src",data.headImg);
								$("#role").val(data.urole);
								$('#editorUserInfo select[name="area"]').val(data.areaId);
								
								if(data.urole == 3){
									
									$.ajax({
										url : '${ctx}/roleManger/getPlatformUserAuth',
										data : {
											platformUserId : sessionStorage.getItem('tabId')
										},
										type : 'post',
										success : function(result){
											
											var platformUserAuths = result.data;
											
											$("input[name=operationAuth]").prop('checked',false);
											for(var index in platformUserAuths){
												var operationItemId = platformUserAuths[index].operationItemId;
												var nodeIndex = "input[name=operationAuth][value="+operationItemId+"]";
												$(nodeIndex).prop('checked',true);
											}
										}
									});
									
									$("#auth").show();
								}else{
									$("#auth").hide();
								}
								
								if(data.urole==4){
									$('#editorUserInfo input[name="urole"][value="4"]').prop("checked",true);
								}else if(data.urole==5){
									$('#editorUserInfo input[name="urole"][value="5"]').prop("checked",true);
									var params = {
											id : data.drivingfiledId,
											insId :data.insId
									};
								
									$("#editorUserInfo select[name='trainYard']").empty();
									$("#editorUserInfo select[name='trainYard']").append("<option value=''>请选择</option>");
									$.post('${ctx}/drivingField/findByIdDriving', params, function(result) {
										if (result.code == 200) {
											for (var i = 0; i < result.data.length; i++) {
												$("#editorUserInfo select[name='trainYard']").append("<option value='" + result.data[i].id + "'>" + result.data[i].name + "</option>");
												if(data.areaId == result.data[i].id ){
													$('#editorUserInfo select[name="trainYard"]').val(result.data[i].id);
												}
											}
										}
									});
								}else if(data.urole==3){
									var params = {
											id : data.areaId,
											insId :data.insId
									};
									$('#editorUserInfo input[name="urole"][value="3"]').prop("checked",true);
									$("#editorUserInfo select[name='station']").empty();
									$("#editorUserInfo select[name='station']").append("<option value=''>请选择</option>");
									$.post('${ctx}/serviceStation/findByArea',params, function(result) {
										if (result.code == 200) {
											for (var i = 0; i < result.data.length; i++) {
												$("#editorUserInfo select[name='station']").append("<option value='" + result.data[i].id + "'>" + result.data[i].name + "</option>");
												if(data.stationId == result.data[i].id ){
													$('#editorUserInfo select[name="station"]').val(result.data[i].id);
												}
											}
										}
									});
							
								}else if(data.urole==2){
									$('#editorUserInfo input[name="urole"][value="2"]').prop("checked",true);
								}
								var aa = $('input[name="urole"]:checked').val();
								
								$('#editorUserInfo select[name="station"]').val(data.drivingfiledId);
								$('#editorUserInfo select[name="station"]').val(data.stationId);
						}
						$('#editorUser').modal('show');
					});
				}

			}
		}
		//保存
		function save() {
			//从form中取参数值
			var id = $('#editorUserInfo input[name="id"]').val();
			var userName = $('#editorUserInfo input[name="userName"]').val();
			var mobile = $('#editorUserInfo input[name="mobile"]').val();
			var urole = $('#editorUserInfo input:radio[name=urole]:checked').val();
			areaId=$("#editorUserInfo select[name='area']").val();
			var station;
			if(urole==3){
				station=$("#editorUserInfo select[name='station']").val();
				
			}
			var password = $('#editorUserInfo input[name="password"]').val();
			var drivingfiledId;
			if(urole==5){
				drivingfiledId=$("#editorUserInfo select[name='trainYard']").val();
			}
			
			var role=$("#role").val();
			var headImg = $('img[name="photo"]').attr("src");
			
			if(role!=""){
				if(role==1||role==0){
					urole=role;
				}
			}
			if(urole==3){
				if(station==""||station==null||station=="null"){
					layer.alert("请选择网点！");
					return false;
				}
			}else if(urole==3){
				station=0;
			}
			
			// 校验表单是否通过
			if( $("#editorUser .valid-form").Validform().check() != true ){
	  			return;
	        }
			
			var checkNode = $("input[name=operationAuth]:checked");
			var authIdValues = [];
			checkNode.each(function(){
				authIdValues.push($(this).val());
			});
			
			//定义提交到服务端的数据对象
			var params = {
				'id' : id,
				'insId' : insId,
				'userName' : userName,
				'mobile' : mobile,
				/* 'password' : password, */
				'station' : station,
				'urole':urole,
				'password':password,
				'headImg':headImg,
				'areaId':areaId,
				'drivingfiledId':drivingfiledId,
				'authIds' : authIdValues.join(',')
			};
			//发送数据到后端保存
			$.post('${ctx}/platform', params, function (result) {
				 if (result.code==200) {
					 //保存成功 刷新列表
			     	buildDataTable();
					 //关闭编辑的表单
					$('#editorUser').modal('hide');
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
				$("#photo").attr('src', datajson.data.s);
				console.log(data);
			}
		});
		function showSaveModel(){
			//重置表单
			$('img[name="photo"]').attr("src","");
			var tool = new toolCtrl();
	            tool.clearForm();
			/* $('#ediorForm input[name="password"]').val(''); */
			
			if(userUrole==1){
				$('#editorUserInfo input[name="urole"][value=1]').prop("checked",true);
			}else if(userUrole==2){
				$('#editorUserInfo input[name="urole"][value=2]').prop("checked",true);
			}else if(userUrole==3){
				$('#editorUserInfo input[name="urole"][value=3]').prop("checked",true);
			}else if(userUrole==4){
				$('#editorUserInfo input[name="urole"][value=4]').prop("checked",true);
			}else if(userUrole==5){
				$('#editorUserInfo input[name="urole"][value=5]').prop("checked",true);
			}
			$('#editorUserInfo input[name="password"]').val('');
			$('#editorUserInfo select[name="area"]').val('');
			$('#editorUserInfo select[name="station"]').empty();
			var urole = $('#editorUserInfo input:radio[name=urole]:checked').val();
			if( urole === '5' ){
				$(".tab-con").hide().eq(0).show();
				$(".tab-con").eq(1).show();
			}else if( urole === '3' ){
				$(".tab-con").hide().eq(0).show();
				$(".tab-con").eq(2).show();
			}else if( urole === '4'){
				$(".tab-con").hide().eq(0).show();
			}else if(urole === '2'){
				$(".tab-con").hide().eq(3).show();
			}
			
			$("input[name=operationAuth]").prop('checked',false);
			
			$('#editorUser').modal('show');
		}

		$("select[name='area']").change(function(){
			var urole = $('#editorUserInfo input:radio[name=urole]:checked').val();
			if(urole==5){
				var insId= '<sec:authentication property="principal.insId"/>';
				//var value=$(this).find("option:selected").text();
				var value=$(this).val();
				if(value=='0'){
					$("select[name='trainYard']").empty()
					$("select[name='trainYard']").append("<option value=''>请选择</option>");
				} else {
					var params = {
						id:value,
						insId:insId
					};
					$.post('${ctx}/drivingField/findByIdDriving', params, function (result) {
						$("select[name='trainYard']").empty()
						var nowstation=$("#nowstation").val();
						console.log(result);
							if (result.code==200) {
								$("select[name='trainYard']").append("<option value=''>请选择</option>");
							for(var i=0; i<result.data.length; i++){
								if(nowstation==result.data[i].name){
									$("select[name='trainYard']").append("<option selected='selected' value='"+result.data[i].id+"'>"+result.data[i].name+"</option>");
								}else {
									$("select[name='trainYard']").append("<option value='"+result.data[i].id+"'>"+result.data[i].name+"</option>");
								}
							}
						}
					});
				}
			}else if(urole==3){
				var insId= '<sec:authentication property="principal.insId"/>';
				var value=$(this).val();
				if(value=='0'){
					$("select[name='station']").empty()
					$("select[name='station']").append("<option value=''>请选择</option>");
				} else {
					var params = {
						id:value,
						insId:insId
					};
					$.post('${ctx}/serviceStation/findByArea', params, function (result) {
						$("select[name='station']").empty()
						var nowstation=$("#nowstation").val();
						console.log(result);
							if (result.code==200) {
								$("select[name='station']").append("<option value=''>请选择</option>");
							for(var i=0; i<result.data.length; i++){
								if(nowstation==result.data[i].name){
									$("select[name='station']").append("<option selected='selected' value='"+result.data[i].id+"'>"+result.data[i].name+"</option>");
								}else {
									$("select[name='station']").append("<option value='"+result.data[i].id+"'>"+result.data[i].name+"</option>");
								}
							}
						}
					});
				}
			}
		});
		$("#editorUserInfo .select-tab span").click(function(){
			$(this).find("input").prop("checked",true);
			var value = $(this).find("input").val();
			console.log(value);
			if( value === '5'){
				$(".tab-con").hide().eq(0).show();
				$(".tab-con").eq(1).show();
			}else if( value === '3' ){
				$(".tab-con").hide().eq(0).show();
				$(".tab-con").eq(2).show();
			}else if( value === '4'){
				$(".tab-con").hide().eq(0).show().eq(3).show();
			}else if( value === '2'||value === '1'){
				$(".tab-con").hide().eq(3).show();
			}
			
		})
		/**
		*	展示编辑表单界面
		*	新增、修改都需要调用该方法打开表单
		*/
		function showViewModel(id) {
			//重置表单
			$('#viewUserInfo img[name="photo"]').attr("src");
			var tool = new toolCtrl();
	            tool.clearForm();
			$('#viewUserInfo input[name="password"]').val('');
			//$('#viewUserInfo input[name="urole"][value="4"]').prop("checked",true);
			$('#viewUserInfo select[name="area"]').val('');
			$('#viewUserInfo select[name="station"]').val('');
			$('#viewUserInfo select[name="trainYard"]').val(''); 
			if(statId!="null"){
				$('.error').hide();
			}
			//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
			$.getJSON("${ctx}/platform/" + id, function (result) {
				 if (result.code==200) {
					 	var data = result.data;
						$('#viewUserInfo input[name="id"]').val(data.id);
						$('#viewUserInfo input[name="userName"]').val(data.userName);
						$('#viewUserInfo input[name="mobile"]').val(data.mobile);
						//$('#editorUserInfo input[name="password"]').val(data.password); 
						$('#viewUserInfo img[name="photo"]').attr("src",data.headImg);
						$("#viewUserInfo #role").val(data.urole);
						$('#viewUserInfo select[name="area"]').val(data.areaId);
						if( data.urole === 5 ){
							$("#viewUserInfo .tab-con").hide().eq(0).show();
							$("#viewUserInfo .tab-con").eq(1).show();
						}else if(data.urole === 3 ){//网点管理员
							$("#viewUserInfo .tab-con").hide().eq(0).show();
							$("#viewUserInfo .tab-con").eq(2).show();
						}else if(data.urole === 4){//片区管理员
							$("#viewUserInfo .tab-con").hide().eq(0).show();
						}else if(data.urole===2){//机构管理员
							$("#viewUserInfo .tab-con").hide().eq(3).show();
						}
						if(data.urole==4){
							$('#viewUserInfo input[name="urole"][value="4"]').prop("checked",true);
						}else if(data.urole==5){
							$("#viewUserInfo .select-tab span").each(function(){
								$('#viewUserInfo input[name="urole"]').prop("checked",false);
							});
							
							$('#viewUserInfo input[name="urole"][value="5"]').prop("checked",true);
							var params = {
									id : data.drivingfiledId,
									insId :data.insId
							};
						
							$("#viewUserInfo select[name='trainYard']").empty();
							$("#viewUserInfo select[name='trainYard']").append("<option value=''>请选择</option>");
							$.post('${ctx}/drivingField/findByIdDriving', params, function(result) {
								if (result.code == 200) {
									for (var i = 0; i < result.data.length; i++) {
										$("#viewUserInfo select[name='trainYard']").append("<option value='" + result.data[i].id + "'>" + result.data[i].name + "</option>");
										if(data.areaId == result.data[i].id ){
											$('#viewUserInfo select[name="trainYard"]').val(result.data[i].id);
										}
									}
								}
							});
						}else if(data.urole==3){
							var params = {
									id : data.areaId,
									insId :data.insId
							};
							$('#viewUserInfo input[name="urole"][value="3"]').prop("checked",true);
							$("#viewUserInfo select[name='station']").empty();
							$("#viewUserInfo select[name='station']").append("<option value=''>请选择</option>");
							$.post('${ctx}/serviceStation/findByArea',params, function(result) {
								if (result.code == 200) {
									for (var i = 0; i < result.data.length; i++) {
										$("#viewUserInfo select[name='station']").append("<option value='" + result.data[i].id + "'>" + result.data[i].name + "</option>");
										if(data.stationId == result.data[i].id ){
											$('#viewUserInfo select[name="station"]').val(result.data[i].id);
										}
									}
								}
							});
					
						}else if(data.urole==2){
							$('#viewUserInfo input[name="urole"][value="2"]').prop("checked",true);
						}
						var aa = $('#viewUserInfo input[name="urole"]:checked').val();
						
						$('#viewUserInfo select[name="station"]').val(data.drivingfiledId);
						$('#viewUserInfo select[name="station"]').val(data.stationId);
				}
				 $('#viewUser').modal('show');
			});
		}
	</script>
</body>
</html>