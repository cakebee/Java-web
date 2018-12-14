<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/8/2
  Time: 13:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
    <title>审核资源</title>
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
        <h3>审核资源</h3>
        <%--<p class="description">--%>
            <%--Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lorem quam, adipiscing condimentum tristique vel, eleifend sed turpis. Pellentesque cursus arcu id magna euismod in elementum purus molestie.--%>
        <%--</p>--%>
        <div class="breadcrumb1">
            <ul>
                <li class="icon6"><a href="adminIndex">管理中心</a></li>
                <li class="current-page">审核资源</li>
            </ul>
        </div>
    </div>
</div>
<!-- //banner -->
<div class="services">
    <div class="container">
        <h1>欢迎您：${username}</h1>
        <div class="service_box1">
            <c:if test="${requestScope.pagemsg.lists.size()=='0'}">
                <div class="container">
                    <form class="login">
                        <div class="form-group">
                            <strong class="lead">没有资源信息</strong>
                        </div>
                    </form>
                </div>
            </c:if>

            <c:if test="${requestScope.pagemsg.lists.size()!='0'}">
                <div style="margin:0 auto;text-align:center">
                    <table class="table_working_hours">
                        <thead>
                        <tr>
                            <td class="day_label">id</td>
                            <td class="day_label">name</td>
                            <td class="day_label">content</td>
                            <td class="day_label">price</td>
                            <td class="day_label">filename</td>
                            <td class="day_label">userid</td>
                            <td class="day_label">time</td>
                            <td class="day_label">通过</td>
                            <td class="day_label">不通过</td>
                            <td class="day_label">下载资源</td>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${requestScope.pagemsg.lists}" var="r">
                            <c:if test="${r.flag == 0}">
                                <tr>
                                    <td style="margin:0 auto;text-align:center" class="day_value">${r.id }</td>
                                    <td style="margin:0 auto;text-align:center" class="day_value">${r.name }</td>
                                    <td style="margin:0 auto;text-align:center" class="day_value">${r.content }</td>
                                    <td style="margin:0 auto;text-align:center" class="day_value">${r.price }</td>
                                    <td style="margin:0 auto;text-align:center" class="day_value">${r.filename }</td>
                                    <td style="margin:0 auto;text-align:center" class="day_value">${r.userid }</td>
                                    <td style="margin:0 auto;text-align:center" class="day_value">${r.time }</td>
                                    <td style="margin:0 auto;text-align:center" class="day_value"><a href="adminResourceSuccess?id=${r.id}">通过</a></td>
                                    <td style="margin:0 auto;text-align:center" class="day_value"><a href="adminResourceFailed?id=${r.id}">不通过</a></td>
                                    <td style="margin:0 auto;text-align:center" class="day_value"><a href="#">下载资源</a></td>
                                </tr>
                            </c:if>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
            <c:if test="${requestScope.pagemsg.lists.size()!='0'}">
                <div style="margin:0 auto;text-align:center">
                    <table class="table_working_hours">
                        <tr>
                            <td class="day_label">
                                <span>第${requestScope.pagemsg.currPage }/ ${requestScope.pagemsg.totalPage}页</span>&nbsp;&nbsp;
                                <span>总记录数：${requestScope.pagemsg.totalCount }&nbsp;&nbsp;每页显示:${requestScope.pagemsg.pageSize}</span>&nbsp;&nbsp;
                                <span>
                            <c:if test="${requestScope.pagemsg.currPage != 1}">
                                <a href="${pageContext.request.contextPath }showResourcesList?currentPage=1">[首页]</a>&nbsp;&nbsp;
                                <a href="${pageContext.request.contextPath }showResourcesList?currentPage=${requestScope.pagemsg.currPage-1}">[上一页]</a>&nbsp;&nbsp;
                            </c:if>

                            <c:if test="${requestScope.pagemsg.currPage != requestScope.pagemsg.totalPage}">
                                <a href="${pageContext.request.contextPath }showResourcesList?currentPage=${requestScope.pagemsg.currPage+1}">[下一页]</a>&nbsp;&nbsp;
                                <a href="${pageContext.request.contextPath }showResourcesList?currentPage=${requestScope.pagemsg.totalPage}">[尾页]</a>&nbsp;&nbsp;
                            </c:if>
                            </span>
                            </td>
                        </tr>
                    </table>
                    <br/>
                    <strong>${result}</strong>
                </div>
            </c:if>
            <!-- //banner -->
            <div class="clearfix"> </div>
        </div>
    </div>
</div>
<jsp:include page="barfoot.jsp" />
</body>
</html>