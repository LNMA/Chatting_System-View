package com.louay.projects.view.service.post;

import com.louay.projects.controller.service.post.AddUserTextPostController;
import com.louay.projects.model.chains.accounts.Users;
import com.louay.projects.model.chains.communications.account.AccountTextPost;
import com.louay.projects.model.util.date.NowDate;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AddUserTextPost extends HttpServlet {

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

        StringBuilder post = new StringBuilder(request.getParameter("post"));
        if (post.length() < 1) {
            response.sendRedirect(request.getContextPath() + "\\signin\\login.jsp");
        }

        AddUserTextPostController addUserTextPost = (AddUserTextPostController) this.context.getBean("addUserTextPost");
        addUserTextPost.insertUserPost(buildAccountTextPost(request, post));

        response.sendRedirect(request.getContextPath() + "\\client\\home-client.jsp");
    }

    private AccountTextPost buildAccountTextPost(HttpServletRequest request, StringBuilder post){
        AccountTextPost accountTextPost = this.context.getBean(AccountTextPost.class);
        HttpSession session = request.getSession(false);

        Users users = accountTextPost.getUser();
        users.setUsername((String) session.getAttribute("username"));
        accountTextPost.setPost(post.toString());
        accountTextPost.setDatePost(NowDate.getNowTimestamp());
        return accountTextPost;
    }
}
