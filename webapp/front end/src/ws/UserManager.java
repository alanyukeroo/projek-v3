package ws;

import javax.xml.namespace.QName;
import javax.xml.ws.BindingProvider;
import javax.xml.ws.Service;
import java.net.MalformedURLException;
import java.net.URL;

public class UserManager {
    private User.User user;

    public UserManager(){
        try {
            URL url = new URL("http://localhost:8090/soap/userimpl?wsdl");

            //1st argument service URI, refer to wsdl document above
            //2nd argument is service name, refer to wsdl document above
            QName qname = new QName("http://User/", "UserImplService");
            Service service = Service.create(url, qname);
            User.User user = service.getPort(User.User.class);

            BindingProvider bindingProvider = (BindingProvider) user;
            bindingProvider.getRequestContext().put(BindingProvider.ENDPOINT_ADDRESS_PROPERTY, "http://localhost:8090/soap/userimpl");
            this.user = user;
        } catch (MalformedURLException e) {
            this.user = null;
        }
    }

    public String getName(String username) {
        return user.getName(username);
    }

    public String getPhone(String username) {
        return user.getPhone(username);
    }

    public String getEmail(String username) {
        return user.getEmail(username);
    }

    public String getImage(String username) { return user.getImage(username); }

    public Boolean isDriver(String username) {
        return user.isDriver(username);
    }

    public Boolean addUser(String json){
        return user.addUser(json);
    }

    public Boolean setName(String username, String name){
        return user.setName(username, name);
    }

    public Boolean setPhone(String username, String phone){
        return user.setPhone(username, phone);
    }

    public Boolean setEmail(String username, String email){
        return user.setEmail(username, email);
    }

    public Boolean setPassword(String username, String password){
        return user.setPassword(username, password);
    }

    public Boolean setImage(String username, String image){
        return user.setImage(username, image);
    }

    public String getAll(String username) {return user.getAll(username);}
    public String getPreferred(String name, String location) {return user.getPreferred(name, location);}
    public String getOtherDriver(String except_name, String location){ return user.getOtherDriver(except_name, location);}
    public Boolean setDriver(String username, Integer val){ return user.setDriver(username, val);}
}
