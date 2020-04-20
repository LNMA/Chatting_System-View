package com.louay.projects.view.service.search;

import com.louay.projects.controller.service.search.SearchAccountGroupController;
import com.louay.projects.model.chains.accounts.Accounts;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Set;

public class SearchAccountGroup extends HttpServlet {
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
            response.sendRedirect(request.getContextPath() + "\\signin\\login.jsp");
        }

        String key = request.getParameter("keySearch");

        SearchAccountGroupController controller = (SearchAccountGroupController) this.context.getBean("searchAccountGroup");
        Set<Accounts> accountsSet = controller.getSearchResult(key);

        request.setAttribute("searchResult", accountsSet);
    }
}
