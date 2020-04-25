package com.louay.projects.view.service.member;

import com.louay.projects.controller.service.member.GetGroupInviteController;
import com.louay.projects.model.chains.member.group.GroupInvite;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

public class GetGroupInviteSent extends HttpServlet {
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
        if (session.getAttribute("username") == null || session.getAttribute("idGroup") == null) {
            response.sendRedirect(request.getContextPath() + "\\signin\\login.jsp");
        }

        GroupInvite invite = this.context.getBean(GroupInvite.class);
        invite.getSourceGroup().setIdGroup((String) session.getAttribute("idGroup"));

        GetGroupInviteController inviteController = (GetGroupInviteController) this.context.getBean("groupInviteCont");
        Map<Long, GroupInvite> groupInviteMap = inviteController.getGroupInviteAndTargetInfoByIdGroup(invite);

        request.setAttribute("groupInviteMap", groupInviteMap);
    }
}
