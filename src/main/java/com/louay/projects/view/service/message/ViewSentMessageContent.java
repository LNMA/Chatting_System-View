package com.louay.projects.view.service.message;

import com.louay.projects.controller.service.message.GetMessageContentController;
import com.louay.projects.controller.service.message.GetNotSeenMessageController;
import com.louay.projects.model.chains.accounts.Client;
import com.louay.projects.model.chains.communications.account.AccountMessage;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Set;
import java.util.TreeSet;

public class ViewSentMessageContent extends HttpServlet {
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
        if (session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath()+"\\signin\\login.jsp");
        }

        String target = request.getParameter("receiveUser");

        AccountMessage accountMessage = this.context.getBean(AccountMessage.class);
        Client targetUser = accountMessage.getTargetUser();
        targetUser.setUsername(target);
        Client sourceUser = accountMessage.getSourceUser();
        sourceUser.setUsername((String) session.getAttribute("username"));

        GetNotSeenMessageController notSeenMessageCont  =
                (GetNotSeenMessageController) this.context.getBean("getNotSeenMessageCont");

        Set<AccountMessage> accountMessageSet = notSeenMessageCont.getUsersAndNotSeenMessageBySenderAndReceiver(accountMessage);

        GetMessageContentController controller = (GetMessageContentController) this.context.getBean("getMessage");
        TreeSet<AccountMessage> messageTreeSet = controller.getSendMessages(accountMessage);

        RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/client/message-sent.jsp");

        request.setAttribute("messageTree", messageTreeSet);
        request.setAttribute("target", target);
        request.setAttribute("numOfNotSeen", accountMessageSet);

        dispatcher.forward(request, response);
    }
}
