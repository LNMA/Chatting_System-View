package com.louay.projects.view.service.group;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class SwitchToGroup extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session.getAttribute("username") == null ) {
            response.sendRedirect(request.getContextPath()+"\\signin\\login.jsp");
        }

        String idGroup = request.getParameter("idGroup");
        session.setAttribute("idGroup", idGroup);
        String memberType = request.getParameter("memberType");
        session.setAttribute("memberType", memberType);

        response.sendRedirect(request.getContextPath() + "\\group\\group-switch.jsp");

    }
}
