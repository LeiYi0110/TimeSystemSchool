<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp"%>
<html>
<head>

<meta name="theme" content="school" />
<link type="text/css" href="${ctx}/resources/css/compiled/new-form.css"
	rel="stylesheet" />
<link href="${ctx}/resources/css/bootstrap-datetimepicker.min.css"
	rel="stylesheet" media="screen" />
<link href="${ctx}/resources/js/form-prompt/style.css" type="text/css"
	rel="stylesheet" media="all" />
<script type="text/javascript"
	src="${ctx}/resources/js/form-prompt/Validform_v5.3.2_min.js"></script>
<script src="${ctx}/resources/uploadify/jquery.uploadify.js"></script>
<script type="text/javascript"
	src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript"
	src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/operationItem"></script>
<script type="text/javascript" src="${ctx}/resources/js/roleAuth/3"></script>
<script type="text/javascript" src="${ctx}/resources/js/userRoles"></script>
<style type="text/css">
.tab-pane span{ margin-right:15px; }
.tab-pane div > label{ height:100%; margin-bottom:0; }
.tab-pane div > span:nth-of-type(6n):after{ content:""; display:block; height:0px; }
</style>
<title>阳光驾培-角色权限管理</title>
</head>
<body>
	<div class="row-fluid">
		<div class="outline">
			<!-- 头部  -->
			<ul id="myTab" class="nav nav-tabs">
				<li class=""><a href="#turnOut" data-toggle="tab">管理员</a></li>
				<li class="active"><a href="#overTo" data-toggle="tab">普通用户</a></li>
			</ul>

			<div class="tab-content">
				<!-- 管理员 -->
				<div class="tab-pane" id="turnOut">
					<div class="sub_content">管理员有所以的权限</div>
				</div>
				<!-- 普通用户 -->
				<div class="tab-pane active" id="overTo">
					<!-- 普通用户-->
					<form class="form-inline" id="menus">
						<!-- demo -->
						<div class="sum">
							<h5>经营范围：</h5>			  		
			  			</div>
			  			<label>
			  				<div class="label-control">A1:</div>
			  				<input type="checkbox" min="0" max="99" name="licenseAndUse" class="width25 c1-subject1" value="0" >
			  			</label>
			  			<label>
			  				<div class="label-control">A1:</div>
			  				<input type="checkbox" min="0" max="99" name="licenseAndUse" class="width25 c1-subject1" value="0" >
			  			</label>
					</form>
					<div id="btn-wrap" style="text-align: center; padding-top: 40px;">
						<input id="save_btn" type="button" class="btn-flat primary" value="保存">
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
		$(document).ready(function() {
			//保存权限
			$("#save_btn").click(function() {
				var checkNode = $("input[name=operationAuth]:checked");
				var values = [];
				checkNode.each(function(){
					values.push($(this).val());
				});
				console.log(values);
				$.ajax({
					url : '${ctx}/roleManger/upateRoleAuth',
					type : 'POST',
					data : {
						authIds : values.join(',')
					},
					success : function(result){
						if(result.code == 200){
							layer.alert('保存成功');
						}
						else{
							layer.alert('保存失败');
						}
					}
				});
			});

			//加载菜单列表
			$(function() {
				var menus = $("#menus");
				$("#menus").empty();
				
				var divArray = [];
				for ( var index in operationItems) {
					if(!operationItems[index].parentId){
						var divNode = document.createElement("div");
						$(divNode).attr("class","sum");
						$(divNode).html('<h5>'+operationItems[index].itemName+'</h5>');

						divArray.push(divNode);
						
						for (var c_index in operationItems){
							if(Number(operationItems[c_index].parentId) == Number(operationItems[index].id)){

					  			var labelNode = document.createElement("label");
					  			var ldivNode = document.createElement("div");
					  			$(ldivNode).attr("class","label-control");
					  			$(ldivNode).html(operationItems[c_index].itemName);

								var inputNode = document.createElement("input");
								$(inputNode).attr("style","margin: 0 3px 0 0;");
								$(inputNode).val(operationItems[c_index].id);
								$(inputNode).attr("class","width25 c1-subject1");
								$(inputNode).attr("type","checkbox");
								$(inputNode).attr("name","operationAuth");
								
								$(labelNode).append(ldivNode);
								$(labelNode).append(inputNode);
								
								divArray.push(labelNode);

							}
						}
					}
				}
				menus.append(divArray);
				
				$("input[name=operationAuth]").prop('checked',false);
				for(var index in roleAuths){
					var operationItemId = roleAuths[index].operationItemId;
					var nodeIndex = "input[name=operationAuth][value="+operationItemId+"]";
					$(nodeIndex).prop('checked',true);
				}
			});
		});
	</script>
</body>
</html>