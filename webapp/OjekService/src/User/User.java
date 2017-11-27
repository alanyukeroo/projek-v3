package User;
import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;
import javax.jws.soap.SOAPBinding.Style;

@WebService
@SOAPBinding(style = Style.RPC)
public interface User {
    @WebMethod String getName(String username);
    @WebMethod String getPhone(String username);
    @WebMethod String getEmail(String username);
    @WebMethod String getImage(String username);
    @WebMethod Boolean setDriver(String username, Integer val);
    @WebMethod Boolean isDriver(String username);
    @WebMethod Boolean addUser(String json);
    @WebMethod Boolean setName(String username, String name);
    @WebMethod Boolean setPhone(String username, String phone);
    @WebMethod Boolean setEmail(String username, String email);
    @WebMethod Boolean setPassword(String username, String password);
    @WebMethod Boolean setImage(String username, String image);
    @WebMethod String getAll(String username);
    @WebMethod String getPreferred(String name, String location);
    @WebMethod String getOtherDriver(String except_name, String location);
}