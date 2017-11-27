<%@ page import="org.json.JSONObject" %>
<%@ page import="ws.UserManager" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 08/11/2017
  Time: 14.15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String full_name = request.getParameter("full_name");
    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String phone_number = request.getParameter("phone_number");
    String statusdriver = request.getParameter("statusdriver");
    String token = request.getParameter("token");

    JSONObject json = new JSONObject();
    json.put("full_name", full_name);
    json.put("username", username);
    json.put("email", email);
    json.put("password", password);
    json.put("phone_number", phone_number);
    json.put("statusdriver", statusdriver);
    json.put("token", token);

    UserManager userManager = new UserManager();
    Boolean result = userManager.addUser(json.toString());
    if (result) {
        json.put("status", "success");
        out.print(json.toString());
    } else {
        json.put("status", "failed");
        out.print(json.toString());
    }
%>
