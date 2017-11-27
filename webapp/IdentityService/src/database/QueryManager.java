package database;

import java.sql.*;

public class QueryManager {
    public String getName(int id){
        DBConnection dbconn = new DBConnection("127.0.0.1", "ojek_cheetos", "root", "");
        Connection conn = dbconn.getConn();
        try{
            if(conn != null){
                Statement stmt = conn.createStatement();
                ResultSet result = stmt.executeQuery("SELECT  * FROM users WHERE ID=" + id);
            String output = null;
            while(result.next()){
                output = result.getString("username");
            }
            result.close();
            stmt.close();
            conn.close();
            return output;
            } else {
                return "no connection";
            }
        } catch (SQLException e){
            return e.getSQLState();
        } catch (Exception e){
            return e.toString();
        }
    }
}
