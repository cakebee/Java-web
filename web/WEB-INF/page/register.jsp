<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/7/31
  Time: 10:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE HTML>
<html>
<head>
    <title>Register</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
    <link href="<%=request.getContextPath()%>/css/bootstrap-3.1.1.min.css" rel='stylesheet' type='text/css' />
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
    <!-- Custom Theme files -->
    <link href="<%=request.getContextPath()%>/css/style.css" rel='stylesheet' type='text/css' />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/jquery.countdown.css" />
    <link href='https://fonts.googleapis.com/css?family=PT+Sans+Narrow:400,700' rel='stylesheet' type='text/css'>
    <!----font-Awesome----->
    <link href="<%=request.getContextPath()%>/css/font-awesome.css" rel="stylesheet">
    <!----font-Awesome----->
    <script>
        $(document).ready(function(){
            $(".dropdown").hover(
                function() {
                    $('.dropdown-menu', this).stop( true, true ).slideDown("fast");
                    $(this).toggleClass('open');
                },
                function() {
                    $('.dropdown-menu', this).stop( true, true ).slideUp("fast");
                    $(this).toggleClass('open');
                }
            );
        });
    </script>
</head>
<body>
<jsp:include page="barhead.jsp" />
<!-- banner -->
<div class="courses_banner">
    <div class="container">
        <h3>注册</h3>
        <%--<p class="description">--%>
            <%--Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lorem quam, adipiscing condimentum tristique vel, eleifend sed turpis. Pellentesque cursus arcu id magna euismod in elementum purus molestie.--%>
        <%--</p>--%>
        <div class="breadcrumb1">
            <ul>
                <li class="icon6"><a href="/">首页</a></li>
                <li class="current-page">注册</li>
            </ul>
        </div>
    </div>
</div>
<!-- //judge -->
<script type="text/javascript">
    function validate() {
        var pwd1 = document.getElementById("password").value;
        var pwd2 = document.getElementById("password2").value;
        if(pwd1 == pwd2) {
            document.getElementById("passerror").innerHTML="<font color='green'>两次密码相同</font>";
            document.getElementById("submit").disabled = false;

        }else{
            document.getElementById("passerror").innerHTML="<font color='red'>两次密码不同</font>";
            document.getElementById("submit").disabled = true;
        }
    }
    function checkEmail(){
        var sletter = document.getElementById("Email").value;
        var isOk;
        if(sletter!=""){
            var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
            isOk=reg.test(sletter);
        }
        if (!isOk) {
            document.getElementById("emailError").innerHTML="<font color='red'>邮箱格式错误</font>";
            document.getElementById("submit").disabled = true;
        }
        else{
            document.getElementById("emailError").innerHTML="<font color='green'>邮箱格式正确</font>";
            document.getElementById("submit").disabled = false;
        }
    }
</script>
<script src="http://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
<script type="text/javascript">
    //收件人邮箱
    function sendCode(){
        var toEmailAddress=document.getElementById("Email").value;
        $.ajax({
            type:"post",
            url:"/sendEmailSystem",
            data:{
                toEmailAddress: toEmailAddress
            },
            dataType:"json",
            success:function(data){
                var json = JSON.parse(data);
                console.log(json)
                if(0 == json.code){
                    alert("邮件发送成功，清查看邮箱！验证码为：" + json.msg);
                } else {
                    alert(json.msg);
                }
            },
            error:function(){
                alert("数据传送失败！");
            }
        });
    }
</script>
<!-- //banner -->
<div class="courses_box1">
    <div class="container">
        <form:form method="POST" action="/registerResult" class="login">
            <p class="lead">注册新账号</p>
            <div class="form-group">
                <form:input path="username" type="text" autocomplete="off" class="required form-control" placeholder="用户名*"/>
            </div>
            <div class="form-group">
                <form:input id="password" path="password" type="password" class="required form-control" placeholder="密码*"/>
            </div>
            <div class="form-group">
                <form:input id="password2" path="password2" type="password" class="required form-control" placeholder="确认密码*" onkeyup="validate()"/>
            </div>
            <div class="form-group">
                <form:input path="email" type="text" id="Email" autocomplete="off" class="required form-control" placeholder="电子邮箱" onkeyup="checkEmail()"/>
                <span id="emailError"></span>
            </div>
            <div class="form-group">
                <form:select path="sex" type="text" autocomplete="off" class="required form-control">
                    <form:option value="man" label="性别"/>
                    <form:option value="man" label="男"/>
                    <form:option value="woman" label="女"/>
                </form:select>
            </div>
            <div class="form-group">
                <form:select path="type" type="text" autocomplete="off" class="required form-control">
                    <form:option value="student" label="用户类型"/>
                    <form:option value="student" label="学生"/>
                    <form:option value="teacher" label="老师"/>
                </form:select>&nbsp;<span id="passerror"></span>
            </div>
            <div class="form-group">
                <input id="authCode" name="idcode" required="required" autocomplete="off" class="required form-control" placeholder="请点击按钮发送验证码" type="text"/>
                <br/>
                <span><input type="button" value="发送验证码" id="sendidcode" onclick="sendCode()" /></span>
            </div>
            <div class="form-group">
                <button id="submit" type="submit" class="btn btn-primary btn-lg1 btn-block">注册</button>
                <strong>${result}</strong>
            </div>
            <p>已有账号？ <a href="login">登陆</a></p>
        </form:form>
    </div>
</div>
<jsp:include page="barfoot.jsp" />
</body>
</html>