package com.louay.projects.view.service.search;

import com.louay.projects.controller.service.search.GetAccountDetailController;
import com.louay.projects.model.chains.accounts.Accounts;
import com.louay.projects.model.chains.accounts.Client;
import com.louay.projects.model.chains.accounts.constant.AccountType;
import com.louay.projects.model.chains.accounts.group.Groups;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Set;

public class ReviewAccount extends HttpServlet {
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
            response.sendRedirect(request.getContextPath() + "\\signin\\login.jsp");
        }

        String id = request.getParameter("strange");
        AccountType accountType = AccountType.valueOf(request.getParameter("type"));

        Accounts accounts = null;
        if (accountType == AccountType.USER){
            accounts = this.context.getBean(Client.class);
            ((Client)accounts).setUsername(id);
        }else if (accountType == AccountType.GROUP){
            accounts = this.context.getBean(Groups.class);
            ((Groups)accounts).setIdGroup(id);
        }

        GetAccountDetailController detailController = (GetAccountDetailController) this.context.getBean("getAccountDetail");

        @SuppressWarnings(value = "unchecked")
        Set<Accounts> accountsSet = (Set<Accounts>) detailController.execute(accounts);

        request.setAttribute("accountDetail", accountsSet);
    }
}
