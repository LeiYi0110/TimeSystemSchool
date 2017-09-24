<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
	<meta name="theme" content="school" />
	<title>阳光驾培-网点排班</title>	
	<link href="${ctx}/resources/css/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen" />
	<script src="${ctx}/resources/uploadify/jquery.uploadify.js"></script>
	<script type="text/javascript" src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
	<script type="text/javascript" src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
	<script type="text/javascript" src="${ctx}/resources/js/classType/<sec:authentication property="principal.insId"/>"></script>
	<script type="text/javascript" src="${ctx}/resources/js/jquery-form.js"></script>
	<script type="text/javascript" src="${ctx}/resources/js/serviceStation/<sec:authentication property="principal.insId"/>"></script>
	<script type="text/javascript" src="${ctx}/resources/js/Area/<sec:authentication property="principal.insId"/>"></script>
	<script type="text/javascript" src="${ctx}/resources/js/StationCoach"></script>
</head>

<body>
	<div class="container-fluid new-admin">
		<div class="select-top">
		<sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
			<a class="select-btn" onclick="exportFile();"><span class="Export"></span>导出</a>
		</sec:authorize>
		
		<sec:authorize access="hasRole('ROLE_SCHOOL_SERVICE')">
			<sec:authorize access="hasRole('ROLE_UserOperation_160')">
				<a class="select-btn" onclick="exportFile();"><span class="Export"></span>导出</a>
			</sec:authorize>
		</sec:authorize>
		</div>
	</div>

	<div class="TermSearch">
		<form>
			<sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
				<select id="areaId" name="areaId">
				</select>
				<select id="stationId" name="stationId">
				</select>
				<input class="input1" type="text" id="searchKeyWord" name="searchKeyWord" placeholder="身份证号/手机号码/教练名称名称搜索 " />
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_SCHOOL_SERVICE')">
				<select id="coachId" name="coachId">
				</select>
			</sec:authorize>
			<button class="btn-flat primary" onClick="loadDutyData();return false;">搜索</button>
		</form>

	</div>

	<!-- 列表 -->
	<div class="row-fluid">
		<div class="Scheduling-tab">
			<table >
				<thead>
					<tr id="thdtr">
					</tr>
				</thead>
				<tbody id="tbd">
				</tbody>
			</table>
		</div>
	</div>
	
	<!-- 设置是否休息 -->
	<div class="modal fade" id="editorModal" tabindex="-1" role="dialog"
		aria-labelledby="editorModalLabel" aria-hidden="true"
		style="z-index: 2000; width: 360px;">
		<div class="modal-dialog">
			<div class="modal-body" style="padding: 0 0 0 30px;">
				<form id="ediorForm">
					<input type="hidden" id="coachId" value=""> <input
						type="hidden" id="time" value=""> <input type="hidden"
						id="day" value=""> <input type="hidden" id="subjectId"
						value="">
					<div class="row-fluid" style="padding-top: 40px;">
						<div class="span3">时段开关:</div>
						<div class="span2">
							<input type="radio" id="status" name="status" value="3">开
						</div>
						<div class="span2">
							<input type="radio" id="status" name="status" value="0">关
						</div>
					</div>
					<div class="row-fluid">
						<div class="span3">指定学员:</div>
						<div class="span9">
							<input type="text" id="tt" autocomplete="off" value=""
								class="text" />
						</div>
						<div class="span9">
							<input type="text" id="stuId" value="" class="hidden" />
							<input type="text" id="stuMobile" value="" class="hidden"/>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" onClick="save();">保存</button>
			</div>
		</div>
	</div>


	<script type="text/javascript">
	
	var searchCoach;
	var selectData = {}; //当前选中这一天的这个小时约车安排的参数 //针对学员安排弹框
	var searchResult = { id : 0 }; //教练查询参数集 //针对教练搜索框 
	
	//初始化 
	$(document).ready(function() {
		initSelected();

		for(var item in stationCoach){
			var node = document.createElement('option');
			$(node).attr("value",stationCoach[item].id);
			$(node).html(stationCoach[item].name);
			$("#coachId").append(node);
		}
		if(stationCoach.length > 0){
			searchResult.id = stationCoach[0].id;
		}
		$("#coachId").change(function(){
			searchResult.id = Number($(this).val());
		});
		
		loadDutyData();
	});
	
	/*初始化网点，片区下拉框*/
	function initSelected(){
		$('#stationId').append("<option value='0'>全部网点</option>");
		$(serviceStations).each(function(item){
			$('#stationId').append("<option value='" + this.id + "'>" + this.name + "</option>");
		});
		
		$('#areaId').append("<option value='0'>全部片区</option>");
		$(areas).each(function(item){
			$('#areaId').append("<option value='" + this.id + "'>" + this.name + "</option>");
		});
		$('#areaId').change(function(){
			var thisValue = $(this).val();
			$('#stationId').empty();
			$('#stationId').append("<option value='0'>全部网点</option>");
			$(serviceStations).each(function(){
				if(Number($('#areaId').val()) === 0 || Number($('#areaId').val()) === this.areaId){
					$('#stationId').append("<option value='" + this.id + "'>" + this.name + "</option>");
				}
			});
		});
	}
	
	//清理表格 
	function clearLoadDutyData(){
		$("#thdtr").empty();
		$("#tbd").empty();
	}
	//加载列表
	function loadDutyData(){
		
		$.ajax({
			url : "${ctx}/coach/exerciseManage",
			data : {
				coachId : isNaN(Number(searchResult.id)) ? 0 : searchResult.id,
 				areaId : ($("#areaId").val() != undefined ?  $("#areaId").val() : 0),
				stationId : ($("#stationId").val() != undefined ?  $("#stationId").val() : 0),
				searchText : (!!$("#searchKeyWord").val() ? $("#searchKeyWord").val() : '')
			},
			type : "get",
			dataType : "json",
			success:function(data){
				if(data.code == 705){
					var coachList = data.data;	
					$("#searchKeyWord").bigAutocomplete({
				        data:coachList,
				        callback:function(data){
				        	searchResult.id = data.result;
				        }
				    });

					clearLoadDutyData();
					layer.open({
						  content: '符合搜索条件的教练有多个，请明确条件或选择一个教练后再点击搜索',
						  scrollbar: false
						});//多个教练
				}else if(data.code == 706){
					clearLoadDutyData();
					layer.open({
						  content: '没有符合搜索条件的教练',
						  scrollbar: false
						});//没有教练
				}else if(data.code == 200){
					//成功获取	
					var data = data.data;
					
					//打印表头
					var node = $("#thdtr");
					node.empty();
					node.append("<th>时间<\/th>")
					for(var index in data){
						var time = new Date(data[index].dayTimeStamps);
						var th = document.createElement("th");
						$(th).html((time.getMonth()+1)+"月"+time.getDate()+"日");
						node.append(th);
					}
					
					var bodyNode = $("#tbd");
					bodyNode.empty();
					var trStatus = document.createElement("tr");
					$(trStatus).append("<td>状态<\/td>")
					for(var index in data){
						var text = data[index].publish == 1 ? "已发布" : "未发布";
						searchResult.resultCoachName = data[index].name;
						
						var statusTd = document.createElement("td");
						$(statusTd).attr("name","setDutyStatus");
						$(statusTd).attr("data-coachId",data[index].coachId);
						$(statusTd).attr("data-dayTimeStamps",data[index].dayTimeStamps);
						$(statusTd).attr("data-publish",data[index].publish);
						
						if(data[index].publish == 1){
							$(statusTd).attr("class","gray");
							$(statusTd).html(text);
						}
						else{
							$(statusTd).attr("class","blue");
							var statusTda = document.createElement("a");
							$(statusTda).html(text);
							$(statusTd).append(statusTda);
						}
						
						$(trStatus).append(statusTd);
						
					}
					bodyNode.append(trStatus);
					
					for(var index= 6 ;index < 22 ;index++){
						var trNode = document.createElement("tr");
						var titleTrNode = document.createElement("td");
						$(titleTrNode).html(index.toString() + ":00-" + (index+1).toString() + ":00");
						$(trNode).append(titleTrNode);
						
						for(var objIndex in data){
							var valueKey = "f" + index;
							var key = "f"+index+"s";
							var mobileKey = "f"+index+"m";
							var stuNameKey = "f"+index+"s";
							var valueNode = document.createElement("td");
							var optionUserNameKey = "f" + index + "o";
							var studentIdKey = "f" + index + "i";
							
							$(valueNode).attr("name","setCoachDuty");
							$(valueNode).attr("data-coachId",data[objIndex].coachId);
							$(valueNode).attr("data-dayTimeStamps",data[objIndex].dayTimeStamps);
							$(valueNode).attr("data-publish",data[objIndex].publish);
							$(valueNode).attr("data-hour",index);
							$(valueNode).attr("data-value",data[objIndex][valueKey]);
							$(valueNode).attr("data-stuName",data[objIndex][stuNameKey]);
							$(valueNode).attr("data-mobile",data[objIndex][mobileKey]);
							$(valueNode).attr("data-stuId",data[objIndex][studentIdKey]);
							
							if(data[objIndex][mobileKey] != null){
								var ulNode = document.createElement("ul");
								var liNameNode = document.createElement("li");
								var liMobileNode = document.createElement("li");
								var liOptionName = document.createElement("li");
								
								$(liNameNode).html(data[objIndex][stuNameKey]);
								$(liMobileNode).html(data[objIndex][mobileKey]);
								$(liOptionName).html("操作人:" + data[objIndex][optionUserNameKey]);
								
								$(ulNode).append(liNameNode);
								$(ulNode).append(liMobileNode);
								$(ulNode).append(liOptionName);
								$(valueNode).append(ulNode);
							}
							else{
								$(valueNode).html(data[objIndex][key]);
							}
							$(trNode).append(valueNode);
						}
						bodyNode.append(trNode);
					}
					
					//绑定事件
					//保存是否发布
					$("[name=setDutyStatus][data-publish=0]").click(function(){
						
						selectData = {};
						selectData.coachId = $(this).attr("data-coachId");
						selectData.timeStamp = $(this).attr("data-dayTimeStamps");
						selectData.publish = $(this).attr("data-publish");
						$("#coachId").val(selectData.coachId);
						
						if(Number(selectData.publish) == 0){
							selectData.selectNode = this;
							
							//确认发布
							layer.confirm('发布之后学员可以直接从手机APP上预约', {
								title : '确认发布',
								btn: ['是','否'],
								btn1 : function(index, layero) {
									saveDutyData();
								}
							});
						};
					});
					
					//设置约车
					$("[name=setCoachDuty]").click(function(){
						selectData = {};
						selectData.coachId = $(this).attr("data-coachId");
						selectData.timeStamp = $(this).attr("data-dayTimeStamps");
						selectData.publish = $(this).attr("data-publish");
						selectData.hour = $(this).attr("data-hour");
						selectData.selectNode = this;
						
						if($(this).attr("data-mobile") != undefined){
							$("#tt").val($(this).attr("data-stuname"));
						}else{
							$("#tt").val("");
						}
						
						$("#coachId").val(selectData.coachId);
						
						$("input:radio[name='status']").attr("checked",null);
						$("input:radio[name='status']").prop("checked",false);
						var thisValue = Number($(this).attr("data-value"));
						if(thisValue == 1 || thisValue == 3){
							var idKey = 'input:radio[name="status"][value=3]';
							$(idKey).prop("checked",true); 
							selectData.status = 1;
						}
						else{
							var idKey = 'input:radio[name="status"][value=0]';
							$(idKey).prop("checked",true); 
							selectData.status = 0;
						}
						
						$('#stuId').val($(this).attr("data-stuId"));
						$("#stuMobile").val($(this).attr("data-mobile"));
						$("#editorModal").modal('show');
						
					});
				}
				else{
					var node = $("#thdtr");
					node.empty();
					$("#tbd").empty();
				}
			},
			error:function(error){
				
			}
		});
	}
	
	//保存发布状态
	function saveDutyData(){
		
		var coachId = selectData.coachId;
		var time = selectData.timeStamp;
		var publish = 1;
		
		$.ajax({
			url : "${ctx}/coach/saveCoachDutyStatus",
			data : {
				coachId : coachId,
				time : time,
				publish : publish
			},
			type : "post",
			dataType : "json",
			success:function(data){
				if(data.code == 200){
					layer.alert("保存成功");
					$(selectData.selectNode).html("已发布");
					$(selectData.selectNode).attr("class","gray");
					
					$(selectData.selectNode).attr("data-publish",1);
					$("#dutyStutas").modal('hide');
				}else{
					layer.alert("保存失败");
				}
			},
			error:function(error){
				
			}
		});
		
	}
	
	//保存约车 
	function save() {
		
		var stringDay = new Date(Number(selectData.timeStamp));
		
		//从form中取参数值
		var coachId = selectData.coachId;
		var day = stringDay.getFullYear()+"-"+(stringDay.getMonth()+1) + "-"+stringDay.getDate();
		var time = selectData.hour;
		var subjectId = 0;
		var status = $('input[name="status"]:checked').val();
		var stuId = isNaN(Number($('#stuId').val())) ? 0 : Number($('#stuId').val());
		
		if(!$("#tt").val().trim()){
			stuId = 0;
		}

		if((stuId=="null" || stuId=='' || stuId==null) && status != 0){
			stuId=0;
			status=1;
		}
		
		if(!!$("#tt").val().trim() && stuId === 0){
			layer.alert("没有匹配的学员无法保存");
			return false;
		}
		
		//定义提交到服务端的数据对象
		var params = {
			'subjectId' : subjectId,
			'coachId' : coachId,
			'time' : time,
			'day' : day,
			'status' : status,
			'stuId' : stuId
		};
		//发送数据到后端保存
		$.post('${ctx}/coach/saveDuty', params, function(result) {
			if (result.code == 200) {
				//保存成功 刷新列表
				//关闭编辑的表单
				var param={
					'coachId' : coachId
				};
				//loadDutyData();
				
				//有学生
				if(Number(stuId) != 0 && Number(status) != 0){
					
					var ulNode = document.createElement("ul");
					var liNameNode = document.createElement("li");
					var liMobileNode = document.createElement("li");
					var optionUserNameNode = document.createElement("li");
					
					$(liNameNode).html($("#tt").val());
					$(liMobileNode).html($("#stuMobile").val());
					try{
						$(optionUserNameNode).html("操作人:" + result.data["optionUserName"]);
					}catch(ex){
						
					}

					$(ulNode).append(liNameNode);
					$(ulNode).append(liMobileNode);
					$(ulNode).append(optionUserNameNode);

					$(selectData.selectNode).empty();
					$(selectData.selectNode).append(ulNode);
					
					$(selectData.selectNode).attr("data-stuName",$("#tt").val());
					$(selectData.selectNode).attr("data-mobile",$("#stuMobile").val());
				}
				else {
					$(selectData.selectNode).html(Number(status) == 1 ? "空闲" : "休息");
					$(selectData.selectNode).attr("data-stuName","");
					$(selectData.selectNode).attr("data-mobile","");
					$(selectData.selectNode).attr("data-value",Number(status) == 1 ? 1 : -1);
				}
				$('#stuId').val(0);
				
				layer.alert("设置成功!");
				$('#editorModal').modal('hide');
			}else{
				layer.alert(result.message);
			}
		});
	}
	
	//弹出指定学员
	 $(function(){
		$("#tt").bigAutocomplete({
			url:'${ctx}/student/getCoachStu',
			callback:function(data){
				$("#stuId").val(data.result);
				$("#stuMobile").val(data.mobile);
			},
			param : {
				type : "post",
				dataType : "json",
				data : {
					keyword : "tt",
					coachId : "coachId",
					subjectId : "subjectId"
				},
				callback : function(result){
					$('#stuId').val(0);//重置选项
					
					var data = result.data;
					if(data.length === 1 && data[0].title === $("#tt").val()){
						$("#stuId").val(data[0].result);
						$("#stuMobile").val(data[0].mobile);
						
						$("#tt").val(data[0].title);
					}
				}
			}
		});
		
		$("#searchKeyWord").bigAutocomplete({
			url : '${ctx}/coach/searchCoach',
			callback : function(data){
				searchResult.id = data.result;
			},
			param : {
				type : "get",
				dataType : "json",
				data : {
					searchKeyWord : "searchKeyWord",
					areaId : "areaId",
					stationId : "stationId"
				}
			}
		});
	});
	 

	</script>
</body>
</html>