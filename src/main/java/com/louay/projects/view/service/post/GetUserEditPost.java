package com.louay.projects.view.service.post;

import com.louay.projects.controller.service.post.GetUserEditPostController;
import com.louay.projects.model.chains.accounts.Users;
import com.louay.projects.model.chains.communications.Post;
import com.louay.projects.model.chains.communications.account.AccountImgPost;
import com.louay.projects.model.chains.communications.account.AccountTextPost;
import com.louay.projects.model.chains.communications.constant.PostClassName;
import com.louay.projects.model.chains.communications.group.GroupImgPost;
import com.louay.projects.model.chains.communications.group.GroupTextPost;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Set;

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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "\\signin\\login.jsp");
        }

        PostClassName postClassName = PostClassName.valueOf(request.getParameter("postClassName"));
        String idPost = request.getParameter("idPost");

        Post post = null;
        if (postClassName == PostClassName.ACCOUNT_TEX_POST) {
            post = this.context.getBean(AccountTextPost.class);

        } else if (postClassName == PostClassName.ACCOUNT_IMG_POST){
            post = this.context.getBean(AccountImgPost.class);

        }else if (postClassName == PostClassName.GROUP_IMG_POST){
            post = this.context.getBean(GroupImgPost.class);

        }else if (postClassName == PostClassName.GROUP_TEXT_POST){
            post = this.context.getBean(GroupTextPost.class);

        }

        if (post != null) {
            post.setIdPost(Long.valueOf(idPost));
            Users users = post.getUser();
            users.setUsername((String) session.getAttribute("username"));
        }

        GetUserEditPostController getUserEditPost = (GetUserEditPostController) this.context.getBean("getUserEditPost");

        @SuppressWarnings(value = "unchecked")
        Set<Post> postSet = (Set<Post>) getUserEditPost.getUserPost(post, postClassName);

        request.setAttribute("editPostSet", postSet);
    }

}
