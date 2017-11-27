//package User;

import java.net.MalformedURLException;
import java.net.URL;
import javax.xml.namespace.QName;
import javax.xml.ws.BindingProvider;
import javax.xml.ws.Service;

public class Main {
    public static void main(String[] args) throws Exception {
        URL url = new URL("http://localhost:8080/Baru_war_exploded/soap/userimpl?wsdl");

        //1st argument service URI, refer to wsdl document above
        //2nd argument is service name, refer to wsdl document above
        QName qname = new QName("http://User/", "UserImplService");
        Service service = Service.create(url, qname);
        User.User hello = service.getPort(User.User.class);

        BindingProvider bindingProvider = (BindingProvider) hello;
        bindingProvider.getRequestContext().put(BindingProvider.ENDPOINT_ADDRESS_PROPERTY, "http://localhost:8080/Baru_war_exploded/soap/userimpl");
        if (hello.isDriver("pratama19")){
            System.out.println("iya");
        } else {
            System.out.println("bukan");
        }
//        System.out.println(hello.logout("6FADF896-D24A-4E41-8C09-643DBF192F9021509881565531"));
    }
}

