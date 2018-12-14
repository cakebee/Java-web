<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/8/2
  Time: 8:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
    <title>发布课程</title>
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
        <h3>发布课程</h3>
        <%--<p class="description">--%>
            <%--Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lorem quam, adipiscing condimentum tristique vel, eleifend sed turpis. Pellentesque cursus arcu id magna euismod in elementum purus molestie.--%>
        <%--</p>--%>
        <div class="breadcrumb1">
            <ul>
                <li class="icon6"><a href="PersonalCenter">个人中心</a></li>
                <li class="current-page">发布课程</li>
            </ul>
        </div>
    </div>
</div>
<!-- //banner -->
<div class="services">
    <div class="container">
        <h1>欢迎您：${username}</h1>
        <!-- //banner -->
        <div class="courses_box1">
            <div class="container">
                <form class="login">
                    <div class="form-group">
                        <strong class="lead">${result}</strong>
                    </div>
                </form>
                <form method="POST" action="releaseResult" enctype="multipart/form-data" name="fileUploadForm" class="login">
                    <div class="form-group">
                        <label>课程名</label>
                        <input name="coursename" autocomplete="off" class="required form-control" placeholder="课程名" />
                    </div>
                    <div class="form-group">
                        <label >课程类型</label>
                        <select name="coursetype" autocomplete="off" class="required form-control">
                            <option value="null">课程类型</option>
                            <c:forEach items="${tags}" var="t">
                                <option value="${t.tag}">${t.tag}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>课程简介</label>
                        <input id="intro" name="intro" autocomplete="off" class="required form-control" placeholder="课程简介" />
                    </div>
                    <div class="form-group">
                        <label>分值</label>
                        <select name="price" autocomplete="off" class="required form-control">
                            <option value="0" >分值</option>
                            <option value="0" >0</option>
                            <option value="5" >5</option>
                            <option value="10">10</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>选择课程图片</label>
                        <input type="file" name="Image" autocomplete="off" class="required form-control" style="display: none" onchange="document.fileUploadForm.filePath.value=this.value"/>
                        <input type="text" name="filePath" autocomplete="off" class="required form-control" readonly="readonly" placeholder="选择文件"/>
                        <br/>
                        <input type="button" value="浏览" onclick="document.fileUploadForm.Image.click()"/>
                    </div>
                    <div class="form-group">
                        <input type="submit" class="btn btn-primary btn-lg1 btn-block" name="submit" value="申请发布">
                    </div>
                </form>
                <form method="get" action="PersonalCenter" class="login">
                    <div class="form-group">
                        <input type="submit" class="btn btn-primary btn-lg1 btn-block" name="submit" value="返回个人中心">
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<jsp:include page="barfoot.jsp" />
</body>
</html>
