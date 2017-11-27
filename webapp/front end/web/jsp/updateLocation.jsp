<%@ page import="ws.DriverManager" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 08/11/2017
  Time: 19.22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    DriverManager driverManager = new DriverManager();
    String username = request.getParameter("username");
    String location_name = request.getParameter("location_name");
    String new_location = request.getParameter("new_location");

    Boolean result = driverManager.updateLocationName(username,location_name,new_location);
    if (result) {
        out.print(1);
    } else {
        out.print(0);
    }
%>
