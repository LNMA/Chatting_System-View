package com.louay.projects.view.service.profile;

import com.louay.projects.controller.service.profile.UserProfileController;
import com.louay.projects.model.chains.accounts.Client;
import com.louay.projects.model.chains.accounts.Users;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Set;

public class GetUserProfileInfo extends HttpServlet {
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
        if (session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "\\signin\\login.jsp");
        }
        String username = (String) session.getAttribute("username");
        Users users = this.context.getBean(Client.class);
        users.setUsername(username);

        UserProfileController profileController =
                (UserProfileController) this.context.getBean("userProfileInfoCont");

        Set<Users> usersSet =profileController.getUserInfo(users);

        request.setAttribute("accountDetail", usersSet);
    }
}
