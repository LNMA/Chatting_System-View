package com.louay.projects.view.service.message;

import com.louay.projects.controller.service.message.AddMessageUserController;
import com.louay.projects.model.chains.accounts.Users;
import com.louay.projects.model.chains.communications.account.AccountMessage;
import com.louay.projects.model.util.date.NowDate;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class SendMessage extends HttpServlet {
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
            response.sendRedirect(request.getContextPath()+"\\signin\\login.jsp");
        }
        String sender = (String) session.getAttribute("username");
        String receiver = request.getParameter("targetUser");
        StringBuilder message = new StringBuilder(request.getParameter("message"));

        AccountMessage accountMessage = this.context.getBean(AccountMessage.class);
        Users sourceUser = accountMessage.getSourceUser();
        sourceUser.setUsername(sender);
        Users targetUser = accountMessage.getTargetUser();
        targetUser.setUsername(receiver);
        accountMessage.setMessageStringBuilder(message);
        accountMessage.setSeen(false);
        accountMessage.setSentDate(NowDate.getNowTimestamp());

        AddMessageUserController addMessageUserController = (AddMessageUserController) this.context.getBean("addMessage");
        addMessageUserController.addMessage(accountMessage);

        response.sendRedirect(request.getContextPath()+"\\client\\message-sent.jsp");
    }
}
