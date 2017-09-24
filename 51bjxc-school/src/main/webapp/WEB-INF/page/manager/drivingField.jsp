<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp"%>
<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-场地管理</title>
<!-- 高德地图 -->
<script src="http://webapi.amap.com/maps?v=1.3&key=85e0a18ddc6ebb0ecb7efb35e8b73cbd"></script>
<script src="http://webapi.amap.com/ui/1.0/main.js"></script>
</head>
<body>

	<div class="container-fluid new-admin">
		<div class="select-top">
		<sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
			<a class="select-btn" data-toggle="modal" onClick="showEditorModel();"><span class="add"></span>新增</a>
			 <a class="select-btn" data-toggle="modal" onClick="showUpdateModel();"><span class="edit"></span>修改</a> 
			 <a class="select-btn " onClick="getResult()"><span class="del"></span>审核结果查询</a>
			 <a class="select-btn " onClick="deletes()"><span class="del"></span>删除</a>
			 <a class="select-btn" href="${ctx}/drivingField/dflist?insId=<sec:authentication property="principal.insId"/>"><span class="Export"></span>导出</a>
		</sec:authorize>
		
		<sec:authorize access="hasRole('ROLE_SCHOOL_SERVICE')">
			<sec:authorize access="hasRole('ROLE_UserOperation_75')">
				<a class="select-btn" data-toggle="modal" onClick="showEditorModel();"><span class="add"></span>新增</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_76')">
				 <a class="select-btn" data-toggle="modal" onClick="showUpdateModel();"><span class="edit"></span>修改</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_77')"> 
				 <a class="select-btn " onClick="getResult()"><span class="del"></span>审核结果查询</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_78')">
				 <a class="select-btn " onClick="deletes()"><span class="del"></span>删除</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_79')">
				 <a class="select-btn" href="${ctx}/drivingField/dflist?insId=<sec:authentication property="principal.insId"/>"><span class="Export"></span>导出</a>
			</sec:authorize>
		</sec:authorize>
		</div>
	</div>
	<div class="TermSearch">
		<form>
			<input class="input1 win200" type="text" id="search" placeholder="名称/地址搜索">
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

		<div class="modal fade" id="studentNum" tabindex="-1" role="dialog" aria-labelledby="editorModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">审核结果</h4>
				</div>
				<div class="row1">
						<div class="form-controll wid90">
							<label>培训机构编号:</label> <input type="text" name="inscode" value="">
						</div>
						<div class="form-controll wid90">
							<label>教学区域编号:</label> <input type="text" name="seq" value="">
						</div>
						<div class="form-controll wid90">
							<label>结果:</label> <div id="jieguo" style="float:left; font-size:16px; line-height:20px;"></div>
						</div>
					</div>
				<div class="modal-footer">
					<button type="button" id="bcountry" class="btn btn-default" onClick="searchResult()">查询</button>
				</div>
			</div>
		</div>
	</div>
		
		<!-- 练车场地 -->
		<div class="modal fade colsform right-map" tabindex="-1" id="editorModal" role="dialog" aria-hidden="true">
			<form class="form-horizontal  valid-form" id="ediorForm">
				<h4>练车场地</h4>
				<div class="modal-content">
					<div class="left" style="width:440px;">
						<div class="row1">
							<div class="form-controll">
								<label>名称:</label> <input type="text" name="name" id="name">
							</div>
						</div>
						<div class="row1">
							<div class="form-controll">
								<label>隶属片区:</label> <select name="areaId" id="areaId" datatype="*"  nullmsg="隶属片区不能为空" sucmsg=" ">
									<option value="">请选择</option>
									<c:forEach items="${areasList}" var="tmp">
									<option value="${tmp.id}">${tmp.name}</option>
								</c:forEach>
								</select>
							</div>
						</div>
						<div class="row1">
							<div class="form-controll">
								<label >教学区域类型:</label>
								<input type="radio" name="type" value="1" id="checkBox1" datatype="*" nullmsg="请选择教学区域类型" sucmsg=" "> 第二部分
								<input type="radio" name="type" value="2" id="checkBox2"> 第三部分
							</div>
						</div>
						<div class="row1">
							<div class="form-controll">
								<label>可容纳车辆数:</label> <input type="text" name="totalvehnum">
							</div>
						</div>
						<div class="row1">
							<div class="form-controll">
								<label>已容纳车辆数:</label> <input type="text" name="curvehnum">
							</div>
						</div>
						<div class="row1">
							<div class="form-controll">
								<label>面积m²:</label> <input type="text" name="area" datatype="*" nullmsg="面积不能为空" sucmsg=" ">
							</div>
						</div>
						<div class="row1">
							<div class="form-controll" style="width: 400px; marghin-right:0;">
								<label>地址:</label>
								<input type="text"  name="address" id="address2" datatype="*" nullmsg="地址不能为空" sucmsg=" " style="width:270px;">
							</div>
						
						</div>
						<div class="row1">
							<div class="form-controll" style="width: 400px; marghin-right:0;">
								<label>空间坐标:</label>
								<input type="text"  name="spatialCoordinates" id="spatialCoordinates" disabled="disabled" style="width:270px;" />
							</div>
						</div>
						
						
						<div class="row1">
							<div class="form-controll" style="width: 400px; marghin-right:0;">
								<label>手动输入:</label>
								<input type="text"  name="shoudong" id="shoudong"  style="width:270px;">
							</div>
						
						</div>
						<div class="row1">
							<div class="form-controll" style="width: 620px;">
								<label style="height: 50px;" >培训车型：</label> 
								    <input type="checkbox" name="vehicletype" value="A1" style="margin: 0 3px 0 0;"  datatype="*" nullmsg="培训车型不能为空" sucmsg=" " > A1
									<input type="checkbox" name="vehicletype" value="A2" style="margin: 0 3px 0 0;" > A2 
									<input type="checkbox" name="vehicletype" value="A3" style="margin: 0 3px 0 0;" > A3
									<input type="checkbox" name="vehicletype" value="B1" style="margin: 0 3px 0 0;" > B1
									<input type="checkbox" name="vehicletype" value="B2" style="margin: 0 3px 0 0;" > B2 
									<input type="checkbox" name="vehicletype" value="C1" style="margin: 0 3px 0 0;" > C1<br> 
									<input type="checkbox" name="vehicletype" value="C2" style="margin: 0 3px 0 0;" > C2 
									<input type="checkbox" name="vehicletype" value="C3" style="margin: 0 3px 0 0;" > C3 
									<input type="checkbox" name="vehicletype" value="C4" style="margin: 0 3px 0 0;" > C4 
									<input type="checkbox" name="vehicletype" value="C5" style="margin: 0 3px 0 0;" > C5
									<input type="checkbox" name="vehicletype" value="D" style="margin: 0 3px 0 0;"  >  D 
									<input type="checkbox" name="vehicletype" value="E" style="margin: 0 3px 0 0;"  >  E 
									<input type="checkbox" name="vehicletype" value="F" style="margin: 0 3px 0 0;"  >  F<br>
									<input type="checkbox" name="vehicletype" value="M" style="margin: 0 3px 0 0;"  >  M 
									<input type="checkbox" name="vehicletype" value="N" style="margin: 0 3px 0 0;"  >  N 
									<input type="checkbox" name="vehicletype" value="P" style="margin: 0 3px 0 0;"  >  P
							</div>
						</div>
					</div>
					<div class="right" id="right-map"><div class="btn btn-success map-pos" id="polygon">点击绘制练车场(鼠标双击或右键结束绘制)</div></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onClick="save();">保存</button>
				</div>
  		  	<input type="hidden" id="id" name="id" />
  		  	<input type="hidden" name="location" id="location" >
  		  	
			</form>
		</div>
		
		
		<!-- 详情 -->
		<div class="modal fade colsform right-map" tabindex="-1" id="desModal" role="dialog" aria-hidden="true">
			<form class="form-horizontal  valid-form" id="desForm">
				<h4>练车场地</h4>
				<div class="modal-content">
					<div class="left" style="width:440px;">
						<div class="row1">
							<div class="form-controll">
								<label>名称:</label> <input type="text" name="name" id="name" readonly="readonly">
							</div>
						</div>
						<div class="row1">
							<div class="form-controll">
								<label>场地编号:</label> <input type="text" name="seq" readonly="readonly">
							</div>
						</div>
						<div class="row1">
							<div class="form-controll">
								<label>隶属片区:</label> <select name="areaId" id="areaId"  readonly="readonly">
									<option value="">请选择</option>
									<c:forEach items="${areasList}" var="tmp">
									<option value="${tmp.id}">${tmp.name}</option>
								</c:forEach>
								</select>
							</div>
						</div>
						<div class="row1">
							<div class="form-controll">
								<label >教学区域类型:</label>
								<input type="radio" name="type" value="1" id="checkBox1" readonly="readonly" > 第二部分 
								<input type="radio" name="type" value="2" id="checkBox2" readonly="readonly"> 第三部分
							</div>
						</div>
						<div class="row1">
							<div class="form-controll">
								<label>可容纳车辆数:</label> <input type="text" name="totalvehnum" readonly="readonly">
							</div>
						</div>
						<div class="row1">
							<div class="form-controll">
								<label>已容纳车辆数:</label> <input type="text" name="curvehnum" readonly="readonly">
							</div>
						</div>
						<div class="row1">
							<div class="form-controll">
								<label>面积m²:</label> <input type="text" name="area" readonly="readonly">
							</div>
						</div>
						<div class="row1">
							<div class="form-controll">
								<label>空间坐标:</label> <input type="text" name="location" id="location" readonly="readonly">
							</div>
						</div>
						
						<div class="row1">
							<div class="form-controll" style="width: 400px; marghin-right:0;">
								<label>地址:</label>
								<input type="text"  name="address" id="address" readonly="readonly">
							</div>
						
						</div>
						<div class="row1">
							<div class="form-controll" style="width: 620px;">
								<label style="height: 50px;" >培训车型：</label> 
								    <input type="checkbox" name="vehicletype" value="A1" style="margin: 0 3px 0 0;" readonly="readonly"> A1
									<input type="checkbox" name="vehicletype" value="A2" style="margin: 0 3px 0 0;" > A2 
									<input type="checkbox" name="vehicletype" value="A3" style="margin: 0 3px 0 0;" > A3
									<input type="checkbox" name="vehicletype" value="B1" style="margin: 0 3px 0 0;" > B1
									<input type="checkbox" name="vehicletype" value="B2" style="margin: 0 3px 0 0;" > B2 
									<input type="checkbox" name="vehicletype" value="C1" style="margin: 0 3px 0 0;" > C1<br> 
									<input type="checkbox" name="vehicletype" value="C2" style="margin: 0 3px 0 0;" > C2 
									<input type="checkbox" name="vehicletype" value="C3" style="margin: 0 3px 0 0;" > C3 
									<input type="checkbox" name="vehicletype" value="C4" style="margin: 0 3px 0 0;" > C4 
									<input type="checkbox" name="vehicletype" value="C5" style="margin: 0 3px 0 0;" > C5
									<input type="checkbox" name="vehicletype" value="D" style="margin: 0 3px 0 0;"  >  D 
									<input type="checkbox" name="vehicletype" value="E" style="margin: 0 3px 0 0;"  >  E 
									<input type="checkbox" name="vehicletype" value="F" style="margin: 0 3px 0 0;"  >  F<br>
									<input type="checkbox" name="vehicletype" value="M" style="margin: 0 3px 0 0;"  >  M 
									<input type="checkbox" name="vehicletype" value="N" style="margin: 0 3px 0 0;"  >  N 
									<input type="checkbox" name="vehicletype" value="P" style="margin: 0 3px 0 0;"  >  P
							</div>
						</div>
					</div>
					<div class="right" id="right-map-item"></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
  		  <input type="hidden" id="id" name="id" />
			</form>
		</div>







		<script type="text/javascript">
			var recordUrl = <custom:properties name='bjxc.user.province'/>;
			var insCode = '<sec:authentication property="principal.insCode"/>';
			//重置菜单
			var current_action = "${ctx}/drivingField";
		</script>
		<script type="text/javascript">
			//标识当前页面的url 用来设置当前菜单标识
			var dataTable = null;
			var insId = '<sec:authentication property="principal.insId"/>';
			var insName = '<sec:authentication property="principal.insName"/>';
			var statId = '<sec:authentication property="principal.stationId"/>';
			var insCode = '<sec:authentication property="principal.insCode"/>';
			var zb=null;
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

					'seq' : {
						'thText' : '场地编号',
						'number' : false,
						'needOrder' : false,
						'precision' : 0,
					},
					'ttname' : {
						'thText' : '隶属片区',
						'number' : false,
						'needOrder' : false,
						'precision' : 0,
					},
					'address' : {
						'thText' : '地址',
						'number' : false,
						'needOrder' : false,
						'precision' : 0,
					},
					'area' : {
						'thText' : '面积',
						'number' : false,
						'needOrder' : false,
						'precision' : 0,
					},
					'vehicletype' : {
						'thText' : '培训车型',
						'number' : true,
						'needOrder' : false,
						'precision' : 0,
					},
					'totalvehnum' : {
						'thText' : '可容纳车辆数',
						'number' : false,
						'needOrder' : false,
						'precision' : 0,
					},
					'curvehnum' : {
						'thText' : '已容纳车量',
						'number' : false,
						'needOrder' : false,
						'precision' : 0,
					},
					'isNotice' : {
						'thText' : '审核',
						'number' : false,
						'needOrder' : false,
						'precision' : 0,
						'render' : function(value, cellmeta, record, rowIndex,
								columnIndex) {
							td = [];
							if (value == 0) {
								td.push('未审核');
							}else if (value == 1) {
								td.push('同意启用');
							}else if( value == 2 ){
								td.push('不同意启用');
							}else{
								td.push(record.isNotice);
							}
							return td.join('');
						}
					},
					'reason' : {
						'thText' : '审核意见',
						'number' : false,
						'needOrder' : false,
						'precision' : 0,
					},
					'isProvince' : {
						'thText' : '备案',
						'number' : false,
						'needOrder' : false,
						'precision' : 0,
						'render' : function(value, cellmeta, record, rowIndex,
								columnIndex) {
							td = [];
							if (value == 0) {
								td.push('未备案');
							} else if (value == 1) {
								td.push('已备案');
							}
							return td.join('');
						}
					},
					'location' : {
						'thText' : '空间坐标',
					}
				};
				//ajax的数据请求参数
				config['page'] = {
					'url' : '${ctx}/drivingField/list?insId=' + insId,
					'size' : 10,
					'ifRealPage' : 1
					
				};
				//初始化 并通过ajax加载数据
				dataTable = MTA.Data.loadAjaxPageTable(config);
			}
			/**
			 *	展示编辑表单界面
			 *	新增、修改都需要调用该方法打开表单
			 */
			 
			 
			
			var map = new AMap.Map('right-map', {
			    resizeEnable: true,
			    zoom:12
			});
			AMapUI.setDomLibrary($);
			AMapUI.loadUI(['misc/PoiPicker'], function(PoiPicker) {
			  	var poiPicker = new PoiPicker({
			      	input: 'address' //输入框id
			  	});
			  	//监听poi选中信息
			  	poiPicker.on('poiPicked', function(poiResult) {
			  	var address = poiResult.item.district + poiResult.item.address;
			  		$("#address").val(address);
			    	map.setZoomAndCenter(17,poiResult.item.location);
			  	});
			});
			map.plugin(["AMap.MouseTool"], function() {
			});
			var mouseTool = new AMap.MouseTool(map);
			AMap.event.addDomListener(document.getElementById('polygon'), 'click', function() {
				map.clearMap();
		    	mouseTool.polygon();
			}, false);
			AMap.event.addListener(mouseTool,"draw",function(e){
				var arrPath = e.obj.getPath();
				if(arrPath.length > 6){
					layer.alert('绘制的点大于6，请重新绘制');
					map.clearMap();
					mouseTool.polygon();
					return;
				}
				var str = '';
				for( var i=0; i<arrPath.length; i++){
					str += arrPath[i].getLng() + ',' + arrPath[i].getLat() + ';';
				}
				zb = str;
				$("#spatialCoordinates").val(zb);
			});
		
			
			
			
			 
			function showEditorModel() {
				//重置表单
				var tool = new toolCtrl();
				tool.clearForm();
				$('#ediorForm select[name="areaId"]').val('');
				$('#editorModal').modal('show');
				/* myMaps.init(map); */
			}
			
			function getResult(){
				$("#studentNum input[name='inscode']").val(insCode);
				$("#studentNum input[name='seq']").val('');
				$("#studentNum").modal("show");
			}
			
			function searchResult(){
				var inscode=$("#studentNum input[name='inscode']").val();
				var seq=$("#studentNum input[name='seq']").val();
				var param={
					'inscode' : inscode,
					'seq' : seq
				};
				$.post(recordUrl+"/province/regionreview/get",param,function(result){
					$("#jieguo").html(result.message);
					if(result.data.flag==1){
						$.get('${ctx}/drivingField/isprovince',param,function(result){
							layer.alert('备案成功');
						})
					}
				});
			}
	
	//增加两个变量，用来控制新增还是修改
	var dfSeq = null;
	var dfId = null;
			
	//修改
	function showUpdateModel() {
		var id=sessionStorage.getItem('tabId')
		var tool = new toolCtrl();
	    tool.clearForm();
	    map.clearMap();
	    var lineArr;
		if(id === null || id === undefined){
			alert('未选择目标');
		}else{
			$('#ediorForm select[name="areaId"]').val('');
			if (id) {	
				//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
				$.getJSON("${ctx}/drivingField/getselect?id=" + id, function(result) {
						if (result.code == 200) {
							var data = result.data;
							lineArr = data.location;
							$('#ediorForm input[name="id"]').val(data.id);
							$('#ediorForm input[name="name"]').val(data.name);
							$('#ediorForm input[name="seq"]').val(data.seq);
							
							$("#spatialCoordinates").val(data.location);
							
							dfId = data.id;
							dfSeq = data.seq;
							
							$('#address2').val(data.address);
							$('#ediorForm input[name="location"]').val(
									data.location);
							$('#ediorForm input[name="curvehnum"]').val(
									data.curvehnum);
							$('#ediorForm input[name="totalvehnum"]').val(
									data.totalvehnum);
							$('#ediorForm input[name="areasize"]').val(
									data.areasize);
							$('#ediorForm input[name="area"]').val(data.area);
							var arr = data.vehicletype.split(',');
							$('#ediorForm input[name="vehicletype"]').each(function(){
								for(var i=0; i<arr.length; i++){
									if($(this).val() === arr[i]){
										$(this).prop("checked",true);
									}
								}
							 });
							$('#ediorForm select[name="areaId"]').val(
									data.areaId);
							var areaId=$('#ediorForm select[name="areaId"]').val();
							if(data.areaId!=areaId){
								$('#ediorForm select[name="areaId"]')
								.val("");
							}	
							//Mod by Levin 20161224, 修改添加教学区域类型总是第一个问题
							//TYPE是必选字段，根据计时系统二选一
							if(data.type==2){
								document.getElementById("checkBox2").checked = true;
							}else{
								document.getElementById("checkBox1").checked = true;
							}
							$('#editorModal').modal('show');
							
							$(".tangram-suggestion-main").hide();
							
							/* 修改地图 */
							var locationArray = data.location.split(';');
							var max_latitude = 0;
							var min_latitude = 999;
							var max_longtitude = 0;
							var min_longtitude = 999;
							for(var i in locationArray){
								if(locationArray[i] === ""){
									continue;
								}
								var t_longtitude = Number(locationArray[i].split(',')[0]);
								var t_latitude = Number(locationArray[i].split(',')[1]);
								max_latitude = t_latitude > max_latitude ? t_latitude : max_latitude;
								min_latitude = t_latitude < min_latitude ? t_latitude : min_latitude;
								max_longtitude = t_longtitude > max_longtitude ? t_longtitude : max_longtitude;
								min_longtitude = t_longtitude < min_longtitude ? t_longtitude : min_longtitude;
							}
							var center_latitude = (max_latitude + min_latitude) / 2;
							var center_longtitude = (max_longtitude + min_longtitude) / 2;
							console.log(center_longtitude,center_latitude);
							map.setZoomAndCenter(17,[center_longtitude,center_latitude]);
							
							var locationPoints = new Array();
							var sLocationPoints = locationArray;
							for(var i=0; i<sLocationPoints.length-1; i++){
								if(sLocationPoints[i] === "") continue;
								var arr = [sLocationPoints[i].split(",")[0],sLocationPoints[i].split(",")[1]]
								locationPoints.push(arr);
							}
							var oldlocationPoints = locationPoints;
							var polygon = new AMap.Polygon({
								path: locationPoints,//设置多边形边界路径
								strokeColor: "#F33", //线颜色
								strokeOpacity: 0.2, //线透明度
								strokeWeight: 2,    //线宽
								fillColor: "#ee2200", //填充色
								fillOpacity: 0.1//填充透明度
							});
							polygon.setMap(map);
						}
					});
			}
		} 
	}
			
	//增加与修改用的是同一个这个方法
	//根据是否有id的值来判断是增加还是修改
	//如果是修改，seq保持不变，如果是新增，seq本机构自增
	//方法重构 20161225
	function save() {

		if(dfId == null || dfId == undefined || dfId==""){
			
			//获取最新的seq
			//此方法要同步执行，必须要返回seq，才能继续后面的操作
			$.ajaxSettings.async = false; 
			$.getJSON("${ctx}/drivingField/Incrementselect?insId=" + insId, function(resultd) {
				if (resultd.code == 200) {
					var data = resultd.data;
					dfSeq = data.seq;
				}
			});
		}

		//从form中取参数值
		var sId = '';
		var dId = '';
		var id = $('#ediorForm input[name="id"]').val();
		var name = $('#name').val();
		var seq = $('#ediorForm input[name="seq"]').val();
		var address = $('#ediorForm input[name="address"]').val();
		var area = $('#ediorForm input[name="area"]').val();
		var shoudong = $('#ediorForm input[name="shoudong"]').val();
		var vehicletype = $('#ediorForm input[name="vehicletype"]').val();
		$('#ediorForm input[name="vehicletype"]:checked').each(function() {
			sId += ($(this).val() + ',')});
		var vehicletype = sId.substring(0, sId.length - 1);
		var type=null;
						
		//Mod by Levin 20161224, 修改添加教学区域类型总是第一个问题
		//type默认为1，根据选中的值来选取
		var type=1;
		if(document.getElementById("checkBox2").checked){
			type = 2;
		}
						
		var curvehnum = $('#ediorForm input[name="curvehnum"]').val();
		var totalvehnum = $('#ediorForm input[name="totalvehnum"]').val();
		var areasize = $('#ediorForm input[name="areasize"]').val();
		var areaId =  $('#areaId').val();
					 	
		//封装提交到服务端的数据对象
		var param = {
			'inscode' : insCode,
			'seq' :dfSeq,
			'name' : name,
			'address' : address,
			'area' : area,
			'type' : type,
			'vehicletype' : vehicletype,
			'polygon' : zb,
			'totalvehnum' : totalvehnum,
			'curvehnum' : curvehnum,
		};
		if(shoudong!=''){
			param.polygon=shoudong;
		}			 	
		//提交到省平台备案
		$.post(recordUrl+'/province/region', param,function(result) {
			if (result.errorcode == 0) { 
				var params = {
					'id':id,
					'insId' : insId,
					'inscode':insCode,
					'seq' : dfSeq,
					'name' : name,
					'address' : address,
					'area' : area,
					'type' : type,
					'vehicletype' : vehicletype,
					'location' : zb,
					'totalvehnum' : totalvehnum,
					'curvehnum' : curvehnum,
					'areaId' : areaId
				};
				
				//发送数据到后端保存
				$.post('${ctx}/drivingField', params, function(result) {
					if (result.code == 200) {
						//关闭编辑的表单	
						layer.alert('保存成功');
						$('#editorModal').modal('hide');
					}else{
						layer.alert('保存失败')
					}
					buildDataTable();
				});
			} else {
				alert(result.message)
			}
		});
		
		//恢复异步
		$.ajaxSettings.async = true; 
		dfId = null;
		dfSeq = null;
	}
	
	
			//禁用
			function deletes() {
				var id = sessionStorage.getItem('tabId');
				if(id === null || id === undefined){
					alert('未选择目标');
				}else{
				$.getJSON("${ctx}/drivingField/getselect?id=" + id, function(result) {
					if (result.code == 200) {
						var data = result.data;
						if (data.status == 1) {
							var gnl = confirm("阳光驾培温馨提示,您确定要删除吗?");
							var seqs=data.seq;
							var seqLength = seqs.length;
							while(seqLength < 4) {  
						        seqs = "0" + seqs;  
						        seqLength++;  
						    }
							if (gnl == true) {
								var paramd={
									'inscode':insCode,
									'seq':seqs
								}
							$.post(recordUrl+'/province/region/delete', paramd,function(result) {
								if (result.errorcode == 0) { 
									var params = {
											'id' : id
										};
								//发送数据到后端保存
								$.post('${ctx}/drivingField/delete', params,function(results) {
											if (results.code == 200) {
												//保存成功 刷新列表
												layer.alert('删除成功');	 
											}else{
												layer.alert('删除失败')
											}
											buildDataTable();
										});
								}else{
									layer.alert(result.message)
								}
							})
								return true;
							} else {
								return false
							}
						} else {
							alert("该区域已被禁用")
						}
					}
				})
			}
		}
			
			function details(id){		
				var tool = new toolCtrl();
	            tool.clearForm();
				//重置表单
			$('#desForm select[name="areaId"]').val('');
				if (id) {	
					//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
					$.getJSON("${ctx}/drivingField/" + id, function(result) {
						if (result.code == 200) {
							var data = result.data;
							$('#desForm input[name="address"]').attr('id','');
							$('#desForm input[name="id"]').val(data.id);
							$('#desForm input[name="name"]').val(data.name);
							$('#desForm input[name="seq"]').val(data.seq);
							$('#desForm input[name="address"]').val(data.address);
							$('#desForm input[name="address"]').focus(function(){
								$(this).attr('id','address');
							})
							$('#desForm input[name="location"]').val(
									data.location);
							$('#desForm input[name="curvehnum"]').val(
									data.curvehnum);
							$('#desForm input[name="totalvehnum"]').val(
									data.totalvehnum);
							$('#desForm input[name="areasize"]').val(
									data.areasize);
							$('#desForm input[name="area"]').val(data.area);
							var arr = data.vehicletype.split(',');
							$('#desForm input[name="vehicletype"]').each(function(){
								for(var i=0; i<arr.length; i++){
									if($(this).val() === arr[i]){
										$(this).prop("checked",true);
									}
								}
							 });
							$('#desForm select[name="areaId"]').val(
									data.areaId);
							var areaId=$('#desForm select[name="areaId"]').val();
							if(data.areaId!=areaId){
								$('#desForm select[name="areaId"]')
								.val("");
							}	
							//Mod by Levin 20161224, 修改添加教学区域类型总是第一个问题
							//TYPE是必选字段，根据计时系统二选一
							if(data.type==2){
								document.getElementById("checkBox2").checked = true;
							}else{
								document.getElementById("checkBox1").checked = true;
							}					
						}
					});
				}
				$('#desModal').modal('show');
			}
		</script>

</body>
</html>