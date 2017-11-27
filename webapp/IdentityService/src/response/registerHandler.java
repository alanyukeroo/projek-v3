package response;

import database.RegisterManager;
import database.TokenManager;
import org.json.JSONException;
import org.json.JSONObject;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.UUID;

public class registerHandler extends HttpServlet {
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        int status;
        RegisterManager register = new RegisterManager();
        status = register.addUser(username, password, email);

        JSONObject obj = new JSONObject();
        try {
            if(status > 0){
                Timestamp timestamp = new Timestamp(System.currentTimeMillis());
                TokenManager tokenManager = new TokenManager();
                String token = tokenManager.getActiveToken(status);
                if (token == null){
                    token = UUID.randomUUID().toString().toUpperCase() + Integer.toString(status) + timestamp.getTime();
                    tokenManager.insertToken(token, status);
                }
                obj.put("status", "success");
                obj.put("token", token);
            } else {
                obj.put("status", "failed");
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }
        PrintWriter out = response.getWriter();
        out.println(obj.toString());
    }
}
