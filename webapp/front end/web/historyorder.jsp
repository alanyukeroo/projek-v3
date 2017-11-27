<%@ page import="ws.DriverManager" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="ws.UserManager" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 05/11/2017
  Time: 17.45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if(request.getParameter("token") == null || request.getParameter("username") == null){
        response.sendRedirect("login.jsp");
    }

    UserManager userManager = new UserManager();
    String username = request.getParameter("username");
    Boolean statusdriver = userManager.isDriver(username);
%>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Sanchez" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
    <link rel="stylesheet" href="css/main.css">
    <meta charset="UTF-8">
    <title>PR-OJEK : History Order</title>
</head>
<body>
<div class="all-element">
    <div class="head-title">
        <div class="kiri">
            <h2><span class="pr content-font-sanchez">PR</span>-<span class="ojek content-font-sanchez">OJEK</span></h2>
            <p class="subtitle">wushh... wushh... ngeeeeeenggg...</p>
        </div>
        <div class="kanan content-font-roboto">
            <p>Hi, <span class="username-title"><%= request.getParameter("username") %></span> !</p>
            <a onclick="logout('<%= request.getParameter("token") %>')">Logout</a>
        </div>
    </div>

    <div class="head-title">
        <div class="head-navbar">
            <% if (!statusdriver) { %>
                <a class="menu" href="makeorder.jsp?token=<%= request.getParameter("token") %>&username=<%= request.getParameter("username") %>">
                    <p>ORDER</p>
                </a>
            <% } else { %>
                <a class="menu" href="findorder.jsp?token=<%= request.getParameter("token") %>&username=<%= request.getParameter("username") %>">
                    <p>ORDER</p>
                </a>
            <% } %>
        </div>
        <div class="head-navbar-now">
            <p>HISTORY</p>
        </div>
        <div class="head-navbar">
            <a class="menu" href="profile.jsp?token=<%= request.getParameter("token") %>&username=<%= request.getParameter("username") %>">
                <p>MY PROFILE</p>
            </a>
        </div>
    </div>

    <div class="head-title">
        <div class="kiri">
            <p class="main-title">TRANSACTION HISTORY</p>
        </div>
    </div>

    <div class="head-title">
        <div class="history-type-now">
            MY PREVIOUS ORDER
        </div>
        <div class="history-type">
            <a class="menu" href="historydriver.jsp?token=<%= request.getParameter("token") %>&username=<%= request.getParameter("username") %>">DRIVER ORDER</a>
        </div>
    </div>

    <%
        DriverManager driverManager = new DriverManager();
        UserManager userManager = new UserManager();
        String result = driverManager.historyOrder(request.getParameter("username"));
        JSONObject arrayDriver;
        if(!result.equals("null")){
            arrayDriver = new JSONObject(result);
        } else {
            arrayDriver = new JSONObject();
        }
        for(Integer i = 0; i < arrayDriver.length(); i++){
    %>
    <div class="column-flex">
        <div id='<%= arrayDriver.getJSONObject(i.toString()).getString("ID") %>' class='head-title driver-list'>
            <div class='gambar-kotak'>
                <img class='square-picture' src='<%= userManager.getImage(arrayDriver.getJSONObject(i.toString()).getString("username_driver")) %>' alt='<%= arrayDriver.getJSONObject(i.toString()).getString("username_driver")%>'>
            </div>
            <div class='detail-select-driver column-flex content-font-sanchez no-margin'>
                <p class='history-date'><%= arrayDriver.getJSONObject(i.toString()).getString("time")%></p>
                <p class='history-name'><%= arrayDriver.getJSONObject(i.toString()).getString("username_driver")%></p>
                <p class='history-place'><%= arrayDriver.getJSONObject(i.toString()).getString("pickingpoint")%>-><%= arrayDriver.getJSONObject(i.toString()).getString("destination")%></p>
                <p class='history-rate'>You rated : <%= arrayDriver.getJSONObject(i.toString()).getString("rating")%> </p>
                <p class='history-comment'>Your Comment</p>
                <p class='history-comment-value'><%= arrayDriver.getJSONObject(i.toString()).getString("comment")%><p>
                <button class='red-button posisi-atas posisi-kanan content-font-sanchez'
                        onclick='hideHistory("<%= request.getParameter("username") %>", "<%=  arrayDriver.getJSONObject(i.toString()).getString("ID") %>")'>HIDE</button>
            </div>
        </div>
    </div>
    <% } %>
</div>
<script>
    function hideHistory(username, idorder) {
        console.log("id order = " + idorder);
        var xmlhttp;
        if (window.XMLHttpRequest) {
            // code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
        } else {
            // code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                console.log("response" + this.response);
                if(this.response == 1){
                    document.getElementById(idorder).style.display='none';
                }
            }
        };
        xmlhttp.open("GET", "jsp/hide.jsp?who=order&username=" + username + "&id=" + idorder, true);
        xmlhttp.send();
    }

</script>
    <script type="text/javascript">
        var token = '<%= request.getParameter("token") %>';
    </script>
    <script type="text/javascript" src="js/cors.js"></script>
    <script type="text/javascript" src="js/validator.js"></script>
    <script type="text/javascript" src="js/logout.js"></script>
</body>
</html>
