package com.louay.projects.view.service.member;

import com.louay.projects.controller.service.member.GetGroupInviteController;
import com.louay.projects.controller.service.member.GetGroupRequestController;
import com.louay.projects.model.chains.member.group.GroupInvite;
import com.louay.projects.model.chains.member.group.GroupRequest;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

public class GetGroupRequestReceive extends HttpServlet {
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
        if (session.getAttribute("username") == null || session.getAttribute("idGroup") == null) {
            response.sendRedirect(request.getContextPath() + "\\signin\\login.jsp");
        }

        GroupRequest groupRequest = this.context.getBean(GroupRequest.class);
        groupRequest.getSourceGroup().setIdGroup((String) session.getAttribute("idGroup"));

        GetGroupRequestController groupRequestController =
                (GetGroupRequestController) this.context.getBean("groupRequestCont");

        Map<Long, GroupRequest> groupRequestMap = groupRequestController.getGroupRequestAndInfoByIdGroup(groupRequest);

        request.setAttribute("groupRequestMap", groupRequestMap);
    }
}
