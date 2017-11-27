<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 05/11/2017
  Time: 15.54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <link href="https://fonts.googleapis.com/css?family=Sanchez" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
  <link href="css/style1.css" rel="stylesheet">
  <title>Log in</title>
  <meta charset="utf-8">
</head>

<body>
<div class="front_page">
  <div class="header">
    <h2>_____</h2>
    <div class="header-title">LOGIN</div>
    <h2>_____</h2>
  </div>
  <div class="content">
    <form>
      <div class="form-group">
        <label class="login-uname">Username</label>
        <input id="username" class="login-input-uname" type="text" name="user_name" >
      </div>
      <div class="form-group">
        <label class="login-pass">Password</label>
        <input id="password" class="login-input-pass" type="password" name="user_password" >
      </div>
      <div id="error-password" class="error">
        <span>*Sorry, your password was incorrect</span>
      </div>
      <a id="login-link" href="signup.jsp"> Don't have an account ? </a>
    </form>
    <input class="content-font-sanchez" id="login-go" type="submit" onclick="login()" value="GO!">
  </div>
</div>
  <script src="js/cors.js"></script>
  <script src="js/login.js"></script>
</body>
</html>
