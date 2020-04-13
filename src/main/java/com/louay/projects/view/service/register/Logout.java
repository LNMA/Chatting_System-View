package com.louay.projects.view.service.register;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class Logout extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

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
