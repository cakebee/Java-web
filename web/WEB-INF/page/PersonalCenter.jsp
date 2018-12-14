<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/8/2
  Time: 8:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>个人中心</title>
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
        <h3>个人中心</h3>
        <div class="breadcrumb1">
            <ul>
                <li class="icon6"><a href="/">首页</a></li>
                <li class="current-page">个人中心</li>
            </ul>
        </div>
    </div>
</div>
<!-- //banner -->
<div class="services">
    <div class="container" style="width: 600px">
        <h1>欢迎您：${username}</h1>
        <div class="service_box1" style="width: 650px">
            <c:if test="${type=='teacher'}">
                <div class="col-md-6">
                    <div class="service_1">
                        <div class="service_1-left">
                            <span class="icon_5"><i class="fa fa-star"> </i></span>
                        </div>
                        <div class="service_1-right">
                            <h5><a href="releaseCourse">发布课程</a></h5>
                            <p>Click here to</p>
                            <p>Release the course</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="service_1">
                        <div class="service_1-left">
                            <span class="icon_5"><i class="fa fa-star"> </i></span>
                        </div>
                        <div class="service_1-right">
                            <h5><a href="showMyCourseList">查看课程</a></h5>
                            <p>Click here to</p>
                            <p>View the course</p>
                        </div>
                    </div>
                </div>
                <div class="clearfix"> </div>
            </c:if>
        </div>
        <div class="service_box1" style="width: 650px">
            <c:if test="${type=='student'}">
                <div class="col-md-6">
                    <div class="service_1">
                        <div class="service_1-left">
                            <span class="icon_5"><i class="fa fa-star"> </i></span>
                        </div>
                        <div class="service_1-right">
                            <h5><a href="showMyParticipateCourse">查看课程</a></h5>
                            <p>Click here to</p>
                            <p>View the course</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="service_1">
                        <div class="service_1-left">
                            <span class="icon_5"><i class="fa fa-star"> </i></span>
                        </div>
                        <div class="service_1-right">
                            <h5><a href="showMyAllCourseScore">我的成绩</a></h5>
                            <p>Click here to</p>
                            <p>View the grade</p>
                        </div>
                    </div>
                </div>
                <div class="clearfix"> </div>
            </c:if>
        </div>
        <div class="service_box1" style="width: 650px">
            <div class="col-md-6">
                <div class="service_1">
                    <div class="service_1-left">
                        <span class="icon_5"><i class="fa fa-star"> </i></span>
                    </div>
                    <div class="service_1-right">
                        <h5><a href="resourceList">资源中心</a></h5>
                        <p>Click here to</p>
                        <p>Resource Center</p>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="service_1">
                    <div class="service_1-left">
                        <span class="icon_5"><i class="fa fa-star"> </i></span>
                    </div>
                    <div class="service_1-right">
                        <h5><a href="message">消息中心</a></h5>
                        <p>Click here to</p>
                        <p>Message Center</p>
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
                        <h5><a href="myIntegral">我的积分</a></h5>
                        <p>Click here to</p>
                        <p>See the scores</p>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="service_1">
                    <div class="service_1-left">
                        <span class="icon_5"><i class="fa fa-star"> </i></span>
                    </div>
                    <div class="service_1-right">
                        <h5><a href="myInterest">我的兴趣</a></h5>
                        <p>Click here to</p>
                        <p>See the interest</p>
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
                        <h5><a href="showUser?username=${username}&editedUsername=${username}">编辑个人信息</a></h5>
                        <p>Click here to</p>
                        <p>Edit the personal information</p>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="service_1">
                    <div class="service_1-left">
                        <span class="icon_5"><i class="fa fa-star"> </i></span>
                    </div>
                    <div class="service_1-right">
                        <h5><a href="chpassword">修改密码</a></h5>
                        <p>Click here to</p>
                        <p>Change the password</p>
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