<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-学员退费审核</title>
<script src="${ctx}/resources/uploadify/jquery.uploadify.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/admin.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/classType/<sec:authentication property="principal.insId"/>"></script>
<script type="text/javascript" src="${ctx}/resources/js/serviceStation/<sec:authentication property="principal.insId"/>"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery-form.js"></script>
</head>
<body>
	<div class="container-fluid new-admin">
		<div class="select-top">
		<sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
			<a class="select-btn" onclick="getCheckbox()"><span class="spare"></span>审核</a>
		</sec:authorize>
		<sec:authorize access="hasRole('ROLE_SCHOOL_SERVICE')">
			<sec:authorize access="hasRole('ROLE_UserOperation_148')">
				<a class="select-btn" onclick="getCheckbox()"><span class="spare"></span>审核</a>
			</sec:authorize>
		</sec:authorize>
		</div>
	</div>
	<div class="TermSearch">
		<form>
			<select id="status">
				<option value="-1" checked>请选择</option>		
				<option value="1" >待审核</option>
				<option value="2">已驳回</option>
				<option value="3">已退费</option>
			</select>  <input
				type="text" class="form_date input1 win90" id="time1"
				data-date-format="yyyy-mm-dd" placeholder="请选择开始日期"> <input
				type="text" class="form_date input1 win90" id="time2"
				data-date-format="yyyy-mm-dd" placeholder="请选择结束日期">
			<buuton class="btn-flat primary"
				onClick="searchQuery();return false;">搜 索</buuton>
		</form>
	</div>
	<!-- 列表 -->
	<div class="row-fluid">
		<div class="sub_content">
			<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
			<div id="table_list" class="gri_wrapper"></div>
			
		</div>
	</div>
			
	<script type="text/javascript">
    	var current_action = "${ctx}/view/student";
	
		//标识当前页面的url 用来设置当前菜单标识
		var dataTable = null;
		var insId= <sec:authentication property="principal.insId"/>;
		var stationId= <sec:authentication property="principal.stationId"/>;
		
		//初始化 
		$(document).ready(function() {
			//初始化界面  完成后调用buildData方法
			MTA.Report.initialize(null, 'buildData');
		});

		function buildData() {
			MTA.Util.setParams('insId', insId);
			if(stationId && stationId != ''){
				MTA.Util.setParams('stationId', stationId);
			}
			MTA.Util.setParams('status', -1); 
			buildDataTable();
		}
		/**
		 *	搜索
		 */
		function searchQuery() {
			
			var time1 = $("#time1").val();
			var time2 = $("#time2").val();
			var status = $("#status").val();
			MTA.Util.setParams('status', status); 
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
					'thText' : '<input type="checkbox" id="quanxuan" onclick="quanxuan()"> 全选',
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
							td.push('<input type="checkbox" class="data-id" value="'+ record.id +'">');
						td.push('</span>');
						return td.join('');
					}
				},
				'createtime' : {
					'thText' : '申请时间',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'studentName' : {
					'thText' : '学生姓名',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'studentID' : {
					'thText' : '学员编号 ',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'serviceStationName' : {
					'thText' : '隶属报名处',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'tcoachName' : {
					'thText' : '隶属教练',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'tuition' : {
					'thText' : '应缴费用',
					'number' : true,
					'needOrder' : false,
					'precision' : 0,
				},
				'alreadyPay' : {
					'thText' : '实缴费用',
					'number' : true,
					'needOrder' : false,
					'precision' : 0,
				},
				'arrearage' : {
					'thText' : '欠缴费用',
					'number' : true,
					'needOrder' : false,
					'precision' : 0,
				},
				'money' : {
					'thText' : '申请退费金额',
					'number' : true,
					'needOrder' : false,
					'precision' : 0,
				},
				'classcurr' : {
					'thText' : '班型',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'classcurr' : {
					'thText' : '班型',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				}
				,
				'subjectId' : {
					'thText' : '学员进度',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<ul class="info">');
							td.push('</li>');
							if(value == 0){
								td.push('科目一录入');
							}else if(value == 1){
								td.push('科目一');
							}else if(value == 2){
								td.push('科目二');
							}else if(value == 3){
								td.push('科目三');
							}else if(value == 4){
								td.push('科目四');
							}else{
								if(record.stunum == null){
									td.push('报名未受理');
								}else{
									td.push('报名已受理');
								}
							}
							td.push('</li>');
						td.push('</ul>');
						return td.join('');
					}
				},
				'status' : {
					'thText' : '审核状态',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<ul class="info">');
							td.push('</li>');
							 if(value == 1){
								td.push('<span style="color:red;">待审核</span>');
							}else if(value == 2){
								td.push('已驳回');
							}else if(value == 3){
								td.push('已退费');
							}
							td.push('</li>');
						td.push('</ul>');
						return td.join('');
					}
				}
			};
			
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/Trefund/list',
				'size' : 10,
				'ifRealPage' : 1
			};
			//初始化 并通过ajax加载数据
			dataTable = MTA.Data.loadAjaxPageTable(config);
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
			
		function getCheckbox(){
			var arrId = [];
			$('table input[class="data-id"]:checked').each(function(){     
				arrId.push($(this).val());//向数组中添加元素  
			 });
			if(arrId.length == 0){
				layer.alert("请选择");
				return;
			}
			var status;
			var userNote;
			
			layer.prompt({
				 title: '说明',
				 btn:['同意','拒绝'],
				 btn2:function(){
					 var value = $('.layui-layer-input').val();
					 userNote = value;
					 status=2;
					 update(userNote,status,arrId);
				 }
			},function(value, index, elem){
				userNote = value;
				status=3;
				layer.close(index); //关闭对话框
				update(userNote,status,arrId);
			});
		}
		
		function update(userNote,status,arrId){
			var reviewUser = <sec:authentication property="principal.id"/>;
			var params = {
					"arrId":arrId,
					"reviewUser":reviewUser,
					"userNote":userNote,
					"status":status
				}; 
			$.post("${ctx}/Trefund/update",params,function (result) {
				if (result.code==200) {
					layer.alert("您审核了"+result.tmp+"个学员");
					buildDataTable();
				}
			});
		}
		
		function quanxuan(){
			if($("input[id='quanxuan']").is(':checked')){
				$('table input[class="data-id"]').prop("checked",true);
			}else{
				$('table input[class="data-id"]').prop("checked",false);
			}	
		}	
	</script>
</body>
</html>