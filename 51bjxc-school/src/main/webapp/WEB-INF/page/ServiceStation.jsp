<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-服务网点管理</title>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=4O6x7Ox8vHvQeQgnMAPOolXiYkudOdZr"></script>
</head>
<body>
	<div class="container-fluid new-admin">
		<div class="select-top">
		<sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
			<a class="select-btn" onclick="showEditorModel()"><span
				class="add"></span>新增</a> <a class="select-btn"
				onclick="showUpdateModel()"><span class="edit"></span>修改</a> <a
				class="select-btn" onclick="remove()"><span class="del"></span>删除</a>
		</sec:authorize>
		
		<sec:authorize access="hasRole('ROLE_SCHOOL_SERVICE')">
			<sec:authorize access="hasRole('ROLE_UserOperation_71')">
				<a class="select-btn" onclick="showEditorModel()"><span	class="add"></span>新增</a> 
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_72')">
				<a class="select-btn" onclick="showUpdateModel()"><span class="edit"></span>修改</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_73')"> 
				<a class="select-btn" onclick="remove()"><span class="del"></span>删除</a>
			</sec:authorize>
		</sec:authorize>
		</div>
	</div>

	<div class="TermSearch">
		<form>
			<input class="input1 win200" type="text" id="search"
				placeholder="名称/负责人">
			<buuton class="btn-flat primary"
				onClick="searchQuery();return false;">搜 索</buuton>
		</form>
	</div>


	<div class="row-fluid">
		<div class="sub_content">
			<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
			<div id="table_list" class="gri_wrapper"></div>

		</div>
	</div>


	<!-- 	<input type="text" class="search" placeholder="search" id="search" />
						<a class="btn-flat small" style="margin-right: 50px;"
							onClick="searchQuery();return false;">查询</a> -->

	<!-- 获取百度地图经纬坐标 -->
	<div class="modal fade modal-map" id="myModal" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">获取经纬度坐标</h4>
				</div>
				<div class="modal-body">
					<div style="width: 100%; height: 390px; position: relative;">
						<div id="allmap"
							style="width: 100%; height: 100%; overflow: hidden; margin: 0; font-family:"微软雅黑";"></div>
						<div
							style="position: absolute; top: 20px; left: 90px; height: 40px;">
							<input id="baiduSearch" type="text" placeholder="请输入地址进行搜索"
								style="height: 26px; padding: 0 10px; background-color: #fff; border: 1px solid #c4c7cc; margin: 0;">
							<button onClick="displayDate()"
								style="background-color: #3385ff; color: #fff; border: none; height: 26px; line-height: 26px; vertical-align: middle; margin-left: -1px;">点击搜索</button>
						</div>
						
						<script type="text/javascript">
							var x = document.getElementById("myModal") // 找到元素
							x.style.zIndex = "-1";

							var map = new BMap.Map("allmap",{enableMapClick:false}); // 创建Map实例

							var point = new BMap.Point(116.331398, 39.897445);
							map.centerAndZoom(point, 13);
							map.enableScrollWheelZoom(); //启用滚轮放大缩小，默认禁用
							map.enableContinuousZoom(); //启用地图惯性拖拽，默认禁用

							//城市IP定位
							function myFun(result) {
								var cityName = result.name;
								map.setCenter(cityName);
								//alert("当前定位城市:"+cityName);
							}
							var myCity = new BMap.LocalCity();
							myCity.get(myFun);

							//获取坐标
							map.addEventListener(
								"click",
								function(e) {
									document.getElementById("location").value = (e.point.lng + "," + e.point.lat);
									$("#myModal").modal('hide');
								}
							);

							//城市选择
							var size = new BMap.Size(10, 20);
							map.addControl(new BMap.CityListControl({
								anchor : BMAP_ANCHOR_TOP_LEFT,
								offset : size,
							}))

							//搜索功能
							function displayDate() {
								var local = new BMap.LocalSearch(map, {
									renderOptions : {
										map : map,
										panel : "r-result"
									},
									pageCapacity : 2
								});
								local.search(document
										.getElementById("baiduSearch").value,
										map.getBounds());
							}

							function myFunction() {
								x.style.zIndex = "9999";
							}
						</script>
					</div>
				</div>
			</div>
		</div>
	</div>





	<div class="modal fade colsform " tabindex="-1" id="editorModal"
		role="dialog" aria-hidden="true" style="width: 450px;">
		<form class="form-horizontal valid-form" id="ediorForm">
			<h4>报名处管理</h4>
			<div class="modal-content">
				<div class="left" style="width: auto;">
					<div class="row1">
						<div class="form-controll">
							 <label>名称:</label>
							<input class="span5" type="text" name="name" datatype="*"  nullmsg="名称不能为空" sucmsg=" ">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>隶属片区:</label>
							 <select name="areaId" id="areaId" datatype="*"  nullmsg="隶属片区不能为空" sucmsg=" "
								style="width: 175px;">
								<option value="">请选择</option>
								<c:forEach items="${areasList}" var="tmp">
									<option value="${tmp.id}">${tmp.name}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>地址:</label> <input type="text" name="address">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>负责人姓名:</label> <input type="text" name="functionary">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>联系电话:</label> <input type="text" name="contactMobile">
						</div>

					</div>
					<div class="row1">
						<div class="form-controll" style="width: auto; margin-right: 0;">
							<label>经纬度:</label> <input type="text" name="location"
								id="location" style="margin-right: 5px;"> <span
								class="btn-flat primary"
								style="height: 24px; line-height: 24px; padding: 0 8px;"
								data-toggle="modal" data-target="#myModal"
								onClick="myFunction()">获取经纬度</span>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" onClick="save();">保存</button>
			</div>
			 <input type="hidden" name="areaname" id="areaname">
			<input type="hidden" id="id" name="id">
		</form>
	</div>





	<script type="text/javascript">
		var insId = '<sec:authentication property="principal.insId"/>';
		//标识当前页面的url 用来设置当前菜单标识
		var dataTable = null;

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
				'name' : {
					'thText' : '名称',
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
						td.push(record.name);
						td.push('</span>');
						return td.join('');
					}
				},
				'areaname' : {
					'thText' : '隶属区域',
					'number' : false,
					'colAlign' : 'left',
					'thAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
				},
				'functionary' : {
					'thText' : '负责人姓名',
					'colAlign' : 'left',
					'thAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
				},
				'contactMobile' : {
					'thText' : '联系电话',
					'number' : false,
					'colAlign' : 'left',
					'thAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
				},
				'address' : {
					'thText' : '地址',
					'number' : false,
					'colAlign' : 'left',
					'thAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
				},
				'coachId' : {
					'thText' : '教练数量',
					'number' : false,
					'colAlign' : 'left',
					'thAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
				},
				'studentId' : {
					'thText' : '学员数量',
					'number' : false,
					'colAlign' : 'left',
					'thAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
				},
				'location' : {
					'thText' : '经纬度',
					'number' : false,
					'colAlign' : 'left',
					'thAlign' : 'left',
					'needOrder' : false,
					'precision' : 0,
				}
			};
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/serviceStation/list?insId=' + insId,
				'size' : 10,
				'ifRealPage' : 1
			};
			//初始化 并通过ajax加载数据
			dataTable = MTA.Data.loadAjaxPageTable(config);
		}
		
		/**
		 *	删除网点
		 */
		function remove() {
			var id=sessionStorage.getItem('tabId')
			if(id === null || id === undefined){
				alert('未选择目标');
			}else{
			$.getJSON("${ctx}/serviceStation/finddon?id=" + id + "&insId="
					+ insId, function(result) {
				if (result.code == 200) {
					var data = result.data;
					var gnl = confirm("阳光驾培温馨提示,您确定要删除吗?");
					if (gnl == true) {
						if (data.coachId > 0 || data.studentId > 0) {
							alert("该网点下还有教练员或学员,删除失败")
						} else {
							  var params={
								  'id':id
							  }
							$.post('${ctx}/serviceStation/deletes', params,
									function(result) {
										if (result.code == 200) {
											//保存成功 刷新列表
											layer.alert('删除成功');	 
										}else{
											layer.alert('删除失败')
										}
										buildDataTable();
									});
						}
						return true
					} else {
						return false
					}
				}
			})
		}
	}

		/**
		 *	展示编辑表单界面
		 *	新增、修改都需要调用该方法打开表单
		 */
		function showEditorModel() {
			//重置表单
			var tool = new toolCtrl();
			tool.clearForm();
			$('#ediorForm select[name="areaId"]').val('');

			$('#editorModal').modal('show');
		}
		//保存
		function save() {
			if( $("#editorModal .valid-form").Validform().check() == true ){  
			//从form中取参数值
			var id = $('#ediorForm input[name="id"]').val();
			var address = $('#ediorForm input[name="address"]').val();
			var areaname = $('#ediorForm select[name="areaId"]').find(
					"option:selected").text();
			var name = $('#ediorForm input[name="name"]').val();
			var functionary = $('#ediorForm input[name="functionary"]').val();
			var contactMobile = $('#ediorForm input[name="contactMobile"]')
					.val();
			var areaId = $('#ediorForm select[name="areaId"]').val();
			var location = $('#ediorForm input[name="location"]').val();

			//定义提交到服务端的数据对象
			var params = {
				'id' : id,
				'name' : name,
				'insId' : insId,
				'address' : address,
				'areaname' : areaname,
				'areaId' : areaId,
				'functionary' : functionary,
				'contactMobile' : contactMobile,
				'location' : location
			};
			//发送数据到后端保存
			$.post('${ctx}/serviceStation/saveUpdate', params,
					function(result) {
						if (result.code == 200) {
							//保存成功 刷新列表
							
							//关闭编辑的表单
						
								layer.alert('保存成功');
								$('#editorModal').modal('hide');
							
							//dataTable.refresh();
							buildDataTable();
						}else{
							layer.alert('保存失败')
						}
					});
		}
		}

		function showUpdateModel() {
			var id = sessionStorage.getItem('tabId')
			if (id === null || id === undefined) {
				alert('未选择目标');
			} else {
				//重置表单
				$('#ediorForm input[name="id"]').val('');
				$('#ediorForm input[name="address"]').val('');
				$('#ediorForm input[name="functionary"]').val('');
				$('#ediorForm input[name="contactMobile"]').val('');
				$('#ediorForm input[name="areaname"]').val();
				$('#ediorForm input[name="name"]').val('');
				$('#ediorForm input[name="studentId"]').val('');
				$('#ediorForm input[name="coachId"]').val('');
				$('#ediorForm select[name="areaId"]:checked').val('');
				$('#ediorForm input[name="location"]').val('');
				if (id) {
					//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
					$.getJSON("${ctx}/serviceStation/" + id, function(result) {
						if (result.code == 200) {
							var data = result.data;
							$('#ediorForm input[name="id"]').val(data.id);
							$('#ediorForm input[name="name"]').val(data.name);
							$('#ediorForm input[name="address"]').val(
									data.address);
							$('#ediorForm input[name="functionary"]').val(
									data.functionary);
							$('#ediorForm input[name="contactMobile"]').val(
									data.contactMobile);
							$('#ediorForm select[name="areaId"]').val(
									data.areaId);
							var areaId = $('#ediorForm select[name="areaId"]')
									.val();
							if (data.areaId != areaId) {
								$('#ediorForm select[name="areaId"]').val("");
							}
							$('#ediorForm input[name="location"]').val(
									data.location);
							$('#ediorForm input[name="studentId"]').val(
									data.studentId);
							$('#ediorForm input[name="coachId"]').val(
									data.coachId);
						}
					});
				}
				$('#editorModal').modal('show');
			}
		}
	</script>
</body>
</html>