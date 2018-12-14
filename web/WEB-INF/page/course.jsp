<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/8/7
  Time: 15:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
    <title>课程</title>
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
    <!----Calender -------->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/clndr.css" type="text/css" />
    <script src="<%=request.getContextPath()%>/js/underscore-min.js" type="text/javascript"></script>
    <script src= "<%=request.getContextPath()%>/js/moment-2.2.1.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/js/clndr.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/js/site.js" type="text/javascript"></script>
    <!----End Calender -------->
</head>
<body>
<jsp:include page="barhead.jsp" />
<!-- banner -->
<div class="courses_banner">
    <div class="container">
        <h3>课程</h3>
        <%--<p class="description">--%>
            <%--Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lorem quam, adipiscing condimentum tristique vel, eleifend sed turpis. Pellentesque cursus arcu id magna euismod in elementum purus molestie.--%>
        <%--</p>--%>
        <div class="breadcrumb1">
            <ul>
                <li class="icon6"><a href="/">首页</a></li>
                <li class="current-page">课程</li>
            </ul>
        </div>
    </div>
</div>
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
<!-- //banner -->
<div class="courses_box1">
    <div class="container">
        <div class="col-md-4">
            <div class="courses_box1-left">
                <form>
                    <p>课程类型：</p>
                    <a href="course">
                        <input type="button" class="course-submit" name="type" value="全部">
                    </a>
                    <a href="myInterestCourse?searchType=5">
                        <input type="button" class="course-submit" name="type" value="推荐">
                    </a>
                    <a href="hotCourse">
                        <input type="button" class="course-submit" name="type" value="热门">
                    </a>
                    <c:forEach items="${requestScope.coursetypes}" var="c">
                        <a href="searchCourse?keywords=${c.tag}&searchType=3">
                            <input type="button" class="course-submit" name="type" value="${c.tag}">
                        </a>
                    </c:forEach>
                </form>
            </div>
            <br/>
            <div class="cal1 cal_2"><div class="clndr"><div class="clndr-controls"><div class="clndr-control-button"><p class="clndr-previous-button">previous</p></div><div class="month">September 2015</div><div class="clndr-control-button rightalign"><p class="clndr-next-button">next</p></div></div><table class="clndr-table" border="0" cellspacing="0" cellpadding="0"><thead><tr class="header-days"><td class="header-day">S</td><td class="header-day">M</td><td class="header-day">T</td><td class="header-day">W</td><td class="header-day">T</td><td class="header-day">F</td><td class="header-day">S</td></tr></thead><tbody><tr><td class="day past adjacent-month last-month calendar-day-2015-08-30"><div class="day-contents">30</div></td><td class="day past adjacent-month last-month calendar-day-2015-08-31"><div class="day-contents">31</div></td><td class="day today calendar-day-2015-09-01"><div class="day-contents">1</div></td><td class="day calendar-day-2015-09-02"><div class="day-contents">2</div></td><td class="day calendar-day-2015-09-03"><div class="day-contents">3</div></td><td class="day calendar-day-2015-09-04"><div class="day-contents">4</div></td><td class="day calendar-day-2015-09-05"><div class="day-contents">5</div></td></tr><tr><td class="day calendar-day-2015-09-06"><div class="day-contents">6</div></td><td class="day calendar-day-2015-09-07"><div class="day-contents">7</div></td><td class="day calendar-day-2015-09-08"><div class="day-contents">8</div></td><td class="day calendar-day-2015-09-09"><div class="day-contents">9</div></td><td class="day event calendar-day-2015-09-10"><div class="day-contents">10</div></td><td class="day event calendar-day-2015-09-11"><div class="day-contents">11</div></td><td class="day event calendar-day-2015-09-12"><div class="day-contents">12</div></td></tr><tr><td class="day event calendar-day-2015-09-13"><div class="day-contents">13</div></td><td class="day event calendar-day-2015-09-14"><div class="day-contents">14</div></td><td class="day calendar-day-2015-09-15"><div class="day-contents">15</div></td><td class="day calendar-day-2015-09-16"><div class="day-contents">16</div></td><td class="day calendar-day-2015-09-17"><div class="day-contents">17</div></td><td class="day calendar-day-2015-09-18"><div class="day-contents">18</div></td><td class="day calendar-day-2015-09-19"><div class="day-contents">19</div></td></tr><tr><td class="day calendar-day-2015-09-20"><div class="day-contents">20</div></td><td class="day event calendar-day-2015-09-21"><div class="day-contents">21</div></td><td class="day event calendar-day-2015-09-22"><div class="day-contents">22</div></td><td class="day event calendar-day-2015-09-23"><div class="day-contents">23</div></td><td class="day calendar-day-2015-09-24"><div class="day-contents">24</div></td><td class="day calendar-day-2015-09-25"><div class="day-contents">25</div></td><td class="day calendar-day-2015-09-26"><div class="day-contents">26</div></td></tr><tr><td class="day calendar-day-2015-09-27"><div class="day-contents">27</div></td><td class="day calendar-day-2015-09-28"><div class="day-contents">28</div></td><td class="day calendar-day-2015-09-29"><div class="day-contents">29</div></td><td class="day calendar-day-2015-09-30"><div class="day-contents">30</div></td><td class="day adjacent-month next-month calendar-day-2015-10-01"><div class="day-contents">1</div></td><td class="day adjacent-month next-month calendar-day-2015-10-02"><div class="day-contents">2</div></td><td class="day adjacent-month next-month calendar-day-2015-10-03"><div class="day-contents">3</div></td></tr></tbody></table></div></div>
        </div>
        <div class="col-md-8 detail">
            <c:if test="${requestScope.pagemsg.lists.size()=='0'}">
                <h2>还没有课程</h2>
            </c:if>
            <c:if test="${requestScope.pagemsg.lists.size()!='0'}">
                <c:forEach items="${requestScope.pagemsg.lists}" var="c">
                    <div class="event-page">
                        <div class="row">
                            <div class="col-xs-4 col-sm-4">
                                <div class="event-img">
                                    <a href="courseIndex?courseID=${c.id}"><img src="showcourseimage?courseid=${c.id}" class="img-responsive" width="223"/></a>
                                    <div class="over-image"></div>
                                </div>
                            </div>
                            <div class="col-xs-8 col-sm-8 event-desc">
                                <h2>${c.coursename }</h2>
                                <div class="event-info-text">
                                    <div class="event-info-middle">
                                        <p><span class="event-bold">课程教师：&nbsp;</span>${c.teacher }</p>
                                        <p><span class="event-bold">课程类型：&nbsp;</span>${c.coursetype }</p>
                                        <p><span class="event-bold"><a href="courseIndex?courseID=${c.id}">点击查看详情</a></span></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${searchType==5}">
                    <ul class="pagination event_pagination">
                        <li class="active"><a href="#">第${requestScope.pagemsg.currPage }/ ${requestScope.pagemsg.totalPage}页</a></li>
                        <li class="active"><a href="#">总记录数：${requestScope.pagemsg.totalCount }</a></li>
                        <li class="active"><a href="#">每页显示:${requestScope.pagemsg.pageSize}</a></li>
                        <c:if test="${requestScope.pagemsg.currPage != 1}">
                            <li><a href="${pageContext.request.contextPath }/myInterestCourse?currentPage=1&searchType=5">首页</a></li>
                            <li><a href="${pageContext.request.contextPath }/myInterestCourse?searchType=5&currentPage=${requestScope.pagemsg.currPage-1}">上一页</a></li>
                        </c:if>
                        <c:if test="${requestScope.pagemsg.currPage != requestScope.pagemsg.totalPage}">
                            <li><a href="${pageContext.request.contextPath }/myInterestCourse?searchType=5&currentPage=${requestScope.pagemsg.currPage+1}">下一页</a></li>
                            <li><a href="${pageContext.request.contextPath }/myInterestCourse?searchType=5&currentPage=${requestScope.pagemsg.totalPage}">尾页</a></li>
                        </c:if>
                    </ul>
                </c:if>
                <c:if test="${searchType==4}">
                    <ul class="pagination event_pagination">
                        <li class="active"><a href="#">第${requestScope.pagemsg.currPage }/ ${requestScope.pagemsg.totalPage}页</a></li>
                        <li class="active"><a href="#">总记录数：${requestScope.pagemsg.totalCount }</a></li>
                        <li class="active"><a href="#">每页显示:${requestScope.pagemsg.pageSize}</a></li>
                        <c:if test="${requestScope.pagemsg.currPage != 1}">
                            <li><a href="${pageContext.request.contextPath }/course?currentPage=1">首页</a></li>
                            <li><a href="${pageContext.request.contextPath }/course?currentPage=${requestScope.pagemsg.currPage-1}">上一页</a></li>
                        </c:if>
                        <c:if test="${requestScope.pagemsg.currPage != requestScope.pagemsg.totalPage}">
                            <li><a href="${pageContext.request.contextPath }/course?currentPage=${requestScope.pagemsg.currPage+1}">下一页</a></li>
                            <li><a href="${pageContext.request.contextPath }/course?currentPage=${requestScope.pagemsg.totalPage}">尾页</a></li>
                        </c:if>
                    </ul>
                </c:if>
                <c:if test="${keywords!='null'}">
                    <ul class="pagination event_pagination">
                        <li class="active"><a href="#">第${requestScope.pagemsg.currPage }/ ${requestScope.pagemsg.totalPage}页</a></li>
                        <li class="active"><a href="#">总记录数：${requestScope.pagemsg.totalCount }</a></li>
                        <li class="active"><a href="#">每页显示:${requestScope.pagemsg.pageSize}</a></li>
                        <c:if test="${requestScope.pagemsg.currPage != 1}">
                            <li><a href="${pageContext.request.contextPath }/searchCourse?keywords=${keywords}&searchType=${searchType}&currentPage=1">首页</a></li>
                            <li><a href="${pageContext.request.contextPath }/searchCourse?keywords=${keywords}&searchType=${searchType}&currentPage=${requestScope.pagemsg.currPage-1}">上一页</a></li>
                        </c:if>
                        <c:if test="${requestScope.pagemsg.currPage != requestScope.pagemsg.totalPage}">
                            <li><a href="${pageContext.request.contextPath }/searchCourse?keywords=${keywords}&searchType=${searchType}&currentPage=${requestScope.pagemsg.currPage+1}">下一页</a></li>
                            <li><a href="${pageContext.request.contextPath }/searchCourse?keywords=${keywords}&searchType=${searchType}&currentPage=${requestScope.pagemsg.totalPage}">尾页</a></li>
                        </c:if>
                    </ul>
                </c:if>
            </c:if>
        </div>
        <div class="clearfix"> </div>
    </div>
</div>
<jsp:include page="barfoot.jsp" />
<!-- FlexSlider -->
<link href="<%=request.getContextPath()%>/css/flexslider.css" rel='stylesheet' type='text/css' />
<script defer src="<%=request.getContextPath()%>/js/jquery.flexslider.js"></script>
<script type="text/javascript">
    $(function(){
        SyntaxHighlighter.all();
    });
    $(window).load(function(){
        $('.flexslider').flexslider({
            animation: "slide",
            start: function(slider){
                $('body').removeClass('loading');
            }
        });
    });
</script>
<!-- FlexSlider -->
</body>
</html>