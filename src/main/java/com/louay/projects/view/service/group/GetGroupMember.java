package com.louay.projects.view.service.group;

import com.louay.projects.controller.service.member.GetGroupMemberController;
import com.louay.projects.model.chains.accounts.group.Groups;
import com.louay.projects.model.chains.member.group.GroupMembers;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

public class GetGroupMember extends HttpServlet {

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

        Groups groups = context.getBean(Groups.class);

        groups.setIdGroup((String) session.getAttribute("idGroup"));

        GetGroupMemberController memberController = (GetGroupMemberController) this.context.getBean("groupMemberCont");
        Map<Long, GroupMembers> groupMembersMap = memberController.getGroupMemberAndInfo(groups);

        request.setAttribute("groupMembersMap", groupMembersMap);
    }

}
