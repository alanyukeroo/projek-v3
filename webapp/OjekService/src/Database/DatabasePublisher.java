package Database;

import javax.xml.ws.Endpoint;

public class DatabasePublisher {
    public static void main(String[] args){
        Endpoint.publish("http://localhost:8080/Ojek",new DatabaseImpl());
    }
}
