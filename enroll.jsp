<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Enroll</title>
<link rel="stylesheet"
	href="http://localhost:8080/HelloWeb/css/enroll.css">
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-3.0.0.js"></script>
<script language="javascript" type="text/javascript">
function load() {
	var d_name='<%=request.getParameter("d_name")%>';
	var d_id='<%=request.getParameter("d_id")%>';
	var a_name='<%=request.getParameter("name")%>';
	$("#title").html(d_name);
	$("#d_name").val(d_name);
	$("#name").val(a_name);
	$("#d_id").val(d_id);
}
</script>
</head>
<body onload="load()">
	<div id="header">
		<ul class="nav">
			<li id="title"></li>
		</ul>
	</div>
	<hr />
	<div  class="enroll_form">
		<form action="">
			<input type="text" id="t_name" name="t_name" placeholder="队名" style="height:30px;font-size:20px;">
			<font color="#FF0000">队名不超过16位，支持中文英文、数字、减号或下划线</font><br />
			<input type="text" id="t_cnt" name="t_cnt" placeholder="队伍人数" style="height:30px;font-size:20px;">
			<font color="#FF0000">请输入数字</font><br />
			<input type="text" id="t_leader"  name="t_leader" placeholder="队长姓名" style="height:30px;font-size:20px;">
			<font color="#FF0000">队长名不超过16位，请输入真实姓名</font><br/>
			<input type="tel" id="t_phone" name="t_phone" placeholder="联系电话" style="height:30px;font-size:20px;">
			<font color="#FF0000">请输入电话号码</font><br/>
			<br />
			<font id="show" color="#FF0000"></font><br/>
			<input type="button" onclick="addEnroll()" style="background-color: #222;color:#fff;width:100px;height:40px" value="报名" >
			<br/>
			<input type="text" id="name" name="name" readonly="readonly" class="disappear">
			<input type="text" id="d_id" name="d_id" readonly="readonly" class="disappear">
			<input type="text" id="d_name" name="d_name" readonly="readonly" class="disappear">
		</form>
	</div>
	<script type="text/javascript">
		function addEnroll(){
			var t_name=$("#t_name").val();
			var t_cnt=$("#t_cnt").val();
			var t_leader=$("#t_leader").val();
			var t_phone=$("#t_phone").val();
			if(t_name=='')
				alert("队名不能为空！","error");
			else if(t_cnt=='')
				alert("队伍人数不能为空！","error");
			else if(t_leader=='')
				alert("队长姓名不能为空！","error");
			else if(t_phone=='')
				alert("联系电话不能为空！","error");
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
		$("#show").html("报名失败,该队名已被使用！");
	else if(error=='yes')
		$("#show").html("报名失败,请重新报名");
	else if(error=='illegal_tname')
		$("#show").html("队名输入不合法！请重新输入");
	else if(error=='illegal_phone')
		$("#show").html("电话输入不合法！请重新输入");
	else if(error=='illegal_tcnt')
		$("#show").html("请在队伍人数处输入数字");
	else if(error=='illegal_lname')
		$("#show").html("队长姓名输入不合法！请重新输入");
</script>