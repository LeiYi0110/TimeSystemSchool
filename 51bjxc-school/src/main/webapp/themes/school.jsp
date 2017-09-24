<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<!DOCTYPE html>
<html>
<head>
	<title><sitemesh:title default="阳光驾培" /></title>
    
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="icon" type="image/png" href="${ctx}/favicon.ico" />
    
    	<!-- scripts for this page -->
    <!-- 
    <script src="${ctx}/resources/js/jquery-latest.js"></script>
     -->
    <%-- <script src="${ctx}/resources/js/jquery.js"></script> --%>
    <script src="${ctx}/resources/js/jquery-1.11.3.min.js"></script>
    <!-- <script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script> -->
    <script src="${ctx}/resources/js/jquery-ui-1.10.2.custom.min.js"></script>
    <script src="${ctx}/resources/js/bootstrap.min.js"></script>
    <script src='${ctx}/resources/js/fullcalendar.min.js'></script>
    <script src="${ctx}/resources/js/theme.js"></script>
    <script src="${ctx}/resources/js/jquery.bigautocomplete.js"></script>
    <script src="${ctx}/resources/js/form-prompt/Validform_v5.3.2_min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/js/admin.js"></script>
    <script type="text/javascript" src="${ctx}/resources/js/layer.js"></script>
    
    <script src="${ctx}/resources/js/app.js"></script>
    <script src="${ctx}/resources/js/sockjs.min.js"></script>
    <script src="${ctx}/resources/js/stomp.min.js"></script>
    <script src="${ctx}/resources/js/jquery.cookie.js"></script>
    <script src="http://112.74.129.7:8709/socket.io/socket.io.js"></script>
    <!-- <script src="http://localhost:8709/socket.io/socket.io.js"></script> -->
    
    
    
    <link type="text/css" href="${ctx}/resources/css/bootstrap/bootstrap.css" rel="stylesheet" />
    <link type="text/css" href="${ctx}/resources/css/bootstrap/bootstrap-responsive.css" rel="stylesheet" />
    <link type="text/css" href="${ctx}/resources/css/bootstrap/bootstrap-overrides.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/css/jquery.bigautocomplete.css" />

    <!-- libraries -->
    <link href="${ctx}/resources/css/lib/jquery-ui-1.10.2.custom.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/resources/css/lib/font-awesome.css" type="text/css" rel="stylesheet" />

    <!-- global styles -->
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/css/layout.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/css/elements.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/css/icons.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/css/compiled/tables.css" />
    <!-- mta -->
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/mta/gri.controls.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/mta/mta_common.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/mta/mta_layout.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/mta/mta_module.css" />

    <!-- this page specific styles -->
    <link rel="stylesheet" href="${ctx}/resources/css/compiled/index.css" type="text/css" media="screen" />
    
    
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/css/admin.css">    

    <!-- open sans font
    <link href='http://fonts.useso.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css' />
 -->
    <!-- lato font
    <link href='http://fonts.useso.com/css?family=Lato:300,400,700,900,300italic,400italic,700italic,900italic' rel='stylesheet' type='text/css' />
 -->
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<sitemesh:head />
	
