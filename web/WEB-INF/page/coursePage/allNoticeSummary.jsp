<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/8/8
  Time: 17:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>课程公告</title>
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
        <h3>课程公告</h3>
        <div class="breadcrumb1">
            <ul>
                <li class="icon6"><a href="courseIndex?courseID=${courseID}">${teacher.username}老师的${course.coursename}课程</a></li>
                <li class="current-page">课程公告</li>
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
            <div class="features">
                <div class="comment_section">
                    <c:if test="${teacher.username.equals(username)}">
                        <form class="login">
                            <div class="comment_section">
                                <a href="editNotice?courseID=${courseID}" class="radial_but">添加课程公告</a>
                            </div>
                        </form>
                        <br/>
                    </c:if>
                    <div class="service_box1">
                        <c:if test="${empty requestScope.pagemsg}">
                            <div class="container">
                                <form class="login">
                                    <div class="form-group">
                                        <strong class="lead">没有课程公告信息</strong>
                                    </div>
                                </form>
                            </div>
                        </c:if>

                        <c:if test="${!empty requestScope.pagemsg}">
                            <div class="course_list">
                                <div class="table-header clearfix">
                                    <div class="id_col">标题</div>
                                    <div class="name_col">时间</div>
                                    <c:if test="${teacher.equals(username)}">
                                        <div class="duration_col">操作</div>
                                        <div class="date_col">操作</div>
                                    </c:if>
                                </div>
                                <c:forEach items="${requestScope.pagemsg.lists}" var="notice">
                                    <ul class="table-list">
                                        <li class="clearfix">
                                            <div class="id_col"><a href="notice?noticeId=${notice.id}">${notice.title}</a></div>

                                            <div class="name_col"><fmt:formatDate value="${notice.time}" pattern="yyyy-MM-dd HH:mm:ss"/></div>

                                            <c:if test="${teacher.username.equals(username)}">
                                                <div class="duration_col"><a href="delNotice?noticeID=${notice.id}&courseID=${courseID}">删除</a></div>
                                                <div class="date_col"><a href="reEditNotice?noticeID=${notice.id}&courseID=${courseID}">重新编辑</a></div>
                                            </c:if>
                                        </li>
                                    </ul>
                                </c:forEach>
                                <ul class="table-list">
                                    <li class="clearfix">
                                        <div class="id_col">第${requestScope.pagemsg.currPage }/ ${requestScope.pagemsg.totalPage}页</div>

                                        <div class="name_col">总记录数：${requestScope.pagemsg.totalCount }&nbsp;&nbsp;每页显示:${requestScope.pagemsg.pageSize}&nbsp;&nbsp;</div>

                                        <div class="duration_col">
                                            <c:if test="${requestScope.pagemsg.currPage != 1}">
                                                <a href="${pageContext.request.contextPath }/allNotices?courseID=${courseID}&currentPage=1">[首页]</a>
                                                <a href="${pageContext.request.contextPath }/allNotices?courseID=${courseID}&currentPage=${requestScope.pagemsg.currPage-1}">[上一页]</a>
                                            </c:if>
                                        </div>

                                        <div class="date_col">
                                            <c:if test="${requestScope.pagemsg.currPage != requestScope.pagemsg.totalPage}">
                                                <a href="${pageContext.request.contextPath }/allNotices?courseID=${courseID}&currentPage=${requestScope.pagemsg.currPage+1}">[下一页]</a>
                                                <a href="${pageContext.request.contextPath }/allNotices?courseID=${courseID}&currentPage=${requestScope.pagemsg.totalPage}">[尾页]</a>
                                            </c:if>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </c:if>
                        <div style="margin:0 auto;text-align:center">
                            <br/>
                            <strong>${result}</strong>
                        </div>
                        <!-- //banner -->
                        <div class="clearfix"> </div>
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