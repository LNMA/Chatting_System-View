package com.louay.projects.view.service.post;

import com.louay.projects.controller.service.post.EditUserTextPostController;
import com.louay.projects.model.chains.accounts.Users;
import com.louay.projects.model.chains.communications.Post;
import com.louay.projects.model.chains.communications.account.AccountTextPost;
import com.louay.projects.model.chains.communications.constant.PostClassName;
import com.louay.projects.model.chains.communications.group.GroupTextPost;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class EditUserTextPost extends HttpServlet {
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

        String idPost = request.getParameter("idPost");
        PostClassName postClassName = PostClassName.valueOf(request.getParameter("postClassName"));
        StringBuilder newPost = new StringBuilder(request.getParameter("post"));

        Post post = initPost(postClassName, newPost);
        post.setIdPost(Long.valueOf(idPost));
        Users users = post.getUser();
        users.setUsername((String) session.getAttribute("username"));

        EditUserTextPostController editUserPostController = (EditUserTextPostController) this.context.getBean("editUserTextPost");
        editUserPostController.editTextPost(postClassName, post);

        response.sendRedirect(request.getContextPath()+"\\client\\home-client.jsp");
    }

    private Post initPost(PostClassName postClassName, StringBuilder newPost){
        Post post;
        if (postClassName == PostClassName.ACCOUNT_TEX_POST) {
            post = this.context.getBean(AccountTextPost.class);
            ((AccountTextPost) post).setPostStringBuilder(newPost);

        } else if (postClassName == PostClassName.GROUP_TEXT_POST) {
            post = this.context.getBean(GroupTextPost.class);
            ((GroupTextPost) post).setPostStringBuilder(newPost);
        } else {
            throw new UnsupportedOperationException("only edit text post are allow.");
        }
        return post;
    }
}
