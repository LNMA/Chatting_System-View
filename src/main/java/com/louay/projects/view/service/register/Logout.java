package com.louay.projects.view.service.register;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class Logout extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.logout();
        request.getSession(false).removeAttribute("username");
        request.getSession(false).removeAttribute("password");
        request.getSession(false).invalidate();
        response.sendRedirect(request.getContextPath()+"\\signin\\login.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Users logout.";
    }
}
