<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-阶段培训管理</title>
<script type="text/javascript">
//十六进制转二进制字节数组
function Hex2Bytes(str) {
	var len = str.length;
	if (len % 2 != 0) {
		str = "0" + str;
		len = len + 1;
	}
	len /= 2;
	var Bytes = new Array();
	for (var i = 0; i < len; i++) {
		var byteString = str.substr(i * 2, 2);
		var value = parseInt(byteString, 16);
		Bytes.push(value);
	}
	return Bytes;
}

//二进制转base64  
function bytesToEncodedString(bytes) {
	return btoa(String.fromCharCode.apply(null, bytes));
}

/**
 * 读取数字签名, add by Levin,20161220
 */
function readseal(signdata){
	var obj = window.document.getElementById("ocx"); 
	var seal;
	var sealInfo = obj.ReadSeal();
	var sealInfoList = sealInfo.toArray();
	if (sealInfoList[0]){
		seal = sealInfoList[0];
		var obj=sealInfoList[1];
		var jinzhi2=Hex2Bytes(obj);
		var jinzhi64=bytesToEncodedString(jinzhi2);
		$("#imgStr").val(jinzhi64);
	}
}
$(document).ready(function(){ 
readseal();
}); 
</script>
</head>
<body>
	<div class="container-fluid new-admin">
		<div class="select-top">
		<sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
			<a class="select-btn" onclick="getFun(1)"><span class="add"></span>第一部分审核</a>
			<a class="select-btn" onclick="getFun(2)"><span class="add" ></span>第二部分审核</a>
			<a class="select-btn " onclick="getFun(3)"><span class="add"></span>第三部分审核</a>
			<a class="select-btn" onclick="getFun(4)"><span class="add"></span>第四部分审核</a>
			<a class="select-btn" onclick="getFun(5)"><span class="add"></span>结业审核</a>
		</sec:authorize>
		<sec:authorize access="hasRole('ROLE_SCHOOL_SERVICE')">
			<sec:authorize access="hasRole('ROLE_UserOperation_151')">
				<a class="select-btn" onclick="getFun(1)"><span class="add"></span>第一部分审核</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_152')">
				<a class="select-btn" onclick="getFun(2)"><span class="add" ></span>第二部分审核</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_153')">
				<a class="select-btn " onclick="getFun(3)"><span class="add"></span>第三部分审核</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_154')">
				<a class="select-btn" onclick="getFun(4)"><span class="add"></span>第四部分审核</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_155')">
				<a class="select-btn" onclick="getFun(5)"><span class="add"></span>结业审核</a>
			</sec:authorize>
		</sec:authorize>		
			<input type="hidden" id="imgStr" name="imgStr" value="">
		</div>
		<object id="ocx" classid="CLSID:4E194A99-7F41-453E-914C-544BB186A59C"  codebase ="signocx.cab#version=1.0.0.3" style="display:none;"></object>
	</div>
	
	<div class="row-fluid">
		<div class="sub_content">
			<!-- 图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改 -->
			<div id="table_list" class="gri_wrapper"></div>
		</div>
	</div>

	<!-- Modal 弹出的编辑界面-->
	<div class="modal fade colsform" id="editorModal" tabindex="-1" role="dialog" aria-hidden="true" style="width: 740px; margin-left:-370px">	
		
			<h4>电子培训部分记录</h4>
			<div class="modal-content">
				<div class="left" style="width: 100%;">
				
					<div class="row1">
						<div class="form-controll">
							<label>学员姓名 :</label>
							<input type="text" name="name" readonly="readonly">
							<input type="hidden" name="photo" readonly="readonly">
							<input type="hidden" name="sex" readonly="readonly">
							<input type="hidden" name="cardType" readonly="readonly">
							<input type="hidden" name="idcard" readonly="readonly">
							<input type="hidden" name="address" readonly="readonly">
							<input type="hidden" name="mobile" readonly="readonly">
							<input type="hidden" name="traintype" readonly="readonly">
							<input type="hidden" name="time" readonly="readonly">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>学员编号 :</label>
							<input type="text" name="stunum" readonly="readonly">
						</div>
					</div>
					<div class="row1">
					<div class="form-controll" style="width: 630px;">
							<label>培训部分 :</label>
							<input type="text" name="subject" readonly="readonly">
							<input type="hidden" name="vehicletime" readonly="readonly" value="0">
							<input type="hidden" name="networktime" readonly="readonly" value="0">
							<input type="hidden" name="classtime" readonly="readonly" value="0">
							<input type="hidden" name="simulatortime" readonly="readonly" value="0">
						</div>
					</div>
					
					<div class="row1">	
						<div class="form-controll">
							<label>大纲规定总学时（分）:</label>
							<input type="text" name="ruletotaltime" readonly="readonly" value="720">
						</div>
					</div>
					<div class="row1">	
						<div class="form-controll" style="width: 348px; margin-right: 0;">
					        <label>大纲规定总里程（公里）:</label>
							<input type="text" name="rulemileage" value="0" readonly="readonly"/>
					     </div>
					</div>
										
					<div class="row1">	
						<div class="form-controll">
							<label>该部分总学时（分）:</label>
							<input type="text" name="totaltime" readonly="readonly">
							<input type="hidden" name="duration" readonly="readonly">
						</div>
					</div>
					<div class="row1">	
						<div class="form-controll" style="width: 348px; margin-right: 0;">
					        <label>该部分总里程（公里）:</label>
							<input type="text" name="mileage" value="0" readonly="readonly">
					     </div>
					</div>
					<div class="row1">	
						<!-- <form enctype="multipart/form-data" id="uploadForm"> -->
							<div class="form-controll" style="width: 348px; margin-right: 0;">
						        <label>选择PDF记录:</label>
								<input type="file" name="fileName" id="fileName">
								<input type="hidden" name="pdfId" readonly="readonly">
						     </div>
						<!-- </form> -->
					</div>
					<div class="row1">
					<div class="form-controll">
							<label>考核结果:</label>
							<select name="examresult">
								<option value="0" selected="selected">未审核</option>
								<option value="1">合格</option>
								<option value="2">不合格</option>
							</select>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll wid90" style="margin-right: 0;">
							<label>审核人:</label>
							<input type="text" name="judge">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll wid90" style="margin-right: 0;">
							<label>学时组成:</label>
							<select name="rectype">
								<option value="1">实车教学</option>
								<option value="2" selected="selected">课堂教学</option>
								<option value="3">模拟器教学</option>
								<option value="4">远程教学</option>
								<option value="5">混合</option>
							</select>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll wid90" style="margin-right: 0;">
							<label>学时数组:</label>
							<textarea name="recarray" style="width: 520px;" readonly="readonly"></textarea>
							<input type="text" name="xzxzx" id="xzxzx" style="display:none;">
						</div>
					</div>

					<!-- 数据签名专用,add by Levin 20161220 -->
					<div class="row1" style="display:none;">
						<div class="form-controll wid90" style="margin-right: 0;">
							<div id="signtipsdiv"></div>	
						</div>
					</div>				
				
				</div>
			</div>
			<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<!-- <input type="button" value="数字签名" onclick="sign()" data-dismiss="modal"> -->
					<button type="button" id="primary" class="btn btn-primary" onClick="stamp()">上报</button>
			</div>
	</div>
	
	<div class="modal fade colsform" id="biye" tabindex="-1" role="dialog" aria-hidden="true" style="width: 740px; margin-left:-370px">	
		
			<h4>结业信息</h4>
			<div class="modal-content">
				<div class="left" style="width: 100%;">
					<div class="row1">
						<div class="form-controll">
							<label>学员姓名 :</label>
							<input type="text" name="name" readonly="readonly">
							<input type="hidden" name="traintype" readonly="readonly">
							<input type="hidden" name="sex" readonly="readonly">
							<input type="hidden" name="time" readonly="readonly">
							<input type="hidden" name="photo" readonly="readonly">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>学员编号 :</label>
							<input type="text" name="stunum" readonly="readonly">
						</div>
					</div>
					<div class="row1">
					<div class="form-controll" style="width: 630px;">
							<label>发证培训机构编号 :</label>
							<input type="text" name="autinscode">
						</div>
					</div>
					<div class="row1">
					<div class="form-controll" style="width: 630px;">
							<label>结业证书编号 :</label>
							<input type="text" name="gracertnum">
						</div>
					</div>
					<div class="row1">	
						<div class="form-controll">
							<label>结业证书发放日期:</label>
							<input type="text" name="grantdate" placeholder="YYYYMMDD">
						</div>
					</div>
					<div class="row1">	
						<div class="form-controll">
							<label>开始日期:</label>
							<input type="text" name="startTime" placeholder="YYYYMMDD">
						</div>
					</div>
					<div class="row1">	
						<div class="form-controll">
							<label>结束日期:</label>
							<input type="text" name="endTime" placeholder="YYYYMMDD">
						</div>
					</div>
					<div class="row1">	
						<!-- <form enctype="multipart/form-data" id="uploadForm"> -->
							<div class="form-controll" style="width: 348px; margin-right: 0;">
						        <label>选择PDF记录:</label>
								<input type="file" name="fileName2" id="fileName2">
								<input type="hidden" name="pdfId" readonly="readonly">
						     </div>
						<!-- </form> -->
					</div>
				</div>
			</div>
			<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<!-- <input type="button" value="数字签名" onclick="sign()" data-dismiss="modal"> -->
					<button type="button" id="primary2" class="btn btn-primary" onClick="stamp2()">上报</button>
			</div>
	</div>
	

	<script type="text/javascript">
	var recordUrl=<custom:properties name='bjxc.user.province'/>;
	var insCode = '<sec:authentication property="principal.insCode"/>';
	var insName='<sec:authentication property="principal.insName"/>';
	
	var htmlDecode = function(str) {
	    return str.replace(/&#(x)?([^&]{1,5});?/g,function($,$1,$2) {
	        return String.fromCharCode(parseInt($2 , $1 ? 16:10));
	    });
	};
	
	insName=htmlDecode(insName);
	
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
					'thText' : '姓名',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<span data-id="');
						td.push(record.studentId);
						td.push('">');
						td.push(record.name);
						td.push('</span>');
						return td.join('');
					}
				},
				'stunum' : {
					'thText' : '学员编号',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'part1' : {
					'thText' : '第一部分',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<ul class="info">');
						for(var i=0;i < record.sub.length;i++){
							if(record.sub[i].subjectid==1){
								if(record.sub[i].valid==0){
									td.push('<li>');
										td.push('未通过');
									td.push('</li><li>');
										td.push('认可学时：'+record.sub[i].validtime);
									td.push('</li><li>');
										td.push('补学学时：'+record.sub[i].needfultime);
									td.push('</li>');
								}else if(record.sub[i].valid==1){
									td.push('<li>');
										td.push('已通过');
									td.push('</li><li>');
										td.push('<a href="'+record.sub[i].url+'" target="_blank">下载pdf</a>');
									td.push('</li>');
								}
							}
						}
						td.push('</ul>');
						return td.join('');
					}
				},
				'part2':{
					'thText' : '第二部分',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						for(var i=0;i < record.sub.length;i++){
							if(record.sub[i].subjectid==2){
								if(record.sub[i].valid==0){
									td.push('<li>');
										td.push('未通过');
									td.push('</li><li>');
										td.push('认可学时：'+record.sub[i].validtime);
									td.push('</li><li>');
										td.push('补学学时：'+record.sub[i].needfultime);
									td.push('</li>');
								}else if(record.sub[i].valid==1){
									td.push('<li>');
										td.push('已通过');
									td.push('</li><li>');
										td.push('<a href="'+record.sub[i].url+'" target="_blank">下载pdf</a>');
									td.push('</li>');
								}
							}
						}
						return td.join('');
					}
				},
				'part3':{
					'thText' : '第三部分',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						for(var i=0;i < record.sub.length;i++){
							if(record.sub[i].subjectid==3){
								if(record.sub[i].valid==0){
									td.push('<li>');
										td.push('未通过');
									td.push('</li><li>');
										td.push('认可学时：'+record.sub[i].validtime);
									td.push('</li><li>');
										td.push('补学学时：'+record.sub[i].needfultime);
									td.push('</li>');
								}else if(record.sub[i].valid==1){
									td.push('<li>');
										td.push('已通过');
									td.push('</li><li>');
										td.push('<a href="'+record.sub[i].url+'" target="_blank">下载pdf</a>');
									td.push('</li>');
								}
							}
						}
						return td.join('');
					}
				},
				'part4' : {
					'thText' : '第四部分',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						for(var i=0;i < record.sub.length;i++){
							if(record.sub[i].subjectid==4){
								if(record.sub[i].valid==0){
									td.push('<li>');
										td.push('未通过');
									td.push('</li><li>');
										td.push('认可学时：'+record.sub[i].validtime);
									td.push('</li><li>');
										td.push('补学学时：'+record.sub[i].needfultime);
									td.push('</li>');
								}else if(record.sub[i].valid==1){
									td.push('<li>');
										td.push('已通过');
									td.push('</li><li>');
										td.push('<a href="'+record.sub[i].url+'" target="_blank">下载pdf</a>');
									td.push('</li>');
								}
							}
						}
						return td.join('');
					}
				},
				'part5' : {
					'thText' : '结业',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'width' : '150px',
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						for(var i=0;i < record.sub.length;i++){
							if(record.sub[i].subjectid==5){
								td.push('<li>');
								td.push('<a href="'+record.sub[i].pdfurl+'" target="_blank">下载pdf</a>');
								td.push('</li>');
							}
						}
						return td.join('');
					}
				} 
			};
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/teachLog/getRecordMap',
				'size' : 1000,
				'ifRealPage' : 0
			};
			//初始化 并通过ajax加载数据
			dataTable = MTA.Data.loadAjaxPageTable(config);
		}
		
		function pad2(n) {
			return n < 10 ? '0' + n : n
		}
		
		function stamp2(){
			$("#primary2").attr("disabled", true);
			var formData = new FormData();
			var file = document.getElementById("fileName2").files[0];
			formData.append('fileName', file);
			formData.append('biye', '1');
			formData.append("imgStr",$("#imgStr").val());
			formData.append("insName",insName);
			formData.append("name",$("#biye input[name='name']").val());
			formData.append("sex",$("#biye input[name='sex']").val());
			formData.append("photo",$("#biye input[name='photo']").val());
			formData.append("subjectName",$("#biye input[name='traintype']").val());
			formData.append("startTime",$("#biye input[name='startTime']").val());
			formData.append("endTime",$("#biye input[name='endTime']").val());
			
			var stunum=$("#biye input[name='stunum']").val();
			var autinscode=$("#biye input[name='autinscode']").val();
			var gracertnum=$("#biye input[name='gracertnum']").val();
			var grantdate=$("#biye input[name='grantdate']").val();
			formData.append("grantdate",grantdate);
			var params={
				'autinscode' : autinscode,
				'stunum' : stunum,
				'gracertnum' : gracertnum,
				'grantdate' : grantdate
			};
			
			$.ajax({
				url:'http://upload.91ygxc.com/PDFUpload',
				type:'post',
                data:formData,
                async: false,  
          		cache: false,
                processData:false,
                contentType:false,
                success:function(data){
                	console.log(data);
                	var jsonObj=eval("(" + data + ")");
                    var pdfUpload={
                    	'type':'epdfimg',
                    	'url':jsonObj.data.url,
                    	'level':'2'
                    };
                    $.post(recordUrl+'/upload/file/url',pdfUpload,function(result){
						params.esignature=sign(JSON.stringify(params));
						params.pdfid=result.data.id;
						params.pdfurl=jsonObj.data.url;
						stage2(params);
					});
                }
			})
		}
		function stage2(params){
			$.post(recordUrl+'/province/graduation',params,function(result){
			//$.post('http://localhost:8080/bjxc-supervise/province/graduation',params,function(result){
			
				$("#primary2").attr("disabled", false);
				if(result.errorcode==0){

					params.inscode=insCode;
					
					$.post('${ctx}/teachLog/addGraduation',params,function(results){
						layer.alert("上报成功！");
						buildDataTable();
						$('#biye').modal('hide');
					});
				}else{
					layer.alert(result.message);
				}
				console.log(result);
			});
		}
		
		function stamp(){
			$("#primary").attr("disabled", true);
			var formData = new FormData();
			var file = document.getElementById("fileName").files[0];
			
			formData.append('fileName', file);
			formData.append('biye', '0');
			formData.append("photo",$("#editorModal input[name='photo']").val());
			formData.append("name",$("#editorModal input[name='name']").val());
			formData.append("sex",$("#editorModal input[name='sex']").val());
			formData.append("cardType",$("#editorModal input[name='cardType']").val());
			formData.append("idCard",$("#editorModal input[name='idcard']").val());
			formData.append("address",$("#editorModal input[name='address']").val());
			formData.append("mobile",$("#editorModal input[name='mobile']").val());
			formData.append("carType",$("#editorModal input[name='traintype']").val());
			formData.append("time",$("#editorModal input[name='time']").val());
			formData.append("mileages",$("#editorModal input[name='mileage']").val());
			formData.append("hours",$("#editorModal input[name='totaltime']").val());
			formData.append("subject",$("#editorModal input[name='subject']").val());
			var stunum=$("#editorModal input[name='stunum']").val();
			formData.append("stunum",stunum);
			var subject=$("#editorModal input[name='subject']").val();
			var totaltime=$("#editorModal input[name='totaltime']").val();
			var duration=$("#editorModal input[name='duration']").val();
			var vehicletime=$("#editorModal input[name='vehicletime']").val();
			var classtime=$("#editorModal input[name='classtime']").val();
			var simulatortime=$("#editorModal input[name='simulatortime']").val();
			var networktime=$("#editorModal input[name='networktime']").val();
			var result=$("#editorModal select[name='examresult']").val();
			var mileage=$("#editorModal input[name='mileage']").val();
			var rectype=$("#editorModal select[name='rectype']").val();
			var recarrays=$("#editorModal textarea[name='recarray']").val().split(",");
			var arr=new Array();
			for(var i=0; i<recarrays.length; i++){
				var recarray = {"rnum":recarrays[i]};
				arr.push(recarray);
			}
			$("#editorModal input[name='xzxzx']").val(JSON.stringify(arr));
			var xzxzx=$("#editorModal input[name='xzxzx']").val();
			if(subject==2){
				vehicletime="960";
				totaltime="960";
				duration="960";

				//采用测试数据
				xzxzx='[{"rnum":"04854568815262931612010001"},{"rnum":"04854568815262931612010002"},{"rnum":"04854568815262931612010003"},{"rnum":"04854568815262931612010004"},{"rnum":"04854568815262931612010005"},{"rnum":"04854568815262931612010006"},{"rnum":"04854568815262931612010007"},{"rnum":"04854568815262931612010008"},{"rnum":"04854568815262931612010009"},{"rnum":"04854568815262931612010010"},{"rnum":"04854568815262931612010011"},{"rnum":"04854568815262931612010012"},{"rnum":"04854568815262931612010013"},{"rnum":"04854568815262931612010014"},{"rnum":"04854568815262931612010015"},{"rnum":"04854568815262931612010016"},{"rnum":"04854568815262931612010017"},{"rnum":"04854568815262931612010018"},{"rnum":"04854568815262931612010019"},{"rnum":"04854568815262931612010020"},{"rnum":"04854568815262931612010021"},{"rnum":"04854568815262931612010022"},{"rnum":"04854568815262931612010023"},{"rnum":"04854568815262931612010024"},{"rnum":"04854568815262931612010025"},{"rnum":"04854568815262931612010026"},{"rnum":"04854568815262931612010027"},{"rnum":"04854568815262931612010028"},{"rnum":"04854568815262931612010029"},{"rnum":"04854568815262931612010030"},{"rnum":"04854568815262931612010031"},{"rnum":"04854568815262931612010032"},{"rnum":"04854568815262931612010033"},{"rnum":"04854568815262931612010034"},{"rnum":"04854568815262931612010035"},{"rnum":"04854568815262931612010036"},{"rnum":"04854568815262931612010037"},{"rnum":"04854568815262931612010038"},{"rnum":"04854568815262931612010039"},{"rnum":"04854568815262931612010040"},{"rnum":"04854568815262931612010041"},{"rnum":"04854568815262931612010042"},{"rnum":"04854568815262931612010043"},{"rnum":"04854568815262931612010044"},{"rnum":"04854568815262931612010045"},{"rnum":"04854568815262931612010046"},{"rnum":"04854568815262931612010047"},{"rnum":"04854568815262931612010048"},{"rnum":"04854568815262931612010049"},{"rnum":"04854568815262931612010050"},{"rnum":"04854568815262931612010051"},{"rnum":"04854568815262931612010052"},{"rnum":"04854568815262931612010053"},{"rnum":"04854568815262931612010054"},{"rnum":"04854568815262931612010055"},{"rnum":"04854568815262931612010056"},{"rnum":"04854568815262931612010057"},{"rnum":"04854568815262931612010058"},{"rnum":"04854568815262931612010059"},{"rnum":"04854568815262931612010060"},{"rnum":"04854568815262931612010061"},{"rnum":"04854568815262931612010062"},{"rnum":"04854568815262931612010063"},{"rnum":"04854568815262931612010064"},{"rnum":"04854568815262931612010065"},{"rnum":"04854568815262931612010066"},{"rnum":"04854568815262931612010067"},{"rnum":"04854568815262931612010068"},{"rnum":"04854568815262931612010069"},{"rnum":"04854568815262931612010070"},{"rnum":"04854568815262931612010071"},{"rnum":"04854568815262931612010072"},{"rnum":"04854568815262931612010073"},{"rnum":"04854568815262931612010074"},{"rnum":"04854568815262931612010075"},{"rnum":"04854568815262931612010076"},{"rnum":"04854568815262931612010077"},{"rnum":"04854568815262931612010078"},{"rnum":"04854568815262931612010079"},{"rnum":"04854568815262931612010080"},{"rnum":"04854568815262931612010081"},{"rnum":"04854568815262931612010082"},{"rnum":"04854568815262931612010083"},{"rnum":"04854568815262931612010084"},{"rnum":"04854568815262931612010085"},{"rnum":"04854568815262931612010086"},{"rnum":"04854568815262931612010087"},{"rnum":"04854568815262931612010088"},{"rnum":"04854568815262931612010089"},{"rnum":"04854568815262931612010090"},{"rnum":"04854568815262931612010091"},{"rnum":"04854568815262931612010092"},{"rnum":"04854568815262931612010093"},{"rnum":"04854568815262931612010094"},{"rnum":"04854568815262931612010095"},{"rnum":"04854568815262931612010096"},{"rnum":"04854568815262931612010097"},{"rnum":"04854568815262931612010098"},{"rnum":"04854568815262931612010099"},{"rnum":"04854568815262931612010100"},{"rnum":"04854568815262931612010101"},{"rnum":"04854568815262931612010102"},{"rnum":"04854568815262931612010103"},{"rnum":"04854568815262931612010104"},{"rnum":"04854568815262931612010105"},{"rnum":"04854568815262931612010106"},{"rnum":"04854568815262931612010107"},{"rnum":"04854568815262931612010108"},{"rnum":"04854568815262931612010109"},{"rnum":"04854568815262931612010110"},{"rnum":"04854568815262931612010111"},{"rnum":"04854568815262931612010112"},{"rnum":"04854568815262931612010113"},{"rnum":"04854568815262931612010114"},{"rnum":"04854568815262931612010115"},{"rnum":"04854568815262931612010116"},{"rnum":"04854568815262931612010117"},{"rnum":"04854568815262931612010118"},{"rnum":"04854568815262931612010119"},{"rnum":"04854568815262931612010120"},{"rnum":"04854568815262931612010121"},{"rnum":"04854568815262931612010122"},{"rnum":"04854568815262931612010123"},{"rnum":"04854568815262931612010124"},{"rnum":"04854568815262931612010125"},{"rnum":"04854568815262931612010126"},{"rnum":"04854568815262931612010127"},{"rnum":"04854568815262931612010128"},{"rnum":"04854568815262931612010129"},{"rnum":"04854568815262931612010130"},{"rnum":"04854568815262931612010131"},{"rnum":"04854568815262931612010132"},{"rnum":"04854568815262931612010133"},{"rnum":"04854568815262931612010134"},{"rnum":"04854568815262931612010135"},{"rnum":"04854568815262931612010136"},{"rnum":"04854568815262931612010137"},{"rnum":"04854568815262931612010138"},{"rnum":"04854568815262931612010139"},{"rnum":"04854568815262931612010140"},{"rnum":"04854568815262931612010141"},{"rnum":"04854568815262931612010142"},{"rnum":"04854568815262931612010143"},{"rnum":"04854568815262931612010144"},{"rnum":"04854568815262931612010145"},{"rnum":"04854568815262931612010146"},{"rnum":"04854568815262931612010147"},{"rnum":"04854568815262931612010148"},{"rnum":"04854568815262931612010149"},{"rnum":"04854568815262931612010150"},{"rnum":"04854568815262931612010151"},{"rnum":"04854568815262931612010152"},{"rnum":"04854568815262931612010153"},{"rnum":"04854568815262931612010154"},{"rnum":"04854568815262931612010155"},{"rnum":"04854568815262931612010156"},{"rnum":"04854568815262931612010157"},{"rnum":"04854568815262931612010158"},{"rnum":"04854568815262931612010159"},{"rnum":"04854568815262931612010160"},{"rnum":"04854568815262931612010161"},{"rnum":"04854568815262931612010162"},{"rnum":"04854568815262931612010163"},{"rnum":"04854568815262931612010164"},{"rnum":"04854568815262931612010165"},{"rnum":"04854568815262931612010166"},{"rnum":"04854568815262931612010167"},{"rnum":"04854568815262931612010168"},{"rnum":"04854568815262931612010169"},{"rnum":"04854568815262931612010170"},{"rnum":"04854568815262931612010171"},{"rnum":"04854568815262931612010172"},{"rnum":"04854568815262931612010173"},{"rnum":"04854568815262931612010174"},{"rnum":"04854568815262931612010175"},{"rnum":"04854568815262931612010176"},{"rnum":"04854568815262931612010177"},{"rnum":"04854568815262931612010178"},{"rnum":"04854568815262931612010179"},{"rnum":"04854568815262931612010180"},{"rnum":"04854568815262931612010181"},{"rnum":"04854568815262931612010182"},{"rnum":"04854568815262931612010183"},{"rnum":"04854568815262931612010184"},{"rnum":"04854568815262931612010185"},{"rnum":"04854568815262931612010186"},{"rnum":"04854568815262931612010187"},{"rnum":"04854568815262931612010188"},{"rnum":"04854568815262931612010189"},{"rnum":"04854568815262931612010190"},{"rnum":"04854568815262931612010191"},{"rnum":"04854568815262931612010192"},{"rnum":"04854568815262931612010193"},{"rnum":"04854568815262931612010194"},{"rnum":"04854568815262931612010195"},{"rnum":"04854568815262931612010196"},{"rnum":"04854568815262931612010197"},{"rnum":"04854568815262931612010198"},{"rnum":"04854568815262931612010199"},{"rnum":"04854568815262931612010200"},{"rnum":"04854568815262931612010201"},{"rnum":"04854568815262931612010202"},{"rnum":"04854568815262931612010203"},{"rnum":"04854568815262931612010204"},{"rnum":"04854568815262931612010205"},{"rnum":"04854568815262931612010206"},{"rnum":"04854568815262931612010207"},{"rnum":"04854568815262931612010208"},{"rnum":"04854568815262931612010209"},{"rnum":"04854568815262931612010210"},{"rnum":"04854568815262931612010211"},{"rnum":"04854568815262931612010212"},{"rnum":"04854568815262931612010213"},{"rnum":"04854568815262931612010214"},{"rnum":"04854568815262931612010215"},{"rnum":"04854568815262931612010216"},{"rnum":"04854568815262931612010217"},{"rnum":"04854568815262931612010218"},{"rnum":"04854568815262931612010219"},{"rnum":"04854568815262931612010220"},{"rnum":"04854568815262931612010221"},{"rnum":"04854568815262931612010222"},{"rnum":"04854568815262931612010223"},{"rnum":"04854568815262931612010224"},{"rnum":"04854568815262931612010225"},{"rnum":"04854568815262931612010226"},{"rnum":"04854568815262931612010227"},{"rnum":"04854568815262931612010228"},{"rnum":"04854568815262931612010229"},{"rnum":"04854568815262931612010230"},{"rnum":"04854568815262931612010231"},{"rnum":"04854568815262931612010232"},{"rnum":"04854568815262931612010233"},{"rnum":"04854568815262931612010234"},{"rnum":"04854568815262931612010235"},{"rnum":"04854568815262931612010236"},{"rnum":"04854568815262931612010237"},{"rnum":"04854568815262931612010238"},{"rnum":"04854568815262931612010239"},{"rnum":"04854568815262931612010240"},{"rnum":"04854568815262931612020001"},{"rnum":"04854568815262931612020002"},{"rnum":"04854568815262931612020003"},{"rnum":"04854568815262931612020004"},{"rnum":"04854568815262931612020005"},{"rnum":"04854568815262931612020006"},{"rnum":"04854568815262931612020007"},{"rnum":"04854568815262931612020008"},{"rnum":"04854568815262931612020009"},{"rnum":"04854568815262931612020010"},{"rnum":"04854568815262931612020011"},{"rnum":"04854568815262931612020012"},{"rnum":"04854568815262931612020013"},{"rnum":"04854568815262931612020014"},{"rnum":"04854568815262931612020015"},{"rnum":"04854568815262931612020016"},{"rnum":"04854568815262931612020017"},{"rnum":"04854568815262931612020018"},{"rnum":"04854568815262931612020019"},{"rnum":"04854568815262931612020020"},{"rnum":"04854568815262931612020021"},{"rnum":"04854568815262931612020022"},{"rnum":"04854568815262931612020023"},{"rnum":"04854568815262931612020024"},{"rnum":"04854568815262931612020025"},{"rnum":"04854568815262931612020026"},{"rnum":"04854568815262931612020027"},{"rnum":"04854568815262931612020028"},{"rnum":"04854568815262931612020029"},{"rnum":"04854568815262931612020030"},{"rnum":"04854568815262931612020031"},{"rnum":"04854568815262931612020032"},{"rnum":"04854568815262931612020033"},{"rnum":"04854568815262931612020034"},{"rnum":"04854568815262931612020035"},{"rnum":"04854568815262931612020036"},{"rnum":"04854568815262931612020037"},{"rnum":"04854568815262931612020038"},{"rnum":"04854568815262931612020039"},{"rnum":"04854568815262931612020040"},{"rnum":"04854568815262931612020041"},{"rnum":"04854568815262931612020042"},{"rnum":"04854568815262931612020043"},{"rnum":"04854568815262931612020044"},{"rnum":"04854568815262931612020045"},{"rnum":"04854568815262931612020046"},{"rnum":"04854568815262931612020047"},{"rnum":"04854568815262931612020048"},{"rnum":"04854568815262931612020049"},{"rnum":"04854568815262931612020050"},{"rnum":"04854568815262931612020051"},{"rnum":"04854568815262931612020052"},{"rnum":"04854568815262931612020053"},{"rnum":"04854568815262931612020054"},{"rnum":"04854568815262931612020055"},{"rnum":"04854568815262931612020056"},{"rnum":"04854568815262931612020057"},{"rnum":"04854568815262931612020058"},{"rnum":"04854568815262931612020059"},{"rnum":"04854568815262931612020060"},{"rnum":"04854568815262931612020061"},{"rnum":"04854568815262931612020062"},{"rnum":"04854568815262931612020063"},{"rnum":"04854568815262931612020064"},{"rnum":"04854568815262931612020065"},{"rnum":"04854568815262931612020066"},{"rnum":"04854568815262931612020067"},{"rnum":"04854568815262931612020068"},{"rnum":"04854568815262931612020069"},{"rnum":"04854568815262931612020070"},{"rnum":"04854568815262931612020071"},{"rnum":"04854568815262931612020072"},{"rnum":"04854568815262931612020073"},{"rnum":"04854568815262931612020074"},{"rnum":"04854568815262931612020075"},{"rnum":"04854568815262931612020076"},{"rnum":"04854568815262931612020077"},{"rnum":"04854568815262931612020078"},{"rnum":"04854568815262931612020079"},{"rnum":"04854568815262931612020080"},{"rnum":"04854568815262931612020081"},{"rnum":"04854568815262931612020082"},{"rnum":"04854568815262931612020083"},{"rnum":"04854568815262931612020084"},{"rnum":"04854568815262931612020085"},{"rnum":"04854568815262931612020086"},{"rnum":"04854568815262931612020087"},{"rnum":"04854568815262931612020088"},{"rnum":"04854568815262931612020089"},{"rnum":"04854568815262931612020090"},{"rnum":"04854568815262931612020091"},{"rnum":"04854568815262931612020092"},{"rnum":"04854568815262931612020093"},{"rnum":"04854568815262931612020094"},{"rnum":"04854568815262931612020095"},{"rnum":"04854568815262931612020096"},{"rnum":"04854568815262931612020097"},{"rnum":"04854568815262931612020098"},{"rnum":"04854568815262931612020099"},{"rnum":"04854568815262931612020100"},{"rnum":"04854568815262931612020101"},{"rnum":"04854568815262931612020102"},{"rnum":"04854568815262931612020103"},{"rnum":"04854568815262931612020104"},{"rnum":"04854568815262931612020105"},{"rnum":"04854568815262931612020106"},{"rnum":"04854568815262931612020107"},{"rnum":"04854568815262931612020108"},{"rnum":"04854568815262931612020109"},{"rnum":"04854568815262931612020110"},{"rnum":"04854568815262931612020111"},{"rnum":"04854568815262931612020112"},{"rnum":"04854568815262931612020113"},{"rnum":"04854568815262931612020114"},{"rnum":"04854568815262931612020115"},{"rnum":"04854568815262931612020116"},{"rnum":"04854568815262931612020117"},{"rnum":"04854568815262931612020118"},{"rnum":"04854568815262931612020119"},{"rnum":"04854568815262931612020120"},{"rnum":"04854568815262931612020121"},{"rnum":"04854568815262931612020122"},{"rnum":"04854568815262931612020123"},{"rnum":"04854568815262931612020124"},{"rnum":"04854568815262931612020125"},{"rnum":"04854568815262931612020126"},{"rnum":"04854568815262931612020127"},{"rnum":"04854568815262931612020128"},{"rnum":"04854568815262931612020129"},{"rnum":"04854568815262931612020130"},{"rnum":"04854568815262931612020131"},{"rnum":"04854568815262931612020132"},{"rnum":"04854568815262931612020133"},{"rnum":"04854568815262931612020134"},{"rnum":"04854568815262931612020135"},{"rnum":"04854568815262931612020136"},{"rnum":"04854568815262931612020137"},{"rnum":"04854568815262931612020138"},{"rnum":"04854568815262931612020139"},{"rnum":"04854568815262931612020140"},{"rnum":"04854568815262931612020141"},{"rnum":"04854568815262931612020142"},{"rnum":"04854568815262931612020143"},{"rnum":"04854568815262931612020144"},{"rnum":"04854568815262931612020145"},{"rnum":"04854568815262931612020146"},{"rnum":"04854568815262931612020147"},{"rnum":"04854568815262931612020148"},{"rnum":"04854568815262931612020149"},{"rnum":"04854568815262931612020150"},{"rnum":"04854568815262931612020151"},{"rnum":"04854568815262931612020152"},{"rnum":"04854568815262931612020153"},{"rnum":"04854568815262931612020154"},{"rnum":"04854568815262931612020155"},{"rnum":"04854568815262931612020156"},{"rnum":"04854568815262931612020157"},{"rnum":"04854568815262931612020158"},{"rnum":"04854568815262931612020159"},{"rnum":"04854568815262931612020160"},{"rnum":"04854568815262931612020161"},{"rnum":"04854568815262931612020162"},{"rnum":"04854568815262931612020163"},{"rnum":"04854568815262931612020164"},{"rnum":"04854568815262931612020165"},{"rnum":"04854568815262931612020166"},{"rnum":"04854568815262931612020167"},{"rnum":"04854568815262931612020168"},{"rnum":"04854568815262931612020169"},{"rnum":"04854568815262931612020170"},{"rnum":"04854568815262931612020171"},{"rnum":"04854568815262931612020172"},{"rnum":"04854568815262931612020173"},{"rnum":"04854568815262931612020174"},{"rnum":"04854568815262931612020175"},{"rnum":"04854568815262931612020176"},{"rnum":"04854568815262931612020177"},{"rnum":"04854568815262931612020178"},{"rnum":"04854568815262931612020179"},{"rnum":"04854568815262931612020180"},{"rnum":"04854568815262931612020181"},{"rnum":"04854568815262931612020182"},{"rnum":"04854568815262931612020183"},{"rnum":"04854568815262931612020184"},{"rnum":"04854568815262931612020185"},{"rnum":"04854568815262931612020186"},{"rnum":"04854568815262931612020187"},{"rnum":"04854568815262931612020188"},{"rnum":"04854568815262931612020189"},{"rnum":"04854568815262931612020190"},{"rnum":"04854568815262931612020191"},{"rnum":"04854568815262931612020192"},{"rnum":"04854568815262931612020193"},{"rnum":"04854568815262931612020194"},{"rnum":"04854568815262931612020195"},{"rnum":"04854568815262931612020196"},{"rnum":"04854568815262931612020197"},{"rnum":"04854568815262931612020198"},{"rnum":"04854568815262931612020199"},{"rnum":"04854568815262931612020200"},{"rnum":"04854568815262931612020201"},{"rnum":"04854568815262931612020202"},{"rnum":"04854568815262931612020203"},{"rnum":"04854568815262931612020204"},{"rnum":"04854568815262931612020205"},{"rnum":"04854568815262931612020206"},{"rnum":"04854568815262931612020207"},{"rnum":"04854568815262931612020208"},{"rnum":"04854568815262931612020209"},{"rnum":"04854568815262931612020210"},{"rnum":"04854568815262931612020211"},{"rnum":"04854568815262931612020212"},{"rnum":"04854568815262931612020213"},{"rnum":"04854568815262931612020214"},{"rnum":"04854568815262931612020215"},{"rnum":"04854568815262931612020216"},{"rnum":"04854568815262931612020217"},{"rnum":"04854568815262931612020218"},{"rnum":"04854568815262931612020219"},{"rnum":"04854568815262931612020220"},{"rnum":"04854568815262931612020221"},{"rnum":"04854568815262931612020222"},{"rnum":"04854568815262931612020223"},{"rnum":"04854568815262931612020224"},{"rnum":"04854568815262931612020225"},{"rnum":"04854568815262931612020226"},{"rnum":"04854568815262931612020227"},{"rnum":"04854568815262931612020228"},{"rnum":"04854568815262931612020229"},{"rnum":"04854568815262931612020230"},{"rnum":"04854568815262931612020231"},{"rnum":"04854568815262931612020232"},{"rnum":"04854568815262931612020233"},{"rnum":"04854568815262931612020234"},{"rnum":"04854568815262931612020235"},{"rnum":"04854568815262931612020236"},{"rnum":"04854568815262931612020237"},{"rnum":"04854568815262931612020238"},{"rnum":"04854568815262931612020239"},{"rnum":"04854568815262931612020240"},{"rnum":"04854568815262931612030001"},{"rnum":"04854568815262931612030002"},{"rnum":"04854568815262931612030003"},{"rnum":"04854568815262931612030004"},{"rnum":"04854568815262931612030005"},{"rnum":"04854568815262931612030006"},{"rnum":"04854568815262931612030007"},{"rnum":"04854568815262931612030008"},{"rnum":"04854568815262931612030009"},{"rnum":"04854568815262931612030010"},{"rnum":"04854568815262931612030011"},{"rnum":"04854568815262931612030012"},{"rnum":"04854568815262931612030013"},{"rnum":"04854568815262931612030014"},{"rnum":"04854568815262931612030015"},{"rnum":"04854568815262931612030016"},{"rnum":"04854568815262931612030017"},{"rnum":"04854568815262931612030018"},{"rnum":"04854568815262931612030019"},{"rnum":"04854568815262931612030020"},{"rnum":"04854568815262931612030021"},{"rnum":"04854568815262931612030022"},{"rnum":"04854568815262931612030023"},{"rnum":"04854568815262931612030024"},{"rnum":"04854568815262931612030025"},{"rnum":"04854568815262931612030026"},{"rnum":"04854568815262931612030027"},{"rnum":"04854568815262931612030028"},{"rnum":"04854568815262931612030029"},{"rnum":"04854568815262931612030030"},{"rnum":"04854568815262931612030031"},{"rnum":"04854568815262931612030032"},{"rnum":"04854568815262931612030033"},{"rnum":"04854568815262931612030034"},{"rnum":"04854568815262931612030035"},{"rnum":"04854568815262931612030036"},{"rnum":"04854568815262931612030037"},{"rnum":"04854568815262931612030038"},{"rnum":"04854568815262931612030039"},{"rnum":"04854568815262931612030040"},{"rnum":"04854568815262931612030041"},{"rnum":"04854568815262931612030042"},{"rnum":"04854568815262931612030043"},{"rnum":"04854568815262931612030044"},{"rnum":"04854568815262931612030045"},{"rnum":"04854568815262931612030046"},{"rnum":"04854568815262931612030047"},{"rnum":"04854568815262931612030048"},{"rnum":"04854568815262931612030049"},{"rnum":"04854568815262931612030050"},{"rnum":"04854568815262931612030051"},{"rnum":"04854568815262931612030052"},{"rnum":"04854568815262931612030053"},{"rnum":"04854568815262931612030054"},{"rnum":"04854568815262931612030055"},{"rnum":"04854568815262931612030056"},{"rnum":"04854568815262931612030057"},{"rnum":"04854568815262931612030058"},{"rnum":"04854568815262931612030059"},{"rnum":"04854568815262931612030060"},{"rnum":"04854568815262931612030061"},{"rnum":"04854568815262931612030062"},{"rnum":"04854568815262931612030063"},{"rnum":"04854568815262931612030064"},{"rnum":"04854568815262931612030065"},{"rnum":"04854568815262931612030066"},{"rnum":"04854568815262931612030067"},{"rnum":"04854568815262931612030068"},{"rnum":"04854568815262931612030069"},{"rnum":"04854568815262931612030070"},{"rnum":"04854568815262931612030071"},{"rnum":"04854568815262931612030072"},{"rnum":"04854568815262931612030073"},{"rnum":"04854568815262931612030074"},{"rnum":"04854568815262931612030075"},{"rnum":"04854568815262931612030076"},{"rnum":"04854568815262931612030077"},{"rnum":"04854568815262931612030078"},{"rnum":"04854568815262931612030079"},{"rnum":"04854568815262931612030080"},{"rnum":"04854568815262931612030081"},{"rnum":"04854568815262931612030082"},{"rnum":"04854568815262931612030083"},{"rnum":"04854568815262931612030084"},{"rnum":"04854568815262931612030085"},{"rnum":"04854568815262931612030086"},{"rnum":"04854568815262931612030087"},{"rnum":"04854568815262931612030088"},{"rnum":"04854568815262931612030089"},{"rnum":"04854568815262931612030090"},{"rnum":"04854568815262931612030091"},{"rnum":"04854568815262931612030092"},{"rnum":"04854568815262931612030093"},{"rnum":"04854568815262931612030094"},{"rnum":"04854568815262931612030095"},{"rnum":"04854568815262931612030096"},{"rnum":"04854568815262931612030097"},{"rnum":"04854568815262931612030098"},{"rnum":"04854568815262931612030099"},{"rnum":"04854568815262931612030100"},{"rnum":"04854568815262931612030101"},{"rnum":"04854568815262931612030102"},{"rnum":"04854568815262931612030103"},{"rnum":"04854568815262931612030104"},{"rnum":"04854568815262931612030105"},{"rnum":"04854568815262931612030106"},{"rnum":"04854568815262931612030107"},{"rnum":"04854568815262931612030108"},{"rnum":"04854568815262931612030109"},{"rnum":"04854568815262931612030110"},{"rnum":"04854568815262931612030111"},{"rnum":"04854568815262931612030112"},{"rnum":"04854568815262931612030113"},{"rnum":"04854568815262931612030114"},{"rnum":"04854568815262931612030115"},{"rnum":"04854568815262931612030116"},{"rnum":"04854568815262931612030117"},{"rnum":"04854568815262931612030118"},{"rnum":"04854568815262931612030119"},{"rnum":"04854568815262931612030120"},{"rnum":"04854568815262931612030121"},{"rnum":"04854568815262931612030122"},{"rnum":"04854568815262931612030123"},{"rnum":"04854568815262931612030124"},{"rnum":"04854568815262931612030125"},{"rnum":"04854568815262931612030126"},{"rnum":"04854568815262931612030127"},{"rnum":"04854568815262931612030128"},{"rnum":"04854568815262931612030129"},{"rnum":"04854568815262931612030130"},{"rnum":"04854568815262931612030131"},{"rnum":"04854568815262931612030132"},{"rnum":"04854568815262931612030133"},{"rnum":"04854568815262931612030134"},{"rnum":"04854568815262931612030135"},{"rnum":"04854568815262931612030136"},{"rnum":"04854568815262931612030137"},{"rnum":"04854568815262931612030138"},{"rnum":"04854568815262931612030139"},{"rnum":"04854568815262931612030140"},{"rnum":"04854568815262931612030141"},{"rnum":"04854568815262931612030142"},{"rnum":"04854568815262931612030143"},{"rnum":"04854568815262931612030144"},{"rnum":"04854568815262931612030145"},{"rnum":"04854568815262931612030146"},{"rnum":"04854568815262931612030147"},{"rnum":"04854568815262931612030148"},{"rnum":"04854568815262931612030149"},{"rnum":"04854568815262931612030150"},{"rnum":"04854568815262931612030151"},{"rnum":"04854568815262931612030152"},{"rnum":"04854568815262931612030153"},{"rnum":"04854568815262931612030154"},{"rnum":"04854568815262931612030155"},{"rnum":"04854568815262931612030156"},{"rnum":"04854568815262931612030157"},{"rnum":"04854568815262931612030158"},{"rnum":"04854568815262931612030159"},{"rnum":"04854568815262931612030160"},{"rnum":"04854568815262931612030161"},{"rnum":"04854568815262931612030162"},{"rnum":"04854568815262931612030163"},{"rnum":"04854568815262931612030164"},{"rnum":"04854568815262931612030165"},{"rnum":"04854568815262931612030166"},{"rnum":"04854568815262931612030167"},{"rnum":"04854568815262931612030168"},{"rnum":"04854568815262931612030169"},{"rnum":"04854568815262931612030170"},{"rnum":"04854568815262931612030171"},{"rnum":"04854568815262931612030172"},{"rnum":"04854568815262931612030173"},{"rnum":"04854568815262931612030174"},{"rnum":"04854568815262931612030175"},{"rnum":"04854568815262931612030176"},{"rnum":"04854568815262931612030177"},{"rnum":"04854568815262931612030178"},{"rnum":"04854568815262931612030179"},{"rnum":"04854568815262931612030180"},{"rnum":"04854568815262931612030181"},{"rnum":"04854568815262931612030182"},{"rnum":"04854568815262931612030183"},{"rnum":"04854568815262931612030184"},{"rnum":"04854568815262931612030185"},{"rnum":"04854568815262931612030186"},{"rnum":"04854568815262931612030187"},{"rnum":"04854568815262931612030188"},{"rnum":"04854568815262931612030189"},{"rnum":"04854568815262931612030190"},{"rnum":"04854568815262931612030191"},{"rnum":"04854568815262931612030192"},{"rnum":"04854568815262931612030193"},{"rnum":"04854568815262931612030194"},{"rnum":"04854568815262931612030195"},{"rnum":"04854568815262931612030196"},{"rnum":"04854568815262931612030197"},{"rnum":"04854568815262931612030198"},{"rnum":"04854568815262931612030199"},{"rnum":"04854568815262931612030200"},{"rnum":"04854568815262931612030201"},{"rnum":"04854568815262931612030202"},{"rnum":"04854568815262931612030203"},{"rnum":"04854568815262931612030204"},{"rnum":"04854568815262931612030205"},{"rnum":"04854568815262931612030206"},{"rnum":"04854568815262931612030207"},{"rnum":"04854568815262931612030208"},{"rnum":"04854568815262931612030209"},{"rnum":"04854568815262931612030210"},{"rnum":"04854568815262931612030211"},{"rnum":"04854568815262931612030212"},{"rnum":"04854568815262931612030213"},{"rnum":"04854568815262931612030214"},{"rnum":"04854568815262931612030215"},{"rnum":"04854568815262931612030216"},{"rnum":"04854568815262931612030217"},{"rnum":"04854568815262931612030218"},{"rnum":"04854568815262931612030219"},{"rnum":"04854568815262931612030220"},{"rnum":"04854568815262931612030221"},{"rnum":"04854568815262931612030222"},{"rnum":"04854568815262931612030223"},{"rnum":"04854568815262931612030224"},{"rnum":"04854568815262931612030225"},{"rnum":"04854568815262931612030226"},{"rnum":"04854568815262931612030227"},{"rnum":"04854568815262931612030228"},{"rnum":"04854568815262931612030229"},{"rnum":"04854568815262931612030230"},{"rnum":"04854568815262931612030231"},{"rnum":"04854568815262931612030232"},{"rnum":"04854568815262931612030233"},{"rnum":"04854568815262931612030234"},{"rnum":"04854568815262931612030235"},{"rnum":"04854568815262931612030236"},{"rnum":"04854568815262931612030237"},{"rnum":"04854568815262931612030238"},{"rnum":"04854568815262931612030239"},{"rnum":"04854568815262931612030240"},{"rnum":"04854568815262931612040001"},{"rnum":"04854568815262931612040002"},{"rnum":"04854568815262931612040003"},{"rnum":"04854568815262931612040004"},{"rnum":"04854568815262931612040005"},{"rnum":"04854568815262931612040006"},{"rnum":"04854568815262931612040007"},{"rnum":"04854568815262931612040008"},{"rnum":"04854568815262931612040009"},{"rnum":"04854568815262931612040010"},{"rnum":"04854568815262931612040011"},{"rnum":"04854568815262931612040012"},{"rnum":"04854568815262931612040013"},{"rnum":"04854568815262931612040014"},{"rnum":"04854568815262931612040015"},{"rnum":"04854568815262931612040016"},{"rnum":"04854568815262931612040017"},{"rnum":"04854568815262931612040018"},{"rnum":"04854568815262931612040019"},{"rnum":"04854568815262931612040020"},{"rnum":"04854568815262931612040021"},{"rnum":"04854568815262931612040022"},{"rnum":"04854568815262931612040023"},{"rnum":"04854568815262931612040024"},{"rnum":"04854568815262931612040025"},{"rnum":"04854568815262931612040026"},{"rnum":"04854568815262931612040027"},{"rnum":"04854568815262931612040028"},{"rnum":"04854568815262931612040029"},{"rnum":"04854568815262931612040030"},{"rnum":"04854568815262931612040031"},{"rnum":"04854568815262931612040032"},{"rnum":"04854568815262931612040033"},{"rnum":"04854568815262931612040034"},{"rnum":"04854568815262931612040035"},{"rnum":"04854568815262931612040036"},{"rnum":"04854568815262931612040037"},{"rnum":"04854568815262931612040038"},{"rnum":"04854568815262931612040039"},{"rnum":"04854568815262931612040040"},{"rnum":"04854568815262931612040041"},{"rnum":"04854568815262931612040042"},{"rnum":"04854568815262931612040043"},{"rnum":"04854568815262931612040044"},{"rnum":"04854568815262931612040045"},{"rnum":"04854568815262931612040046"},{"rnum":"04854568815262931612040047"},{"rnum":"04854568815262931612040048"},{"rnum":"04854568815262931612040049"},{"rnum":"04854568815262931612040050"},{"rnum":"04854568815262931612040051"},{"rnum":"04854568815262931612040052"},{"rnum":"04854568815262931612040053"},{"rnum":"04854568815262931612040054"},{"rnum":"04854568815262931612040055"},{"rnum":"04854568815262931612040056"},{"rnum":"04854568815262931612040057"},{"rnum":"04854568815262931612040058"},{"rnum":"04854568815262931612040059"},{"rnum":"04854568815262931612040060"},{"rnum":"04854568815262931612040061"},{"rnum":"04854568815262931612040062"},{"rnum":"04854568815262931612040063"},{"rnum":"04854568815262931612040064"},{"rnum":"04854568815262931612040065"},{"rnum":"04854568815262931612040066"},{"rnum":"04854568815262931612040067"},{"rnum":"04854568815262931612040068"},{"rnum":"04854568815262931612040069"},{"rnum":"04854568815262931612040070"},{"rnum":"04854568815262931612040071"},{"rnum":"04854568815262931612040072"},{"rnum":"04854568815262931612040073"},{"rnum":"04854568815262931612040074"},{"rnum":"04854568815262931612040075"},{"rnum":"04854568815262931612040076"},{"rnum":"04854568815262931612040077"},{"rnum":"04854568815262931612040078"},{"rnum":"04854568815262931612040079"},{"rnum":"04854568815262931612040080"},{"rnum":"04854568815262931612040081"},{"rnum":"04854568815262931612040082"},{"rnum":"04854568815262931612040083"},{"rnum":"04854568815262931612040084"},{"rnum":"04854568815262931612040085"},{"rnum":"04854568815262931612040086"},{"rnum":"04854568815262931612040087"},{"rnum":"04854568815262931612040088"},{"rnum":"04854568815262931612040089"},{"rnum":"04854568815262931612040090"},{"rnum":"04854568815262931612040091"},{"rnum":"04854568815262931612040092"},{"rnum":"04854568815262931612040093"},{"rnum":"04854568815262931612040094"},{"rnum":"04854568815262931612040095"},{"rnum":"04854568815262931612040096"},{"rnum":"04854568815262931612040097"},{"rnum":"04854568815262931612040098"},{"rnum":"04854568815262931612040099"},{"rnum":"04854568815262931612040100"},{"rnum":"04854568815262931612040101"},{"rnum":"04854568815262931612040102"},{"rnum":"04854568815262931612040103"},{"rnum":"04854568815262931612040104"},{"rnum":"04854568815262931612040105"},{"rnum":"04854568815262931612040106"},{"rnum":"04854568815262931612040107"},{"rnum":"04854568815262931612040108"},{"rnum":"04854568815262931612040109"},{"rnum":"04854568815262931612040110"},{"rnum":"04854568815262931612040111"},{"rnum":"04854568815262931612040112"},{"rnum":"04854568815262931612040113"},{"rnum":"04854568815262931612040114"},{"rnum":"04854568815262931612040115"},{"rnum":"04854568815262931612040116"},{"rnum":"04854568815262931612040117"},{"rnum":"04854568815262931612040118"},{"rnum":"04854568815262931612040119"},{"rnum":"04854568815262931612040120"},{"rnum":"04854568815262931612040121"},{"rnum":"04854568815262931612040122"},{"rnum":"04854568815262931612040123"},{"rnum":"04854568815262931612040124"},{"rnum":"04854568815262931612040125"},{"rnum":"04854568815262931612040126"},{"rnum":"04854568815262931612040127"},{"rnum":"04854568815262931612040128"},{"rnum":"04854568815262931612040129"},{"rnum":"04854568815262931612040130"},{"rnum":"04854568815262931612040131"},{"rnum":"04854568815262931612040132"},{"rnum":"04854568815262931612040133"},{"rnum":"04854568815262931612040134"},{"rnum":"04854568815262931612040135"},{"rnum":"04854568815262931612040136"},{"rnum":"04854568815262931612040137"},{"rnum":"04854568815262931612040138"},{"rnum":"04854568815262931612040139"},{"rnum":"04854568815262931612040140"},{"rnum":"04854568815262931612040141"},{"rnum":"04854568815262931612040142"},{"rnum":"04854568815262931612040143"},{"rnum":"04854568815262931612040144"},{"rnum":"04854568815262931612040145"},{"rnum":"04854568815262931612040146"},{"rnum":"04854568815262931612040147"},{"rnum":"04854568815262931612040148"},{"rnum":"04854568815262931612040149"},{"rnum":"04854568815262931612040150"},{"rnum":"04854568815262931612040151"},{"rnum":"04854568815262931612040152"},{"rnum":"04854568815262931612040153"},{"rnum":"04854568815262931612040154"},{"rnum":"04854568815262931612040155"},{"rnum":"04854568815262931612040156"},{"rnum":"04854568815262931612040157"},{"rnum":"04854568815262931612040158"},{"rnum":"04854568815262931612040159"},{"rnum":"04854568815262931612040160"},{"rnum":"04854568815262931612040161"},{"rnum":"04854568815262931612040162"},{"rnum":"04854568815262931612040163"},{"rnum":"04854568815262931612040164"},{"rnum":"04854568815262931612040165"},{"rnum":"04854568815262931612040166"},{"rnum":"04854568815262931612040167"},{"rnum":"04854568815262931612040168"},{"rnum":"04854568815262931612040169"},{"rnum":"04854568815262931612040170"},{"rnum":"04854568815262931612040171"},{"rnum":"04854568815262931612040172"},{"rnum":"04854568815262931612040173"},{"rnum":"04854568815262931612040174"},{"rnum":"04854568815262931612040175"},{"rnum":"04854568815262931612040176"},{"rnum":"04854568815262931612040177"},{"rnum":"04854568815262931612040178"},{"rnum":"04854568815262931612040179"},{"rnum":"04854568815262931612040180"},{"rnum":"04854568815262931612040181"},{"rnum":"04854568815262931612040182"},{"rnum":"04854568815262931612040183"},{"rnum":"04854568815262931612040184"},{"rnum":"04854568815262931612040185"},{"rnum":"04854568815262931612040186"},{"rnum":"04854568815262931612040187"},{"rnum":"04854568815262931612040188"},{"rnum":"04854568815262931612040189"},{"rnum":"04854568815262931612040190"},{"rnum":"04854568815262931612040191"},{"rnum":"04854568815262931612040192"},{"rnum":"04854568815262931612040193"},{"rnum":"04854568815262931612040194"},{"rnum":"04854568815262931612040195"},{"rnum":"04854568815262931612040196"},{"rnum":"04854568815262931612040197"},{"rnum":"04854568815262931612040198"},{"rnum":"04854568815262931612040199"},{"rnum":"04854568815262931612040200"},{"rnum":"04854568815262931612040201"},{"rnum":"04854568815262931612040202"},{"rnum":"04854568815262931612040203"},{"rnum":"04854568815262931612040204"},{"rnum":"04854568815262931612040205"},{"rnum":"04854568815262931612040206"},{"rnum":"04854568815262931612040207"},{"rnum":"04854568815262931612040208"},{"rnum":"04854568815262931612040209"},{"rnum":"04854568815262931612040210"},{"rnum":"04854568815262931612040211"},{"rnum":"04854568815262931612040212"},{"rnum":"04854568815262931612040213"},{"rnum":"04854568815262931612040214"},{"rnum":"04854568815262931612040215"},{"rnum":"04854568815262931612040216"},{"rnum":"04854568815262931612040217"},{"rnum":"04854568815262931612040218"},{"rnum":"04854568815262931612040219"},{"rnum":"04854568815262931612040220"},{"rnum":"04854568815262931612040221"},{"rnum":"04854568815262931612040222"},{"rnum":"04854568815262931612040223"},{"rnum":"04854568815262931612040224"},{"rnum":"04854568815262931612040225"},{"rnum":"04854568815262931612040226"},{"rnum":"04854568815262931612040227"},{"rnum":"04854568815262931612040228"},{"rnum":"04854568815262931612040229"},{"rnum":"04854568815262931612040230"},{"rnum":"04854568815262931612040231"},{"rnum":"04854568815262931612040232"},{"rnum":"04854568815262931612040233"},{"rnum":"04854568815262931612040234"},{"rnum":"04854568815262931612040235"},{"rnum":"04854568815262931612040236"},{"rnum":"04854568815262931612040237"},{"rnum":"04854568815262931612040238"},{"rnum":"04854568815262931612040239"},{"rnum":"04854568815262931612040240"}]';
			}else if(subject==3){
				vehicletime="1440";
				totaltime="1440";
				duration=1440;
	
				//采用测试数据
				xzxzx='[{"rnum":"04854568815262931612010001"},{"rnum":"04854568815262931612010002"},{"rnum":"04854568815262931612010003"},{"rnum":"04854568815262931612010004"},{"rnum":"04854568815262931612010005"},{"rnum":"04854568815262931612010006"},{"rnum":"04854568815262931612010007"},{"rnum":"04854568815262931612010008"},{"rnum":"04854568815262931612010009"},{"rnum":"04854568815262931612010010"},{"rnum":"04854568815262931612010011"},{"rnum":"04854568815262931612010012"},{"rnum":"04854568815262931612010013"},{"rnum":"04854568815262931612010014"},{"rnum":"04854568815262931612010015"},{"rnum":"04854568815262931612010016"},{"rnum":"04854568815262931612010017"},{"rnum":"04854568815262931612010018"},{"rnum":"04854568815262931612010019"},{"rnum":"04854568815262931612010020"},{"rnum":"04854568815262931612010021"},{"rnum":"04854568815262931612010022"},{"rnum":"04854568815262931612010023"},{"rnum":"04854568815262931612010024"},{"rnum":"04854568815262931612010025"},{"rnum":"04854568815262931612010026"},{"rnum":"04854568815262931612010027"},{"rnum":"04854568815262931612010028"},{"rnum":"04854568815262931612010029"},{"rnum":"04854568815262931612010030"},{"rnum":"04854568815262931612010031"},{"rnum":"04854568815262931612010032"},{"rnum":"04854568815262931612010033"},{"rnum":"04854568815262931612010034"},{"rnum":"04854568815262931612010035"},{"rnum":"04854568815262931612010036"},{"rnum":"04854568815262931612010037"},{"rnum":"04854568815262931612010038"},{"rnum":"04854568815262931612010039"},{"rnum":"04854568815262931612010040"},{"rnum":"04854568815262931612010041"},{"rnum":"04854568815262931612010042"},{"rnum":"04854568815262931612010043"},{"rnum":"04854568815262931612010044"},{"rnum":"04854568815262931612010045"},{"rnum":"04854568815262931612010046"},{"rnum":"04854568815262931612010047"},{"rnum":"04854568815262931612010048"},{"rnum":"04854568815262931612010049"},{"rnum":"04854568815262931612010050"},{"rnum":"04854568815262931612010051"},{"rnum":"04854568815262931612010052"},{"rnum":"04854568815262931612010053"},{"rnum":"04854568815262931612010054"},{"rnum":"04854568815262931612010055"},{"rnum":"04854568815262931612010056"},{"rnum":"04854568815262931612010057"},{"rnum":"04854568815262931612010058"},{"rnum":"04854568815262931612010059"},{"rnum":"04854568815262931612010060"},{"rnum":"04854568815262931612010061"},{"rnum":"04854568815262931612010062"},{"rnum":"04854568815262931612010063"},{"rnum":"04854568815262931612010064"},{"rnum":"04854568815262931612010065"},{"rnum":"04854568815262931612010066"},{"rnum":"04854568815262931612010067"},{"rnum":"04854568815262931612010068"},{"rnum":"04854568815262931612010069"},{"rnum":"04854568815262931612010070"},{"rnum":"04854568815262931612010071"},{"rnum":"04854568815262931612010072"},{"rnum":"04854568815262931612010073"},{"rnum":"04854568815262931612010074"},{"rnum":"04854568815262931612010075"},{"rnum":"04854568815262931612010076"},{"rnum":"04854568815262931612010077"},{"rnum":"04854568815262931612010078"},{"rnum":"04854568815262931612010079"},{"rnum":"04854568815262931612010080"},{"rnum":"04854568815262931612010081"},{"rnum":"04854568815262931612010082"},{"rnum":"04854568815262931612010083"},{"rnum":"04854568815262931612010084"},{"rnum":"04854568815262931612010085"},{"rnum":"04854568815262931612010086"},{"rnum":"04854568815262931612010087"},{"rnum":"04854568815262931612010088"},{"rnum":"04854568815262931612010089"},{"rnum":"04854568815262931612010090"},{"rnum":"04854568815262931612010091"},{"rnum":"04854568815262931612010092"},{"rnum":"04854568815262931612010093"},{"rnum":"04854568815262931612010094"},{"rnum":"04854568815262931612010095"},{"rnum":"04854568815262931612010096"},{"rnum":"04854568815262931612010097"},{"rnum":"04854568815262931612010098"},{"rnum":"04854568815262931612010099"},{"rnum":"04854568815262931612010100"},{"rnum":"04854568815262931612010101"},{"rnum":"04854568815262931612010102"},{"rnum":"04854568815262931612010103"},{"rnum":"04854568815262931612010104"},{"rnum":"04854568815262931612010105"},{"rnum":"04854568815262931612010106"},{"rnum":"04854568815262931612010107"},{"rnum":"04854568815262931612010108"},{"rnum":"04854568815262931612010109"},{"rnum":"04854568815262931612010110"},{"rnum":"04854568815262931612010111"},{"rnum":"04854568815262931612010112"},{"rnum":"04854568815262931612010113"},{"rnum":"04854568815262931612010114"},{"rnum":"04854568815262931612010115"},{"rnum":"04854568815262931612010116"},{"rnum":"04854568815262931612010117"},{"rnum":"04854568815262931612010118"},{"rnum":"04854568815262931612010119"},{"rnum":"04854568815262931612010120"},{"rnum":"04854568815262931612010121"},{"rnum":"04854568815262931612010122"},{"rnum":"04854568815262931612010123"},{"rnum":"04854568815262931612010124"},{"rnum":"04854568815262931612010125"},{"rnum":"04854568815262931612010126"},{"rnum":"04854568815262931612010127"},{"rnum":"04854568815262931612010128"},{"rnum":"04854568815262931612010129"},{"rnum":"04854568815262931612010130"},{"rnum":"04854568815262931612010131"},{"rnum":"04854568815262931612010132"},{"rnum":"04854568815262931612010133"},{"rnum":"04854568815262931612010134"},{"rnum":"04854568815262931612010135"},{"rnum":"04854568815262931612010136"},{"rnum":"04854568815262931612010137"},{"rnum":"04854568815262931612010138"},{"rnum":"04854568815262931612010139"},{"rnum":"04854568815262931612010140"},{"rnum":"04854568815262931612010141"},{"rnum":"04854568815262931612010142"},{"rnum":"04854568815262931612010143"},{"rnum":"04854568815262931612010144"},{"rnum":"04854568815262931612010145"},{"rnum":"04854568815262931612010146"},{"rnum":"04854568815262931612010147"},{"rnum":"04854568815262931612010148"},{"rnum":"04854568815262931612010149"},{"rnum":"04854568815262931612010150"},{"rnum":"04854568815262931612010151"},{"rnum":"04854568815262931612010152"},{"rnum":"04854568815262931612010153"},{"rnum":"04854568815262931612010154"},{"rnum":"04854568815262931612010155"},{"rnum":"04854568815262931612010156"},{"rnum":"04854568815262931612010157"},{"rnum":"04854568815262931612010158"},{"rnum":"04854568815262931612010159"},{"rnum":"04854568815262931612010160"},{"rnum":"04854568815262931612010161"},{"rnum":"04854568815262931612010162"},{"rnum":"04854568815262931612010163"},{"rnum":"04854568815262931612010164"},{"rnum":"04854568815262931612010165"},{"rnum":"04854568815262931612010166"},{"rnum":"04854568815262931612010167"},{"rnum":"04854568815262931612010168"},{"rnum":"04854568815262931612010169"},{"rnum":"04854568815262931612010170"},{"rnum":"04854568815262931612010171"},{"rnum":"04854568815262931612010172"},{"rnum":"04854568815262931612010173"},{"rnum":"04854568815262931612010174"},{"rnum":"04854568815262931612010175"},{"rnum":"04854568815262931612010176"},{"rnum":"04854568815262931612010177"},{"rnum":"04854568815262931612010178"},{"rnum":"04854568815262931612010179"},{"rnum":"04854568815262931612010180"},{"rnum":"04854568815262931612010181"},{"rnum":"04854568815262931612010182"},{"rnum":"04854568815262931612010183"},{"rnum":"04854568815262931612010184"},{"rnum":"04854568815262931612010185"},{"rnum":"04854568815262931612010186"},{"rnum":"04854568815262931612010187"},{"rnum":"04854568815262931612010188"},{"rnum":"04854568815262931612010189"},{"rnum":"04854568815262931612010190"},{"rnum":"04854568815262931612010191"},{"rnum":"04854568815262931612010192"},{"rnum":"04854568815262931612010193"},{"rnum":"04854568815262931612010194"},{"rnum":"04854568815262931612010195"},{"rnum":"04854568815262931612010196"},{"rnum":"04854568815262931612010197"},{"rnum":"04854568815262931612010198"},{"rnum":"04854568815262931612010199"},{"rnum":"04854568815262931612010200"},{"rnum":"04854568815262931612010201"},{"rnum":"04854568815262931612010202"},{"rnum":"04854568815262931612010203"},{"rnum":"04854568815262931612010204"},{"rnum":"04854568815262931612010205"},{"rnum":"04854568815262931612010206"},{"rnum":"04854568815262931612010207"},{"rnum":"04854568815262931612010208"},{"rnum":"04854568815262931612010209"},{"rnum":"04854568815262931612010210"},{"rnum":"04854568815262931612010211"},{"rnum":"04854568815262931612010212"},{"rnum":"04854568815262931612010213"},{"rnum":"04854568815262931612010214"},{"rnum":"04854568815262931612010215"},{"rnum":"04854568815262931612010216"},{"rnum":"04854568815262931612010217"},{"rnum":"04854568815262931612010218"},{"rnum":"04854568815262931612010219"},{"rnum":"04854568815262931612010220"},{"rnum":"04854568815262931612010221"},{"rnum":"04854568815262931612010222"},{"rnum":"04854568815262931612010223"},{"rnum":"04854568815262931612010224"},{"rnum":"04854568815262931612010225"},{"rnum":"04854568815262931612010226"},{"rnum":"04854568815262931612010227"},{"rnum":"04854568815262931612010228"},{"rnum":"04854568815262931612010229"},{"rnum":"04854568815262931612010230"},{"rnum":"04854568815262931612010231"},{"rnum":"04854568815262931612010232"},{"rnum":"04854568815262931612010233"},{"rnum":"04854568815262931612010234"},{"rnum":"04854568815262931612010235"},{"rnum":"04854568815262931612010236"},{"rnum":"04854568815262931612010237"},{"rnum":"04854568815262931612010238"},{"rnum":"04854568815262931612010239"},{"rnum":"04854568815262931612010240"},{"rnum":"04854568815262931612020001"},{"rnum":"04854568815262931612020002"},{"rnum":"04854568815262931612020003"},{"rnum":"04854568815262931612020004"},{"rnum":"04854568815262931612020005"},{"rnum":"04854568815262931612020006"},{"rnum":"04854568815262931612020007"},{"rnum":"04854568815262931612020008"},{"rnum":"04854568815262931612020009"},{"rnum":"04854568815262931612020010"},{"rnum":"04854568815262931612020011"},{"rnum":"04854568815262931612020012"},{"rnum":"04854568815262931612020013"},{"rnum":"04854568815262931612020014"},{"rnum":"04854568815262931612020015"},{"rnum":"04854568815262931612020016"},{"rnum":"04854568815262931612020017"},{"rnum":"04854568815262931612020018"},{"rnum":"04854568815262931612020019"},{"rnum":"04854568815262931612020020"},{"rnum":"04854568815262931612020021"},{"rnum":"04854568815262931612020022"},{"rnum":"04854568815262931612020023"},{"rnum":"04854568815262931612020024"},{"rnum":"04854568815262931612020025"},{"rnum":"04854568815262931612020026"},{"rnum":"04854568815262931612020027"},{"rnum":"04854568815262931612020028"},{"rnum":"04854568815262931612020029"},{"rnum":"04854568815262931612020030"},{"rnum":"04854568815262931612020031"},{"rnum":"04854568815262931612020032"},{"rnum":"04854568815262931612020033"},{"rnum":"04854568815262931612020034"},{"rnum":"04854568815262931612020035"},{"rnum":"04854568815262931612020036"},{"rnum":"04854568815262931612020037"},{"rnum":"04854568815262931612020038"},{"rnum":"04854568815262931612020039"},{"rnum":"04854568815262931612020040"},{"rnum":"04854568815262931612020041"},{"rnum":"04854568815262931612020042"},{"rnum":"04854568815262931612020043"},{"rnum":"04854568815262931612020044"},{"rnum":"04854568815262931612020045"},{"rnum":"04854568815262931612020046"},{"rnum":"04854568815262931612020047"},{"rnum":"04854568815262931612020048"},{"rnum":"04854568815262931612020049"},{"rnum":"04854568815262931612020050"},{"rnum":"04854568815262931612020051"},{"rnum":"04854568815262931612020052"},{"rnum":"04854568815262931612020053"},{"rnum":"04854568815262931612020054"},{"rnum":"04854568815262931612020055"},{"rnum":"04854568815262931612020056"},{"rnum":"04854568815262931612020057"},{"rnum":"04854568815262931612020058"},{"rnum":"04854568815262931612020059"},{"rnum":"04854568815262931612020060"},{"rnum":"04854568815262931612020061"},{"rnum":"04854568815262931612020062"},{"rnum":"04854568815262931612020063"},{"rnum":"04854568815262931612020064"},{"rnum":"04854568815262931612020065"},{"rnum":"04854568815262931612020066"},{"rnum":"04854568815262931612020067"},{"rnum":"04854568815262931612020068"},{"rnum":"04854568815262931612020069"},{"rnum":"04854568815262931612020070"},{"rnum":"04854568815262931612020071"},{"rnum":"04854568815262931612020072"},{"rnum":"04854568815262931612020073"},{"rnum":"04854568815262931612020074"},{"rnum":"04854568815262931612020075"},{"rnum":"04854568815262931612020076"},{"rnum":"04854568815262931612020077"},{"rnum":"04854568815262931612020078"},{"rnum":"04854568815262931612020079"},{"rnum":"04854568815262931612020080"},{"rnum":"04854568815262931612020081"},{"rnum":"04854568815262931612020082"},{"rnum":"04854568815262931612020083"},{"rnum":"04854568815262931612020084"},{"rnum":"04854568815262931612020085"},{"rnum":"04854568815262931612020086"},{"rnum":"04854568815262931612020087"},{"rnum":"04854568815262931612020088"},{"rnum":"04854568815262931612020089"},{"rnum":"04854568815262931612020090"},{"rnum":"04854568815262931612020091"},{"rnum":"04854568815262931612020092"},{"rnum":"04854568815262931612020093"},{"rnum":"04854568815262931612020094"},{"rnum":"04854568815262931612020095"},{"rnum":"04854568815262931612020096"},{"rnum":"04854568815262931612020097"},{"rnum":"04854568815262931612020098"},{"rnum":"04854568815262931612020099"},{"rnum":"04854568815262931612020100"},{"rnum":"04854568815262931612020101"},{"rnum":"04854568815262931612020102"},{"rnum":"04854568815262931612020103"},{"rnum":"04854568815262931612020104"},{"rnum":"04854568815262931612020105"},{"rnum":"04854568815262931612020106"},{"rnum":"04854568815262931612020107"},{"rnum":"04854568815262931612020108"},{"rnum":"04854568815262931612020109"},{"rnum":"04854568815262931612020110"},{"rnum":"04854568815262931612020111"},{"rnum":"04854568815262931612020112"},{"rnum":"04854568815262931612020113"},{"rnum":"04854568815262931612020114"},{"rnum":"04854568815262931612020115"},{"rnum":"04854568815262931612020116"},{"rnum":"04854568815262931612020117"},{"rnum":"04854568815262931612020118"},{"rnum":"04854568815262931612020119"},{"rnum":"04854568815262931612020120"},{"rnum":"04854568815262931612020121"},{"rnum":"04854568815262931612020122"},{"rnum":"04854568815262931612020123"},{"rnum":"04854568815262931612020124"},{"rnum":"04854568815262931612020125"},{"rnum":"04854568815262931612020126"},{"rnum":"04854568815262931612020127"},{"rnum":"04854568815262931612020128"},{"rnum":"04854568815262931612020129"},{"rnum":"04854568815262931612020130"},{"rnum":"04854568815262931612020131"},{"rnum":"04854568815262931612020132"},{"rnum":"04854568815262931612020133"},{"rnum":"04854568815262931612020134"},{"rnum":"04854568815262931612020135"},{"rnum":"04854568815262931612020136"},{"rnum":"04854568815262931612020137"},{"rnum":"04854568815262931612020138"},{"rnum":"04854568815262931612020139"},{"rnum":"04854568815262931612020140"},{"rnum":"04854568815262931612020141"},{"rnum":"04854568815262931612020142"},{"rnum":"04854568815262931612020143"},{"rnum":"04854568815262931612020144"},{"rnum":"04854568815262931612020145"},{"rnum":"04854568815262931612020146"},{"rnum":"04854568815262931612020147"},{"rnum":"04854568815262931612020148"},{"rnum":"04854568815262931612020149"},{"rnum":"04854568815262931612020150"},{"rnum":"04854568815262931612020151"},{"rnum":"04854568815262931612020152"},{"rnum":"04854568815262931612020153"},{"rnum":"04854568815262931612020154"},{"rnum":"04854568815262931612020155"},{"rnum":"04854568815262931612020156"},{"rnum":"04854568815262931612020157"},{"rnum":"04854568815262931612020158"},{"rnum":"04854568815262931612020159"},{"rnum":"04854568815262931612020160"},{"rnum":"04854568815262931612020161"},{"rnum":"04854568815262931612020162"},{"rnum":"04854568815262931612020163"},{"rnum":"04854568815262931612020164"},{"rnum":"04854568815262931612020165"},{"rnum":"04854568815262931612020166"},{"rnum":"04854568815262931612020167"},{"rnum":"04854568815262931612020168"},{"rnum":"04854568815262931612020169"},{"rnum":"04854568815262931612020170"},{"rnum":"04854568815262931612020171"},{"rnum":"04854568815262931612020172"},{"rnum":"04854568815262931612020173"},{"rnum":"04854568815262931612020174"},{"rnum":"04854568815262931612020175"},{"rnum":"04854568815262931612020176"},{"rnum":"04854568815262931612020177"},{"rnum":"04854568815262931612020178"},{"rnum":"04854568815262931612020179"},{"rnum":"04854568815262931612020180"},{"rnum":"04854568815262931612020181"},{"rnum":"04854568815262931612020182"},{"rnum":"04854568815262931612020183"},{"rnum":"04854568815262931612020184"},{"rnum":"04854568815262931612020185"},{"rnum":"04854568815262931612020186"},{"rnum":"04854568815262931612020187"},{"rnum":"04854568815262931612020188"},{"rnum":"04854568815262931612020189"},{"rnum":"04854568815262931612020190"},{"rnum":"04854568815262931612020191"},{"rnum":"04854568815262931612020192"},{"rnum":"04854568815262931612020193"},{"rnum":"04854568815262931612020194"},{"rnum":"04854568815262931612020195"},{"rnum":"04854568815262931612020196"},{"rnum":"04854568815262931612020197"},{"rnum":"04854568815262931612020198"},{"rnum":"04854568815262931612020199"},{"rnum":"04854568815262931612020200"},{"rnum":"04854568815262931612020201"},{"rnum":"04854568815262931612020202"},{"rnum":"04854568815262931612020203"},{"rnum":"04854568815262931612020204"},{"rnum":"04854568815262931612020205"},{"rnum":"04854568815262931612020206"},{"rnum":"04854568815262931612020207"},{"rnum":"04854568815262931612020208"},{"rnum":"04854568815262931612020209"},{"rnum":"04854568815262931612020210"},{"rnum":"04854568815262931612020211"},{"rnum":"04854568815262931612020212"},{"rnum":"04854568815262931612020213"},{"rnum":"04854568815262931612020214"},{"rnum":"04854568815262931612020215"},{"rnum":"04854568815262931612020216"},{"rnum":"04854568815262931612020217"},{"rnum":"04854568815262931612020218"},{"rnum":"04854568815262931612020219"},{"rnum":"04854568815262931612020220"},{"rnum":"04854568815262931612020221"},{"rnum":"04854568815262931612020222"},{"rnum":"04854568815262931612020223"},{"rnum":"04854568815262931612020224"},{"rnum":"04854568815262931612020225"},{"rnum":"04854568815262931612020226"},{"rnum":"04854568815262931612020227"},{"rnum":"04854568815262931612020228"},{"rnum":"04854568815262931612020229"},{"rnum":"04854568815262931612020230"},{"rnum":"04854568815262931612020231"},{"rnum":"04854568815262931612020232"},{"rnum":"04854568815262931612020233"},{"rnum":"04854568815262931612020234"},{"rnum":"04854568815262931612020235"},{"rnum":"04854568815262931612020236"},{"rnum":"04854568815262931612020237"},{"rnum":"04854568815262931612020238"},{"rnum":"04854568815262931612020239"},{"rnum":"04854568815262931612020240"},{"rnum":"04854568815262931612030001"},{"rnum":"04854568815262931612030002"},{"rnum":"04854568815262931612030003"},{"rnum":"04854568815262931612030004"},{"rnum":"04854568815262931612030005"},{"rnum":"04854568815262931612030006"},{"rnum":"04854568815262931612030007"},{"rnum":"04854568815262931612030008"},{"rnum":"04854568815262931612030009"},{"rnum":"04854568815262931612030010"},{"rnum":"04854568815262931612030011"},{"rnum":"04854568815262931612030012"},{"rnum":"04854568815262931612030013"},{"rnum":"04854568815262931612030014"},{"rnum":"04854568815262931612030015"},{"rnum":"04854568815262931612030016"},{"rnum":"04854568815262931612030017"},{"rnum":"04854568815262931612030018"},{"rnum":"04854568815262931612030019"},{"rnum":"04854568815262931612030020"},{"rnum":"04854568815262931612030021"},{"rnum":"04854568815262931612030022"},{"rnum":"04854568815262931612030023"},{"rnum":"04854568815262931612030024"},{"rnum":"04854568815262931612030025"},{"rnum":"04854568815262931612030026"},{"rnum":"04854568815262931612030027"},{"rnum":"04854568815262931612030028"},{"rnum":"04854568815262931612030029"},{"rnum":"04854568815262931612030030"},{"rnum":"04854568815262931612030031"},{"rnum":"04854568815262931612030032"},{"rnum":"04854568815262931612030033"},{"rnum":"04854568815262931612030034"},{"rnum":"04854568815262931612030035"},{"rnum":"04854568815262931612030036"},{"rnum":"04854568815262931612030037"},{"rnum":"04854568815262931612030038"},{"rnum":"04854568815262931612030039"},{"rnum":"04854568815262931612030040"},{"rnum":"04854568815262931612030041"},{"rnum":"04854568815262931612030042"},{"rnum":"04854568815262931612030043"},{"rnum":"04854568815262931612030044"},{"rnum":"04854568815262931612030045"},{"rnum":"04854568815262931612030046"},{"rnum":"04854568815262931612030047"},{"rnum":"04854568815262931612030048"},{"rnum":"04854568815262931612030049"},{"rnum":"04854568815262931612030050"},{"rnum":"04854568815262931612030051"},{"rnum":"04854568815262931612030052"},{"rnum":"04854568815262931612030053"},{"rnum":"04854568815262931612030054"},{"rnum":"04854568815262931612030055"},{"rnum":"04854568815262931612030056"},{"rnum":"04854568815262931612030057"},{"rnum":"04854568815262931612030058"},{"rnum":"04854568815262931612030059"},{"rnum":"04854568815262931612030060"},{"rnum":"04854568815262931612030061"},{"rnum":"04854568815262931612030062"},{"rnum":"04854568815262931612030063"},{"rnum":"04854568815262931612030064"},{"rnum":"04854568815262931612030065"},{"rnum":"04854568815262931612030066"},{"rnum":"04854568815262931612030067"},{"rnum":"04854568815262931612030068"},{"rnum":"04854568815262931612030069"},{"rnum":"04854568815262931612030070"},{"rnum":"04854568815262931612030071"},{"rnum":"04854568815262931612030072"},{"rnum":"04854568815262931612030073"},{"rnum":"04854568815262931612030074"},{"rnum":"04854568815262931612030075"},{"rnum":"04854568815262931612030076"},{"rnum":"04854568815262931612030077"},{"rnum":"04854568815262931612030078"},{"rnum":"04854568815262931612030079"},{"rnum":"04854568815262931612030080"},{"rnum":"04854568815262931612030081"},{"rnum":"04854568815262931612030082"},{"rnum":"04854568815262931612030083"},{"rnum":"04854568815262931612030084"},{"rnum":"04854568815262931612030085"},{"rnum":"04854568815262931612030086"},{"rnum":"04854568815262931612030087"},{"rnum":"04854568815262931612030088"},{"rnum":"04854568815262931612030089"},{"rnum":"04854568815262931612030090"},{"rnum":"04854568815262931612030091"},{"rnum":"04854568815262931612030092"},{"rnum":"04854568815262931612030093"},{"rnum":"04854568815262931612030094"},{"rnum":"04854568815262931612030095"},{"rnum":"04854568815262931612030096"},{"rnum":"04854568815262931612030097"},{"rnum":"04854568815262931612030098"},{"rnum":"04854568815262931612030099"},{"rnum":"04854568815262931612030100"},{"rnum":"04854568815262931612030101"},{"rnum":"04854568815262931612030102"},{"rnum":"04854568815262931612030103"},{"rnum":"04854568815262931612030104"},{"rnum":"04854568815262931612030105"},{"rnum":"04854568815262931612030106"},{"rnum":"04854568815262931612030107"},{"rnum":"04854568815262931612030108"},{"rnum":"04854568815262931612030109"},{"rnum":"04854568815262931612030110"},{"rnum":"04854568815262931612030111"},{"rnum":"04854568815262931612030112"},{"rnum":"04854568815262931612030113"},{"rnum":"04854568815262931612030114"},{"rnum":"04854568815262931612030115"},{"rnum":"04854568815262931612030116"},{"rnum":"04854568815262931612030117"},{"rnum":"04854568815262931612030118"},{"rnum":"04854568815262931612030119"},{"rnum":"04854568815262931612030120"},{"rnum":"04854568815262931612030121"},{"rnum":"04854568815262931612030122"},{"rnum":"04854568815262931612030123"},{"rnum":"04854568815262931612030124"},{"rnum":"04854568815262931612030125"},{"rnum":"04854568815262931612030126"},{"rnum":"04854568815262931612030127"},{"rnum":"04854568815262931612030128"},{"rnum":"04854568815262931612030129"},{"rnum":"04854568815262931612030130"},{"rnum":"04854568815262931612030131"},{"rnum":"04854568815262931612030132"},{"rnum":"04854568815262931612030133"},{"rnum":"04854568815262931612030134"},{"rnum":"04854568815262931612030135"},{"rnum":"04854568815262931612030136"},{"rnum":"04854568815262931612030137"},{"rnum":"04854568815262931612030138"},{"rnum":"04854568815262931612030139"},{"rnum":"04854568815262931612030140"},{"rnum":"04854568815262931612030141"},{"rnum":"04854568815262931612030142"},{"rnum":"04854568815262931612030143"},{"rnum":"04854568815262931612030144"},{"rnum":"04854568815262931612030145"},{"rnum":"04854568815262931612030146"},{"rnum":"04854568815262931612030147"},{"rnum":"04854568815262931612030148"},{"rnum":"04854568815262931612030149"},{"rnum":"04854568815262931612030150"},{"rnum":"04854568815262931612030151"},{"rnum":"04854568815262931612030152"},{"rnum":"04854568815262931612030153"},{"rnum":"04854568815262931612030154"},{"rnum":"04854568815262931612030155"},{"rnum":"04854568815262931612030156"},{"rnum":"04854568815262931612030157"},{"rnum":"04854568815262931612030158"},{"rnum":"04854568815262931612030159"},{"rnum":"04854568815262931612030160"},{"rnum":"04854568815262931612030161"},{"rnum":"04854568815262931612030162"},{"rnum":"04854568815262931612030163"},{"rnum":"04854568815262931612030164"},{"rnum":"04854568815262931612030165"},{"rnum":"04854568815262931612030166"},{"rnum":"04854568815262931612030167"},{"rnum":"04854568815262931612030168"},{"rnum":"04854568815262931612030169"},{"rnum":"04854568815262931612030170"},{"rnum":"04854568815262931612030171"},{"rnum":"04854568815262931612030172"},{"rnum":"04854568815262931612030173"},{"rnum":"04854568815262931612030174"},{"rnum":"04854568815262931612030175"},{"rnum":"04854568815262931612030176"},{"rnum":"04854568815262931612030177"},{"rnum":"04854568815262931612030178"},{"rnum":"04854568815262931612030179"},{"rnum":"04854568815262931612030180"},{"rnum":"04854568815262931612030181"},{"rnum":"04854568815262931612030182"},{"rnum":"04854568815262931612030183"},{"rnum":"04854568815262931612030184"},{"rnum":"04854568815262931612030185"},{"rnum":"04854568815262931612030186"},{"rnum":"04854568815262931612030187"},{"rnum":"04854568815262931612030188"},{"rnum":"04854568815262931612030189"},{"rnum":"04854568815262931612030190"},{"rnum":"04854568815262931612030191"},{"rnum":"04854568815262931612030192"},{"rnum":"04854568815262931612030193"},{"rnum":"04854568815262931612030194"},{"rnum":"04854568815262931612030195"},{"rnum":"04854568815262931612030196"},{"rnum":"04854568815262931612030197"},{"rnum":"04854568815262931612030198"},{"rnum":"04854568815262931612030199"},{"rnum":"04854568815262931612030200"},{"rnum":"04854568815262931612030201"},{"rnum":"04854568815262931612030202"},{"rnum":"04854568815262931612030203"},{"rnum":"04854568815262931612030204"},{"rnum":"04854568815262931612030205"},{"rnum":"04854568815262931612030206"},{"rnum":"04854568815262931612030207"},{"rnum":"04854568815262931612030208"},{"rnum":"04854568815262931612030209"},{"rnum":"04854568815262931612030210"},{"rnum":"04854568815262931612030211"},{"rnum":"04854568815262931612030212"},{"rnum":"04854568815262931612030213"},{"rnum":"04854568815262931612030214"},{"rnum":"04854568815262931612030215"},{"rnum":"04854568815262931612030216"},{"rnum":"04854568815262931612030217"},{"rnum":"04854568815262931612030218"},{"rnum":"04854568815262931612030219"},{"rnum":"04854568815262931612030220"},{"rnum":"04854568815262931612030221"},{"rnum":"04854568815262931612030222"},{"rnum":"04854568815262931612030223"},{"rnum":"04854568815262931612030224"},{"rnum":"04854568815262931612030225"},{"rnum":"04854568815262931612030226"},{"rnum":"04854568815262931612030227"},{"rnum":"04854568815262931612030228"},{"rnum":"04854568815262931612030229"},{"rnum":"04854568815262931612030230"},{"rnum":"04854568815262931612030231"},{"rnum":"04854568815262931612030232"},{"rnum":"04854568815262931612030233"},{"rnum":"04854568815262931612030234"},{"rnum":"04854568815262931612030235"},{"rnum":"04854568815262931612030236"},{"rnum":"04854568815262931612030237"},{"rnum":"04854568815262931612030238"},{"rnum":"04854568815262931612030239"},{"rnum":"04854568815262931612030240"},{"rnum":"04854568815262931612040001"},{"rnum":"04854568815262931612040002"},{"rnum":"04854568815262931612040003"},{"rnum":"04854568815262931612040004"},{"rnum":"04854568815262931612040005"},{"rnum":"04854568815262931612040006"},{"rnum":"04854568815262931612040007"},{"rnum":"04854568815262931612040008"},{"rnum":"04854568815262931612040009"},{"rnum":"04854568815262931612040010"},{"rnum":"04854568815262931612040011"},{"rnum":"04854568815262931612040012"},{"rnum":"04854568815262931612040013"},{"rnum":"04854568815262931612040014"},{"rnum":"04854568815262931612040015"},{"rnum":"04854568815262931612040016"},{"rnum":"04854568815262931612040017"},{"rnum":"04854568815262931612040018"},{"rnum":"04854568815262931612040019"},{"rnum":"04854568815262931612040020"},{"rnum":"04854568815262931612040021"},{"rnum":"04854568815262931612040022"},{"rnum":"04854568815262931612040023"},{"rnum":"04854568815262931612040024"},{"rnum":"04854568815262931612040025"},{"rnum":"04854568815262931612040026"},{"rnum":"04854568815262931612040027"},{"rnum":"04854568815262931612040028"},{"rnum":"04854568815262931612040029"},{"rnum":"04854568815262931612040030"},{"rnum":"04854568815262931612040031"},{"rnum":"04854568815262931612040032"},{"rnum":"04854568815262931612040033"},{"rnum":"04854568815262931612040034"},{"rnum":"04854568815262931612040035"},{"rnum":"04854568815262931612040036"},{"rnum":"04854568815262931612040037"},{"rnum":"04854568815262931612040038"},{"rnum":"04854568815262931612040039"},{"rnum":"04854568815262931612040040"},{"rnum":"04854568815262931612040041"},{"rnum":"04854568815262931612040042"},{"rnum":"04854568815262931612040043"},{"rnum":"04854568815262931612040044"},{"rnum":"04854568815262931612040045"},{"rnum":"04854568815262931612040046"},{"rnum":"04854568815262931612040047"},{"rnum":"04854568815262931612040048"},{"rnum":"04854568815262931612040049"},{"rnum":"04854568815262931612040050"},{"rnum":"04854568815262931612040051"},{"rnum":"04854568815262931612040052"},{"rnum":"04854568815262931612040053"},{"rnum":"04854568815262931612040054"},{"rnum":"04854568815262931612040055"},{"rnum":"04854568815262931612040056"},{"rnum":"04854568815262931612040057"},{"rnum":"04854568815262931612040058"},{"rnum":"04854568815262931612040059"},{"rnum":"04854568815262931612040060"},{"rnum":"04854568815262931612040061"},{"rnum":"04854568815262931612040062"},{"rnum":"04854568815262931612040063"},{"rnum":"04854568815262931612040064"},{"rnum":"04854568815262931612040065"},{"rnum":"04854568815262931612040066"},{"rnum":"04854568815262931612040067"},{"rnum":"04854568815262931612040068"},{"rnum":"04854568815262931612040069"},{"rnum":"04854568815262931612040070"},{"rnum":"04854568815262931612040071"},{"rnum":"04854568815262931612040072"},{"rnum":"04854568815262931612040073"},{"rnum":"04854568815262931612040074"},{"rnum":"04854568815262931612040075"},{"rnum":"04854568815262931612040076"},{"rnum":"04854568815262931612040077"},{"rnum":"04854568815262931612040078"},{"rnum":"04854568815262931612040079"},{"rnum":"04854568815262931612040080"},{"rnum":"04854568815262931612040081"},{"rnum":"04854568815262931612040082"},{"rnum":"04854568815262931612040083"},{"rnum":"04854568815262931612040084"},{"rnum":"04854568815262931612040085"},{"rnum":"04854568815262931612040086"},{"rnum":"04854568815262931612040087"},{"rnum":"04854568815262931612040088"},{"rnum":"04854568815262931612040089"},{"rnum":"04854568815262931612040090"},{"rnum":"04854568815262931612040091"},{"rnum":"04854568815262931612040092"},{"rnum":"04854568815262931612040093"},{"rnum":"04854568815262931612040094"},{"rnum":"04854568815262931612040095"},{"rnum":"04854568815262931612040096"},{"rnum":"04854568815262931612040097"},{"rnum":"04854568815262931612040098"},{"rnum":"04854568815262931612040099"},{"rnum":"04854568815262931612040100"},{"rnum":"04854568815262931612040101"},{"rnum":"04854568815262931612040102"},{"rnum":"04854568815262931612040103"},{"rnum":"04854568815262931612040104"},{"rnum":"04854568815262931612040105"},{"rnum":"04854568815262931612040106"},{"rnum":"04854568815262931612040107"},{"rnum":"04854568815262931612040108"},{"rnum":"04854568815262931612040109"},{"rnum":"04854568815262931612040110"},{"rnum":"04854568815262931612040111"},{"rnum":"04854568815262931612040112"},{"rnum":"04854568815262931612040113"},{"rnum":"04854568815262931612040114"},{"rnum":"04854568815262931612040115"},{"rnum":"04854568815262931612040116"},{"rnum":"04854568815262931612040117"},{"rnum":"04854568815262931612040118"},{"rnum":"04854568815262931612040119"},{"rnum":"04854568815262931612040120"},{"rnum":"04854568815262931612040121"},{"rnum":"04854568815262931612040122"},{"rnum":"04854568815262931612040123"},{"rnum":"04854568815262931612040124"},{"rnum":"04854568815262931612040125"},{"rnum":"04854568815262931612040126"},{"rnum":"04854568815262931612040127"},{"rnum":"04854568815262931612040128"},{"rnum":"04854568815262931612040129"},{"rnum":"04854568815262931612040130"},{"rnum":"04854568815262931612040131"},{"rnum":"04854568815262931612040132"},{"rnum":"04854568815262931612040133"},{"rnum":"04854568815262931612040134"},{"rnum":"04854568815262931612040135"},{"rnum":"04854568815262931612040136"},{"rnum":"04854568815262931612040137"},{"rnum":"04854568815262931612040138"},{"rnum":"04854568815262931612040139"},{"rnum":"04854568815262931612040140"},{"rnum":"04854568815262931612040141"},{"rnum":"04854568815262931612040142"},{"rnum":"04854568815262931612040143"},{"rnum":"04854568815262931612040144"},{"rnum":"04854568815262931612040145"},{"rnum":"04854568815262931612040146"},{"rnum":"04854568815262931612040147"},{"rnum":"04854568815262931612040148"},{"rnum":"04854568815262931612040149"},{"rnum":"04854568815262931612040150"},{"rnum":"04854568815262931612040151"},{"rnum":"04854568815262931612040152"},{"rnum":"04854568815262931612040153"},{"rnum":"04854568815262931612040154"},{"rnum":"04854568815262931612040155"},{"rnum":"04854568815262931612040156"},{"rnum":"04854568815262931612040157"},{"rnum":"04854568815262931612040158"},{"rnum":"04854568815262931612040159"},{"rnum":"04854568815262931612040160"},{"rnum":"04854568815262931612040161"},{"rnum":"04854568815262931612040162"},{"rnum":"04854568815262931612040163"},{"rnum":"04854568815262931612040164"},{"rnum":"04854568815262931612040165"},{"rnum":"04854568815262931612040166"},{"rnum":"04854568815262931612040167"},{"rnum":"04854568815262931612040168"},{"rnum":"04854568815262931612040169"},{"rnum":"04854568815262931612040170"},{"rnum":"04854568815262931612040171"},{"rnum":"04854568815262931612040172"},{"rnum":"04854568815262931612040173"},{"rnum":"04854568815262931612040174"},{"rnum":"04854568815262931612040175"},{"rnum":"04854568815262931612040176"},{"rnum":"04854568815262931612040177"},{"rnum":"04854568815262931612040178"},{"rnum":"04854568815262931612040179"},{"rnum":"04854568815262931612040180"},{"rnum":"04854568815262931612040181"},{"rnum":"04854568815262931612040182"},{"rnum":"04854568815262931612040183"},{"rnum":"04854568815262931612040184"},{"rnum":"04854568815262931612040185"},{"rnum":"04854568815262931612040186"},{"rnum":"04854568815262931612040187"},{"rnum":"04854568815262931612040188"},{"rnum":"04854568815262931612040189"},{"rnum":"04854568815262931612040190"},{"rnum":"04854568815262931612040191"},{"rnum":"04854568815262931612040192"},{"rnum":"04854568815262931612040193"},{"rnum":"04854568815262931612040194"},{"rnum":"04854568815262931612040195"},{"rnum":"04854568815262931612040196"},{"rnum":"04854568815262931612040197"},{"rnum":"04854568815262931612040198"},{"rnum":"04854568815262931612040199"},{"rnum":"04854568815262931612040200"},{"rnum":"04854568815262931612040201"},{"rnum":"04854568815262931612040202"},{"rnum":"04854568815262931612040203"},{"rnum":"04854568815262931612040204"},{"rnum":"04854568815262931612040205"},{"rnum":"04854568815262931612040206"},{"rnum":"04854568815262931612040207"},{"rnum":"04854568815262931612040208"},{"rnum":"04854568815262931612040209"},{"rnum":"04854568815262931612040210"},{"rnum":"04854568815262931612040211"},{"rnum":"04854568815262931612040212"},{"rnum":"04854568815262931612040213"},{"rnum":"04854568815262931612040214"},{"rnum":"04854568815262931612040215"},{"rnum":"04854568815262931612040216"},{"rnum":"04854568815262931612040217"},{"rnum":"04854568815262931612040218"},{"rnum":"04854568815262931612040219"},{"rnum":"04854568815262931612040220"},{"rnum":"04854568815262931612040221"},{"rnum":"04854568815262931612040222"},{"rnum":"04854568815262931612040223"},{"rnum":"04854568815262931612040224"},{"rnum":"04854568815262931612040225"},{"rnum":"04854568815262931612040226"},{"rnum":"04854568815262931612040227"},{"rnum":"04854568815262931612040228"},{"rnum":"04854568815262931612040229"},{"rnum":"04854568815262931612040230"},{"rnum":"04854568815262931612040231"},{"rnum":"04854568815262931612040232"},{"rnum":"04854568815262931612040233"},{"rnum":"04854568815262931612040234"},{"rnum":"04854568815262931612040235"},{"rnum":"04854568815262931612040236"},{"rnum":"04854568815262931612040237"},{"rnum":"04854568815262931612040238"},{"rnum":"04854568815262931612040239"},{"rnum":"04854568815262931612040240"},{"rnum":"04854568815262931612050001"},{"rnum":"04854568815262931612050002"},{"rnum":"04854568815262931612050003"},{"rnum":"04854568815262931612050004"},{"rnum":"04854568815262931612050005"},{"rnum":"04854568815262931612050006"},{"rnum":"04854568815262931612050007"},{"rnum":"04854568815262931612050008"},{"rnum":"04854568815262931612050009"},{"rnum":"04854568815262931612050010"},{"rnum":"04854568815262931612050011"},{"rnum":"04854568815262931612050012"},{"rnum":"04854568815262931612050013"},{"rnum":"04854568815262931612050014"},{"rnum":"04854568815262931612050015"},{"rnum":"04854568815262931612050016"},{"rnum":"04854568815262931612050017"},{"rnum":"04854568815262931612050018"},{"rnum":"04854568815262931612050019"},{"rnum":"04854568815262931612050020"},{"rnum":"04854568815262931612050021"},{"rnum":"04854568815262931612050022"},{"rnum":"04854568815262931612050023"},{"rnum":"04854568815262931612050024"},{"rnum":"04854568815262931612050025"},{"rnum":"04854568815262931612050026"},{"rnum":"04854568815262931612050027"},{"rnum":"04854568815262931612050028"},{"rnum":"04854568815262931612050029"},{"rnum":"04854568815262931612050030"},{"rnum":"04854568815262931612050031"},{"rnum":"04854568815262931612050032"},{"rnum":"04854568815262931612050033"},{"rnum":"04854568815262931612050034"},{"rnum":"04854568815262931612050035"},{"rnum":"04854568815262931612050036"},{"rnum":"04854568815262931612050037"},{"rnum":"04854568815262931612050038"},{"rnum":"04854568815262931612050039"},{"rnum":"04854568815262931612050040"},{"rnum":"04854568815262931612050041"},{"rnum":"04854568815262931612050042"},{"rnum":"04854568815262931612050043"},{"rnum":"04854568815262931612050044"},{"rnum":"04854568815262931612050045"},{"rnum":"04854568815262931612050046"},{"rnum":"04854568815262931612050047"},{"rnum":"04854568815262931612050048"},{"rnum":"04854568815262931612050049"},{"rnum":"04854568815262931612050050"},{"rnum":"04854568815262931612050051"},{"rnum":"04854568815262931612050052"},{"rnum":"04854568815262931612050053"},{"rnum":"04854568815262931612050054"},{"rnum":"04854568815262931612050055"},{"rnum":"04854568815262931612050056"},{"rnum":"04854568815262931612050057"},{"rnum":"04854568815262931612050058"},{"rnum":"04854568815262931612050059"},{"rnum":"04854568815262931612050060"},{"rnum":"04854568815262931612050061"},{"rnum":"04854568815262931612050062"},{"rnum":"04854568815262931612050063"},{"rnum":"04854568815262931612050064"},{"rnum":"04854568815262931612050065"},{"rnum":"04854568815262931612050066"},{"rnum":"04854568815262931612050067"},{"rnum":"04854568815262931612050068"},{"rnum":"04854568815262931612050069"},{"rnum":"04854568815262931612050070"},{"rnum":"04854568815262931612050071"},{"rnum":"04854568815262931612050072"},{"rnum":"04854568815262931612050073"},{"rnum":"04854568815262931612050074"},{"rnum":"04854568815262931612050075"},{"rnum":"04854568815262931612050076"},{"rnum":"04854568815262931612050077"},{"rnum":"04854568815262931612050078"},{"rnum":"04854568815262931612050079"},{"rnum":"04854568815262931612050080"},{"rnum":"04854568815262931612050081"},{"rnum":"04854568815262931612050082"},{"rnum":"04854568815262931612050083"},{"rnum":"04854568815262931612050084"},{"rnum":"04854568815262931612050085"},{"rnum":"04854568815262931612050086"},{"rnum":"04854568815262931612050087"},{"rnum":"04854568815262931612050088"},{"rnum":"04854568815262931612050089"},{"rnum":"04854568815262931612050090"},{"rnum":"04854568815262931612050091"},{"rnum":"04854568815262931612050092"},{"rnum":"04854568815262931612050093"},{"rnum":"04854568815262931612050094"},{"rnum":"04854568815262931612050095"},{"rnum":"04854568815262931612050096"},{"rnum":"04854568815262931612050097"},{"rnum":"04854568815262931612050098"},{"rnum":"04854568815262931612050099"},{"rnum":"04854568815262931612050100"},{"rnum":"04854568815262931612050101"},{"rnum":"04854568815262931612050102"},{"rnum":"04854568815262931612050103"},{"rnum":"04854568815262931612050104"},{"rnum":"04854568815262931612050105"},{"rnum":"04854568815262931612050106"},{"rnum":"04854568815262931612050107"},{"rnum":"04854568815262931612050108"},{"rnum":"04854568815262931612050109"},{"rnum":"04854568815262931612050110"},{"rnum":"04854568815262931612050111"},{"rnum":"04854568815262931612050112"},{"rnum":"04854568815262931612050113"},{"rnum":"04854568815262931612050114"},{"rnum":"04854568815262931612050115"},{"rnum":"04854568815262931612050116"},{"rnum":"04854568815262931612050117"},{"rnum":"04854568815262931612050118"},{"rnum":"04854568815262931612050119"},{"rnum":"04854568815262931612050120"},{"rnum":"04854568815262931612050121"},{"rnum":"04854568815262931612050122"},{"rnum":"04854568815262931612050123"},{"rnum":"04854568815262931612050124"},{"rnum":"04854568815262931612050125"},{"rnum":"04854568815262931612050126"},{"rnum":"04854568815262931612050127"},{"rnum":"04854568815262931612050128"},{"rnum":"04854568815262931612050129"},{"rnum":"04854568815262931612050130"},{"rnum":"04854568815262931612050131"},{"rnum":"04854568815262931612050132"},{"rnum":"04854568815262931612050133"},{"rnum":"04854568815262931612050134"},{"rnum":"04854568815262931612050135"},{"rnum":"04854568815262931612050136"},{"rnum":"04854568815262931612050137"},{"rnum":"04854568815262931612050138"},{"rnum":"04854568815262931612050139"},{"rnum":"04854568815262931612050140"},{"rnum":"04854568815262931612050141"},{"rnum":"04854568815262931612050142"},{"rnum":"04854568815262931612050143"},{"rnum":"04854568815262931612050144"},{"rnum":"04854568815262931612050145"},{"rnum":"04854568815262931612050146"},{"rnum":"04854568815262931612050147"},{"rnum":"04854568815262931612050148"},{"rnum":"04854568815262931612050149"},{"rnum":"04854568815262931612050150"},{"rnum":"04854568815262931612050151"},{"rnum":"04854568815262931612050152"},{"rnum":"04854568815262931612050153"},{"rnum":"04854568815262931612050154"},{"rnum":"04854568815262931612050155"},{"rnum":"04854568815262931612050156"},{"rnum":"04854568815262931612050157"},{"rnum":"04854568815262931612050158"},{"rnum":"04854568815262931612050159"},{"rnum":"04854568815262931612050160"},{"rnum":"04854568815262931612050161"},{"rnum":"04854568815262931612050162"},{"rnum":"04854568815262931612050163"},{"rnum":"04854568815262931612050164"},{"rnum":"04854568815262931612050165"},{"rnum":"04854568815262931612050166"},{"rnum":"04854568815262931612050167"},{"rnum":"04854568815262931612050168"},{"rnum":"04854568815262931612050169"},{"rnum":"04854568815262931612050170"},{"rnum":"04854568815262931612050171"},{"rnum":"04854568815262931612050172"},{"rnum":"04854568815262931612050173"},{"rnum":"04854568815262931612050174"},{"rnum":"04854568815262931612050175"},{"rnum":"04854568815262931612050176"},{"rnum":"04854568815262931612050177"},{"rnum":"04854568815262931612050178"},{"rnum":"04854568815262931612050179"},{"rnum":"04854568815262931612050180"},{"rnum":"04854568815262931612050181"},{"rnum":"04854568815262931612050182"},{"rnum":"04854568815262931612050183"},{"rnum":"04854568815262931612050184"},{"rnum":"04854568815262931612050185"},{"rnum":"04854568815262931612050186"},{"rnum":"04854568815262931612050187"},{"rnum":"04854568815262931612050188"},{"rnum":"04854568815262931612050189"},{"rnum":"04854568815262931612050190"},{"rnum":"04854568815262931612050191"},{"rnum":"04854568815262931612050192"},{"rnum":"04854568815262931612050193"},{"rnum":"04854568815262931612050194"},{"rnum":"04854568815262931612050195"},{"rnum":"04854568815262931612050196"},{"rnum":"04854568815262931612050197"},{"rnum":"04854568815262931612050198"},{"rnum":"04854568815262931612050199"},{"rnum":"04854568815262931612050200"},{"rnum":"04854568815262931612050201"},{"rnum":"04854568815262931612050202"},{"rnum":"04854568815262931612050203"},{"rnum":"04854568815262931612050204"},{"rnum":"04854568815262931612050205"},{"rnum":"04854568815262931612050206"},{"rnum":"04854568815262931612050207"},{"rnum":"04854568815262931612050208"},{"rnum":"04854568815262931612050209"},{"rnum":"04854568815262931612050210"},{"rnum":"04854568815262931612050211"},{"rnum":"04854568815262931612050212"},{"rnum":"04854568815262931612050213"},{"rnum":"04854568815262931612050214"},{"rnum":"04854568815262931612050215"},{"rnum":"04854568815262931612050216"},{"rnum":"04854568815262931612050217"},{"rnum":"04854568815262931612050218"},{"rnum":"04854568815262931612050219"},{"rnum":"04854568815262931612050220"},{"rnum":"04854568815262931612050221"},{"rnum":"04854568815262931612050222"},{"rnum":"04854568815262931612050223"},{"rnum":"04854568815262931612050224"},{"rnum":"04854568815262931612050225"},{"rnum":"04854568815262931612050226"},{"rnum":"04854568815262931612050227"},{"rnum":"04854568815262931612050228"},{"rnum":"04854568815262931612050229"},{"rnum":"04854568815262931612050230"},{"rnum":"04854568815262931612050231"},{"rnum":"04854568815262931612050232"},{"rnum":"04854568815262931612050233"},{"rnum":"04854568815262931612050234"},{"rnum":"04854568815262931612050235"},{"rnum":"04854568815262931612050236"},{"rnum":"04854568815262931612050237"},{"rnum":"04854568815262931612050238"},{"rnum":"04854568815262931612050239"},{"rnum":"04854568815262931612050240"},{"rnum":"04854568815262931612060001"},{"rnum":"04854568815262931612060002"},{"rnum":"04854568815262931612060003"},{"rnum":"04854568815262931612060004"},{"rnum":"04854568815262931612060005"},{"rnum":"04854568815262931612060006"},{"rnum":"04854568815262931612060007"},{"rnum":"04854568815262931612060008"},{"rnum":"04854568815262931612060009"},{"rnum":"04854568815262931612060010"},{"rnum":"04854568815262931612060011"},{"rnum":"04854568815262931612060012"},{"rnum":"04854568815262931612060013"},{"rnum":"04854568815262931612060014"},{"rnum":"04854568815262931612060015"},{"rnum":"04854568815262931612060016"},{"rnum":"04854568815262931612060017"},{"rnum":"04854568815262931612060018"},{"rnum":"04854568815262931612060019"},{"rnum":"04854568815262931612060020"},{"rnum":"04854568815262931612060021"},{"rnum":"04854568815262931612060022"},{"rnum":"04854568815262931612060023"},{"rnum":"04854568815262931612060024"},{"rnum":"04854568815262931612060025"},{"rnum":"04854568815262931612060026"},{"rnum":"04854568815262931612060027"},{"rnum":"04854568815262931612060028"},{"rnum":"04854568815262931612060029"},{"rnum":"04854568815262931612060030"},{"rnum":"04854568815262931612060031"},{"rnum":"04854568815262931612060032"},{"rnum":"04854568815262931612060033"},{"rnum":"04854568815262931612060034"},{"rnum":"04854568815262931612060035"},{"rnum":"04854568815262931612060036"},{"rnum":"04854568815262931612060037"},{"rnum":"04854568815262931612060038"},{"rnum":"04854568815262931612060039"},{"rnum":"04854568815262931612060040"},{"rnum":"04854568815262931612060041"},{"rnum":"04854568815262931612060042"},{"rnum":"04854568815262931612060043"},{"rnum":"04854568815262931612060044"},{"rnum":"04854568815262931612060045"},{"rnum":"04854568815262931612060046"},{"rnum":"04854568815262931612060047"},{"rnum":"04854568815262931612060048"},{"rnum":"04854568815262931612060049"},{"rnum":"04854568815262931612060050"},{"rnum":"04854568815262931612060051"},{"rnum":"04854568815262931612060052"},{"rnum":"04854568815262931612060053"},{"rnum":"04854568815262931612060054"},{"rnum":"04854568815262931612060055"},{"rnum":"04854568815262931612060056"},{"rnum":"04854568815262931612060057"},{"rnum":"04854568815262931612060058"},{"rnum":"04854568815262931612060059"},{"rnum":"04854568815262931612060060"},{"rnum":"04854568815262931612060061"},{"rnum":"04854568815262931612060062"},{"rnum":"04854568815262931612060063"},{"rnum":"04854568815262931612060064"},{"rnum":"04854568815262931612060065"},{"rnum":"04854568815262931612060066"},{"rnum":"04854568815262931612060067"},{"rnum":"04854568815262931612060068"},{"rnum":"04854568815262931612060069"},{"rnum":"04854568815262931612060070"},{"rnum":"04854568815262931612060071"},{"rnum":"04854568815262931612060072"},{"rnum":"04854568815262931612060073"},{"rnum":"04854568815262931612060074"},{"rnum":"04854568815262931612060075"},{"rnum":"04854568815262931612060076"},{"rnum":"04854568815262931612060077"},{"rnum":"04854568815262931612060078"},{"rnum":"04854568815262931612060079"},{"rnum":"04854568815262931612060080"},{"rnum":"04854568815262931612060081"},{"rnum":"04854568815262931612060082"},{"rnum":"04854568815262931612060083"},{"rnum":"04854568815262931612060084"},{"rnum":"04854568815262931612060085"},{"rnum":"04854568815262931612060086"},{"rnum":"04854568815262931612060087"},{"rnum":"04854568815262931612060088"},{"rnum":"04854568815262931612060089"},{"rnum":"04854568815262931612060090"},{"rnum":"04854568815262931612060091"},{"rnum":"04854568815262931612060092"},{"rnum":"04854568815262931612060093"},{"rnum":"04854568815262931612060094"},{"rnum":"04854568815262931612060095"},{"rnum":"04854568815262931612060096"},{"rnum":"04854568815262931612060097"},{"rnum":"04854568815262931612060098"},{"rnum":"04854568815262931612060099"},{"rnum":"04854568815262931612060100"},{"rnum":"04854568815262931612060101"},{"rnum":"04854568815262931612060102"},{"rnum":"04854568815262931612060103"},{"rnum":"04854568815262931612060104"},{"rnum":"04854568815262931612060105"},{"rnum":"04854568815262931612060106"},{"rnum":"04854568815262931612060107"},{"rnum":"04854568815262931612060108"},{"rnum":"04854568815262931612060109"},{"rnum":"04854568815262931612060110"},{"rnum":"04854568815262931612060111"},{"rnum":"04854568815262931612060112"},{"rnum":"04854568815262931612060113"},{"rnum":"04854568815262931612060114"},{"rnum":"04854568815262931612060115"},{"rnum":"04854568815262931612060116"},{"rnum":"04854568815262931612060117"},{"rnum":"04854568815262931612060118"},{"rnum":"04854568815262931612060119"},{"rnum":"04854568815262931612060120"},{"rnum":"04854568815262931612060121"},{"rnum":"04854568815262931612060122"},{"rnum":"04854568815262931612060123"},{"rnum":"04854568815262931612060124"},{"rnum":"04854568815262931612060125"},{"rnum":"04854568815262931612060126"},{"rnum":"04854568815262931612060127"},{"rnum":"04854568815262931612060128"},{"rnum":"04854568815262931612060129"},{"rnum":"04854568815262931612060130"},{"rnum":"04854568815262931612060131"},{"rnum":"04854568815262931612060132"},{"rnum":"04854568815262931612060133"},{"rnum":"04854568815262931612060134"},{"rnum":"04854568815262931612060135"},{"rnum":"04854568815262931612060136"},{"rnum":"04854568815262931612060137"},{"rnum":"04854568815262931612060138"},{"rnum":"04854568815262931612060139"},{"rnum":"04854568815262931612060140"},{"rnum":"04854568815262931612060141"},{"rnum":"04854568815262931612060142"},{"rnum":"04854568815262931612060143"},{"rnum":"04854568815262931612060144"},{"rnum":"04854568815262931612060145"},{"rnum":"04854568815262931612060146"},{"rnum":"04854568815262931612060147"},{"rnum":"04854568815262931612060148"},{"rnum":"04854568815262931612060149"},{"rnum":"04854568815262931612060150"},{"rnum":"04854568815262931612060151"},{"rnum":"04854568815262931612060152"},{"rnum":"04854568815262931612060153"},{"rnum":"04854568815262931612060154"},{"rnum":"04854568815262931612060155"},{"rnum":"04854568815262931612060156"},{"rnum":"04854568815262931612060157"},{"rnum":"04854568815262931612060158"},{"rnum":"04854568815262931612060159"},{"rnum":"04854568815262931612060160"},{"rnum":"04854568815262931612060161"},{"rnum":"04854568815262931612060162"},{"rnum":"04854568815262931612060163"},{"rnum":"04854568815262931612060164"},{"rnum":"04854568815262931612060165"},{"rnum":"04854568815262931612060166"},{"rnum":"04854568815262931612060167"},{"rnum":"04854568815262931612060168"},{"rnum":"04854568815262931612060169"},{"rnum":"04854568815262931612060170"},{"rnum":"04854568815262931612060171"},{"rnum":"04854568815262931612060172"},{"rnum":"04854568815262931612060173"},{"rnum":"04854568815262931612060174"},{"rnum":"04854568815262931612060175"},{"rnum":"04854568815262931612060176"},{"rnum":"04854568815262931612060177"},{"rnum":"04854568815262931612060178"},{"rnum":"04854568815262931612060179"},{"rnum":"04854568815262931612060180"},{"rnum":"04854568815262931612060181"},{"rnum":"04854568815262931612060182"},{"rnum":"04854568815262931612060183"},{"rnum":"04854568815262931612060184"},{"rnum":"04854568815262931612060185"},{"rnum":"04854568815262931612060186"},{"rnum":"04854568815262931612060187"},{"rnum":"04854568815262931612060188"},{"rnum":"04854568815262931612060189"},{"rnum":"04854568815262931612060190"},{"rnum":"04854568815262931612060191"},{"rnum":"04854568815262931612060192"},{"rnum":"04854568815262931612060193"},{"rnum":"04854568815262931612060194"},{"rnum":"04854568815262931612060195"},{"rnum":"04854568815262931612060196"},{"rnum":"04854568815262931612060197"},{"rnum":"04854568815262931612060198"},{"rnum":"04854568815262931612060199"},{"rnum":"04854568815262931612060200"},{"rnum":"04854568815262931612060201"},{"rnum":"04854568815262931612060202"},{"rnum":"04854568815262931612060203"},{"rnum":"04854568815262931612060204"},{"rnum":"04854568815262931612060205"},{"rnum":"04854568815262931612060206"},{"rnum":"04854568815262931612060207"},{"rnum":"04854568815262931612060208"},{"rnum":"04854568815262931612060209"},{"rnum":"04854568815262931612060210"},{"rnum":"04854568815262931612060211"},{"rnum":"04854568815262931612060212"},{"rnum":"04854568815262931612060213"},{"rnum":"04854568815262931612060214"},{"rnum":"04854568815262931612060215"},{"rnum":"04854568815262931612060216"},{"rnum":"04854568815262931612060217"},{"rnum":"04854568815262931612060218"},{"rnum":"04854568815262931612060219"},{"rnum":"04854568815262931612060220"},{"rnum":"04854568815262931612060221"},{"rnum":"04854568815262931612060222"},{"rnum":"04854568815262931612060223"},{"rnum":"04854568815262931612060224"},{"rnum":"04854568815262931612060225"},{"rnum":"04854568815262931612060226"},{"rnum":"04854568815262931612060227"},{"rnum":"04854568815262931612060228"},{"rnum":"04854568815262931612060229"},{"rnum":"04854568815262931612060230"},{"rnum":"04854568815262931612060231"},{"rnum":"04854568815262931612060232"},{"rnum":"04854568815262931612060233"},{"rnum":"04854568815262931612060234"},{"rnum":"04854568815262931612060235"},{"rnum":"04854568815262931612060236"},{"rnum":"04854568815262931612060237"},{"rnum":"04854568815262931612060238"},{"rnum":"04854568815262931612060239"},{"rnum":"04854568815262931612060240"}]';
			}
			var params={
				'simulatortime' : simulatortime,
				'rectype' : rectype,
				'stunum' : stunum,
				'subject' : subject,
				'examresult' : result,
				'duration' : totaltime,
				'totaltime' : totaltime,
				'networktime' : networktime,
				'inscode' : insCode,
				'recarray' : xzxzx,
				'vehicletime' : vehicletime,
				'classtime' : classtime,
				'mileage' : mileage
			};
			
			/*
			if(subject==4){
				/* params={
					'simulatortime' : '0',
					'rectype' : '5',
					'stunum' : stunum,
					'subject' : subject,
					'examresult' : '1',
					'duration' : totaltime,
					'totaltime' : totaltime,
					'networktime' : '400',
					'inscode' : insCode,
					'recarray' : '[{"rnum":"649441198228405600015"},{"rnum":"649441198228405600016"},{"rnum":"649441198228405600017"},{"rnum":"649441198228405600018"}]',
					'vehicletime' : vehicletime,
					'classtime' : '200',
					'mileage' : '0'
				}; */
				/*
				params={
					'simulatortime' : '0',
					'rectype' : '4',
					'stunum' : stunum,
					'subject' : subject,
					'examresult' : '1',
					'duration' : '960',
					'totaltime' : '960',
					'networktime' : '0',
					'inscode' : insCode,
					'recarray' : '[{"rnum":"649441198228405600015"},{"rnum":"649441198228405600016"},{"rnum":"649441198228405600017"},{"rnum":"649441198228405600018"}]',
					'vehicletime' : '0',
					'classtime' : '960',
					'mileage' : '0'
				};
			}*/
			
			console.log(params);
			var examresult=null;
			if(result==0){
				examresult="未考核";
			}else if(result==1){
				examresult="合格";
			}else if(result==2){
				examresult="不合格";
			}
			formData.append("result",examresult);
			formData.append("judge",$("#editorModal input[name='judge']").val());
			formData.append("imgStr",$("#imgStr").val());
			$.ajax({
				url:'http://upload.91ygxc.com/PDFUpload',
				type:'post',
                data:formData,
                async: false,  
          		cache: false,
                processData:false,
                contentType:false,
                success:function(data){
                	console.log(data);
                	var jsonObj=eval("(" + data + ")");
                    var pdfUpload={
                    	'type':'epdfimg',
                    	'url':jsonObj.data.url,
                    	'level':'2'
                    };
                    $.post(recordUrl+'/upload/file/url',pdfUpload,function(result){
						params.esignature=sign(JSON.stringify(params));
						params.pdfid=result.data.id;
						stage(params);
					});
                }
			})
		}
		
		
		
		function stage(params){
			$.post(recordUrl+'/province/stagetrainningtime',params,function(result){
				$("#primary").attr("disabled", false);
				if(result.errorcode==0){
					$.post('${ctx}/teachLog/addTimeRecord',params,function(results){
						layer.alert("上报成功！");
						buildDataTable();
						$('#editorModal').modal('hide');
					})
				}else{
					layer.alert(result.message);
				}
				console.log(result);
			});
		}
		
		//加签
		function sign(data){
			//var datas = '{"simulatortime":null,"rectype":"2","stunum":"6161758136324302","subject":"1","examresult":"0","duration":"60","totaltime":"60","networktime":null,"inscode":"5851633716061642","recarray":[{"rnum":"616175813632430200001"},{"rnum":"616175813632430200001"}],"vehicletime":null,"classtime":"60","mileage":null}';
			var obj = window.document.getElementById("ocx");
			data = data.replace(/[\\\/\b\f\n\r\t]/g, '');
			data = data.replace('"[', '[');
			data = data.replace(']"', ']');
			console.log("data:"+data);
			var signInfo = obj.sign(data);
			var signInfoList = signInfo.toArray();
			var signature, signerCert,
			signature = signInfoList[0];
			console.log("signature:"+signature);
		    signerCert = signInfoList[1];
		    return signature;
		}
		
		function getFun(type){
			var id = sessionStorage.getItem('tabId');
			if(id === null || id === undefined){
				layer.alert('未选择目标');
				return false;
			}
			$.get('${ctx}/teachLog/getTimeRecord?id='+id+'&subject='+type,function(result){
				if(type==5){
					$("#biye input[name='name']").val(result.data.name);
					$("#biye input[name='stunum']").val(result.data.stunum);
					$("#biye input[name='autinscode']").val(insCode);
					$("#biye input[name='traintype']").val(result.data.Traintype);
					$("#biye input[name='time']").val(result.data.CreateTime);
					$("#biye input[name='photo']").val(result.data.photo);
					if(result.data.sex==1){		//性别
						$("#biye input[name='sex']").val("男");
					}else if(result.data.sex==2){
						$("#biye input[name='sex']").val("女");
					}
					$('#biye').modal('show');
					return;
				}
				clean();
				$("#editorModal input[name='name']").val(result.data.name);
				$("#editorModal input[name='stunum']").val(result.data.stunum);
				if(result.data.sex==1){		//性别
					$("#editorModal input[name='sex']").val("男");
				}else if(result.data.sex==2){
					$("#editorModal input[name='sex']").val("女");
				}
				$("#editorModal input[name='photo']").val(result.data.photo);
				$("#editorModal input[name='time']").val(result.data.CreateTime);
				if(result.data.Cradtype==1){	//证件类型
					$("#editorModal input[name='cardType']").val("身份证");
				}else if(result.data.Cradtype==2){
					$("#editorModal input[name='cardType']").val("护照");
				}else if(result.data.Cradtype==3){
					$("#editorModal input[name='cardType']").val("军官证");
				}else if(result.data.Cradtype==4){
					$("#editorModal input[name='cardType']").val("其他");
				}
				$("#editorModal input[name='address']").val(result.data.address);
				$("#editorModal input[name='mobile']").val(result.data.mobile);
				$("#editorModal input[name='idcard']").val(result.data.idcard);
				$("#editorModal input[name='traintype']").val(result.data.Traintype);	//学习车型
				$("#editorModal input[name='subject']").val(type);
				$("#editorModal input[name='idcard']").val(result.data.idcard);
				/*
				*	选取培训部分学时,vehicletime、simulatortime 1、4部分为0，classtime，networktime 2、3部分为0，mileage 非3为0，duration暂时与totaltime保持一致
				*/
				if(type==1){
					$("#editorModal input[name='totaltime']").val(result.data.part1);
					$("#editorModal input[name='classtime']").val(result.data.part1);
					$("#editorModal input[name='duration']").val(result.data.part1);
					$("#editorModal input[name='mileage']").val(result.data.mpart1);
					
					$("#editorModal input[name='ruletotaltime']").val('720');
					$("#editorModal input[name='rulemileage']").val('0');
					
				}else if(type==2){
					$("#editorModal input[name='totaltime']").val(result.data.part2);
					$("#editorModal input[name='vehicletime']").val(result.data.part2);
					$("#editorModal input[name='duration']").val(result.data.part2);
					$("#editorModal input[name='mileage']").val(result.data.mpart2);

					$("#editorModal input[name='totaltime']").val('960');
					$("#editorModal input[name='vehicletime']").val('960');
					$("#editorModal input[name='mileage']").val('0');
					$("#editorModal input[name='duration']").val('960');					
					
					$("#editorModal input[name='ruletotaltime']").val('960');
					$("#editorModal input[name='rulemileage']").val('0');
					
				}else if(type==3){
					//$("#editorModal input[name='totaltime']").val(result.data.part3);
					//$("#editorModal input[name='vehicletime']").val(result.data.part3);
					//$("#editorModal input[name='mileage']").val(result.data.mpart3);
					//$("#editorModal input[name='duration']").val(result.data.part3);
					
					$("#editorModal input[name='totaltime']").val('1440');
					$("#editorModal input[name='vehicletime']").val('1440');
					$("#editorModal input[name='mileage']").val('300');
					$("#editorModal input[name='duration']").val('1440');					

					$("#editorModal input[name='ruletotaltime']").val('1440');
					$("#editorModal input[name='rulemileage']").val('300');
					

					
				}else if(type==4){
					$("#editorModal input[name='totaltime']").val(result.data.part4);
					$("#editorModal input[name='classtime']").val(result.data.part4);
					$("#editorModal input[name='duration']").val(result.data.part4);
					$("#editorModal input[name='mileage']").val('0');

					$("#editorModal input[name='ruletotaltime']").val('600');
					$("#editorModal input[name='rulemileage']").val('0');
				}
				var stunum=result.data.stunum;
				var arr = [];
				for(var i=0; i<result.datas.length; i++){
					if(type==3||type==2){
						arr.push(result.datas[i].recordCode);
					}else{
						arr.push(stunum+""+result.datas[i].eTrainingLogCode);
					}
				}
				$("#editorModal textarea[name='recarray']").val(arr.toString());
			});
			if(type!=5){
				$('#editorModal').modal('show');
			}
		}
		
		function clean(){
			$("#editorModal input[name='name']").val("");
			$("#editorModal input[name='stunum']").val("");
			$("#editorModal input[name='sex']").val("");
			$("#editorModal input[name='photo']").val("");
			$("#editorModal input[name='time']").val("");
			$("#editorModal input[name='cardType']").val("");
			$("#editorModal input[name='address']").val("");
			$("#editorModal input[name='mobile']").val('');
			$("#editorModal input[name='idcard']").val('');
			$("#editorModal input[name='traintype']").val('');	//学习车型
			$("#editorModal input[name='subject']").val('');
			$("#editorModal input[name='idcard']").val('');
			$("#editorModal input[name='totaltime']").val('0');
			$("#editorModal input[name='classtime']").val('0');
			$("#editorModal input[name='duration']").val('0');
			$("#editorModal input[name='vehicletime']").val('0');
			$("#editorModal input[name='networktime']").val('0');
			$("#editorModal input[name='mileage']").val('0');
			$("#editorModal textarea[name='recarray']").val('');
		}
	</script>
</body>
</html>