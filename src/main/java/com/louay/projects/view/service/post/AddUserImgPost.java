package com.louay.projects.view.service.post;


import com.louay.projects.controller.service.client.AddUserImgPostController;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import java.io.*;
import java.util.logging.Level;
import java.util.logging.Logger;

@MultipartConfig(
        maxFileSize = 16 * 1024 * 1024,
        maxRequestSize = 65 * 1024 * 1024,
        //TODO modify file path
        location = "C:\\Users\\Oday Amr\\Documents\\IdeaProjects\\Chatting_System-View\\src\\main\\webapp\\data",
        fileSizeThreshold = 1024 * 1024
)
public class AddUserImgPost extends HttpServlet {

    private final static Logger LOGGER = Logger.getLogger(AddUserImgPost.class.getCanonicalName());

    private AnnotationConfigApplicationContext context;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        this.context = new AnnotationConfigApplicationContext();
        context.scan("com.louay.projects.model", "com.louay.projects.controller");
        context.refresh();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session =request.getSession(false);
        if (session.getAttribute("username") == null){
            response.sendRedirect(request.getContextPath()+"\\signin\\login.jsp");
        }else {
            response.setContentType("text/html;charset=UTF-8");

            final Part filePart = request.getPart("filename");
            final String fileName = getFileName(filePart);

            if (filePart.getContentType().contains("image")) {
                System.out.println(filePart.getContentType());
                System.out.println(filePart.getSubmittedFileName());
                System.out.println(filePart.getHeaderNames());
                System.out.println(fileName);

                try (InputStream in = filePart.getInputStream()) {

                    final byte[] bytes = new byte[(int) filePart.getSize()];
                    int byteRead;

                    int i = 0;
                    while ((byteRead = in.read()) != -1) {
                        bytes[i] = (byte) byteRead;
                        i++;
                    }
                    in.close();

                    AddUserImgPostController addUserImgPostController = (AddUserImgPostController) this.context.getBean("addUserImgPost");
                    addUserImgPostController.addImgPost((String) request.getSession(false).getAttribute("username"), fileName, bytes);

                } catch (FileNotFoundException fne) {
                    System.out.println(fne.getMessage());
                }
            }
        }

        response.sendRedirect(request.getContextPath()+"\\client\\home-client.jsp");
    }

    private String getFileName(final Part part) {
        final String partHeader = part.getHeader("content-disposition");
        LOGGER.log(Level.INFO, "Part Header = {0}", partHeader);
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(
                        content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}
