<!-- 
--1首页
--2比赛结果-->
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
					option : $("#a1").html()
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
							if(mark=='1'){//首页
								var j=0;
								for (;; j+=2) {
									if((j+1)>=eval(data).length)
										break;
									$(".match_table")
										.append("<tr><td><ul><li><image src='img/"
												+eval(data)[j].image_name+"' height='300px' width='500px'></image></li><li>"
												+"<a href='http://localhost:8080/HelloWeb/enroll.jsp?name="+Aname+"&d_id="
												+eval(data)[j].d_id+"&d_name="
												+eval(data)[j].d_name+"'>"
												+eval(data)[j].d_name+"</a></li></ul></td>"
												+"<td><ul><li><image src='img/"
												+eval(data)[j+1].image_name+"' height='300px' width='500px'></image></li><li>"
												+"<a href='http://localhost:8080/HelloWeb/enroll.jsp?name="+Aname+"&d_id="
												+eval(data)[j+1].d_id+"&d_name="
												+eval(data)[j+1].d_name+"'>"
												+eval(data)[j+1].d_name+"</a></li></ul></td></tr>")
								}
								if(j<eval(data).length){
									$(".match_table")
									.append("<tr><td><ul><li><image src='img/"
											+eval(data)[j].image_name+"' height='300px' width='500px'></image></li><li>"
											+"<a href='http://localhost:8080/HelloWeb/enroll.jsp?name="+Aname+"&d_id="
											+eval(data)[j].d_id+"&d_name="
											+eval(data)[j].d_name+"'>"
											+eval(data)[j].d_name+"</a></li></ul></td></tr>")
								}
							}
							
						}
						
					}
				}
			});
}
</script>
<script language="javascript" type="text/javascript">
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
												if(mark=='1'){//首页
													var j=0;
													for (;; j+=2) {
														if((j+1)>=eval(data).length)
															break;
														$(".match_table")
															.append("<tr><td><ul><li><image src='img/"
																	+eval(data)[j].image_name+"' height='300px' width='500px'></image></li><li>"
																	+"<a href='http://localhost:8080/HelloWeb/enroll.jsp?name="+Aname+"&d_id="
																	+eval(data)[j].d_id+"&d_name="
																	+eval(data)[j].d_name+"'>"
																	+eval(data)[j].d_name+"</a></li></ul></td>"
																	+"<td><ul><li><image src='img/"
																	+eval(data)[j+1].image_name+"' height='300px' width='500px'></image></li><li>"
																	+"<a href='http://localhost:8080/HelloWeb/enroll.jsp?name="+Aname+"&d_id="
																	+eval(data)[j+1].d_id+"&d_name="
																	+eval(data)[j+1].d_name+"'>"
																	+eval(data)[j+1].d_name+"</a></li></ul></td></tr>")
													}
													if(j<eval(data).length){
														$(".match_table")
														.append("<tr><td><ul><li><image src='img/"
																+eval(data)[j].image_name+"' height='300px' width='500px'></image></li><li>"
																+"<a href='http://localhost:8080/HelloWeb/enroll.jsp?name="+Aname+"&d_id="
																+eval(data)[j].d_id+"&d_name="
																+eval(data)[j].d_name+"'>"
																+eval(data)[j].d_name+"</a></li></ul></td></tr>")
													}
												}
												else{//比赛结果
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
			<li class="active"><a href="#index" role="tab"
				data-toggle="pill" id="a1" class="year" title="首页">首页</a></li>
			<li><a href="#result" role="tab" id="a7" class="year"
				title="比赛结果">比赛结果</a></li>
			<li id="exit"><a onClick="exit()" title="退出">退出</a></li>
			<li id="user"></li>
		</ul>
	</div>

	<hr />
	<!-- 选项卡面板 -->
	<div id="myTabContent" class="tab-content">
		<div class="tab-pane fade in active" id="index">
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
