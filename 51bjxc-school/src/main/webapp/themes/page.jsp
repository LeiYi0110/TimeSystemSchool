<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<!DOCTYPE html>
<html>
<head>
	<title><sitemesh:title default="阳光驾培" /></title>
    
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="icon" type="image/png" href="${ctx}/favicon.ico" />
	
    <!-- bootstrap -->
    
    
    	<!-- scripts for this page -->
    <!-- 
    <script src="${ctx}/resources/js/jquery-latest.js"></script>
     -->
    <%-- <script src="${ctx}/resources/js/jquery.js"></script> --%>
    <script src="${ctx}/resources/js/jquery-1.11.3.min.js"></script>
    <script src="${ctx}/resources/js/jquery-ui-1.10.2.custom.min.js"></script>
    <script src="${ctx}/resources/js/bootstrap.min.js"></script>
    <script src='${ctx}/resources/js/fullcalendar.min.js'></script>
    <script src="${ctx}/resources/js/theme.js"></script>
    <script src="${ctx}/resources/js/jquery.bigautocomplete.js"></script>
    
    
    <link type="text/css" href="${ctx}/resources/css/bootstrap/bootstrap.css" rel="stylesheet" />
    <link type="text/css" href="${ctx}/resources/css/bootstrap/bootstrap-responsive.css" rel="stylesheet" />
    <link type="text/css" href="${ctx}/resources/css/bootstrap/bootstrap-overrides.css" rel="stylesheet" />

    <!-- libraries -->
    <link href="${ctx}/resources/css/lib/jquery-ui-1.10.2.custom.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/resources/css/lib/font-awesome.css" type="text/css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/css/jquery.bigautocomplete.css" />

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
            
            <a class="brand" href="${ctx}/school"><img src="${ctx}/resources/img/logo.png"  style="height:21px;"/></a>

        </div>
    </div>
    <!-- end navbar -->

	<script src="${ctx}/resources/mta/mta.js"></script>
	<script src="${ctx}/resources/mta/gri.js"></script>
	<script src="${ctx}/resources/mta/gri.dataTable.js"></script>
	<script src="${ctx}/resources/mta/gri.dateRange.js"></script>
	<!-- main container -->
    <div class="content">
    	<sitemesh:body />
	</div>
</body>
</html>