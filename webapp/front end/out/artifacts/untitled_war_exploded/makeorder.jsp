<%@ page import="ws.UserManager" %>
<%@ page import="ws.DriverManager" %>
<%@ page import="org.json.JSONObject" %><%--
Created by IntelliJ IDEA.
User: Admin
Date: 05/11/2017
Time: 18.25
To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html ng-app="projek">
<head>
    <link href="https://fonts.googleapis.com/css?family=Sanchez" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
    <link rel="stylesheet" href="css/main.css">
    <script src="js/angular.min.js"></script>
    <script src="js/app.js"></script>
    <script src="js/controller.js"></script>
    <meta charset="UTF-8">
    <title>PR-OJEK : Make Order</title>
</head>
<body ng-controller="order-controller">
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
            {{ 1+1 }}
            <p class="main-title">MAKE AN ORDER</p>
        </div>
    </div>

    <div class="head-title use-baseline content-font-sanchez">
        <div id="label-step-1" class="order-step-now">
            <p class="step-number">1</p>
            <p class="step-def">Select Destination</p>
        </div>
        <div id="label-step-2" class="order-step">
            <p class="step-number">2</p>
            <p class="step-def">Select a Driver</p>
        </div>
        <div id="label-step-3" class="order-step">
            <p class="step-number">3</p>
            <p class="step-def">Chat driver</p>
        </div>
        <div id="label-step-4" class="order-step">
            <p class="step-number">4</p>
            <p class="step-def">Complete your order</p>
        </div>
    </div>

    <%-- FORM PART 1 --%>
    <div id="step-1">
        <div class="head-title content-font-roboto" >
            <div class="input-label">Picking point</div>
            <input id="pick-location" name="pick-location" class="input-place" type="text" >
        </div>

        <div class="head-title content-font-roboto" >
            <div class="input-label">Destination</div>
            <input id="destination" name="destination" class="input-place" type="text" >
        </div>

        <div class="head-title content-font-roboto" >
            <div class="input-label">Preferred Driver</div>
            <input id="input-prefer-driver" class="input-place" type="text" placeholder="(optional)">
        </div>

        <div class="head-title main-content content-font-sanchez" >
            <div class="green-button posisi-tengah" onclick="increase(); setPreferDriver(document.getElementById('input-prefer-driver').value,'<%= request.getParameter("username") %>',document.getElementById('destination').value,document.getElementById('pick-location').value );
                    setOtherDriver(document.getElementById('input-prefer-driver').value,'<%= request.getParameter("username") %>',document.getElementById('destination').value,document.getElementById('pick-location').value );">
                Next
            </div>
        </div>
    </div>

    <%-- FORM PART 2 --%>
    <div id="step-2">
        <div class="column-flex with-border">
            <p class="submain-title">PREFERRED DRIVERS:</p>
            <div id="preffered-driver"></div>
        </div>

        <div class="column-flex with-border">
            <p class="submain-title">OTHER DRIVERS:</p>
            <div id="other-driver"></div>
        </div>
    </div>
    <input name="driver-id" id="driver-id" type="text" style="display:none" >

    <%-- FORM PART 3 --%>
    <div id="step-3">
        <div class="column-flex with-border">
            <ol class="chat">
                <li class="other">
                    <div class="msg">
                        <p>Halo!</p>
                        <p>Ada dimana sekarang ya pak?</p>
                    </div>
                </li>
                <li class="self">
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
        <div class="head-title main-content content-font-sanchez" >
            <button class="red-button posisi-tengah" onclick="increase();check(step);">
                Close
            </button>
        </div>
    </div>

    <%-- FORM PART 4 --%>
    <div id="step-4">
        <div class="head-title">
            <div class="kiri">
                <p class="submain-title">HOW WAS IT:</p>
            </div>
        </div>

        <div id="info-selected-driver" class="main-content content-font-sanchez">
            <div class="main-content">
                <div class="gambar-bulat">
                    <img class="user-profpic" id="chosen-driver-pic"></img>
                </div>
            </div>
            <p><span class="username-profile" id="show-username">@username</span></p>
            <p id="show-name">user full name</p>
            <fieldset class="rating" id="rate">
                <input type="radio" id="star5" name="rating" value="5" onclick="rate(5)"/><label for="star5" title="Rocks!">5 stars</label>
                <input type="radio" id="star4" name="rating" value="4" onclick="rate(4)"/><label for="star4" title="Pretty good">4 stars</label>
                <input type="radio" id="star3" name="rating" value="3" onclick="rate(3)"/><label for="star3" title="Meh">3 stars</label>
                <input type="radio" id="star2" name="rating" value="2" onclick="rate(2)"/><label for="star2" title="Kinda bad">2 stars</label>
                <input type="radio" id="star1" name="rating" value="1" onclick="rate(1)"/><label for="star1" title="Sucks big time">1 star</label>
            </fieldset>
        </div>

        <div class="head-title">
            <textarea id="comment" name="comment" class="input-comment" placeholder="Your comment..."></textarea>
        </div>
        <!-- Kurang your comment di text area -->
        <div class="head-title content-font-sanchez">
            <button class="green-button posisi-kanan content-font-sanchez" onclick="order()">Complete <br> Order</button>
        </div>
    </div>
    <!--            </form>-->
</div>

<script type="text/javascript">
    var token = '<%= request.getParameter("token") %>';
    var username = '<%= request.getParameter("username") %>';
</script>
<script src="js/makeorder.js"></script>
<script type="text/javascript">
    var token = '<%= request.getParameter("token") %>';
</script>
<script type="text/javascript" src="js/cors.js"></script>
<script type="text/javascript" src="js/validator.js"></script>
<script type="text/javascript" src="js/logout.js"></script>
</body>
</html>

