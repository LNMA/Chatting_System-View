package com.louay.projects.view.service.post;

import com.louay.projects.controller.service.client.GetUserTextPostController;
import com.louay.projects.model.chains.communications.AccountTextPost;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.LinkedHashSet;

public class GetUserTextPost extends HttpServlet {

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
        HttpSession session =request.getSession(false);
        if (session.getAttribute("username") == null){
            response.sendRedirect(request.getContextPath()+"\\signin\\login.jsp");
        }else {
            AccountTextPost accountTextPost = this.context.getBean(AccountTextPost.class);
            accountTextPost.setIdUsername((String) session.getAttribute("username"));
            GetUserTextPostController getUserTextPostController = (GetUserTextPostController) this.context.getBean("getUserTextPost");
            LinkedHashSet<AccountTextPost> linkedHashSet = getUserTextPostController.getUserTextPost(accountTextPost);
            response.setContentType("text/html;charset=UTF-8");
            request.setAttribute("userTextPost", linkedHashSet);
        }
    }
}
