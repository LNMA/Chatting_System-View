package com.louay.projects.view.service.register;

import com.louay.projects.controller.service.FindFriendByUsernameController;
import com.louay.projects.model.chains.users.Admin;
import com.louay.projects.model.chains.users.Users;
import com.louay.projects.model.chains.util.PictureDirection;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class Logout extends HttpServlet {

    private AnnotationConfigApplicationContext context;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        this.context = new AnnotationConfigApplicationContext();
        context.scan("com.louay.projects.model", "com.louay.projects.controller");
        context.refresh();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Users users = context.getBean(Admin.class);
        users.setUsername((String) req.getSession(false).getAttribute("username"));
        users.setPassword((String) req.getSession(false).getAttribute("password"));
        FindFriendByUsernameController friendByName = (FindFriendByUsernameController) context.getBean("findFriendByName");
        List<PictureDirection> list = friendByName.execute(users);
        friendByName.deleteImg(list);

        req.logout();
        req.getSession(false).removeAttribute("username");
        req.getSession(false).removeAttribute("password");
        req.getSession(false).invalidate();
        resp.sendRedirect("signin\\login.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Users logout.";
    }
}
