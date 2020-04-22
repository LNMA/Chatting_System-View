package com.louay.projects.view.service.message;

import com.louay.projects.controller.service.message.GetNotSeenMessageController;
import com.louay.projects.model.chains.accounts.Users;
import com.louay.projects.model.chains.communications.account.AccountMessage;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Set;

public class ViewListSentMessage extends HttpServlet {
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

        AccountMessage accountMessage = this.context.getBean(AccountMessage.class);
        Users sourceUser = accountMessage.getSourceUser();
        sourceUser.setUsername((String) session.getAttribute("username"));

        GetNotSeenMessageController notSeenMessageCont  =
                (GetNotSeenMessageController) this.context.getBean("getNotSeenMessageCont");

        Set<AccountMessage> accountMessageSet = notSeenMessageCont.getUsersAndNotSeenMessageBySender(accountMessage);


        request.setAttribute("notSeenSet", accountMessageSet);
    }

}
