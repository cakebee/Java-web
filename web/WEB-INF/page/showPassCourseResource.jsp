<%--
  Created by IntelliJ IDEA.
  User: Eason
  Date: 2018/8/3
  Time: 8:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>课程学习</title>
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
        <h3>课程目录</h3>
        <%--<p class="description">--%>
            <%--Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lorem quam, adipiscing condimentum tristique vel, eleifend sed turpis. Pellentesque cursus arcu id magna euismod in elementum purus molestie.--%>
        <%--</p>--%>
        <div class="breadcrumb1">
            <ul>
                <li class="icon6"><a href="courseIndex?courseID=${courseID}">课程主页</a></li>
                <li class="current-page">课程目录</li>
            </ul>
        </div>
    </div>
</div>
<!-- //banner -->
<div class="courses_box1">
    <div class="container">
        <jsp:include page="barleft.jsp" />
        <div class="col-md-9 detail">
            <%--<img src="showcourseimage?courseid=${courseID}" class="img-responsive" width="500"/>--%>
            <h3>${coursename}</h3>
            <p>${course.intro}</p>
            <c:set var="currentChapter" value="-100">

            </c:set>
            <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                <c:forEach var="c" items="${courseIndexList}" varStatus="l">
                    <c:if test="${currentChapter != c.chapter}">
                        <c:set var="currentChapter" value="${c.chapter}">

                        </c:set>
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="heading${currentChapter}">
                                <h4 class="panel-title">
                                    <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse${currentChapter}" aria-expanded="false" aria-controls="collapse${currentChapter}">
                                        <i class="fa fa-pencil-square-o icon_3"></i>第${currentChapter}章: ${c.chaprtTitle}
                                    </a>
                                </h4>
                            </div>
                            <div id="collapse${currentChapter}" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading${currentChapter}" aria-expanded="false" style="height: 0px;">
                                <div class="panel-body">
                                    <c:forEach var="courseIndex" items="${courseIndexList}" varStatus="loop">
                                        <c:if test="${courseIndex.chapter == currentChapter}">

                                            <table class="table_working_hours" style="table-layout:fixed">
                                                <tbody>
                                                <tr>
                                                    <td style="width: 50px">${courseIndex.chapter}-${courseIndex.part}</td>
                                                    <td style="width: 450px">${courseIndex.partTitle}</td>
                                                    <td align="center">
                                                        <c:if test="${courseIndex.video != -1}">
                                                            <a href="playVideo?crID=${courseIndex.video}&courseID=${courseIndex.courseid}">在线观看</a>
                                                        </c:if>
                                                    </td>
                                                    <td align="center">
                                                        <c:if test="${courseIndex.pdf != -1}">
                                                            <a href="downloadCourseResource?crID=${courseIndex.pdf}&courseID=${courseIndex.courseid}">下载PDF</a>
                                                        </c:if>
                                                    </td>
                                                    <td align="center">
                                                        <c:if test="${courseIndex.word != -1}">
                                                            <a href="downloadCourseResource?crID=${courseIndex.word}&courseID=${courseIndex.courseid}">下载Word</a>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                                </tbody>
                                            </table>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
            <!-- //banner -->
            <div class="clearfix"> </div>
        </div>
        <div class="clearfix"> </div>
    </div>
</div>
<jsp:include page="barfoot.jsp" />


</body>
</html>
