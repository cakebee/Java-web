<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/8/2
  Time: 9:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE HTML>
<html>
<head>
    <title>编辑我的课程</title>
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
    <script type="text/javascript">
        function F_Open_dialog(){
            document.getElementById("btn_file").click();
        }
        function imgChange(e, imageid) {
            console.info(e.target.files[0]);//图片文件
            console.log(e.target.value);//这个也是文件的路径和上面的dom.value是一样的
            var reader = new FileReader();
            reader.onload = (function (file) {
                return function (e) {
                    console.info(this.result); //这个就是base64的数据了
                    document.getElementById(imageid).src = this.result;
                };
            })(e.target.files[0]);
            reader.readAsDataURL(e.target.files[0]);
        }
    </script>
</head>
<body>
<jsp:include page="barhead.jsp" />
<!-- banner -->
<div class="courses_banner">
    <div class="container">
        <h3>编辑我的课程</h3>
        <%--<p class="description">--%>
            <%--Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lorem quam, adipiscing condimentum tristique vel, eleifend sed turpis. Pellentesque cursus arcu id magna euismod in elementum purus molestie.--%>
        <%--</p>--%>
        <div class="breadcrumb1">
            <ul>
                <li class="icon6"><a href="showMyCourseList">我的课程列表</a></li>
                <li class="current-page">编辑我的课程</li>
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
                <form:form method="POST" action="updateCourse?courseID=${returnCourse.id}" enctype="multipart/form-data" modelAttribute="returnCourse" class="login">
                    <p class="lead">正在编辑的课程为：${editedCoursename}</p>
                    <div class="form-group">
                        <form:label path="coursename">课程名</form:label>
                        <form:input path="coursename"  autocomplete="off" class="required form-control" placeholder="课程名" />
                    </div>
                    <div class="form-group">
                        <form:label path="coursetype">课程类型</form:label>
                        <form:select path="coursetype" type="text" autocomplete="off" class="required form-control">

                            <c:forEach items="${tags}" var="t">
                                <form:option value="${t.tag}" label="${t.tag}"/>
                            </c:forEach>

                        </form:select>
                    </div>
                    <div class="form-group">
                        <form:label path="intro">课程简介</form:label>
                        <form:textarea id="intro" path="intro" autocomplete="off" class="required form-control" rows="5" placeholder="课程简介" />
                    </div>
                    <div class="form-group">
                        <label>当前课程图片(点击修改)</label>
                        <br/>
                        <input type="file" id="btn_file" name="Image" accept="image/jpg,image/jpeg,image/gif,image/png" style="display:none" onchange="imgChange(event,'Image')">
                        <img id="Image" src="showcourseimage?courseid=${returnCourse.id}" width="500" onclick="F_Open_dialog('btn_file')">
                    </div>
                    <div class="form-group">
                        <input type="submit" class="btn btn-primary btn-lg1 btn-block" name="submit" value="提交">
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</div>
<jsp:include page="barfoot.jsp" />
</body>
</html>
