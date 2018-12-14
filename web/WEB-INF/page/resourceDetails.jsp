<%--
  Created by IntelliJ IDEA.
  User: ATFB
  Date: 2018/8/11
  Time: 18:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
    <title>资源-${requestScope.resourceDetails.name}-详情</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
    <link href="<%=request.getContextPath()%>/css/bootstrap-3.1.1.min.css" rel='stylesheet' type='text/css' />
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.raty/lib/jquery.raty.min.js"></script>
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
    <script>
        function sure(total,price) {
            if (total<price){
                window.alert("你的积分不足");
            }
            else{
                window.confirm("确定下载资源？");
                window.location.href="${pageContext.request.contextPath }/downloadResource?fileName=${requestScope.resourceDetails.filename}&resourceID=${requestScope.resourceDetails.id}";
            }
        }
    </script>
</head>
<body>
<jsp:include page="barhead.jsp" />
<input type="hidden" value="${username}" id="UserName"/>
<input type="hidden" value="${resourceID}" id="ResourceID"/>
<!-- banner -->
<div class="courses_banner">
    <div class="container">
        <h3>资源-${requestScope.resourceDetails.name}-详情</h3>
        <%--<p class="description">--%>
        <%--Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lorem quam, adipiscing condimentum tristique vel, eleifend sed turpis. Pellentesque cursus arcu id magna euismod in elementum purus molestie.--%>
        <%--</p>--%>
        <div class="breadcrumb1">
            <ul>
                <li class="icon6"><a href="resourceList">资源中心</a></li>
                <li class="current-page">资源-${requestScope.resourceDetails.name}-详情</li>
            </ul>
        </div>
    </div>
</div>
<!-- //banner -->
<div class="services">
    <div class="container">
        <h1>欢迎您：${username}</h1>
        <div class="service_box1">
            <div class="container">
                <form class="login">
                    <strong class="lead">资源名称: ${requestScope.resourceDetails.name}</strong>
                    <br/>
                    <strong class="lead">资源简介: ${requestScope.resourceDetails.content}</strong>
                    <br/>
                    <strong class="lead">上传者：<a href="${pageContext.request.contextPath }/resourceList?keyword=${requestScope.resourceDetails.userid}">${requestScope.resourceDetails.userid}</a></strong>
                    <br/>
                    <strong class="lead">资源价格：${requestScope.resourceDetails.price}</strong>
                    <br/>
                    <strong class="lead">下载次数：${requestScope.resourceDetails.downloadTimes}</strong>
                    <br/>
                    <strong class="lead">文件名称：${requestScope.resourceDetails.filename}</strong>
                    <br/>
                    <br/>
                    <a href="javascript:void(0);" onclick="sure(${requestScope.userScore},${requestScope.resourceDetails.price})" class="radial_but">下载</a>
                    <br/>
                    <div style="width:200px; margin:100px auto;">
                        <c:if test="${requestScope.Own==1 and requestScope.score==0}">
                            <strong class="lead">我来评分：</strong>
                            <div class="demo">
                                <div id="function-demo" class="target-demo"></div>
                                <div id="function-hint" class="hint"></div>
                            </div>
                        </c:if>
                        <c:if test="${requestScope.Own==1 and requestScope.score!=0}">
                            <strong class="lead">我的评分：</strong>
                            <div class="demo">
                                <div id="function-demo1" class="target-demo" data-num="${requestScope.score}"></div>
                                <div id="function-hint1" class="hint"></div>
                            </div>
                        </c:if>
                        <strong class="lead">总体评分：</strong>
                        <div class="demo">
                            <div id="function-demo2" class="target-demo" data-num="${requestScope.evalute}"></div>
                            <div id="function-hint2" class="hint"></div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="clearfix"> </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function() {
        $.fn.raty.defaults.path = 'lib/img';
        $('#function-demo').raty({
            number: 5,//多少个星星设置
            targetType: 'hint',//类型选择，number是数字值，hint，是设置的数组值
            path      : '/js/jquery.raty/demo/img',
            hints     : ['无力吐槽','一般','不错','好','Amazing'],
            cancelOff : 'cancel-off-big.png',
            cancelOn  : 'cancel-on-big.png',
            size      : 24,
            starHalf  : 'star-half-big.png',
            starOff   : 'star-off-big.png',
            starOn    : 'star-on-big.png',
            target    : '#function-hint',
            cancel    : false,
            targetKeep: true,
            targetText: '来打个分吧',
            click: function(score) {
                var resourceID = document.getElementById("ResourceID").value;
                var username = document.getElementById("UserName").value;
                var aim_url= '/resourceEvaluate?resourceID='+resourceID+'&score='+score+'&username='+username;
                //alert(aim_url);
                window.location.href=aim_url;
                return false;
            }
        });

        $('#function-demo1').raty({
            score:function(){
                return $(this).attr("data-num");
            },
            number: 5,
            targetType: 'number',//类型选择，number是数字值，hint，是设置的数组值
            path      : '/js/jquery.raty/demo/img',
            cancelOff : 'cancel-off-big.png',
            cancelOn  : 'cancel-on-big.png',
            size      : 24,
            starHalf  : 'star-half-big.png',
            starOff   : 'star-off-big.png',
            starOn    : 'star-on-big.png',
            target    : '#function-hint1',
            readOnly  : true,
            cancel    : false,
            targetKeep: true,
            precision : false,//是否包含小数
            targetText: '我的的评分',
        });

        $('#function-demo2').raty({
            score:function(){
                return $(this).attr("data-num");
            },
            number: 5,
            targetType: 'number',
            path      : '/js/jquery.raty/demo/img',
            cancelOff : 'cancel-off-big.png',
            cancelOn  : 'cancel-on-big.png',
            size      : 24,
            starHalf  : 'star-half-big.png',
            starOff   : 'star-off-big.png',
            starOn    : 'star-on-big.png',
            target    : '#function-hint2',
            readOnly  : true,
            cancel    : false,
            targetKeep: true,
            precision : true,//是否包含小数
            targetText: '资源评分',
        });
    });
</script>

<jsp:include page="barfoot.jsp" />
</body>
</html>