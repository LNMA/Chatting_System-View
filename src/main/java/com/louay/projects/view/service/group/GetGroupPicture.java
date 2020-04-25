package com.louay.projects.view.service.group;

import com.louay.projects.controller.service.client.GetMyImgController;
import com.louay.projects.model.chains.accounts.Admin;
import com.louay.projects.model.chains.accounts.Users;
import com.louay.projects.model.chains.accounts.group.Groups;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Set;

public class GetGroupPicture extends HttpServlet {

    private AnnotationConfigApplicationContext context;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        this.context = new AnnotationConfigApplicationContext();
        context.scan("com.louay.projects.model", "com.louay.projects.controller");
        context.refresh();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session.getAttribute("username") == null || session.getAttribute("idGroup") == null) {
            response.sendRedirect(request.getContextPath() + "\\signin\\login.jsp");
        }

        String idGroup = (String) session.getAttribute("idGroup");

        Groups groups = this.context.getBean(Groups.class);
        groups.setIdGroup(idGroup);

        GetMyImgController getMyImgController = (GetMyImgController) this.context.getBean("getMyImg");

        Set<Groups> img = getMyImgController.getGroupPhoto(groups);

        byte[] imgByte = null;
        try {
            int size = (int) img.iterator().next().getPicture().length();
            imgByte = img.iterator().next().getPicture().getBytes(1, size);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.setContentType("image");
        if (imgByte != null) {
            response.setContentLength(imgByte.length);
            response.getOutputStream().write(imgByte);
            response.getOutputStream().flush();
            response.getOutputStream().close();
        }
    }

}
