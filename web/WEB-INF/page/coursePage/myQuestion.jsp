<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/8/8
  Time: 16:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>我的问题</title>
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
        <h3>我的问题</h3>
        <div class="breadcrumb1">
            <ul>
                <li class="icon6"><a href="allQuestions?courseId=${courseId}">问题列表</a></li>
                <li class="current-page">我的问题</li>
            </ul>
        </div>
    </div>
</div>
<!-- //banner -->
<div class="courses_box1">
    <div class="container">
        <jsp:include page="../barleft.jsp" />
        <div class="col-md-9 detail">
            <%--<img src="showcourseimage?courseid=${courseId}" class="img-responsive" width="500"/>--%>
            <h3>${course.coursename}</h3>
            <p>${course.intro}</p>
            <div class="comment_section">
                    <%--<h1>问答讨论</h1>--%>
                    <br/>
                    <c:if test="${!empty requestScope.pagemsg}">
                        <div style="margin:0 auto;text-align:center">
                            <table class="timetable">
                                <thead>
                                <tr>
                                    <th>课程</th>
                                    <th>标题</th>
                                    <th>发送者</th>
                                    <th>内容</th>
                                    <th>时间</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="question" items="${requestScope.pagemsg.lists}">
                                    <tr>
                                        <td>${course.coursename}</td>
                                        <td><a href="getQuestion?questionId=${question.id}">${question.title}</a></td>
                                        <td>${question.userid}</td>
                                        <td>${question.content}</td>
                                        <td><fmt:formatDate value="${question.questime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                        <td><a href="delQuestion?questionId=${question.id}" onclick="return confirm('确定要删除吗')">删除</a></td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                    <div style="margin:0 auto;text-align:center">
                        <table class="timetable">
                            <tr>
                                <td class="day_label">
                                    <span>第${requestScope.pagemsg.currPage }/ ${requestScope.pagemsg.totalPage}页</span>&nbsp;&nbsp;
                                    <span>总记录数：${requestScope.pagemsg.totalCount }&nbsp;&nbsp;每页显示:${requestScope.pagemsg.pageSize}</span>&nbsp;&nbsp;
                                    <span>
                            <c:if test="${requestScope.pagemsg.currPage != 1}">
                                <a href="${pageContext.request.contextPath }/myQuestion?courseId=${courseId}&currentPage=1">[首页]</a>&nbsp;&nbsp;
                                <a href="${pageContext.request.contextPath }/myQuestion?courseId=${courseId}&currentPage=${requestScope.pagemsg.currPage-1}">[上一页]</a>&nbsp;&nbsp;
                            </c:if>

                            <c:if test="${requestScope.pagemsg.currPage != requestScope.pagemsg.totalPage}">
                                <a href="${pageContext.request.contextPath }/myQuestion?courseId=${courseId}&currentPage=${requestScope.pagemsg.currPage+1}">[下一页]</a>&nbsp;&nbsp;
                                <a href="${pageContext.request.contextPath }/myQuestion?courseId=${courseId}&currentPage=${requestScope.pagemsg.totalPage}">[尾页]</a>&nbsp;&nbsp;
                            </c:if>
                            </span>
                                </td>
                            </tr>
                        </table>
                        <br/>
                        <c:if test="${not empty result}">
                            <form class="login">
                                <div class="form-group">
                                    <strong class="lead">${result}</strong>
                                </div>
                            </form>
                        </c:if>
                    </div>
                </div>
        </div>
        <div class="clearfix"> </div>
    </div>
</div>
<jsp:include page="../barfoot.jsp" />
</body>
</html>