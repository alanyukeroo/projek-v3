<%@ page import="ws.DriverManager" %><%--
  Created by IntelliJ IDEA.
  User: pratamaagung
  Date: 08/11/17
  Time: 19:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String who = request.getParameter("who");
    String username = request.getParameter("username");
    String id = request.getParameter("id");

    DriverManager driverManager = new DriverManager();
    if(who.equals("order")){
        Boolean suc = driverManager.hideTransactionOrder(username, Integer.parseInt(id));
        if(suc){
            out.print(1);
        } else {
            out.print(0);
        }
    } else {
        Boolean suc = driverManager.hideTransactionDriver(username, Integer.parseInt(id));
        if(suc){
            out.print(1);
        } else {
            out.print(0);
        }
    }
%>
