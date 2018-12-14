<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/8/2
  Time: 9:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
    <title>我的课程列表</title>
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
        <h3>我的课程列表</h3>
        <div class="breadcrumb1">
            <ul>
                <li class="icon6"><a href="PersonalCenter">个人中心</a></li>
                <li class="current-page">我的课程列表</li>
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
                            <strong class="lead">您还未发布课程</strong>
                        </div>
                    </form>
                </div>
            </c:if>

            <c:if test="${requestScope.pagemsg.lists.size()!='0'}">
                <div style="margin:0 auto;text-align:center">
                    <table class="table_working_hours">
                        <thead>
                        <tr>
                            <td class="day_label">课程名</td>
                            <td class="day_label">课程简介</td>
                            <td class="day_label">课程类型</td>
                            <td class="day_label">所需积分</td>
                            <td class="day_label">课程状态</td>
                            <td class="day_label">编辑</td>
                            <td class="day_label">查看已上传资源</td>
                            <td class="day_label">上传资源</td>
                            <td class="day_label">删除</td>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${requestScope.pagemsg.lists}" var="c">
                            <tr>
                                <td style="margin:0 auto;text-align:center" class="day_value"><a href="courseIndex?courseID=${c.id}">${c.coursename }</a></td>
                                <td style="margin:0 auto;text-align:center" class="day_value">${c.intro }</td>
                                <td style="margin:0 auto;text-align:center" class="day_value">${c.coursetype }</td>
                                <td style="margin:0 auto;text-align:center" class="day_value">${c.price }</td>
                                <td style="margin:0 auto;text-align:center" class="day_value">
                                    <c:if test="${c.flag=='0'}">
                                        待审核
                                    </c:if>
                                    <c:if test="${c.flag=='1'}">
                                        审核通过
                                    </c:if>
                                    <c:if test="${c.flag=='2'}">
                                        未通过
                                    </c:if>
                                </td>
                                <td style="margin:0 auto;text-align:center" class="day_value"><a href="editCourse?courseID=${c.id}">编辑课程信息</a></td>
                                <td style="margin:0 auto;text-align:center" class="day_value"><a href="showCourseResourceList?courseID=${c.id}">查看</a></td>
                                <td style="margin:0 auto;text-align:center" class="day_value"><a href="uploadCourseResource?courseID=${c.id}">上传</a></td>
                                <td style="margin:0 auto;text-align:center" class="day_value"><a href="deleteCourse?courseID=${c.id}" onclick="return confirm('确定要删除吗')">删除课程</a></td>
                            </tr>
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
                                <a href="${pageContext.request.contextPath }/showMyCourseList?currentPage=1">[首页]</a>&nbsp;&nbsp;
                                <a href="${pageContext.request.contextPath }/showMyCourseList?currentPage=${requestScope.pagemsg.currPage-1}">[上一页]</a>&nbsp;&nbsp;
                            </c:if>

                            <c:if test="${requestScope.pagemsg.currPage != requestScope.pagemsg.totalPage}">
                                <a href="${pageContext.request.contextPath }/showMyCourseList?currentPage=${requestScope.pagemsg.currPage+1}">[下一页]</a>&nbsp;&nbsp;
                                <a href="${pageContext.request.contextPath }/showMyCourseList?currentPage=${requestScope.pagemsg.totalPage}">[尾页]</a>&nbsp;&nbsp;
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
            <div class="courses_box1">
                <div class="container">
                    <form method="get" action="PersonalCenter" class="login">
                        <div class="form-group">
                            <input type="submit" class="btn btn-primary btn-lg1 btn-block" name="submit" value="返回个人中心">
                        </div>
                    </form>
                </div>
            </div>
            <div class="clearfix"> </div>
        </div>
    </div>
</div>
<jsp:include page="../barfoot.jsp" />
</body>
</html>