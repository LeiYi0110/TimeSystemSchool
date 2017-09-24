<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-评价信息管理</title>
</head>
<body>
	<div class="container-fluid">
		<div id="pad-wrapper">
			<div class="table-wrapper products-table">
				<div class="row-fluid head">
					<div class="span12">
						<h4>评价信息管理</h4>
					</div>
				</div>
				<!-- 搜索 -->
				<div class="row-fluid filter-block">
					<div class="pull-left">
						<select name="choose">
							<option selected="selected" value="1">驾培机构评价信息</option>
							<option value="2">教练评价信息</option>
						</select>
					</div>
					<div class="pull-right">
						<input type="text" class="search" placeholder="search" id="search" />
						<input type="hidden" id="coachId" value=""/>
						<a class="btn-flat small" style="margin-right: 50px;" onClick="searchQuery();return false;">查询</a>
					</div>
				</div>
				<!-- 列表 -->
				<div class="row-fluid">
					<div class="sub_content">
						<div id="ins">
							<table>
								<tr>
									<td>机构名称:<input type="text" id="name" value="" readonly="readonly"> </td>
									<td>5星:<input type="text" id="fiveStar" value="" readonly="readonly"></td>
								</tr>
								<tr>
									<td>统一编号:<input type="text" id="id" value="" readonly="readonly"></td>
									<td>4星:<input type="text" id="fourStar" value="" readonly="readonly"></td>
								</tr>
								<tr>
									<td>综合评价:<input type="text" id="avgStar" value="" readonly="readonly"></td>
									<td>3星:<input type="text" id="threeStar" value="" readonly="readonly"></td>
								</tr>
								<tr>
									<td>评价总数:<input type="text" id="sumStar" value="" readonly="readonly"></td>
									<td>2星:<input type="text" id="twoStar" value="" readonly="readonly"></td>
								</tr>
								<tr>
									<td>1星:<input type="text" id="oneStar" value="" readonly="readonly"></td>
								</tr>
							</table>
						</div>
						<div id="coach">
							<table>
								<tr>
									<td>教练名字:<input type="text" id="cname" value="" readonly="readonly"> </td>
									<td>5星:<input type="text" id="cfiveStar" value="" readonly="readonly"></td>
								</tr>
								<tr>
									<td>统一编号:<input type="text" id="cid" value="" readonly="readonly"></td>
									<td>4星:<input type="text" id="cfourStar" value="" readonly="readonly"></td>
								</tr>
								<tr>
									<td>综合评价:<input type="text" id="cavgStar" value="" readonly="readonly"></td>
									<td>3星:<input type="text" id="cthreeStar" value="" readonly="readonly"></td>
								</tr>
								<tr>
									<td>评价总数:<input type="text" id="csumStar" value="" readonly="readonly"></td>
									<td>2星:<input type="text" id="ctwoStar" value="" readonly="readonly"></td>
								</tr>
								<tr>
									<td>1星:<input type="text" id="coneStar" value="" readonly="readonly"></td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<div>
					评价详情 <select name="stars">
							<option selected="selected" value="">全部</option>
							<option value="5">五星</option>
							<option value="4">四星</option>
							<option value="3">三星</option>
							<option value="2">二星</option>
							<option value="1">一星</option>
						  </select>
					<input type="hidden" id="stars" value="">
					<input type="hidden" id="now" value="0">
				</div>
				<div>
					<table id="tab">
					</table>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		//标识当前页面的url 用来设置当前菜单标识
		var dataTable = null;
		var insId= '<sec:authentication property="principal.insId"/>';
		var insName = '<sec:authentication property="principal.insName"/>';
		var statId= '<sec:authentication property="principal.stationId"/>';
		$(document).ready(function() {
			$("#coach").hide();
			$(".pull-right").hide();
			ins();
		});
		//驾校
		function ins(){
			var star=$("#stars").val();
			var param={
				'insId':insId,
				'star':star
			};
			$.get('${ctx}/comment/getList',param,function(result){
				$("#id").val(result.ins.id);
				$("#name").val(result.ins.name);
				$("#fiveStar").val(result.ins.fiveStar);
				$("#fourStar").val(result.ins.fourStar);
				$("#threeStar").val(result.ins.threeStar);
				$("#twoStar").val(result.ins.twoStar);
				$("#oneStar").val(result.ins.oneStar);
				$("#sumStar").val(result.ins.sumStar);
				$("#avgStar").val(result.ins.avgStar);
				$('#tab').empty();
				var tabHtml = "";
				for(var i=0; i<result.data.length; i++){
				 	tabHtml += '<tr>'
					tabHtml += ('<td>' + result.data[i].stuName + '</td>');
					tabHtml += ('<td>学员编号：' + result.data[i].studentId + '</td>');
					tabHtml += ('<td>评价时间：' + result.data[i].evaluatetime + '</td>');
					tabHtml += ('<td>评价详情：' + result.data[i].teachlevel + '</td>');
					tabHtml += '</tr>'
				}
				$('#tab').append(tabHtml);
				$('#tab').val("0");
			})
		}
		//教练
		function coach(coachId){
			var star=$("#stars").val();
			var param={
				'insId':insId,
				'star':star,
				'coachId':coachId
			};
			$.get('${ctx}/comment/getList',param,function(result){
				$("#cid").val(result.coach.id);
				$("#coachId").val(result.coach.id);
				$("#cname").val(result.coach.name);
				$("#cfiveStar").val(result.coach.fiveStar);
				$("#cfourStar").val(result.coach.fourStar);
				$("#cthreeStar").val(result.coach.threeStar);
				$("#ctwoStar").val(result.coach.twoStar);
				$("#coneStar").val(result.coach.oneStar);
				$("#csumStar").val(result.coach.sumStar);
				$("#cavgStar").val(result.coach.avgStar);
				$('#tab').empty();
				var tabHtml = "";
				for(var i=0; i<result.data.length; i++){
					tabHtml += '<tr>'
					tabHtml += ('<td>' + result.data[i].studentName + '</td>');
					tabHtml += ('<td>学员编号：' + result.data[i].studentId + '</td>');
					tabHtml += ('<td>评价时间：' + result.data[i].createTime + '</td>');
					tabHtml += ('<td>评价详情：' + result.data[i].comment + '</td>');
					tabHtml += '</tr>'
				}
				$('#tab').append(tabHtml);
				$('#tab').val("1");
			})
		}
		$("select[name='choose']").change(function(){
			var value=$(this).val();
			if(value==1){
				$(".pull-right").hide();
				$("#coach").hide();
				$("#ins").show();
				ins();
			}else{
				$(".pull-right").show();
				$("#coach").show();
				$("#ins").hide();
				coach(0);
			}
		})
		
		$("select[name='stars']").change(function(){
			var value=$(this).val();
			$("#stars").val(value);
			var now=$("#now").val();
			var coachId=$("#coachId").val();
			if(now==0){
				ins();
			}else{
				coach(coachId);
			}
		})
		
		$(function(){
			$("#search").bigAutocomplete({
				url:'${ctx}/comment/getCoach?insId='+insId,
				callback:function(data){
					$("#coachId").val(data.result);
					var coachId=$("#coachId").val();
					coach(coachId);
				}
			});
		});
	</script>
</body>
</html>