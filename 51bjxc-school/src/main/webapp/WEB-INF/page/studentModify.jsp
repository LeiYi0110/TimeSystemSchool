<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta name="theme" content="manager" />
<title>阳光驾培-学生管理</title>
</head>
<body>
	<div class="row-fluid head">
		<div class="span12">
			<h4>学生信息录入</h4>
		</div>
	</div>
	<!-- 新增 -->
	<div>
		<div align="center">
			<form id="ediorForm">
				<input type="hidden" name="id" value="">
				<div class="field-box success">
					<label>学员统一编号:</label> <input class="span5" type="text"
						name="stunum" value="#{student.stunum}">
				</div>
				<div class="field-box success">
					<label>用户ID:</label> <input class="span5" type="text" name="userId"
						value="#{student.userId}">
				</div>
				<div class="field-box success">
					<label>培训机构ID:</label> <input class="span5" type="text"
						name="insId" value="#{student.insId}">
				</div>
				<div class="field-box success">
					<label>姓名:</label> <input class="span5" type="text" name="name"
						value="#{student.name}">
				</div>
				<div class="field-box success">
					<label>电话号码:</label> <input class="span5" type="text" name="mobile"
						value="#{student.mobile}">
				</div>
				<div class="field-box success">
					<label>证件类型:</label>
					<!-- 1-身份证 2-护照 3-军官证 4-其它 -->
					<input id="idCard" type="radio" name="cradtype" value="1"
						<c:if test="${student.cradtype==1}"> checked='checked'</c:if>>
					<label for="idCard">身份证</label> <input id="passport" type="radio"
						name="cradtype" value="2"
						<c:if test="${student.cradtype==2}"> checked='checked'</c:if>>
					<label for="passport">护照</label> <input id="militaryId"
						type="radio" name="cradtype" value="3"
						<c:if test="${student.cradtype==3}"> checked='checked'</c:if>>
					<label for="militaryId">军官证</label> <input id="other_1"
						type="radio" name="cradtype" value="4"
						<c:if test="${student.cradtype==4}"> checked='checked'</c:if>>
					<label for="other_1">其它</label>
				</div>
				<div class="field-box success">
					<label>证件号:</label> <input class="span5" type="text" name="idcard"
						value="#{student.idcard}">
				</div>
				<div class="field-box success">
					<label>国籍:</label> <input class="span5" type="text"
						name="nationality" value="#{student.nationality}">
				</div>
				<div class="field-box success">
					<label>性别:</label>
					<!-- <input class="span5" type="text" name="sex"> 1-男  2-女 -->
					<input id="male" type="radio" name="cradtype" value="1"
						<c:if test="${student.sex==1}"> checked='checked'</c:if>>
					<label for="male">男</label> <input id="female" type="radio"
						name="cradtype" value="1"
						<c:if test="${student.sex==2}"> checked='checked'</c:if>>
					<label for="female">女</label>
				</div>
				<div class="field-box success">
					<label>联系地址:</label> <input class="span5" type="text"
						name="address" value="#{student.address}">
				</div>
				<div class="field-box success">
					<label>头像照片地址:</label> <img alt="#{student.name}"
						src="#{student.photo}"> <input class="span5" type="text"
						name="photo" value="#{student.photo}">
				</div>
				<div class="field-box success">
					<label>指纹图片地址:</label> <img alt="#{student.name}"
						src="#{student.fingerprint}"> <input class="span5"
						type="text" name="fingerprint" value="#{student.fingerprint}">
				</div>
				<div class="field-box success">
					<label>业务类型:</label>
					<!-- <input class="span5" type="text" name="busitype"> 0-初领1-增领2-其它 -->
					<input id="earlyLead" type="radio" name="cradtype" value="1"
						<c:if test="${student.busitype==0}"> checked='checked'</c:if>>
					<label for="earlyLead">初领</label> <input id="additionalCollar"
						type="radio" name="cradtype" value="1"
						<c:if test="${student.busitype==1}"> checked='checked'</c:if>>
					<label for="additionalCollar">增领</label> <input id="other_2"
						type="radio" name="cradtype" value="1"
						<c:if test="${student.busitype==2}"> checked='checked'</c:if>>
					<label for="other_2">其它</label>
				</div>
				<div class="field-box success">
					<label>驾驶证号:</label> <input class="span5" type="text"
						name="drilicnum" value="#{student.drilicnum}">
				</div>
				<div class="field-box success">
					<label>初次领证日期:</label> <input class="span5" type="text"
						name="fstdrilicdate" value="#{student.fstdrilicdate}">
				</div>
				<div class="field-box success">
					<label>原准驾车型:</label> <input class="span5" type="text"
						name="perdritype" value="#{student.perdritype}">
				</div>
				<div class="field-box success">
					<label>培训车型:</label> <input class="span5" type="text"
						name="traintype" value="#{student.traintype}">
				</div>
				<div class="field-box success">
					<label>报名时间:</label> <input class="span5" type="text"
						name="applydate" value="#{student.applydate}">
				</div>
				<div class="field-box success">
					<label>状态:</label>
					<!-- <input class="span5" type="text" name="status"> -1-失效 1-报名 2-学习中 3- 拿到驾照 -->
					<input id="failure" type="radio" name="cradtype" value="1"
						<c:if test="${student.status==-1}"> checked='checked'</c:if>>
					<label for="failure">失效 </label> <input id="registration"
						type="radio" name="cradtype" value="1"
						<c:if test="${student.status==1}"> checked='checked'</c:if>>
					<label for="registration">报名</label> <input id="learning"
						type="radio" name="cradtype" value="1"
						<c:if test="${student.status==2}"> checked='checked'</c:if>>
					<label for="learning">学习中</label> <input id="license" type="radio"
						name="cradtype" value="1"
						<c:if test="${student.status==3}"> checked='checked'</c:if>>
					<label for="license">拿到驾照 </label>
				</div>
			</form>
		</div>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-primary" onClick="save();">保存</button>
	</div>

	<!-- 列表 -->
	<div class="row-fluid">
		<div class="sub_content">
			<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
			<div id="table_list" class="gri_wrapper"></div>
		</div>
	</div>

	<!-- Modal 弹出的编辑界面-->
	<div class="modal fade" id="editorModal" tabindex="-1" role="dialog"
		aria-labelledby="editorModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">学生</h4>
				</div>
				<div class="modal-body">
					<h4>学生信息录入失败，请确认录入信息是否正确。</h4>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>



	<script type="text/javascript">
		//保存
		function save() {
			//从form中取参数值
			var id = $('#ediorForm input[name="id"]').val();
			var userId = $('#ediorForm input[name="userId"]').val();
			var insId = $('#ediorForm input[name="insId"]').val();
			var name = $('#ediorForm input[name="name"]').val();
			var mobile = $('#ediorForm input[name="mobile"]').val();
			var cradtype = $('#ediorForm input[name="cradtype"]').val();
			var idcard = $('#ediorForm input[name="idcard"]').val();
			var nationality = $('#ediorForm input[name="nationality"]').val();
			var sex = $('#ediorForm input[name="sex"]').val();
			var address = $('#ediorForm input[name="address"]').val();
			var photo = $('#ediorForm input[name="photo"]').val();
			var fingerprint = $('#ediorForm input[name="fingerprint"]').val();
			var busitype = $('#ediorForm input[name="busitype"]').val();
			var drilicnum = $('#ediorForm input[name="drilicnum"]').val();
			var fstdrilicdate = $('#ediorForm input[name="fstdrilicdate"]').val();
			var perdritype = $('#ediorForm input[name="perdritype"]').val();
			var traintype = $('#ediorForm input[name="traintype"]').val();
			var applydate = $('#ediorForm input[name="applydate"]').val();
			var status = $('#ediorForm input[name="status"]').val();
			var stunum = $('#ediorForm input[name="stunum"]').val();
			//定义提交到服务端的数据对象
			var params = {
				'id' : id,
				"userId" : userId,
				"insId" : insId,
				"name" : name,
				"mobile" : mobile,
				"cradtype" : cradtype,
				"idcard" : idcard,
				"nationality" : nationality,
				"sex" : sex,
				"address" : address,
				"photo" : photo,
				"fingerprint" : fingerprint,
				"busitype" : busitype,
				"drilicnum" : drilicnum,
				"fstdrilicdate" : fstdrilicdate,
				"perdritype" : perdritype,
				"traintype" : traintype,
				"applydate" : applydate,
				"status" : status,
				"stunum" : stunum
			};
			//发送数据到后端保存
			$.post('${ctx}/student', params, function(result) {
				if (result.code == 200) {
					//保存成功 返回刷新列表
					window.location.href="${ctx}/student";
				}else{
					//打开错误提示框
					$('#editorModal').modal('show');
				}
			});
		}
		
		function clickModal(){
			//关闭错误提示框
			$('#editorModal').modal('hide');
		}
	</script>
</body>
</html>