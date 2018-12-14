<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/8/8
  Time: 19:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>发布课程公告</title>
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
<jsp:include page="../barhead.jsp" />
<!-- banner -->
<div class="courses_banner">
    <div class="container">
        <h3>发布课程公告</h3>
        <div class="breadcrumb1">
            <ul>
                <li class="icon6"><a href="allNotices?courseID=${courseID}">课程公告列表</a></li>
                <li class="current-page">发布课程公告</li>
            </ul>
        </div>
    </div>
</div>
<!-- //banner -->
<div class="courses_box1">
    <div class="container">
        <jsp:include page="../barleft.jsp" />
        <div class="col-md-9 detail">
            <img src="showcourseimage?courseid=${courseID}" class="img-responsive" width="500"/>
            <h3>${course.coursename}</h3>
            <p>${course.intro}</p>
            <div class="features">
                <div class="comment_section">
                    <div class="courses_box1-left">
                        <form:form action="addNotice?courseID=${courseID}" method="post">
                            <div class="input-group input-group1">
                                <form:label path="title">标题</form:label>
                                <form:input path="title" type="text" name="title" autocomplete="off" class="form-control has-dark-background" placeholder="请输入标题"/>
                            </div>
                            <div class="input-group input-group1">
                                <form:label path="content">内容</form:label>
                                <form:textarea path="content" name="content" rows="5" aria-required="true" class="form-control has-dark-background" placeholder="请输入内容"/>
                            </div>
                            <div class="clearfix"> </div>
                            <input name="submit" type="submit" class="course-submit" value="发送">
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
        <div class="clearfix"> </div>
    </div>
</div>
<jsp:include page="../barfoot.jsp" />
</body>
</html>