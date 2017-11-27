package database;

import java.sql.*;

public class TokenManager {
    public void insertToken(String token, int id){
        DBConnection dbconn = new DBConnection("127.0.0.1", "ojek_season2", "root", "");
        Connection conn = dbconn.getConn();
        try{
            if(conn != null){
                Statement stmt = conn.createStatement();
                String query = "INSERT INTO user_token(user_id, token) VALUES (" + id + ",\'" + token+ "\')";
                stmt.executeUpdate(query);
                stmt.close();
                conn.close();
            }
        } catch (SQLException e){
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getActiveToken(int id){
        DBConnection dbconn = new DBConnection("127.0.0.1", "ojek_season2", "root", "");
        Connection conn = dbconn.getConn();
        try{
            if(conn != null){
                Statement stmt = conn.createStatement();
                String query = "SELECT token, time FROM user_token WHERE user_id=" + id + " ORDER BY time DESC LIMIT 1";
                ResultSet result = stmt.executeQuery(query);
                String token = null;
                if(result.next()){
                    Timestamp timestamp = result.getTimestamp("time");
                    Timestamp now = new Timestamp(System.currentTimeMillis());
                    if (now.getTime() - timestamp.getTime() <= 30*60*1000){
                        token = result.getString("token");
                    }
                }
                result.close();
                stmt.close();
                conn.close();
                return token;
            } else {
                return null;
            }
        } catch (SQLException e){
            e.printStackTrace();
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public String validateToken(String token){
        DBConnection dbconn = new DBConnection("127.0.0.1", "ojek_season2", "root", "");
        Connection conn = dbconn.getConn();
        try{
            if(conn != null){
                Statement stmt = conn.createStatement();
                String query = "SELECT time FROM user_token WHERE token=\'" + token + "\' ORDER BY time DESC LIMIT 1";
                ResultSet result = stmt.executeQuery(query);
                String validation;
                if(result.next()){
                    Timestamp timestamp = result.getTimestamp("time");
                    Timestamp now = new Timestamp(System.currentTimeMillis());
                    if (now.getTime() - timestamp.getTime() <= 30*60*1000){
                        String update = "UPDATE user_token SET time='" + now.toString() + "'     WHERE token='" + token + "'";
                        stmt.executeUpdate(update);
                        validation = "success";
                    } else {
                        validation = "failed";
                    }
                } else {
                    validation = "failed";
                }
                result.close();
                stmt.close();
                conn.close();
                return validation;
            } else {
                return null;
            }
        } catch (SQLException e){
            e.printStackTrace();
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public int expiryToken(String token){
        DBConnection dbconn = new DBConnection("127.0.0.1", "ojek_season2", "root", "");
        Connection conn = dbconn.getConn();
        int ret = -1;
        if(conn!=null){
            Statement stmt = null;
            try {
                stmt = conn.createStatement();
                ret = stmt.executeUpdate("UPDATE user_token SET time=0 WHERE token=\'" + token + "\'");
                stmt.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return ret;
    }
}
