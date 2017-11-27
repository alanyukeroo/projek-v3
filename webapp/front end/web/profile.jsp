<%@ page import="ws.UserManager" %>
<%@ page import="ws.DriverManager" %>
<%@ page import="org.json.JSONObject" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 05/11/2017
  Time: 16.50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if(request.getParameter("token") == null || request.getParameter("username") == null){
        response.sendRedirect("login.jsp");
    }

    UserManager userManager = new UserManager();
    String username = request.getParameter("username");
    String token = request.getParameter("token");
    String full_name = userManager.getName(username);
    String email = userManager.getEmail(username);
    String phone_number = userManager.getPhone(username);
    Boolean statusdriver = userManager.isDriver(username);
    String image = userManager.getImage(username);

    DriverManager driverManager = new DriverManager();
    String rating = driverManager.getCurrentRate(username);
    String votes = driverManager.getVotes(username);

    String location = driverManager.getLocation(username);
    JSONObject json_loc;
    if(location != null){
        json_loc = new JSONObject(location);
    } else {
        json_loc = new JSONObject();
    }

    String location_str = "";
    for (Integer i = 0; i<json_loc.length(); i++) {
        location_str += "<li>" + json_loc.getJSONObject(i.toString()).getString("location") + "</li>";
    }

    String info_location = "";
    String driver_str;
    String rating_str;
    if (statusdriver) {
        driver_str = "Driver";
        rating_str = " | <span class='font-rating'>&#9734 "+ rating + "</span> ("+ votes+"  votes)";
        info_location = info_location +
                "<div class=\"head-title\">" +
                "<div class=\"kiri\"> " +
                    "<p class=\"submain-title\">PREFERRED LOCATIONS:</p> " +
                "</div> " +
                ("<div> " +
                        "<a href=\"editprefloc.jsp?token=") + token + "&username=" + username + "\"> " +
                "<img class=\"edit-button kanan\" id=\"edit-ico\" src=\"img/edit.PNG\"> " +
                "</a> " +
        "</div> " +
        "</div> " +
        "<ul class=\"content-font-sanchez\"> " +
                location_str +
        "</ul>";
    } else {
        driver_str = "Non-Driver";
        rating_str = "";
    }

    String profile =
          "<div class='main-content'> " +
            ("<div class='gambar-bulat'> " +
                 "<img class='user-profpic' src=\"") + image +"\" alt=" + username +" >" +
             "</div> " +
          ("</div> " +
           "<p><span class='username-profile'>@") + username + ("</span></p> " +
           "<p>")+ full_name +("</p> " +
           "<p>")+ driver_str +" "+ rating_str + (" <!-- | <span class='font-rating'>&#9734 4.7</span> (1,000 votes) --></p> " +
           "<p>&#9993 ") + email +("</p> " +
           "<p>&#9743 ") + phone_number +"</p>";

%>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Sanchez" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
    <link rel="stylesheet" href="css/main.css">
    <meta charset="UTF-8">
    <title>PR-OJEK : My Profile</title>
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
        <div class="head-navbar">
            <a class="menu" href="historyorder.jsp?token=<%= request.getParameter("token") %>&username=<%= request.getParameter("username") %>">
                <p>HISTORY</p>
            </a>
        </div>
        <div class="head-navbar-now">
            <p>MY PROFILE</p>
        </div>
    </div>

    <div class="head-title">
        <div class="kiri">
            <p class="main-title">MY PROFILE</p>
        </div>
        <div>
            <a href='editprof.jsp?token=<%= request.getParameter("token") %>&username=<%= request.getParameter("username") %>' >
            <img class='edit-button kanan' id='edit-ico' src='img\edit.PNG'>
            </a>
        </div>
    </div>

    <div class="main-content content-font-sanchez">
        <%
            out.print(profile);
        %>
    </div>

    <%
        out.print(info_location);
    %>
</div>
    <script type="text/javascript">
        var token = '<%= request.getParameter("token") %>';
    </script>
    <script type="text/javascript" src="js/cors.js"></script>
    <script type="text/javascript" src="js/validator.js"></script>
    <script type="text/javascript" src="js/logout.js"></script>
</body>
</html>
