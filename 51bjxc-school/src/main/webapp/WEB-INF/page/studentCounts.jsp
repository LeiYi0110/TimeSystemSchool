<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<meta name="theme" content="school" />
<title>学员数据统计</title>
<script type="text/javascript" src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="${ctx}/resources/js/echarts.js"></script>
</head>
<body>
	<div class="container-fluid new-admin">
		<div class="select-top">
			<a class="select-btn"><span class="Export"></span>导出</a>
		</div>
	</div>
	<div class="TermSearch">
	 	 <form>
			 <input type="text" class="form_date input1 win90" data-date-format="yyyy-mm-dd" placeholder="请选择开始日期">
			 <input type="text" class="form_date input1 win90" data-date-format="yyyy-mm-dd" placeholder="请选择结束日期">
			 <select>
			  	 <option value="">选择网点</option>
			 </select>
			 <buuton class="btn-flat primary">搜 索</buuton>
		 </form>
	 </div>
	 <div class="student-count">
		<ul class="nav nav-tabs" id="myCount">
			<li class="active"><a href="#add">新增学员</a></li>
			<li><a href="#graduation">毕业学员</a></li>
			<li><a href="#while">在学学员</a></li>
			<li><a href="#distributed">学员分布</a></li>
		</ul>
		 
		<div class="tab-content">
		  	<div class="tab-pane active" id="add"><div id="echarts1" class="item"></div></div>
		  	<div class="tab-pane" id="graduation"><div id="echarts2" class="item"></div></div>
		  	<div class="tab-pane" id="while"><div id="echarts3" class="item"></div></div>
		  	<div class="tab-pane" id="distributed"><div id="echarts4" class="item"></div></div>
		</div>
	 </div>
	 <!-- 列表 -->
	<div class="row-fluid">
		<div class="sub_content">
			<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
			<div id="table_list" class="gri_wrapper"></div>
		</div>
	</div>
<script>
$(function(){
	// 调用日历控件
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
	// 调用标签页组件
	$('#myCount a').click(function (e) {
		e.preventDefault();
		$(this).tab('show');
	});
	
	line('echarts1','dasdas',[],[]);
	line('echarts2','dasdas1',[],[]); 
	line('echarts3','dasdas2',[],[]); 
	pie('echarts4','dasdas2',[]); 
	
	// K线图通用方法
	function line(domId,title,xData,yData){
		var content = document.getElementById(domId);
		var myChart = echarts.init(content); 
		var option = {
			title:{
				text:title,
				x:'center'
			},
			xAxis:{
				type: 'category',
			    boundaryGap: ['5%','5%'],
				data:xData
			},
			yAxis:{
				axisLine:{
					show:false
				},
				axisTick:{
					show:false
				}
			},
			tooltip :{
				trigger:'axis',
				formatter:'{b}<br><strong>{c} </strong>人',
				axisPointer:{
					lineStyle:{
						opacity:0
					}
					}
				},
			color:['#69f'],
			series:{
				type:'line',
				showAllSymbol: true,
				data:yData
			}
		}
		myChart.setOption(option);
	}
	
	function pie(domId,title,data){
		var content = document.getElementById(domId);
		var myChart = echarts.init(content);
		var option = {
			    title : {
			        text: title,
			        x:'center',
			        y:'top'
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
			            center: ['50%', '60%'],
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
	
})	
</script>
</body>
</html>