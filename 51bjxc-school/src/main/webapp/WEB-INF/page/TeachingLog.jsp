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
</style>
<meta name="theme" content="school" />
<title>阳光驾培-教学日志管理</title>
<script type="text/javascript" src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="http://webapi.amap.com/maps?v=1.3&key=85e0a18ddc6ebb0ecb7efb35e8b73cbd"></script>
<script src="${ctx}/resources/uploadify/jquery.uploadify.js"></script>
<script src="${ctx}/resources/js/ImageView.js"></script>
</head>
<body>
	<div class="container-fluid new-admin">
		<div class="select-top">
		<sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
			<a class="select-btn" onclick="add()"><span class="spare"></span>新增</a>
			<!-- <a class="select-btn" onclick="spare()"><span class="spare"></span>备案</a> -->
			<a class="select-btn" onclick="uploadPhoto()"><span class="spare"></span>图片资料</a>
			<a class="select-btn" onclick="uploadVideo()"><span class="spare"></span>视频资料</a>
			<a class="select-btn"><span class="Export"></span>导出</a>
		</sec:authorize>
		<sec:authorize access="hasRole('ROLE_SCHOOL_SERVICE')">
			<sec:authorize access="hasRole('ROLE_UserOperation_143')">
				<a class="select-btn" onclick="add()"><span class="spare"></span>新增</a>
			</sec:authorize>
			<!-- <a class="select-btn" onclick="spare()"><span class="spare"></span>备案</a> -->
			<sec:authorize access="hasRole('ROLE_UserOperation_144')">
				<a class="select-btn" onclick="uploadPhoto()"><span class="spare"></span>图片资料</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_145')">
				<a class="select-btn" onclick="uploadVideo()"><span class="spare"></span>视频资料</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_146')">
				<a class="select-btn"><span class="Export"></span>导出</a>
			</sec:authorize>
		</sec:authorize>
		
		<a class="select-btn" onclick="record()"><span class="spare"></span>备案</a>
		<a class="select-btn" onclick="trainLog()"><span class="spare"></span>学时审核</a>
		<a class="select-btn" onclick="locus()"><span class="spare"></span>轨迹审核</a>
		<a class="select-btn" onclick="searchPhoto()"><span class="spare"></span>照片审核</a>
		<a class="select-btn" onclick="checkTeachlog()"><span class="spare"></span>平台审核</a>
		</div>
	</div>
	<div class="TermSearch">
		<input class="input1 win200" type="text" placeholder="输入学员名称" style="width:150px;" id="search">
		<input type="text" class="form_date input1 win90" data-date-format="yyyy-mm-dd" placeholder="请选择日期" readonly="readonly" id="day">
		<select id="subjectId">
		  	<option value="">请选择培训阶段</option>
		  	<option value="1">第1部分</option>
		  	<option value="2">第2部分</option>
		  	<option value="3">第3部分</option>
		  	<option value="4">第4部分</option>
		</select>
		<select id="status">
		  	<option value="" selected="selected">未备案</option>
		  	<option value="">已备案</option>
		</select>
		
		<button class="btn-flat primary" onClick="searchQuery();return false;">搜 索</button>
	</div>
	<!-- <div class="alert alert-info log-info">
		<div class="log-item"><span class="log-info-label">电子教学日志编号:</span><span class="log-info-val">4651344</span></div>
		<div class="log-item"><span class="log-info-label">科目二:</span><span class="log-info-val">4651344</span></div>
	</div> -->
	<div class="row-fluid">
		<div class="sub_content">
			<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
			<div id="table_list" class="gri_wrapper"></div>
		</div>
	</div>
	
	<!-- 新增 -->
	<div class="modal fade colsform log-spare" id="add" tabindex="-1" role="dialog" aria-hidden="true">
		<h4>新增</h4>
		<div class="modal-content">
				<div class="row1">
				<span>平台编号:</span><input type="text" name="platnum" datatype="*" nullmsg="不能为空" sucmsg=" " >
				</div>
				<div class="row1">
				<span>机构编号:</span><input type="text" name="inscode" datatype="*" nullmsg="不能为空" sucmsg=" " >
				</div>
				<div class="row1">
				<span>学员编号:</span><input type="text" name="stunum" datatype="*" nullmsg="不能为空" sucmsg=" ">
				</div>
				<div class="row1">
				<span>课程编码:</span><input type="text" name="courseCode" datatype="*" nullmsg="不能为空" sucmsg=" ">
				</div>
				<div class="row1">
				<span>签到图片:</span><input type="text" name="photo1" datatype="*" nullmsg="不能为空" sucmsg=" ">
					<div class="right" style="height:30px;">
							<div class="swfobj">
								<div id="addphoto1">上传</div>
							</div>
							<a style="margin-top: -75px; width: 80px;" class="btn btn-success">上传</a>
					</div>
				</div>
				<div class="row1">
				<span>随机图片:</span><input type="text" name="photo2" datatype="*" nullmsg="不能为空" sucmsg=" ">
				<div class="right" style="height:30px;">
							<div class="swfobj">
								<div id="addphoto2">上传</div>
							</div>
							<a style="margin-top: -75px; width: 80px;" class="btn btn-success">上传</a>
					</div>
				</div>
				<div class="row1">
				<span>签退图片:</span><input type="text" name="photo3" datatype="*" nullmsg="不能为空" sucmsg=" ">
				<div class="right" style="height:30px;">
							<div class="swfobj">
								<div id="addphoto3">上传</div>
							</div>
							<a style="margin-top: -75px; width: 80px;" class="btn btn-success">上传</a>
					</div>
				</div>
				
				<div class="row1">
					<span>培训阶段:</span>
					<span style="padding-right:5px;"><input type="radio" checked="checked" name="part" value="1" style="margin:0 2px 0 0;">第一阶段</span>
					<span style="padding-right:5px;"><input type="radio" name="part" value="2" style="margin:0 2px 0 0;">第二阶段</span>
					<span style="padding-right:5px;"><input type="radio" name="part" value="3" style="margin:0 2px 0 0;">第三阶段</span>
					<span style="padding-right:5px;"><input type="radio" name="part" value="4" style="margin:0 2px 0 0;">第四阶段</span>
				</div>
				<div class="row1">
					<span>日期:</span><input type="text" name="createtime" datatype="*" nullmsg="不能为空" sucmsg=" " placeholder="YYYYMMDDHHmmss">
				</div>
				<div class="row1">
					<span>多条生成(测试用):</span>
					<select name="many">
						<option value="1">1条</option>
						<option value="10">10条（科目四）</option>
						<option value="12">12条（科目一）</option>
						<option value="16">16条（科目二）</option>
						<option value="24">24条（科目三）</option>
					</select>
				</div>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
			<button type="button" class="btn btn-primary" id="adds" onClick="addSave();">保存</button>
		</div>
	</div>
	
	<!-- 备案 -->
	<div class="modal fade colsform log-spare" id="spare" tabindex="-1" role="dialog" aria-hidden="true">
		<h4>备案</h4>
		<div class="modal-content">
			<div>
				<span>学时组成:</span>
				<label><input type="checkbox" />实车教学</label>
				<label><input type="checkbox" />课堂教学</label>
				<label><input type="checkbox" />模拟器教学</label>
				<label><input type="checkbox" />远程教学</label>
				<label><input type="checkbox" />混合教学</label>
			</div>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		</div>
	</div>
	
	<!-- 培训过程图片资料信息 -->
	<div class="modal fade colsform log-spare" id="uploadPhoto" tabindex="-1" role="dialog" aria-hidden="true" style="width:1000px;margin-left:-500px;">
		<h4>培训过程图片资料信息上传</h4>
		<div class="modal-content">
			<div class="left" style="width: 770px;">
					<div class="row1">
						<div class="form-controll">
							<label>培训机构编号(16位) :</label>
							<input type="text" name="inscode" datatype="*" nullmsg="不能为空" sucmsg=" ">
						</div>
						<div class="form-controll">
							<label>学员编号(16位) :</label>
							<input type="text" name="stunum" datatype="*" nullmsg="不能为空" sucmsg=" ">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>教练编号(16位) :</label>
							<input type="text" name="coachnum">
						</div>
						<div class="form-controll">
							<label>课程(10位) :</label>
							<input type="text" name="subjcode" datatype="*" nullmsg="不能为空" sucmsg=" ">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>来源计时终端编号(16位) :</label>
							<input type="text" name="platnum" datatype="*" nullmsg="不能为空" sucmsg=" ">
						</div>
						<div class="form-controll">
							<label>电子教学日志编号(5位) :</label>
							<input type="text" name="recnum" datatype="*" nullmsg="不能为空" sucmsg=" ">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>时间 :</label>
							<input type="text" name="ptime" datatype="*" nullmsg="不能为空" sucmsg=" " placeholder="YYYYMMDDHHmmss">
						</div>
						<div class="form-controll">
							<label>成功上传的图片文件ID :</label>
							<input type="text" name="fileid" datatype="*" nullmsg="不能为空" sucmsg=" " >
						</div>
					</div>
					<div class="row1">
					<div class="form-controll">
							<label>成功上传的图片文件url :</label>
							<input type="text" name="fileurl" datatype="*" nullmsg="不能为空" sucmsg=" " >
						</div>
						</div>
					<div class="row1">
					<div class="form-controll" name="fileinfo" style="width: 700px;">
							<label>上传的图片文件信息 :</label>
						</div>
					</div>
					
			</div>
			<div class="right">
						<div class="rk_swfupload">
							<div style="height: 60px; width: 100px; display: inline-block;">
								<span class="pic">图片资料<img id="photo1" name="photo1" src=""
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
			<button type="button" class="btn btn-primary" onClick="uploadPhotoSave();">上传</button>
		</div>
	</div>
	
	<!-- 培训过程视频资料信息 -->
	<div class="modal fade colsform log-spare" id="uploadVideo" tabindex="-1" role="dialog" aria-hidden="true" style="width:1000px;margin-left:-500px;">
		<h4>培训过程视频资料信息上传</h4>
		<div class="modal-content">
			<div class="left" style="width: 770px;">
					<div class="row1">
						<div class="form-controll">
							<label>计时终端编号(16位) :</label>
							<input type="text" name="devnum" datatype="*" nullmsg="不能为空" sucmsg=" ">
						</div>
						<div class="form-controll">
							<label>培训机构编号(16位) :</label>
							<input type="text" name="inscode" datatype="*" nullmsg="不能为空" sucmsg=" ">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>学员编号(16位) :</label>
							<input type="text" name="stunum" datatype="*" nullmsg="不能为空" sucmsg=" ">
						</div>
						<div class="form-controll">
							<label>教练编号(16位) :</label>
							<input type="text" name="coachnum">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>课程(10位) :</label>
							<input type="text" name="subjcode" datatype="*" nullmsg="不能为空" sucmsg=" ">
						</div>
						<div class="form-controll">
							<label>电子教学日志编号(5位) :</label>
							<input type="text" name="recnum" datatype="*" nullmsg="不能为空" sucmsg=" ">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>开始时间 :</label>
							<input type="text" name="starttime" datatype="*" nullmsg="不能为空" sucmsg=" " placeholder="YYYYMMDDHHmmss">
						</div>
						<div class="form-controll">
							<label>结束时间 :</label>
							<input type="text" name="endtime" datatype="*" nullmsg="不能为空" sucmsg=" " placeholder="YYYYMMDDHHmmss">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>触发事件 :</label>
							<input type="text" name="event" datatype="*" nullmsg="不能为空" sucmsg=" ">
						</div>
						<div class="form-controll">
							<label>成功上传的视频文件ID :</label>
							<input type="text" name="fileid" datatype="*" nullmsg="不能为空" sucmsg=" ">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>成功上传的视频文件url :</label>
							<input type="text" name="fileurl" datatype="*" nullmsg="不能为空" sucmsg=" " >
						</div>
						</div>
					<div class="row1">
						<div class="form-controll" name="fileinfo" style="width: 700px;">
							<label>上传的视频文件信息 :</label>
						</div>
					</div>
			</div>
					<div class="right">
						<div class="rk_swfupload">
							<div style="height: 60px; width: 100px; display: inline-block;">
								<span class="pic">视频资料<video autoplay id="video1" name="video1" src=""
									class="img-thumbnail upload-img"></video></span> <a
									style="margin-top: 20px; width: 100px;" class="btn btn-success">上传</a>
							</div>
							<div class="swfobj swfobj-position">
								<div id="upload_buton_video1"></div>
							</div>
						</div>
					</div>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			<button type="button" class="btn btn-primary" onClick="uploadVideoSave();">上传</button>
		</div>
	</div>
	
	<!-- 轨迹审核 -->
	<!-- <div class="modal fade colsform log-spare" id="locus" tabindex="-1" role="dialog" aria-hidden="true" style="width:1000px;margin-left:-500px;">
		<h4>轨迹审核</h4>
		<div id="locus-map" style="height:450px;"></div>
		<div class="modal-footer">
		<div class="modal-footer-left">
			当前部分其它轨迹
		</div>
			<div class="modal-footer-left">			
				<label class="ui-switch">
					<input type="hidden" id="recordId" value="">
					<input type="checkbox" id="elseInfo">
				</label>
			</div>
			<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			<button type="button" class="btn btn-primary" onClick="">审核</button>
		</div>
	</div> -->
	
	
	<!-- 轨迹审核2 -->
	<div class="modal fade colsform log-spare" id="locus" tabindex="-1" role="dialog" aria-hidden="true" style="width:1000px;margin-left:-500px;">
		<h4>轨迹审核</h4>
		<div class="modal-content">
			<div class="locus-left">
				<div id="locus-map2"></div>
				<div class="label-ctrl">
					<span>审核结果:</span>
					<label>
						<input type="radio" name="recordInpass" value="1">有效
					</label>
					<label>
						<input type="radio" name="recordInpass" value="0">无效
					</label>
				</div>
				<textarea placeholder="备注：" name="recordInreason" style="width:780px;"></textarea>
			</div>
			
			<div style="float: right;">
				<h5 style="padding-left: 10px;">电子教学日志编号</h5>
				<ul class="map-label" id="recordList">
					<!-- <li>
						<label>
							<input type="checkbox">00001<b style="border-color:blue"></b>				
						</label>
					</li>
					<li>
						<label>
							<input type="checkbox">00001<b></b>				
						</label>
					</li>
					<li>
						<label>
							<input type="checkbox">00001<b></b>				
						</label>
					</li> -->
				</ul>
			</div>
			
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			<button type="button" class="btn btn-primary" id="recordPassSave">审核</button>
		</div>
	</div>
	
	<!-- 照片审核 -->
	<div class="modal fade colsform" id="Batch-img" tabindex="-1" role="dialog"  aria-hidden="true">
		<h4>照片审核</h4>
		
		<div class="modal-content" >
			<div class="reserved-img">
				<img id="reserved-img" src="" >
				预留头像
			</div>
			<div id="photo"></div>
			<!-- <div class="Batch-item">
				<img alt="" src="http://img.91ygxc.com/2017/01/19/4f1dd82c-50df-46c8-9063-a78472d31f3a_s.jpg">
				<p>2017年1月20日09:00:01</p>
				<p>照片编号：001</p>
				<button type="button" class="btn btn-info img-contrast" >对比</button>
				<span class="label label-success">有效</span>
			</div>
			<div class="Batch-item">
				<img alt="" src="http://img.91ygxc.com/2017/01/19/4f1dd82c-50df-46c8-9063-a78472d31f3a_s.jpg">
				<p>2017年1月20日09:00:01</p>
				<p>照片编号：001</p>
				<button type="button" class="btn btn-info img-contrast">对比</button>
				<span class="label label-important">无效</span>
			</div> -->
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		</div>
	</div>
	
	<!-- 照片对比  -->
	<div class="modal fade colsform" id="Batch-img-contrast" tabindex="-1" role="dialog"  aria-hidden="true" >
		<h4>照片对比</h4>
		<div class="modal-content">
			<div class="item-info" id="deviceimage">
				<h5>照片编号：<span></span></h5>
				<div class="Batch-contrast-item">
					<img id="contrast1-item" class="img" alt="" src="http://img.91ygxc.com/2017/01/19/4f1dd82c-50df-46c8-9063-a78472d31f3a_s.jpg">
				</div>
				<p>签到照片 2017年1月20日09:00:12</p>
				<span>事件</span>
			</div>
			<div class="item-info">
				<h5>预留对比照片</h5>
				<div class="Batch-contrast-item" id="studentImage">
					<img id="contrast2-item" class="img" alt="" src="http://img.91ygxc.com/2017/01/19/4f1dd82c-50df-46c8-9063-a78472d31f3a_s.jpg">
				</div>
				<p>头像</p>
			</div>
			<div class="label-ctrl">
				<span>审核结果:</span>
				<label>
					<input type="radio" name="imagePass" value="1" >有效
				</label>
				<label>
					<input type="radio" name="imagePass" value="-1">无效
				</label>
			</div>
			<textarea placeholder="备注：" name="imageReason"></textarea>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			<button type="button" class="btn btn-success" data-dismiss="modal" id="imagePassSave">保存</button>
		</div>
	</div>
	
	<div class="modal fade colsform" id="Batch-checkTeachlog" tabindex="-1" role="dialog"
		aria-labelledby="searchPhotoLabel" aria-hidden="true"
		style="z-index: 2000; width: 360px;">
		
		<div class="row-fluid" style="padding-top: 20px;">
			<div class="span3">输入意见:</div>
			<div class="span9">
				<input type="hidden" id="recordid" value="">
				<input type="hidden" id="locu" value="">
				<textarea rows="" cols="" id="reason"></textarea>
			</div>
		</div>
			<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal" onClick="updateOne(1)">通过</button>
			<button type="button" class="btn btn-default" data-dismiss="modal" onClick="updateOne(-1)">不通过</button>
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
		//初始化 
		$(document).ready(function() {
			//初始化界面  完成后调用buildData方法
			MTA.Report.initialize(null, 'buildData');
			
			/*审核照片*/
			$("#imagePassSave").click(function(){
				var id = $(this).attr("data-imageId");
				var inpass =  $("[name=imagePass]:checked").val();
				var reason = $("[name=imageReason]").val();
				
				if(!inpass){
					layer.alert("请选择审核结果");
					return false;
				}
				
				$.ajax({
					url : '${ctx}/teachLog/passImage',
					type : 'post',
					data : {
						imageId : id,
						pass : inpass,
						reason : null
					},
					success : function(result){
						if(result.code!=200){
							layer.alert(result.message);
						}else{
							layer.alert("保存成功");
							searchPhoto();
						}
					}
				});
			});
			
			
			$("#recordPassSave").click(function(){
				var id = sessionStorage.getItem("tabId");
				if(!id){
					layer.alert("请选择教学日志");
					return false;
				}
				var inpass = $("[name=recordInpass]:checked").val();
				var reason = $("[name=recordInreason]").val();
				
				if(!inpass){
					layer.alert("请选择审核结果");
					return false;
				}
				
				$.ajax({
					url : '${ctx}/teachLog/passTeachLog',
					type : 'post',
					data : {
						recordIds : id,
						pass : inpass,
						reason : reason
					},
					success : function(result){
						if(result.code != 200){
							layer.alert(result.message);
						}else{
							layer.alert("保存成功");
							searchQuery();
						}
					}
				});
			});
			
		});
		/**
		*	搜索
		*/
		function searchQuery() {
			var search = $("#search").val();
			var day = $("#day").val();
			var subjectId = $("#subjectId").val();
			var status = $("#status").val();
			MTA.Util.setParams('searchText', search);
			//MTA.Util.setParams('status', status);
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
				'etrainingLogCode' : {
					'thText' : '电子教学日志编号',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<span data-id='+record.id+'>'+value+'</span>');
						return td.join('');
					}
				},
				/* 'stunum' : {
					'thText' : '学员编号',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				}, */
				'stuname' : {
					'thText' : '学员姓名',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'coachname' : {
					'thText' : '教练员姓名',
				},
				'subjectId' : {
					'thText' : '培训部分',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('第'+value+'部分');
						return td.join('');
					}
				},
				'starttime' : {
					'thText' : '开始时间',
				},
				'endtime' : {
					'thText' : '结束时间',
				},
				'courseCode' : {
					'thText' : '课程编号',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'mileage' : {
					'thText' : '培训里程', 
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push(value/10+"km");
						return td.join('');
					}
				},
				'duration' : {
					'thText' : '培训学时',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push(value+"min");
						return td.join('');
					}
				},
				'approvalDuration' : {
					'thText' : '全部累计学时', 
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push(value+"");
						return td.join('');
					}
				},
				'approvalDurationCount' : {
					'thText' : '认可学时', 
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push(value+"");
						return td.join('');
					}
				},
				'subjectApprovalDuration' : {
					'thText' : '本培训部分累计学时', 
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push(value+"");
						return td.join('');
					}
				},
				'subjectMileage' : {
					'thText' : '本培训部分累计里程', 
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push(value/10+"km");
						return td.join('');
					}
				},
				
				'zero' : {'thText' : '0速条数'},
				'five' : {'thText' : '1-5速条数'},
				'bigfive' : {'thText' : '>5速条数'},
				'inpass' : {
					'thText' : '审核结果',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						td = [];
						if (value == -1) {
							td.push('<span style="color:red">无效</span>');
						} else if (value == 1) {
							td.push('有效');
						} else if(value == 2){
							td.push('有效');
						}else if(value == -2){
							td.push('<span style="color:red">无效</span>');
						}
						return td.join('');
					}
				},
				'inreason' : {
					'thText' : '审核意见',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				/* 'isProvince' : {
					'thText' : '是否备案',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						td = [];
						if (value == 0) {
							td.push('未备案');
						} else if (value == 1) {
							td.push('已备案 ');
						}
						return td.join('');
					}
				}, */
				'id' : {
					'thText' : ' ',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'width' : '150px',
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
							var td = [];
						td.push('<ul class="actions">');
						td.push('<li>');
						/*td.push('<a class="btn-flat primary"  onClick="record(' + record.id + ')">');
						td.push('备案</a>');
						 if(record.subjectId==2||record.subjectId==3){
							td.push('<a class="btn-flat primary" onclick="trainLog(' + record.id + ')">');
							td.push('学时审核</a>');
							td.push('</a>');
							td.push('<a class="btn-flat primary"  onClick="locus(' + record.id + ')">');
							td.push('轨迹审核');
							td.push('</a>');
							td.push('<a class="btn-flat primary"  onClick="searchPhoto(' + record.id + ',' + record.studentId + ')">');
							td.push('照片审核');
							td.push('</a>');
							td.push('<a class="btn-flat primary"  onClick="checkTeachlog(' + record.id + ')">');
							td.push('平台审核');
							td.push('</a>');
						} */
						td.push('</li></ul>');
						return td.join('');
					}
				}
			};
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/teachLog/getList?insId='+insId,
				'size': '1000',
				'ifRealPage' : 0
			};
			//初始化 并通过ajax加载数据
			dataTable = MTA.Data.loadAjaxPageTable(config);
		}
		
		function trainLog(id){
			if(!arguments[0]){
				id = sessionStorage.getItem("tabId");
			}
			
			sessionStorage.setItem("recordId", id);
			window.location.href = "${ctx}/view/trainingLog";
		}
		
		$("#elseInfo").change(function() {
			var id = $("#recordId").val();
			var location = "116.208137,40.103899;116.208008,40.102914;116.209467,40.102569;116.211248,40.102619;116.211098,40.103964;116.209853,40.103931;";
			var locu=$("#locu").val();
        	if($("#elseInfo").is(':checked')){
        		$.get("${ctx}/trainingLog/getLong/"+id,function(result){
        			//paint(location,locu,result.data);
        		})
        	}else{
        		//paint(location,locu,null);
        	}
    	});
		
		function record(id){
			
			if(!arguments[0]){
				id = sessionStorage.getItem("tabId");
			}
			
			$.get('${ctx}/teachLog/getOne?id='+id,null,function(result){
				var param={
					'inscode' : result.data.inscode,
					'stunum' : result.data.stunum,
					'coachnum' : result.data.coachnum,
					'carnum' : result.data.carnum,
					'simunum' : result.data.devnum,
					'platnum' : result.data.platnum,
					'recnum' : result.data.etrainingLogCode,
					'subjcode' : result.data.courseCode,
					'photo1' : result.data.photo1,
					'photo2' : result.data.photo2,
					'photo3' : result.data.photo3,
					'starttime' : new Date(result.data.starttime).pattern('yyyyMMddHHmmss'),
					'endtime' : new Date(result.data.endtime).pattern('yyyyMMddHHmmss'),
					'duration' : result.data.duration,
					'mileage' : result.data.mileage,
					'avevelocity' : result.data.avevelocity,
					'coacmt' : result.data.coacmt,
					'total' : result.data.total,
					'part1' : result.data.part1,
					'part2' : result.data.part2,
					'part3' : result.data.part3,
					'part4' : result.data.part4
				};
				console.log(param);
				$.post(recordUrl+"/province/classrecord",param,function(results){
					if(results.errorcode==0){
						$.get("${ctx}/teachLog/updateLog?id="+id,null,function(resultss){
							buildDataTable();
							layer.alert("备案成功！");
						});
					} else{
						console.log(results);
						layer.alert(results.message);
					}
				});
			})
		}
		
		function uploadPhotoSave(){
			// 校验表单是否通过
			if( $("#uploadPhoto").Validform().check() != true ){
				return
			}
			var param={
					'inscode' : $('#uploadPhoto input[name="inscode"]').val(),
					'stunum' : $('#uploadPhoto input[name="stunum"]').val(),
					'coachnum' : $('#uploadPhoto input[name="coachnum"]').val(),
					'subjcode' : $('#uploadPhoto input[name="subjcode"]').val(),
					'platnum' : $('#uploadPhoto input[name="platnum"]').val(),
					'recnum' : $('#uploadPhoto input[name="recnum"]').val(),
					'ptime' : $('#uploadPhoto input[name="ptime"]').val(),
					'fileid' : $('#uploadPhoto input[name="fileid"]').val()
				};
			$.post(recordUrl+"/province/trainimginfo",param,function(results){
				if(results.errorcode==0){
					var param1 = {
							'traningrecordId' : sessionStorage.getItem('tabId'),
							'imageTime' : param.ptime,
							'imageUrl' : $('#uploadPhoto input[name="fileurl"]').val()
					}
					$.post('${ctx}/teachLog/uploadPhoto',param1,function(result){
						if(result.code==200){
						dataTable.refresh();
						$('#uploadPhoto').modal('hide');
							layer.alert("备案成功！");
						}
					});
				} else{
					layer.alert("备案失败！");
					layer.alert(results.message);
				}
			});
		}
		
		function uploadVideoSave(){
			// 校验表单是否通过
			if( $("#uploadVideo").Validform().check() != true ){
				return
			}
			var param={
					'devnum' : $('#uploadVideo input[name="devnum"]').val(),
					'inscode' : $('#uploadVideo input[name="inscode"]').val(),
					'stunum' : $('#uploadVideo input[name="stunum"]').val(),
					'coachnum' : $('#uploadVideo input[name="coachnum"]').val(),
					'subjcode' : $('#uploadVideo input[name="subjcode"]').val(),
					'recnum' : $('#uploadVideo input[name="recnum"]').val(),
					'starttime' : $('#uploadVideo input[name="starttime"]').val(),
					'endtime' : $('#uploadVideo input[name="endtime"]').val(),
					'event' : $('#uploadVideo input[name="event"]').val(),
					'fileid' : $('#uploadVideo input[name="fileid"]').val()
				};
			$.post(recordUrl+"/province/videorecord",param,function(results){
				if(results.errorcode==0){
					var param1 = {
							'traningrecordId' : sessionStorage.getItem('tabId'),
							'starttime' : param.starttime,
							'endtime' : param.endtime,
							'event' : param.event,
							'videoURL' : $('#uploadVideo input[name="fileurl"]').val()
					}
					$.post('${ctx}/teachLog/uploadVideo',param1,function(result){
						if(result.code==200){
						dataTable.refresh();
						$('#uploadVideo').modal('hide');
							layer.alert("备案成功！");
						}
					});
				} else{
					layer.alert("备案失败！");
					layer.alert(results.message);
				}
			});
		}
		
		function addSave(){
			// 校验表单是否通过
			if( $("#add").Validform().check() != true ){
				return
			}
			$("#adds").attr('disabled','true');
			
			var param={
					'platnum' : $('#add input[name="platnum"]').val(),
					'inscode' : $('#add input[name="inscode"]').val(),
					'etrainingLogCode' : $('#add input[name="etrainingLogCode"]').val(),
					'stunum' : $('#add input[name="stunum"]').val(),
					'courseCode' : $('#add input[name="courseCode"]').val(),
					'photo1' : $('#add input[name="photo1"]').val(),
					'photo2' : $('#add input[name="photo2"]').val(),
					'photo3' : $('#add input[name="photo3"]').val(),
					'mileage' : $('#add input[name="mileage"]').val(),
					'duration' : $('#add input[name="duration"]').val(),
					'part' : $('#add input[name="part"]:checked').val(),
					'createtime' : $('#add input[name="createtime"]').val(),
					'many' : $('#add select[name="many"]').val()
				};
			$.post('${ctx}/teachLog/addLog',param,function(result){
				$("#adds").removeAttr("disabled");
				if(result.code==200){
					dataTable.refresh();
					$('#add').modal('hide');
					layer.alert("添加成功！");
				}else{
					layer.alert("添加失败！");
				}
			});
	}

	var studentImage = null;//用于在弹出对比模态框时候使用 
	function searchPhoto(id,studentId) {
		
		if(!arguments[0]){
			id = sessionStorage.getItem("tabId");
		}
		
		$("#Batch-img").modal('show');
		$.get("${ctx}/trainingLog/searchPhoto?id="+id, function(result) {
			var data = result.data;
			$("#photo").empty();
			for (var i = 0; i < data.length; i++) {
				if(Number(data[i].event) == Number(21) || Number(data[i].evnet) == Number(20)){
					continue;
				}
				
				$("#photo").append('<div class="Batch-item">' +
					'<img data-id="'+data[i].id+'" src="' + data[i].imageurl + '">' +
					'<p>' + data[i].createtime + '</p>' + 
					'<p>图片编号:' + data[i].imageNum + '</p>' +
					'<p>事件:' + eventInfo[(data[i].event+"")] + '</p>' +
					'<button type="button" class="btn btn-info img-contrast" onclick="onContrast(\''+ 
							data[i].id +'\',\''+ data[i].imageurl +'\',\''+ 
							data[i].imageNum +'\',\''+data[i].createtime+'\',\''+
							data[i].studentId +'\',\'' + data[i].event + '\')">对比</button>' +
							(Number(data[i].inpass) > 0 ? '<span class="label label-success">有效</span>' 
							: (Number(data[i].inpass) < 0 ? '<span class="label label-important">无效</span>' : '') ) + 
					'</div>');
				if(!studentId){
					studentId = data[i].studentId;
				}
			}
			
			//请求学员头像
			$.ajax({
				type : "get",
				url : "${ctx}/teachLog/getStudentImg?studentId=" + studentId,
				success : function(result){
					$("#reserved-img").attr('src',result.data);
					studentImage = result.data;
				}
			}); 
			
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
		
	/*
	打开对比模态框 
	*/
	function onContrast(imageId , imageUrl , imageNum , imageTime , studentId , event){
		//分钟学时图片
		$("#deviceimage h5 span").html(imageNum);
		$("#deviceimage p").html(imageTime);
		$("#deviceimage span").html('事件：' + eventInfo[event+""]);
		$("#deviceimage div").empty();
		$("#deviceimage div").append('<img id="contrast1-item" class="img" alt="" src="'+ imageUrl +'">');
		//学员头像图片
		$("#studentImage").empty();
		$("#studentImage").append('<img id="contrast2-item" class="img" src="'+studentImage+'">');
		//保存按钮使用id
		$("#imagePassSave").attr("data-imageId",imageId);
		
		$("#Batch-img-contrast").modal('show'); 
		
		//初始化图片放大缩小 ， 由于模态框打开需要时间 ， 限于插件局限 ， 在模态框完全打开之后才初始化， 采用延时来等待模态框打开  
		var t2 = window.setTimeout(function(){
			var imageview = new ImageView(document.getElementById('contrast1-item'), {
				movingCheck: false, // 可选， 当移动的时候，是否检查边界，达到的效果就是当到边界的时候，
				                    // 可不可以继续拖拽等效果 实验下就明白了 默认true
				scaleNum: 1 // 可选，缩放比例 当进行缩放时 scale 时的比例 默认2
			});
			
			var imageview = new ImageView(document.getElementById('contrast2-item'), {
				movingCheck: false, // 可选， 当移动的时候，是否检查边界，达到的效果就是当到边界的时候，
				                    // 可不可以继续拖拽等效果 实验下就明白了 默认true
				scaleNum: 1 // 可选，缩放比例 当进行缩放时 scale 时的比例 默认2
			});
			window.clearTimeout(t2);
		},500);
	}
	

	function checkTeachlog(id){
		if(!arguments[0]){
			id = sessionStorage.getItem("tabId");
		}
		
		
		$("#recordid").val(id);
		$("#Batch-checkTeachlog").modal('show');
	}
	
	function updateOne(pass){
		var id=$("#recordid").val();
		var reason=$("#reason").val();
		
		var param={
				'pass' : pass,
				'id' : id,
				'reason' : reason
			};
			$.post('${ctx}/teachLog/updatePass',param,function(result){
				console.log(result);
				if(result.code==200){
					layer.alert(result.message);
					buildDataTable();
				}else{
					layer.alert(result.message);
					return false;
				}
			});
		
	}
	
	var map;
	function locus(id){
		
		if(!arguments[0]){
			id = sessionStorage.getItem("tabId");
		}

		// 练车场坐标
		//var location = "116.208137,40.103899;116.208008,40.102914;116.209467,40.102569;116.211248,40.102619;116.211098,40.103964;116.209853,40.103931;";
		//var locus = "116.209008,40.102769;116.209999,40.103169;116.210000,40.103669;";
		//var location = "113.815639,22.632704;113.814948,22.630769;113.817131,22.62971;113.818909,22.631987;";
		$.get('${ctx}/drivingField/getDrivingFieldByCoach?recordId='+id,function(result){
				if(result.code==200){
					var location = result.data.location;
					//TODO 计算练车场中心坐标 
					var locationArray = location.split(';');
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
					//
					
					var locus = "";
					if(!!id){
						var recordId = $("#recordId").val(id);
						
						$.ajax({
							url : '${ctx}/trainingLog/getLongAll/' + id,
							type : 'get',
							success : function(result){
								var data = result.data;
								
								var color = "#FFFFFF";
								$("#recordList").empty();
			
								map = new AMap.Map("locus-map2",{});
								map.setZoomAndCenter(17,[center_longtitude,center_latitude]);//地图缩放至指定级别并以指定点为地图显示中心点 
								
								// 绘制区域 
								var locationPoints = new Array();
								var sLocationPoints = location.split(";");
								for(var i=0; i<sLocationPoints.length-1; i++){
									var arr = [sLocationPoints[i].split(",")[0],sLocationPoints[i].split(",")[1]]
									locationPoints.push(arr);
								}
							   	var polygon = new AMap.Polygon({
							        path: locationPoints,//设置多边形边界路径
							        strokeColor: "#F33", //线颜色
							        strokeOpacity: 0.2, //线透明度
							        strokeWeight: 2,    //线宽
							        fillColor: "#ee2200", //填充色
							        fillOpacity: 0.1//填充透明度
							    });
							   	polygon.setMap(map);
			
								for(var index = 0 ;index < data.length; index++){
									var item = data[index];
									//选择颜色
									color = "#4B0082";
									var unit = ["09","AA","F0"];//支持27种颜色  
									var colorValueCount = unit.length;
									if(!!unit[index % colorValueCount] && !!unit[Math.floor(index % (colorValueCount * colorValueCount) / colorValueCount)]
										&& !!unit[Math.floor(index / (colorValueCount * colorValueCount))]){
										color = "#" + unit[index % colorValueCount] + unit[Math.floor(index % (colorValueCount * colorValueCount) / colorValueCount)]
											+ unit[Math.floor(index / (colorValueCount * colorValueCount))];
									}
									//TODO
									
									//创建图例
									var recordId = !!item ? item[0].recordId : 0;
									var sCoordinate = ""; 
									for(var positionIndex in item){
										var positionItem = item[positionIndex];
										if(!positionItem.longtitude || !positionItem.latitude){
											continue;
										}
										sCoordinate += positionItem.longtitude + ',' + positionItem.latitude + ';';
									}
									sCoordinate = sCoordinate.substr(0,sCoordinate.length-1);
									$("#recordList").append('<li><label>'
											+ '<input type="checkbox" name="recordLine" value="'+ sCoordinate +'" data-id="' + recordId + '" data-color="'+color+'" checked />'
											+ '<cnode name="recordSpan" data-id="' + recordId +'">' + recordId + '</cnode><b style="border-color:' + color + '"></b>'
											+ '</label></li>');
									
									var strokeWeight = 1;
									if(Number(item[0].recordId) == Number(id)){
										//当前选择记录的线，处理！！！
										//TODO 变颜色啊什么的 
										strokeWeight = 2;
										
										$("cnode[name=recordSpan][data-id="+id+"]").css("color","red");
									}
									
									
									
									//划线
									var locationPoints = new Array();
									for(var positionIndex in item){
										var positionItem = item[positionIndex];
										if(!positionItem.longtitude || !positionItem.latitude){
											continue;
										}
										locationPoints.push([positionItem.longtitude,positionItem.latitude]);
									}
									
									
									var polyline = new AMap.Polyline({
								        path: locationPoints,          //设置线覆盖物路径
								        strokeColor: color, //线颜色
								        strokeOpacity: 1,       //线透明度
								        strokeWeight: strokeWeight,        //线宽
								        strokeStyle: "solid",   //线样式 
								        strokeDasharray: [10, 5] //补充线样式
								    });
									polyline.setMap(map);
								}
								
								// 监控图例
								var mapLabel = $(".map-label :checkbox");
								mapLabel.change(function(){
									var arrline = [];
									var arrcolor = [];
									var arrid = [];
									mapLabel.each(function(){
										if($(this).is(":checked")){
											var thisColor = $(this).attr("data-color");
											arrline.push($(this).val());
											arrcolor.push(thisColor);
											arrid.push($(this).attr('data-id'));
										}
									})
									redrawLine(map,arrline,arrcolor,arrid);
								})
								
							   	$("#locus").modal('show');
							}
						});
			
						function redrawLine(map,line,color,arrid){
							// 清除覆盖物 
							map.clearMap();
							
							
							// 绘制区域 
							var location = "116.208137,40.103899;116.208008,40.102914;116.209467,40.102569;116.211248,40.102619;116.211098,40.103964;116.209853,40.103931;";
							var locationPoints = new Array();
							var sLocationPoints = location.split(";");
							for(var i=0; i<sLocationPoints.length-1; i++){
								var arr = [sLocationPoints[i].split(",")[0],sLocationPoints[i].split(",")[1]]
								locationPoints.push(arr);
							}
						   	var polygon = new AMap.Polygon({
						        path: locationPoints,//设置多边形边界路径
						        strokeColor: "#F33", //线颜色
						        strokeOpacity: 0.2, //线透明度
						        strokeWeight: 2,    //线宽
						        fillColor: "#ee2200", //填充色
						        fillOpacity: 0.1//填充透明度
						    });
						   	polygon.setMap(map);
						   	
						   	for(var i = 0 ;i < line.length; i++){
						   		if(!line[i]){
						   			continue;
						   		}
						   		//划线
						   		var lineAll = line[i].split(";");
						   		var locationPoints = new Array();
								for(var j=0; j<lineAll.length; j++){
									var linePoint = lineAll[j].split(",")
									locationPoints.push([linePoint[0],linePoint[1]]);
								}
								
								var strokeWeight = 1;
								if(arrid[i] == Number(id)){
									//当前选择记录的线，处理！！！
									//TODO 变颜色啊什么的 
									strokeWeight = 2;
								}
								
								var polyline = new AMap.Polyline({
							        path: locationPoints,          //设置线覆盖物路径
							        strokeColor: color[i], //线颜色
							        strokeOpacity: 1,       //线透明度
							        strokeWeight: strokeWeight,        //线宽
							        strokeStyle: "solid",   //线样式 
							        strokeDasharray: [10, 5] //补充线样式
							    });
								polyline.setMap(map);
							}
						   	
						}
						
						/* $.get('${ctx}/trainingLog/getLong?recordId='+id,function(result){
							console.log(result);
							var a="";
							var data=result.data;
							for(var i=0;i<data.length;i++){
								var b=data[i].longtitude+","+data[i].latitude+";";
								locus+=b;
							}
							$("#locu").val(locus);
							//paint(location,locus,null);
							map2(location,locus);
						}); */
					}
				}else{
					layer.alert(result.message);
					return false;
				}
			});
	}
		
		
		
		function map2(location){
			var t3 = window.setTimeout(function(){
				map = new AMap.Map("locus-map2",{});
				
				map.setZoomAndCenter(15,[location.split(";")[0].split(",")[0] ,location.split(";")[0].split(",")[1]]);
				var locationPoints = new Array();
				var sLocationPoints = location.split(";");
				for(var i=0; i<sLocationPoints.length-1; i++){
					var arr = [sLocationPoints[i].split(",")[0],sLocationPoints[i].split(",")[1]]
					locationPoints.push(arr);
				}
			   	var polygon = new AMap.Polygon({
			        path: locationPoints,//设置多边形边界路径
			        strokeColor: "#F33", //线颜色
			        strokeOpacity: 0.2, //线透明度
			        strokeWeight: 2,    //线宽
			        fillColor: "#ee2200", //填充色
			        fillOpacity: 0.25//填充透明度
			    });
			   	polygon.setMap(map);
			   	mapLine();
			   	window.clearTimeout(t3);
			},350);
		}
		
		function mapLine(){
			if(polyline){
				console.log(polyline)
			}else{
				console.log('2')
			}
			var locus = '116.209008,40.102769;116.209999,40.103169;116.210000,40.103669;';
			var locusPoints = new Array();
			var sLocusPoints = locus.split(";");
			for(var i=0; i<sLocusPoints.length-1; i++){
				var arr = [sLocusPoints[i].split(",")[0],sLocusPoints[i].split(",")[1]];
				locusPoints.push(arr);
			}
			var polyline = new AMap.Polyline({
		        path: locusPoints,          //设置线覆盖物路径
		        strokeColor: "#3366FF", //线颜色
		        strokeOpacity: 1,       //线透明度
		        strokeWeight: 2,        //线宽
		        strokeStyle: "solid",   //线样式
		        strokeDasharray: [10, 5] //补充线样式
		    });
			polyline.setMap(map);
		}
	
		/* function paint(location,locus,list){
			var t1 = window.setTimeout(function(){
				var map = new AMap.Map("locus-map",{});

				// 生成地图 
				if(location!=null){
					map.setZoomAndCenter(15,[location.split(";")[0].split(",")[0] ,location.split(";")[0].split(",")[1]]);
					// 绘制练车场  
					var locationPoints = new Array();
					var sLocationPoints = location.split(";");
					for(var i=0; i<sLocationPoints.length-1; i++){
						var arr = [sLocationPoints[i].split(",")[0],sLocationPoints[i].split(",")[1]]
						locationPoints.push(arr);
					}
				   	var polygon = new AMap.Polygon({
				        path: locationPoints,//设置多边形边界路径
				        strokeColor: "#F33", //线颜色
				        strokeOpacity: 0.2, //线透明度
				        strokeWeight: 2,    //线宽
				        fillColor: "#ee2200", //填充色
				        fillOpacity: 0.25//填充透明度
				    });
				    polygon.setMap(map);
				}
				
				
			    
			    // 绘制轨迹 
			    if(locus!=null){
					var locusPoints = new Array();
					var sLocusPoints = locus.split(";");
					for(var i=0; i<sLocusPoints.length-1; i++){
						var arr = [sLocusPoints[i].split(",")[0],sLocusPoints[i].split(",")[1]]
						locusPoints.push(arr);
					}
					var polyline = new AMap.Polyline({
				        path: locusPoints,          //设置线覆盖物路径
				        strokeColor: "#3366FF", //线颜色
				        strokeOpacity: 1,       //线透明度
				        strokeWeight: 5,        //线宽
				        strokeStyle: "solid",   //线样式
				        strokeDasharray: [10, 5] //补充线样式
				    });
					polyline.setMap(map);
				}
				
				if(list!=null){
					var colors=['#FF4500','#FFD700','#FF00FF','#CDC5BF','#B3EE3A','#B23AEE','#4EEE94'];
					for(var i=0;i<list.length;i++){
						var data=list[i];
						var s="";
						for(var i=0;i<data.length;i++){
							var b=data[i].longtitude+","+data[i].latitude+";";
							s+=b;
						}
						var locusPoints = new Array();
						var sLocusPoints = s.split(";");
						for(var i=0; i<sLocusPoints.length-1; i++){
							var arr = [sLocusPoints[i].split(",")[0],sLocusPoints[i].split(",")[1]]
							locusPoints.push(arr);
						}
						var polyline = new AMap.Polyline({
					        path: locusPoints,          //设置线覆盖物路径
					        strokeColor: colors[randValue()], //线颜色
					        strokeOpacity: 0.5,       //线透明度
					        strokeWeight: 5,        //线宽
					        strokeStyle: "solid",   //线样式
					        strokeDasharray: [10, 5] //补充线样式
					    });
						polyline.setMap(map);
					}
					var locu="116.209100,40.102769;116.209500,40.102999;116.209999,40.103200;116.215000,40.104200;"
					
				}
				window.clearTimeout(t1);
			},350);
		} */

//生成1~7的随机数  
/* function randValue() {  
   return (Math.floor(Math.random() * 7) + 1);  
}   */

function add(){
	$("#add").modal('show');
	$("#add input[name='inscode']").val(insCode);
	$("#add input[name='platnum']").val("A0041");
}
function spare(){
	$("#spare").modal('show');
}
function uploadPhoto(){
	$("#uploadPhoto").modal('show');
	var id = sessionStorage.getItem('tabId');
	console.log(id);
	if(id!=null && id != undefined){
		$.get('${ctx}/teachLog/getOne?id='+id,null,function(result){
			$("#uploadPhoto input[name='inscode']").val(result.data.inscode);
			$("#uploadPhoto input[name='stunum']").val(result.data.stunum);
			$("#uploadPhoto input[name='coachnum']").val(result.data.coachnum);
			$("#uploadPhoto input[name='subjcode']").val(result.data.courseCode);
			$("#uploadPhoto input[name='recnum']").val(result.data.etrainingLogCode);
			$("#uploadPhoto input[name='platnum']").val(result.data.devnum);	
			var date = new Date(result.data.starttime);
			var starttime = date.pattern("yyyyMMddHHmmss");
			$("#uploadPhoto input[name='ptime']").val(starttime);
			$("#uploadPhoto input[name='fileurl']").val(result.data.loginPhotoUrl);
		});
		$.get('${ctx}/teachLog/getUploadPhoto?id='+id,null,function(result){
			if(result.code==200 && result.data!=null){
				for(var i=0;i<result.data.length;i++){
					console.log($("#uploadPhoto div[name='fileinfo']")[0].innerHTML);
					$("#uploadPhoto div[name='fileinfo']")[0].innerHTML+="</br> imageUrl: "+result.data[i].imageUrl;
					//$("#uploadPhoto textarea[name='fileinfo']").val($("#uploadPhoto textarea[name='fileinfo']").val()+"</br> imageUrl: "+result.data[i].imageUrl);
				}
			}
		});
	}
}
function uploadVideo(id){
	$("#uploadVideo").modal('show');
	var id = sessionStorage.getItem('tabId');
	if(id!=null && id != undefined){
		$.get('${ctx}/teachLog/getOne?id='+id,null,function(result){
			$("#uploadVideo input[name='devnum']").val(result.data.devnum);
			$("#uploadVideo input[name='inscode']").val(result.data.inscode);
			$("#uploadVideo input[name='stunum']").val(result.data.stunum);
			$("#uploadVideo input[name='coachnum']").val(result.data.coachnum);
			$("#uploadVideo input[name='subjcode']").val(result.data.courseCode);
			$("#uploadVideo input[name='recnum']").val(result.data.etrainingLogCode);
			var date = new Date(result.data.starttime);
			var starttime = date.pattern("yyyyMMddHHmmss");
			date = new Date(result.data.endtime);
			var endtime = date.pattern("yyyyMMddHHmmss");
			$("#uploadVideo input[name='starttime']").val(starttime);
			$("#uploadVideo input[name='endtime']").val(endtime);
			$("#uploadVideo input[name='fileurl']").val(result.data.loginPhotoUrl);
		});
		$.get('${ctx}/teachLog/getUploadVideo?id='+id,null,function(result){
			if(result.code==200 && result.data!=null){
				for(var i=0;i<result.data.length;i++){
					console.log($("#uploadVideo div[name='fileinfo']")[0].innerHTML);
					$("#uploadVideo div[name='fileinfo']")[0].innerHTML+="</br> videoUrl: "+result.data[i].videoURL;
				}
			}
		});
	}
}
$('#addphoto1').uploadify({
	'swf' : 'http://upload.91ygxc.com/resources/swfupload.swf',
	'uploader' : 'http://upload.91ygxc.com/FileUpload',
	'height' : '30',
	'width' : '106',
	'fileTypeExts' : '*.jpg;*.JPG;*.jpeg;*.JPEG;*.png;*.PNG;*.gif;*.GIF',
	'fileObjName' : 'file_upload',
	'onUploadSuccess' : function(file, data, response) {
		var datajson = eval("(" + data + ")");
		$('#add input[name="photo1"]').val(datajson.data.s);
	}
}); 
$('#addphoto2').uploadify({
	'swf' : 'http://upload.91ygxc.com/resources/swfupload.swf',
	'uploader' : 'http://upload.91ygxc.com/FileUpload',
	'height' : '30',
	'width' : '106',
	'fileTypeExts' : '*.jpg;*.JPG;*.jpeg;*.JPEG;*.png;*.PNG;*.gif;*.GIF',
	'fileObjName' : 'file_upload',
	'onUploadSuccess' : function(file, data, response) {
		var datajson = eval("(" + data + ")");
		$('#add input[name="photo2"]').val(datajson.data.s);
	}
}); 
$('#addphoto3').uploadify({
	'swf' : 'http://upload.91ygxc.com/resources/swfupload.swf',
	'uploader' : 'http://upload.91ygxc.com/FileUpload',
	'height' : '30',
	'width' : '106',
	'fileTypeExts' : '*.jpg;*.JPG;*.jpeg;*.JPEG;*.png;*.PNG;*.gif;*.GIF',
	'fileObjName' : 'file_upload',
	'onUploadSuccess' : function(file, data, response) {
		var datajson = eval("(" + data + ")");
		$('#add input[name="photo3"]').val(datajson.data.s);
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
		$('#uploadPhoto input[name="fileurl"]').val(datajson.data.s);
		var fileParam = {
				"type" :'simulation',
				"url" :datajson.data.s,
				"level" :2
			};
		$.post(recordUrl+'/upload/file/url',fileParam,function(results){
			console.log(results);
			if(results.errorcode==0){
				$('#uploadPhoto input[name="fileid"]').val(results.data.id);
			}
		});
		console.log(data);
	}
});
$('#upload_buton_video1').uploadify({
	'swf' : 'http://upload.91ygxc.com/resources/swfupload.swf',
	'uploader' : 'http://upload.91ygxc.com/docUpload',
	'height' : '30',
	'width' : '130',
	'fileTypeExts' : '*.avi;*.AVI;*.mp4;*.MP4;*.3gp;*.3GP;*.flv;*.rmvb;*.FLV;*.RMVB',
	'fileObjName' : 'file_upload',
	'onUploadSuccess' : function(file, data, response) {
		var datajson = eval("(" + data + ")");
		$("#video1").attr('src', datajson.data.url);
		$('#uploadVideo input[name="fileurl"]').val(datajson.data.url);
		var fileParam = {
				"type" :'video',
				"url" :datajson.data.url,
				"level" :2
			};
		$.post(recordUrl+'/upload/file/url',fileParam,function(results){
			console.log(results);
			if(results.errorcode==0){
				$('#uploadVideo input[name="fileid"]').val(results.data.id);
			}
		});
		console.log(data);
	}
});
	
	//批量通过教学日志
	function batchPassTeachLog(ids,pass,reason){
		$.ajax({
			url : '${ctx}/teachLog/passTeachLog',
			data : {
				recordIds : ids,
				pass : pass,
				reason : reason
			},
			type : 'post',
			success : function (result){
				if(result.code==200){
					layer.alert('保存成功');
					buildDataTable();
				}else{
					layer.alert(result.message);
					return false;
				}
			}
		});
	}
</script>
</body>
</html>