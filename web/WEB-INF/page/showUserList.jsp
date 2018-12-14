<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/7/31
  Time: 14:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
    <title>用户信息查询</title>
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
        <h3>用户信息查询</h3>
        <%--<p class="description">--%>
            <%--Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lorem quam, adipiscing condimentum tristique vel, eleifend sed turpis. Pellentesque cursus arcu id magna euismod in elementum purus molestie.--%>
        <%--</p>--%>
        <div class="breadcrumb1">
            <ul>
                <li class="icon6"><a href="adminIndex">管理中心</a></li>
                <li class="current-page">用户信息查询</li>
            </ul>
        </div>
    </div>
</div>
<!-- //banner -->
<div class="services">
    <div class="container">
        <h1>欢迎您：${username}</h1>
        <div class="service_box1">
            <c:if test="${empty requestScope.pagemsg}">
                <div class="container">
                    <form class="login">
                        <div class="form-group">
                            <strong class="lead">没有用户信息</strong>
                        </div>
                    </form>
                </div>
            </c:if>

            <c:if test="${!empty requestScope.pagemsg}">
            <div style="margin:0 auto;text-align:center">
                <table class="timetable">
                    <thead>
                    <tr>
                        <th>用户名</th>
                        <th>密码</th>
                        <th>邮箱地址</th>
                        <th>用户性别</th>
                        <th>用户地址</th>
                        <th>用户签名</th>
                        <th>用户积分</th>
                        <th>用户类型</th>
                        <th>编辑</th>
                        <th>删除</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${requestScope.pagemsg.lists}" var="u">
                        <tr>
                            <td>${u.username }</td>
                            <td>${u.password }</td>
                            <td>${u.email }</td>
                            <td>${u.sex }</td>
                            <td>${u.address }</td>
                            <td>${u.sign }</td>
                            <td>${u.core }</td>
                            <td>${u.type }</td>
                            <c:if test="${u.type!='admin'}">
                                <td><a href="showUser?username=${username}&editedUsername=${u.username}">编辑用户</a></td>
                                <td><a href="deleteUser?deletedUsername=${u.username}" onclick="return confirm('确定要删除吗')">删除用户</a></td>
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
                                <a href="${pageContext.request.contextPath }/showUserList?currentPage=1&username=${username}">[首页]</a>&nbsp;&nbsp;
                                <a href="${pageContext.request.contextPath }/showUserList?currentPage=${requestScope.pagemsg.currPage-1}&username=${username}">[上一页]</a>&nbsp;&nbsp;
                            </c:if>

                            <c:if test="${requestScope.pagemsg.currPage != requestScope.pagemsg.totalPage}">
                                <a href="${pageContext.request.contextPath }/showUserList?currentPage=${requestScope.pagemsg.currPage+1}&username=${username}">[下一页]</a>&nbsp;&nbsp;
                                <a href="${pageContext.request.contextPath }/showUserList?currentPage=${requestScope.pagemsg.totalPage}&username=${username}">[尾页]</a>&nbsp;&nbsp;
                            </c:if>
                            </span>
                        </td>
                    </tr>
                </table>
                <br/>
                <strong>${result}</strong>
            </div>
            <!-- //banner -->
            <div class="courses_box1">
                <div class="container">
                    <form method="get" action="adminIndex" class="login">
                        <div class="form-group">
                            <input type="submit" class="btn btn-primary btn-lg1 btn-block" name="submit" value="返回管理员首页">
                        </div>
                    </form>
                </div>
            </div>
            <div class="clearfix"> </div>
        </div>
    </div>
</div>
<jsp:include page="barfoot.jsp" />
</body>
</html>