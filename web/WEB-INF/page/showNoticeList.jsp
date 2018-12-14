<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/8/3
  Time: 14:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>公告查询</title>
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
        <h3>公告查询</h3>
        <%--<p class="description">--%>
            <%--Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lorem quam, adipiscing condimentum tristique vel, eleifend sed turpis. Pellentesque cursus arcu id magna euismod in elementum purus molestie.--%>
        <%--</p>--%>
        <div class="breadcrumb1">
            <ul>
                <c:choose>
                    <c:when test="${type=='admin'}">
                        <li class="icon6"><a href="adminIndex">管理中心</a></li>
                    </c:when>
                    <c:when test="${type=='teacher'||'student'}">
                        <li class="icon6"><a href="PersonalCenter">个人中心</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="icon6"><a href="/">首页</a></li>
                    </c:otherwise>
                </c:choose>
                <li class="current-page">公告查询</li>
            </ul>
        </div>
    </div>
</div>
<!-- //banner -->
<div class="services">
    <div class="container">
        <c:choose>
            <c:when test="${type=='teacher'||'student'||'admin'}">
                <h1>欢迎您：${username}</h1>
            </c:when>
            <c:otherwise>

            </c:otherwise>
        </c:choose>
        <div class="service_box1">
            <c:if test="${empty requestScope.pagemsg}">
                <div class="container">
                    <form class="login">
                        <div class="form-group">
                            <strong class="lead">没有公告信息</strong>
                        </div>
                    </form>
                </div>
            </c:if>

            <c:if test="${!empty requestScope.pagemsg}">
                <div class="course_list">
                    <div class="table-header clearfix">
                        <div class="id_col">ID</div>
                        <div class="name_col">标题</div>
                        <div class="duration_col">日期</div>
                        <c:if test="${type=='admin'}">
                            <div class="date_col">操作</div>
                        </c:if>
                    </div>
                    <c:forEach items="${requestScope.pagemsg.lists}" var="r">
                        <ul class="table-list">
                            <li class="clearfix">
                                <div class="id_col">${r.id }</div>

                                <div class="name_col"><a href="showDetail?id=${r.id}">${r.title}</a></div>

                                <div class="duration_col"><fmt:formatDate value="${r.notitime}" pattern="yyyy-MM-dd HH:mm:ss"/></div>

                                <c:if test="${type=='admin'}">
                                    <div class="date_col"><a href="deleteNotice?id=${r.id}">删除公告</a></div>
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
                                <a href="${pageContext.request.contextPath }/showNoticeList?currentPage=1">[首页]</a>
                                <a href="${pageContext.request.contextPath }/showNoticeList?currentPage=${requestScope.pagemsg.currPage-1}">[上一页]</a>
                            </c:if>
                            </div>

                            <div class="date_col">
                            <c:if test="${requestScope.pagemsg.currPage != requestScope.pagemsg.totalPage}">
                                <a href="${pageContext.request.contextPath }/showNoticeList?currentPage=${requestScope.pagemsg.currPage+1}">[下一页]</a>
                                <a href="${pageContext.request.contextPath }/showNoticeList?currentPage=${requestScope.pagemsg.totalPage}">[尾页]</a>
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
<jsp:include page="barfoot.jsp" />
</body>
</html>
