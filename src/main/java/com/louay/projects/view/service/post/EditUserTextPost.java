package com.louay.projects.view.service.post;

import com.louay.projects.controller.service.post.EditUserTextPostController;
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

        Post post = initPost(postClassName, newPost, request, Long.valueOf(idPost));

        EditUserTextPostController editUserPostController = (EditUserTextPostController) this.context.getBean("editUserTextPost");
        editUserPostController.editTextPost(postClassName, post);

        if (postClassName == PostClassName.GROUP_TEXT_POST) {
            response.sendRedirect(request.getContextPath() + "\\group\\group-switch.jsp");

        }else if (postClassName == PostClassName.ACCOUNT_TEX_POST){
            response.sendRedirect(request.getContextPath() + "\\client\\home-client.jsp");

        }else {
            throw new UnsupportedOperationException("Unsupported redirect postClassName.");
        }

    }

    private Post initPost(PostClassName postClassName, StringBuilder newPost, HttpServletRequest request, Long idPost) {
        Post post;

        if (postClassName == PostClassName.ACCOUNT_TEX_POST) {
            post = buildAccountTextPost(request, newPost, idPost);

        } else if (postClassName == PostClassName.GROUP_TEXT_POST) {
            post = buildGroupTextPost(request, newPost, idPost);

        } else {
            throw new UnsupportedOperationException("only edit text post are allow here.");
        }
        return post;
    }

    private AccountTextPost buildAccountTextPost(HttpServletRequest request, StringBuilder newPost, Long idPost) {
        AccountTextPost accountTextPost = this.context.getBean(AccountTextPost.class);
        HttpSession session = request.getSession(false);
        accountTextPost.setIdPost(idPost);
        accountTextPost.setPostStringBuilder(newPost);
        accountTextPost.getUser().setUsername((String) session.getAttribute("username"));

        return accountTextPost;
    }

    private GroupTextPost buildGroupTextPost(HttpServletRequest request, StringBuilder newPost, Long idPost) {
        GroupTextPost groupTextPost = this.context.getBean(GroupTextPost.class);
        HttpSession session = request.getSession(false);
        groupTextPost.setIdPost(idPost);
        groupTextPost.setPostStringBuilder(newPost);
        groupTextPost.getUser().setUsername((String) session.getAttribute("username"));
        groupTextPost.getGroups().setIdGroup((String) session.getAttribute("idGroup"));

        return groupTextPost;
    }
}
