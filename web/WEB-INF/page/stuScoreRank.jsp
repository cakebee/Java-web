<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/8/11
  Time: 21:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>成绩排行</title>
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
        <h3>成绩排行</h3>

        <div class="breadcrumb1">
            <ul>
                <li class="icon6"><a href="courseIndex?courseID=${courseID}">课程主页</a></li>
                <li class="current-page">成绩排行</li>
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
                <div class="comment_section">
                    <div class="service_box1">
                        <c:if test="${empty requestScope.pagemsg}">
                            <div class="container">
                                <form class="login">
                                    <div class="form-group">
                                        <strong class="lead">没有学生参加课程</strong>
                                    </div>
                                </form>
                            </div>
                        </c:if>

                        <c:if test="${!empty requestScope.pagemsg}">
                            <div class="course_list">
                                <div class="table-header clearfix">
                                    <div class="id_col"></div>
                                    <div class="name_col">学生</div>
                                    <div class="duration_col">分数</div>
                                    <div class="date_col">名次</div>
                                </div>
                                <c:forEach items="${requestScope.pagemsg.lists}" var="c">
                                    <ul class="table-list">
                                        <li class="clearfix">
                                            <div class="id_col"></div>

                                            <div class="name_col">${c.userid }</div>

                                            <div class="duration_col">${c.score }</div>

                                            <div class="date_col">${c.rank }</div>
                                        </li>
                                    </ul>
                                </c:forEach>
                                <ul class="table-list">
                                    <li class="clearfix">
                                        <div class="id_col">第${requestScope.pagemsg.currPage }/ ${requestScope.pagemsg.totalPage}页</div>

                                        <div class="name_col">总记录数：${requestScope.pagemsg.totalCount }&nbsp;&nbsp;每页显示:${requestScope.pagemsg.pageSize}&nbsp;&nbsp;</div>

                                        <div class="duration_col">
                                            <c:if test="${requestScope.pagemsg.currPage != 1}">
                                                <a href="${pageContext.request.contextPath }/showStuScoreRank?currentPage=1">[首页]</a>
                                                <a href="${pageContext.request.contextPath }/showStuScoreRank?currentPage=${requestScope.pagemsg.currPage-1}">[上一页]</a>
                                            </c:if>
                                        </div>

                                        <div class="date_col">
                                            <c:if test="${requestScope.pagemsg.currPage != requestScope.pagemsg.totalPage}">
                                                <a href="${pageContext.request.contextPath }/showStuScoreRank?currentPage=${requestScope.pagemsg.currPage+1}">[下一页]</a>
                                                <a href="${pageContext.request.contextPath }/showStuScoreRank?currentPage=${requestScope.pagemsg.totalPage}">[尾页]</a>
                                            </c:if>
                                        </div>
                                    </li>
                                </ul>
                            </div>
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