<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/8/7
  Time: 17:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>${course.teacher}老师的${course.coursename}课程</title>
    <jsp:include page="userParser/userParser.jsp"/>
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
        <h3>${course.teacher}老师的${course.coursename}课程</h3>
        <%--<p class="description">--%>
            <%--Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lorem quam, adipiscing condimentum tristique vel, eleifend sed turpis. Pellentesque cursus arcu id magna euismod in elementum purus molestie.--%>
        <%--</p>--%>
        <div class="breadcrumb1">
            <ul>
                <li class="icon6"><a href="course">课程</a></li>
                <li class="current-page">${course.teacher}老师的${course.coursename}课程</li>
            </ul>
        </div>
    </div>
</div>
<!-- //banner -->
<div class="courses_box1">
    <div class="container">
        <jsp:include page="barleft.jsp" />
        <div class="col-md-9 detail">
            <img src="showcourseimage?courseid=${course.id}" class="img-responsive" width="500"/>
            <h3>${course.coursename}</h3>
            <p>${course.intro}</p>
            <div class="advantage">
                <c:if test="${course.teacher==username||state=='in'}">
                    <div class="col-md-4 box_1">
                        <div class="list styled custom-list custom-list1">
                            <ul>
                                <li><span class="dropcap">☆</span>
                                    <div class="item_content">
                                        <h5><a href="showPassCourseResourceList?courseID=${course.id}">课程学习</a></h5>
                                        <p> Click here to</p>
                                        <p> Study the course</p>
                                    </div>
                                </li>
                            </ul>
                            <br/>
                            <ul>
                                <li><span class="dropcap">☆</span>
                                    <div class="item_content">
                                        <h5><a href="allQuestions?courseId=${course.id}">讨论区</a></h5>
                                        <p> Click here to</p>
                                        <p> Join the discussion</p>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-md-4 box_1">
                        <div class="list styled custom-list custom-list1">
                            <ul>
                                <li><span class="dropcap">☆</span>
                                    <div class="item_content">
                                        <h5><a href="workList?courseID=${course.id}">作业</a></h5>
                                        <p> Click here to</p>
                                        <p> Practice the homework</p>
                                    </div>
                                </li>
                            </ul>
                            <br/>
                            <ul>
                                <li><span class="dropcap">☆</span>
                                    <div class="item_content">
                                        <h5><a href="showStuScoreRank?courseID=${course.id}">成绩排行</a></h5>
                                        <p> Click here to</p>
                                        <p> View the grade ranking</p>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-md-4 box_1">
                        <div class="list styled custom-list custom-list1">
                            <ul>
                                <li><span class="dropcap">☆</span>
                                    <div class="item_content">
                                        <h5><a href="Test?courseId=${course.id}&&type=${type}&&username=${username}">测试</a></h5>
                                        <p> Click here to</p>
                                        <p> Join the test</p>
                                    </div>
                                </li>
                            </ul>
                            <br/>
                            <ul>
                                <li><span class="dropcap">☆</span>
                                    <div class="item_content">
                                        <h5><a href="CourseEvaluate?courseID=${course.id}">课程评价</a></h5>
                                        <p> Click here to</p>
                                        <p> View the course evaluation</p>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </c:if>
                <c:if test="${course.teacher!=username&&state=='out'}">
                    <div class="col-md-4 box_1">
                        <div class="list styled custom-list custom-list1">
                            <ul>
                                <li><span class="dropcap">☆</span>
                                    <div class="item_content">
                                        <h5><a href="participateLearning?courseID=${course.id}&username=${username}">参与学习</a></h5>
                                        <p> anteposuerit litterarum formas humanitatis per</p>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </c:if>
                <div class="clearfix"> </div>
            </div>
        </div>
        <div class="clearfix"> </div>
    </div>
</div>
<jsp:include page="barfoot.jsp" />
</body>
</html>