<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/8/8
  Time: 16:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>${question.title}</title>
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
        <h3>${question.title}</h3>
        <div class="breadcrumb1">
            <ul>
                <li class="icon6"><a href="allQuestions?courseId=${course.id}">问题列表</a></li>
                <li class="current-page">${question.title}</li>
            </ul>
        </div>
    </div>
</div>
<!-- //banner -->
<div class="courses_box1">
    <div class="container">
        <jsp:include page="../barleft.jsp" />
        <div class="col-md-9 detail">
            <%--<img src="images/course.jpg" class="img-responsive" alt=""/>--%>
            <h3>${question.title}</h3>
            <h4>${question.content}</h4>
            <br/>
            <div class="author-box">
                <div class="author-box_left"><img src="showimage?userid=${course.teacher}" class="img-responsive"/></div>
                <div class="author-box_right">
                    <h5>由${question.userid}发布</h5>
                    <p>于<fmt:formatDate value="${question.questime}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                </div>
                <div class="clearfix"> </div>
            </div>
            <div class="comment_section">
                <form class="comment-form">
                    <strong class="lead">回复</strong>
                </form>
            </div>
            <br/>
            <div class="comment_section">
                <ul class="comment-list">
                    <c:if test="${requestScope.pagemsg.lists.size()=='0'}">
                        没有回复
                    </c:if>
                    <c:if test="${requestScope.pagemsg.lists.size()!='0'}">
                        <c:forEach var="answer" items="${requestScope.pagemsg.lists}">
                            <li>
                                <div class="author-box">
                                    <div class="author-box_left"><img src="showimage?userid=${answer.userid}" class="img-responsive"/></div>
                                    <div class="author-box_right">
                                        <h5>${answer.userid}<span class="pull-right"><a class="comment-reply-link" href="delAnswer?answerId=${answer.id}">删除</a></span></h5>
                                        <span class="m_1"><fmt:formatDate value="${answer.answtime}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                        <p>${answer.content}</p>
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
                                <li><a href="${pageContext.request.contextPath }/getQuestion?questionId=${question.id}&currentPage=1">首页</a></li>
                                <li><a href="${pageContext.request.contextPath }/getQuestion?questionId=${question.id}&currentPage=${requestScope.pagemsg.currPage-1}">上一页</a></li>
                            </c:if>
                            <c:if test="${requestScope.pagemsg.currPage != requestScope.pagemsg.totalPage}">
                                <li><a href="${pageContext.request.contextPath }/getQuestion?questionId=${question.id}&currentPage=${requestScope.pagemsg.currPage+1}">下一页</a></li>
                                <li><a href="${pageContext.request.contextPath }/getQuestion?questionId=${question.id}&currentPage=${requestScope.pagemsg.totalPage}">尾页</a></li>
                            </c:if>
                        </ul>
                    </c:if>
                </ul>
            </div>
            <br/>
            <div class="comment_section">
                <form:form action="/addAnswer?questionId=${question.id}" method="post" modelAttribute="newAnswer" class="comment-form">
                    <strong class="lead">发表回复</strong>
                    <div class="input-group input-group1">
                        <form:textarea path="content" name="content" aria-required="true" class="form-control has-dark-background" placeholder="请输入内容"/>
                    </div>
                    <div class="clearfix"> </div>
                    <input name="submit" type="submit" class="course-submit" value="添加回答">
                </form:form>
            </div>
        </div>
        <div class="clearfix"> </div>
    </div>
</div>
<jsp:include page="../barfoot.jsp" />
</body>
</html>