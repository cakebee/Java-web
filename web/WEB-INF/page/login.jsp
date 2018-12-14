<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/7/31
  Time: 9:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE HTML>
<html>
<head>
    <title>登录</title>
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
    <script type="text/javascript">
        function reloadCode(){
            var time = new Date().getTime();
            document.getElementById("codeImage").src="VerificationCode/generate.action?d="+time;
        }

    </script>
</head>
<body>
<jsp:include page="barhead.jsp" />
<!-- banner -->
<div class="courses_banner">
    <div class="container">
        <h3>登陆</h3>
        <%--<p class="description">--%>
            <%--Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lorem quam, adipiscing condimentum tristique vel, eleifend sed turpis. Pellentesque cursus arcu id magna euismod in elementum purus molestie.--%>
        <%--</p>--%>
        <div class="breadcrumb1">
            <ul>
                <li class="icon6"><a href="/">首页</a></li>
                <li class="current-page">登陆</li>
            </ul>
        </div>
    </div>
</div>
<!-- //banner -->
<div class="courses_box1">
    <div class="container">
        <form:form method="POST" action="/loginResult" class="login">
            <p class="lead">欢迎回来!</p>
            <div class="form-group">
                <form:input path="username" type="text" autocomplete="off" class="required form-control" placeholder="用户名"/>
            </div>
            <div class="form-group">
                <form:input path="password" type="password" autocomplete="off" class="password required form-control" placeholder="密码"/>
            </div>
            <div class="form-group">
                <input id="authCode" name="checkCode" autocomplete="off" type="text" class="required form-control" placeholder="验证码"/>
                <br/>
                <img class="ii" type="image" src="VerificationCode/generate.action" id="codeImage"  onclick="reloadCode()" style="cursor:pointer;"/>
                <p><a href="javascript:reloadCode()">看不清楚</a></p>
            </div>
            <div class="form-group">
                <input type="submit" class="btn btn-primary btn-lg1 btn-block" name="submit" value="登陆">
                <strong>${result}</strong>
            </div>
            <p>还没有账号？ <a href="register">注册</a></p>
            <p>忘记密码？ <a href="findPass">找回密码</a></p>
        </form:form>
    </div>
</div>
<jsp:include page="barfoot.jsp" />
</body>
</html>