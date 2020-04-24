package com.louay.projects.view.service.group;

import com.louay.projects.model.chains.accounts.group.Groups;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class CreateGroup extends HttpServlet {
    private AnnotationConfigApplicationContext context;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        this.context = new AnnotationConfigApplicationContext();
        context.scan("com.louay.projects.model", "com.louay.projects.controller");
        context.refresh();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "\\signin\\login.jsp");
        }
        String idGroup = request.getParameter("idGroup");
        String privacy = request.getParameter("privacy");
        String activity = request.getParameter("activity");

        Groups group = this.context.getBean(Groups.class);
        group.setIdGroup(idGroup);
        group.setGroupPrivacy(privacy);
        group.setGroupActivity(activity);


    }
}
