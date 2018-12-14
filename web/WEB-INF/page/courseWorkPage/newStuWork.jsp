<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/8/10
  Time: 10:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>上传作业</title>
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
        <h3>上传作业</h3>
        <%--<p class="description">--%>
            <%--Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lorem quam, adipiscing condimentum tristique vel, eleifend sed turpis. Pellentesque cursus arcu id magna euismod in elementum purus molestie.--%>
        <%--</p>--%>
        <div class="breadcrumb1">
            <ul>
                <li class="icon6"><a href="workList?courseID=${courseID}">作业列表</a></li>
                <li class="current-page">上传作业</li>
            </ul>
        </div>
    </div>
</div>
<!-- //banner -->
<div class="courses_box1">
    <div class="container">
        <jsp:include page="../barleft.jsp" />
        <div class="col-md-9 detail">
            <img src="showcourseimage?courseid=${courseID}" class="img-responsive" width="500"/>
            <h3>${coursename}</h3>
            <p>${course.intro}</p>
            <h3 style="margin:0 auto;text-align:center">正在上传</h3>
            <br/>
            <h3 style="margin:0 auto;text-align:center">第${work.chapter}章</h3>
            <br/>
            <h3 style="margin:0 auto;text-align:center">第${work.part}节</h3>
            <br/>
            <h3 style="margin:0 auto;text-align:center">作业：${work.workname}</h3>
            <br/>
            <form:form action="/addStuWork?courseID=${courseID}&workID=${work.id}" enctype="multipart/form-data" method="post" name="fileUploadForm" class="login">
                <div class="form-group">
                    <p>选择文件</p>
                    <input type="file" name="file" autocomplete="off" class="required form-control" style="display: none" onchange="document.fileUploadForm.filePath.value=this.value"/>
                    <input type="text" name="filePath" autocomplete="off" class="required form-control" readonly="readonly" placeholder="选择文件"/>
                    <br/>
                    <input type="button" value="浏览" onclick="document.fileUploadForm.file.click()"/>

                </div>
                <div class="form-group">
                    <input type="submit" class="btn btn-primary btn-lg1 btn-block" name="submit" value="上传">
                </div>
            </form:form>
        </div>
        <div class="clearfix"> </div>
    </div>
</div>
</div>
<jsp:include page="../barfoot.jsp" />
</body>
</html>