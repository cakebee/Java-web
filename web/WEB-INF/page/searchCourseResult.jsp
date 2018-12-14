<%--
  Created by IntelliJ IDEA.
  User: Eason
  Date: 2018/8/2
  Time: 10:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>课程搜索结果</title>
</head>

<body>
搜索结果
<hr>
<c:if test="${requestScope.pagemsg.lists.size()=='0'}">
    搜索不到诶！
</c:if>

<c:if test="${requestScope.pagemsg.lists.size()!='0'}">
    <table border="1" cellpadding="10" cellspacing="0" class="table1">
        <thead>
        <tr>
            <td>课程名</td>
            <td>课程教师</td>
            <td>课程类型</td>
            <td>进入学习</td>
        </tr>
        </thead>
        <c:forEach items="${requestScope.pagemsg.lists}" var="c">
            <tr>
                <th>${c.coursename }</th>

                <th>${c.teacher }</th>
                <th>${c.coursetype }</th>

                <td><a href="courseIndex?courseID=${c.id}">点击参与学习</a></td>

            </tr>
        </c:forEach>
    </table>
    <table  border="0" cellspacing="0" cellpadding="0"  width="900px">
        <tr>
            <td class="td2">
                <span>第${requestScope.pagemsg.currPage }/ ${requestScope.pagemsg.totalPage}页</span>&nbsp;&nbsp;
                <span>总记录数：${requestScope.pagemsg.totalCount }&nbsp;&nbsp;每页显示:${requestScope.pagemsg.pageSize}</span>&nbsp;&nbsp;
                <span>
       <c:if test="${requestScope.pagemsg.currPage != 1}">
           <a href="${pageContext.request.contextPath }/course?currentPage=1">[首页]</a>&nbsp;&nbsp;
           <a href="${pageContext.request.contextPath }/course?currentPage=${requestScope.pagemsg.currPage-1}">[上一页]</a>&nbsp;&nbsp;
       </c:if>

       <c:if test="${requestScope.pagemsg.currPage != requestScope.pagemsg.totalPage}">
           <a href="${pageContext.request.contextPath }/course?currentPage=${requestScope.pagemsg.currPage+1}">[下一页]</a>&nbsp;&nbsp;
           <a href="${pageContext.request.contextPath }/course?currentPage=${requestScope.pagemsg.totalPage}">[尾页]</a>&nbsp;&nbsp;
       </c:if>
    </span>
            </td>
        </tr>
    </table>
</c:if>
</body>
</html>
