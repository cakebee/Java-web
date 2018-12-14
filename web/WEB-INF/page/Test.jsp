<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/8/11
  Time: 21:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>在线测试</title>
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
        <h3>在线测试</h3>
        <div class="breadcrumb1">
            <ul>
                <li class="icon6"><a href="courseIndex?courseID=${courseid}">课程主页</a></li>
                <li class="current-page">在线测试</li>
            </ul>
        </div>
    </div>
</div>
<!-- //banner -->
<div class="courses_box1">
    <div class="container">
        <jsp:include page="barleft.jsp" />
        <div class="col-md-9 detail">
            <h3>${course.coursename}</h3>
            <h2>期末测试</h2>
            <br/>
            <div class="comment_section">
                <div class="service_box1">
                    <c:if test="${requestScope.flag == 1}">
                        您已答过题目，分数是${result}分
                    </c:if>
                    <c:if test="${requestScope.flag == 0}">
                        <c:if test="${empty requestScope.pagemsg}">
                            <div class="container">
                                <form class="login">
                                    <div class="form-group">
                                        <strong class="lead">没有题目</strong>
                                    </div>
                                </form>
                            </div>
                        </c:if>

                        <c:if test="${requestScope.pagemsg.lists.size()!='0'}">
                            <div class="course_list">
                                <c:forEach items="${requestScope.pagemsg.lists}" var="r">
                                    <div class="event-info-middle">
                                        <p><span class="event-bold">题目: ${r.testName }</span></p>
                                        <p><span class="event-bold">A&nbsp;&nbsp;.&nbsp;&nbsp;${r.questiona }</span></p>
                                        <p><span class="event-bold">B&nbsp;&nbsp;.&nbsp;&nbsp;${r.questionb }</span></p>
                                        <p><span class="event-bold">C&nbsp;&nbsp;.&nbsp;&nbsp;${r.questionc }</span></p>
                                    </div>
                                    <form method="POST" action="catch?courseid=${courseid}&&testname=${r.testName}&&currentPage=${requestScope.pagemsg.currPage}&&studentname=${username}">
                                        <div class="col-md-4 form_box">
                                            <div class="select-block1">
                                                <label>你的答案</label>
                                                <select name="answer" autocomplete="off" class="required form-control">
                                                    <option value="A">你的答案</option>
                                                    <option value="A">A</option>
                                                    <option value="B">B</option>
                                                    <option value="C">C</option>
                                                </select>
                                            </div>
                                            <input type="submit" class="course-submit" value="提交">
                                            <div class="clearfix"> </div>
                                        </div>
                                    </form>
                                </c:forEach>
                                <div class="clearfix"> </div>
                            </div>
                            <br/>
                            <ul class="pagination event_pagination">
                                <li class="active"><a href="#">第${requestScope.pagemsg.currPage }/ ${requestScope.pagemsg.totalPage}题</a></li>
                                <li class="active"><a href="#">总题数：${requestScope.pagemsg.totalCount }</a></li>
                            </ul>
                        </c:if>
                    </c:if>
                    <!-- //banner -->
                    <div class="clearfix"> </div>
                </div>
            </div>
        </div>
        <div class="clearfix"> </div>
    </div>
</div>
<jsp:include page="barfoot.jsp" />
</body>
</html>