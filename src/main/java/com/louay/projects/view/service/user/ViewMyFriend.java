package com.louay.projects.view.service.user;

import com.louay.projects.controller.service.client.ViewMyFriendController;
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
import java.io.Serializable;

import java.util.Set;

public class ViewMyFriend extends HttpServlet implements Serializable {

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
        HttpSession session =request.getSession(false);
        if (session.getAttribute("username") == null){
            response.sendRedirect(request.getContextPath()+"\\signin\\login.jsp");
        }

        Users users = context.getBean(Client.class);

        users.setUsername((String) session.getAttribute("username"));

        ViewMyFriendController friendByName = (ViewMyFriendController) this.context.getBean("findFriendByName");
        Set<Users> set = friendByName.execute(users);

        request.setAttribute("pictureList", set);
    }
}
