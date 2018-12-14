<%--
  Created by IntelliJ IDEA.
  User: Eason
  Date: 2018/7/27
  Time: 18:44
  To change this template use File | Settings | File Templates.
--%>

<%
    String username = (String)request.getSession().getAttribute("username");
    String type = (String)request.getSession().getAttribute("type");
    request.getSession().setAttribute("username",username);
    request.getSession().setAttribute("type",type);

    if ((username == null)){
        request.getRequestDispatcher("/login").forward(request, response);
    }

%>
