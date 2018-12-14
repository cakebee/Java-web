<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/8/3
  Time: 13:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE HTML>
<html>
<head>
    <title>发布公告</title>
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
        <h3>发布公告</h3>
        <%--<p class="description">--%>
            <%--Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lorem quam, adipiscing condimentum tristique vel, eleifend sed turpis. Pellentesque cursus arcu id magna euismod in elementum purus molestie.--%>
        <%--</p>--%>
        <div class="breadcrumb1">
            <ul>
                <li class="icon6"><a href="adminIndex">管理中心</a></li>
                <li class="current-page">发布公告</li>
            </ul>
        </div>
    </div>
</div>
<!-- //banner -->
<div class="services">
    <div class="container">
        <h1>欢迎您：${username}</h1>
        <!-- //banner -->
        <div class="courses_box1">
            <div class="container">
                <form method="POST" action="AnnouncementsResult" class="comment-form">
                    <h4>发布一则公告</h4>
                    <div class="col-md-6 comment-form-left">
                        <p>标题</p>
                        <br/>
                        <input type="text" name="title" autocomplete="off" class="form-control" placeholder="请输入标题" >
                    </div>
                    <div class="col-md-6 comment-form-right">
                        <textarea name="content" aria-required="true" class="form-control" placeholder="请输入内容"></textarea>
                    </div>
                    <div class="clearfix"> </div>
                    <div class="form-submit">
                        <input name="submit" type="submit" id="submit" class="submit_1 btn btn-primary btn-block" value="提交公告">
                    </div>
                </form>
                <form class="login">
                    <div class="form-group">
                        <strong class="lead">${result}</strong>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<jsp:include page="barfoot.jsp" />
</body>
</html>