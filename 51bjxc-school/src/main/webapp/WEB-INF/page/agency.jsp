<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-demo</title>
<script type="text/javascript" src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
</head>
<body>
	<div class="container-fluid new-admin">
		<div class="select-top">
		<sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
			<a href="${ctx}/view/editAgency" class="select-btn"><span class="add"></span>新增</a>
			<a onclick="update();" class="select-btn"><span class="edit" ></span>修改</a>
			<a class="select-btn"><span class="del"></span>禁用</a>
			<a class="select-btn" onClick="typing()"><span class="spare"></span>预录入</a>
			<a class="select-btn" onClick="upRecord()"><span class="spare"></span>备案</a>
			<a class="select-btn"><span class="tpl"></span>导入模板</a>
			<a class="select-btn"><span class="Import"></span>导入</a>
			<a class="select-btn" onclick="exportFile();"><span class="Export"></span>导出</a>
		</sec:authorize>
		
		<sec:authorize access="hasRole('ROLE_SCHOOL_SERVICE')">
			<sec:authorize access="hasRole('ROLE_UserOperation_39')">
				<a href="${ctx}/view/editAgency" class="select-btn"><span class="add"></span>新增</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_40')">
				<a onclick="update();" class="select-btn"><span class="edit" ></span>修改</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_41')">
				<a class="select-btn"><span class="del"></span>禁用</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_42')">
				<a class="select-btn" onClick="typing()"><span class="spare"></span>预录入</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_43')">
				<a class="select-btn" onClick="upRecord()"><span class="spare"></span>备案</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_44')">
				<a class="select-btn"><span class="tpl"></span>导入模板</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_45')">
				<a class="select-btn"><span class="Import"></span>导入</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_46')">
				<a class="select-btn" onclick="exportFile();"><span class="Export"></span>导出</a>
			</sec:authorize>
		</sec:authorize>
		</div>
	</div>
	<div class="termSearch">
		<input class="input1 win200" type="text" placeholder="培训机构名称、经营许可证号、地址" id="termSearch">
		<button class="btn-flat primary" onClick="searchQuery();return false;">搜 索</button>
	</div>
	<div class="row-fluid">
		<div class="sub_content">
			<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
			<div id="table_list" class="gri_wrapper"></div>
			
		</div>
	</div>
	
	<div class="modal fade" id="studentModal" tabindex="-1" role="dialog" aria-labelledby="editorModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">预录入驾校</h4>
				</div>
				<div class="row1">
						<div class="form-controll wid90">
							<label>行政编码:</label> <input type="text" name="district" value="">
						</div>
						<div class="form-controll wid90">
							<label>机构名称:</label> <input type="text" name="name" value="">
						</div>
						<div class="form-controll wid90">
							<label>营业许可证:</label> <input type="text" name="licnum" value="">
						</div>
					</div>
				<div class="modal-footer">
					<button type="button" id="bcountry" class="btn btn-default" onClick="country();">国家备案</button>
					<button type="button" id="bprovince" class="btn btn-default" onClick="province();">省备案</button>
				</div>
			</div>
		</div>
	</div>
	
<script type="text/javascript">
var recordUrl=<custom:properties name='bjxc.user.province'/>;
//初始化 
$(document).ready(function() {
	//初始化界面  完成后调用buildData方法
	MTA.Report.initialize(null, 'buildData');
});

function buildData() {
	/* MTA.Util.setParams('insId', insId); */
	buildDataTable();
}
/**
 *	搜索
 */
function searchQuery() {
	var termSearch = $("#termSearch").val();
	MTA.Util.setParams('searchText', termSearch);
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
		'inscode' : {
			'thText' : '机构编号',
			'number' : false,
			'needOrder' : false,
			'precision' : 0,
			'render' : function(value, cellmeta, record, rowIndex,
					columnIndex) {
				var td = [];
				td.push('<span data-id="');
					td.push(record.id);
					td.push('">');
					td.push(record.inscode);
				td.push('</span>');
				return td.join('');
			}
		},
		'name' : {
			'thText' : '企业名称',
			'number' : false,
			'needOrder' : false,
			'precision' : 0,
		},
		'shortName' : {
			'thText' : '企业简称',
			'number' : false,
			'needOrder' : false,
			'precision' : 0,
		},
		'licnum' : {
			'thText' : '经营许可证号',
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
		'contact' : {
			'thText' : '联系人',
			'number' : false,
			'needOrder' : false,
			'precision' : 0,
		},
		'phone' : {
			'thText' : '联系方式',
			'number' : false,
			'needOrder' : false,
			'precision' : 0,
		},
		'busiscope' : {
			'thText' : '经营范围',
			'number' : false,
			'needOrder' : false,
			'precision' : 0,
		},
		'busistatus' : {
			'thText' : '经营状态',
			'number' : false,
			'needOrder' : false,
			'precision' : 0,
			'render' : function(value, cellmeta, record, rowIndex,
					columnIndex) {
				td = [];
				td.push('<ul class="info">');
					td.push('<li>');
						if (value ==  1) {
							td.push('营业');
						} else if (value == 2) {
							td.push('停业');
						}else if(value==3){
							td.push('整改');
						}else if(value==4){
							td.push('停业整顿');
						}else if(value==5){
							td.push('歇业');
						}else if(value==6){
							td.push('注销');
						}else if(value==9){
							td.push('其他');
						}
					td.push('</li>');
				td.push('</ul>');
				return td.join('');
				}
			},
			'licetime' : {
				'thText' : '许可时间',
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
				'thText' : ' ',
			'number' : false,
			'needOrder' : false,
			'precision' : 0,
			'width' : '150px',
			'render' : function(value, cellmeta, record, rowIndex,
					columnIndex) {
				var td = [];
				td.push('<button class="btn btn-success" onClick="viewModal('+record.id+');">查看详情</button>');
				td.push('<ul class="actions">');
				/* td.push('<li>');
				td.push('<a class="btn-flat primary" title="安全员详情信息" href="${ctx}/view/assessmentEditor?id='+record.id+'" target= "_blank">');
				td.push('详情');
				td.push('</a>');
				td.push('</li>');
				td.push('<li>');
				td.push("<input class='btn-flat primary' type='button' onClick='upRecord("+ sRecord + ")' value='上传备案'>");					
				td.push('</li>'); */
				td.push('</ul>');
				return td.join('');
			}
		}
	}
	//ajax的数据请求参数
	config['page'] = {
		'url' : '${ctx}/institutionInfo/list',
		'size' : 10,
		'ifRealPage' : 1
	};
	//初始化 并通过ajax加载数据
	dataTable = MTA.Data.loadAjaxPageTable(config);
}

