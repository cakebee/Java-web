<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/8/10
  Time: 9:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>批改作业</title>
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
        <h3>批改作业</h3>
        <%--<p class="description">--%>
            <%--Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lorem quam, adipiscing condimentum tristique vel, eleifend sed turpis. Pellentesque cursus arcu id magna euismod in elementum purus molestie.--%>
        <%--</p>--%>
        <div class="breadcrumb1">
            <ul>
                <li class="icon6"><a href="workList?courseID=${courseID}">作业列表</a></li>
                <li class="current-page">批改作业</li>
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
            <p>${course.intro}</p>
            <div class="comment_section">
                <table class="timetable">
                    <thead>
                    <tr>
                        <th>学生</th>
                        <th>分数</th>
                        <th>状态</th>
                        <th>作业</th>
                        <th colspan="2">评分</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="work" items="${requestScope.pagemsg.lists}">
                        <tr>
                            <td>${work.userid}</td>
                            <c:if test="${work.score == -1}">
                                <td>未评分</td>
                            </c:if>
                            <c:if test="${work.score != -1}">
                                <td>${work.score}</td>
                            </c:if>
                            <c:if test="${work.isreaded == 0}">
                                <td><font color="red">未读</font></td>
                            </c:if>
                            <c:if test="${work.isreaded == 1}">
                                <td><font color="green">已读</font></td>
                            </c:if>
                            <td><a href="downloadStuWork?workScoreID=${work.id}">下载作业</a></td>
                            <c:if test="${work.score == -1}">
                                <form:form action="setScore?workID=${work.workid}&workScoreID=${work.id}&courseID=${courseID}" method="post">
                                    <td>
                                        <input name="score" type="text" autocomplete="off">
                                    </td>
                                    <td>
                                        <input type="submit" class="shortcode_but small" value="打分">
                                    </td>
                                </form:form>
                            </c:if>

                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <div style="margin:0 auto;text-align:center">
                    <table class="timetable">
                        <tr>
                            <td class="day_label">
                                <span>第${requestScope.pagemsg.currPage }/ ${requestScope.pagemsg.totalPage}页</span>&nbsp;&nbsp;
                                <span>总记录数：${requestScope.pagemsg.totalCount }&nbsp;&nbsp;每页显示:${requestScope.pagemsg.pageSize}</span>&nbsp;&nbsp;
                                <span>
                            <c:if test="${requestScope.pagemsg.currPage != 1}">
                                <a href="${pageContext.request.contextPath }allStuWorks?workID=${workID}&currentPage=1">[首页]</a>&nbsp;&nbsp;
                                <a href="${pageContext.request.contextPath }allStuWorks?workID=${workID}&currentPage=${requestScope.pagemsg.currPage-1}">[上一页]</a>&nbsp;&nbsp;
                            </c:if>

                            <c:if test="${requestScope.pagemsg.currPage != requestScope.pagemsg.totalPage}">
                                <a href="${pageContext.request.contextPath }allStuWorks?workID=${workID}&currentPage=${requestScope.pagemsg.currPage+1}">[下一页]</a>&nbsp;&nbsp;
                                <a href="${pageContext.request.contextPath }allStuWorks?workID=${workID}&currentPage=${requestScope.pagemsg.totalPage}">[尾页]</a>&nbsp;&nbsp;
                            </c:if>
                            </span>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div class="clearfix"> </div>
    </div>
</div>
</div>
<jsp:include page="../barfoot.jsp" />
</body>
</html>