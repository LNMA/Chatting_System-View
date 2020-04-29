package com.louay.projects.view.service.message;

import com.louay.projects.controller.service.member.GetUserRequestController;
import com.louay.projects.controller.service.message.GetNotSeenMessageController;
import com.louay.projects.model.chains.accounts.Users;
import com.louay.projects.model.chains.communications.account.AccountMessage;
import com.louay.projects.model.chains.member.account.FriendRequest;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class ViewAllNotSeenMessage extends HttpServlet {
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
            response.sendRedirect(request.getContextPath()+"\\signin\\login.jsp");
        }

        GetNotSeenMessageController notSeenMessageCont  =
                (GetNotSeenMessageController) this.context.getBean("getNotSeenMessageCont");

        GetUserRequestController requestController =
                (GetUserRequestController) this.context.getBean("userRequestCont");


        int numRequest = requestController.numberOfReceiveRequest(buildFriendRequest(request));


        int numMessage = notSeenMessageCont.getNumberOfAllNotSeenMessageByReceiver(buildAccountMessage(request));

        request.setAttribute("messageNotSeen", numMessage);
        request.setAttribute("requestReceive" , numRequest);
    }

    private AccountMessage buildAccountMessage(HttpServletRequest request){
        HttpSession session = request.getSession(false);
        AccountMessage accountMessage = this.context.getBean(AccountMessage.class);
        Users targetUser = accountMessage.getTargetUser();
        targetUser.setUsername((String) session.getAttribute("username"));

        return accountMessage;
    }

    private FriendRequest buildFriendRequest(HttpServletRequest request){
        HttpSession session = request.getSession(false);
        FriendRequest friendRequest = this.context.getBean(FriendRequest.class);
        friendRequest.getTargetAccount().setUsername((String) session.getAttribute("username"));

        return friendRequest;
    }
}
