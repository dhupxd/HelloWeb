<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Regist</title>
<link rel="stylesheet"
	href="http://localhost:8080/HelloWeb/css/regist.css">
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-3.0.0.js"></script>
</head>
<body>
	<div id="header">
		<ul class="nav">
			<li onclick="addLogin()" ><a title="提交">提交</a></li>
		</ul>
	</div>
	<hr />
	<div  class="login_form">
		<form action="">
			<input type="text" id="admin_name" name="admin_name" placeholder="用户名" style="height:30px;font-size:20px;">
			<font color="#FF0000">用户名不超过16位，支持中文英文、数字、减号或下划线</font><br />
			<input type="password" id="password" name="password" placeholder="密码" style="height:30px;font-size:20px;">
			<font color="#FF0000">密码6到18位，且仅含字母、数字和下划线，并只能以字母开头</font><br />
			<input type="password" id="password_certain" placeholder="确认密码" style="height:30px;font-size:20px;"><br />
			<font id="show" color="#FF0000"></font>
		</form>
	</div>
	<script type="text/javascript">
		function addLogin(){
			var admin_name=$("#admin_name").val();
			var password=$("#password").val();
			var password2=$("#password_certain").val();
			if(admin_name=='')
				alert("用户名不能为空！","error");
			else if(password==''||password2=='')
				alert("密码不能为空！","error");
			else if(password!=password2)
				$("#show").html("两次输入密码不一致！请重新输入！");
			else{
				var form=document.forms[0];
				form.action="<%=request.getContextPath()%>/servlet/addEnrollServlet";
				form.method="post";
				form.submit();

			}
		}
	</script>
</body>
</html>
<script type="text/javascript">
var error='<%=request.getParameter("error")%>';
	if(error == 'exist')
		$("#show").html("注册失败,该用户名已被使用！");
	else if(error=='illegal')
		$("#show").html("输入不合法！请重新输入");
</script>