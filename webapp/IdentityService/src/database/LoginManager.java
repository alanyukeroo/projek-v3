package database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class LoginManager {
    public int getLoginStatus(String username, String password){
        DBConnection dbconn = new DBConnection("127.0.0.1", "ojek_season2", "root", "");
        Connection conn = dbconn.getConn();
        try{
            if(conn != null){
                Statement stmt = conn.createStatement();
                ResultSet result = stmt.executeQuery("SELECT  * FROM users WHERE username=\'" + username + "\' AND password=\'" + password + "\'");
                int output = -1;
                if(result.next()){
                    output = result.getInt("ID");
                }
                result.close();
                stmt.close();
                conn.close();
                return output;
            } else {
                return -1;
            }
        } catch (SQLException e){
            return -1;
        } catch (Exception e){
            return -1;
        }
    }
}
