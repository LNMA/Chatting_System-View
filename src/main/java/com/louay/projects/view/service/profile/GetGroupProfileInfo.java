package com.louay.projects.view.service.profile;

import com.louay.projects.controller.service.profile.GroupProfileController;
import com.louay.projects.model.chains.accounts.group.Groups;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Set;

public class GetGroupProfileInfo extends HttpServlet {
    private AnnotationConfigApplicationContext context;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        this.context = new AnnotationConfigApplicationContext();
        context.scan("com.louay.projects.model", "com.louay.projects.controller");
        context.refresh();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session.getAttribute("username") == null || session.getAttribute("idGroup") == null) {
            response.sendRedirect(request.getContextPath() + "\\signin\\login.jsp");
        }

        Groups groups = this.context.getBean(Groups.class);
        groups.setIdGroup((String) session.getAttribute("idGroup"));

        GroupProfileController profileController =
                (GroupProfileController) this.context.getBean("groupProfileInfoCont");

        Set<Groups> groupsSet = profileController.getGroupInfo(groups);

        request.setAttribute("groupsSet", groupsSet);
    }
}
