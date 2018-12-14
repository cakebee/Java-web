<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/8/2
  Time: 14:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE HTML>
<html>
<head>
    <title>修改密码</title>
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
        <h3>修改密码</h3>
        <%--<p class="description">--%>
            <%--Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lorem quam, adipiscing condimentum tristique vel, eleifend sed turpis. Pellentesque cursus arcu id magna euismod in elementum purus molestie.--%>
        <%--</p>--%>
        <div class="breadcrumb1">
            <ul>
                <li class="icon6"><a href="PersonalCenter">个人中心</a></li>
                <li class="current-page">修改密码</li>
            </ul>
        </div>
    </div>
</div>
<!-- //judge -->
<script type="text/javascript">
    function validate() {
        var pwd1 = document.getElementById("password").value;
        var pwd2 = document.getElementById("passwordch").value;
        if(pwd1 == pwd2) {
            document.getElementById("passerror").innerHTML="<font color='green'>两次密码相同</font>";
            document.getElementById("submit").disabled = false;

        }else{

            document.getElementById("passerror").innerHTML="<font color='red'>两次密码不相同</font>";
            document.getElementById("submit").disabled = true;
        }
    }
</script>
<!-- //banner -->
<div class="services">
    <div class="container">
        <h1>欢迎您：${username}</h1>
        <!-- //banner -->
        <div class="courses_box1">
            <div class="container">
                <form class="login">
                    <div class="form-group">
                        <strong class="lead">${result}</strong>
                    </div>
                </form>
                <form:form method="POST" action="/chPassResult" class="login">
                    <div class="form-group">
                        <form:label path="password2">原密码</form:label>
                        <form:input id="password2" path="password2" type="password" autocomplete="off" class="required form-control" placeholder="输入原密码" />
                    </div>
                    <div class="form-group">
                        <form:label path="password2">新密码</form:label>
                        <form:input id="password" path="password" type="password" autocomplete="off" class="required form-control" placeholder="输入新密码" />
                    </div>
                    <div class="form-group">
                        <form:label path="password2">确认新密码</form:label>
                        <form:input id="passwordch" path="passwordch" type="password" autocomplete="off" class="required form-control" placeholder="输入新密码" onkeyup="validate()"/>&nbsp;<span id="passerror"></span>
                    </div>
                    <div class="form-group">
                        <button id="submit" type="submit" class="btn btn-primary btn-lg1 btn-block">提交</button>
                    </div>
                </form:form>
                <form method="get" action="PersonalCenter" class="login">
                    <div class="form-group">
                        <input type="submit" class="btn btn-primary btn-lg1 btn-block" name="submit" value="返回个人中心">
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<jsp:include page="barfoot.jsp" />
</body>
</html>