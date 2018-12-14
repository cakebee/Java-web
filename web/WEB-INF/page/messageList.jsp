<%--
  Created by IntelliJ IDEA.
  User: zxy
  Date: 2018/7/30
  Time: 8:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>消息中心</title>
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
        <h3>消息中心</h3>
        <%--<p class="description">--%>
            <%--Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lorem quam, adipiscing condimentum tristique vel, eleifend sed turpis. Pellentesque cursus arcu id magna euismod in elementum purus molestie.--%>
        <%--</p>--%>
        <div class="breadcrumb1">
            <ul>
                <li class="icon6"><a href="PersonalCenter">个人中心</a></li>
                <li class="current-page">消息中心</li>
            </ul>
        </div>
    </div>
</div>
<div class="services">
    <div class="container">
        <h1>欢迎您：${username}</h1>
        <div class="form-group" style="text-align:center">
            <a href="editmessage?receiverID=" class="radial_but">发送消息</a>
            <a href="sended_message" class="radial_but">已发消息</a>
        </div>
        <div class="service_box1">
            <c:if test="${messageList.size() == 0}">
                <div class="container">
                    <form class="login">
                        <div class="form-group">
                            <strong class="lead">这里空空如也</strong>
                        </div>
                    </form>
                </div>
            </c:if>

            <c:if test="${!empty pagemsg}">
                <div style="margin:0 auto;text-align:center">
                    <table class="timetable">
                        <thead>
                        <tr>
                            <th>标题</th>
                            <th>发送给</th>
                            <th>时间</th>
                            <th>状态</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="m" items="${pagemsg.lists}">
                            <tr>
                                <td><a href="singlemessage?id=${m.id}">${m.title}</a></td>
                                <td>${m.receid}</td>
                                <td><fmt:formatDate value="${m.sendtime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                <c:if test="${m.flag==0}">
                                    <td>未读</td>
                                </c:if>
                                <c:if test="${m.flag==1}">
                                    <td>已读</td>
                                </c:if>
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
                                <a href="${pageContext.request.contextPath }message?currentPage=1">[首页]</a>&nbsp;&nbsp;
                                <a href="${pageContext.request.contextPath }message?currentPage=${requestScope.pagemsg.currPage-1}">[上一页]</a>&nbsp;&nbsp;
                            </c:if>

                            <c:if test="${requestScope.pagemsg.currPage != requestScope.pagemsg.totalPage}">
                                <a href="${pageContext.request.contextPath }message?currentPage=${requestScope.pagemsg.currPage+1}">[下一页]</a>&nbsp;&nbsp;
                                <a href="${pageContext.request.contextPath }message?currentPage=${requestScope.pagemsg.totalPage}">[尾页]</a>&nbsp;&nbsp;
                            </c:if>
                            </span>
                        </td>
                    </tr>
                </table>
                <br/>
                <strong>${result}</strong>
            </div>
            <div class="clearfix"> </div>
        </div>
    </div>
</div>
<jsp:include page="barfoot.jsp" />
</body>
</html>
