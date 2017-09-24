<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-计时终端监控</title>
<script src="http://webapi.amap.com/maps?v=1.3&key=85e0a18ddc6ebb0ecb7efb35e8b73cbd"></script>
<script type="text/javascript" src="${ctx}/resources/js/tcp.js"></script>
</head>
<body>
	<div class="monitor">
		<div class="monitor-left">
			<div class="monitor-search">
				<input id="search17Id" type="text" placeholder="车牌号">
				<button class="btn btn-success" onclick="search()">查询</button>
			</div>
			<div class="monitor-tabs">
				<span class="active" id="onlineNumId" onclick="showTab('onlineNumId')"></span>
				<span id="offlineNumId" onclick="showTab('offlineNumId')"></span>
			</div>
			<ul class="monitor-list" id="onlineId">
			</ul>
			<ul class="monitor-list" id="offlineId" style="display:none;">
			</ul>
		</div>
		<div class="monitor-right">
			<div class="alert alert-info">
		 	 	<div class="row-fluid">
				  	<div class="span3" id="stuNumId">学员编号：<span></span></div>
				  	<div class="span3" id="coaNumId">教练员编号：<span></span></div>
				  	<div class="span3" id="carLicensePlateId">教练车车牌号：<span></span></div>
				  	<div class="span3" id="deviceId">终端编号：<span></span></div>
				</div>
				<div class="row-fluid">
				  	<div class="span3" id="speedId">发动机转速：<span></span></div>
				  	<div class="span3" id="runningSpeedId">行驶速度：<span></span></div>
				  	<div class="span3" id="stateId">车辆状态：<span></span></div>
				</div>
				<div class="row-fluid">
				  	<div class="span5" id="coordinateId">当前坐标：<span></span></div>
				  	<div class="span4" id="timeId">时间：<span></span></div>
				  	<div class="span3"><button id="nowPhotoId43" disabled="disabled" class="btn btn-success btn-abs" onclick="submitForm($('#formId'))">立即拍照</button></div>
				</div>
			</div>
			<div id="monitor-map"><!-- 地图 --></div>
		</div>
	</div>
	
	<div style="padding: 24px;display:none;">
		<form class="form-horizontal" action="${ctx}/TCPClient/getPhoto" method="post" id="formId">
