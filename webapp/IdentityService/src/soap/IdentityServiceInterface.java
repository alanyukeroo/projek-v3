package soap;

import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;

@WebService
@SOAPBinding(style = SOAPBinding.Style.RPC)
public interface IdentityServiceInterface {
    @WebMethod
    public String login(String username, String password);
    @WebMethod
    public String logout(String token);
    @WebMethod
    public String register(String email, String username, String password);
    @WebMethod
    public String validate(String token);
}
