<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/7/31
  Time: 8:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>退役士兵网络培训平台</title>
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
<div class="banner">
    <!-- banner Slider starts Here -->
    <script src="<%=request.getContextPath()%>/js/responsiveslides.min.js"></script>
    <script>
        // You can also use "$(window).load(function() {"
        $(function () {
            // Slideshow 4
            $("#slider3").responsiveSlides({
                auto: true,
                pager: true,
                nav: true,
                speed: 500,
                namespace: "callbacks",
                before: function () {
                    $('.events').append("<li>before event fired.</li>");
                },
                after: function () {
                    $('.events').append("<li>after event fired.</li>");
                }
            });

        });
    </script>
    <!--//End-slider-script -->
    <div  id="top" class="callbacks_container">
        <ul class="rslides" id="slider3">
            <li>
                <div class="banner-bg">
                    <div class="container">
                        <div class="banner-info">
                            <br/>
                            <br/>
                            <br/>
                            <h3><span>退役士兵网络培训平台</span></h3>
                            <p>Retired soldier network training platform</p>
                        </div>
                    </div>
                </div>
            </li>
        </ul>
    </div>
</div>
<!-- //banner -->
<form action="searchCourse" method="post">
    <div class="details">
        <div class="container">
            <div class="col-sm-10 dropdown-buttons">
                <div class="col-sm-3 dropdown-button">
                    <div class="input-group">
                        <input class="form-control has-dark-background" name="keywords" placeholder="请输入关键字" type="text">
                    </div>
                </div>
                <div class="col-sm-3 dropdown-button">
                    <div class="section_1">
                        <select class="frm-field required" name="searchType">
                            <option value="1">搜索类型</option>
                            <option value="1">搜索课程名</option>
                            <option value="2">搜索教师</option>
                            <option value="3">搜索课程类型</option>
                        </select>
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
<div class="grid_1">
    <div class="container">
        <div class="col-md-4">
            <div class="news">
                <h1>最新公告</h1>
                <div class="section-content">
                    <c:if test="${empty requestScope.pagemsg}">
                        <article>
                            <figure class="date"><i class="fa fa-file-o"></i></figure>
                            <a href="#">没有公告信息</a>
                        </article>
                    </c:if>
                    <c:if test="${!empty requestScope.pagemsg}">
                    <c:forEach items="${requestScope.pagemsg.lists}" var="r">
                        <article>
                            <i class="fa fa-file-o"></i><a href="showDetail?id=${r.id}">${r.title}</a>
                            <figure class="date"><fmt:formatDate value="${r.notitime}" pattern="yyyy-MM-dd HH:mm:ss"/></figure>
                        </article>
                    </c:forEach>
                    </c:if>
                </div><!-- /.section-content -->
                <a href="showNoticeList" class="read-more">所有公告</a>
            </div><!-- /.news-small -->
        </div>
        <div class="col-md-8 grid_1_right">
            <h2>热门课程</h2>
            <div class="but_list">
                <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
                    <ul id="myTab" class="nav nav-tabs nav-tabs1" role="tablist">
                        <li role="presentation" class="active"><a href="hotCourse" id="home-tab" role="tab" data-toggle="tab" aria-controls="home" aria-expanded="true">最受欢迎的课程</a></li>
                    </ul>
                    <c:if test="${empty requestScope.pagemsgHotCourse}">
                        <article>
                            <figure class="date"><i class="fa fa-file-o"></i></figure>
                            <a href="#">没有热门课程</a>
                        </article>
                    </c:if>
                    <c:if test="${!empty requestScope.pagemsgHotCourse}">
                        <c:forEach items="${requestScope.pagemsgHotCourse.lists}" var="course">
                            <div id="myTabContent" class="tab-content">
                                <div role="tabpanel" class="tab-pane fade in active" id="home" aria-labelledby="home-tab">
                                    <div class="events_box">
                                        <div class="event_left">
                                            <div class="event_left-item">
                                                <div class="icon_2"><i class="fa fa-location-arrow"></i>${course.coursetype}</div>
                                                <div class="icon_2">
                                                    <div class="speaker">
                                                        <i class="fa fa-user"></i>
                                                        <div class="speaker_item">
                                                            <a href="searchCourse?searchType=2&keywords=${course.teacher}">${course.teacher}</a>
                                                        </div>
                                                        <div class="clearfix"></div>
                                                        <br/>
                                                        <img src="showcourseimage?courseid=${course.id}" class="img-responsive" alt=""/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="event_right">
                                            <h3>${course.coursename}</h3>
                                            <p>${course.intro}</p>
                                            <p><a href="courseIndex?courseID=${course.id}">查看详情</a></p>
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                </div>
            </div>
        </div>
        <div class="clearfix"> </div>
    </div>
</div>
<jsp:include page="barfoot.jsp" />
<script src="<%=request.getContextPath()%>/js/jquery.countdown.js"></script>
<script src="<%=request.getContextPath()%>/js/script.js"></script>
</body>
</html>