</head>
<body>

    <!-- navbar -->
    <div class="navbar navbar-inverse">
        <div class="navbar-inner">
            <button type="button" class="btn btn-navbar visible-phone" id="menu-toggler">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                
            </button>
            
            <a class="brand" href="${ctx}/school"><img src="${ctx}/resources/img/logo.png" style="height:40px;"/>
					<span id="insid-label"><sec:authentication property="principal.insName"/></span>
					<!-- 批量备案id，临时用 -->
					<div style="display:none" id="batch"></div>
					<input type="hidden" value='<sec:authentication property="principal.insCode"/>' id="insCodex">
			</a>
            <ul class="nav pull-right">                
               <!--  <li class="hidden-phone">
                    <input class="search" type="text" />
                </li> -->
                <li class="dropdown">
                    <a href="#">
                        <i class="icon-user1"></i><sec:authentication property="principal.username"/>
                    </a>
                    <ul class="dropdown-ul">
                    	<a onclick="accInfo()"><i class="icon-password"></i>用户信息</a>
                    </ul>
                </li>
                <sec:authorize access="hasRole('ROLE_PLATFORM_MANAGER')">
                <li class="dropdown">
                     <a href="#"><i class="icon-identity"></i>平台管理员</a>
                </li>
                </sec:authorize>
                <sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
                <li class="dropdown">
                     <a href="#"><i class="icon-identity"></i>机构管理员</a>
                </li>
                </sec:authorize>
                <sec:authorize access="hasRole('ROLE_SCHOOL_SERVICE')">
                <li class="dropdown">
                     <a href="#"><i class="icon-identity"></i>网点管理员</a>
                </li>
                </sec:authorize>
                <sec:authorize access="hasRole('ROLE_TIME_SYSTEM')">
                <li class="dropdown">
                     <a href="#"><i class="icon-identity"></i>计时平台</a>
                </li>
                </sec:authorize>
                <li class="dropdown">
                     <a href="${ctx}/logout"><i class="icon-quit"></i>退出</a>
                </li>
           		<sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
                <li class="settings hidden-phone">
                    <%-- <a href="${ctx}/view/manager" role="button">
                        <i class="icon-cog"></i>
                    </a> --%>
                </li>
               </sec:authorize>
            </ul>            
        </div>
    </div>
    <!-- end navbar -->

    <!-- sidebar -->
   <div id="sidebar-nav">
        <ul class="ConLeftNav">
        <sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
        	<li class="NavBox">
                <a href="#" class="NavTit">
                    <i class="driving"></i>
                    <span>驾校概况</span>
                </a>
                 <ul class="NavTxt">
                    <li><a href="${ctx}/view/school">驾校概况</a></li>
                    <li><a href="${ctx}/view/development">学员统计</a></li>
                    <%-- <li><a href="${ctx}/view/coachCounts">教练统计</a></li> --%>
                    <li><a href="${ctx}/view/development">教练统计</a></li>
                  	<li><a href="${ctx}/view/institution">驾校简介</a></li>
                  	<li><a href="${ctx}/view/agency">机构管理</a></li>
                </ul>
            </li>
            <li class="NavBox">
                <a href="#" class="NavTit">
                    <i class="tcp"></i>
                    <span>TCP管理</span>
                </a>
                 <ul class="NavTxt">
                 	<li><a href="${ctx}/view/tcp/bindDevice">绑定终端</a></li>
                    <li><a href="${ctx}/view/tcp/login">平台登录</a></li>
                    <li><a href="${ctx}/view/tcp/logout">平台登出</a></li>
                    <li><a href="${ctx}/view/tcp/setParams">设置终端参数</a></li>
                  	<li><a href="${ctx}/view/tcp/searchParams">查询终端参数</a></li>
                  	<li><a href="${ctx}/view/tcp/searchOneParam">查询指定终端参数</a></li>
                  	<li><a href="${ctx}/view/tcp/control">终端控制</a></li>
                  	<li><a href="${ctx}/view/tcp/locationInfo">位置信息查询</a></li>
                  	<li><a href="${ctx}/view/tcp/locationFollow">临时位置跟踪控制</a></li>
                  	<li><a href="${ctx}/view/tcp/recordReport">命令上报学时记录</a></li>
                  	<li><a href="${ctx}/view/tcp/takePhoto">立即拍照</a></li>
                  	<li><a href="${ctx}/view/tcp/searchPhoto">查询照片</a></li>
                  	<li><a href="${ctx}/view/tcp/reportPhoto">上传指定照片</a></li>
                  	<li><a href="${ctx}/view/tcp/setDeviceParams">设置计时终端参数</a></li>
                  	<li><a href="${ctx}/view/tcp/searchDeviceParams">查询计时终端参数</a></li>
                  	<li><a href="${ctx}/view/tcp/setNoTrain">设置禁训状态</a></li>
                  	<li><a href="${ctx}/view/tcp/autorecord">添加模拟学时</a></li>
                  	
                </ul>
            </li>
            <li class="NavBox">
                <a class="NavTit">
                    <i class="assets"></i>
                    <span>驾校配置</span>
                </a>
                 <ul class="NavTxt">
                 	<li><a href="${ctx}/view/tteacharea">片区管理</a></li>
                 	<li><a href="${ctx}/view/serviceStation?insId=<sec:authentication property="principal.insId"/>">网点管理</a></li>
                    <li><a href="${ctx}/view/drivingField?insId=<sec:authentication property="principal.insId"/>">练车场管理</a></li>
                  	<li><a href="${ctx}/view/trainingCar">教练车管理</a></li>
                  	<li><a href="${ctx}/view/device">计时终端管理</a></li>
                  	<li><a href="${ctx}/view/monitor">计时终端监控</a></li>
                  	<li><a href="${ctx}/view/classType">班型管理</a></li>
                </ul>
            </li>
            <li class="NavBox">
                <a class="NavTit">
                    <i class="user"></i>
                    <span>职员管理</span>
                </a>
                 <ul class="NavTxt">
                    <li><a href="${ctx}/view/mg/coachList">教练员管理</a></li>
                    <li><a href="${ctx}/view/assessment">考核员管理</a></li>
                    <li><a href="${ctx}/view/securityMember">安全员管理</a></li>
                    <%-- <li><a href="${ctx}/view/platformUser?insId=<sec:authentication property="principal.insId"/>">其他成员管理</a></li> --%>
                    <%-- <li><a href="${ctx}/view/development">其他成员管理</a></li> --%>
                </ul>
            </li>
            <li class="NavBox">
                <a class="NavTit">
                    <i class="student"></i>
                    <span>学员管理</span>
                </a>
                 <ul class="NavTxt">
                    <li><a href="${ctx}/view/student">学员管理</a></li>
                    <li><a href="${ctx}/view/trainproc">学员培训流程</a></li>
                    <li><a href="${ctx}/view/TeachingLog">教学日志</a></li>
                    <li><a href="${ctx}/view/trefund">学员退费管理</a></li>
                    <li><a href="${ctx}/view/studentExpire">学员逾期预警</a></li>
                    <li><a href="${ctx}/view/timerecord">阶段培训管理</a></li>
                    <li><a href="${ctx}/view/trainingLog">学时管理</a></li>
                    <li><a href="${ctx}/view/studentRefereeManage">报名信息查询</a></li>
                    <li><a href="${ctx}/view/graduation">结业信息查询</a></li>
                    
                </ul>
            </li>
            <li class="NavBox">
                <a class="NavTit">
                    <i class="affairs"></i>
                    <span>教务管理</span>
                </a>
                 <ul class="NavTxt">
                 	<li><a href="${ctx}/view/coachDutyManage">练车排班管理</a></li>
                 	<li><a href="${ctx}/view/stationDuty">练车排班记录</a></li>
                 	<li><a href="${ctx}/view/development">学时异常预警</a></li>
                  	<li><a href="${ctx}/view/theoreticalCourseNumber">理论课人数</a></li>
                  	<li><a href="${ctx}/view/theoryList">理论上课名单</a></li>
                  	<li><a href="${ctx}/view/studentExam">考试管理</a></li>
                  	<li><a href="${ctx}/view/outline">教学大纲管理</a></li>
                  	<li><a href="${ctx}/view/studentChangeInstitution">跨驾培机构管理</a></li>
                </ul>
            </li>
            <li class="NavBox">
                <a class="NavTit">
                     <i class="feedback"></i>
                    <span>反馈管理</span>
                </a>
                 <ul class="NavTxt">
                    <li><a href="${ctx}/view/shcoolcomment">学员评价驾校</a></li>
                    <li><a href="${ctx}/view/Coachevaluation">学员评价教练</a></li>
                    <li><a href="${ctx}/view/complaintsDriving">学员投诉驾校</a></li>
                    <li><a href="${ctx}/view/complaintsCoach">学员投诉教练</a></li>
                </ul>
            </li>
            <li class="NavBox">
                <a class="NavTit">
                    <i class="statistics"></i>
                    <span>计时班管理</span>
                </a>
                 <ul class="NavTxt">
                    <li><a href="${ctx}/view/development">计时班教练管理</a></li>
                    <li><a href="${ctx}/view/development">先付后学管理</a></li>
                    <li><a href="${ctx}/view/development">先学后付管理</a></li>
                </ul>
            </li>
            <li class="NavBox">
                <a class="NavTit">
                    <i class="statistics"></i>
                    <span>财务系统</span>
                </a>
                 <ul class="NavTxt">
                    <li><a href="${ctx}/view/development">APP报名对账</a></li>
                </ul>
            </li>
            <li class="NavBox">
                <a class="NavTit">
                    <i class="feedback"></i>
                    <span>消息管理</span>
                </a>
                 <ul class="NavTxt">
                    <li><a href="${ctx}/view/notificationMessage">消息列表</a></li>
                </ul>
            </li>
             <li class="NavBox">
                <a class="NavTit">
                    <i class="statistics"></i>
                    <span>系统设置</span>
                </a>
                 <ul class="NavTxt">
                 	<li><a href="${ctx}/view/roleManage">角色权限管理</a></li>
                    <li><a href="${ctx}/view/platformUser?insId=<sec:authentication property="principal.insId"/>">用户账号管理</a></li>
                    <li><a href="${ctx}/view/excelDatasAdd">数据导入导出</a></li>
                    <li><a href="${ctx}/view/systemconfig">系统参数配置</a></li>
                    <li><a href="${ctx}/view/userlog">日志管理</a></li>
                </ul>
            </li>
            <%--<li class="NavBox">
                <a class="NavTit">
                    <i class="statistics"></i>
                    <span>统计分析</span>
                </a>
                 <ul class="NavTxt">
                    <li><a href="${ctx}/view/development">培训学员</a></li>
                    <li><a href="${ctx}/view/development">结业学员</a></li>
                    <li><a href="${ctx}/view/development">营业收入</a></li>
                </ul>
            </li>
            <li class="NavBox">
                <a class="NavTit">
                    <i class="purview"></i>
                    <span>系统角色权限</span>
                </a>
                 <ul class="NavTxt">
                    <li><a href="${ctx}/view/development">用户管理</a></li>
                </ul>
            </li>
            <li class="NavBox">
                <a class="NavTit">
                    <i class="orders"></i>
                    <span>网上订单</span>
                </a>
                 <ul class="NavTxt">
                    <li><a href="${ctx}/view/development">网上订单</a></li>
                </ul>
            </li> --%>
        </sec:authorize>
        <sec:authorize access="hasRole('ROLE_SCHOOL_SERVICE')">
        	<li class="NavBox">
	        	<sec:authorize access="hasRole('ROLE_OPERATION_31')">
	                <a href="#" class="NavTit">
	                    <i class="driving"></i>
	                    <span>驾校概况</span>
	                </a>
	            </sec:authorize>
	            
                 <ul class="NavTxt">
                 <sec:authorize access="hasRole('ROLE_OPERATION_38')">
                    <li><a href="${ctx}/view/school">驾校概况</a></li>
                 </sec:authorize>
                 <sec:authorize access="hasRole('ROLE_OPERATION_32')">
                    <li><a href="${ctx}/view/development">学员统计</a></li>
                 </sec:authorize>
                    <%-- <li><a href="${ctx}/view/coachCounts">教练统计</a></li> --%>
                 <sec:authorize access="hasRole('ROLE_OPERATION_33')">
                    <li><a href="${ctx}/view/development">教练统计</a></li>
                 </sec:authorize>
                 <sec:authorize access="hasRole('ROLE_OPERATION_34')">
                  	<li><a href="${ctx}/view/institution">驾校简介</a></li>
                 </sec:authorize>
                 <sec:authorize access="hasRole('ROLE_OPERATION_37')">
                  	<li><a href="${ctx}/view/agency">机构管理</a></li>
                 </sec:authorize>
                 <sec:authorize access="hasRole('ROLE_OPERATION_47')">
                  	<li><a href="${ctx}/view/tcp">TCP管理</a></li>
                 </sec:authorize>
                </ul>
            </li>
            <li class="NavBox">
            <sec:authorize access="hasRole('ROLE_OPERATION_48')">
                <a href="#" class="NavTit">
                    <i class="tcp"></i>
                    <span>TCP管理</span>
                </a>
            </sec:authorize>
                 <ul class="NavTxt">
                 <sec:authorize access="hasRole('ROLE_OPERATION_49')">
                 	<li><a href="${ctx}/view/tcp/bindDevice">绑定终端</a></li>
                 </sec:authorize>
                 <sec:authorize access="hasRole('ROLE_OPERATION_50')">
                    <li><a href="${ctx}/view/tcp/login">平台登录</a></li>
                 </sec:authorize>
                 <sec:authorize access="hasRole('ROLE_OPERATION_51')">
                    <li><a href="${ctx}/view/tcp/logout">平台登出</a></li>
                 </sec:authorize>
                 <sec:authorize access="hasRole('ROLE_OPERATION_52')">
                    <li><a href="${ctx}/view/tcp/setParams">设置终端参数</a></li>
                 </sec:authorize>
                 <sec:authorize access="hasRole('ROLE_OPERATION_53')">
                  	<li><a href="${ctx}/view/tcp/searchParams">查询终端参数</a></li>
                 </sec:authorize>
                 <sec:authorize access="hasRole('ROLE_OPERATION_54')">
                  	<li><a href="${ctx}/view/tcp/searchOneParam">查询指定终端参数</a></li>
                  </sec:authorize>
                  <sec:authorize access="hasRole('ROLE_OPERATION_55')">
                  	<li><a href="${ctx}/view/tcp/control">终端控制</a></li>
                  </sec:authorize>
                  <sec:authorize access="hasRole('ROLE_OPERATION_56')">
                  	<li><a href="${ctx}/view/tcp/locationInfo">位置信息查询</a></li>
                  </sec:authorize>
                  <sec:authorize access="hasRole('ROLE_OPERATION_57')">
                  	<li><a href="${ctx}/view/tcp/locationFollow">临时位置跟踪控制</a></li>
                  </sec:authorize>
                  <sec:authorize access="hasRole('ROLE_OPERATION_58')">
                  	<li><a href="${ctx}/view/tcp/recordReport">命令上报学时记录</a></li>
                  </sec:authorize>
                  <sec:authorize access="hasRole('ROLE_OPERATION_59')">
                  	<li><a href="${ctx}/view/tcp/takePhoto">立即拍照</a></li>
                  </sec:authorize>
                  <sec:authorize access="hasRole('ROLE_OPERATION_60')">
                  	<li><a href="${ctx}/view/tcp/searchPhoto">查询照片</a></li>
                  </sec:authorize>
                  <sec:authorize access="hasRole('ROLE_OPERATION_61')">
                  	<li><a href="${ctx}/view/tcp/reportPhoto">上传指定照片</a></li>
                  </sec:authorize>
                  <sec:authorize access="hasRole('ROLE_OPERATION_62')">
                  	<li><a href="${ctx}/view/tcp/setDeviceParams">设置计时终端参数</a></li>
                  </sec:authorize>
                  <sec:authorize access="hasRole('ROLE_OPERATION_63')">
                  	<li><a href="${ctx}/view/tcp/searchDeviceParams">查询计时终端参数</a></li>
                  </sec:authorize>
                  <sec:authorize access="hasRole('ROLE_OPERATION_64')">
                  	<li><a href="${ctx}/view/tcp/setNoTrain">设置禁训状态</a></li>
                  </sec:authorize>
                </ul>
            </li>
            <li class="NavBox">
            <sec:authorize access="hasRole('ROLE_OPERATION_65')">
                <a class="NavTit">
                    <i class="assets"></i>
                    <span>驾校配置</span>
                </a>
             </sec:authorize>
             
                 <ul class="NavTxt">
                 <sec:authorize access="hasRole('ROLE_OPERATION_66')">
                 	<li><a href="${ctx}/view/tteacharea">片区管理</a></li>
                 </sec:authorize>
                 <sec:authorize access="hasRole('ROLE_OPERATION_70')">
                 	<li><a href="${ctx}/view/serviceStation?insId=<sec:authentication property="principal.insId"/>">网点管理</a></li>
                 </sec:authorize>
                 <sec:authorize access="hasRole('ROLE_OPERATION_74')">
                    <li><a href="${ctx}/view/drivingField?insId=<sec:authentication property="principal.insId"/>">练车场管理</a></li>
                 </sec:authorize>
                 <sec:authorize access="hasRole('ROLE_OPERATION_80')">
                  	<li><a href="${ctx}/view/trainingCar">教练车管理</a></li>
                 </sec:authorize>
                 <sec:authorize access="hasRole('ROLE_OPERATION_88')">
                  	<li><a href="${ctx}/view/device">计时终端管理</a></li>
                 </sec:authorize>
                 <sec:authorize access="hasRole('ROLE_OPERATION_98')">
                  	<li><a href="${ctx}/view/classType">班型管理</a></li>
                 </sec:authorize>
                </ul>
            </li>
            <li class="NavBox">
                <sec:authorize access="hasRole('ROLE_OPERATION_3')">
                	<a class="NavTit">
                    	<i class="user"></i>
                    	<span>职员管理</span>
                	</a>
                </sec:authorize>
                 
                 <ul class="NavTxt">
                 	<sec:authorize access="hasRole('ROLE_OPERATION_7')">
                    	<li><a href="${ctx}/view/mg/coachList">教练员管理</a></li>
                    </sec:authorize>
                    <sec:authorize access="hasRole('ROLE_OPERATION_8')">
                    	<li><a href="${ctx}/view/assessment">考核员管理</a></li>
                    </sec:authorize>
                    <sec:authorize access="hasRole('ROLE_OPERATION_9')">
                    	<li><a href="${ctx}/view/securityMember">安全员管理</a></li>
                    </sec:authorize>
                </ul>
            </li>
            <li class="NavBox">
            <sec:authorize access="hasRole('ROLE_OPERATION_128')">
                <a class="NavTit">
                    <i class="student"></i>
                    <span>学员管理</span>
                </a>
            </sec:authorize>
                 <ul class="NavTxt">
                 <sec:authorize access="hasRole('ROLE_OPERATION_129')">
                    <li><a href="${ctx}/view/student">学员管理</a></li>
                 </sec:authorize>
                 <sec:authorize access="hasRole('ROLE_OPERATION_142')">
                    <li><a href="${ctx}/view/TeachingLog">教学日志</a></li>
                 </sec:authorize>
                 <sec:authorize access="hasRole('ROLE_OPERATION_147')">
                    <li><a href="${ctx}/view/trefund">学员退费管理</a></li>
                 </sec:authorize>
                 <sec:authorize access="hasRole('ROLE_OPERATION_149')">
                    <li><a href="${ctx}/view/studentExpire">学员逾期预警</a></li>
                 </sec:authorize>
                 <sec:authorize access="hasRole('ROLE_OPERATION_150')">
                    <li><a href="${ctx}/view/timerecord">阶段培训管理</a></li>
                 </sec:authorize>
                 <sec:authorize access="hasRole('ROLE_OPERATION_156')">
                    <li><a href="#">学时管理</a></li>
                 </sec:authorize>
                 <sec:authorize access="hasRole('ROLE_OPERATION_157')">
                    <li><a href="${ctx}/view/studentRefereeManage">报名信息查询</a></li>
                 </sec:authorize>
                </ul>
            </li>
            <li class="NavBox">
            <sec:authorize access="hasRole('ROLE_OPERATION_158')">
                <a class="NavTit">
                    <i class="affairs"></i>
                    <span>教务管理</span>
                </a>
            </sec:authorize>
                 <ul class="NavTxt">
                 <sec:authorize access="hasRole('ROLE_OPERATION_159')">
                 	<li><a href="${ctx}/view/coachDutyManage">练车排班管理</a></li>
                 </sec:authorize>
                <sec:authorize access="hasRole('ROLE_OPERATION_161')">
                	<li><a href="${ctx}/view/stationDuty">练车排班记录</a></li>
                </sec:authorize>
                <sec:authorize access="hasRole('ROLE_OPERATION_163')">
                 	<li><a href="${ctx}/view/development">学时异常预警</a></li>
                </sec:authorize>
                 <sec:authorize access="hasRole('ROLE_OPERATION_164')">
                  	<li><a href="${ctx}/view/theoreticalCourseNumber">理论课人数</a></li>
                 </sec:authorize>
                 <sec:authorize access="hasRole('ROLE_OPERATION_166')">
                  	<li><a href="${ctx}/view/theoryList">理论上课名单</a></li>
                 </sec:authorize>
                 <sec:authorize access="hasRole('ROLE_OPERATION_168')">
                  	<li><a href="${ctx}/view/studentExam">考试管理</a></li>
                  	</sec:authorize>
                  <sec:authorize access="hasRole('ROLE_OPERATION_169')">
                  	<li><a href="${ctx}/view/outline">教学大纲管理</a></li>
                  </sec:authorize>
                  <sec:authorize access="hasRole('ROLE_OPERATION_170')">
                  	<li><a href="${ctx}/view/studentChangeInstitution">跨驾培机构管理</a></li>
                  </sec:authorize>
                </ul>
            </li>
            <li class="NavBox">
            <sec:authorize access="hasRole('ROLE_OPERATION_172')">
                <a class="NavTit">
                     <i class="feedback"></i>
                    <span>反馈管理</span>
                </a>
             </sec:authorize>
                 <ul class="NavTxt">
                 <sec:authorize access="hasRole('ROLE_OPERATION_173')">
                    <li><a href="${ctx}/view/shcoolcomment">学员评价驾校</a></li>
                 </sec:authorize>
                 <sec:authorize access="hasRole('ROLE_OPERATION_176')">
                    <li><a href="${ctx}/view/Coachevaluation">学员评价教练</a></li>
                 </sec:authorize>
                 <sec:authorize access="hasRole('ROLE_OPERATION_179')">
                    <li><a href="${ctx}/view/complaintsDriving">学员投诉驾校</a></li>
                 </sec:authorize>
                 <sec:authorize access="hasRole('ROLE_OPERATION_183')">
                    <li><a href="${ctx}/view/complaintsCoach">学员投诉教练</a></li>
                 </sec:authorize>
                </ul>
            </li>
            <li class="NavBox">
            <sec:authorize access="hasRole('ROLE_OPERATION_187')">
                <a class="NavTit">
                    <i class="statistics"></i>
                    <span>计时班管理</span>
                </a>
            </sec:authorize>
                 <ul class="NavTxt">
                 <sec:authorize access="hasRole('ROLE_OPERATION_188')">
                    <li><a href="${ctx}/view/development">计时班教练管理</a></li>
                 </sec:authorize>
                 <sec:authorize access="hasRole('ROLE_OPERATION_189')">
                    <li><a href="${ctx}/view/development">先付后学管理</a></li>
                 </sec:authorize>
                 <sec:authorize access="hasRole('ROLE_OPERATION_190')">
                    <li><a href="${ctx}/view/development">先学后付管理</a></li>
                 </sec:authorize>
                </ul>
            </li>
            <li class="NavBox">
            <sec:authorize access="hasRole('ROLE_OPERATION_191')">
                <a class="NavTit">
                    <i class="statistics"></i>
                    <span>财务系统</span>
                </a>
            </sec:authorize>
                 <ul class="NavTxt">
                 <sec:authorize access="hasRole('ROLE_OPERATION_192')">
                    <li><a href="${ctx}/view/development">APP报名对账</a></li>
                 </sec:authorize>
                </ul>
            </li>
            <li class="NavBox">
            <sec:authorize access="hasRole('ROLE_OPERATION_193')">
                <a class="NavTit">
                    <i class="feedback"></i>
                    <span>消息管理</span>
                </a>
            </sec:authorize>
                 <ul class="NavTxt">
                 <sec:authorize access="hasRole('ROLE_OPERATION_194')">
                    <li><a href="${ctx}/view/notificationMessage">消息列表</a></li>
                 </sec:authorize>
                </ul>
            </li>
             <li class="NavBox">
             <sec:authorize access="hasRole('ROLE_OPERATION_195')">
                <a class="NavTit">
                    <i class="statistics"></i>
                    <span>系统设置</span>
                </a>
             </sec:authorize>
                 <ul class="NavTxt">
                 <sec:authorize access="hasRole('ROLE_OPERATION_206')">
                 	<li><a href="${ctx}/view/roleManage">角色权限管理</a></li>
                 </sec:authorize>
                 <sec:authorize access="hasRole('ROLE_OPERATION_196')">
                    <li><a href="${ctx}/view/platformUser?insId=<sec:authentication property="principal.insId"/>">用户账号管理</a></li>
                 </sec:authorize>
                 <sec:authorize access="hasRole('ROLE_OPERATION_201')">
                    <li><a href="${ctx}/view/excelDatasAdd">数据导入导出</a></li>
                 </sec:authorize>
                 <sec:authorize access="hasRole('ROLE_OPERATION_204')">
                 	<li><a href="${ctx}/view/systemconfig">系统参数配置</a></li>
                 </sec:authorize>
                </ul>
            </li>
            
        </sec:authorize>
        </ul>
    </div>
    
    <div class="modal fade colsform " tabindex="-1" id="accInfo"
		role="dialog" aria-hidden="true" style="width: 450px; margin-left:-225px;">
		<form class="form-horizontal valid-form" id="updateTPlatformUser">
			<h4>编辑帐号信息</h4>
			<div class="modal-content">
				<div class="left" style="width: auto;">
					<div class="row1">
						<div class="form-controll">
							<label>用户名:</label><span><sec:authentication property="principal.username"/></span>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>旧密码:</label>
							<input class="span5 password" type="text" id="oldPasswordTrue" name="oldPasswordTrue" datatype="/^[\w\W]{6,18}$/"
								placeholder="请输入旧密码" errormsg="密码格式必须是6位到18位" nullmsg="旧密码不能为空" sucmsg=" ">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>新密码:</label>
							<input class="span5 password" type="text" name="PasswordTrue" datatype="/^[\w\W]{6,18}$/"
								placeholder="请输入新密码" errormsg="密码格式必须是6位到18位" nullmsg="新密码不能为空" sucmsg=" ">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>确认新密码:</label>
							<input class="span5 password" type="text" id="newPassword2True" name="newPassword2True" recheck="PasswordTrue" datatype="/^[\w\W]{6,18}$/"
								placeholder="请再次输入新密码" errormsg="您两次输入的账号密码不一致" nullmsg="确认新密码不能为空" sucmsg=" ">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>手机号:</label>
							<input class="span5" type="text" name="phomeTrue" value="" autocomplete="off">
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" id="accinfoSub" onClick="updatepwd();">保存</button>
			</div>
		</form>
	</div>
	
	<sec:authorize access="hasRole('ROLE_TIME_SYSTEM')">
		<script type="text/javascript">
			var role = 100;
		</script>
	</sec:authorize>
    
    <!-- end sidebar -->
	<script src="${ctx}/resources/mta/mta.js"></script>
	<script src="${ctx}/resources/mta/gri.js"></script>
	<script src="${ctx}/resources/mta/gri.dataTable.js"></script>
	<script src="${ctx}/resources/mta/gri.dateRange.js"></script>
	<!-- main container -->
    <div class="content">
    	<sitemesh:body />
	</div>
   <script type="text/javascript">
  	var insId = '<sec:authentication property="principal.insId"/>';
  	var id=	<sec:authentication property="principal.id"/>
  	var insCode = '<sec:authentication property="principal.insCode"/>';

  	//connect();
  	
    var isconnected = sessionStorage.getItem('isconnected');
  	
  	console.log("isconnected is "  + isconnected)
  	
  	//connect();
  	/*
  	if(isconnected != 1)
  	{
  		
  		connect();
  	}
  	*/
  	var socket = io('http://112.74.129.7:8709/');
  	//var socket = io('http://localhost:8709/');
    socket.on('news', function (data) {
    	console.log(data);
    	var content=JSON.parse(data.content);
		var contentBody=content.body;
    	if(content.messageIdHexString!=-2 && content.messageIdHexString!=-3){
		    if(content.messageIdHexString!=200){
    			//var obj = JSON.parse(data);
		    	/* layer.alert(data.content); */
		    }
    	}else{
    		if(($("#nowPhotoId43").attr("disabled")!=null && $("#nowPhotoId43").attr("disabled")!="disabled") || $("#nowPhotoId43").attr("disabled")==null){
	    		/*定位*/
    			if(content.messageIdHexString==-2 && contentBody.deviceId==$("#deviceId88").val()){
	    			$("#speedId").find("span").text(contentBody.engine_speed+"r/min");
	    			$("#runningSpeedId").find("span").text(contentBody.carSpeed+"km/h");
	    			if(contentBody.status!=null){
	    				$.get("${ctx}/device/inttobinary?intsta="+contentBody.status,function(result){
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
	    				})
	    			}
	    			$("#timeId").find("span").text("20"+contentBody.time.substring(0,2)+"年"+
	    					contentBody.time.substring(2,4)+"月"+contentBody.time.substring(4,6)+"日"+
	    					contentBody.time.substring(6,8)+":"+contentBody.time.substring(8,10)+":"+
	    					contentBody.time.substring(10));
	    			var latitude=(contentBody.latitude+"").substring(0,2)+"."+(contentBody.latitude+"").substring(2);
	    			var longtitude=(contentBody.longtitude+"").substring(0,3)+"."+(contentBody.longtitude+"").substring(3);
					$("#coordinateId").find("span").text(latitude+","+longtitude);
					if(latitude!="." || latitude!=null){
	    				var temp=$("#locusId").val();
	    				temp+=longtitude+","+latitude+";";
	    				$("#locusId").val(temp);
	    				//绘制轨迹
		    			paintLocus($("#locusId").val());
	    				
		    			map.setZoomAndCenter(17,[longtitude,latitude]);
						//重新定位标志物 车
						marker.setPosition([longtitude, latitude]);
	    			}
	        	}
	        	//拍照的图片显示
	        	if(content.messageIdHexString==-3 && contentBody.lic==$("#carLicensePlateId").find("span").text()){
	        		showPic(contentBody.photoUrl);
	        	}
    		}
    	}
    	$(".result_div").append("<p>").append(data.content).append("</p>");
    	
    	$(".result_div").css("width","1000px");
    	$(".result_div").css("background-color","#E0FFFF");
    	$(".result_div").css("height","400px");
    	$(".result_div").css("margin-left","-300px");
    	$(".result_div").css("overflow","auto");
    });
  	
  	
  	
  	
  	function isTimeSystem()
	{
		if(typeof(role) == "undefined")
		{
			return false;
		}
		
		if(role == 100)
		{
			return true;
		}
		return false;
		
	}
  		
	function accInfo(){
		/* 防止浏览器自动填写密码行为 */
		$(".password").focus(function(){
			$(this).attr('type','password');
		});
		
		/* 清除表单 */
		var tool = new toolCtrl();
		tool.clearForm();
		$.getJSON('${ctx}/platform/'+id, function(result) {
			if (result.code == 200) {
				$('#accInfo input[name="phomeTrue"]').val(result.data.mobile);
			}
		});
		/* 显示弹框 */
		$("#accInfo").modal('show');
		
	}
	/* $(function(){
		$("#accinfoSub").click(function(){
		})
	}) */
	function updatepwd(){
		
		//旧密码
		var oldPasswordTrue = $('#oldPasswordTrue').val();
		
		//新密码
		var newPassword2True = $('#newPassword2True').val();
		
		//电话号码
		var phomeTrue = $('#phomeTrue').val();
		// 校验表单是否通过
		if( $("#accInfo .valid-form").Validform().check() != true ){
			
			return
		}
		$.getJSON("${ctx}/platform/" + id, function(result) {
			if (result.code == 200) {
				var data = result.data;
						var params = {
							'id' : id,
							'oldPasswordTrue':oldPasswordTrue,
							'newPassword2True':newPassword2True,
							'phomeTrue':phomeTrue
						}
						//发送数据到后端保存
					 	$.post('${ctx}/platform/updatepwd', params, function(
								result) {
							if (result.code == 200) {
								//保存成功 刷新列表
								layer.alert("密码修改成功");
								$("#accInfo").modal('hide');
								buildDataTable();
							} else {
								layer.alert('修改失败,' + result.message)
							}
						}); 
			}
		})
	}
   </script>
</body>
</html>