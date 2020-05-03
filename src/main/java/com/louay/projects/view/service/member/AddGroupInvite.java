package com.louay.projects.view.service.member;

import com.louay.projects.controller.service.member.AddGroupInviteController;
import com.louay.projects.model.chains.member.group.GroupInvite;
import com.louay.projects.model.util.date.NowDate;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AddGroupInvite extends HttpServlet {
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
        HttpSession session = request.getSession(false);
        if (session.getAttribute("username") == null || session.getAttribute("idGroup") == null) {
            response.sendRedirect(request.getContextPath() + "\\signin\\login.jsp");
        }

        String id = request.getParameter("id");
        GroupInvite invite = this.context.getBean(GroupInvite.class);
        invite.getSourceGroup().setIdGroup((String) session.getAttribute("idGroup"));
        invite.getTargetAccount().setUsername(id);
        invite.setRequestDate(NowDate.getNowTimestamp());

        AddGroupInviteController addGroupInviteController =
                (AddGroupInviteController) this.context.getBean("addGroupInviteCont");

        addGroupInviteController.addGroupInvite(invite);

        if ("master".equalsIgnoreCase((String)session.getAttribute("memberType"))){
            response.sendRedirect(request.getContextPath() + "\\group\\group-invite-sent.jsp");

        }else {
            response.sendRedirect(request.getContextPath() + "\\group\\group-invite-sent.jsp");

        }
    }
}
