<%@ page import="ws.UserManager" %>
<%@ page import="org.json.JSONObject" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 08/11/2017
  Time: 21.36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    UserManager userManager = new UserManager();
    String username = request.getParameter("username");

    String json_str = userManager.getAll(username);
    JSONObject jsonObject = new JSONObject(json_str);
    out.print(jsonObject.toString());
%>
