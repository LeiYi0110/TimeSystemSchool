<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
<meta name="theme" content="school" />
<script type="text/javascript" src="${ctx}/resources/js/form-prompt/Validform_v5.3.2_min.js"></script>
<title>教学大纲</title>
</head>
<body>
	<div class="row-fluid">
		<div class="outline">
			<!-- 头部  -->
			<ul id="myTab" class="nav nav-tabs">
              <li class="active"><a href="#C1" data-toggle="tab">C1</a></li>
              <li class=""><a href="#C2" data-toggle="tab">C2</a></li>
            </ul>
 
			<div class="tab-content">
			  <!-- C1的容器 -->
			  <div class="tab-pane active" id="C1">
			  	<form class="form-inline">
			  		<div class="sum">
						<h5>部分一总学时:<b class="c1-subject1-sum">0</b> （根据规定，第一部分不得少于12小时）</h5>			  		
			  		</div>
			  		<label>
			  			<div class="label-control">机动车驾驶证申领与使用:</div>
			  			<input type="number" min="0" max="99" name="licenseAndUse" class="width25 c1-subject1" value="0" >学时
			  		</label>
				  	<label>
			  			<div class="label-control">道路通行规则:</div>
			  			<input type="number" min="0" max="99" name="trafficRules" class="width25 c1-subject1" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">驾驶行为:</div>
			  			<input type="number" min="0" max="99" name="drivingBehavior" class="width25 c1-subject1" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">违法行为处罚:</div>
			  			<input type="number" min="0" max="99" name="illegalPunishment" class="width25 c1-subject1" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">机动车登记:</div>
			  			<input type="number" min="0" max="99" name="vehicleRegistration" class="width25 c1-subject1" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">交通事故处理:</div>
			  			<input type="number" min="0" max="99" name="trafficAccident" class="width25 c1-subject1" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">地方性法规:</div>
			  			<input type="number" min="0" max="99" name="localRegulations" class="width25 c1-subject1" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">车辆结构常识:</div>
			  			<input type="number" min="0" max="99" name="vehicleStructure" class="width25 c1-subject1" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">车辆主要安全装置:</div>
			  			<input type="number" min="0" max="99" name="vehicleMainSafety" class="width25 c1-subject1" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">驾驶操纵机构的作用:</div>
			  			<input type="number" min="0" max="99" name="operatingMechanism" class="width25 c1-subject1" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">车辆性能:</div>
			  			<input type="number" min="0" max="99" name="vehiclePerformance" class="width25 c1-subject1" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">车辆检查和维护:</div>
			  			<input type="number" min="0" max="99" name="inspectionMaintenance" class="width25 c1-subject1" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">车辆运行材料:</div>
			  			<input type="number" min="0" max="99" name="vehicleMaterial" class="width25 c1-subject1" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">相关法律、法规:</div>
			  			<input type="number" min="0" max="99" name="lawsRegulations" class="width25 c1-subject1" value="0" >学时
			  		</label>
			  		<div class="sum">
						<h5>部分二总学时:<b class="c1-subject2-sum">0</b> （根据规定，第二部分不得少于16学时）</h5>			  		
			  		</div>
			  		<label>
			  			<div class="label-control">基础驾驶操作理论知识:</div>
			  			<input type="number" min="0" max="99" name="basistheoryKnowledge" class="width25 c1-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">驾驶姿势:</div>
			  			<input type="number" min="0" max="99" name="drivingPosition" class="width25 c1-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">操控装置的规范操作:</div>
			  			<input type="number" min="0" max="99" name="operationSpecification" class="width25 c1-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">起步前车辆检查与调整:</div>
			  			<input type="number" min="0" max="99" name="inspectionAdjustment" class="width25 c1-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">上下车动作:</div>
			  			<input type="number" min="0" max="99" name="boardingActions" class="width25 c1-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">上下车前的检查:</div>
			  			<input type="number" min="0" max="99" name="checkUpFront" class="width25 c1-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">起步、停车:</div>
			  			<input type="number" min="0" max="99" name="startStop" class="width25 c1-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">变档、换挡、倒车:</div>
			  			<input type="number" min="0" max="99" name="shiftAstern" class="width25 c1-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">行驶位置和路线:</div>
			  			<input type="number" min="0" max="99" name="positionRoute" class="width25 c1-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">场地驾驶理论知识:</div>
			  			<input type="number" min="0" max="99" name="drivingtheoryKnowledge" class="width25 c1-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">倒车入库:</div>
			  			<input type="number" min="0" max="99" name="treasury" class="width25 c1-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">定点停车与起步:</div>
			  			<input type="number" min="0" max="99" name="parkingStarted" class="width25 c1-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">侧方停车:</div>
			  			<input type="number" min="0" max="99" name="sideParking" class="width25 c1-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">曲线行驶车:</div>
			  			<input type="number" min="0" max="99" name="curve" class="width25 c1-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">直角拐弯:</div>
			  			<input type="number" min="0" max="99" name="rightAngleBend" class="width25 c1-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">模拟城市街道驾驶:</div>
			  			<input type="number" min="0" max="99" name="drivingCityStreets" class="width25 c1-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">跟车行驶:</div>
			  			<input type="number" min="0" max="99" name="withCarDriving" class="width25 c1-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">独立行驶:</div>
			  			<input type="number" min="0" max="99" name="independentDriving" class="width25 c1-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">基础和场地驾驶:</div>
			  			<input type="number" min="0" max="99" name="basisDrivingField" class="width25 c1-subject2" value="0" >学时
			  		</label>
			  		<div class="sum">
						<h5>部分三总学时:<b class="c1-subject3-sum">0</b> （根据规定，第三部分不得少于24学时）</h5>			  		
			  		</div>
			  		<label>
			  			<div class="label-control">跟车行驶:</div>
			  			<input type="number" min="0" max="99" name="carDrivingThree" class="width25 c1-subject3" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">变更车道:</div>
			  			<input type="number" min="0" max="99" name="changeLanes" class="width25 c1-subject3" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">靠边停车:</div>
			  			<input type="number" min="0" max="99" name="pullOver" class="width25 c1-subject3" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">掉头:</div>
			  			<input type="number" min="0" max="99" name="turnAround" class="width25 c1-subject3" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">通过路口:</div>
			  			<input type="number" min="0" max="99" name="intersection" class="width25 c1-subject3" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">通过人行横道:</div>
			  			<input type="number" min="0" max="99" name="pedestrianCrossing" class="width25 c1-subject3" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">通过学校区域:</div>
			  			<input type="number" min="0" max="99" name="schoolArea" class="width25 c1-subject3" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">通过公共汽车站:</div>
			  			<input type="number" min="0" max="99" name="busStop" class="width25 c1-subject3" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">会车:</div>
			  			<input type="number" min="0" max="99" name="passing" class="width25 c1-subject3" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">超车:</div>
			  			<input type="number" min="0" max="99" name="overtaking" class="width25 c1-subject3" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">夜间行驶:</div>
			  			<input type="number" min="0" max="99" name="drivingAtNight" class="width25 c1-subject3" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">恶劣条件下的驾驶:</div>
			  			<input type="number" min="0" max="99" name="badDriving" class="width25 c1-subject3" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">综合驾驶及考核:</div>
			  			<input type="number" min="0" max="99" name="drivingAndTested" class="width25 c1-subject3" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">山区道路驾驶:</div>
			  			<input type="number" min="0" max="99" name="mountain" class="width25 c1-subject3" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">高速公路驾驶:</div>
			  			<input type="number" min="0" max="99" name="highwayDriving" class="width25 c1-subject3" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">行驶路线选择:</div>
			  			<input type="number" min="0" max="99" name="routeChoice" class="width25 c1-subject3" value="0" >学时
			  		</label>
			  		<div class="sum">
						<h5>部分四总学时:<b class="c1-subject4-sum">0</b> （根据规定，第四部分不得少于10学时）</h5>			  		
			  		</div>
			  		<label>
			  			<div class="label-control">安全、文明驾驶知识:</div>
			  			<input type="number" min="0" max="99" name="civilizedDrivingKnow" class="width25 c1-subject4" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">危险源辨知识:</div>
			  			<input type="number" min="0" max="99" name="hazardsDistinguishes" class="width25 c1-subject4" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">紧急情况处理:</div>
			  			<input type="number" min="0" max="99" name="emergencyTreatment" class="width25 c1-subject4" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">危险化学品知识:</div>
			  			<input type="number" min="0" max="99" name="dangerousChemicals" class="width25 c1-subject4" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">夜间和高速路安全驾驶知识:</div>
			  			<input type="number" min="0" max="99" name="drivingSafetyKnow" class="width25 c1-subject4" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">典型事故案例分析:</div>
			  			<input type="number" min="0" max="99" name="caseAnalysis" class="width25 c1-subject4" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">综合复习及考核:</div>
			  			<input type="number" min="0" max="99" name="reviewAssessment" class="width25 c1-subject4" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">恶劣气候和复杂情况下安全驾驶:</div>
			  			<input type="number" min="0" max="99" name="badWeather" class="width25 c1-subject4" value="0" >学时
			  		</label>
			  		<div id="btn-wrap" style="text-align: center; padding-top: 40px;">
						<input id="save_btn" type="button" class="btn-flat primary" value="提交备案">
					</div>
				</form>
			  </div>
			  
			  <!-- C2的容器 -->
			  <div class="tab-pane" id="C2">
			  	<form class="form-inline">
			  		<div class="sum">
						<h5>科目一总学时:<b class="c2-subject1-sum">0</b> （根据规定，科目一不得少于12小时）</h5>			  		
			  		</div>
			  		<label>
			  			<div class="label-control">机动车驾驶证申领与使用:</div>
			  			<input type="number" min="0" max="99" name="licenseAndUse" class="width25 c2-subject1" value="0" >学时
			  		</label>
				  	<label>
			  			<div class="label-control">道路通行规则:</div>
			  			<input type="number" min="0" max="99" name="trafficRules" class="width25 c2-subject1" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">驾驶行为:</div>
			  			<input type="number" min="0" max="99" name="drivingBehavior" class="width25 c2-subject1" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">违法行为处罚:</div>
			  			<input type="number" min="0" max="99" name="illegalPunishment" class="width25 c2-subject1" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">机动车登记:</div>
			  			<input type="number" min="0" max="99" name="vehicleRegistration" class="width25 c2-subject1" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">交通事故处理:</div>
			  			<input type="number" min="0" max="99" name="trafficAccident" class="width25 c2-subject1" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">地方性法规:</div>
			  			<input type="number" min="0" max="99" name="localRegulations" class="width25 c2-subject1" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">车辆结构常识:</div>
			  			<input type="number" min="0" max="99" name="vehicleStructure" class="width25 c2-subject1" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">车辆主要安全装置:</div>
			  			<input type="number" min="0" max="99" name="vehicleMainSafety" class="width25 c2-subject1" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">驾驶操纵机构的作用:</div>
			  			<input type="number" min="0" max="99" name="operatingMechanism" class="width25 c2-subject1" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">车辆性能:</div>
			  			<input type="number" min="0" max="99" name="vehiclePerformance" class="width25 c2-subject1" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">车辆检查和维护:</div>
			  			<input type="number" min="0" max="99" name="inspectionMaintenance" class="width25 c2-subject1" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">车辆运行材料:</div>
			  			<input type="number" min="0" max="99" name="vehicleMaterial" class="width25 c2-subject1" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">相关法律、法规:</div>
			  			<input type="number" min="0" max="99" name="lawsRegulations" class="width25 c2-subject1" value="0" >学时
			  		</label>
			  		<div class="sum">
						<h5>科目二总学时:<b class="c2-subject2-sum">0</b> （根据规定，科目二不得少于14学时）</h5>			  		
			  		</div>
			  		<label>
			  			<div class="label-control">基础驾驶操作理论知识:</div>
			  			<input type="number" min="0" max="99" name="basistheoryKnowledge" class="width25 c2-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">驾驶姿势:</div>
			  			<input type="number" min="0" max="99" name="drivingPosition" class="width25 c2-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">操控装置的规范操作:</div>
			  			<input type="number" min="0" max="99" name="operationSpecification" class="width25 c2-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">起步前车辆检查与调整:</div>
			  			<input type="number" min="0" max="99" name="inspectionAdjustment" class="width25 c2-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">上下车动作:</div>
			  			<input type="number" min="0" max="99" name="boardingActions" class="width25 c2-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">上下车前的检查:</div>
			  			<input type="number" min="0" max="99" name="checkUpFront" class="width25 c2-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">起步、停车:</div>
			  			<input type="number" min="0" max="99" name="startStop" class="width25 c2-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">变档、换挡、倒车:</div>
			  			<input type="number" min="0" max="99" name="shiftAstern" class="width25 c2-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">行驶位置和路线:</div>
			  			<input type="number" min="0" max="99" name="positionRoute" class="width25 c2-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">场地驾驶理论知识:</div>
			  			<input type="number" min="0" max="99" name="drivingtheoryKnowledge" class="width25 c2-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">倒车入库:</div>
			  			<input type="number" min="0" max="99" name="treasury" class="width25 c2-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">定点停车与起步:</div>
			  			<input type="number" min="0" max="99" name="parkingStarted" class="width25 c2-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">侧方停车:</div>
			  			<input type="number" min="0" max="99" name="sideParking" class="width25 c2-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">曲线行驶车:</div>
			  			<input type="number" min="0" max="99" name="curve" class="width25 c2-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">直角拐弯:</div>
			  			<input type="number" min="0" max="99" name="rightAngleBend" class="width25 c2-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">模拟城市街道驾驶:</div>
			  			<input type="number" min="0" max="99" name="drivingCityStreets" class="width25 c2-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">跟车行驶:</div>
			  			<input type="number" min="0" max="99" name="withCarDriving" class="width25 c2-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">独立行驶:</div>
			  			<input type="number" min="0" max="99" name="independentDriving" class="width25 c2-subject2" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">基础和场地驾驶:</div>
			  			<input type="number" min="0" max="99" name="basisDrivingField" class="width25 c2-subject2" value="0" >学时
			  		</label>
			  		<div class="sum">
						<h5>科目三总学时:<b class="c2-subject3-sum">0</b> （根据规定，科目三不得少于24学时）</h5>			  		
			  		</div>
			  		<label>
			  			<div class="label-control">跟车行驶:</div>
			  			<input type="number" min="0" max="99" name="carDrivingThree" class="width25 c2-subject3" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">变更车道:</div>
			  			<input type="number" min="0" max="99" name="changeLanes" class="width25 c2-subject3" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">靠边停车:</div>
			  			<input type="number" min="0" max="99" name="pullOver" class="width25 c2-subject3" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">掉头:</div>
			  			<input type="number" min="0" max="99" name="turnAround" class="width25 c2-subject3" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">通过路口:</div>
			  			<input type="number" min="0" max="99" name="intersection" class="width25 c2-subject3" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">通过人行横道:</div>
			  			<input type="number" min="0" max="99" name="pedestrianCrossing" class="width25 c2-subject3" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">通过学校区域:</div>
			  			<input type="number" min="0" max="99" name="schoolArea" class="width25 c2-subject3" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">通过公共汽车站:</div>
			  			<input type="number" min="0" max="99" name="busStop" class="width25 c2-subject3" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">会车:</div>
			  			<input type="number" min="0" max="99" name="passing" class="width25 c2-subject3" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">超车:</div>
			  			<input type="number" min="0" max="99" name="overtaking" class="width25 c2-subject3" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">夜间行驶:</div>
			  			<input type="number" min="0" max="99" name="drivingAtNight" class="width25 c2-subject3" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">恶劣条件下的驾驶:</div>
			  			<input type="number" min="0" max="99" name="badDriving" class="width25 c2-subject3" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">综合驾驶及考核:</div>
			  			<input type="number" min="0" max="99" name="drivingAndTested" class="width25 c2-subject3" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">山区道路驾驶:</div>
			  			<input type="number" min="0" max="99" name="mountain" class="width25 c2-subject3" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">高速公路驾驶:</div>
			  			<input type="number" min="0" max="99" name="highwayDriving" class="width25 c2-subject3" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">行驶路线选择:</div>
			  			<input type="number" min="0" max="99" name="routeChoice" class="width25 c2-subject3" value="0" >学时
			  		</label>
			  		<div class="sum">
						<h5>科目四总学时:<b class="c2-subject4-sum">0</b> （根据规定，科目四不得少于10学时）</h5>			  		
			  		</div>
			  		<label>
			  			<div class="label-control">安全、文明驾驶知识:</div>
			  			<input type="number" min="0" max="99" name="civilizedDrivingKnow" class="width25 c2-subject4" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">危险源辨知识:</div>
			  			<input type="number" min="0" max="99" name="hazardsDistinguishes" class="width25 c2-subject4" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">紧急情况处理:</div>
			  			<input type="number" min="0" max="99" name="emergencyTreatment" class="width25 c2-subject4" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">危险化学品知识:</div>
			  			<input type="number" min="0" max="99" name="dangerousChemicals" class="width25 c2-subject4" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">夜间和高速路安全驾驶知识:</div>
			  			<input type="number" min="0" max="99" name="drivingSafetyKnow" class="width25 c2-subject4" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">典型事故案例分析:</div>
			  			<input type="number" min="0" max="99" name="caseAnalysis" class="width25 c2-subject4" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">综合复习及考核:</div>
			  			<input type="number" min="0" max="99" name="reviewAssessment" class="width25 c2-subject4" value="0" >学时
			  		</label>
			  		<label>
			  			<div class="label-control">恶劣气候和复杂情况下安全驾驶:</div>
			  			<input type="number" min="0" max="99" name="badWeather" class="width25 c2-subject4" value="0" >学时
			  		</label>
			  		<div id="btn-wrap" style="text-align: center; padding-top: 40px;">
						<input id="save_btn2" type="button" class="btn-flat primary" value="提交备案">
					</div>
				</form>
			  </div>
			</div>
		</div>
	</div>
