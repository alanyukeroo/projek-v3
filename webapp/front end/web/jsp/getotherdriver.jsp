<%@ page import="ws.DriverManager" %>
<%@ page import="ws.UserManager" %>
<%@ page import="org.json.JSONObject" %>
<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 08/11/2017
  Time: 20.30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    public String setOtherDriver(String search, String username, String destination, String pick) {
        UserManager userManager = new UserManager();
        DriverManager driverManager = new DriverManager();
        String tmp = userManager.getOtherDriver(search, pick);
        Integer num_row = 0;
        JSONObject json = null;
        try {
            json = new JSONObject(tmp);
            num_row = json.length();
        } catch (Exception e) {
            num_row = 0;
        }

//        return num_row.toString() + tmp;
        String other_driver = "";
        String temp_name, temp_username, temp_image;
        if (num_row >= 1) {
            Integer i = 0;
            while (i < num_row){
                try {
                    temp_name = (json.getJSONObject(i.toString()).getString("name") != null) ? json.getJSONObject(i.toString()).getString("name") : "";
                    temp_username = (json.getJSONObject(i.toString()).getString("username") != null) ? json.getJSONObject(i.toString()).getString("username") : "";
                    temp_image = (json.getJSONObject(i.toString()).getString("image") != null) ? json.getJSONObject(i.toString()).getString("image") : "";
                            other_driver = other_driver +
                    "<div class='head-title driver-list' id='" + temp_username + "'> " +
                            " <div class='gambar-kotak'> " +
                        " <img class='square-picture' src = '" + temp_image + "' " +
                    " alt = '" + temp_username + "'> " +
                    " </div > " +
                    " <div class='detail-select-driver content-font-sanchez'> " +
                        " <p > " + temp_name + " </p > " +
                        " <p ><span class='font-rating'> &#9734 " + driverManager.getCurrentRate(temp_username) + " </" +
                    "span> (" + driverManager.getVotes(temp_username) + " votes)</p> " +
                        " <div class='green-button posisi-bawah posisi-kanan' " +
                " onclick = 'increase(); iChoose(\"" + temp_username + "\");'> I Choose You ! </div> " +
                    " </div > " +
                    " </div > ";
                } catch (Exception e){
                    return "<div class='head-title driver-list content-font-segoe'> <p class='posisi-tengah'>Nothing to Display :(</p></div>";
                }
                ++i;
            }
            if (other_driver == ""){
                return "<div class='head-title driver-list content-font-segoe'> <p class='posisi-tengah'>Nothing to Display :(</p></div>";
            } else {
                return other_driver;
            }
        } else {
            return "<div class='head-title driver-list content-font-segoe'> <p class='posisi-tengah'>Nothing to Display :(</p></div>";
        }
    }
%>

<%
    UserManager um = new UserManager();
    try {
        String search = request.getParameter("search");
        String username = request.getParameter("username");
        String destination = request.getParameter("destination");
        String pick = request.getParameter("pick");
        if (search == ""){
            search = "null";
        }
//        out.print(search + ' ' + username + ' ' + destination + ' ' + pick);
        out.print(setOtherDriver(search, username, destination, pick));
    } catch (Exception e) {
//        out.print("Nothing to show");
    }
    try {
        if (request.getParameter("cari").length() > 0){

        }
    } catch (Exception e) {
//        out.print("Nothing to show");
    }
%>