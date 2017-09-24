<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-班型管理</title>
</head>
<body>
	<div class="container-fluid new-admin">
		<div class="select-top">
		<sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
			<a class="select-btn" onclick="getFun(1)"><span class="add"></span>新增</a>
			<a class="select-btn" onclick="getFun(2)"><span class="edit" ></span>修改</a>
			<a class="select-btn " onclick="getFun(3)"><span class="del"></span>删除</a>
			<a class="select-btn" onclick="getFun(4)"><span class="spare"></span>上传备案</a>
		</sec:authorize>
		
		<sec:authorize access="hasRole('ROLE_SCHOOL_SERVICE')">
			<sec:authorize access="hasRole('ROLE_UserOperation_99')">
				<a class="select-btn" onclick="getFun(1)"><span class="add"></span>新增</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_100')">
				<a class="select-btn" onclick="getFun(2)"><span class="edit" ></span>修改</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_101')">
				<a class="select-btn " onclick="getFun(3)"><span class="del"></span>删除</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_102')">
				<a class="select-btn" onclick="getFun(4)"><span class="spare"></span>上传备案</a>
			</sec:authorize>
		</sec:authorize>
		</div>
	</div>
	
	<div class="row-fluid">
		<div class="sub_content">
			<!-- 图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改 -->
			<div id="table_list" class="gri_wrapper"></div>
		</div>
	</div>

	<!-- Modal 弹出的编辑界面-->
	<div class="modal fade colsform" id="editorModal" tabindex="-1" role="dialog" aria-hidden="true" style="width: 740px; margin-left:-370px">	
		<form class="form-horizontal valid-form">
			<h4>班型</h4>
			<div class="modal-content">
				<div class="left" style="width: 100%;">
					<div class="row1">
						
						<div class="form-controll">
							<label>班型名称 :</label>
							<input type="text" name="classcurr" datatype="*" nullmsg="班型名称不能为空" sucmsg=" ">
						</div>
						<div class="form-controll">
							<label>金额 :</label>
							<input type="text" name="price" placeholder="(总价/小时单价)" datatype="*" nullmsg="金额不能为空" sucmsg=" ">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>课时限制 :</label>
							<select id="resRegular" name="resRegular" datatype="*" nullmsg="课时限制 不能为空" sucmsg=" ">
										<option value='1'>1课时/周</option>
										<option value='2'>2课时/周</option>
										<option value='3'>3课时/周</option>
										<option value='4'>4课时/周</option>
										<option value='5'>5课时/周</option>
										<option value='6'>学完一节约下一节,不限课时</option>
									</select>
						</div>
						<div class="form-controll">
							<label>服务内容:</label>
							<input type="text" name="service">
						</div>
					</div>
					<div class="row1">
					<div class="form-controll" style="width: 630px;">
							<label height:40px;'>培训车型 :</label>
									<input type="radio"
									name="vehicletype" value="A1" datatype="*" nullmsg="培训车型 不能为空" sucmsg=" " style="margin: 0 3px 0 0;">
									A1<span style="padding-right: 5px;"><input
									type="radio" name="vehicletype" value="A2"
									style="margin: 0 3px 0 0;"> A2</span> <span
									style="padding-right: 5px;"><input type="radio"
									name="vehicletype" value="A3" style="margin: 0 3px 0 0;">
									A3</span> <span style="padding-right: 5px;"><input
									type="radio" name="vehicletype" value="B1"
									style="margin: 0 3px 0 0;"> B1</span> <span
									style="padding-right: 5px;"><input type="radio"
									name="vehicletype" value="B2" style="margin: 0 3px 0 0;">
									B2</span><span
									style="padding-right: 5px;"><input type="radio"
									name="vehicletype" value="C1" style="margin: 0 3px 0 0;">
									C1</span> <span style="padding-right: 5px;"><input
									type="radio" name="vehicletype" value="C2"
									style="margin: 0 3px 0 0;"> C2</span> <span
									style="padding-right: 5px;"><input type="radio"
									name="vehicletype" value="C3" style="margin: 0 3px 0 0;">
									C3</span> <span style="padding-right: 5px;"><input
									type="radio" name="vehicletype" value="C4"
									style="margin: 0 3px 0 0;"> C4</span> <span
									style="padding-right: 5px;"><input type="radio"
									name="vehicletype" value="C5" style="margin: 0 3px 0 0;">
									C5</span> <span style="padding-right: 5px;"><input
									type="radio" name="vehicletype" value="D"
									style="margin: 0 3px 0 0;"> D</span> <span
									style="padding-right: 5px;"><input type="radio"
									name="vehicletype" value="E" style="margin: 0 3px 0 0;">
									E</span><br><span style="padding-right: 5px;"><input
									type="radio" name="vehicletype" value="F"
									style="margin: 0 3px 0 0;"> F</span> <span
									style="padding-right: 5px;"><input type="radio"
									name="vehicletype" value="M" style="margin: 0 3px 0 0;">
									M</span> <span style="padding-right: 5px;"><input
									type="radio" name="vehicletype" value="N"
									style="margin: 0 3px 0 0;"> N</span> <span
									style="padding-right: 5px;"><input type="radio"
									name="vehicletype" value="P" style="margin: 0 3px 0 0;">
									P</span>
						</div>
					</div>
					<div class="row1">	
						<div class="form-controll">
							<label>培训模式:</label>
							<span style="padding-right: 5px;"><input type="radio" name="trainningmode" value="1" style="margin:0 2px 0 0;">定时培训</span>
							<span style="padding-right: 5px;"><input type="radio" name="trainningmode" value="2" style="margin:0 2px 0 0;">预约培训</span>
							<span><input type="radio" name="trainningmode" value="9" style="margin:0 2px 0 0;">其他</span>
						</div>
						<div class="form-controll" style="width: 348px; margin-right: 0;">
					        <label>培训时段:</label>
							<span style="padding-right:5px;"><input type="radio" name="trainningtime" value="1" style="margin:0 2px 0 0;">普通时段</span>
							<span style="padding-right:5px;"><input type="radio" name="trainningtime" value="2" style="margin:0 2px 0 0;">高峰时段</span>
							<span><input type="radio" name="trainningtime" value="3" style="margin:0 2px 0 0;">节假日时段</span>
					     </div>
					</div>
					<div class="row1">
					<div class="form-controll">
							<label>收费模式:</label>
							<span style="padding-right:5px;"><input type="radio" name="chargemode" value="1" style="margin:0 2px 0 0;">一次性收费</span>
							<span style="padding-right:5px;"><input type="radio" name="chargemode" value="2" style="margin:0 2px 0 0;">计时收费</span>
							<span><input type="radio" name="chargemode" value="9" style="margin:0 2px 0 0;">其他</span>
						</div>
						<div class="form-controll">
							<label>付费模式:</label>
							<select name="paymode" datatype="*" nullmsg="付费模式 不能为空" sucmsg=" ">
								<option value="">请选择付费模式</option>
								<option value="3">计时班-先学后付</option>
								<option value="2">计时班-先付后学</option>
								<option value="1">传统班-其他</option>
							</select>
							<!-- <span style="padding-right:5px;"><input type="radio" name="paymode" value="3" style="margin:0 2px 0 0;">先学后付</span>
							<span style="padding-right:5px;"><input type="radio" name="paymode" value="2" style="margin:0 2px 0 0;">先付后学</span>
							<span><input type="radio" name="paymode" value="1" style="margin:0 2px 0 0;">其他</span> -->
						</div>
					</div>
					<div style="height:70px;">
							<label style="float: left;width: 110px;text-align: right;margin-right: 5px;height:70px;">培训部分及方式:</label>
							<span style="width:150px;display: inline-block; margin-bottom: 5px;"><input type="radio" name="subject" value="1" style="margin:0 2px 0 0;">第一部分集中教学</span>
							<span style="width:150px;display: inline-block; margin-bottom: 5px;"><input type="radio" name="subject"value="2" style="margin:0 2px 0 0;">第一部分网络教学</span>
							<span style="display: inline-block; margin-bottom: 5px;"><input type="radio" name="subject" value="3" style="margin:0 2px 0 0;">第四部分集中教学</span>
													    <br>
							<span style="width:150px;display: inline-block; margin-bottom: 5px;"><input type="radio" name="subject" value="4" style="margin:0 2px 0 0;">第四部分网络教学</span>
							<span style="width:150px;display: inline-block; margin-bottom: 5px;"><input type="radio" name="subject"  value="5" style="margin:0 2px 0 0;">模拟器教学</span>
							<span style="display: inline-block; margin-bottom: 5px;"><input type="radio" name="subject"  value="6" style="margin:0 2px 0 0;">第二部分普通教学</span>
													    <br>
							<span style="width:150px;display: inline-block;"><input type="radio" name="subject"  value="7" style="margin:0 2px 0 0;">第二部分智能教学</span>
							<span style="width:150px;display: inline-block;"><input type="radio" name="subject"  value="8" style="margin:0 2px 0 0;">第三部分普通教学</span>
							<span style="display: inline-block;"><input type="radio" name="subject"  value="9" style="margin:0 2px 0 0;">第三部分智能教学</span>				
					</div>
					<div class="row1">
						<div class="form-controll wid90" style="margin-right: 0;">
							<label>备注:</label>
							<textarea name="description" style="width: 520px;"></textarea>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onClick="getFun(5);">保存</button>
			</div>
		</form>
	</div>
	
	<!-- 详情显示窗口 -->
	<div class="modal fade colsform" id="viewStudent" tabindex="-1" role="dialog" aria-hidden="true">	
		<form id="view">
			<h4>查看详情</h4>
			<div class="modal-content">
				<div class="form-controll">
					<label>班型名称:</label>
					<input type="text" name="classcurr" disabled>
				</div>
				<div class="form-controll">
					<label>培训班型:</label>
					<input type="text"  name="vehicletype" disabled> 
				</div>
				<div class="form-controll">
					<label>金额:</label>
					<input type="text"  name="price" disabled> 
				</div>
				<div class="form-controll">
					<label>培训模式:</label>
					<input type="text"  name="trainningmode" disabled> 
				</div>
				<div class="form-controll">
					<label>课时限制:</label>
					<input type="text"  name="resRegular" disabled> 
				</div>
				<div class="form-controll">
					<label>培训部分及方式:</label>
					<input type="text"  name="subject" disabled> 
				</div>
				<div class="form-controll">
					<label>培训时段:</label>
					<input type="text"  name="trainningtime" disabled> 
				</div>
				<div class="form-controll">
					<label>收费模式:</label>
					<input type="text"  name="chargemode" disabled> 
				</div>
				<div class="form-controll">
					<label>付费模式:</label>
					<input type="text"  name="paymode" disabled> 
				</div>
				<div class="form-controll">
					<label>服务内容:</label>
					<input type="text"  name="service" disabled> 
				</div>
				<div class="form-controll wid90" style="margin-right: 0;">
					<label>备注:</label>
					<textarea name="description" style="width: 520px;" disabled></textarea>
				</div>
			</div>
			<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			</div>
		</form>
	</div>

	<script type="text/javascript">
	var recordUrl=<custom:properties name='bjxc.user.province'/>;
	var insId= '<sec:authentication property="principal.insId"/>';
	var provinceUrl = <custom:properties name = 'bjxc.user.province'/>;
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
				'classcurr' : {
					'thText' : '名称',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<span data-id='+record.id+','+record.classcurr+','+record.seq+','+record.isProvince+'>'+record.classcurr+'</span>');
						return td.join('');
					}
				},
				/* 'id' : {
					'thText' : '收费标准编号',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				}, */
				'vehicletype' : {
					'thText' : '培训车型',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'price' : {
					'thText' : '金额',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'resRegular':{
					'thText' : '课时限制',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var item = ["","1课时/周","2课时/周","3课时/周","4课时/周","5课时/周","学完一节约下一节,不限课时"];
						var td = [];
							td.push('<span>'+item[value]+'</span>');
						return td.join('');
					}
				},
				'status':{
					'thText' : '状态',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var status = ["已停用","使用中"];
						var td = [];
							td.push('<span>'+status[value]+'</span>');
						return td.join('');
					}
				},
				'uptime' : {
					'thText' : '更新时间',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						var time = new Date(value);
						if (value != null && value != 'null') {
							td.push('<span>'+time.pattern("yyyy-MM-dd")+'</span>');							
						}
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
				'description' : {
					'thText' : '操作',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'width' : '150px',
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<button class="btn btn-success" onclick="view('+ record.id + ' )">查看详情</button>'); 
						return td.join('');
					}
				} 
			};
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/classType/list?insId='+insId,
				'size' : 1000,
				'ifRealPage' : 0
			};
			//初始化 并通过ajax加载数据
			dataTable = MTA.Data.loadAjaxPageTable(config);
		}
		/**
		*	停用数据
		*/
		function remove(id, classcurr,seq,isProvince) {
			//弹出提示框 让用户确认停用
			var dialog = new GRI.Dialog({
				type : 4,
				title : '班型停用',
				content : '确定停用【' + classcurr + '】吗？',
				deGRIil : '',
				btnType : 1,
				extra : {
					top : 250
				},
				winSize : 1
			}, function() {
				if(seq!=null&&isProvince==1){
					var seqLength = seq.length;
					while(seqLength < 5) {  
				        seq = "0" + seq;  
				        seqLength++;  
				    } 
					var param={"seq":seq,"inscode":insCode};
					$.post(recordUrl+"/province/charstandard/delete",param,function(result){
						if(result.errorcode == 0){
							//用户点了停用的确认信息
							$.ajax({
								type : "DELETE",
								url : "${ctx}/classType/" + id,
								data : "{}",
								contentType : "application/json; charset=utf-8",
								dataType : "json",
								success : function(data) {
									if(data.code==200){
										layer.alert('删除成功');
										buildDataTable();
									}else{
										layer.alert('删除失败');
									}
								},
								error : function(msg) {
									layer.alert(msg);
								}
							});
						}else{
							if(result.message.includes("删除条件对象不存在")){
								layer.alert("该班型没有备案");
							}else{
								layer.alert(result.message);
							}
						}
					});		
				}
			});
		}
		function pad2(n) {
			return n < 10 ? '0' + n : n
		}
		/**
		*	上传数据到省备案
		*/
		function updateToProvince(id){
			$.getJSON("${ctx}/classType/" + id, function (result) {
					 console.log(result);
				 if (result.code==200) {
					 var id=result.data.id;
					 var isCountry=result.data.isCountry;
					 var uptime = '20161111';
					 if (result.data.uptime != null && result.data.uptime != 'null') {
							var date = new Date(result.data.uptime);
							uptime = date.pattern("yyyyMMdd");
					 };
					 /*计时系统用户登录 自动备案到省(已全国备案作为前提)*/
					 if(isTimeSystem()){
							var param = {
									"inscode":insCode,
									"seq":result.data.seq,
									"vehicletype":result.data.vehicletype,
									"trainningmode":result.data.trainningmode,
									"subject":result.data.subject,
									"trainningtime":result.data.trainningtime,
									"chargemode":result.data.chargemode,
									"paymode":result.data.paymode,
									"service":result.data.service,
									"price":result.data.price,
									"classcurr":result.data.classcurr,
									"uptime":uptime
							};
						 if(param.paymode==3){
							 param.paymode = 1
						 }else if(param.paymode==2){
							 
						 }else{
							 param.paymode=9;
						 }
						  $.post(provinceUrl+"/province/charstandard",param,function(urlResult){
							if (urlResult.errorcode != 0) {
								layer.alert("信息正确性不完整,备案失败");
								return false;
							} else {
								//定义提交到服务端的数据对象
								var params = {
									"id" : id,
									"isprovince":1
								};
								$.post('${ctx}/classType/updatebeian', params, function(results) {
									console.log("request");
									if (results.code == 200) {
										if(!id || id != ''){
											$('#editCoach').modal('hide');
											 //保存成功 刷新列表
									     	
										}
										buildDataTable();
										layer.alert("备案成功");
									} else {
										//打开错误提示框
										alert(results.message);
									}
									$('#save_btn').attr('disabled',false);
								});
							}
						});
					 }
				 }else{
					 layer.alert(result.message);
				 }
			});
		}
		
		/**
		*	展示编辑表单界面
		*	新增、修改都需要调用该方法打开表单
		*/
		function showEditorModel(id) {
			//重置表单
			$('#editorModal input[name="classcurr"]').val('');
			$('#editorModal input[name="price"]').val('');
			//$("#ediorForm input[name='resRegular'][value=1]").attr("checked",true);
			//$("#ediorForm input[name='vehicletype'][value='C1']").attr("checked",true);
			var vehicletype = [];
			var checkBox = $("#editorModal input[name='vehicletype']");
		    for(k in checkBox){
		        checkBox[k].checked = false;
		    }
			$('#resRegular').get(0).selectedIndex=0;
			$("#editorModal input[name='trainningmode']").attr("checked",false);
			$("#editorModal input[name='subject']").attr("checked",false);
			$("#editorModal input[name='trainningtime']").attr("checked",false);
			$("#editorModal input[name='chargemode']").attr("checked",false);
			$("#editorModal select[name='paymode']").val('');
			$("#editorModal input[name='service']").val('');
			$("#editorModal textarea[name='description']").val('');
			if (id) {
				//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
				$.getJSON("${ctx}/classType/" + id, function (result) {
					 if (result.code==200) {
						 	var data = result.data;
							$('#editorModal input[name="id"]').val(data.id);
							$('#editorModal input[name="classcurr"]').val(data.classcurr);
							$('#editorModal input[name="price"]').val(data.price);
							//$("#ediorForm input[name='vehicletype'][value="+data.vehicletype+"]").attr("checked",true);
							$('#resRegular').get(0).value = data.resRegular;
							$("#editorModal input[name='trainningmode'][value="+data.trainningmode+"]").attr("checked",true);
							$("#editorModal input[name='subject'][value="+data.subject+"]").attr("checked",true);
							$("#editorModal input[name='trainningtime'][value="+data.trainningtime+"]").attr("checked",true);
							$("#editorModal input[name='chargemode'][value="+data.chargemode+"]").attr("checked",true);
							/* $("#editorModal input[name='paymode'][value="+data.paymode+"]").attr("checked",true); */
							$("#editorModal select[name='paymode'] option").each(function(){
								if( $(this).val() == data.paymode ){
									$(this).prop('selected',true);
									console.log($(this).val())
								}
								
							});
							console.log(data.paymode);
							$('#editorModal input[name="service"]').val(data.service);
							$("#editorModal textarea[name='description']").val(data.description);
							
							var checkBox = $("#editorModal input[name='vehicletype']");
							var item = data.vehicletype.split(",");
							for(i in item){
								for(k in checkBox){
							        if(checkBox[k].value == item[i]){
							        	checkBox[k].checked = true;
							        }
							    }
							}
							$('#editorModal').modal('show');
					 }else{
						 layer.alert('获取数据失败，错误代码'+result.code);
					 }
				});
			}else{
				$('#editorModal').modal('show');
			}
			
		}
		
		/**
		* 显示详情
		*/
		function view(id){
			$('#viewStudent').modal('show');
			$.getJSON("${ctx}/classType/" + id, function (result) {
				 if (result.code==200) {
					 var trainningmode = ["0","定时培训","预约培训","3","4","5","6","7","8","其他"];
					 var subject = ["0","第一部分集中教学","第一部分网络教学","第四部分集中教学","第四部分网络教学","模拟器教学","第二部分普通教学","第二部分智能教学","第三部分普通教学","第三部分智能教学"];
					 var trainningtime = ["0","普通时段","高峰时段","节假日时段"];
					 var chargemode = ["0","一次性收费","计时收费","3","4","5","6","7","8","其他"];
					 var paymode = ["0","其他","先付后学","先学后付"];
					 var resRegular = ["","1课时/周","2课时/周","3课时/周","4课时/周","5课时/周","学完一节约下一节,不限课时"];
					 	var data = result.data;
						$('#view input[name="id"]').val(data.id);
						$('#view input[name="classcurr"]').val(data.classcurr);
						$('#view input[name="price"]').val(data.price);
						$('#view input[name="vehicletype"]').val(data.vehicletype);
						$('#view input[name="resRegular"]').val(resRegular[data.resRegular]);
						$('#view input[name="trainningmode"]').val(trainningmode[data.trainningmode]);
						$('#view input[name="subject"]').val(subject[data.subject]);
						$('#view input[name="trainningtime"]').val(trainningtime[data.trainningtime]);
						$('#view input[name="chargemode"]').val(chargemode[data.chargemode]);
						$('#view input[name="paymode"]').val(paymode[data.paymode]);
						$('#view input[name="service"]').val(data.service);
						$("#view textarea[name='description']").val(data.description);
				 }else{
					 layer.alert(result.message);
				 }
			});
		}
		
		//新建或编辑保存
		function save(id) {
			//从form中取参数值
			var classcurr = $('#editorModal input[name="classcurr"]').val();
			var price = $('#editorModal input[name="price"]').val();
			var resRegular = $('#resRegular').val();
			var trainningmode = $('#editorModal input[name="trainningmode"]:checked').val();
			var subject = $('#editorModal input[name="subject"]:checked').val();
			var trainningtime = $('#editorModal input[name="trainningtime"]:checked').val();
			var chargemode = $('#editorModal input[name="chargemode"]:checked').val();
			var paymode = $('#editorModal select[name="paymode"]').val();
			var service = $('#editorModal input[name="service"]').val();
			var description = $('#editorModal textarea[name="description"]').val();
			
			var vehicletype = [];
			var checkBox = $("#editorModal input[name='vehicletype']");
		    for(k in checkBox){
		        if(checkBox[k].checked){
		        	vehicletype.push(checkBox[k].value);
		        }
		    }
		 	// 校验表单是否通过
			if( $("#updateSecurity .valid-form").Validform().check() != true ){
				return
			}
		 	/*修改*/
		 	if(typeof(id)!="undefined"){
		 		//定义提交到服务端的数据对象
				var params = {
					'id' : id,
					'insId' : insId,
					'classcurr' : classcurr,
					'price' : price,
					'vehicletype' : vehicletype.toString(),
					'resRegular':resRegular,
					'trainningmode' : trainningmode,
					'subject' : subject,
					'trainningtime' : trainningtime,
					'chargemode' : chargemode,
					'paymode' : paymode,
					'service' : service,
					'description' : description
				};
				console.log(params);
				//发送数据到后端保存
				$.post('${ctx}/classType', params, function (result) {
					 if (result.code==200) {
						 //保存成功 刷新列表
				     	dataTable.refresh();
				     	layer.alert('保存成功');
						 //关闭编辑的表单
						$('#editorModal').modal('hide');
					}else{
						layer.alert('保存失败，错误代码'+result.code);
					}
				});	
		 	}else{
				/*计时系统用户登录 自动备案*/
				if(isTimeSystem()){
			 		$.getJSON("${ctx}/classType/addseq/"+insId,function(result){
			 			if(result.code==200){
			 				var date=new Date();
			 				var dateInt=date.getDate();
			 				var dateVal=null;
			 				if(dateInt<10){
			 					dateVal='0'+dateInt;				
			 				}else{
			 					dateVal=dateInt;
			 				}
			 				var uptime=date.getFullYear().toString()+(date.getMonth() + 1).toString()+dateVal;
			 				var seqVal=result.data;
			 				//定义提交到服务端的数据对象
							var param = {
								"inscode" : insCode,
								"seq":seqVal,
								'vehicletype' : vehicletype.toString(),
								'trainningmode' : trainningmode,
								'subject' : subject,
								'trainningtime' : trainningtime,
								'chargemode' : chargemode,
								'paymode' : paymode,
								'service' : service,
								'price' : price,
								'classcurr' : classcurr,
								'uptime':uptime
							};
							//发送数据到后端保存
							$.post(recordUrl+'/province/charstandard',param,function(result) {
								if (result.errorcode == 0) {
									//定义提交到服务端的数据对象
									var params = {
										'id' : id,
										'insId' : insId,
										'classcurr' : classcurr,
										'price' : price,
										'vehicletype' : vehicletype.toString(),
										'resRegular':resRegular,
										'trainningmode' : trainningmode,
										'subject' : subject,
										'trainningtime' : trainningtime,
										'chargemode' : chargemode,
										'paymode' : paymode,
										'service' : service,
										'description' : description,
										'seq':seqVal,
										'isprovince':1
									};
									console.log(params);
									//发送数据到后端保存
									$.post('${ctx}/classType', params, function (result) {
										 if (result.code==200) {
											 //保存成功 刷新列表
									     	dataTable.refresh();
									     	layer.alert('保存成功');
											 //关闭编辑的表单
											$('#editorModal').modal('hide');
										}else{
											layer.alert('保存失败，错误代码'+result.code);
										}
									});
								}else{
									//layer.alert('保存失败，错误代码'+result.code);
									layer.alert(result.message);
								}
							})
			 			}else{
			 				layer.alert(result.message);
			 			}
			 		});
				}else{
					$.getJSON("${ctx}/classType/addseq/"+insId,function(result){
						if(result.code==200){
							//定义提交到服务端的数据对象
							var params = {
								'id' : id,
								'insId' : insId,
								'classcurr' : classcurr,
								'price' : price,
								'vehicletype' : vehicletype.toString(),
								'resRegular':resRegular,
								'trainningmode' : trainningmode,
								'subject' : subject,
								'trainningtime' : trainningtime,
								'chargemode' : chargemode,
								'paymode' : paymode,
								'service' : service,
								'description' : description,
								'isprovince':0,
								'seq':result.data
							};
							console.log(params);
							//发送数据到后端保存
							$.post('${ctx}/classType', params, function (result) {
								 if (result.code==200) {
									 //保存成功 刷新列表
							     	dataTable.refresh();
							     	layer.alert('保存成功');
									 //关闭编辑的表单
									$('#editorModal').modal('hide');
								}else{
									layer.alert('保存失败，错误代码'+result.code);
								}
							});
						}
					});
				}
		 	}
		}
		
		/*  统一获取方法  */
		function getFun(type){
			var ids = sessionStorage.getItem('tabId');
			if(type==1){	//新增
				sessionStorage.removeItem('tabId');
				showEditorModel();
				classId = null;
				return;
			}
			if(type==5 && ids === null || ids === undefined){	//新增->保存
				save();
				return;
			}
			/* 获取id */
			if(ids === null || ids === undefined){
				layer.alert('未选择目标');
				return;
			}else{
			var item = ids.split(",");
			var id = item[0];
			var classcurr = item[1];
			var seq=item[2];
			var isProvince=item[3];
				switch(type){
					case 2:	//修改
						showEditorModel(id);
					break;
					case 3:	//停用
						remove(id,classcurr,seq,isProvince);
					break;
					case 4:	//备案
						updateToProvince(id);
					break;
					case 5:	//修改->保存
						save(id);
					break;
				}
			}
		}
	</script>
</body>
</html>