<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-缴费流水</title>
<script src="${ctx}/resources/uploadify/jquery.uploadify.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/admin.js"></script>
</head>
<body>
	
	<!-- 列表 -->
	<div class="row-fluid">
		<div class="sub_content">
			<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
			<div id="table_list" class="gri_wrapper"></div>
			
		</div>
	</div>
	
	<div class="modal fade colsform" id="addStudent" tabindex="-1" role="dialog" aria-hidden="true">	
		<form class="form-horizontal">
			<h4>新增学员</h4>
			<div class="modal-content">
				<div class="left">
					<div class="row1">
						<div class="form-controll">
							<label>姓名:</label>
							<input type="text">
						</div>
						<div class="form-controll">
							<label>性别:</label>
							<input type="radio" name="sex" checked> 男
							<input type="radio" name="sex" > 女
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>国籍:</label>
							<select>
  								<option value ="volvo">Volvo</option>
  								<option value ="saab">Saab</option>
 								<option value="opel">Opel</option>
  								<option value="audi">Audi</option>
							</select>
						</div>
						<div class="form-controll">
							<label>联系地址:</label>
							<input type="text">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>证件类型:</label>
							<input type="radio" name="aa" checked> 身份证
							<input type="radio" name="aa" > 军官证
							<input type="radio" name="aa" > 护照
							<input type="radio" name="aa" > 其他
						</div>
						<div class="form-controll">
							<label>证件号:</label>
							<input type="text">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>电话号码:</label>
							<input type="text">
						</div>
						<div class="form-controll">
							<label>报名时间:</label>
							<input type="text" name="applydate"  class="form_date" data-date-format="yyyy-mm-dd" readonly="readonly" >
						</div>
					</div>
					<div class="row1">
						<div class="form-controll width100">
							<label>电话号码:</label>
							<input type="text">
						</div>
						<div class="form-controll width100">
							<label>电话号码:</label>
							<input type="text" >
						</div>
						<div class="form-controll width100">
							<label>电话号码:</label>
							<input type="text" >
						</div>
					</div>
					<div class="row1">
						<div class="form-controll wid90">
							<label>电话号码:</label>
							<textarea></textarea>
						</div>
						
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
					<button type="button" class="btn btn-primary" >保存</button>
			</div>
		</form>
	</div>
	
	<div class="modal fade colsform" id="editStudent" tabindex="-1" role="dialog"  aria-hidden="true">	
		<form class="form-horizontal">
			<h4>查看详情</h4>
			<div class="modal-content">
				<div class="left">
					<div class="row1">
						<div class="form-controll">
							<label>姓名:</label>
							<input type="text" value="呵呵呵">
						</div>
						<div class="form-controll">
							<label>性别:</label>
							<input type="radio" name="sex" checked> 男
							<input type="radio" name="sex" > 女
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>国籍:</label>
							<select>
  								<option value ="volvo">Volvo</option>
  								<option value ="saab">Saab</option>
 								<option value="opel">Opel</option>
  								<option value="audi">Audi</option>
							</select>
						</div>
						<div class="form-controll">
							<label>联系地址:</label>
							<input type="text">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>证件类型:</label>
							<input type="radio" name="aa" checked> 身份证
							<input type="radio" name="aa" > 军官证
							<input type="radio" name="aa" > 护照
							<input type="radio" name="aa" > 其他
						</div>
						<div class="form-controll">
							<label>证件号:</label>
							<input type="text">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>电话号码:</label>
							<input type="text">
						</div>
						<div class="form-controll">
							<label>报名时间:</label>
							<input type="text" name="applydate"  class="form_date" data-date-format="yyyy-mm-dd" readonly="readonly" >
						</div>
					</div>
					<div class="row1">
						<div class="form-controll width100">
							<label>电话号码:</label>
							<input type="text">
						</div>
						<div class="form-controll width100">
							<label>电话号码:</label>
							<input type="text" >
						</div>
						<div class="form-controll width100">
							<label>电话号码:</label>
							<input type="text" >
						</div>
					</div>
					<div class="row1">
						<div class="form-controll wid90">
							<label>电话号码:</label>
							<textarea></textarea>
						</div>
						
					</div>
				</div>
				<div class="right">
					<div class="rk_swfupload">
						<div style="height: 60px; width: 100px; display: inline-block;">
							<span class="pic">个人相片</span>
							<img id="photo" name="photo" src="" class="img-thumbnail">
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
					<button type="button" class="btn btn-primary" onClick="changeCoach();">保存</button>
			</div>
		</form>
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
			var coachId=$("#coachId").val();
			if(stationId && stationId != ''){
				MTA.Util.setParams('stationId', stationId);
			}
			if(coachId && coachId != ''){
				MTA.Util.setParams('coachId', coachId);
			}
			buildDataTable();
		}
		/**
		 *	搜索
		 */
		function searchQuery() {
			var search = $("#search").val();
			var coachOrStu=$("#coachOrStu").val();
			MTA.Util.setParams('searchText', search);
			MTA.Util.setParams('coachOrStu', coachOrStu);
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
				'applydate' : {
					'thText' : '日期',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<span data-id="');
							td.push(record.id);
							td.push('">');
							td.push(value);
						td.push('</span>');
						return td.join('');
					}
				},
				'name' : {
					'thText' : '学员姓名',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'traintype' : {
					'thText' : '培训车型',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'alreadyPay' : {
					'thText' : '实际缴费 ',
					'number' : true,
					'needOrder' : false,
					'precision' : 0,
				},
				'arrearage' : {
					'thText' : '欠缴费用',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				}
			};
			
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/student/payWaterList',
				'size' : 10,
				'ifRealPage' : 1
			};
			//初始化 并通过ajax加载数据
			dataTable = MTA.Data.loadAjaxPageTable(config);
		}
		
		

		
		function changeStudentStatus(studentId,studentName, status) {
			var msg = '确定将 ' + studentName + ' 更改到';
				if(status == 0){
					msg += '科目一学习';
				}else if(status == 1){
					msg += '科目一学习';
				}else if(status == 2){
					msg += '科目二学习';
				}else if(status == 3){
					msg += '科目三学习';
				}else if(status == 4){
					msg += '科目四学习';
				}else if(status == 5){
					msg += '已拿证';
				}
			//弹出提示框 让用户确认删除
			var dialog = new GRI.Dialog({
				type : 4,
				title : '变更学员进度',
				content : msg,
				deGRIil : '',
				btnType : 1,
				extra : {
					top : 250
				},
				winSize : 1
			}, function() {
				var params = {
						studentId:studentId,
						status:status,
						insId:insId
				}
				
				$.post('${ctx}/student/changeStudentStatus', params, function (result) {
					if(result.code==200){
						buildDataTable();
					}else{
						new GRI.Dialog({
							type : 4,
							title : '变更学员进度',
							content : result.message,
							deGRIil : '',
							btnType : 3,
							extra : {
								top : 250
							},
							winSize : 1
						});
					}
					
				});
			});
		}
		
		function changeCoach(){
			var subjectId = $('#coachForm input[name="subjectId"]').val();
			var studentId = $('#coachForm input[name="studentId"]').val();
			var coachId = $('#coachForm select[name="coach"]').val();
			if(!coachId){
				return;
			}
			var datas={
				subjectId:subjectId,
				studentId:studentId,
				coachId:coachId
			};
			$.post("${ctx}/studentSubject/changeCoach",datas,function (result) {
				if (result.code==200) {
					$('#coachModal').modal('hide');
					buildDataTable();
				}
			});
			
		}
		

		
		function showChangeCoachPanel(studentId,subjectId,coachId){
			$('#coachForm input[name="studentId"]').val(studentId);
			$('#coachForm input[name="subjectId"]').val(subjectId);
			$('#coachForm select[name="coach"]').empty();
				var datas={
					subjectId:subjectId,
					insId:insId
				};
				if(stationId){
					datas['stationId'] = stationId
				}
				$("select[name='coach']").append("<option value=''>请选择教练</option>");
				$.getJSON("${ctx}/coach/getInsCoach",datas,function (result) {
					if (result.code==200) {
						var data = result.data;
						for(var i=0; i<data.length; i++){
							$("select[name='coach']").append("<option value='"+data[i].id+"'>"+data[i].name+"</option>");
						}
						if(coachId){
							$('#coachForm select[name="coach"]').val(coachId);
						}
					}
				});
			$('#coachModal').modal('show');
		}
		
		function changeStudent(){
			var studentId = $('#studentForm input[name="studentId"]').val();
			var stunum = $('#studentForm input[name="stunum"]').val();
			
			if(!studentId){
				return;
			}
			
			var datas={
				studentId:studentId,
				stunum:stunum,
			};
			
			$.post("${ctx}/student/changeStudentStunum",datas,function (result) {
				alert(stunum);
				if (result.code==200) {
					$('#studentModal').modal('hide');
					buildDataTable();
				}
			});
			
		}
		
		function showChangeStudentStunum(studentId){
			$('#studentForm input[name="studentId"]').val(studentId);
			$('#studentForm input[name="stunum"]').val();
			
			$('#studentModal').modal('show');
		}
		/**
		*	展示编辑表单界面
		*	新增、修改都需要调用该方法打开表单
		*/
		function uploadRecord(id,name) {
			//弹出提示框 让用户确认删除
			var dialog = new GRI.Dialog({
				type : 4,
				title : '上传备案',
				content : '确定上传【' + name + '】学员信息备案吗？',
				deGRIil : '',
				btnType : 1,
				extra : {
					top : 250
				},
				winSize : 1
			}, function() {
				if (id) {
					//传入了ID需要从后端去获取已有的数据 并填充到表单编辑界面
					$.getJSON("${ctx}/student/" + id, function (result) {
						 if (result.code==200) {
							 	var data = result.data;
							 	//定义提交到服务端的数据对象
								var params = {
									'inscode' : '2236581429084424',
									'stunum':data.stunum,
									'cardtype' :data.cradtype,
									"idcard" : data.idcard,
									"nationality" : '中国',
									"name" :data.name,
									"sex" : data.sex,
									"phone" :data.mobile,
									"address" :data.address,
									"photo" : 213674,
									"fingerprint" :data.fingerprint,
									"busitype" :data.busitype,
									"drilicnum" :data.drilicnum,
									"fstdrilicdate" : 20161002,
									"perdritype" :data.perdritype,
									"traintype" :data.traintype,
									"applydate" : 20161002
								};
								//发送数据到后端保存
								$.post('http://192.168.1.6:8000/province/student',params,function(result) {
									if (result.errorcode == 0) {
										 //保存成功 刷新列表
								     	dataTable.refresh();
									}else{
										alert(result.message)
									}
								});
						}
					});
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
		$('.tab-button').datetimepicker({
	        language:  'zh-CN',
	        weekStart: 1,
	        todayBtn:  1,
			autoclose: 1,
			todayHighlight: 0,
			startView: 2,
			minView: 2,
			forceParse: 0
	   }).on('changeDate', function(ev){
		   /* 时间被改变是的回调 */
	   });
		$('#upload_buton_img').uploadify({
			'swf' : 'http://upload.91ygxc.com/resources/swfupload.swf',
			'uploader' : 'http://upload.91ygxc.com/FileUpload',
			'height' : '170',
			'width' : '120',
			'fileTypeExts' : '*.jpg;*.JPG;*.jpeg;*.JPEG;*.png;*.PNG;*.gif;*.GIF',
			'fileObjName' : 'file_upload',
			'onUploadSuccess' : function(file, data, response) {
				var datajson = eval("(" + data + ")");
				$("#photo").attr('src', datajson.data.s);
			}
		})
		function addModal(){
			/* 获取id */
			/* alert(sessionStorage.getItem('tabId')); */
			$('#addStudent').modal('show');a
			
		};
		function editModal(){
			/* 获取id */
			var id = sessionStorage.getItem('tabId');
			if(id === null || id === undefined){
				alert('未选择目标');
			}else{
				$('#editStudent').modal('show');
			}
			
				
		}
		function mgmt(){

			$('#ViewTrainees').modal('show');	
		}
		
		
	</script>
</body>
</html>