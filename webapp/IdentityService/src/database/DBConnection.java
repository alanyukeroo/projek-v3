package database;

import java.sql.*;

public class DBConnection {
    public Connection conn;
    private String host;
    private String dbName;
    private String username;
    private String password;

    public DBConnection(String host, String dbName, String username, String password){
        try {
            Class.forName("com.mysql.jdbc.Driver");
            this.host = host;
            this.dbName = dbName;
            this.username = username;
            this.password = password;
            this.conn = DriverManager.getConnection("jdbc:mysql://" + host + ":3306/" + dbName,username,password);
        }
        catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        catch (SQLException e){
            e.printStackTrace();
        }
    }

    public String getHost(){
        return host;
    }

    public String getDbName(){
        return dbName;
    }

    public String getPassword() {
        return password;
    }

    public String getUsername() {
        return username;
    }

    public Connection getConn() {
        return conn;
    }
}
