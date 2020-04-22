package com.louay.projects.view.service.member;

import com.louay.projects.controller.service.member.AddRequestController;
import com.louay.projects.model.chains.accounts.Users;
import com.louay.projects.model.chains.accounts.constant.AccountType;
import com.louay.projects.model.chains.accounts.group.Groups;
import com.louay.projects.model.chains.member.Request;
import com.louay.projects.model.chains.member.account.FriendRequest;
import com.louay.projects.model.chains.member.group.GroupRequest;
import com.louay.projects.model.util.date.NowDate;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AddRequest extends HttpServlet {
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

        String id = request.getParameter("id");
        AccountType accountType = AccountType.valueOf(request.getParameter("type"));

        Request requestMember = null;

        if (accountType == AccountType.GROUP){
            requestMember = this.context.getBean(GroupRequest.class);
            GroupRequest groupRequest = (GroupRequest) requestMember;
            groupRequest.getSourceGroup().setIdGroup(id);
            groupRequest.getTargetAccount().setUsername((String) session.getAttribute("username"));
            groupRequest.setRequestDate(NowDate.getNowTimestamp());

        }else if (accountType == AccountType.USER){
            requestMember = this.context.getBean(FriendRequest.class);
            FriendRequest friendRequest = (FriendRequest) requestMember;
            friendRequest.getSourceAccount().setUsername((String) session.getAttribute("username"));
            friendRequest.getTargetAccount().setUsername(id);
            friendRequest.setRequestDate(NowDate.getNowTimestamp());

        }

        AddRequestController requestController = (AddRequestController) this.context.getBean("addRequestCont");
        requestController.addRequest(requestMember);

        response.sendRedirect(request.getContextPath() + "\\client\\request-user-sent.jsp");
    }
}