<script type="text/javascript">
var insId= <sec:authentication property="principal.insId"/>;

$(function(){
	
	/**     
	* sum()方法是对用来更新单个科目总学时     
	* 参数：   selector：监控目标的选择集合
	*      sumDom：     求和目标的document
	*/  
	function sum(selector,sumDom){
		var selector = $(selector);
		var sumDom = $(sumDom);
		var sumVal = 0;
		selector.each(function(){
			if($(this).val() === ""){
				$(this).val(0);
				sumVal += 0;
			}else if( parseInt($(this).val()) > 99 ){
				$(this).val(99);
				sumVal += 99;
			}else if( parseInt($(this).val()) < 0 ){
				$(this).val(0);
				sumVal += 0;
			}else{
				sumVal += parseInt($(this).val());
			}
		})
		sumDom.html(sumVal);
	};
	
	function myWatch(selector,sumDom){
		var _selector = $(selector);
		_selector.focus(function(){
			$(this).change(function(){
				sum(selector,sumDom);
			})
		})
	}
	
	
	// C1科目一监控
	myWatch(".c1-subject1",".c1-subject1-sum");
	// C1科目二监控
	myWatch(".c1-subject2",".c1-subject2-sum");
	// C1科目三监控
	myWatch(".c1-subject3",".c1-subject3-sum");
	// C1科目四监控
	myWatch(".c1-subject4",".c1-subject4-sum");
	// C2科目一监控
	myWatch(".c2-subject1",".c2-subject1-sum");
	// C2科目二监控
	myWatch(".c2-subject2",".c2-subject2-sum");
	// C2科目三监控
	myWatch(".c2-subject3",".c2-subject3-sum");
	// C2科目四监控
	myWatch(".c2-subject4",".c2-subject4-sum");
	
	/* C1备份  */
	$("#save_btn").click(function(){
		var formdata = $("#C1 form").serializeArray();
		var subject1 = parseInt($(".c1-subject1-sum").html());
		var subject2 = parseInt($(".c1-subject2-sum").html());
		var subject3 = parseInt($(".c1-subject3-sum").html());
		var subject4 = parseInt($(".c1-subject4-sum").html());
		if( subject1 < 12 ){
			layer.alert('科目一不得少于12小时');
		}else if( subject2 < 16 ){
			layer.alert('科目二不得少于16学时');
		}else if( subject3 < 24 ){
			layer.alert('根科目三不得少于24学时');
		}else if( subject4 < 10 ){
			layer.alert('根科目三不得少于10学时');
		}else{
			var otherParam=[
				{name:"insId",
				value:insId},
				{name:"cartype",
				value:"C1"},
				{name:"subOneCourseNum",
				value:subject1},
				{name:"subTwoCourseNum",
				value:subject2},
				{name:"subThreeCourseNum",
				value:subject3},
				{name:"subFourCourseNum",
				value:subject4}];
			for( var i=0; i<otherParam.length; i++ ){
				formdata.push(otherParam[i]);
			}
			$.post('${ctx}/teachoutline/add',formdata,function(res){
				if(res.code === 200){
					if(res.message!="教学大纲更新成功"){
						layer.alert('C1教学大纲备案成功');
					}else{
						layer.alert('C1'+res.message);
					}
				}else{
					layer.alert('备案失败,错误代码：'+res.code);
				}
			},'json');
		}
	});
	
	/* C2备份  */
	$("#save_btn2").click(function(){
		var formdata = $("#C2 form").serializeArray();
		
		var subject1 = parseInt($(".c2-subject1-sum").html());
		var subject2 = parseInt($(".c2-subject2-sum").html());
		var subject3 = parseInt($(".c2-subject3-sum").html());
		var subject4 = parseInt($(".c2-subject4-sum").html());
		if( subject1 < 12 ){
			layer.alert('科目一不得少于12小时');
		}else if( subject2 < 14 ){
			layer.alert('科目二不得少于14学时');
		}else if( subject3 < 24 ){
			layer.alert('根科目三不得少于24学时');
		}else if( subject4 < 10 ){
			layer.alert('根科目三不得少于10学时');
		}else{
			var otherParam=[
				{name:"insId",
				value:insId},
				{name:"cartype",
				value:"C2"},
				{name:"subOneCourseNum",
				value:subject1},
				{name:"subTwoCourseNum",
				value:subject2},
				{name:"subThreeCourseNum",
				value:subject3},
				{name:"subFourCourseNum",
				value:subject4}];
			for( var i=0; i<otherParam.length; i++ ){
				formdata.push(otherParam[i]);
			}
			$.post('${ctx}/teachoutline/add',formdata,function(res){
				if(res.code === 200){
					if(res.message!="教学大纲更新成功"){
						layer.alert('C2教学大纲备案成功');
					}else{
						layer.alert('C2'+res.message);
					}
				}else{
					layer.alert('备案失败,错误代码：'+res.code);
				}
			},'json');
		} 
		
	});
	
})
</script>
</body>
</html>
