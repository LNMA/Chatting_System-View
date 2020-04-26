package com.louay.projects.view.service.member;

import com.louay.projects.controller.service.member.AddGroupMemberController;
import com.louay.projects.model.chains.accounts.constant.AccountType;
import com.louay.projects.model.chains.member.constant.GroupMemberType;
import com.louay.projects.model.chains.member.group.GroupMembers;
import com.louay.projects.model.util.date.NowDate;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AddMemberGroup extends HttpServlet {
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
        if (session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "\\signin\\login.jsp");
        }

        String id = request.getParameter("strange");
        AccountType accountType = AccountType.valueOf(request.getParameter("type"));
        if (accountType.compareTo(AccountType.GROUP) == 0){

            AddGroupMemberController addGroupMemberController =
                    (AddGroupMemberController) this.context.getBean("addGroupMemberCont");

            GroupMembers groupMembers = this.context.getBean(GroupMembers.class);
            groupMembers.getGroup().setIdGroup(id);
            groupMembers.getFriendMember().setUsername((String) session.getAttribute("username"));
            groupMembers.setGroupMemberType(GroupMemberType.SLAVE.getMemberType());
            groupMembers.setFriendMemberSince(NowDate.getNowTimestamp());

            addGroupMemberController.addGroupMemberInvite(groupMembers);

        }

        if ("master".equalsIgnoreCase((String)session.getAttribute("memberType"))){
            response.sendRedirect(request.getContextPath() + "\\group\\group-members.jsp");

        }else {
            response.sendRedirect(request.getContextPath() + "\\group\\group-control.jsp");

        }
    }
}
