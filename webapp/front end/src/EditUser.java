import ws.UserManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.*;

//@WebServlet(name = "EditUser", urlPatterns = {"/edituser"})
@MultipartConfig
public class EditUser extends HttpServlet{
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        String username = request.getParameter("username");
        String full_name = request.getParameter("name");
        String phone_number = request.getParameter("phone");
        String token = request.getParameter("token");
        String driver = request.getParameter("driver_status");

        UserManager userManager = new UserManager();
//        PrintWriter writer = response.getWriter();
        Part filePart = request.getPart("img-file-addr");
        String fileName = filePart.getSubmittedFileName();
        if(fileName != ""){
            int dot = fileName.lastIndexOf('.');
            String extension = fileName.substring(dot);
            String filePath = "../docroot/img/"+username+extension;
            OutputStream out = new FileOutputStream(filePath);
            InputStream filecontent = filePart.getInputStream();
            final byte[] bytes = new byte[1024];

            int read;
            while((read = filecontent.read(bytes)) != -1){
                out.write(bytes, 0, read);
            }

//        writer.println("Created");
            out.close();
            filecontent.close();
//        writer.close();
            userManager.setImage(username, "../img/" + username + extension);
        }

        Boolean bool_name = userManager.setName(username,full_name);
        Boolean bool_phone_number = userManager.setPhone(username,phone_number);
        if(driver == null){
            driver = "0";
        } else {
            driver = "1";
        }
        Boolean bool_driver = userManager.setDriver(username, Integer.parseInt(driver));

        if(bool_driver && bool_name && bool_phone_number){
            response.sendRedirect("profile.jsp?token=" + token + "&username=" + username);
        } else {
            response.sendRedirect("editprof.jsp?token=" + token + "&username=" + username);
        }
    }
}
