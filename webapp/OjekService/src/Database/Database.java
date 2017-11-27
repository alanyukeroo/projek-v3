package Database;
import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;
import javax.jws.soap.SOAPBinding.Style;
import java.sql.*;

@WebService
@SOAPBinding(style = Style.RPC)
public interface Database {
    @WebMethod String getName();
    @WebMethod void setName(String name);
    @WebMethod void refresh();
    @WebMethod String executeQuery(String query) throws SQLException;
    @WebMethod void executeUpdate(String query) throws SQLException;
    @WebMethod void setHost(String host);
    @WebMethod void setUser(String user);
    @WebMethod void setPassword(String password);
    @WebMethod void setDbName(String dbName);
    @WebMethod void close();
}
