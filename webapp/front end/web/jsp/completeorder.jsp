<%@ page import="ws.DriverManager" %>
<%@ page import="java.sql.Timestamp" %><%--
  Created by IntelliJ IDEA.
  User: pratamaagung
  Date: 16/11/17
  Time: 17:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String driver = request.getParameter("driver");
    String username = request.getParameter("username");
    String pick = request.getParameter("pick");
    String dest = request.getParameter("dest");
    String comment = request.getParameter("comment");
    int rating = Integer.parseInt(request.getParameter("rating"));

   // out.print(driver + username);
    Timestamp now = new Timestamp(System.currentTimeMillis());
    String time = now.toString();

    DriverManager driverManager = new DriverManager();
    Boolean success = driverManager.addHistory(username, driver, rating, comment, time, pick, dest);
    out.print(success);
%>