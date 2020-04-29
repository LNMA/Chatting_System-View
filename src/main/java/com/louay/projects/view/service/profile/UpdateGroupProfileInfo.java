package com.louay.projects.view.service.profile;

import com.louay.projects.controller.service.profile.GroupProfileController;
import com.louay.projects.model.chains.accounts.group.Groups;
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
public class UpdateGroupProfileInfo extends HttpServlet {
    private final static Logger LOGGER = Logger.getLogger(UpdateGroupProfileInfo.class.getCanonicalName());

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
        HttpSession session = request.getSession(false);
        if (session.getAttribute("username") == null || session.getAttribute("idGroup") == null) {
            response.sendRedirect(request.getContextPath() + "\\signin\\login.jsp");
        }

        String fieldCode = request.getParameter("fieldCode");
        int result;

        switch (fieldCode){
            case "pGroup0img1c":
                result = imgUpdateHandler(request, fieldCode);
                break;

            case "pGroup1privacy2c":
                result = privacyUpdateHandler(request, fieldCode);
                break;

            case "pGroup2Activity3c":
                result = activityUpdateHandler(request, fieldCode);
                break;

            default: throw new UnsupportedOperationException("unsupported profile update.");
        }
        if (result < 1 ){
            throw new RuntimeException("something wrong while update process.");
        }
        response.sendRedirect(request.getContextPath() + "\\group\\group-switch.jsp");
    }

    private int activityUpdateHandler(HttpServletRequest request, String fieldCode) {
        HttpSession session = request.getSession(false);
        Groups groups = this.context.getBean(Groups.class);
        groups.setIdGroup((String) session.getAttribute("idGroup"));

        final String activity = request.getParameter("activity");

        groups.setGroupActivity(activity);

        GroupProfileController profileController = (GroupProfileController) this.context.getBean("groupProfileInfoCont");
        return profileController.updateGroupProfile(groups, fieldCode);
    }

    private int privacyUpdateHandler(HttpServletRequest request, String fieldCode) {
        HttpSession session = request.getSession(false);
        Groups groups = this.context.getBean(Groups.class);
        groups.setIdGroup((String) session.getAttribute("idGroup"));

        final String privacy = request.getParameter("privacy");

        groups.setGroupPrivacy(privacy);

        GroupProfileController profileController = (GroupProfileController) this.context.getBean("groupProfileInfoCont");
        return profileController.updateGroupProfile(groups, fieldCode);
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

                GroupProfileController profileController = (GroupProfileController) this.context.getBean("groupProfileInfoCont");
                result = profileController.auxUpdateGroupImg((String) session.getAttribute("idGroup"), fileName, bytes, fieldCode);

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
