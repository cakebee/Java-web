<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/8/7
  Time: 15:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>作业列表</title>
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
        <h3>作业列表</h3>
        <%--<p class="description">--%>
            <%--Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lorem quam, adipiscing condimentum tristique vel, eleifend sed turpis. Pellentesque cursus arcu id magna euismod in elementum purus molestie.--%>
        <%--</p>--%>
        <div class="breadcrumb1">
            <ul>
                <li class="icon6"><a href="courseIndex?courseID=${courseID}">课程主页</a></li>
                <li class="current-page">作业列表</li>
            </ul>
        </div>
    </div>
</div>
<!-- //banner -->
<div class="courses_box1">
    <div class="container">
        <jsp:include page="../barleft.jsp" />
        <div class="col-md-9 detail">
            <%--<img src="showcourseimage?courseid=${courseID}" class="img-responsive" width="500"/>--%>
            <h3>${course.coursename}</h3>
            <p>${course.intro}</p>
                <br>
            <c:if test="${type == 'teacher'}">
                <div class="comment_section">
                    <a href="newWork?courseID=${courseID}" class="radial_but">添加作业</a>
                </div>
            </c:if>
            <c:set var="currentChapter" value="-100">

            </c:set>
            <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                <c:forEach var="w" items="${workList}" varStatus="l">
                    <c:if test="${currentChapter != w.chapter}">
                        <c:set var="currentChapter" value="${w.chapter}">

                        </c:set>
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="heading${currentChapter}">
                                <h4 class="panel-title">
                                    <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse${currentChapter}" aria-expanded="false" aria-controls="collapse${currentChapter}">
                                        <i class="fa fa-pencil-square-o icon_3"></i>第${currentChapter}章
                                    </a>
                                </h4>
                            </div>
                            <div id="collapse${currentChapter}" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading${currentChapter}" aria-expanded="false" style="height: 0px;">
                                <div class="panel-body">
                                    <c:forEach var="work" items="${workList}" varStatus="loop">
                                        <c:if test="${work.chapter == currentChapter}">
                                            <table class="table_working_hours" style="table-layout:fixed">
                                                <tbody>
                                                <tr>
                                                    <td style="width: 50px">${work.chapter}-${work.part}</td>
                                                    <td style="width: 200px">${work.workname}</td>
                                                    <td><fmt:formatDate value="${work.publishdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                                    <c:if test="${type == 'student'}">
                                                        <c:if test="${score[loop.count-1] != -1}">
                                                            <td style="width: 70px" align="center">${score[loop.count-1]}分</td>
                                                        </c:if>
                                                        <c:if test="${score[loop.count-1] == -1}">
                                                            <td style="width: 70px" align="center">未评分</td>
                                                        </c:if>
                                                        <c:if test="${isSubmitList[loop.count-1]}">
                                                            <td style="width: 50px" align="center">已提交</td>
                                                            <td style="width: 70px" align="center"><a href="newStuWork?workID=${work.id}&courseID=${courseID}">重新提交</a></td>
                                                        </c:if>
                                                        <c:if test="${not isSubmitList[loop.count-1]}">
                                                            <td style="width: 50px" align="center">未提交</td>
                                                            <td style="width: 70px" align="center"><a href="newStuWork?workID=${work.id}&courseID=${courseID}">提交作业</a></td>
                                                        </c:if>
                                                    </c:if>
                                                    <c:if test="${type == 'teacher'}">
                                                        <td style="width: 100px" align="center"><a href="allStuWorks?workID=${work.id}&courseID=${courseID}">查看学生作业</a></td>
                                                        <td style="width: 70px" align="center"><a href="delWork?workID=${work.id}&courseID=${courseID}">删除作业</a></td>
                                                    </c:if>
                                                    <td style="width: 70px" align="center"><a href="downloadWork?workID=${work.id}">下载作业</a></td>
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
<jsp:include page="../barfoot.jsp" />
</body>
</html>
