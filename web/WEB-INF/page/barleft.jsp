<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/8/8
  Time: 19:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>barleft</title>
    <!----Calender -------->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/clndr.css" type="text/css" />
    <script src="<%=request.getContextPath()%>/js/underscore-min.js" type="text/javascript"></script>
    <script src= "<%=request.getContextPath()%>/js/moment-2.2.1.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/js/clndr.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/js/site.js" type="text/javascript"></script>
    <!----End Calender -------->
</head>
<body>
<div class="col-md-3">
    <div class="cal1 cal_2">
        <div class="clndr">
            <div class="clndr-controls">
                <div class="clndr-control-button">
                    <p class="clndr-previous-button">previous</p>
                </div>
                <div class="month">September 2015</div>
                <div class="clndr-control-button rightalign">
                    <p class="clndr-next-button">next</p>
                </div>
            </div>
            <table class="clndr-table" border="0" cellspacing="0" cellpadding="0">
                <thead>
                <tr class="header-days">
                    <td class="header-day">S</td>
                    <td class="header-day">M</td>
                    <td class="header-day">T</td>
                    <td class="header-day">W</td>
                    <td class="header-day">T</td>
                    <td class="header-day">F</td>
                    <td class="header-day">S</td>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td class="day past adjacent-month last-month calendar-day-2015-08-30">
                        <div class="day-contents">30</div>
                    </td>
                    <td class="day past adjacent-month last-month calendar-day-2015-08-31">
                        <div class="day-contents">31</div>
                    </td>
                    <td class="day today calendar-day-2015-09-01">
                        <div class="day-contents">1</div>
                    </td>
                    <td class="day calendar-day-2015-09-02">
                        <div class="day-contents">2</div>
                    </td>
                    <td class="day calendar-day-2015-09-03">
                        <div class="day-contents">3</div>
                    </td>
                    <td class="day calendar-day-2015-09-04">
                        <div class="day-contents">4</div>
                    </td>
                    <td class="day calendar-day-2015-09-05">
                        <div class="day-contents">5</div>
                    </td>
                </tr>
                <tr>
                    <td class="day calendar-day-2015-09-06">
                        <div class="day-contents">6</div>
                    </td>
                    <td class="day calendar-day-2015-09-07">
                        <div class="day-contents">7</div>
                    </td>
                    <td class="day calendar-day-2015-09-08">
                        <div class="day-contents">8</div>
                    </td>
                    <td class="day calendar-day-2015-09-09">
                        <div class="day-contents">9</div>
                    </td>
                    <td class="day event calendar-day-2015-09-10">
                        <div class="day-contents">10</div>
                    </td>
                    <td class="day event calendar-day-2015-09-11">
                        <div class="day-contents">11</div>
                    </td>
                    <td class="day event calendar-day-2015-09-12">
                        <div class="day-contents">12</div>
                    </td>
                </tr>
                <tr>
                    <td class="day event calendar-day-2015-09-13">
                        <div class="day-contents">13</div>
                    </td>
                    <td class="day event calendar-day-2015-09-14">
                        <div class="day-contents">14</div>
                    </td>
                    <td class="day calendar-day-2015-09-15">
                        <div class="day-contents">15</div>
                    </td>
                    <td class="day calendar-day-2015-09-16">
                        <div class="day-contents">16</div>
                    </td>
                    <td class="day calendar-day-2015-09-17">
                        <div class="day-contents">17</div>
                    </td>
                    <td class="day calendar-day-2015-09-18">
                        <div class="day-contents">18</div>
                    </td>
                    <td class="day calendar-day-2015-09-19">
                        <div class="day-contents">19</div>
                    </td>
                </tr>
                <tr>
                    <td class="day calendar-day-2015-09-20">
                        <div class="day-contents">20</div>
                    </td>
                    <td class="day event calendar-day-2015-09-21">
                        <div class="day-contents">21</div>
                    </td>
                    <td class="day event calendar-day-2015-09-22">
                        <div class="day-contents">22</div>
                    </td>
                    <td class="day event calendar-day-2015-09-23">
                        <div class="day-contents">23</div>
                    </td>
                    <td class="day calendar-day-2015-09-24">
                        <div class="day-contents">24</div>
                    </td>
                    <td class="day calendar-day-2015-09-25">
                        <div class="day-contents">25</div>
                    </td>
                    <td class="day calendar-day-2015-09-26">
                        <div class="day-contents">26</div>
                    </td>
                </tr>
                <tr>
                    <td class="day calendar-day-2015-09-27">
                        <div class="day-contents">27</div>
                    </td>
                    <td class="day calendar-day-2015-09-28">
                        <div class="day-contents">28</div>
                    </td>
                    <td class="day calendar-day-2015-09-29">
                        <div class="day-contents">29</div>
                    </td>
                    <td class="day calendar-day-2015-09-30">
                        <div class="day-contents">30</div>
                    </td>
                    <td class="day adjacent-month next-month calendar-day-2015-10-01">
                        <div class="day-contents">1</div>
                    </td>
                    <td class="day adjacent-month next-month calendar-day-2015-10-02">
                        <div class="day-contents">2</div>
                    </td>
                    <td class="day adjacent-month next-month calendar-day-2015-10-03">
                        <div class="day-contents">3</div>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="personBox">
        <div class="personBox_1">
            <div class="person_image">
                <img src="showimage?userid=${course.teacher}" class="img-responsive"/>
            </div>
            <div class="person_image_desc">
                <h1>${course.teacher}</h1>
                <p>任课老师</p>
            </div>
            <div class="clearfix"> </div>
        </div>
        <div class="person_description">
            <p>
                ${teacher.sign}
            </p>
        </div>
    </div>
    <br/>
    <section class="slider">
        <h3><a href="allNotices?courseID=${courseID}">课程公告</a></h3>
        <div class="flexslider">
            <ul class="slides">
                <c:if test="${not empty courseNotices}">
                    <c:forEach var="notice" items="${courseNotices}">
                        <li>
                            <div class="banner-info1">
                                <p><a href="notice?noticeId=${notice.id}">${notice.title}</a></p>
                                <h5><fmt:formatDate value="${notice.time}" pattern="yyyy-MM-dd HH:mm:ss"/></h5>
                            </div>
                        </li>
                    </c:forEach>
                </c:if>
            </ul>
        </div>
    </section>
</div>
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
