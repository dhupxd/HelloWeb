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
<base href="<%=basePath%>">

<title>Login</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet"
	href="http://localhost:8080/HelloWeb/css/mystyle.css">
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-3.0.0.js"></script>

</head>

<body>
	<div id="header">
		<ul class="nav">
			<li onclick="getAdmin()" ><a title="登录">登录</a></li>
			<li onclick="addAdmin()" ><a title="注册">注册</a></li>
		</ul>
	</div>
	<hr/>
	<div  class="login_form">
		<form action="">
			姓名：<input type="text" id="admin_name" name="admin_name"><br />
			密码：<input type="password" id="password" name="password"><br />
			<font id="show" color="#FF0000"></font>
		</form>
	</div>
	<script type="text/javascript">
		function addAdmin(){
			window.location.href="http://localhost:8080/HelloWeb/regist.jsp";
		}
		function getAdmin(){
			<%
			Date date=new Date();
			Cookie c1=new Cookie("mark",date.toLocaleString());
			c1.setMaxAge(-1);
			response.addCookie(c1);
			%>
			var form=document.forms[0];
			form.action="<%=request.getContextPath()%>/servlet/getAdminServlet";
			form.method = "post";
			form.submit();
		}
	</script>

</body>
</html>
<script type="text/javascript">
var error='<%=request.getParameter("error")%>';
	if (error == 'yes')
		$("#show").html("登陆失败,该用户不存在或者密码输入错误!");
	else if(error=='no')
		$("#show").html("注册成功！请登录！");
</script>
