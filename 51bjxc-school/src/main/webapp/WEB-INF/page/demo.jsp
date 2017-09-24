<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/meta/meta-tag.jsp" %>
<html>
<head>
<meta name="theme" content="school" />
<title>阳光驾培-demo</title>
<script src="${ctx}/resources/uploadify/jquery.uploadify.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/resources/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=4O6x7Ox8vHvQeQgnMAPOolXiYkudOdZr"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.js"></script>
<link rel="stylesheet" href="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.css" />
</head>
<body>
	<div class="container-fluid new-admin">
		<div class="select-top">
			<a class="select-btn" onclick="addModal()"><span class="add"></span>新增</a>
			<a class="select-btn" onclick="editModal()"><span class="edit" ></span>修改</a>
			<a class="select-btn "><span class="del"></span>删除</a>
			<a class="select-btn" onclick="getCheckbox()"><span class="spare"></span>备案</a>
			<a class="select-btn" onclick="tanchu()"><span class="shift"></span>转店</a>
			<a class="select-btn" onclick="myMap()"><span class="Refund"></span>退费</a>
			<a class="select-btn"><span class="tpl"></span>导入模板</a>
			<a class="select-btn"><span class="Import"></span>导入</a>
			<a class="select-btn"><span class="Export"></span>导出</a>
		</div>
	</div>
 	 <div class="TermSearch">
 	 <form>
	 <input class="input1 win200" type="text" placeholder="输入学员号/身份证号/学员姓名/手机号码/教练姓名搜索">
	 <select>
  	 	<option value="">已受理未上课</option>
  	 	<option value="">报名未受理</option>
  	 	<option value="">科目一</option>
  	 	<option value="">科目二</option>
  	 	<option value="">科目三</option>
  	 	<option value="">科目四</option>
  	 	<option value="">结业</option>
  	 	<option value="">退费</option>
	 </select>
	 <input type="text" class="form_date input1 win90" data-date-format="yyyy-mm-dd" placeholder="请选择开始日期" readonly="readonly">
	 <input type="text" class="form_date input1 win90" data-date-format="yyyy-mm-dd" placeholder="请选择结束日期" readonly="readonly">
	 <buuton class="btn-flat primary">搜 索</buuton>
	 </form>
	 </div>
	<!-- 列表 -->
	<div class="row-fluid">
		<div class="sub_content">
			<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
			<div id="table_list" class="gri_wrapper"></div>
			
		</div>
	</div>
	
	<div class="modal fade colsform" id="addStudent" tabindex="-1" role="dialog" aria-hidden="true">	
		<form class="form-horizontal valid-form">
			<h4>新增学员</h4>
			<div class="modal-content">
				<div class="left">
					<div class="row1">
						<div class="form-controll">
							<label>姓名:</label>
							<input type="text" datatype="*" errormsg="姓名" nullmsg="姓名不能为空" sucmsg=" " >
						</div>
						<div class="form-controll">
							<label>性别:</label>
							<input type="radio" name="sex" checked> 男
							<input type="radio" name="sex" > 女
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>国籍:</label>
							<select>
  								<option value ="volvo">Volvo</option>
  								<option value ="saab">Saab</option>
 								<option value="opel">Opel</option>
  								<option value="audi">Audi</option>
							</select>
						</div>
						<div class="form-controll">
							<label>联系地址:</label>
							<input type="text">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>证件类型:</label>
							<input type="radio" name="aa" checked> 身份证
							<input type="radio" name="aa" > 军官证
							<input type="radio" name="aa" > 护照
							<input type="radio" name="aa" > 其他
						</div>
						<div class="form-controll">
							<label>证件号:</label>
							<input type="text">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>电话号码:</label>
							<input type="text">
						</div>
						<div class="form-controll">
							<label>报名时间:</label>
							<input type="text" name="applydate"  class="form_date" data-date-format="yyyy-mm-dd" >
						</div>
					</div>
					<div class="row1">
						<div class="form-controll width100">
							<label>电话号码:</label>
							<div class="input-three">
								<label>应付:
									<input type="text" datatype="*" errormsg="姓名" nullmsg="应付不能为空" sucmsg=" ">
								</label>
								<label>应付:
									<input type="text" datatype="*" errormsg="姓名" nullmsg="已付不能为空" sucmsg=" ">
								</label>
								<label>应付:
									<input type="text" datatype="*" errormsg="姓名" nullmsg="未付不能为空" sucmsg=" ">
								</label>
							</div>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll wid90">
							<label>电话号码:</label>
							<textarea datatype="*" errormsg="姓名" nullmsg="备注不能为空" sucmsg=" "></textarea>
						</div>
					</div>
				</div>
				<div class="right">
					<div class="rk_swfupload">
						<div style="height: 60px; width: 100px; display: inline-block;">
							<span class="pic">个人相片<img id="photo" name="photo" src="" class="img-thumbnail upload-img"></span>
							<a style="margin-top:20px; width:100px;" class="btn btn-success">上传</a>
						</div>
						<div class="swfobj swfobj-position">
							<input type="file" name="a1" id="file" style="display:none;"/>
							<div for="file" id="upload_buton_img"></div>
						</div>
					</div>
					<div class="rk_swfupload">
						<div style="height: 60px; width: 100px; display: inline-block;">
							<span class="pic">指纹<img id="photo2" name="photo" src="" class="img-thumbnail upload-img"></span>
							<a style="margin-top:20px; width:100px;" class="btn btn-success">上传</a>
						</div>
						<div class="swfobj swfobj-position">
							
							<div  id="upload_buton_img2"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" onclick="sub()" >保存</button>
			</div>
		</form>
	</div>
	
	<div class="modal fade colsform" id="editStudent" tabindex="-1" role="dialog"  aria-hidden="true">	
		<form class="form-horizontal">
			<h4>查看详情</h4>
			<div class="modal-content">
				<div class="left">
					<div class="row1">
						<div class="form-controll">
							<label>姓名:</label>
							<input type="text" value="呵呵呵">
						</div>
						<div class="form-controll">
							<label>性别:</label>
							<input type="radio" name="sex" checked> 男
							<input type="radio" name="sex" > 女
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>国籍:</label>
							<select>
  								<option value ="volvo">Volvo</option>
  								<option value ="saab">Saab</option>
 								<option value="opel">Opel</option>
  								<option value="audi">Audi</option>
							</select>
						</div>
						<div class="form-controll">
							<label>联系地址:</label>
							<input type="text">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>证件类型:</label>
							<input type="radio" name="aa" checked> 身份证
							<input type="radio" name="aa" > 军官证
							<input type="radio" name="aa" > 护照
							<input type="radio" name="aa" > 其他
						</div>
						<div class="form-controll">
							<label>证件号:</label>
							<input type="text">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>电话号码:</label>
							<input type="text">
						</div>
						<div class="form-controll">
							<label>报名时间:</label>
							<input type="text" name="applydate"  class="form_date" data-date-format="yyyy-mm-dd" readonly="readonly" >
						</div>
					</div>
					<div class="row1">
						<div class="form-controll width100">
							<label>电话号码:</label>
							<span>应付:</span><input type="text">
							<span>应付:</span><input type="text" >
							<span>应付:</span><input type="text" >
						</div>
					</div>
					<div class="row1">
						<div class="form-controll wid90">
							<label>电话号码:</label>
							<textarea></textarea>
						</div>
						
					</div>
				</div>
				<div class="right">
					<div class="rk_swfupload">
						<div style="height: 60px; width: 100px; display: inline-block;">
							<span class="pic">个人相片</span>
							<img id="photo" name="photo" src="" class="img-thumbnail">
							<a style="margin-top:20px; width:100px;" class="btn btn-success">上传</a>
						</div>
						<div class="swfobj swfobj-position">
							<div id="upload_buton_img1"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onClick="changeCoach();">保存</button>
			</div>
		</form>
	</div>
	
	
	<div class="modal fade colsform" id="viewStudent" tabindex="-1" role="dialog" aria-hidden="true">	
		<form class="form-horizontal">
			<h4>查看详情</h4>
			<div class="modal-content">
				<div class="left">
					<div class="row1">
						<div class="form-controll">
							<label>姓名:</label>
							<input type="text" value="呵呵呵" disabled/>
						</div>
						<div class="form-controll">
							<label>性别:</label>
							<input type="text" value="男" disabled/>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>国籍:</label>
							<input type="text" value="中国" disabled/>
						</div>
						<div class="form-controll">
							<label>联系地址:</label>
							<input type="text">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>证件类型:</label>
							<input type="text" value="身份证" disabled/>
						</div>
						<div class="form-controll">
							<label>证件号:</label>
							<input type="text">
						</div>
					</div>
					<div class="row1">
						<div class="form-controll">
							<label>电话号码:</label>
							<input type="text">
						</div>
						<div class="form-controll">
							<label>报名时间:</label>
							<input type="text" value="2016/11/9" disabled>
						</div>
					</div>
					<div class="row1">
						<div class="form-controll width100">
							<label>电话号码:</label>
							<span>应付:</span><input type="text">
							<span>应付:</span><input type="text" >
							<span>应付:</span><input type="text" >
						</div>
					</div>
					<div class="row1">
						<div class="form-controll wid90">
							<label>电话号码:</label>
							<textarea></textarea>
						</div>
						
					</div>
				</div>
				<div class="right">
					<div class="rk_swfupload">
						
						<span class="pic">个人相片<img id="photo" name="photo" src="" class="img-thumbnail upload-img"></span>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			</div>
		</form>
	</div>
	
	<div class="modal fade colsform" id="Scheduling" tabindex="-1" role="dialog" aria-hidden="true">	
		<h4>【教练名】的排班记录</h4>
		<div class="sub_content">
			<!--图控件的模版，这里目前内容较少，后面方便扩展，直接在这里修改-->
			<div id="Scheduling_list" class="">
				<table class="gri_stable">
					<thead>
						<tr>
							<th class="tab-button" data-date-format="yyyy-mm-dd" readonly="readonly">
								<span>选择日期</span>
							</th>
							<th>2016-11-09</th>
							<th>2016-11-10</th>
							<th>2016-11-11</th>
							<th>2016-11-12</th>
							<th>2016-11-13</th>
							<th>2016-11-14</th>
							<th>2016-11-15</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><span>7:00-8:00</span></td>
							<td><span class="red">未预约</span></td>
							<td><span class="rest">休息</span></td>
							<td><span class="green">可预约</span></td>
							<td><span class="blue">呵呵呵<br>13166668888</span></td>
							<td><span class="red">未预约</span></td>
							<td><span class="rest">休息</span></td>
							<td><span class="green">可预约</span></td>
						</tr>
						<tr>
							<td><span>7:00-8:00</span></td>
							<td><span class="red">未预约</span></td>
							<td><span class="rest">休息</span></td>
							<td><span class="green">可预约</span></td>
							<td><span class="blue">呵呵呵<br>13166668888</span></td>
							<td><span class="red">未预约</span></td>
							<td><span class="rest">休息</span></td>
							<td><span class="green">可预约</span></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		</div>
	</div>
	
	<!-- 图片视频 -->
	<div class="modal fade colsform modal750" id="media" tabindex="-1" role="dialog" aria-hidden="true">
		<h4>图片视频</h4>
		
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		</div>
	</div>
	
	
	<div class="modal fade colsform" id="record" tabindex="-1" role="dialog" aria-hidden="true">	
		<h4>用车记录</h4>
		<div class="sub_content">
			<div class="tab-scroll">
			 <table>
			  	<thead>
			  		<tr>
			  			<th>日期</th>
			  			<th>开始时间</th>
			  			<th>结束时间</th>
			  			<th>学员姓名</th>
			  			<th>科目项目</th>
			  			<th>班级类型</th>
			  		</tr>
			  	</thead>
			  	<tbody>
			  		<tr>
			  			<td>2015-9-7</td>
				  		<td>8：00</td>
				  		<td>10：00</td>
				  		<td>刘德华</td>
				  		<td>科目二</td>
				  		<td>先学后付</td>
			  		</tr>
			  		<tr>
			  			<td>2015-9-7</td>
				  		<td>8：00</td>
				  		<td>10：00</td>
				  		<td>刘德华</td>
				  		<td>科目二</td>
				  		<td>先学后付</td>
			  		</tr>
			  		<tr>
			  			<td>2015-9-7</td>
				  		<td>8：00</td>
				  		<td>10：00</td>
				  		<td>刘德华</td>
				  		<td>科目二</td>
				  		<td>先学后付</td>
			  		</tr>
			  		<tr>
			  			<td>2015-9-7</td>
				  		<td>8：00</td>
				  		<td>10：00</td>
				  		<td>刘德华</td>
				  		<td>科目二</td>
				  		<td>先学后付</td>
			  		</tr>
			  		<tr>
			  			<td>2015-9-7</td>
				  		<td>8：00</td>
				  		<td>10：00</td>
				  		<td>刘德华</td>
				  		<td>科目二</td>
				  		<td>先学后付</td>
			  		</tr>
			  		<tr>
			  			<td>2015-9-7</td>
				  		<td>8：00</td>
				  		<td>10：00</td>
				  		<td>刘德华</td>
				  		<td>科目二</td>
				  		<td>先学后付</td>
			  		</tr>
			  		<tr>
			  			<td>2015-9-7</td>
				  		<td>8：00</td>
				  		<td>10：00</td>
				  		<td>刘德华</td>
				  		<td>科目二</td>
				  		<td>先学后付</td>
			  		</tr>
			  		<tr>
			  			<td>2015-9-7</td>
				  		<td>8：00</td>
				  		<td>10：00</td>
				  		<td>刘德华</td>
				  		<td>科目二</td>
				  		<td>先学后付</td>
			  		</tr>
			  		<tr>
			  			<td>2015-9-7</td>
				  		<td>8：00</td>
				  		<td>10：00</td>
				  		<td>刘德华</td>
				  		<td>科目二</td>
				  		<td>先学后付</td>
			  		</tr>
			  		<tr>
			  			<td>2015-9-7</td>
				  		<td>8：00</td>
				  		<td>10：00</td>
				  		<td>刘德华</td>
				  		<td>科目二</td>
				  		<td>先学后付</td>
			  		</tr>
			  		<tr>
			  			<td>2015-9-7</td>
				  		<td>8：00</td>
				  		<td>10：00</td>
				  		<td>刘德华</td>
				  		<td>科目二</td>
				  		<td>先学后付</td>
			  		</tr>
			  		<tr>
			  			<td>2015-9-7</td>
				  		<td>8：00</td>
				  		<td>10：00</td>
				  		<td>刘德华</td>
				  		<td>科目二</td>
				  		<td>先学后付</td>
			  		</tr>
			  		<tr>
			  			<td>2015-9-7</td>
				  		<td>8：00</td>
				  		<td>10：00</td>
				  		<td>刘德华</td>
				  		<td>科目二</td>
				  		<td>先学后付</td>
			  		</tr>
			 	 </tbody>
			 </table>
			 
		   </div>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal" onclick="clearRow()">关闭</button>
		</div>
	</div>
	
	
	<!-- 进度管理 -->
	<div class="modal fade" id="setbacks" tabindex="-1" role="dialog"
		aria-labelledby="editorModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">指定教练</h4>
				</div>
				<div class="modal-body">
					<div class="span5 no-margin">
						<form>
							<div class="row1">
								<label>状态：</label>
								<select id="setbacksSelect" name="">
									<option>报名未受理</option>
									<option>已受理未上课</option>
									<option>科目一学习中</option>
									<option>科目二学习中</option>
									<option >科目三学习中</option>
									<option>科目四学习中</option>
									<option selected="selected">已结业</option>
								</select>
							</div>
							<div class="tab-con"></div>
							<div class="tab-con">
								<div class="row1">
									<label>流水号：</label>
									<input type="text">
								</div>
							</div>
								<div class="tab-con"></div>
								<div class="tab-con">
									<div class="row1">
										<label>科目一成绩：</label>
										<input type="text">
									</div>
								</div>
								<div class="tab-con">
									<div class="row1">
										<label>科目二成绩：</label>
										<input type="text">
									</div>
								</div>
								<div class="tab-con">
									<div class="row1">
										<label>科目三成绩：</label>
										<input type="text">
									</div>
								</div>
								<div class="tab-con">
									<div class="row1">
										<label>科目四成绩：</label>
										<input type="text">
									</div>
									<div class="row1">
										<label>驾驶证号：</label>
										<input type="text">
									</div>
									<div class="row1">
										<label>发证机关编号：</label>
										<input type="text">
									</div>
									<div class="row1">
										<label>结业证书编号：</label>
										<input type="text">
									</div>
									<div class="row1">
										<label>结业证书文件：</label>
										<input type="file">（PDF文件）
									</div>
									<div class="row1">
										<label>机构电子签章：</label>
										<input type="file">
									</div>
								</div>
						</form>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" onClick="changeCoach();">保存</button>
			</div>
		</div>
	</div>
	
	<!-- 练车场地 -->
	<div class="modal fade colsform right-map" tabindex="-1" id="myMap" role="dialog" aria-hidden="true">
			<form class="form-horizontal" id="ediorForm">
				<h4>练车场地</h4>
				<div class="modal-content">
					<div class="left">
						<div class="row1">
							<div class="form-controll">
							    <input type="hidden" id="id" name="id" />
								<label>名称:</label> <input type="text" name="name">
							</div>
						</div>
						<div class="row1">
							<div class="form-controll">
								<label>场地编号:</label> <input type="text" name="seq">
							</div>
						</div>
						<div class="row1">
							<div class="form-controll">
								<label>隶属片区:</label> <select name="areaId" id="areaId">
									<option value="">请选择</option>
									<c:forEach items="${areasList}" var="tmp">
									<option value="${tmp.id}">${tmp.name}</option>
								</c:forEach>
								</select>
							</div>
						</div>
						<div class="row1">
							<div class="form-controll">
								<label>教学区域类型:</label>
								<input type="checkbox" name="type" value="1"> 科目二 
								<input type="checkbox" name="type" value="2"> 科目三
							</div>
						</div>
						<div class="row1">
							<div class="form-controll">
								<label>可容纳车辆数:</label> <input type="text" name="totalvehnum">
							</div>
						</div>
						<div class="row1">
							<div class="form-controll">
								<label>已容纳车辆数:</label> <input type="text" name="curvehnum">
							</div>
						</div>
						<div class="row1">
							<div class="form-controll">
								<label>面积m²:</label> <input type="text" name="area">
							</div>
						</div>
						<div class="row1">
							<div class="form-controll" style="width: 100%;">
								<label>地址:</label> 
								<input type="text" name="address" id="address" style="width: 300px;">
							</div>
						</div>
						<div class="row1">
							<div class="form-controll" style="width: 620px;">
								<label style="height: 50px;">培训车型：</label> 
								    <span style="padding-right: 5px;"><input type="checkbox" name="vehicletype" value="A1" style="margin: 0 3px 0 0;"> A1</span> 
									<span style="padding-right: 5px;"><input type="checkbox" name="vehicletype" value="A2" style="margin: 0 3px 0 0;"> A2</span> 
									<span style="padding-right: 5px;"><input type="checkbox" name="vehicletype" value="A3" style="margin: 0 3px 0 0;"> A3</span> 
									<span style="padding-right: 5px;"><input type="checkbox" name="vehicletype" value="B1" style="margin: 0 3px 0 0;"> B1</span> 
									<span style="padding-right: 5px;"><input type="checkbox" name="vehicletype" value="B2" style="margin: 0 3px 0 0;"> B2</span> 
									<span style="padding-right: 5px;"><input type="checkbox" name="vehicletype" value="B3" style="margin: 0 3px 0 0;"> B3</span> 
									<span style="padding-right: 5px;"><input type="checkbox" name="vehicletype" value="C1" style="margin: 0 3px 0 0;"> C1</span><br> 
									<span style="padding-right: 5px;"><input type="checkbox" name="vehicletype" value="C2" style="margin: 0 3px 0 0;"> C2</span> 
									<span style="padding-right: 5px;"><input type="checkbox" name="vehicletype" value="C3" style="margin: 0 3px 0 0;"> C3</span> 
									<span style="padding-right: 5px;"><input type="checkbox" name="vehicletype" value="C4" style="margin: 0 3px 0 0;"> C4</span> 
									<span style="padding-right: 5px;"><input type="checkbox" name="vehicletype" value="C5" style="margin: 0 3px 0 0;"> C5</span>
									<span style="padding-right: 5px;"><input type="checkbox" name="vehicletype" value="D" style="margin: 0 3px 0 0;">  D</span> 
									<span style="padding-right: 5px;"><input type="checkbox" name="vehicletype" value="E" style="margin: 0 3px 0 0;">  E</span> 
									<span style="padding-right: 5px;"><input type="checkbox" name="vehicletype" value="F" style="margin: 0 3px 0 0;">  F</span><br>
									<span style="padding-right: 5px;"><input type="checkbox" name="vehicletype" value="M" style="margin: 0 3px 0 0;">  M</span> 
									<span style="padding-right: 5px;"><input type="checkbox" name="vehicletype" value="N" style="margin: 0 3px 0 0;">  N</span> 
									<span style="padding-right: 5px;"><input type="checkbox" name="vehicletype" value="P" style="margin: 0 3px 0 0;">  P</span>
							</div>
						</div>
					</div>
					<div class="right" id="right-map"></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onClick="save();">保存</button>
					<div class="right-footer">
						<span>绘制区域的坐标点必须大于2小于7，<b>双击</b>结束绘制</span>
						<input type="button" class="btn btn-warning" value="重新绘制" id="clearAll" />
					</div>
				</div>
			</form>
		</div>
			
	<script type="text/javascript">
    	var current_action = "${ctx}/view/student";
	
		//标识当前页面的url 用来设置当前菜单标识
		var dataTable = null;
		var insId= <sec:authentication property="principal.insId"/>;
		var stationId= <sec:authentication property="principal.stationId"/>;
		//初始化 
		$(document).ready(function() {
			//初始化界面  完成后调用buildData方法
			MTA.Report.initialize(null, 'buildData');
		});

		function buildData() {
			MTA.Util.setParams('insId', insId);
			var coachId=$("#coachId").val();
			if(stationId && stationId != ''){
				MTA.Util.setParams('stationId', stationId);
			}
			if(coachId && coachId != ''){
				MTA.Util.setParams('coachId', coachId);
			}
			buildDataTable();
		}
		/**
		 *	搜索
		 */
		function searchQuery() {
			var search = $("#search").val();
			var coachOrStu=$("#coachOrStu").val();
			MTA.Util.setParams('searchText', search);
			MTA.Util.setParams('coachOrStu', coachOrStu);
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
				'stunum' : {
					'thText' : ' ',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<span data-id="');
							td.push(record.id);
							td.push('">');
							td.push('<input type="checkbox" value="'+ record.id +'">');
						td.push('</span>');
						return td.join('');
					}
				},
				'idcard' : {
					'thText' : '身份证号',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
				},
				'name' : {
					'thText' : '进度管理',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'render' : function(value, cellmeta, record, rowIndex,columnIndex) {
						var td = [];
						td.push('<li>');
							td.push('科目二: ');
							td.push(record.coachName);
							td.push('&nbsp;&nbsp;');
							td.push('<a href="#" onclick="showSetbacks()">');
							td.push('<i class="icon-pencil"></i>');
							td.push('</a>');
						td.push('</li>');
						td.push('</ul>');
						return td.join('');
					}
				},
				'sex' : {
					'thText' : '性别 ',
					'number' : true,
					'needOrder' : false,
					'precision' : 0,
					'render' : function() {
						var td = [];
						td.push('<input class="tab-input-text" type="text" value="">');
						return td.join('');
					}
				},
				'mobile' : {
					'thText' : '手机号码',
					'number' : false,
					'needOrder' : false,
					'render': function(){
						var td = [];
						td.push('<span class="tab-date">');
							td.push('2016-12-5');
						td.push('</span>')
						return td.join('');
					}
				},
				'id' : {
					'thText' : '校证、核对',
					'number' : false,
					'needOrder' : false,
					'precision' : 0,
					'width' : '150px',
					'render' : function(value, cellmeta, record, rowIndex,
							columnIndex) {
						var td = [];
						td.push('<button class="btn btn-success" data-toggle="modal" data-target="#viewStudent">详情</button>');
						td.push('<button class="btn btn-success" data-toggle="modal" data-target="#Scheduling">排班表</button>');
						td.push('<button class="btn btn-success" onclick="mgmt()">教学日志</button>'); 
						td.push('<button class="btn btn-success" onclick="record()">用车记录</button>'); 
						return td.join('');
					}
				}
			};
			
			//ajax的数据请求参数
			config['page'] = {
				'url' : '${ctx}/coach/list?insId=1&stationId=null',
				'size' : 10,
				'ifRealPage' : 1
			};
			config['callback'] = function(){
				$('.tab-date').datetimepicker({
			        language:  'zh-CN',
			        weekStart: 1,
			        todayBtn:  1,
					autoclose: 1,
					todayHighlight: 0,
					startView: 2,
					minView: 2,
					forceParse: 0
			   }).on('changeDate',function(ev){
				   $(this).html('<span data-id="">'+ ev.date +'</span>');
			   });
				
				$(".tab-input-text").change(function(){
					alert($(this).val());
				})
			};
			//初始化 并通过ajax加载数据
			dataTable = MTA.Data.loadAjaxPageTable(config);
		}

		
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
		$('.tab-button').datetimepicker({
	        language:  'zh-CN',
	        weekStart: 1,
	        todayBtn:  1,
			autoclose: 1,
			todayHighlight: 0,
			startView: 2,
			minView: 2,
			forceParse: 0
	   }).on('changeDate', function(ev){
		   /* 时间被改变是的回调 */
	   });
		
		
		
		$('#upload_buton_img').uploadify({
			'swf' : 'http://upload.91ygxc.com/resources/swfupload.swf',
			'uploader' : 'http://upload.91ygxc.com/FileUpload',
			'height' : '30',
			'width' : '130',
			'fileTypeExts' : '*.jpg;*.JPG;*.jpeg;*.JPEG;*.png;*.PNG;*.gif;*.GIF',
			'fileObjName' : 'file_upload',
			'onUploadSuccess' : function(file, data, response) {
				var datajson = eval("(" + data + ")");
				$("#photo").attr('src', datajson.data.s);
				/* console.log(file);
				console.log(data);
				console.log(response); */
			}
		})
		
		$('#upload_buton_img2').uploadify({
			'swf' : 'http://upload.91ygxc.com/resources/swfupload.swf',
			'uploader' : 'http://upload.91ygxc.com/FileUpload',
			'height' : '30',
			'width' : '130',
			'fileTypeExts' : '*.jpg;*.JPG;*.jpeg;*.JPEG;*.png;*.PNG;*.gif;*.GIF',
			'fileObjName' : 'file_upload',
			'onUploadSuccess' : function(file, data, response) {
				var datajson = eval("(" + data + ")");
				$("#photo2").attr('src', datajson.data.s);
			}
		})
		
		
		function addModal(){
			/* 获取id */
			/* alert(sessionStorage.getItem('tabId')); */
			var tool = new toolCtrl();
			tool.clearForm();
			$('#addStudent').modal('show');
		};
		function editModal(){
			/* 获取id */
			var id = sessionStorage.getItem('tabId');
			if(id === null || id === undefined){
				alert('未选择目标');
			}else{
				$('#editStudent').modal('show');
			}	
		}
		function mgmt(){

			$('#ViewTrainees').modal('show');	
		}
		
		function getCheckbox(){	
			var arrId = [];
			$('table input[type="checkbox"]:checked').each(function(){     
				arrId.push($(this).val());//向数组中添加元素  
			 });
		}
		
		function record(){
			$('#record').modal('show');
		}
		
		function tanchu(){
			// 对话框
			/* layer.prompt({
				 title: '请输入值',
				 btn:['确定11','取消11'],
				 btn2:function(){
					 layer.alert(1111);
				 }
			},function(value, index, elem){
				layer.alert(value);	// 弹出框
				layer.close(index); //关闭对话框
			}); */
			
			//询问框
			layer.confirm('内容',{title:'对话框'},function(){
				alert(1);
				layer.close(index); //关闭对话框
			},function(){
				alert(2);
			});
		}
		
		function showSetbacks(){
			/* var val =  $('#setbacksSelect').val(); */
			var i = $('#setbacksSelect option:selected').index();
			var tabCon = $('#setbacks .tab-con');
			tabCon.eq(i).show();
			 $('#setbacksSelect').change(function(){
				var val = $(this).val();
				if(val === '报名未受理'){
					tabCon.hide().eq(0).show();
				}else if(val === '已受理未上课'){
					tabCon.hide().eq(1).show();
				}else if(val === '科目一学习中'){
					tabCon.hide().eq(2).show();
				}else if(val === '科目二学习中'){
					tabCon.hide().eq(3).show();
				}else if(val === '科目三学习中'){
					tabCon.hide().eq(4).show();
				}else if(val === '科目四学习中'){
					tabCon.hide().eq(5).show();
				}else if(val === '已结业'){
					tabCon.hide().eq(6).show();
				}
			 });
			$('#setbacks').modal('show');
		}
		function sub(){
			// 校验表单是否通过
			if( $("#addStudent .valid-form").Validform().check() == true ){
	            // ajax操作
	            if(res.code===200){
	            	sdjhasd
	            }else{
	            	layer.alert('错误代码'+res.code);
	            }
	            // 关闭弹框并清除表单
	            $("#addStudent").modal('hide');
	            var tool = new toolCtrl();
	            tool.clearForm();
	        }
		}
		
		function media(){
			$("#media").modal('show');
		}
		$(function(){
			var i = 0;
			var pag = 0;
			// 滚动加载
			$('#one').scroll(function(){
				var top = $(this).scrollTop();
				var height = $(this).get(0).scrollHeight;
				var viewHeight = $(this).height();
				if(height-viewHeight-top === 0){
					if(i === pag){
						$('.tab-loading').show();
						$.get('http://localhost:8080/bjxc-school/coach/list?insId=1&stationId=null&pageIndex=0&pageSize=10&t=0.14484360844095745&ajax=1&insId=1',function(res){
							if(res.code === 200){
								$('#one table tbody').append(pag+'<br>');
								pag++;
								i = pag;
								$('.tab-loading').hide();
							}else{
								layer.alert('错误代码：'+res.code);
							}
						},'json');
					}else{
						console.log(i,pag);
					}
					i++;
				} 
			})
		});
		
		// 清除选一行
		function clearRow(){
			var a1 = new toolCtrl();
			a1.clearRow();
		}
		

	</script>
</body>
</html>