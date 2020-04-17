package com.louay.projects.view.service.post;

import com.louay.projects.controller.service.client.DeleteUserPostController;
import com.louay.projects.model.chains.communications.Post;
import com.louay.projects.model.chains.communications.PostClassName;
import com.louay.projects.model.chains.communications.account.AccountImgPost;
import com.louay.projects.model.chains.communications.account.AccountTextPost;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class DeleteUserPost extends HttpServlet {

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
        } else {
            PostClassName postClassName = PostClassName.valueOf(request.getParameter("postClassName"));
            String idPost = request.getParameter("idPost");

            Post post = null;
            if (postClassName == PostClassName.ACCOUNT_TEX_POST) {
                post = this.context.getBean(AccountTextPost.class);
            } else if (postClassName == PostClassName.ACCOUNT_IMG_POST) {
                post = this.context.getBean(AccountImgPost.class);
            }

            if (post != null) {
                post.setIdPost(Long.valueOf(idPost));
                post.setUsername((String) session.getAttribute("username"));

            }
            DeleteUserPostController deleteUserPostController = (DeleteUserPostController) this.context.getBean("DeleteUserPost");
            deleteUserPostController.deletePost(post, postClassName);

            response.sendRedirect(request.getContextPath()+"\\client\\home-client.jsp");
        }
    }
}
