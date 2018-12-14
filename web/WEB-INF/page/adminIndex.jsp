<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/7/31
  Time: 13:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>管理员首页</title>
    <jsp:include page="userParser/adminUserParser.jsp"/>
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
        <h3>管理中心</h3>
        <div class="breadcrumb1">
            <ul>
                <li class="icon6"><a href="/">首页</a></li>
                <li class="current-page">管理中心</li>
            </ul>
        </div>
    </div>
</div>
<!-- //banner -->
<div class="services">
    <div class="container" style="width: 600px">
        <h1>欢迎您：${username}</h1>
        <div class="service_box1" style="width: 650px">
            <div class="col-md-6">
                <div class="service_1">
                    <div class="service_1-left">
                        <span class="icon_5"><i class="fa fa-star"> </i></span>
                    </div>
                    <div class="service_1-right">
                        <h5><a href="showUserList">管理用户</a></h5>
                        <p>Click here to</p>
                        <p>Manage the user</p>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="service_1">
                    <div class="service_1-left">
                        <span class="icon_5"><i class="fa fa-star"> </i></span>
                    </div>
                    <div class="service_1-right">
                        <h5><a href="resourceList_Manage">审核资源</a></h5>
                        <p>Click here to</p>
                        <p>Verify the resource</p>
                    </div>
                </div>
            </div>
            <div class="clearfix"> </div>
        </div>
        <div class="service_box1" style="width: 650px">
            <div class="col-md-6">
                <div class="service_1">
                    <div class="service_1-left">
                        <span class="icon_5"><i class="fa fa-star"> </i></span>
                    </div>
                    <div class="service_1-right">
                        <h5><a href="showCourseList">审核课程</a></h5>
                        <p>Click here to</p>
                        <p>Verify the course</p>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="service_1">
                    <div class="service_1-left">
                        <span class="icon_5"><i class="fa fa-star"> </i></span>
                    </div>
                    <div class="service_1-right">
                        <h5><a href="showCourseResourcesList">审核课程资源</a></h5>
                        <p>Click here to</p>
                        <p>Verify the course resource</p>
                    </div>
                </div>
            </div>
            <div class="clearfix"> </div>
        </div>
        <div class="service_box1" style="width: 650px">
            <div class="col-md-6">
                <div class="service_1">
                    <div class="service_1-left">
                        <span class="icon_5"><i class="fa fa-star"> </i></span>
                    </div>
                    <div class="service_1-right">
                        <h5><a href="Announcements">发布公告</a></h5>
                        <p>Click here to</p>
                        <p>Release the announcement</p>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="service_1">
                    <div class="service_1-left">
                        <span class="icon_5"><i class="fa fa-star"> </i></span>
                    </div>
                    <div class="service_1-right">
                        <h5><a href="showNoticeList">查看公告</a></h5>
                        <p>Click here to</p>
                        <p>View the announcement</p>
                    </div>
                </div>
            </div>
            <div class="clearfix"> </div>
        </div>
    </div>
</div>
<jsp:include page="barfoot.jsp" />
</body>
</html>
