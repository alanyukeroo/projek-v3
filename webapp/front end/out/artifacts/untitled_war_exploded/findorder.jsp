<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 26/11/2017
  Time: 16:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Sanchez" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
    <link rel="stylesheet" href="css/main.css">
    <meta charset="UTF-8">
    <title>PR-OJEK : Find Order</title>
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
        <div class="head-navbar-now">
            <p>ORDER</p>
        </div>
        <div class="head-navbar">
            <a class="menu" href="historyorder.jsp?token=<%= request.getParameter("token") %>&username=<%= request.getParameter("username") %>">
                <p>HISTORY</p>
            </a>
        </div>
        <div class="head-navbar">
            <a class="menu" href="profile.jsp?token=<%= request.getParameter("token") %>&username=<%= request.getParameter("username") %>">
                <p>MY PROFILE</p>
            </a>
        </div>
    </div>

    <div class="head-title">
        <div class="kiri">
            <p class="main-title">LOOKING FOR AN ORDER</p>
        </div>
    </div>

    <%-- STEP 1 --%>
    <div id="part-1">
        <div class="column-flex">
            <div class="head-title main-content content-font-sanchez">
                <div class="green-button posisi-tengah" onclick="increase()">
                    FIND ORDER
                </div>
            </div>
        </div>
    </div>


    <%-- STEP 2 --%>
    <div id="part-2">
        <div class="head-title main-content content-font-sanchez">
            <div class="column-flex">
                <p class="posisi-tengah">Finding Order ... </p>
            </div>
        </div>
        <div class="column-flex">
            <div class="red-button posisi-tengah content-font-sanchez" onclick="increase()">
                CANCEL
            </div>
        </div>
    </div>

    <%-- STEP 3 --%>
    <div id="part-3">
        <div class="main-content content-font-sanchez">
            <p>Got an Order!</p>
            <p>username_penumpang</p>
        </div>
        <div class="column-flex with-border">
            <ol class="chat">
                <li class="self">
                    <div class="msg">
                        <p>Halo!</p>
                        <p>Ada dimana sekarang ya pak?</p>
                    </div>
                </li>
                <li class="other">
                    <div class="msg">
                        <p>Hai!</p>
                        <p>Saya ada di depan gerbang ITB</p>
                        <p>buruan ya pak!</p>
                    </div>
                </li>
            </ol>
        </div>
        <div class="column-flex with-border">
            <input type="text" placeholder="Type here!"/>
        </div>
    </div>


    <script type="text/javascript">
        var token = '<%= request.getParameter("token") %>';
        var username = '<%= request.getParameter("username") %>';
    </script>
    <script src="js/findorder.js"></script>
    <script type="text/javascript">
        var token = '<%= request.getParameter("token") %>';
    </script>
    <script type="text/javascript" src="js/cors.js"></script>
    <script type="text/javascript" src="js/validator.js"></script>
    <script type="text/javascript" src="js/logout.js"></script>
</body>
</html>
