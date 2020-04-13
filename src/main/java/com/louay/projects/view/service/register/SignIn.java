package com.louay.projects.view.service.register;


import com.louay.projects.controller.service.SignInController;
import com.louay.projects.model.chains.users.Admin;
import com.louay.projects.model.chains.users.Users;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class SignIn extends HttpServlet {

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
        String username = req.getParameter("username").toLowerCase();
        String password = req.getParameter("password");
        String rememberMe = req.getParameter("rememberMe");

        Users users = context.getBean(Admin.class);
        users.setUsername(username);
        users.setPassword(password);

        SignInController signInController = (SignInController) context.getBean("isSignUp");
        boolean isSignUp = signInController.isSignUp(users);

        HttpSession session = req.getSession();
        if (isSignUp){
            if (rememberMe != null){
                if ("remember".equals(rememberMe)){
                    Cookie usernameCookie = new Cookie("username", username);
                    resp.addCookie(usernameCookie);
                    Cookie passwordCookie = new Cookie("password", password);
                    resp.addCookie(passwordCookie);
                }
            }
            session.setAttribute("username", username);
            session.setAttribute("password", password);
            session.setAttribute("isSign", null);

            resp.sendRedirect("signin\\login.jsp");
        }else {
            session.setAttribute("isSign", false);
            resp.sendRedirect("signin\\login.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Sign in users";
    }
}

