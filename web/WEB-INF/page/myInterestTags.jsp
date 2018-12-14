<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/8/10
  Time: 11:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
    <title>我的兴趣</title>
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
    <style>
        input[type="checkbox"] {
            position: absolute;
            clip: rect(0,0,0,0);
        }

        input[type="checkbox"] + label {
            display: inline-block;
            padding: 17px 25px;
            background: #4fbed6;
            border: none;
            text-align: center;
            cursor: pointer;
        }

        input[type="checkbox"]:checked + label,
        input[type="checkbox"]:active + label {
            box-shadow: .04em .1em .2em rgba(0,0,0,.6) inset;
            border-color: rgba(0,0,0,.3);
            background: #3b8fa3;
        }
    </style>
</head>
<body>
<jsp:include page="barhead.jsp" />
<!-- banner -->
<div class="courses_banner">
    <div class="container">
        <h3>我的兴趣</h3>
        <%--<p class="description">--%>
            <%--Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lorem quam, adipiscing condimentum tristique vel, eleifend sed turpis. Pellentesque cursus arcu id magna euismod in elementum purus molestie.--%>
        <%--</p>--%>
        <div class="breadcrumb1">
            <ul>
                <li class="icon6"><a href="PersonalCenter">个人中心</a></li>
                <li class="current-page">我的兴趣</li>
            </ul>
        </div>
    </div>
</div>
<!-- //banner -->
<div class="services">
    <div class="container">
        <h1>欢迎您：${username}</h1>
        <div class="service_box1">
            <div class="courses_box1-left">
                <form action="addMyInterest?username=${username}" method="post">
                    <h3 class="title normal">请选择感兴趣的标签</h3>
                    <br/>
                    <c:forEach items="${requestScope.tags}" var="t">
                        <input type="checkbox" value="${t.id}" name="tags" id="${t.id}" autofocus />
                        <label for="${t.id}"><font color="#ffffff">${t.tag}</font></label>
                    </c:forEach>
                    <br/>
                    <input type="submit" class="course-submit" value="提交">
                </form>
            </div>
            <br/>
            <h3 class="title normal">我的兴趣标签</h3>
            <p>点按可删除</p>
            <c:forEach items="${requestScope.mytags}" var="c">
                <a href="javascript:if(confirm('确实要删除吗?'))location='deleteMyTags?username=${username}&id=${c.id}'">
                    <input type="button" class="course-submit" name="type" value="${c.tagcontent}">
                </a>
                <%--<a href="javascript:if(confirm('确实要删除吗?'))location='deleteMyTags?username=${username}&id=${c.id}'">--%>
                    <%--<div class="alert alert-dismissible admission-alert info" role="alert" style="width: 15%">--%>
                        <%--<button type="button" class="close" data-dismiss="alert">--%>
                        <%--<span aria-hidden="true">--%>
                            <%--<i class="fa fa-times-circle"></i>--%>
                        <%--</span>--%>
                        <%--<span class="sr-only">--%>
                            <%--Close--%>
                        <%--</span>--%>
                        <%--</button>--%>
                        <%--${c.tagcontent}--%>
                    <%--</div>--%>
                <%--</a>--%>
            </c:forEach>
            <br/>
            <br/>
            <strong>${result}</strong>
        </div>
    </div>
</div>
<jsp:include page="barfoot.jsp" />
</body>
</html>