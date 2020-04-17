package com.louay.projects.view.service.post;

import com.louay.projects.model.chains.communications.PostClassName;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class GetUserEditPost extends HttpServlet {
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

        PostClassName postClassName = PostClassName.valueOf(request.getParameter("postClassName"));
        String idPost = request.getParameter("idPost");

        if (postClassName == PostClassName.ACCOUNT_TEX_POST) {

        } else if (postClassName == PostClassName.ACCOUNT_IMG_POST){

        }else if (postClassName == PostClassName.GROUP_IMG_POST){

        }else if (postClassName == PostClassName.GROUP_TEXT_POST){

        }

    }

}
