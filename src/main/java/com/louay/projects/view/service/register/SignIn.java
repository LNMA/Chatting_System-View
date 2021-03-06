package com.louay.projects.view.service.register;


import com.louay.projects.controller.service.register.SignInController;
import com.louay.projects.model.chains.accounts.Admin;
import com.louay.projects.model.chains.accounts.Users;
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username").toLowerCase();
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");

        Users users = context.getBean(Admin.class);
        users.setUsername(username);
        users.setPassword(password);

        SignInController signInController = (SignInController) context.getBean("isSignUp");
        boolean isSignUp = signInController.isSignUp(users);

        HttpSession session = request.getSession();
        if (isSignUp){
            if (rememberMe != null){
                if ("remember".equals(rememberMe)){
                    Cookie usernameCookie = new Cookie("username", username);
                    response.addCookie(usernameCookie);
                    Cookie passwordCookie = new Cookie("password", password);
                    response.addCookie(passwordCookie);
                }
            }
            session.setAttribute("username", username);
            session.setAttribute("password", password);
            session.setAttribute("isSign", null);

            response.sendRedirect(request.getContextPath()+"\\signin\\login.jsp");

        }else {
            session.setAttribute("isSign", false);
            response.sendRedirect(request.getContextPath()+"\\signin\\login.jsp");
        }
    }



    @Override
    public String getServletInfo() {
        return "Sign in users";
    }
}

