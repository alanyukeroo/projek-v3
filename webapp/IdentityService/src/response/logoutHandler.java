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

public class logoutHandler extends HttpServlet {
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        String token = request.getParameter("token");

        int status;
        TokenManager tokenManager = new TokenManager();
        status = tokenManager.expiryToken(token);

        JSONObject obj = new JSONObject();
        try {
            if(status > 0){
                obj.put("status", "success");
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
