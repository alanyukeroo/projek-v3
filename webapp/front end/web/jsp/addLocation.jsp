<%@ page import="ws.DriverManager" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 08/11/2017
  Time: 19.23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    DriverManager driverManager = new DriverManager();
    String username = request.getParameter("username");
    String location_name = request.getParameter("location");

    Boolean result = driverManager.addLocation(username,location_name);
    if (result) {
        out.print(1);
    } else {
        out.print(0);
    }
%>
