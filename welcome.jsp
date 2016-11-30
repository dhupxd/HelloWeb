<!-- 
--2用户管理
--3裁判管理
--4参赛队伍管理
--5比赛管理
--6最近访客-->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>welcome to Dance Match</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="http://localhost:8080/HelloWeb/css/mystyle.css">
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-3.0.0.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-3.0.0.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
<script language="javascript" type="text/javascript">
function load() {
	var Aname='<%=request.getParameter("name")%>';
	$("#user").html("ID:"+Aname);
	$.ajax({
			type : "post",
			async : true,
			cache : false,
			dataType : 'text',
			url : "./servlet/getAllServlet",
			data : {
				name:Aname,
				option : $("#a2").html()
			},
			success : function(data) {
				var head = "";
				var i = 0;
				for (; i < data.length; i++) {
					if (data[i] == '&')
						break;
					head += data[i];
				}
				if("failure"==head)
					window.location.href="http://localhost:8080/HelloWeb/index.jsp";
				else{
					var mark=data[i+1];
					data=data.substring(i+2,data.length);
					$(".match_table").empty();
					$(".head3").empty();
					if(eval(data) == null)
						$(".head3").html("没有搜寻到结果");
					else{
						if(mark=='2'){
							$("#lable_way").hide();
							$(".match_table")
							.append(
									"<thead class='thead'><td>用户名</td><td>操作</td></thead><tbody class='tbody'>")
							var col=1;
							for ( var i = 0; i < eval(data).length; i++) {
								var tmp=JSON.stringify(eval(data)[i]);
								var myJson=jsonFormat(tmp);
								$(".match_table")
									.append("<tr><td><input id='edit"
											+(i*col+1)+"' type='text' disabled='true' value='"
											+eval(data)[i].a_name
											+"' style='background:transparent;border-width: 0'></input></td><td><a id='update"
											+(i+1)+"' href='javascript:void(0);width:200px;' onclick='javascript:updateOne("
											+myJson+",2,"+(i+1)+","+col+")' >修改&nbsp;</a><a href='javascript:void(0);' onclick='javascript:deleteOne("
											+myJson+",2)' >&nbsp;删除</a></td></tr>")
							}
							$(".match_table").append("</tbody>");
						}
						
					}
					
				}
			}
		});
}
</script>
<script language="javascript" type="text/javascript">
function jsonFormat(tmp){
	var myJson="";
	for(var j=0;j<tmp.length;j++){
		if(tmp[j]=='"'){
			myJson+='\"';
		}else{
			var _t=tmp.substring(j,j+1)
			myJson+=_t;
		}
	}
	return myJson;
}
function deleteOne(myJson,myFlag){
	var Aname='<%=request.getParameter("name")%>';
	var json=JSON.stringify(myJson);
	$.ajax({
		type : "post",
		async : true,
		cache : false,
		dataType : 'text',
		url : "./servlet/deleteAllServlet",
		data : {
			name:Aname,
			json:json,
			flag:myFlag
		},
		success:function(data){
			if("failureConfirm"==data)
				window.location.href="http://localhost:8080/HelloWeb/index.jsp";
			else if("failure"==data)
				alert("删除失败");
			document.getElementById("a"+myFlag).click();
		}
	});
}
function updateOne(myJson,myFlag,idx,cnt){
	var Aname='<%=request.getParameter("name")%>';
	var row=idx-1;
	if(document.getElementById("update"+idx).innerHTML=='确认&nbsp;'){
		document.getElementById("edit"+(row*cnt+1)).style.display="none";
		document.getElementById("a"+(row*cnt+1)).style.display="block";
		switch (myFlag){
		case 2:
			myJson.a_name=document.getElementById("edit"+(row*cnt+1)).value;
			break;
		case 3:
			myJson.r_name=document.getElementById("edit"+(row*cnt+1)).value;
			myJson.r_password=document.getElementById("edit"+(row*cnt+2)).value;
			break;
		case 4:
			myJson.t_name=document.getElementById("edit"+(row*cnt+1)).value;
			myJson.t_cnt=document.getElementById("edit"+(row*cnt+2)).value;
			myJson.t_leader=document.getElementById("edit"+(row*cnt+3)).value;
			myJson.t_phone=document.getElementById("edit"+(row*cnt+4)).value;
			break;
		case 5:
			myJson.d_name=document.getElementById("edit"+(row*cnt+1)).value;
			myJson.d_time=document.getElementById("edit"+(row*cnt+2)).value;
			myJson.d_place=document.getElementById("edit"+(row*cnt+3)).value;
			myJson.d_way=document.getElementById("edit"+(row*cnt+4)).value;
			myJson.referee_cnt=document.getElementById("edit"+(row*cnt+5)).value;
			myJson.isfinish=document.getElementById("edit"+(row*cnt+6)).value;
			myJson.image_name=document.getElementById("edit"+(row*cnt+7)).value;
			break;
		}
		var json=JSON.stringify(myJson);
		$.ajax({
			type : "post",
			async : true,
			cache : false,
			dataType : 'text',
			url : "./servlet/updateAllServlet",
			data : {
				name:Aname,
				json:json,
				flag:myFlag
			},
			success:function(data){
				if("failureConfirm"==data)
					window.location.href="http://localhost:8080/HelloWeb/index.jsp";
				else if("failure"==data)
					alert("修改失败");
				document.getElementById("a"+myFlag).click();
			}
		});
	}else{
		document.getElementById("update"+idx).innerHTML='确认&nbsp;';
		document.getElementById("edit"+(row*cnt+1)).style.display="block";
		document.getElementById("a"+(row*cnt+1)).style.display="none";
		if(myFlag==5){
			for(var i=1;i<=2;i++)
				document.getElementById("op"+(row*2+i)).innerHTML='--';
		}
		for(var i=1;i<=cnt;i++){
			document.getElementById("edit"+(row*cnt+i)).disabled=false;
			document.getElementById("edit"+(row*cnt+i)).style.border='1px solid';
		}
	}
}
function addOne(myFlag,cnt){
	var Aname='<%=request.getParameter("name")%>';
	var myJson=new Object();
	if(document.getElementById("add").innerHTML=='确认&nbsp;'){
		switch (myFlag){
		case 3:
			myJson.r_name=document.getElementById("add1").value;
			myJson.r_password=document.getElementById("add2").value;
			break;
		case 5:
			myJson.d_name=document.getElementById("add1").value;
			myJson.d_time=document.getElementById("add2").value;
			myJson.d_place=document.getElementById("add3").value;
			myJson.d_way=document.getElementById("add4").value;
			myJson.referee_cnt=document.getElementById("add5").value;
			myJson.isfinish=document.getElementById("add6").value;
			myJson.image_name=document.getElementById("add7").value;
			break;
		}
		var json=JSON.stringify(myJson);
		$.ajax({
			type : "post",
			async : true,
			cache : false,
			dataType : 'text',
			url : "./servlet/addAllServlet",
			data : {
				name:Aname,
				json:json,
				flag:myFlag
			},
			success:function(data){
				if("failureConfirm"==data)
					window.location.href="http://localhost:8080/HelloWeb/index.jsp";
				else if("failure"==data)
					alert("添加失败");
				document.getElementById("a"+myFlag).click();
			}
		});
	}else{
		document.getElementById("add").innerHTML='确认&nbsp;';
		for(var i=1;i<=cnt;i++){
			document.getElementById("add"+i).disabled=false;
			document.getElementById("add"+i).style.border='1px solid';
		}
	}
}
$(function() {
	$("#myTab .year")
			.click(
					function() {
						var Aname='<%=request.getParameter("name")%>';
						$
								.ajax({
									type : "post",
									async : true,
									cache : false,
									dataType : 'text',
									url : "./servlet/getAllServlet",
									data : {
										name:Aname,
										option : $(this).html()
									},
									success : function(data) {
										var head = "";
										var i = 0;
										for (; i < data.length; i++) {
											if (data[i] == '&')
												break;
											head += data[i];
										}
										if("failure"==head)
											window.location.href="http://localhost:8080/HelloWeb/index.jsp";
										else{
											var mark=data[i+1];
											data=data.substring(i+2,data.length);
											$(".match_table").empty();
											$(".head3").empty();
											if(eval(data) == null)
												$(".head3").html("没有搜寻到结果");
											else{
												if(mark=='2'){//用户
													$("#lable_way").hide();
													$(".match_table")
													.append(
															"<thead class='thead'><td>用户名</td><td>操作</td></thead><tbody class='tbody'>")
													var col=1;
													for ( var i = 0; i < eval(data).length; i++) {
														var tmp=JSON.stringify(eval(data)[i]);
														var myJson=jsonFormat(tmp);
														$(".match_table")
															.append("<tr><td><input id='edit"
																	+(i*col+1)+"' type='text' disabled='true' value='"
																	+eval(data)[i].a_name
																	+"' style='background:transparent;border-width: 0'></input></td><td><a id='update"
																	+(i+1)+"' href='javascript:void(0);width:200px;' onclick='javascript:updateOne("
																	+myJson+",2,"+(i+1)+","+col+")' >修改&nbsp;</a><a href='javascript:void(0);' onclick='javascript:deleteOne("
																	+myJson+",2)' >&nbsp;删除</a></td></tr>")
													}
													$(".match_table").append("</tbody>");
												}
												else if(mark=='3'){//裁判
													$("#lable_way").hide();
													$(".match_table")
													.append(
															"<thead class='thead'><td>裁判名</td><td>密码</td><td>操作</td></thead><tbody class='tbody'>")
													var col=2;
													for ( var i = 0; i < eval(data).length; i++) {
														var tmp=JSON.stringify(eval(data)[i]);
														var myJson=jsonFormat(tmp);
														$(".match_table")
															.append("<tr><td><input id='edit"
															+(i*col+1)+"' type='text' disabled='true' value='"
															+eval(data)[i].r_name
															+"' style='background:transparent;border-width: 0;width:200px'></input></td><td><input id='edit"
															+(i*col+2)+"' type='text' disabled='true' value='"
															+eval(data)[i].r_password
															+"' style='background:transparent;border-width: 0;width:200px'></input></td><td><a id='update"
															+(i+1)+"' href='javascript:void(0);' onclick='javascript:updateOne("
															+myJson+",3,"+(i+1)+","+col+")' >修改&nbsp;</a><a href='javascript:void(0);' onclick='javascript:deleteOne("
															+myJson+",3)' >&nbsp;删除</a></td></tr>")
													}
													$(".match_table")
													.append("<tr><td><input id='add1' type='text' disabled='true' style='background:transparent;border-width: 0;width:200px'></input></td>"
															+"<td><input id='add2' type='text'  disabled='true' style='background:transparent;border-width: 0;width:200px'></input></td>"
															+"<td style='width:200px'><a id='add' href='javascript:void(0);' onclick='javascript:addOne(3,"+col+")' >添加&nbsp;</a></td></tr>")
													
													$(".match_table").append("</tbody>");
												}
												else if(mark=='4'){//参赛队伍
													$("#lable_way").hide();
													$(".match_table")
													.append(
															"<thead class='thead'><td>参赛队伍名称</td><td>队伍人数</td><td>队长</td><td>联系方式</td><td>操作</td></thead><tbody class='tbody'>")
													var col=4;
													for ( var i = 0; i < eval(data).length; i++) {
														var tmp=JSON.stringify(eval(data)[i]);
														var myJson=jsonFormat(tmp);
														$(".match_table")
															.append("<tr><td><input id='edit"
																	+(i*col+1)+"' type='text' disabled='true' value='"
																	+eval(data)[i].t_name
																	+"' style='background:transparent;border-width: 0;width:200px'></input></td><td><input id='edit"
																	+(i*col+2)+"' type='text' disabled='true' value='"
																	+eval(data)[i].t_cnt
																	+"' style='background:transparent;border-width: 0;width:50px'></input></td><td><input id='edit"
																	+(i*col+3)+"' type='text' disabled='true' value='"
																	+eval(data)[i].t_leader
																	+"' style='background:transparent;border-width: 0;width:100px'></input></td><td><input id='edit"
																	+(i*col+4)+"' type='text' disabled='true' value='"
																	+eval(data)[i].t_phone
																	+"' style='background:transparent;border-width: 0;width:200px'></input></td><td><a id='update"
																	+(i+1)+"' href='javascript:void(0);' onclick='javascript:updateOne("
																	+myJson+",4,"+(i+1)+","+col+")' >修改&nbsp;</a><a href='javascript:void(0);' onclick='javascript:deleteOne("
																	+myJson+",4)' >&nbsp;删除</a></td></tr>")
													}
													$(".match_table").append("</tbody>");
												}
												else if(mark=='5'){//比赛管理
													$("#lable_way").show();
													$(".match_table")
													.append(
															"<thead class='thead'><td>比赛名称</td><td>比赛时间</td><td>比赛地点</td><td>比赛方式</td><td>裁判人数</td><td>比赛是否结束</td><td>背景图片名称</td><td>操作</td></thead><tbody class='tbody'>")
													var col=7;
													for ( var i = 0; i < eval(data).length; i++) {
														var tmp=JSON.stringify(eval(data)[i]);
														var myJson=jsonFormat(tmp);
														$(".match_table")
															.append("<tr><td><a id='a"
																	+(i*col+1)+"' href='http://localhost:8080/HelloWeb/start.jsp?id="
																	+ eval(data)[i].d_id
																	+ "&way="
																	+ eval(data)[i].d_way
																	+ "&name="
																	+ (eval(data)[i].d_name)
																	+ "&admin_name="
																	+ (Aname)
																	+ "' style='background:transparent;border-width: 0;width:220px'>"
																	+ eval(data)[i].d_name
																	+ "</a><input id='edit"
																	+(i*col+1)+"' type='text' disabled='true' value='"
																	+eval(data)[i].d_name
																	+"' style='display:none;background:transparent;border-width: 0;width:220px'></input></td><td><input id='edit"
																	+(i*col+2)+"' type='datetime-local' disabled='true' value='"
																	+eval(data)[i].d_time
																	+"' style='background:transparent;border-width: 0;width:230px'></input></td><td><input id='edit"
																	+(i*col+3)+"' type='text' disabled='true' value='"
																	+eval(data)[i].d_place
																	+"' style='background:transparent;border-width: 0;width:50px'></input></td><td><select id='edit"
																	+(i*col+4)+"' disabled='true' style='backgroud:transparent;border-width:0;width:50px'><option id='op"+(i*2+1)+"' value='"
																	+eval(data)[i].d_way+"'"
																	+" selected=''>"
																	+eval(data)[i].d_way+"</option><option value='1'>1</option><option value='2'>2</option></select></td><td><input id='edit"
																	+(i*col+5)+"' type='text' disabled='true' value='"
																	+eval(data)[i].referee_cnt
																	+"' style='background:transparent;border-width: 0;width:20px'></input></td><td><select id='edit"
																	+(i*col+6)+"' disabled='true' style='backgroud:transparent;border-width:0;width:50px'><option id='op"+(i*2+2)+"' value='"
																	+eval(data)[i].isfinish+"'"
																	+" selected=''>"
																	+eval(data)[i].isfinish+"</option><option value='0'>0</option><option value='1'>1</option></select></td><td><input id='edit"
																	+(i*col+7)+"' type='text' disabled='true' value='"
																	+eval(data)[i].image_name
																	+"' style='background:transparent;border-width: 0;width:150px'></input></td><td><a id='update"
																	+(i+1)+"' href='javascript:void(0);' onclick='javascript:updateOne("
																	+myJson+",5,"+(i+1)+","+col+")' >修改&nbsp;</a><a href='javascript:void(0);' onclick='javascript:deleteOne("
																	+myJson+",5)' >&nbsp;删除</a></td></tr>")
													}
													$(".match_table")
													.append("<tr><td><input id='add1' type='text' disabled='true' style='background:transparent;border-width: 0;width:220px'></input></td>"
															+"<td><input id='add2' type='text'  disabled='true' style='background:transparent;border-width: 0;width:230px'></input></td>"
															+"<td><input id='add3' type='text'  disabled='true' style='background:transparent;border-width: 0;width:50px'></input></td>"
															+"<td><input id='add4' type='text'  disabled='true' style='background:transparent;border-width: 0;width:20px'></input></td>"
															+"<td><input id='add5' type='text'  disabled='true' style='background:transparent;border-width: 0;width:20px'></input></td>"
															+"<td><input id='add6' type='text'  disabled='true' style='background:transparent;border-width: 0;width:20px'></input></td>"
															+"<td><input id='add7' type='text'  disabled='true' style='background:transparent;border-width: 0;width:150px'></input></td>"
															+"<td style='width:200px'><a id='add' href='javascript:void(0);' onclick='javascript:addOne(5,"+col+")' >添加&nbsp;</a></td></tr>")
													$(".match_table").append("</tbody>");
												}
												else if(mark=='6'){//最近访客
													$("#lable_way").hide();
													$(".match_table")
													.append(
															"<thead class='thead'><td>最近访客</td><td>来访时间</td><td>操作</td></thead><tbody class='tbody'>")
													for ( var i = 0; i < eval(data).length; i++) {
														var tmp=JSON.stringify(eval(data)[i]);
														var myJson=jsonFormat(tmp);
														$(".match_table")
															.append("<tr><td>"
															+ eval(data)[i].admin_name+"</td><td>"
															+eval(data)[i].mark+"</td><td><a href='javascript:void(0);' onclick='javascript:deleteOne("
															+myJson+",6)' >&nbsp;删除</a></tr>")
													}
													$(".match_table").append("</tbody>");
												}
												else{//比赛结果
													$("#lable_way").hide();
													$(".match_table")
													.append(
															"<thead class='thead'><td>比赛名称</td><td>比赛时间</td><td>比赛地点</td><td>比赛方式</td><td>裁判人数</td></thead><tbody class='tbody'>")
													for ( var i = 0; i < eval(data).length; i++) {
														$(".match_table")
														.append(
																"<tr><td><a href='http://localhost:8080/HelloWeb/result.jsp?id="
																		+ eval(data)[i].d_id
																		+ "&way="
																		+ eval(data)[i].d_way
																		+ "&name="
																		+ (eval(data)[i].d_name)
																		+ "&admin_name="
																		+ (Aname)
																		+ "'>"
																		+ eval(data)[i].d_name
																		+ "</a></td><td>"
																		+ eval(data)[i].d_time
																		+ "</td><td>"
																		+ eval(data)[i].d_place
																		+ "</td><td>"
																		+ eval(data)[i].d_way
																		+ "</td><td>"
																		+ eval(data)[i].referee_cnt
																		+"</td></tr>")
													}
													$(".match_table").append("</tbody>");
												}
											}
											
										}
									}
								});
					});
});
		function exit() {
			var name = $("#user").html()
			if (name != null) {
				name = name.substring(3, name.length)
				$
						.ajax({
							type : "post",
							async : true,
							cache : false,
							dataType : 'text',
							url : "./servlet/deleteCookieServlet",
							data : {
								name : name
							},
							success : function(data) {
								if("failure"==data){
									alert("异常退出");
								}
								window.location.href = "http://localhost:8080/HelloWeb/index.jsp";
							}
						});
			}
		}
  </script>

