<%--
  Created by IntelliJ IDEA.
  User: Eason
  Date: 2018/8/9
  Time: 15:58
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>

    <title>在线预览</title>
    <!--首先要引入jquery库及相关的js-->
    <script type="text/javascript" src="${pageContext.request.contextPath}/flash/js/jquery.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/flash/js/flexpaper_flash.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/flash/js/flexpaper_flash_debug.js"></script>
</head>

<body>
<div style="position:absolute;left:10px;top:10px;">
    <a id="viewerPlaceHolder" style="width:1000px;height:680px;display:block"></a>
    <%-- 调节flexPaper的宽度和高度  --%>
    <script type="text/javascript">
        var fp = new FlexPaperViewer(
            'FlexPaper/swfFiles/FlexPaperViewer',
            'viewerPlaceHolder',     //<!--对应于a 标签的id-->
            { config : {
                    SwfFile : ('${pageContext.request.contextPath}/swf/222.swf'),  //<!--这句是关键: SwfFile: 指示导入的.swf的路径-->
                    Scale : 0.6,
                    ZoomTransition : 'easeOut',
                    ZoomTime : 0.5,
                    ZoomInterval : 0.2,
                    FitPageOnLoad : true,
                    FitWidthOnLoad : false,
                    PrintEnabled : true,//<!-- 是否可以打印  -->
                    FullScreenAsMaxWindow : false,
                    ProgressiveLoading : false,
                    MinZoomSize : 0.2,
                    MaxZoomSize : 5,
                    SearchMatchAll : false,
                    InitViewMode : 'Portrait',

                    ViewModeToolsVisible : true,
                    ZoomToolsVisible : true,
                    NavToolsVisible : true,
                    CursorToolsVisible : true,
                    SearchToolsVisible : true,
                    localeChain: 'en_US'
                }});
    </script>
</div>

</body>
</html>