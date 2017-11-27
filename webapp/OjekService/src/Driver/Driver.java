package Driver;
import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;
import javax.jws.soap.SOAPBinding.Style;

@WebService
@SOAPBinding(style = Style.RPC)
public interface Driver {
    @WebMethod String getLocation(String username);
    @WebMethod String getCurrentRate(String username);
    @WebMethod Boolean addHistory(String user, String driver, Integer rating,
                               String comment, String time, String pick, String destination);
    @WebMethod String historyOrder(String username_user);
    @WebMethod String historyDriver(String username_driver);
    @WebMethod Boolean addLocation(String username, String place);
    @WebMethod Boolean deleteLocation(String username, String place);
    @WebMethod Boolean hideTransactionOrder(String username, Integer id_trx);
    @WebMethod Boolean hideTransactionDriver(String username, Integer id_trx);
    @WebMethod Boolean updateLocationName(String username, String first, String last);
    @WebMethod String getMatch(String location);
    @WebMethod String getVotes(String username);
}