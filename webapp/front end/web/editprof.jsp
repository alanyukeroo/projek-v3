<%@ page import="ws.UserManager" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 05/11/2017
  Time: 17.23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    UserManager userManager = new UserManager();
    String username = request.getParameter("username");
%>
<html>
<head>
    <title>PR-OJEK : Edit Preferred Location</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="css/edit.css" rel="stylesheet">
    <!-- <link href="reset.css" rel="stylesheet"> -->
</head>
<body>
<div class="all-element">
    <div class="head-title">
        <p class="judul">Edit Profile Information</p>
    </div>

    <form method="POST" action="/untitled_war_exploded/edituser" enctype="multipart/form-data" onsubmit="return validateForm()">
        <input type="hidden" name="token" value="<%= request.getParameter("token") %>">
        <input type="hidden" name="username" value="<%= request.getParameter("username") %>">
        <div class="head-title ">
            <div class="gambar-kotak">
                <img id="img-profile" class="square-picture" src="<%= userManager.getImage(username)%>">
            </div>

            <div class="column-flex fit-width">
                <div class="head-title content-font-sanchez">
                    Update Profile Picture
                </div>
                <div class="head-title no-margin">
                    <input id="file-path" class="file-gambar" type="text" value="" disabled="disabled">
                    <label for="file-upload" class="custom-file-upload posisi-kanan">
                        <input id="file-upload" type="file" name="img-file-addr" onchange="cek()">
                        Browse...
                    </label>
                </div>
            </div>


        </div>

        <div class="head-title content-font-roboto">
            <div class="field-label"> Your Name </div>
            <input id="name" type="text" class="field-value" name="name"  value="<%=userManager.getName(username)%>" oninput="checkName(this.value)">
        </div>
        <div id="error-name" style="display: none;">Name must not exceed 20 character</div>

        <div class="head-title content-font-roboto">
            <div class="field-label"> Phone</div>
            <input id="phone" type="text" class="field-value" name="phone" value="<%= userManager.getPhone(username) %>" oninput="checkPhoneNumber(this.value)">
        </div>
        <div id="error-phone-number" style="display: none;">Wrong format</div>

        <div class="head-title content-font-roboto">
            <div class="field-label">Status Driver</div>
            <label class="switch posisi-kanan">
                <input id="statusDriver" type="checkbox" name="driver_status" <% if(userManager.isDriver(username)){
                    out.print("checked");
                }%>>
                <span class="slider round"></span>
            </label>
        </div>

        <div class="head-title top-margin content-font-sanchez">
            <input id="editprof-submit" class="green-button posisi-kanan content-font-sanchez"
                   type="submit" name="save" value="SAVE">

        </div>
    </form>
    <div class="head-title top-margin content-font-sanchez">
        <a href="profile.jsp?token=<%= request.getParameter("token") %>&username=<%= request.getParameter("username") %>" >
            <button class='red-button posisi-kiri content-font-sanchez'>BACK</button>
        </a>
    </div>
</div>
</body>
<script type="text/javascript" src="js/logout.js"></script>
</html>

<script>

    var getUser = "jsp/getUserDetail.jsp?token=" + <% request.getParameter("token"); %> + "&username=" + <% request.getParameter("username"); %> + "\\";

    if (window.XMLHttpRequest) {
        // code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    } else {
        // code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            var obj = JSON.parse(this.response);
            if (obj != null) {
                console.log(obj);
                document.getElementById('name').value = obj.name;
                document.getElementById('phone').value = obj.phone_number;

                if (obj.driver === "1") {
                    document.getElementById('statusDriver').checked = true;
                }

                document.getElementById('img-profile').setAttribute('src', obj.image_address);
            } else {
                console.log("error");
            }
        }
    };
    xmlhttp.open("GET", getUser, true);
    xmlhttp.send();


    function cek(yey) {
        var path  = document.getElementById('file-upload').value;
        var filename = path.replace(/^.*[\\\/]/, '')
        document.getElementById('file-path').value = filename;
    }

    function stats() {

    }
</script>
<script type="text/javascript">
    var token = '<%= request.getParameter("token") %>';
</script>
<script type="text/javascript" src="js/cors.js"></script>
<script type="text/javascript" src="js/validator.js"></script>
<script type="text/javascript" src="js/logout.js"></script>
<script type="text/javascript" src="js/editprof.js"></script>
