<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/8/1
  Time: 8:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE HTML>
<html>
<head>
    <title>用户详细信息</title>
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
        <h3>用户详细信息</h3>
        <%--<p class="description">--%>
            <%--Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lorem quam, adipiscing condimentum tristique vel, eleifend sed turpis. Pellentesque cursus arcu id magna euismod in elementum purus molestie.--%>
        <%--</p>--%>
        <div class="breadcrumb1">
            <ul>
                <c:if test="${type=='admin'}">
                    <li class="icon6"><a href="showUserList">用户信息查询</a></li>
                </c:if>
                <c:if test="${type!='admin'}">
                    <li class="icon6"><a href="PersonalCenter">个人中心</a></li>
                </c:if>
                <li class="current-page">用户详细信息</li>
            </ul>
        </div>
    </div>
</div>
<!-- //banner -->
<div class="admission">
    <div class="container">
        <!-- //banner -->
        <div class="courses_box1">
            <div class="container">
                <form class="login">
                    <div class="form-group">
                        <strong class="lead">${result}</strong>
                    </div>
                </form>
                <form:form method="POST" action="editUser?editUsername=${username}&editedUsername=${editedUsername}" enctype="multipart/form-data" modelAttribute="returnUser">
                    <div class="col-md-6 admission_left">
                        <h2>正在编辑的用户为：${editedUsername}</h2>
                        <form>
                            <c:if test="${type=='admin'}">
                                <div class="form-group">
                                    <div class="input-group input-group1">
                                        <form:label path="password">密码</form:label>
                                        <form:input id="password" path="password" autocomplete="off" class="form-control has-dark-background" placeholder="密码" />
                                    </div>
                                </div>
                            </c:if>
                            <div class="input-group input-group1">
                                <form:label path="email">电子邮箱</form:label>
                                <form:input path="email"  autocomplete="off" class="form-control has-dark-background" placeholder="电子邮箱" />
                            </div>
                            <!-- select-block -->
                            <div class="col-md-4 form_box">
                                <div class="select-block1">
                                    <form:label path="sex">性别</form:label>
                                    <form:select path="sex" type="text" autocomplete="off" class="required form-control">
                                        <form:option value="man" label="性别"/>
                                        <form:option value="man" label="男"/>
                                        <form:option value="woman" label="女"/>
                                    </form:select>
                                </div>
                            </div>
                            <c:if test="${type=='admin'}">
                                <div class="col-md-4 form_box">
                                    <div class="select-block1">
                                        <form:label path="type">用户类型</form:label>
                                        <form:select path="type" type="text" autocomplete="off" class="required form-control">
                                            <form:option value="student" label="用户类型"/>
                                            <form:option value="student" label="学生"/>
                                            <form:option value="teacher" label="老师"/>
                                        </form:select>
                                    </div>
                                    <div class="clearfix"> </div>
                                </div>
                            </c:if>
                            <div class="input-group input-group1">
                                <br/>
                                <h2>当前头像为</h2>
                                <p>(点击修改)</p>
                                <div class="form-field">
                                    <input type="file" id="btn_file" name="image" accept="image/jpg,image/jpeg,image/gif,image/png" style="display:none" onchange="imgChange(event,'Image')">
                                    <img id="Image" src="showimage?userid=${editedUsername}" width="128" onclick="F_Open_dialog('btn_file')">
                                </div>
                            </div>
                        <form/>
                    </div>
                    <div class="col-md-6 admission_left">

                    </div>
                    <div class="col-md-6 admission_right">
                        <h3><br/></h3>
                        <form>
                            <div class="input-group input-group1">
                                <form:label path="sign">个性签名</form:label>
                                <form:input path="sign" autocomplete="off" class="form-control has-dark-background" placeholder="个性签名" />
                            </div>
                            <div class="input-group input-group1">
                                <form:label path="address">地址</form:label>
                                <form:input path="address" autocomplete="off" class="form-control has-dark-background" placeholder="地址" />
                            </div>

                            <input type="submit" class="course-submit" value="提交">
                        </form>
                    </div>
                </form:form>
            </div>
            <br/>

        </div>
    </div>
</div>
<jsp:include page="barfoot.jsp" />
</body>
</html>