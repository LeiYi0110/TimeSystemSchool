<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<meta name="theme" content="school" />
<title>学员数据统计</title>
<link type="text/css" href="${ctx}/resources/css/daterangepicker.min.css" rel="stylesheet" />
<script src='${ctx}/resources/js/moment.min.js'></script>
<script src="${ctx}/resources/js/jquery.daterangepicker.min.js"></script>
<script src="${ctx}/resources/js/echarts.js"></script>
</head>
<body>

	<div class="container-fluid">

		<div id="pad-wrapper">
			<div class="table-wrapper products-table">
				<div class="row-fluid head">
					<div class="span12">
						<h3>学员数据统计</h3>
					</div>
				</div>
				<!-- 搜索 -->
				<div class="row-fluid filter-block">
					<div class="pull-right">
					<span id="two-inputs">
                <input id="time1" size="20" value="" readonly="readonly"> 到 <input id="time2" size="20" value=""readonly="readonly">
                </span>
						选择服务网点<select id="tServiceStation" name="tServiceStation">
						</select>
						<a class="btn-flat small" style="margin-right: 50px;"
							onClick="searchQuery();return false;">查询</a>
					</div>
				</div>
					<div id="echart" style="width:500px; height:300px; margin:0 auto;"></div>
				
				<!-- 列表 -->
				<div class="row-fluid">
					<div class="sub_content">
						<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
						<div id="table_list" class="gri_wrapper"></div>
					</div>
				</div>
			</div>
		</div>
	</div>

   <script type="text/javascript">
   		
  		 var current_action = "${ctx}/view/StudentCount";
  		 var echart = $('#echart')[0];
  		 var myChart = echarts.init(echart);
  		 var xData = new Array(10);
  		 var yData = new Array(10);
  		 function a1(xData,yData){
  			var option = {
  	  				title:{
  	  					text:'新增学员',
  	  					x:'center'
  	  				},
  	  				xAxis:{
  	  					type: 'category',
  	  			        boundaryGap: ['10%','10%'],
  	  					data:xData
  	  				},
  	  				yAxis:{

  	  				},
  	  				dataZoom: [{
  	  			        type: 'slider',
  	  			        startValue : 0,
  	  			        endValue : 6
  	  			    }, {
  	  			        start: 0,
  	  			        end: 6,
  	  			        handleSize: '80%',
  	  			        handleStyle: {
  	  			            color: '#fff',
  	  			            shadowBlur: 3,
  	  			            shadowColor: 'rgba(0, 0, 0, 0.6)',
  	  			            shadowOffsetX: 2,
  	  			            shadowOffsetY: 2
  	  			        }
  	  			    }],
  	  				color:['#5b9bd5','#ed7d31','#a5a5a5','#ffc001','#4472c4','#70ad47'],
  	  				series:{
  	  					type:'line',
  	  					label:{
  	  						normal:{
  	  							show:true
  	  						}
  	  					},
  	  					data:yData
  	  				}
  	  			}
  	  		myChart.setOption(option);
  		 }
  		 
  		
  		$.post("${ctx}/count/page",function (data) {
			if(data.code==200){
				$('#tServiceStation').append("<option value='-1'>请选择服务网点</option>");
				for(var i=0;i<data.ServiceStationAll.length;i++){
					$('#tServiceStation').append("<option value='" +data.ServiceStationAll[i].insId+ "_" + data.ServiceStationAll[i].id + "'>" + data.ServiceStationAll[i].name + "</option>");
				}
				
				for(var i=0;i<data.data.length;i++){
					xData[i]=data.data[i].statidate;
					yData[i]=data.data[i].newstudentcount;
				}
				a1(xData,yData);
			}
		});
  		 
  		
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
		*	构建列表
		*/
		function buildDataTable() {
			var config = {
				'container' : 'table_list'
			};
			//定义列表的列
			config['allFields'] = {
				'statidate' : {
					'thText' : '日期',
					'number' : false,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
				},
				'name' : {
					'thText' : '网点名称',
					'number' : false,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
				},
				'newstudentcount' : {
					'thText' : '新增学员',
					'number' : false,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
				},
				'graduatestudentcount' : {
					'thText' : '毕业学员',
					'number' : true,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
				},
				'currentcount' : {
					'thText' : '在学学员数',
					'number' : false,
					'colAlign' : 'center',
					'thAlign' : 'center',
					'needOrder' : false,
					'precision' : 0,
				},
			};
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/count/tongji',
				'size' : 10,
				'ifRealPage' : 1
			};
			//初始化 并通过ajax加载数据
			dataTable = MTA.Data.loadAjaxPageTable(config);	
			/* var i = $('current').text(); */
			
			 
		}
	</script>
	<script type="text/javascript">
		//日历日期多选
	    $('#two-inputs').dateRangePicker({
	        language:'cn',
			separator : ' to ',
			getValue: function()
			{
				if ($('#time1').val() && $('#time2').val() )
					return $('#time1').val() + ' to ' + $('#time2').val();
				else
					return '';
			},
			setValue: function(s,s1,s2)
			{
				$('#time1').val(s1);
				$('#time2').val(s2);
			}
		});
    </script>
</body>
</html>