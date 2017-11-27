package Database;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import javax.jws.WebService;
import org.json.simple.JSONObject;
import org.json.simple.JSONArray;

//Service Implementation
@WebService(endpointInterface = "Database.Database")
public class DatabaseImpl implements Database {
    private String host;
    private String user;
    private String password;
    private String dbName;
    private String port;
    private Connection connect;
    private String name;
    private ResultSet hasil;

    public DatabaseImpl(){
        this.host = "127.0.0.1";
        this.user = "root";
        this.password = "";
        this.dbName = "pr-ojek";
        this.port = "3306";
        this.name = "[DEFAULT]";
    }

    public DatabaseImpl(String host, String port, String dbName, String user, String pass, String name){
        this.host = host;
        this.user = user;
        this.password = pass;
        this.dbName = dbName;
        this.port = port;
        this.name = name;
    }

    @Override
    public String getName(){
        return this.name;
    }

    @Override
    public void setName(String name){
        this.name = name;
    }

    @Override
    public void refresh(){
        try {
            Class.forName("com.mysql.jdbc.Driver");
            try {
                System.out.println("Trying connect to server: "+"jdbc:mysql://" + host + ":" + port + "/" + dbName);
                this.connect = DriverManager.getConnection(
                        "jdbc:mysql://" + host + ":" + port + "/" + dbName,
                        user,
                        password
                );
                System.out.println("Connection success");
            } catch (Exception e){
                System.out.println("Cannot connect to server, error found in: "+e);
            }
        } catch (Exception e){
            System.out.println("Class not found, please download it (and also install it) in: ");
            System.out.println("**************************************************");
            System.out.println("   https://dev.mysql.com/downloads/connector/j/   ");
            System.out.println("**************************************************");
            System.out.println("Detail error can be read below this:");
            System.out.println("=====================================================================================");
            System.out.println(e.toString());
            System.out.println("=====================================================================================");
        }
    }

    @Override
    public String executeQuery(String query) throws SQLException{
        try {
            hasil = connect.createStatement().executeQuery(query);
            ResultSetMetaData rsmd = hasil.getMetaData();
            String[] kolom = new String[rsmd.getColumnCount()];
            for (int i = 0; i < kolom.length; ++i) {
                kolom[i] = rsmd.getColumnName(i+1);
            }
            JSONObject o = new JSONObject();
            JSONObject tmp;
            Integer cnt = 0;
            while (hasil.next()) {
                tmp = new JSONObject();
                for (int i = 0; i < kolom.length; ++i) {
                    tmp.put(kolom[i], hasil.getString(kolom[i]));
                }
                o.put(cnt, tmp);
                cnt++;
            }
            return o.toString();
        } catch (SQLException e){
            return e.getSQLState();
        }
    }

    @Override
    public void executeUpdate(String query) throws SQLException{
        Statement stmt = connect.createStatement();
        stmt.executeUpdate(query);
    }

    @Override
    public void setHost(String host){
        try {
            this.host = host;
        } catch (Exception e){
            System.out.println("Argument is not a string");
        }
    }

    @Override
    public void setUser(String user){
        try {
            this.user = user;
        } catch (Exception e){
            System.out.println("Argument is not a string");
        }
    }

    @Override
    public void setPassword(String password){
        try {
            this.password = password;
        } catch (Exception e){
            System.out.println("Argument is not a string");
        }
    }

    @Override
    public void setDbName(String dbName){
        try {
            this.dbName = dbName;
        } catch (Exception e){
            System.out.println("Argument is not a string");
        }
    }

    @Override
    public void close(){
        try {
            this.connect.close();
        } catch (Exception e){
            System.out.println("Database cannot be closed, please check whether the database is not open!");
        }
    }
}
