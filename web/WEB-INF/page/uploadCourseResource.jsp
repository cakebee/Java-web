<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/8/2
  Time: 11:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE HTML>
<html>
<head>
    <title>上传课程资源</title>
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
        <h3>上传课程资源</h3>
        <%--<p class="description">--%>
            <%--Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lorem quam, adipiscing condimentum tristique vel, eleifend sed turpis. Pellentesque cursus arcu id magna euismod in elementum purus molestie.--%>
        <%--</p>--%>
        <div class="breadcrumb1">
            <ul>
                <li class="icon6"><a href="showMyCourseList">我的课程列表</a></li>
                <li class="current-page">上传课程资源</li>
            </ul>
        </div>
    </div>
</div>
<!-- //banner -->
<div class="services">
    <div class="container">
        <h1>欢迎您：${username}</h1>
        <h2 style="margin:0 auto;text-align:center">您正在上传的课程是：${coursename}</h2>
        <!-- //banner -->
        <div class="courses_box1">
            <div class="container">
                <form class="login">
                    <div class="form-group">
                        <strong class="lead">${result}</strong>
                    </div>
                </form>
                <form method="POST" action="uploadResult?courseID=${courseID}" enctype="multipart/form-data" name="fileUploadForm" class="login">
                    <div class="form-group">
                        <p>资源类型</p>
                        <select name="type" autocomplete="off" class="required form-control">
                            <option value="Video">资源类型</option>
                            <<option value="Video">视频</option>
                            <option value="Pdf">PDF文档</option>
                            <option value="Word">WORD文档</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <p>资源名称</p>
                        <input type="text" name="name" autocomplete="off" class="required form-control" placeholder="资源名称" />
                    </div>
                    <div class="form-group">
                        <p>章号</p>
                        <input type="text" name="chapter" autocomplete="off" class="required form-control" placeholder="章号" />
                    </div>
                    <div class="form-group">
                        <p>章标题</p>
                        <input type="text" name="chapterTitle" autocomplete="off" class="required form-control" placeholder="章标题" />
                    </div>
                    <div class="form-group">
                        <p>节号</p>
                        <input type="text" name="part" autocomplete="off" class="required form-control" placeholder="节号" />
                    </div>
                    <div class="form-group">
                        <p>节标题</p>
                        <input type="text" name="partTitle" autocomplete="off" class="required form-control" placeholder="节标题" />
                    </div>
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
                </form>
                <form method="get" action="showMyCourseList" class="login">
                    <div class="form-group">
                        <input type="submit" class="btn btn-primary btn-lg1 btn-block" name="submit" value="返回课程列表">
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<jsp:include page="barfoot.jsp" />
</body>
</html>
