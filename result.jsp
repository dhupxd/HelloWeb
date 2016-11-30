<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>Result</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="http://localhost:8080/HelloWeb/css/mystyle.css">
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-3.0.0.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-3.0.0.min.js"></script>
<script language="javascript" type="text/javascript">
	function result() {
		var aname=('<%=request.getParameter("admin_name")%>');
		$("#user").html("ID:"+aname)
		var id='<%=request.getParameter("id")%>';
		var way='<%=request.getParameter("way")%>';
		var name=('<%=request.getParameter("name")%>');
		$("#match_name").html(name);
		$.ajax({
			type : "post",
			async : true,
			cache : false,
			dataType : 'text',
			url : "./servlet/getResultServlet",
			data : {id:id,way:way,name:aname},
			success : function(data) {
				var head=""
				var i=0
				for(;i<data.length;i++){
					if(data[i]=='&')
						break;
					head+=data[i];
				}
				if("failure"==head){
					window.location.href="http://localhost:8080/HelloWeb/index.jsp";
				}else{
					data=data.substring(i+1,data.length)
					$("#result_table").empty()
					$("#result_table").append("<thead class=\"thead\"><td>排名</td><td>参赛团队</td><td>得分</td></thead><tbody class=\"tbody\">");
					for ( var i = 0,j = 0; i < eval(data).length; i++) {
						if(eval(data)[i].t_score==0)
							continue;
						j++;
						$("#result_table").append("<tr><td>"+ j +"</td><td>"+eval(data)[i].t_name+ "</td><td>"+eval(data)[i].t_score+"</td></tr>")
					}
					$("#result_tabele").append("</tbody>")
				}
				
			}
		});
	}
	function exit() {
		var name=$("#user").html()
		name=name.substring(3,name.length)
		$.ajax({
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
						window.location.href="http://localhost:8080/HelloWeb/index.jsp";
					}
				});
	}
</script>
</head>

<body onload="result()">
	<div id="header">
		<ul id="myTab">
			<li id="match_name"></li>
			<li id="exit"><a onClick="exit()" title="退出">退出</a></li>
			<li id="user">ID:wa</li>
			
		</ul>
	</div>
	<hr/>
	<table id="result_table" class="match_table">
	</table>
</body>
</html>

