package Driver;
import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;
import javax.jws.soap.SOAPBinding.Style;
import Database.*;
import org.json.JSONObject;

//Service Implementation
@WebService(endpointInterface = "Driver.Driver")
public class DriverImpl implements Driver{
    private DatabaseImpl db;

    public DriverImpl(){
        db = new DatabaseImpl();
        db.refresh();
    }

    @Override
    public String getLocation(String username){
        try {
            String tmp =  db.executeQuery("SELECT location FROM driver_locations WHERE username='" + username + "'");
            return tmp;
        } catch (Exception e){
            return "null";
        }
    }
    @Override
    public String getCurrentRate(String username){
        try {
            String tmp =  db.executeQuery("SELECT AVG(rating) as rate FROM transaction WHERE username_driver='"+username+"'");
            JSONObject json = new JSONObject(tmp);
            String res = json.getJSONObject("0").getString("rate");
            if(res == null){
                res = "0";
            } else {
                Float parse_res = Float.parseFloat(res);
                res = String.format("%.2f", parse_res);
            }
            return res;
        } catch (Exception e){
            return "0";
        }
    }

    @Override
    public Boolean addHistory(String user, String driver, Integer rating,
                               String comment, String time, String pick, String destination){
        try {
            db.executeUpdate("INSERT INTO transaction VALUES (NULL, "
                + "'" + user + "', '" + driver + "', '" + rating.toString() + "', '"
                    + comment + "', '" + time + "', '" + pick + "', '" + destination + "', 0, 0)");
            return true;
        } catch (Exception e){
            return false;
        }
    }

    @Override
    public String historyOrder(String username_user){
        try {
            String tmp =  db.executeQuery(
                    "SELECT * FROM transaction "
                    + "WHERE username_user='" + username_user + "' "
                    + "AND hideForOrder=0 ORDER BY time DESC"
            );
            JSONObject json = new JSONObject(tmp);
            return json.toString();
        } catch (Exception e){
            return "null";
        }
    }

    @Override
    public String historyDriver(String username_driver){
        try {
            String tmp =  db.executeQuery(
                    "SELECT * FROM transaction "
                            + "WHERE username_driver='" + username_driver + "' "
                            + "AND hideForDriver=0 ORDER BY time DESC"
            );
            JSONObject json = new JSONObject(tmp);
            return json.toString();
        } catch (Exception e){
            return "null";
        }
    }
    @Override
    public Boolean addLocation(String drive, String location){
        try {
            String location_exist = db.executeQuery("SELECT COUNT(*) as many FROM driver_locations WHERE username='" + drive + "' AND location='" + location + "'");
            JSONObject json = new JSONObject(location_exist);
            String nb_exist = json.getJSONObject("0").getString("many");
            if(Integer.parseInt(nb_exist) > 0){
                return false;
            } else {
                db.executeUpdate("INSERT INTO driver_locations VALUES ('" + drive + "', '" + location + "')");
                return true;
            }
        } catch (Exception e){
            return false;
        }
    }

    @Override
    public Boolean deleteLocation(String username, String place){
        try {
            db.executeUpdate("DELETE FROM driver_locations WHERE " +
                    " username='" + username + "' AND location='" + place + "'");
            return true;
        } catch (Exception e){
            return false;
        }
    }

    @Override
    public Boolean hideTransactionOrder(String username, Integer id_trx){
        try {
            db.executeUpdate(
                    "UPDATE transaction " +
                            "SET hideForOrder=1 " +
                            "WHERE username_user='" + username + "' AND " +
                            "ID=" + id_trx.toString()
            );
            return true;
        } catch (Exception e){
            return false;
        }
    }

    @Override
    public Boolean hideTransactionDriver(String username, Integer id_trx){
        try {
            db.executeUpdate(
                    "UPDATE transaction " +
                            "SET hideForDriver=1 " +
                            "WHERE username_driver='" + username + "' AND " +
                            "ID=" + id_trx.toString()
            );
            return true;
        } catch (Exception e){
            return false;
        }
    }

    @Override
    public Boolean updateLocationName(String username, String first, String last){
        try {
            db.executeUpdate(
                    "UPDATE driver_locations " +
                            "SET location='" + last + "' " +
                            "WHERE username='" + username + "' AND " +
                            "location='" + first + "'"
            );
            return true;
        } catch (Exception e){
            return false;
        }
    }

    @Override
    public String getMatch(String location){
        try {
            String res = db.executeQuery("SELECT * FROM driver_locations " +
                    "JOIN user ON driver_locations.username = user.username " +
                    "WHERE location = '" + location + "'"
            );
            JSONObject json = new JSONObject(res);
            return json.getJSONObject("0").toString();
        } catch (Exception e) {
            return "null";
        }
    }

    @Override
    public String getVotes(String username){
        try {
            String res = db.executeQuery("SELECT COUNT(rating) AS votes FROM transaction " +
                "WHERE username_driver = '" + username + "'"
            );
            JSONObject json = new JSONObject(res);
            return json.getJSONObject("0").getString("votes");
        } catch (Exception e){
            return "0";
        }
    }
}