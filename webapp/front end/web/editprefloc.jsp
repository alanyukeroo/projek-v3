<%@ page import="ws.UserManager" %>
<%@ page import="ws.DriverManager" %>
<%@ page import="org.json.JSONObject" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 05/11/2017
  Time: 17.38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    UserManager userManager = new UserManager();
    DriverManager driverManager = new DriverManager();

    String token = request.getParameter("token");
    String username = request.getParameter("username");
    String location = driverManager.getLocation(username);
    String location_str = "";
    JSONObject json_loc;
    if (location.equals("null")) {
        json_loc = new JSONObject();
    } else {
        json_loc = new JSONObject(location);
    }
    Integer iterator = 1;
    for (Integer i = 0; i<json_loc.length(); i++) {
        location_str +=
            ("<tr> " +
             "<td class='nomor content-font-sanchez'>") + iterator.toString() + "</td> " +
             ("<td class='lokasi'> " +
              "<input id='loc") + json_loc.getJSONObject(i.toString()).getString("location") +"' class='list-lokasi content-font-sanchez' type='text' value='"+ json_loc.getJSONObject(i.toString()).getString("location") + "' disabled='disabled'> " +
               "</td> " +
            "<td class='aksi'> " +
               ("<div class='head-title no-margin' style='margin-bottom: 10px'> " +
                    "<span id='edit") + json_loc.getJSONObject(i.toString()).getString("location") + "' class='gambar-icon gambar-icon-edit' onclick='editLocation(\"" + json_loc.getJSONObject(i.toString()).getString("location") +"\",\""+ username +("\")'>&#10000;</span> " +
                    "<span id='delete")+json_loc.getJSONObject(i.toString()).getString("location")+"' class='gambar-icon gambar-icon-delete' onclick='deleteLocation(\""+json_loc.getJSONObject(i.toString()).getString("location")+"\",\""+ username +"\")'>&#10006;</span> " +
                "</div> " +
            "</td> " +
            "</tr>";
        iterator++;
    }
%>
<html>
<head>
    <title>PR-OJEK : Edit Preferred Location</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="css/edit.css" rel="stylesheet">
</head>
<body>
<div class="all-element">
    <div class="head-title ">
        <p class="judul">Edit Preferred Locations</p>
    </div>

    <div class="head-title">
        <table>

        </table>
    </div>

    <div class="head-title">
        <table>
            <tr>
                <th class="nomor content-font-roboto">No</th>
                <th class="lokasi content-font-roboto">Locations</th>
                <th class="aksi content-font-roboto">Actions</th>
            </tr>
            <%
                out.print(location_str);
            %>
        </table>
    </div>

    <div class="head-title top-margin">
        <div class="subjudul">ADD NEW LOCATION:</div>
    </div>

    <div class="head-title">
        <input type="text" id="location" class="field-location" name="newlocation">
        <button class="green-button posisi-kanan content-font-sanchez" onclick="addLocation('<%= request.getParameter("username")%>')">ADD</button>
    </div>

    <div class="head-title top-margin">
        <a href="profile.jsp?token=<%= request.getParameter("token") %>&username=<%= request.getParameter("username") %>" >
            <button class="red-button posisi-kiri content-font-sanchez">BACK</button>
        </a>
    </div>


</div>
<script type="text/javascript">
    var token = '<%= request.getParameter("token") %>';
</script>
<script type="text/javascript" src="js/cors.js"></script>
<script type="text/javascript" src="js/validator.js"></script>
<script src="js/editprefloc.js"></script>
</body>
</html>
