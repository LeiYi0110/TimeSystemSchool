<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<style>
	#uploadPhoto  .form-controll { width:360px; }
	#uploadPhoto label{ width:160px; }
	#uploadVideo  .form-controll { width:360px; }
	#uploadVideo label{ width:160px; }
	#Batch-img .img-item{ float:left; width:155px; margin-right:15px; margin-bottom:15px; text-align:center; }
	#Batch-img .img-item:nth-of-type(5n){ margin-right:0; }
	#Batch-img .img-item img{ display:block; width:100%; height:100%; }
</style>
<meta name="theme" content="school" />
<title>阳光驾培-学时管理</title>
<script type="text/javascript" src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=4O6x7Ox8vHvQeQgnMAPOolXiYkudOdZr"></script>
<script src="${ctx}/resources/uploadify/jquery.uploadify.js"></script>
</head>
<body>
	<div class="container-fluid new-admin">
		<div class="select-top">
			<a class="select-btn" onclick="updateAll(1)"><span class="spare"></span>批量通过</a>
			<a class="select-btn" onclick="updateAll(0)"><span class="spare"></span>批量否决</a>
			<a class="select-btn" onclick="batchUpdatePass(1)"><span class="spare"></span>选中批量通过</a>
			<a class="select-btn" onclick="batchUpdatePass(-1)"><span class="spare"></span>选中批量否决</a>
			<a class="select-btn" onclick="getImage()"><span class="spare"></span>查看照片</a>
		</div>
	</div>

	<div class="TermSearch">
		<input class="input1 win200" type="text" placeholder="输入学员姓名/编号/身份证" style="width:150px;" id="search">
		<input type="text" class="form_date input1 win90" data-date-format="yyyy-mm-dd" placeholder="请选择日期" readonly="readonly" id="day">
		<select id="subjectId">
		  	<option value="">请选择培训阶段</option>
		  	<option value="2">第二部分</option>
		  	<option value="3">第三部分</option>
		</select>
		<select id="inspass">
		  	<option value="">计时平台审核</option>
		  	<option value="-2">自动审核未通过</option>
		  	<option value="2">自动审核已通过</option>
		  	<option value="-1">未通过</option>
		  	<option value="1">已通过</option>
		</select>
		<select id="propass">
		  	<option value="">监管平台审核</option>
		  	<option value="0">未通过</option>
		  	<option value="1">已通过</option>
		</select>
		<button class="btn-flat primary" onClick="searchQuery();return false;">搜 索</button>
		<!-- <button class="btn-flat primary" onClick="searchPhoto();return false;">照 片 审 核</button> -->
	</div>
		
	<div class="row-fluid">
		<div class="sub_content">
			<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
			<div id="table_list" class="gri_wrapper"></div>
		</div>
	</div>
	
	<!-- 轨迹审核 -->
	<div class="modal fade colsform log-spare" id="locus" tabindex="-1" role="dialog" aria-hidden="true" style="width:1000px;margin-left:-500px;">
		<h4>轨迹审核</h4>
		<div id="locus-map" style="height:450px;"></div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			<!-- <button type="button" class="btn btn-primary" onClick="">审核</button> -->
		</div>
	</div>
	
	<div class="modal fade colsform" id="Batch-img" tabindex="-1" role="dialog"  aria-hidden="true">
		<div class="modal-content" id="photo">
			
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">关闭<tton>
		</div>
	</div>
	
	<div class="modal fade colsform" id="editorModal" tabindex="-1" role="dialog"
		aria-labelledby="editorModalLabel" aria-hidden="true"
		style="z-index: 2000; width: 360px;">
		
		<div class="row-fluid" style="padding-top: 20px;">
			<div class="span3">输入意见:</div>
			<div class="span9">
				<input type="hidden" id="recordid" value="">
				<textarea rows="" cols="" id="reason"></textarea>
			</div>
		</div>
		
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal" onClick="updateOne(1)">通过<tton>
			<button type="button" class="btn btn-default" data-dismiss="modal" onClick="updateOne(-1)">不通过<tton>
		</div>
	</div>
