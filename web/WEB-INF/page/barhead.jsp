<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/8/3
  Time: 10:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>barhead</title>
</head>
<body>
<nav class="navbar navbar-default" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/">TYSOWLPX</a>
        </div>
        <!--/.navbar-header-->
        <div class="navbar-collapse collapse" id="bs-example-navbar-collapse-1" style="height: 1px;">
            <ul class="nav navbar-nav">
                <li class="dropdown">
                    <c:choose>
                        <c:when test="${type=='teacher'}">
                            <a href="PersonalCenter"><i class="fa fa-user"></i><span>${username}</span></a>
                        </c:when>
                        <c:when test="${type=='student'}">
                            <a href="PersonalCenter"><i class="fa fa-user"></i><span>${username}</span></a>
                        </c:when>
                        <c:when test="${type=='admin'}">
                            <a href="adminIndex"><i class="fa fa-user"></i><span>管理中心</span></a>
                        </c:when>
                        <c:otherwise>
                            <a href="login"><i class="fa fa-user"></i><span>登陆</span></a>
                        </c:otherwise>
                    </c:choose>
                </li>
                <li class="dropdown">
                    <a href="course"><i class="fa fa-list"></i><span>课程</span></a>
                </li>
                <li class="dropdown">
                    <a href="showNoticeList"><i class="fa fa-calendar"></i><span>公告</span></a>
                </li>
                <li class="dropdown">
                    <a href="" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-search"></i><span>搜索</span></a>
                    <ul class="dropdown-menu search-form">
                        <form action="searchCourse" method="post">
                            <input type="text" name="keywords" autocomplete="off" class="search-text" placeholder="请输入关键字">
                            <button type="submit" class="search-submit"><i class="fa fa-search"></i></button>
                            <div class="radios">
                                <input type="radio" name="searchType" value="1" class="label_radio" checked="checked"><span>搜索课程名</span>
                                <input type="radio" name="searchType" value="2" class="label_radio"><span>搜索教师</span>
                                <input type="radio" name="searchType" value="3" class="label_radio"><span>搜索课程类型</span>
                            </div>
                        </form>
                    </ul>
                </li>
                <li class="dropdown">
                    <c:choose>
                        <c:when test="${type=='teacher'}">
                            <a href="logout"><i class="fa fa-globe"></i><span>退出</span></a>
                        </c:when>
                        <c:when test="${type=='student'}">
                            <a href="logout"><i class="fa fa-globe"></i><span>退出</span></a>
                        </c:when>
                        <c:when test="${type=='admin'}">
                            <a href="logout"><i class="fa fa-globe"></i><span>退出</span></a>
                        </c:when>
                        <c:otherwise>

                        </c:otherwise>
                    </c:choose>
                </li>
            </ul>
        </div>
        <div class="clearfix"> </div>
    </div>
    <!--/.navbar-collapse-->
</nav>
<nav class="navbar nav_bottom" role="navigation">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header nav_2">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-megadropdown-tabs">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#"></a>
        </div>
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-megadropdown-tabs">
            <ul class="nav navbar-nav nav_1">
                <li><a href="/">退役士兵网络培训平台</a></li>
            </ul>
        </div><!-- /.navbar-collapse -->
    </div>
</nav>
</body>
</html>
