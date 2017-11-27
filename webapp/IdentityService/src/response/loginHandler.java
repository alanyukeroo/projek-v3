package response;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.UUID;

import database.LoginManager;
import database.TokenManager;
import org.json.JSONException;
import org.json.JSONObject;

public class loginHandler extends HttpServlet {
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        LoginManager query = new LoginManager();

        String status;
        String token = null;
        int id = query.getLoginStatus(username, password);
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        if (id>=0){
            status = "success";
            TokenManager tokenManager = new TokenManager();
            token = tokenManager.getActiveToken(id);
            if (token == null){
                token = UUID.randomUUID().toString().toUpperCase() + Integer.toString(id) + timestamp.getTime();
                tokenManager.insertToken(token, id);
            }
        } else {
            status = "failed";
        }

        JSONObject obj = new JSONObject();
        try {
            obj.put("status", status);
            obj.put("token", token);
        } catch (JSONException e) {
            e.printStackTrace();
        }

        out.println(obj.toString());
    }
}
