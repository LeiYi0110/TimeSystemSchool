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
    <script src="${ctx}/resources/js/jquery.js"></script>
    <script src="${ctx}/resources/js/jquery-ui-1.10.2.custom.min.js"></script>
    <script src="${ctx}/resources/js/bootstrap.min.js"></script>
    <script src='${ctx}/resources/js/fullcalendar.min.js'></script>
    <script src="${ctx}/resources/js/theme.js"></script>
    <script src="${ctx}/resources/js/jquery.bigautocomplete.js"></script>
    
    
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

    <!-- open sans font
    <link href='http://fonts.useso.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css' />
 -->
    <!-- lato font
    <link href='http://fonts.useso.com/css?family=Lato:300,400,700,900,300italic,400italic,700italic,900italic' rel='stylesheet' type='text/css' />
 -->
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<sitemesh:head />
<style type="text/css">
	#insid-label{
    	width: 180px;
    	margin: 0em;
    	padding-right: 15px;
    	padding-top:10px;
	    margin-bottom: 0;
	    font-weight: 80;
	    font-size:20px;
    	text-shadow: 1px 1px 1px #fff;
    	line-height:20px;
    	vertical-align:middle;
    	text-align:left;
    	height:40px;
    	color:fff;
	}
</style>
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
            
            <a class="brand" href="${ctx}/school"><img src="${ctx}/resources/img/logo.png" style="height:21px;"/>
					<span id="insid-label"><sec:authentication property="principal.insName"/></span>
			</a>
            <ul class="nav pull-right">                
                <li class="hidden-phone">
                    <input class="search" type="text" />
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle hidden-phone" data-toggle="dropdown">
                        <sec:authentication property="principal.username"/>
                        <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="#">帐号信息</a></li>
                        <li><a href="${ctx}/logout">退出</a></li>
                    </ul>
                </li>
                
           		<sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
                <li class="settings hidden-phone">
                    <a href="${ctx}/view/manager" role="button">
                        <i class="icon-cog"></i>
                    </a>
                </li>
               </sec:authorize>
            </ul>            
        </div>
    </div>
    <!-- end navbar -->

    <!-- sidebar -->
    <div id="sidebar-nav">
        <ul id="dashboard-menu">
            <li class="active">
                <a href="${ctx}/view/school" class="dropdown-toggle">
                    <i class="icon-home"></i>
                    <span>驾校概况</span>
                </a>
                 <ul class="submenu" style="display: block;">
                    <li><a href="${ctx}/view/StudentCount">学员数据统计</a></li>
                  	<li><a href="${ctx}/view/CoachCount">教练数据统计</a></li>
                </ul>
            </li>            
            <li class="active">
                <a class="dropdown-toggle" href="#">
                    <i class="icon-group"></i>
                    <span>教练管理</span>
                </a>
                <ul class="submenu" style="display: block;">
                    <li><a href="${ctx}/view/mg/coachList">全部教练</a></li>
                    <sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
	                    <li><a href="${ctx}/view/mg/coachEditor">添加教练</a></li>
                  	</sec:authorize>
                  	<li><a href="${ctx}/view/dutyList">培训时段管理</a></li>
                </ul>
            </li>
            <li class="active">
                <a class="dropdown-toggle" href="#">
                    <i class="icon-edit"></i>
                    <span>学员管理</span>
                    <i class="icon-chevron-down"></i>
                </a>
                <ul class="submenu" style="display: block;">
                    <li><a href="${ctx}/view/student">全部学员</a></li>
                    <li><a href="${ctx}/view/studentChangeStation">学员转店管理</a></li>
                    <sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
	                    <li><a href="${ctx}/view/studentEditor">添加学员</a></li>
	                    <li><a href="${ctx}/view/studentExam">考试管理</a></li>
                    </sec:authorize>
                    <!-- 
                    <li><a href="${ctx}/view/studentError">学员信息报错</a></li>
                     -->
                </ul>
            </li>
            <sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
            <li class="active">
                <a class="dropdown-toggle" href="#">
                    <i class="icon-edit"></i>
                    <span>App报名管理</span>
                    <i class="icon-chevron-down"></i>
                </a>
                <ul class="submenu" style="display: block;">
                   <li><a href="${ctx}/view/studentReferee">APP报名</a></li>
                </ul>
            </li>
         	
            <li class="active">
                <a class="dropdown-toggle" href="#">
                    <i class="icon-code-fork"></i>
                    <span>驾校管理</span>
                    <i class="icon-chevron-down"></i>
                </a>
                <ul class="submenu" style="display: block;">
                	<li><a href="${ctx}/view/classType">班型管理</a></li>
                	<li><a href="${ctx}/view/trainingCar">教练车管理</a></li>
                    <li><a href="${ctx}/view/drivingField">练车场地管理</a></li>
                    <li><a href="${ctx}/view/serviceStation">服务网点管理</a></li>	
                    
                </ul>
             </li>   
             </sec:authorize>
             <li class="active">
              	 <a class="dropdown-toggle" href="#">
                  	 <i class="icon-edit"></i>
                  	 <span>计时班管理</span>
                   	 <i class="icon-chevron-down"></i>
               	</a>
               	<ul class="submenu" style="display: block;">
               		<li><a href="${ctx}/view/studentFirstLearning">先学后付</a></li>
               		<li><a href="${ctx}/view/studentFirstPay">先付后学</a></li>
               	</ul>
            </li>
            <sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
            <li class="active">
              	 <a class="dropdown-toggle" href="#">
                  	 <i class="icon-edit"></i>
                  	 <span>教务管理</span>
                   	 <i class="icon-chevron-down"></i>
               	</a>
               	<ul class="submenu" style="display: block;">
               		<li><a href="${ctx}/view/securityMember">安全员管理</a></li>
               		<li><a href="${ctx}/view/assessment">考核员管理</a></li>
               		<li><a href="${ctx}/view/device">计时终端管理</a></li>
               		<li><a href="${ctx}/view/comment">评价信息管理</a></li>
               		<li><a href="${ctx}/view/complaintInfo">投诉信息管理</a></li>
               		<li><a href="${ctx}/view/teachingProgram">教学大纲管理</a></li>
               		<li><a href="${ctx}/view/studentExpire">学员到期管理</a></li>
               		<li><a href="${ctx}/view/studentWarning">学时异常管理</a></li>
               		<li><a href="#">跨驾培机构管理</a></li>
               	</ul>
            </li>
            </sec:authorize> 
	            <li class="active">
	                 <a class="dropdown-toggle" href="#">
	                  	 <i class="icon-edit"></i>
	                  	 <span>帐号管理</span>
	                   	 <i class="icon-chevron-down"></i>
	               	</a>
	                <ul class="submenu" style="display: block;">
	                     <li><a href="${ctx}/view/platformUser">帐号信息</a></li>
	                </ul>
	            </li> 
   
           <%-- <sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
	            <li class="active">
	            	<a href="${ctx}/view/manager">
	               	 	<button>驾校管理</button>
	                </a>
	            </li>
           </sec:authorize> --%> 
        </ul>
    </div>
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
        $(function() {
            //标识当前页面的菜单
            if (current_action) {
                var atag = $('#dashboard-menu a[href="' + current_action + '"]');
                var litag = $(atag).parent('li');
                var pointer = ' <div class="pointer"> <div class="arrow"></div> <div class="arrow_border"></div> </div>';
                litag.append(pointer);
            }
        });
    </script>
 
</body>
</html>