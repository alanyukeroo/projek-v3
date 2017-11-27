package database;

import javax.servlet.http.HttpServlet;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Logger;

public class RegisterManager extends HttpServlet{
    public int addUser(String username, String password, String email) {
//        Logger logger = Logger.getLogger(getClass().getName());
        DBConnection dbconn = new DBConnection("127.0.0.1", "ojek_season2", "root", "");
        Connection conn = dbconn.getConn();
        int ret = 1;
        try {
            if (conn != null) {
                 Statement stmt = conn.createStatement();
                 if (checkCredentials(username,email) > 0) {
                     String query = "INSERT INTO users (username, password, email) VALUES (\'" + username + "\', \'" +
                             password + "\', \'" + email + "\')";
//                     logger.info(query);
                     ret = stmt.executeUpdate(query);
                     if (ret > 0) {
                         String query_id = "SELECT ID FROM users WHERE username=\'" + username + "\'";
//                         logger.info(query_id);
                         ResultSet resultSet = stmt.executeQuery(query_id);
                         if (resultSet.next()) {
                             ret = resultSet.getInt("ID");
                         } else {
                             ret = -1;
                         }
                     }
//                     logger.info(query + " Result: " + Integer.toString(ret));
                 } else {
                     ret = -1;
                 }
             } else {
                 ret = -1;
             }
         } catch (SQLException e){
             ret = -1;
         } catch (Exception e){
             ret = -1;
         }
//         logger.info("Result: " + Integer.toString(ret));
         return ret;
    }

    public int checkCredentials(String username, String email) {
//        Logger logger = Logger.getLogger(getClass().getName());
        DBConnection dbconn = new DBConnection("127.0.0.1", "ojek_season2", "root", "");
        Connection conn = dbconn.getConn();
        int ret = 1;
        try {
            if (conn != null) {
                Statement stmt = conn.createStatement();
                ResultSet result_username = stmt.executeQuery("SELECT * FROM users WHERE username=\'" + username + "\'");
                result_username.last();
                int row_username = result_username.getRow();
                ResultSet result_email = stmt.executeQuery("SELECT * FROM users WHERE email=\'" + email + "\'");
                result_email.last();
                int row_email = result_email.getRow();
                if (row_username >= 1 || row_email >=1) {
                    ret = -1;
                }
            } else {
                ret = -1;
            }
        } catch (SQLException e) {
            ret = -1;
        } catch (Exception e) {
            ret = -1;
        }
//        logger.info("Return: " + Integer.toString(ret));
        return ret;
    }
}
