<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-数据导入</title>
<script type="text/javascript" src="${ctx}/resources/js/admin.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery-form.js"></script>
</head>
<body>
	<div class="container-fluid new-admin">
		<div class="select-top">
		<sec:authorize access="hasRole('ROLE_SCHOOL_MANAGER')">
			<a class="select-btn" id="uploadStuExcId" onclick="clickFile()"><span class="Import"></span>导入</a>
			<a class="select-btn" onclick="exportFile();"><span class="Export"></span>导出</a>
		</sec:authorize>
		
		<sec:authorize access="hasRole('ROLE_SCHOOL_SERVICE')">
			<sec:authorize access="hasRole('ROLE_UserOperation_202')">
				<a class="select-btn" id="uploadStuExcId" onclick="clickFile()"><span class="Import"></span>导入</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_UserOperation_203')">
				<a class="select-btn" onclick="exportFile();"><span class="Export"></span>导出</a>
			</sec:authorize>
		</sec:authorize>
		</div>
	</div>
	<div style="display: none">
		<form method="POST" enctype="multipart/form-data" id="uploadExcId">
			<input id="upfile" type="file" name="upfile"
				onchange="clickAjaxSubmit()" /> <input type="button"
				id="ajaxUploadId" />
		</form>
	</div>
	<script type="text/javascript">
		var dataTable = null;
		var insId= '<sec:authentication property="principal.insId"/>';
		var insName = '<sec:authentication property="principal.insName"/>';
		var statId= '<sec:authentication property="principal.stationId"/>';
		var insCode = '<sec:authentication property="principal.insCode"/>';
		function clickFile(){
			$("#upfile").click();
		}
		function clickAjaxSubmit(){
			$('#ajaxUploadId').click();
		}
		//ajax 方式上传文件操作
		$('#ajaxUploadId').click(function(){
           if(checkData()){
        	   if(statId!='null'){
        	   	   var param={"stationId":statId};
        	   }else{
        		   var param={"stationId":null};   
        	   }
               $('#uploadExcId').ajaxSubmit({
                   url:'${ctx}/insertsevensheetsdatas',  
                   data:param,
                   dataType: 'json',  
                   success: function resutlMsg(result){
	            	   $("#upfile").val("");
	            	   if(result.code==200){
	            		   layer.alert("导入数据成功!")
	            	   }else{
	            		   layer.alert("导入数据失败!")
	            	   }
	               },
                   error: function errorMsg(){
	            	   $("#upfile").val("");
	            	   layer.alert(result.message);   
	               }  
               });
           }  
       });
		//JS校验form表单信息  
	    function checkData(){
	       var fileDir = $("#upfile").val();  
	       var suffix = fileDir.substr(fileDir.lastIndexOf("."));  
	       if("" == fileDir){  
	    	   layer.alert("选择需要导入的Excel文件！");  
	           return false;  
	       }  
	       if(".xls" != suffix && ".xlsx" != suffix ){  
	    	   layer.alert("选择Excel格式的文件导入！");  
	           return false; 
	       }  
	       return true;  
	    }
		
	    function exportFile(){
	    	if(statId=='null'){
	    		statId=-1;
	    	}
			window.location.href="${ctx}/exportdatas580?insId="+insId+"&stationId="+statId+"&insCode="+insCode;
		}
	</script>
</body>
</html>