package com.louay.projects.view.service.register;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class LogoutGroup extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        request.getSession(false).removeAttribute("idGroup");
        request.getSession(false).removeAttribute("memberType");

        response.sendRedirect(request.getContextPath()+"\\signin\\login.jsp");

    }
}