</head>

<body onload="load()">
	<div id="header">
		<!-- 选项卡组件（菜单项nav-pills）-->
		<ul id="myTab" role="tablist">
			<li class="active"><a href="#admin" role="tab"
				data-toggle="pill" id="a2" class="year" title="用户管理">用户管理</a>
			</li>
			<li><a href="#referee" role="tab" id="a3" class="year"
				title="裁判管理">裁判管理</a>
			</li>
			<li><a href="#team" role="tab" id="a4" class="year"
				title="参赛队伍管理">参赛队伍管理</a>
			</li>
			<li><a href="#match" role="tab" id="a5" class="year"
				title="比赛管理">比赛管理</a>
			</li>
			<li><a href="#visit" role="tab" id="a6" class="year"
				title="最近访客">最近访客</a>
			</li>
			<li><a href="#result" role="tab" id="a7" class="year"
				title="比赛结果">比赛结果</a></li>
			<li id="exit"><a onClick="exit()" title="退出">退出</a>
			</li>
			<li id="user"></li>
		</ul>
	</div>
	
	<hr />
	<lable id="lable_way" style="display:none;">比赛方式:1表示淘汰制-----2表示打分制;比赛是否结束:1表示结束-----0表示未结束</lable>
	<!-- 选项卡面板 -->
	<div id="myTabContent" class="tab-content">
		<div class="tab-pane fade in active" id="admin">
			<h3 class="head3"></h3>
			<table class="match_table">
			</table>
		</div>
		<div class="tab-pane fade" id="referee">
			<h3 class="head3"></h3>
			<table class="match_table">
			</table>
		</div>
		<div class="tab-pane fade" id="team">
			<h3 class="head3"></h3>
			<table class="match_table">
			</table>
		</div>
		<div class="tab-pane fade" id="match">
			<h3 class="head3"></h3>
			<table class="match_table">
			</table>
		</div>
		<div class="tab-pane fade" id="visit">
			<h3 class="head3"></h3>
			<table class="match_table">
			</table>
		</div>
		<div class="tab-pane fade" id="result">
			<h3 class="head3"></h3>
			<table class="match_table">
			</table>
		</div>
	</div>

</body>
</html>
<script type="text/javascript">
var error='<%=request.getParameter("error")%>';
	if(error=='no')
		alert("报名成功")
</script>
