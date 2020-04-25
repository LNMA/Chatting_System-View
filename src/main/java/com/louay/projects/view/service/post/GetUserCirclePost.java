package com.louay.projects.view.service.post;

import com.louay.projects.controller.service.post.GetUserCirclePostController;
import com.louay.projects.model.chains.accounts.Client;
import com.louay.projects.model.chains.accounts.Users;
import com.louay.projects.model.chains.communications.Post;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.TreeSet;

public class GetUserCirclePost extends HttpServlet {
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
        Users users = this.context.getBean(Client.class);
        users.setUsername((String) session.getAttribute("username"));

        GetUserCirclePostController getUserCirclePostController =
                (GetUserCirclePostController) this.context.getBean("getUserCirclePost");


        TreeSet<Post> postTreeSet = getUserCirclePostController.getUserCirclesPost(users);

        request.setAttribute("userCirclePost", postTreeSet);

    }
}
