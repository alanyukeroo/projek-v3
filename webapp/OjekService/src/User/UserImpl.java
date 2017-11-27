package User;

import Database.*;
import org.json.*;

import javax.jws.WebService;

//Service Implementation
@WebService(endpointInterface = "User.User")
public class UserImpl implements User{
    private DatabaseImpl db;

    public UserImpl(){
        db = new DatabaseImpl();
        db.refresh();
    }

    @Override
    public String getName(String username){
        try {
            String tmp =  db.executeQuery("SELECT name FROM user WHERE username='" + username + "'");
            JSONObject json = new JSONObject(tmp);
            String res = json.getJSONObject("0").getString("name");
            return res;
        } catch (Exception e){
            return "null";
        }
    }

    @Override
    public String getPhone(String username){
        try {
            String tmp =  db.executeQuery("SELECT phone FROM user WHERE username='" + username + "'");
            JSONObject json = new JSONObject(tmp);
            String res = json.getJSONObject("0").getString("phone");
            return res;
        } catch (Exception e){
            return "null";
        }
    }

    @Override
    public String getImage(String username){
        try {
            String tmp =  db.executeQuery("SELECT image FROM user WHERE username='" + username + "'");
            JSONObject json = new JSONObject(tmp);
            String res = json.getJSONObject("0").getString("image");
            return res;
        } catch (Exception e){
            return "null";
        }
    }

    @Override
    public String getEmail(String username){
        try {
            String tmp =  db.executeQuery("SELECT email FROM user WHERE username='" + username + "'");
            JSONObject json = new JSONObject(tmp);
            String res = json.getJSONObject("0").getString("email");
            return res;
        } catch (Exception e){
            return "null";
        }
    }


    @Override
    public Boolean isDriver(String username){
        try {
            String tmp = db.executeQuery("SELECT isdriver FROM user WHERE username='" + username + "'");
            JSONObject json = new JSONObject(tmp);
            String res = json.getJSONObject("0").getString("isdriver");
            return (res.compareTo("1") == 0);
        } catch (Exception e){
            return false;
        }
    }

    @Override
    public Boolean setName(String username, String name){
        try {
            db.executeUpdate(
                "UPDATE user "  +
                        "SET name='" + name + "' " +
                        "WHERE username='" + username + "'"
            );
            return true;
        } catch (Exception e){
            return false;
        }
    }

    @Override
    public Boolean setPhone(String username, String phone){
        try {
            db.executeUpdate(
                    "UPDATE user "  +
                            "SET phone='" + phone + "' " +
                            "WHERE username='" + username + "'"
            );
            return true;
        } catch (Exception e){
            return false;
        }
    }

    @Override
    public Boolean setEmail(String username, String email){
        try {
            db.executeUpdate(
                    "UPDATE user "  +
                            "SET email='" + email + "' " +
                            "WHERE username='" + username + "'"
            );
            return true;
        } catch (Exception e){
            return false;
        }
    }

    @Override
    public Boolean setPassword(String username, String password){
        try {
            db.executeUpdate(
                    "UPDATE user "  +
                            "SET password='" + password + "' " +
                            "WHERE username='" + username + "'"
            );
            return true;
        } catch (Exception e){
            return false;
        }
    }

    @Override
    public Boolean setImage(String username, String image){
        try {
            db.executeUpdate(
                    "UPDATE user "  +
                            "SET image='" + image + "' " +
                            "WHERE username='" + username + "'"
            );
            return true;
        } catch (Exception e){
            return false;
        }
    }

    @Override
    public Boolean addUser(String json){
        try {
            JSONObject j = new JSONObject(json);
            db.executeUpdate(
                    "INSERT INTO user VALUES (" +
                            "'" + j.getString("username") + "', " +
                            "'" + j.getString("full_name") + "', " +
                            "'" + j.getString("email") + "', " +
                            "'" + j.getString("password") + "', " +
                            "'" + j.getString("phone_number") + "', " +
                            "'" + j.getString("statusdriver") + "', " +
                            "NULL)"
            );
            return true;
        } catch (Exception e){
            return false;
        }
    }

    @Override
    public String getAll(String username){
        try {
            String res = db.executeQuery("SELECT * FROM user WHERE username='" + username + "'");
            JSONObject json = new JSONObject(res);
            return json.toString();
        } catch (Exception e){
            return "null";
        }
    }

    @Override
    public Boolean setDriver(String username, Integer val){
        try {
            db.executeUpdate(
                    "UPDATE user " +
                            "SET isdriver =" + val +
                            " WHERE username = '" + username + "'"
            );
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @Override
    public String getPreferred(String name, String location){
        try {
            String res = db.executeQuery("SELECT DISTINCT username, name, image FROM user NATURAL JOIN driver_locations WHERE name LIKE '%" + name + "%' "
                    + "AND isdriver = 1 AND location= '" + location + "'"
            );
            JSONObject json = new JSONObject(res);
            return json.toString();
        } catch (Exception e){
            return "null";
        }
    }

    @Override
    public String getOtherDriver(String except_name, String location){
        try {
            String res = db.executeQuery("SELECT DISTINCT username, name, image FROM user NATURAL JOIN driver_locations WHERE name NOT LIKE '%" + except_name + "%' "
                    + "AND isdriver = 1 AND location = '" + location + "'"
            );
            JSONObject json = new JSONObject(res);
            return json.toString();
        } catch (Exception e) {
            return "null";
        }
    }
}
