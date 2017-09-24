<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta name="theme" content="school" />
<script type="text/javascript" src="${ctx}/resources/js/echarts.js"></script>
<style type="text/css">
	.div_top p{
		margin: 98px 0px 0px 10px;
		font-size: 18px;
		font-family: "微软雅黑"
	}
	.div_Survey p{
		margin: 30px 0px 0px 485px;
		font-size: 18px;
		font-family: "微软雅黑"
	}
	.div_Survey .div_bk{
		background-image:url(${ctx}/resources/img/logo-number.png);
	}
</style>
</head>
<body>
 <div class="index-top">
 	<h3>驾校概况</h3>
 	<h4 id="timeId"></h4>
 </div>
 <div class="echarts-index">
 	<div class="item" id="allStuId">累计学员数<span></span></div>
 	<div class="item" id="nowStuId">当前在学学员数<span></span></div>
 	<div class="item" id="todayStuId">今天新增学员数<span></span></div>
 	<div class="item" id="yesterdayStuId">昨天新增学员数<span></span></div>
 	<div class="item" id="monthStuId">本月新增学员数<span></span></div>
 	<div id="echarts" class="index-con"></div>
 </div>
 <!-- 列表 -->
	<div class="row-fluid">
		<div class="sub_content">
			<div id="table_list" class="gri_wrapper">
				<table id="table_list_table" class="gri_stable">
					<colgroup span="6">
						<col class="gri_4">
						<col class="gri_5">
						<col class="gri_6">
						<col class="gri_7">
						<col class="gri_8">
						<col class="gri_9">
					</colgroup>
					<thead>
						<tr>
							<th name="4">报名未受理</th>
							<th name="5">已受理未上课</th>
							<th name="6">科目一学习中</th>
							<th name="7">科目二学习中</th>
							<th name="8">科目三学习中</th>
							<th name="9">科目四学习中</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td id="notAcceptedOneId" style="vertical-align: inherit;">
								<span data-id="3657"></span>
							</td>
							<td id="notSubjectOneId" style="vertical-align: inherit;">
								<span data-id="3657"></span>
							</td>
							<td id="subjectOneId" style="vertical-align: inherit;">
								<span data-id="3657"></span>
							</td>
							<td id="subjectTwoId" style="vertical-align: inherit;">
								<span data-id="3657"></span>
							</td>
							<td id="subjectThreeId" style="vertical-align: inherit;">
								<span data-id="3657"></span>
							</td>
							<td id="subjectFourId" style="vertical-align: inherit;">
								<span data-id="3657"></span>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
<script type="text/javascript">
	var current_action = "${ctx}/view/school";
	var insId= '<sec:authentication property="principal.insId"/>';
	var staId=<sec:authentication property="principal.stationId"/>;
	var dataTable = null;
	
	sessionStorage.setItem("isconnected", 0);
	
	var param={"insId":insId,"staId":staId};
	$(document).ready(function() {
		var date=getNowFormatDate();
		$("#timeId").text(date);
		
		$.get('${ctx}/institutionInfo/generalSituation',param,function(result){
			if(result.code==200){
				$("#nowStuId span").text(result.data[0]);
				$("#todayStuId span").text(result.data[1]);
				$("#yesterdayStuId span").text(result.data[2]);
				$("#monthStuId span").text(result.data[3]);
				$("#allStuId span").text(result.data[10]);//累计学员
				var param=[
						{value:result.data[4],name:result.title[4]+''},
						{value:result.data[5],name:result.title[5]+''},
						{value:result.data[6],name:result.title[6]+''},
						{value:result.data[7],name:result.title[7]+''},
						{value:result.data[8],name:result.title[8]+''},
						{value:result.data[9],name:result.title[9]+''}
						];
				pie("echarts","",param);
				$("#notAcceptedOneId span").text(result.data[4]);
				$("#notSubjectOneId span").text(result.data[5]);
				$("#subjectOneId span").text(result.data[6]);
				$("#subjectTwoId span").text(result.data[7]);
				$("#subjectThreeId span").text(result.data[8]);
				$("#subjectFourId span").text(result.data[9]);
				
			}
		});
	});
	//格式化日期
	function getNowFormatDate() {
	    var date = new Date();
	    var seperator1 = "-";
	    var year = date.getFullYear();
	    var month = date.getMonth() + 1;
	    var strDate = date.getDate();
	    if (month >= 1 && month <= 9) {
	       month = "0" + month;
	    }
	    if (strDate >= 0 && strDate <= 9) {
	    	strDate = "0" + strDate;
	    }
	    var currentdate = year + seperator1 + month + seperator1 + strDate;
	    return currentdate;
	 }
	
	function pie(domId,title,data){
		var content = document.getElementById(domId);
		var myChart = echarts.init(content);
		var option = {
			    title : {
			        text: title,
			        x:'center',
			        y:'bottom'
			    },
			    tooltip : {
			        trigger: 'item',
			        formatter: "{b} <br/><strong>{c}</strong>({d}%)"
			    },
			    color:['#5b9bd5','#ed7d31','#a5a5a5','#ffc001','#4472c4','#70ad47'],
			    series : [
			        {
			            name: '学员分布',
			            type: 'pie',
			            radius : '70%',
			            center: ['50%', '50%'],
			            data:data,
			            label:{
			            	normal:{
			            		textStyle:{
			            			fontSize:14
			            		},
			            		formatter:'{b}: {d}%'
			            	}
			            },
			            itemStyle: {
			                emphasis: {
			                    shadowBlur: 10,
			                    shadowOffsetX: 0,
			                    shadowColor: 'rgba(0, 0, 0, 0.5)'
			                }
			            }
			        }
			    ]
			};
		myChart.setOption(option);
	}
</script>
</body>
</html>