package com.louay.projects.view.service.member;

import com.louay.projects.controller.service.member.GetUserRequestController;
import com.louay.projects.model.chains.accounts.Users;
import com.louay.projects.model.chains.member.Request;
import com.louay.projects.model.chains.member.account.FriendRequest;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;
import java.util.TreeMap;

public class GetRequestReceive extends HttpServlet {
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
        HttpSession session = request.getSession(false);
        if (session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "\\signin\\login.jsp");
        }

        GetUserRequestController requestController = (GetUserRequestController) this.context.getBean("userRequestCont");

        FriendRequest friendRequest = this.context.getBean(FriendRequest.class);
        friendRequest.getTargetAccount().setUsername((String) session.getAttribute("username"));

        TreeMap<Long, Request> requestMap = requestController.getSentRequestAndPicByReceiver(friendRequest);

        request.setAttribute("requestMap", requestMap);
    }
}
