<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/8/7
  Time: 20:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>问题列表</title>
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
        <h3>问题列表</h3>
        <div class="breadcrumb1">
            <ul>
                <li class="icon6"><a href="courseIndex?courseID=${courseId}">课程主页</a></li>
                <li class="current-page">问题列表</li>
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
            <div class="features">
                <div class="comment_section">
                    <%--<h1>问答讨论</h1>--%>
                    <form class="login">
                        <div class="comment_section">
                            <a href="editQuestion?courseId=${courseId}" class="radial_but">发布问题</a>
                            <a href="myQuestion?courseId=${courseId}" class="radial_but">我的问题</a>
                        </div>
                    </form>
                    <br/>
                    <c:if test="${not empty result}">
                        <form class="login">
                            <div class="form-group">
                                <strong class="lead">${result}</strong>
                            </div>
                        </form>
                    </c:if>
                    <c:forEach var="summary" items="${pagemsg.lists}">
                        <div class="blog_box1">
                            <dl class="item_info_dl">
                                <h2><a href="getQuestion?questionId=${summary.id}">${summary.title}</a></h2>
                                <dd>
                                    <address class="item_createdby">
                                        由${summary.userid}发布
                                    </address>
                                </dd>
                                <dd>
                                    <time datetime="2015-05-01 19:45" class="item_published">
                                        于<fmt:formatDate value="${summary.questime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </time>
                                </dd>
                            </dl>
                            <a href="getQuestion?questionId=${summary.id}" class="radial_but">查看详情</a>
                        </div>
                    </c:forEach>
                    <ul class="pagination event_pagination">
                        <li class="active"><a href="#">第${requestScope.pagemsg.currPage }/ ${requestScope.pagemsg.totalPage}页</a></li>
                        <li class="active"><a href="#">总记录数：${requestScope.pagemsg.totalCount }</a></li>
                        <li class="active"><a href="#">每页显示:${requestScope.pagemsg.pageSize}</a></li>
                        <c:if test="${requestScope.pagemsg.currPage != 1}">
                            <li><a href="${pageContext.request.contextPath }/allQuestions?currentPage=1">首页</a></li>
                            <li><a href="${pageContext.request.contextPath }/allQuestions?currentPage=${requestScope.pagemsg.currPage-1}">上一页</a></li>
                        </c:if>
                        <c:if test="${requestScope.pagemsg.currPage != requestScope.pagemsg.totalPage}">
                            <li><a href="${pageContext.request.contextPath }/allQuestions?currentPage=${requestScope.pagemsg.currPage+1}">下一页</a></li>
                            <li><a href="${pageContext.request.contextPath }/allQuestions?currentPage=${requestScope.pagemsg.totalPage}">尾页</a></li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </div>
        <div class="clearfix"> </div>
    </div>
</div>
<jsp:include page="../barfoot.jsp" />
</body>
</html>