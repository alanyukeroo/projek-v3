package soap;

import database.LoginManager;
import database.RegisterManager;
import database.TokenManager;
import org.json.JSONException;
import org.json.JSONObject;

import javax.jws.WebService;
import java.sql.Timestamp;
import java.util.UUID;

@WebService(endpointInterface = "soap.IdentityServiceInterface")
public class IdentityServiceImpl implements IdentityServiceInterface {
    @Override
    public String login(String username, String password){
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
        return obj.toString();
    }

    @Override
    public String logout(String token){
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
        return obj.toString();
    }

    @Override
    public String register(String email, String username, String password){
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
        return obj.toString();
    }

    @Override
    public String validate(String token){
        String status;
        TokenManager tokenManager = new TokenManager();
        String validation = tokenManager.validateToken(token);

        if (validation != null && validation == "success"){
            status = "success";
        } else {
            status = "failed";
        }

        JSONObject obj = new JSONObject();
        try {
            obj.put("status", status);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return obj.toString();
    }

}
