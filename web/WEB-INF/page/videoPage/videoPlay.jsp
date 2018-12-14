<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/8/7
  Time: 19:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>在线播放</title>
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
    <!----Calender -------->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/clndr.css" type="text/css" />
    <script src="<%=request.getContextPath()%>/js/underscore-min.js" type="text/javascript"></script>
    <script src= "<%=request.getContextPath()%>/js/moment-2.2.1.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/js/clndr.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/js/site.js" type="text/javascript"></script>
    <!----End Calender -------->
</head>
<body>
<jsp:include page="../barhead.jsp" />
<!-- banner -->
<div class="courses_banner">
    <div class="container">
        <h3>在线播放</h3>
        <%--<p class="description">--%>
            <%--Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lorem quam, adipiscing condimentum tristique vel, eleifend sed turpis. Pellentesque cursus arcu id magna euismod in elementum purus molestie.--%>
        <%--</p>--%>
        <div class="breadcrumb1">
            <ul>
                <li class="icon6"><a href="showPassCourseResourceList?courseID=${courseID}">课程学习</a></li>
                <li class="current-page">在线播放</li>
            </ul>
        </div>
    </div>
</div>
<!-- //banner -->
<div class="courses_box1">
    <div class="container">
        <jsp:include page="../barleft.jsp" />
        <div class="col-md-9 detail">
            <h3>${course.coursename}</h3>
            <h3>${courseIndex.chapter}-${courseIndex.part}: ${courseIndex.partTitle}</h3>
            <div class="service_box1">
                <div class="course_list">
                    <video id="player" width="100%" controls="controls">
                        <source  src="video?crID=${crID}&courseID=${courseID}" type="video/mp4" >
                    </video>
                </div>
                <!-- //banner -->
                <div class="clearfix"> </div>
            </div>
        </div>
        <div class="clearfix"> </div>
    </div>
</div>
<jsp:include page="../barfoot.jsp" />
<!-- FlexSlider -->
<link href="<%=request.getContextPath()%>/css/flexslider.css" rel='stylesheet' type='text/css' />
<script defer src="<%=request.getContextPath()%>/js/jquery.flexslider.js"></script>
<script type="text/javascript">
    $(function(){
        SyntaxHighlighter.all();
    });
    $(window).load(function(){
        $('.flexslider').flexslider({
            animation: "slide",
            start: function(slider){
                $('body').removeClass('loading');
            }
        });
    });
</script>
<!-- FlexSlider -->
</body>
</html>