function typing(){
	$('#studentModal input[name="district"]').val('');
	$('#studentModal input[name="name"]').val('');
	$('#studentModal input[name="licnum"]').val('');
	$("#bcountry").attr("disabled", false);
	$("#bprovince").attr("disabled", true);
	$("#studentModal").modal('show');
}

function country(){
	var district=$('#studentModal input[name="district"]').val();
	var name=$('#studentModal input[name="name"]').val();
	var licnum=$('#studentModal input[name="licnum"]').val();
	var param={
		'district' : district,
		'name' : name,
		'licnum' : licnum,
		'type' : '1'
	};
	$.post(recordUrl+'/country/login',param,function(result){
		console.log(result);
		if(result.errorcode==0){
			$("#bprovince").attr("disabled", false);
			$("#bcountry").attr("disabled", true);
			layer.alert('国家登录成功');
		}else {
			layer.alert(result.message);
		}
	});
}

function province(){
	var district=$('#studentModal input[name="district"]').val();
	var name=$('#studentModal input[name="name"]').val();
	var licnum=$('#studentModal input[name="licnum"]').val();
	var param={
		'district' : district,
		'name' : name,
		'licnum' : licnum,
		'type' : '2'
	};
	$.post(recordUrl+'/country/login',param,function(result){
		console.log(result);
		if(result.errorcode==0){
			$("#bprovince").attr("disabled", true);
			layer.alert('省登录成功');
		}else {
			layer.alert(result.message);
		}
	});
	}

	function exportFile() {
		window.location.href = "${ctx}/institutionInfo/exportInsInfo";
	}

	function update(){
	var id=sessionStorage.getItem('tabId')
	if(id === null || id === undefined){
		layer.alert('未选择目标');
	}else{
		window.location.href="${ctx}/view/editAgency?id="+id;
	}
}

function viewModal(id){
	window.location.href="${ctx}/view/agencyView?id="+id;
}

/**
*	备案到省平台
*/
function upRecord() {
	/* 获取id */
	var id = sessionStorage.getItem('tabId');
	if(id === null || id === undefined){
		layer.alert('未选择目标');
	}else{
		$.getJSON("${ctx}/institutionInfo/" + id,function(result) {
			if(result.code==200){
				var data = result.data;
				//弹出提示框 让用户确认删除
				var dialog = new GRI.Dialog({
					type : 4,
					title : '上传备案',
					content : '确定上传名为【' + data.name + '】的驾校吗？',
					deGRIil : '',
					btnType : 1,
					extra : {
						top : 250
					},
					winSize : 1
				}, function() {
					var isCountry=data.isCountry;
					if(isCountry!=null &&isCountry==1){
						//时间判断函数
					 	function pad2(n) { return n < 10 ? '0' + n : n }
					 	//经营许可日期
					 	var licetime;
						if(data.licetime!=null){
							var date = new Date(data.licetime);
							var licetime = date.getFullYear().toString() + pad2(date.getMonth() + 1) + pad2( date.getDate())
						}
						//定义提交到服务端的数据对象
						var params = {
								'inscode' :data.inscode,//'5113559050455096',
								'district' : data.district,
								'name' :data.name,//'2383114336134796',
								'shortname' : data.shortName,
								'licnum' : data.licnum,
								'licetime' :licetime,
								'business' : data.business,
								'creditcode':data.creditcode,
								'address':data.address,
								'postcode':data.postcode,
								'legal':data.legal,
								'contact':data.contact,
								'phone':data.phone,
								'busiscope':data.busiscope,
								'busistatus':data.busistatus,
								'level':data.level,
								'coachnumber':data.coachnumber,
								'grasupvnum':data.grasupvnum,
								'safmngnum':data.safmngnum,
								'tracarnum':data.tracarnum,
								'classroom':data.classroom,
								'thclassroom':data.thclassroom,
								'praticefield':data.praticefield
						};
						//发送数据到后端保存
						$.post(recordUrl+'/province/institution',params,function(result) {
							if (result.errorcode == 0) {
								var params={"id":id};
								$.post('${ctx}/institutionInfo/updateStatus', params, function(result) {
									if (result.code == 200) {
										//保存成功 刷新列表
								     	buildDataTable();
								     	layer.alert("备案成功")
									}else{
										layer.alert(result.message);
									}
								});
							}else{
								layer.alert(result.message);
							}
						});
					}else{
						layer.open({
						  title: '提示',
						  maxWidth:900,
						  content: '<h4 style="color:red; text-align:center;font-size:20px;">温馨提示</h4>'+
						  '<div style="text-align:center;">该培训机构没有国家平台备案的机构编号,不能上传省平台备案!</br>(在计时平台对接前录入的学员不需要备案)</div>'
						});
					}
				});
			}
		});
	}
}
</script>
</body>
</html>