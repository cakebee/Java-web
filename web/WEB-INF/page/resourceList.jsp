<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/8/11
  Time: 18:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
    <title>资源列表</title>
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
        <h3>资源中心</h3>
        <%--<p class="description">--%>
            <%--Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lorem quam, adipiscing condimentum tristique vel, eleifend sed turpis. Pellentesque cursus arcu id magna euismod in elementum purus molestie.--%>
        <%--</p>--%>
        <div class="breadcrumb1">
            <ul>
                <li class="icon6"><a href="PersonalCenter">个人中心</a></li>
                <li class="current-page">资源中心</li>
            </ul>
        </div>
    </div>
</div>
<form action="resourceList" method="post">
    <div class="details">
        <div class="container">
            <div class="col-sm-10 dropdown-buttons">
                <div class="col-sm-3 dropdown-button">
                    <div class="input-group">
                        <input class="form-control has-dark-background" name="keyword" value="${requestScope.keywords}" placeholder="请输入关键字" type="text">
                    </div>
                </div>
                <div class="col-sm-2 submit_button">
                    <form>
                        <input type="submit" value="搜索">
                    </form>
                </div>
                <div class="clearfix"> </div>
            </div>
            <div class="clearfix"> </div>
        </div>
    </div>
</form>
<!-- //banner -->
<div class="services">
    <div class="container">
        <h1>欢迎您：${username}</h1>
        <div class="form-group" style="text-align:center">
            <a href="resourceOwn" class="radial_but">已购资源</a>
            <a href="resourceUploaded" class="radial_but">上传的资源</a>
            <a href="resourceUpload" class="radial_but">上传资源</a>
        </div>
        <div class="service_box1">
            <c:if test="${requestScope.pagemsg.lists.size()=='0'}">
                <div class="container">
                    <form class="login">
                        <div class="form-group">
                            <strong class="lead">没有资源</strong>
                        </div>
                    </form>
                </div>
            </c:if>

            <c:if test="${requestScope.pagemsg.lists.size()!='0'}">
                <div style="margin:0 auto;text-align:center">
                    <table class="timetable">
                        <thead>
                        <tr>
                            <th>资源名</th>
                            <th>资源简介</th>
                            <th>所需积分</th>
                            <th>文件名称</th>
                            <th>上传者</th>
                            <th>上传时间</th>
                            <th>下载次数</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${requestScope.pagemsg.lists}" var="c">
                            <tr>
                                <td id="result1${c.id}"><a href="showResource?resourceID=${c.id}">${c.name }</a></td>
                                <td id="result2${c.id}">${c.content }</td>
                                <td>${c.price }</td>
                                <td>${c.filename }</td>
                                <td id="result3${c.id}">${c.userid}</td>
                                <td>${c.time}</td>
                                <td>${c.downloadTimes}</td>
                            </tr>
                            <script>
                                var ff=document.getElementById("result1${c.id}").innerHTML;
                                document.getElementById("result1${c.id}").innerHTML=ff.replace("${requestScope.keywords}","<font color='red'>"+"${requestScope.keywords}"+"</font>");
                                ff=document.getElementById("result2${c.id}").innerHTML;
                                document.getElementById("result2${c.id}").innerHTML=ff.replace("${requestScope.keywords}","<font color='red'>"+"${requestScope.keywords}"+"</font>");
                                ff=document.getElementById("result3${c.id}").innerHTML;
                                document.getElementById("result3${c.id}").innerHTML=ff.replace("${requestScope.keywords}","<font color='red'>"+"${requestScope.keywords}"+"</font>");
                            </script>
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
                                <a href="${pageContext.request.contextPath }/resourceList?currentPage=1">[首页]</a>&nbsp;&nbsp;
                                <a href="${pageContext.request.contextPath }/resourceList?currentPage=${requestScope.pagemsg.currPage-1}">[上一页]</a>&nbsp;&nbsp;
                            </c:if>

                            <c:if test="${requestScope.pagemsg.currPage != requestScope.pagemsg.totalPage}">
                                <a href="${pageContext.request.contextPath }/resourceList?currentPage=${requestScope.pagemsg.currPage+1}">[下一页]</a>&nbsp;&nbsp;
                                <a href="${pageContext.request.contextPath }/resourceList?currentPage=${requestScope.pagemsg.totalPage}">[尾页]</a>&nbsp;&nbsp;
                            </c:if>
                            </span>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="clearfix"> </div>
        </div>
    </div>
</div>
<jsp:include page="barfoot.jsp" />
</body>
</html>