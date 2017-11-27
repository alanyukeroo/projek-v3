package ws;

import javax.xml.namespace.QName;
import javax.xml.ws.BindingProvider;
import javax.xml.ws.Service;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.logging.Logger;

public class DriverManager {
    private Driver.Driver driver;

    public DriverManager() {
        try {
            URL url = new URL("http://localhost:8090/soap/driverimpl?wsdl");

            //1st argument service URI, refer to wsdl document above
            //2nd argument is service name, refer to wsdl document above
            QName qname = new QName("http://Driver/", "DriverImplService");
            Service service = Service.create(url, qname);
            Driver.Driver driver = service.getPort(Driver.Driver.class);

            BindingProvider bindingProvider = (BindingProvider) driver;
            bindingProvider.getRequestContext().put(BindingProvider.ENDPOINT_ADDRESS_PROPERTY, "http://localhost:8090/soap/driverimpl");
            this.driver = driver;
        } catch (MalformedURLException e) {
            this.driver = null;
        }
    }

    public String getLocation(String username) {
        return driver.getLocation(username);
    }

    public String getCurrentRate(String username) {
        return driver.getCurrentRate(username);
    }

    public Boolean addHistory(String user, String driver_1, Integer rating,
                                  String comment, String time, String pick, String destination) {
        return driver.addHistory(user,driver_1,rating,comment,time,pick,destination);
    }

    public String historyOrder(String username_user) {
        return driver.historyOrder(username_user);
    }

    public String historyDriver(String username_driver){
        Logger logger = Logger.getLogger(getClass().getName());
        String ret = driver.historyDriver(username_driver);
        logger.info(ret);
        return ret;
    }

    public Boolean addLocation(String username, String place) {
        return driver.addLocation(username,place);
    }
    public Boolean deleteLocation(String username, String place) {
        return driver.deleteLocation(username,place);
    }

    public Boolean hideTransactionOrder(String username, Integer id_trx) { return driver.hideTransactionOrder(username,id_trx); }
    public Boolean hideTransactionDriver(String username, Integer id_trx) { return driver.hideTransactionDriver(username,id_trx); }
    public Boolean updateLocationName(String username, String first, String last) { return driver.updateLocationName(username,first,last);}
    public String getMatch(String location) {return driver.getMatch(location);}
    public String getVotes(String username) {return driver.getVotes(username);}
}
