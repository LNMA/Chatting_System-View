package com.louay.projects.view.service.profile;


import com.louay.projects.controller.service.profile.UserProfileController;
import com.louay.projects.model.chains.accounts.Client;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.logging.Level;
import java.util.logging.Logger;

@MultipartConfig(
        maxFileSize = 16 * 1024 * 1024,
        maxRequestSize = 65 * 1024 * 1024,
        //TODO modify file path
        location = "C:\\Users\\Ryzen 5\\Documents\\IdeaProjects\\Chatting_System-View\\src\\main\\webapp\\data",
        fileSizeThreshold = 1024 * 1024
)
public class UpdateUserProfile extends HttpServlet {
    private AnnotationConfigApplicationContext context;

    private final static Logger LOGGER = Logger.getLogger(UpdateUserProfile.class.getCanonicalName());

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        this.context = new AnnotationConfigApplicationContext();
        context.scan("com.louay.projects.model", "com.louay.projects.controller");
        context.refresh();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "\\signin\\login.jsp");
        }
        String fieldCode = request.getParameter("fieldCode");
        int result;

        switch (fieldCode) {
            case "p0img1c":
                result = imgUpdateHandler(request, fieldCode);
                break;

            case "p1pass2c":
                result = passwordUpdateHandler(request, fieldCode);
                break;

            case "p2fName3c":
                result = firstNameUpdateHandler(request, fieldCode);
                break;

            case "p2lName4c":
                result = lastNameUpdateHandler(request, fieldCode);
                break;

            case "p2gender5c":
                result = genderUpdateHandler(request, fieldCode);
                break;

            case "p2birth6c":
                result = birthdayUpdateHandler(request, fieldCode);
                break;

            case "p2telephone7c":
                result = telephoneUpdateHandler(request, fieldCode);
                break;

            case "p2email8c":
                result = emailUpdateHandler(request, fieldCode);
                break;

            case "p2allAddress9c":
                result = fullAddressUpdateHandler(request, fieldCode);
                break;

            default:
                throw new UnsupportedOperationException("unsupported profile update.");
        }
        if (result < 1 ){
            throw new RuntimeException("something wrong while update process.");
        }
        response.sendRedirect(request.getContextPath() + "\\client\\home-client.jsp");
    }

    private int fullAddressUpdateHandler(HttpServletRequest request, String fieldCode) {
        HttpSession session = request.getSession(false);
        Client client = this.context.getBean(Client.class);
        client.setUsername((String) session.getAttribute("username"));

        final String country = request.getParameter("country");
        final String state = request.getParameter("state");
        final String address = request.getParameter("address");

        client.setCountry(country);
        client.setState(state);
        client.setAddress(address);

        UserProfileController profileController = (UserProfileController) this.context.getBean("userProfileInfoCont");
        return profileController.updateUserProfile(client, fieldCode);
    }

    private int emailUpdateHandler(HttpServletRequest request, String fieldCode) {
        HttpSession session = request.getSession(false);
        Client client = this.context.getBean(Client.class);
        client.setUsername((String) session.getAttribute("username"));

        final String email = request.getParameter("email");

        client.setEmail(email);

        UserProfileController profileController = (UserProfileController) this.context.getBean("userProfileInfoCont");
        return profileController.updateUserProfile(client, fieldCode);
    }

    private int telephoneUpdateHandler(HttpServletRequest request, String fieldCode) {
        HttpSession session = request.getSession(false);
        Client client = this.context.getBean(Client.class);
        client.setUsername((String) session.getAttribute("username"));

        final String telephone = request.getParameter("telephone");

        client.setTelephone(telephone);

        UserProfileController profileController = (UserProfileController) this.context.getBean("userProfileInfoCont");
        return profileController.updateUserProfile(client, fieldCode);
    }

    private int genderUpdateHandler(HttpServletRequest request, String fieldCode) {
        HttpSession session = request.getSession(false);
        Client client = this.context.getBean(Client.class);
        client.setUsername((String) session.getAttribute("username"));

        final String gender = request.getParameter("gender");

        client.setGender(gender);

        UserProfileController profileController = (UserProfileController) this.context.getBean("userProfileInfoCont");
        return profileController.updateUserProfile(client, fieldCode);
    }

    private int birthdayUpdateHandler(HttpServletRequest request, String fieldCode) {
        HttpSession session = request.getSession(false);
        Client client = this.context.getBean(Client.class);
        client.setUsername((String) session.getAttribute("username"));

        final java.sql.Date birthday = java.sql.Date.valueOf(request.getParameter("birthday"));

        client.setBirthday(birthday);

        UserProfileController profileController = (UserProfileController) this.context.getBean("userProfileInfoCont");
        return profileController.updateUserProfile(client, fieldCode);
    }

    private int lastNameUpdateHandler(HttpServletRequest request, String fieldCode) {
        HttpSession session = request.getSession(false);
        Client client = this.context.getBean(Client.class);
        client.setUsername((String) session.getAttribute("username"));

        final String lastName = request.getParameter("lastName");

        client.setLastName(lastName);

        UserProfileController profileController = (UserProfileController) this.context.getBean("userProfileInfoCont");
        return profileController.updateUserProfile(client, fieldCode);
    }

    private int firstNameUpdateHandler(HttpServletRequest request, String fieldCode) {
        HttpSession session = request.getSession(false);
        Client client = this.context.getBean(Client.class);
        client.setUsername((String) session.getAttribute("username"));

        final String firstName = request.getParameter("firstName");

        client.setFirstName(firstName);

        UserProfileController profileController = (UserProfileController) this.context.getBean("userProfileInfoCont");
        return profileController.updateUserProfile(client, fieldCode);
    }

    private int passwordUpdateHandler(HttpServletRequest request, String fieldCode) {
        HttpSession session = request.getSession(false);
        Client client = this.context.getBean(Client.class);
        client.setUsername((String) session.getAttribute("username"));

        final String oldPassword = request.getParameter("passwordOld");
        final String newPassword = request.getParameter("passwordNew");
        final String reNewPassword = request.getParameter("passwordReNew");

        UserProfileController profileController = (UserProfileController) this.context.getBean("userProfileInfoCont");
        return profileController.auxUpdateUserPassword(client, oldPassword, newPassword, reNewPassword, fieldCode);
    }

    private int imgUpdateHandler(HttpServletRequest request, String fieldCode) throws IOException, ServletException {
        HttpSession session = request.getSession(false);

        final Part filePart = request.getPart("filename");
        final String fileName = getFileName(filePart);
        int result = 0;

        if (filePart.getContentType().contains("image")) {

            try (InputStream in = filePart.getInputStream()) {

                final byte[] bytes = new byte[(int) filePart.getSize()];
                int byteRead;

                int i = 0;
                while ((byteRead = in.read()) != -1) {
                    bytes[i] = (byte) byteRead;
                    i++;
                }
                in.close();

                UserProfileController profileController = (UserProfileController) this.context.getBean("userProfileInfoCont");
                result = profileController.auxUpdateUserImg((String) session.getAttribute("username"), fileName, bytes, fieldCode);

            } catch (FileNotFoundException fne) {
                System.out.println(fne.getMessage());
            }
        }
        return result;
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
