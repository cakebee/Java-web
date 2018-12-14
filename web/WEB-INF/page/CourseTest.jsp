<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/8/11
  Time: 21:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
    <title>添加题目</title>
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
        <h3>添加题目</h3>
        <%--<p class="description">--%>
            <%--Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lorem quam, adipiscing condimentum tristique vel, eleifend sed turpis. Pellentesque cursus arcu id magna euismod in elementum purus molestie.--%>
        <%--</p>--%>
        <div class="breadcrumb1">
            <ul>
                <li class="icon6"><a href="Test?courseId=${courseid}&&type=teacher&&username=${username}">测试管理</a></li>
                <li class="current-page">添加题目</li>
            </ul>
        </div>
    </div>
</div>
<!-- //banner -->
<div class="courses_box1">
    <div class="container">
        <jsp:include page="barleft.jsp" />
        <div class="col-md-9 detail">
            <div class="comment_section">
                    <form method="POST" action="CourseTest?courseid=${courseid}" enctype="multipart/form-data" class="login">
                        <div class="form-group">
                            <label>题目名</label>
                            <input name="testname" autocomplete="off" class="required form-control" placeholder="题目名" />
                        </div>
                        <div class="form-group">
                            <label>A选项</label>
                            <input name="questionA" autocomplete="off" class="required form-control" placeholder="A选项" />
                        </div>
                        <div class="form-group">
                            <label>B选项</label>
                            <input name="questionB" autocomplete="off" class="required form-control" placeholder="B选项" />
                        </div>
                        <div class="form-group">
                            <label>C选项</label>
                            <input name="questionC" autocomplete="off" class="required form-control" placeholder="C选项" />
                        </div>
                        <div class="form-group">
                            <label >分值</label>
                            <select name="price" autocomplete="off" class="required form-control">
                                <option value="null">分值</option>
                                <option value="5" >5</option>
                                <option value="10" >10</option>
                                <option value="15" >15</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>正确选项</label>
                            <select name="correct" autocomplete="off" class="required form-control">
                                <option value="A" >正确选项</option>
                                <option value="A" >A</option>
                                <option value="B" >B</option>
                                <option value="C">C</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <input type="submit" class="btn btn-primary btn-lg1 btn-block" name="submit" value="提交题目">
                        </div>
                    </form>
                </div>
        </div>
        <div class="clearfix"> </div>
    </div>
</div>
<jsp:include page="barfoot.jsp" />
</body>
</html>
