<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/8/10
  Time: 15:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>课程评价</title>
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
        <h3>课程评价</h3>
        <%--<p class="description">--%>
            <%--Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lorem quam, adipiscing condimentum tristique vel, eleifend sed turpis. Pellentesque cursus arcu id magna euismod in elementum purus molestie.--%>
        <%--</p>--%>
        <div class="breadcrumb1">
            <ul>
                <li class="icon6"><a href="courseIndex?courseID=${courseID}">课程主页</a></li>
                <li class="current-page">课程评价</li>
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
            <p>${course.intro}</p>
            <div class="comment_section">
                <%--<h4>课程评价</h4>--%>
                <br>
                <ul class="comment-list">
                    <c:if test="${requestScope.pagemsg.lists.size()=='0'}">
                        没有评价信息
                    </c:if>
                    <c:if test="${requestScope.pagemsg.lists.size()!='0'}">
                        <c:forEach items="${requestScope.pagemsg.lists}" var="r">
                            <li>
                                <div class="author-box">
                                    <div class="author-box_left"><img src="showimage?userid=${r.userid}" class="img-responsive"/></div>
                                    <div class="author-box_right">
                                        <h5>${r.userid}</h5>
                                        <span class="m_1">评分：${r.score }</span>
                                        <p>${r.comment}</p>
                                    </div>
                                    <div class="clearfix"> </div>
                                </div>
                            </li>
                        </c:forEach>
                        <ul class="pagination event_pagination">
                            <li class="active"><a href="#">第${requestScope.pagemsg.currPage }/ ${requestScope.pagemsg.totalPage}页</a></li>
                            <li class="active"><a href="#">总记录数：${requestScope.pagemsg.totalCount }</a></li>
                            <li class="active"><a href="#">每页显示:${requestScope.pagemsg.pageSize}</a></li>
                            <c:if test="${requestScope.pagemsg.currPage != 1}">
                                <li><a href="${pageContext.request.contextPath }/CourseEvaluate1?currentPage=1">首页</a></li>
                                <li><a href="${pageContext.request.contextPath }/CourseEvaluate1?currentPage=${requestScope.pagemsg.currPage-1}">上一页</a></li>
                            </c:if>
                            <c:if test="${requestScope.pagemsg.currPage != requestScope.pagemsg.totalPage}">
                                <li><a href="${pageContext.request.contextPath }/CourseEvaluate1?currentPage=${requestScope.pagemsg.currPage+1}">下一页</a></li>
                                <li><a href="${pageContext.request.contextPath }/CourseEvaluate1?currentPage=${requestScope.pagemsg.totalPage}">尾页</a></li>
                            </c:if>
                        </ul>
                    </c:if>
                </ul>
            </div>
            <br>
            <form:form method="POST" action="/CourseEvaluateCommit" class="comment-form">
                <h4>发布评价</h4>
                <div class="col-md-6 comment-form-left">
                    <div class="select-block1">
                        <form:label path="score1">内容使用</form:label>
                        <form:select path="score1" type="text" autocomplete="off" class="required form-control">
                            <form:option value="1" label="1"/>
                            <form:option value="2" label="2"/>
                            <form:option value="3" label="3"/>
                            <form:option value="4" label="4"/>
                            <form:option value="5" label="5"/>
                        </form:select>
                    </div>
                    <div class="select-block1">
                        <form:label path="score2">简洁易懂</form:label>
                        <form:select path="score2" type="text" autocomplete="off" class="required form-control">
                            <form:option value="1" label="1"/>
                            <form:option value="2" label="2"/>
                            <form:option value="3" label="3"/>
                            <form:option value="4" label="4"/>
                            <form:option value="5" label="5"/>
                        </form:select>
                    </div>
                    <div class="select-block1">
                        <form:label path="score3">逻辑清晰</form:label>
                        <form:select path="score3" type="text" autocomplete="off" class="required form-control">
                            <form:option value="1" label="1"/>
                            <form:option value="2" label="2"/>
                            <form:option value="3" label="3"/>
                            <form:option value="4" label="4"/>
                            <form:option value="5" label="5"/>
                        </form:select>
                    </div>
                </div>
                <div class="col-md-6 comment-form-right">
                    <div class="select-block1">
                        <form:label path="comment">文字评价</form:label>
                        <form:textarea id="comment" path="comment" rows="5" aria-required="true" class="form-control has-dark-background" placeholder="文字评价"/>
                        <input name="submit" type="submit" id="submit" class="course-submit" value="添加评价">
                    </div>
                </div>
                <div class="clearfix"> </div>
            </form:form>
        </div>
        <div class="clearfix"> </div>
    </div>
</div>
<jsp:include page="barfoot.jsp" />
</body>
</html>