<script type="text/javascript">
//标识当前页面的url 用来设置当前菜单标识
		var dataTable = null;
		var recordUrl = <custom:properties name="bjxc.user.province"/>;
		var insId= '<sec:authentication property="principal.insId"/>';
		var insName = '<sec:authentication property="principal.insName"/>';
		var statId= '<sec:authentication property="principal.stationId"/>';
		var insCode = '<sec:authentication property="principal.insCode"/>';
		
		var recordId = sessionStorage.getItem("recordId");
		//初始化 
		$(document).ready(function() {
			//初始化界面  完成后调用buildData方法
			MTA.Report.initialize(null, 'buildData');
		});
		/**
		*	搜索
		*/
		function searchQuery() {
			var search = $("#search").val();
			var day = $("#day").val();
			var subjectId = $("#subjectId").val();
			var inspass = $("#inspass").val();
			var propass = $("#propass").val();
			MTA.Util.setParams('propass', propass);
			MTA.Util.setParams('inspass', inspass);
			MTA.Util.setParams('stunum', search);
			MTA.Util.setParams('day', day);
			MTA.Util.setParams('subjectId', subjectId);
			buildDataTable();
		}
		function buildData() {
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
				'checkbox' : {
					'thText' :'<input type="checkbox" class="js_checkbox_all js_checkbox_group" />全选'
									+'<input type="checkbox" class="js_checkbox_no js_checkbox_group"/>反选'
					,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						td = [];
						td.push('<span data-id="');
						td.push(record.id);
						td.push('">');
						var checkbox = '<input type="checkbox" value="'+record.id+'" class="js_checkbox"/>';
						td.push(checkbox);
						td.push('</span>');
						return td.join('');
					}
				},
				'recordnum' : {
					'thText' : '学时记录编号',
					'width' : '150px',
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						td = [];
						td.push(value);
						if(Number(record.imageCount) > 0){
							td.push("<span style='color:red'> 图片</span>");
						}
						return td.join('');
					}
				},
				'studentnum' : {'thText' : '学员编号'},
				'name' : {'thText' : '学员姓名'},
				'recordtime' : {'thText' : '记录时间'},
				'maxspeed' : { 
					'thText' : '最大速度(1/10km/h)'
				},
				'mileage' : {
					'thText' : '行驶距离(km)',
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						td = [];
						td.push(value / 10);
						return td.join('');
					}
				},
				'enginespeed' : { 
					'thText' : '发动机转速'
				},
				'carSpeed' : { 
					'thText' : '行驶记录速度（车辆）',
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						td = [];
						td.push(value / 10);
						return td.join('');
					}
				},
				'status' : {
					'thText' : '记录状态',
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						td = [];
						if (value == 0) {
							td.push('正常记录');
						} else if (value == 1) {
							td.push('异常记录');
						}
						return td.join('');
					}
				},
				'course' : {'thText' : '课程编码'},
				'subjectId' : {'thText' : '培训部分'},
				'inspass' : {
					'thText' : '审核结果',
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						td = [];
						if (value == -1) {
							td.push('<span style="color:red">无效</span>');
						} else if (value == 1) {
							td.push('有效');
						} else if (value == 2) {
							td.push('有效');
						} else if (value == -2) {
							td.push('<span style="color:red">无效</span>');
						}
						return td.join('');
					}
				},
				'inreason' : {'thText' : '审核意见'},
				'id' : {
					'thText' : '操作',
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
							var td = [];
							$("#batch").append(record.id+",");
							td.push('<ul class="actions">');
							td.push('<li>');
							/* if (record.inspass==null){
								td.push('<a class="btn btn-success"  onClick="updateOne(1,' + record.id + ')">');
								td.push('通过');
								td.push('</a>');
								td.push('<a class="btn btn-success"  onClick="updateOne(0,' + record.id + ')">');
								td.push('不通过');
								td.push('</a>');
							} */
							td.push('<a class="btn btn-success"  onClick="showModel(' + record.id + ')">');
							td.push('平台审核');
							/* td.push('</a>');
							td.push('<a class="btn btn-success"  onClick="locus(' + record.trainingrecordid + ')">');
							td.push('审核轨迹');
							td.push('</a>'); */
							td.push('</li>');
							td.push('</ul>');
							return td.join('');
					} 
				}
			};
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/trainingLog/getList?recordId='+recordId,
				'size' : 1000,
				'ifRealPage' : 0
			};
			config['callback'] = function(){
				//全选
				$(".js_checkbox_all").change(function(){
					$(".js_checkbox_no").prop("checked",false);
					var thisValue = $(this).prop("checked");
					$(".js_checkbox").prop("checked",!!thisValue);
				});
				//反选 
				$(".js_checkbox_no").change(function(){
					$(".js_checkbox_all").prop("checked",false);
					$(".js_checkbox").each(function(){
						var itemValue = $(this).prop("checked");
						$(this).prop("checked",!itemValue);
					});
				});
			}
			//初始化 并通过ajax加载数据
			dataTable = MTA.Data.loadAjaxPageTable(config);
		}
		
		function searchPhoto(){
			var search = $("#search").val();
			var subjectId = $("#subjectId").val();
			if(search!=""&&subjectId!="0"){
				$("#Batch-img").modal('show');
				var params={
					'stunum' : search,
					'subjectId' : subjectId
				};
				$.post("${ctx}/trainingLog/searchPhoto",params,function(result){
					console.log(result);
					var data=result.data;
					for(var i=0;i<data.length;i++){
						$("#photo").append('<div class="img-item">'+
						'<img alt="" src="'+data[i].imageurl+'">'+
						''+data[i].createtime+'</div>');
					}
				})
			}else{
				layer.alert("请输入学员编号或选择科目！");
			}
		}
		
		function updateAll(pass){
			var batchId=$("#batch").text().split(",");
			var dialog = new GRI.Dialog({
				type : 4,
				title : '审核学时',
				content : '确定批量审核？',
				deGRIil : '',
				btnType : 1,
				extra : {
					top : 250
				},
				winSize : 1
			}, function() {
				console.log(batchId);
				for(var i=0;i<batchId.length-1;i++){
					update(pass,batchId[i],null);
					buildDataTable();
				}
			});
		}
		
		function updateOne(pass){
			var id=$("#recordid").val();
			var reason=$("#reason").val();
			update(pass,id,reason);
			buildDataTable();
		}
		
		function showModel(id){
			$("#recordid").val(id);
			$("#editorModal").modal("show");
		}
		
		function update(pass,id,reason){
			var param={
				'pass' : pass,
				'id' : id,
				'reason' : reason
			};
			$.post('${ctx}/trainingLog/updatePass',param,function(result){
				console.log(result);
				if(result.code!=200){
					layer.alert(result.message);
					return false;
				}
			})
		}
		
		
		function locus(id){
			$("#locus").modal('show');
			// 练车场坐标
			var location = "113.819897,22.631837;113.819107,22.630953;113.819188,22.62986;113.820796,22.629226;113.82199,22.631061;";
			//var locus = "113.821155,22.630669;113.820616,22.631036;113.819969,22.631036;113.81943,22.63097;113.819358,22.630569;"
			var locus = "";
			if(id!=null){
				$.get('${ctx}/trainingLog/getLong?recordId='+id,function(result){
					console.log(result);
					//var a="";
					var data=result.data;
					for(var i=0;i<data.length;i++){
						var b=data[i].latitude+","+data[i].longtitude+";";
						locus+=b;
					}
					paint(location,locus);
				});
			}
		}
		
		function paint(location,locus){
			var t1 = window.setTimeout(function(){
				var map = new BMap.Map("locus-map",{enableMapClick:false});

				/* 生成地图  */
				var point = new BMap.Point(location.split(";")[0].split(",")[0] ,location.split(";")[0].split(",")[1]);
				map.centerAndZoom(point, 17);
				
				/* 绘制练车场  */
				var locationPoints = location.split(";");
				var points = [];
				for(var j=0;j<locationPoints.length-1;j++){
					var p1 = locationPoints[j].split(",")[0];
					var p2 = locationPoints[j].split(",")[1];
					points.push(new BMap.Point(p1,p2));
				}
				points.push(point);
				var line = new BMap.Polyline(points,{strokeStyle:'solid',strokeWeight:4,strokeColor:'#f00',strokeOpacity:0.6});
				map.addOverlay(line);
				
				/* 绘制轨迹  */
				var locationPoints = locus.split(";");
				var points = [];
				for(var j=0;j<locationPoints.length-1;j++){
					var p1 = locationPoints[j].split(",")[0];
					var p2 = locationPoints[j].split(",")[1];
					points.push(new BMap.Point(p1,p2));
				}
				var line = new BMap.Polyline(points,{strokeStyle:'solid',strokeWeight:4,strokeColor:'#51a351'});
				map.addOverlay(line);
				
				
				map.enableScrollWheelZoom(true);        // 开启鼠标滚轮缩放
				window.clearTimeout(t1);
			},350);
		}
		
		//批量更新
		function batchUpdatePass(pass){
			var checkboxGroup = $(".js_checkbox");
			var list = [];
			$(".js_checkbox").each(function(){
				var thisValue = $(this).val();
				if(!!thisValue && !!$(this).prop("checked")){
					list.push(thisValue);
				}
			});
			$.ajax({
				url : '${ctx}/trainingLog/batchUpdatePass',
				type : 'post',
				data : {
					pass : pass,
					ids : list.join(","),
					reason : null
				},
				success : function(result){
					if(result.code!=200){
						layer.alert(result.message);
					}else{
						layer.alert("保存成功");
						searchQuery();
					}
				}
			})
		}
		
		var eventInfo = {
			"0" : "中心查询的图片",
			"1" : "紧急报警主动上传的图片",
			"2" : "关车门后达到指定车速主动上传的图片",
			"3" : "侧翻报警主动上传的图片",
			"4" : "上客",
			"5" : "定时拍照",
			"6" : "进区域",
			"7" : "出区域",
			"8" : "事故疑点(紧急刹车)",
			"9" : "开车门",
			"17" : "学员登录拍照",
			"18" : "学员登出拍照",
			"19" : "学员培训过程中拍照",
			"20" : "教练员登录拍照",
			"21" : "教练员登出拍照"
		};
		
		//获取学时图片 
		function getImage(){
			var id = sessionStorage.getItem("tabId");
			$("#photo").empty();
			$.ajax({
				url : '${ctx}/trainingLog/getTrainingLogImage/' + id,
				type : 'get',
				success : function(result){
					var data = result.data;
					for (var i = 0; i < data.length; i++) {
						$("#photo").append('<div class="img-item">' +
							'<img alt="" class="js_image" data-id="'+data[i].id+'" src="' + data[i].imageUrl + '">' +
							data[i].createtime + '<br/>事件：' + 
							eventInfo[data[i].event+""] +
							'</div>');
					}
					$("#Batch-img").modal('show');
				}
			});
		}
		
</script>
</body>
</html>