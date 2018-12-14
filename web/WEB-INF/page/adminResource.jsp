<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: Eason
  Date: 2018/7/23
  Time: 20:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>审核</title>
</head>
<body>
<form:form method="POST" action="/adminSuccess">
    <table>
        <tr>
            <input type="submit" value="通过" onclick="alert('审核通过')"/>
        </tr>
    </table>
</form:form>
<form:form method="POST" action="/adminFailed">
    <table>
        <tr>
            <input type="submit" value="退回" onclick="alert('审核未通过')"/>
        </tr>
    </table>
</form:form>
</body>
</html>