<!--		  <div class="control-group">
 		    <label class="control-label">上传模式:</label>
		    <div class="controls">
		      <input id="getPhotoType" type="text" name="type" placeholder="BYTE" value="1"/>
		    </div>
		  </div>
		  <div class="control-group">
		    <label class="control-label">摄像头通道号:</label>
		    <div class="controls">
		      <input id="getPhotoCameraNum" type="text" name="cameraNum" placeholder="BYTE"  value="0"/>
		    </div>
		  </div>
		  <div class="control-group">
		    <label class="control-label">图片尺寸:</label>
		    <div class="controls">
		      <input id="getPhotoSize" type="text" name="size" placeholder="BYTE"  value="1"/>
		    </div>
		  </div> -->
		  <input type="hidden" name="type" id="getPhotoType" value="1"/>
		  <input type="hidden" name="cameraNum" id="getPhotoCameraNum" value="0"/>
		  <input type="hidden" name="size" id="getPhotoSize" value="1"/>
		  <input type="hidden" name="deviceNum" id="deviceNumId"/>
		  <input type="hidden" name="mobile" id="mobileId"/>
		  <div class="result_div"></div>
		</form>
	</div>
	
	<div class="modal fade colsform" id="showPic" tabindex="-1" role="dialog" aria-hidden="true" style="width:350px; margin-left:-175px;">
		<h4>立即拍照</h4>
		<div class="modal-content">
				<img alt="" src="" style="width:100%;">
				<p style="text-align: center"></p>
		</div>
		<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		</div>
	</div>
	<input type="hidden" id="locusId"/>
	<input type="hidden" id="locationId"/>
	<input type="hidden" id="deviceId88"/>
	
	<script>	
	function carList(searchText){
		$.get("${ctx}/device/carlist?searchText="+searchText+"&insId="+<sec:authentication property="principal.insId"/>,function(result){
			$("#onlineNumId").html("在线车辆<br>"+result.onlineNum+"辆");
			$("#offlineNumId").html("离线车辆<br>"+result.offlineNum+"辆");
			
			var onlineHtml="";
			var offlineHtml="";
			for(var i=0;i<result.data.length;i++){
				if(result.data[i].isLogin!=null && result.data[i].isLogin==1){
					onlineHtml+='<li class="online" onclick="loadMessage(\''+result.data[i].licnum+'\')">'+result.data[i].licnum+'</li>';
				}else if(result.data[i].isLogin==null || result.data[i].isLogin==0){
					offlineHtml+='<li class="offline">'+result.data[i].licnum+'</li>';
				}
		    }
			$("#onlineId").html(onlineHtml);
			$("#offlineId").html(offlineHtml);
		});
	}
	
		$(function(){			
			carList("");
			
			var map = new AMap.Map("monitor-map",{});
			var marker =null;
			
			$(".monitor-tabs span").click(function(){
				var i = $(this).index();
				$(".monitor-tabs span").removeClass('active').eq(i).addClass('active');
			})
		})
		
		function paintLocation(locations){
			/* 生成地图  */
			if(locations!=null){
				/* 绘制练车场  */
				var locationPoints = new Array();
				var sLocationPoints = locations.split(";");
				for(var i=0; i<sLocationPoints.length-1; i++){
					var arr = [sLocationPoints[i].split(",")[0],sLocationPoints[i].split(",")[1]]
					locationPoints.push(arr);
				}
			   	var polygon = new AMap.Polygon({
			        path: locationPoints,//设置多边形边界路径
			        strokeColor: "#F33", //线颜色
			        strokeOpacity: 0.2, //线透明度
			        strokeWeight: 2,    //线宽
			        fillColor: "#ee2200", //填充色
			        fillOpacity: 0.25//填充透明度
			    });
			    polygon.setMap(map);
			}
		}
		function paintLocus(locus){
			/* 绘制轨迹  */
		    if(locus!=null){
				var locusPoints = new Array();
				var sLocusPoints = locus.split(";");
				for(var i=0; i<sLocusPoints.length-1; i++){
					var arr = [sLocusPoints[i].split(",")[0],sLocusPoints[i].split(",")[1]]
					locusPoints.push(arr);
				}
				var polyline = new AMap.Polyline({
			        path: locusPoints,          //设置线覆盖物路径
			        strokeColor: "#3366FF", //线颜色
			        strokeOpacity: 1,       //线透明度
			        strokeWeight: 2,        //线宽
			        strokeStyle: "solid",   //线样式
			        strokeDasharray: [10, 5] //补充线样式
			    });
				polyline.setMap(map);
			}
		}
		
		function loadMessage(licNum){			
			$("#nowPhotoId43").prop("disabled",false);
			
			$.get("${ctx}/device/carbylicnum?licNum="+licNum,function(result){
				$("#stuNumId").find("span").text(result.data.studentnum!=null?result.data.studentnum:"");
				$("#coaNumId").find("span").text(result.data.coachnum!=null?result.data.coachnum:"");
				$("#carLicensePlateId").find("span").text(result.data.licnum!=null?result.data.licnum:"");
				$("#deviceId").find("span").text(result.data.devnum!=null?result.data.devnum:"");
				$("#speedId").find("span").text(result.data.engineSpeed!=null?(result.data.engineSpeed+"r/min"):"");
				$("#runningSpeedId").find("span").text(result.data.carSpeed!=null?(result.data.carSpeed+"km/h"):"");
				if(result.data.status!=null){
					$.ajax({
						url : "${ctx}/device/inttobinary?intsta="+result.data.status,
						type : "get",
						async : false,
						success : function(result){
							var data=result.data;
	    					var intVal=null;
	    					var statusStr="";
	    					var jsonVal=[{"a":"ACC关","b":"ACC开"},{"a":"未定位","b":"定位"}
	    								,{"a":"北纬","b":"南纬"},{"a":"东经","b":"西经"}
	    								,{"a":"运营状态","b":"停运状态"},{"a":"经纬度未经保密插件加密","b":"经纬度已经保密插件加密"}
	    								,{"a":"","b":""},{"a":"","b":""},{"a":"","b":""},{"a":"","b":""}
	    								,{"a":"车辆油路正常","b":"车辆油路断开"},{"a":"车辆电路正常","b":"车辆电路断开"}
	    								,{"a":"车门解锁","b":"车门加锁"}
	    								,{"a":"","b":""},{"a":"","b":""},{"a":"","b":""},{"a":"","b":""}
	    								,{"a":"","b":""},{"a":"","b":""},{"a":"","b":""},{"a":"","b":""}
	    								,{"a":"","b":""},{"a":"","b":""},{"a":"","b":""},{"a":"","b":""}
	    								,{"a":"","b":""},{"a":"","b":""},{"a":"","b":""},{"a":"","b":""}
	    								,{"a":"","b":""},{"a":"","b":""},{"a":"","b":""}];
	    					for(var i=0;i<data.length;i++){
	    						switch (data[i]){
	    							case "0":
	    								statusStr+=(jsonVal[i].a+" ");
	    							continue;
	    							case "1":
	    								statusStr+=(jsonVal[i].b+" ");
	    							continue;
	    						}
	    					}
	    					$("#stateId").find("span").text(statusStr);
						}
					});
				}
				if(result.data.timeStr!=null){
					$("#timeId").find("span").text("20"+result.data.timeStr.substring(0,2)+"年"+
							result.data.timeStr.substring(2,4)+"月"+result.data.timeStr.substring(4,6)+"日"+
							result.data.timeStr.substring(6,8)+":"+result.data.timeStr.substring(8,10)+":"+
							result.data.timeStr.substring(10));
				}
				
				var latitude=result.data.latitude!=null?
						((result.data.latitude+"").substring(0,2)+"."+(result.data.latitude+"").substring(2)):"";
				var longtitude=result.data.longtitude!=null?
						((result.data.longtitude+"").substring(0,3)+"."+(result.data.longtitude+"").substring(3)):"";
				var locus="";
				var location="";
				location=result.data.location;
					
				if("."!=latitude && "."!=longtitude){
					$("#coordinateId").find("span").text(latitude+","+longtitude);
				}
				map = new AMap.Map("monitor-map",{});
				
				if("."!=latitude && "."!=longtitude){
					map.setZoomAndCenter(17,[longtitude,latitude]);
					locus=longtitude+","+latitude+";";
					
					marker =new AMap.Marker({
						map : map,
						position : [longtitude,latitude],
						icon : new AMap.Icon({
							size: new AMap.Size(32,32),  //图标大小
		           	 		image: "http://img.91ygxc.com/2017/01/18/54306951-359d-46c5-ab7b-18d36a419c3e_s.png"
							//imageOffset : new AMap.Pixel(0, -60)
						})
					});
					paintLocus(locus);
				}
				$("#locusId").val("");
				
				if(location!=""){
					paintLocation(location);
				}
				
				if(result.data.sim!=null){
					var mobile=result.data.sim.substring(0,5)=="00000"?result.data.sim.substring(5):result.data.sim;
					$("#mobileId").val(mobile);
					var parambindDevice = {
						deviceNum:result.data.devnum,
						mobile:mobile
					}
					$.post("${ctx}/TCPClient/bindDevice",parambindDevice,function(result){});
				}
				$("#deviceNumId").val(result.data.devnum);
				$("#deviceId88").val(result.data.id);
				
			});
		}
		
		function showPic(src){
			$("#showPic").find("img").prop("src",src);
			$('#showPic p').text(getnowtime());
			$('#showPic').modal('show');
				$("#getPhotoType").val(1);
				$("#getPhotoCameraNum").val(0);
				$("#getPhotoSize").val(1);
		}
		
		function search(){
			carList($("#search17Id").val());
		}
		
		function showTab(sign){
			if(sign=="onlineNumId"){
				$("#onlineNumId").siblings().removeClass("active");
				$("#onlineNumId").addClass("active");
				$("#onlineId").attr("style","display:block;");
				$("#offlineId").attr("style","display:none;");
			}else if(sign=="offlineNumId"){
				$("#offlineNumId").siblings().removeClass("active");
				$("#offlineNumId").addClass("active");
				$("#onlineId").attr("style","display:none;");
				$("#offlineId").attr("style","display:block;");
				$("#nowPhotoId43").prop("disabled",true);
			}
		}
		//当前时间
		function getnowtime() {  
            var nowtime = new Date();  
            var year = nowtime.getFullYear();  
            var month = padleft0(nowtime.getMonth() + 1);  
            var day = padleft0(nowtime.getDate());  
            var hour = padleft0(nowtime.getHours());  
            var minute = padleft0(nowtime.getMinutes());  
            var second = padleft0(nowtime.getSeconds());  
            return year + "年" + month + "月" + day + "日 " + hour + ":" + minute + ":" + second;  
        }  
        //补齐两位数  
        function padleft0(obj) {  
            return obj.toString().replace(/^[0-9]{1}$/, "0" + obj);  
        }
	</script>
</body>
</html>