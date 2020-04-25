package com.louay.projects.view.service.post;

import com.louay.projects.controller.service.post.DeleteUserPostController;
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
        }

            PostClassName postClassName = PostClassName.valueOf(request.getParameter("postClassName"));
            String idPost = request.getParameter("idPost");

            Post post = buildPost(postClassName, Long.valueOf(idPost), request);

            DeleteUserPostController deleteUserPostController = (DeleteUserPostController) this.context.getBean("DeleteUserPost");
            deleteUserPostController.deletePost(post, postClassName);

            if (postClassName == PostClassName.GROUP_IMG_POST || postClassName == PostClassName.GROUP_TEXT_POST){
                response.sendRedirect(request.getContextPath() + "\\group\\group-switch.jsp");

            }else if (postClassName == PostClassName.ACCOUNT_TEX_POST || postClassName == PostClassName.ACCOUNT_IMG_POST){
                response.sendRedirect(request.getContextPath()+"\\client\\home-client.jsp");

            }else {
                throw new UnsupportedOperationException("Unsupported redirect postClassName.");
            }

        }

        private Post buildPost(PostClassName postClassName, Long idPost, HttpServletRequest request){
            Post post;
            HttpSession session = request.getSession(false);

            if (postClassName == PostClassName.ACCOUNT_TEX_POST) {
                post = this.context.getBean(AccountTextPost.class);
                post.getUser().setUsername((String) session.getAttribute("username"));

            } else if (postClassName == PostClassName.ACCOUNT_IMG_POST) {
                post = this.context.getBean(AccountImgPost.class);
                post.getUser().setUsername((String) session.getAttribute("username"));

            }else if (postClassName == PostClassName.GROUP_TEXT_POST) {
                post = this.context.getBean(GroupTextPost.class);
                ((GroupTextPost)post).getGroups().setIdGroup((String) session.getAttribute("idGroup"));

            } else if (postClassName == PostClassName.GROUP_IMG_POST) {
                post = this.context.getBean(GroupImgPost.class);
                ((GroupImgPost)post).getGroups().setIdGroup((String) session.getAttribute("idGroup"));

            } else {
                throw new UnsupportedOperationException("unsupported operation.");

            }

            post.setIdPost(idPost);
            return post;
        }

}
