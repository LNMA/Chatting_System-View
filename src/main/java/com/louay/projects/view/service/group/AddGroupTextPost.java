package com.louay.projects.view.service.group;

import com.louay.projects.controller.service.group.AddGroupPostController;
import com.louay.projects.model.chains.communications.group.GroupTextPost;
import com.louay.projects.model.util.date.NowDate;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AddGroupTextPost extends HttpServlet {
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
        if (session.getAttribute("username") == null || session.getAttribute("idGroup") == null) {
            response.sendRedirect(request.getContextPath() + "\\signin\\login.jsp");
        }
        StringBuilder post = new StringBuilder(request.getParameter("post"));
        if (post.length() < 1) {
            response.sendRedirect(request.getContextPath() + "\\group\\group-switch.jsp");
        }

        AddGroupPostController groupPostController = (AddGroupPostController) this.context.getBean("addGroupPostCont");
        groupPostController.addGroupTextPost(buildGroupTextPost(request, post));

        response.sendRedirect(request.getContextPath() + "\\group\\group-switch.jsp");
    }

    private GroupTextPost buildGroupTextPost(HttpServletRequest request, StringBuilder post){
        GroupTextPost groupTextPost = this.context.getBean(GroupTextPost.class);
        HttpSession session = request.getSession(false);

        groupTextPost.getGroups().setIdGroup((String) session.getAttribute("idGroup"));
        groupTextPost.getUser().setUsername((String) session.getAttribute("username"));
        groupTextPost.setPostStringBuilder(post);
        groupTextPost.setDatePost(NowDate.getNowTimestamp());

        return groupTextPost;
    }
}
