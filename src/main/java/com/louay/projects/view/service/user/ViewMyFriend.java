package com.louay.projects.view.service.user;

import com.louay.projects.controller.service.member.GetUserFriendController;
import com.louay.projects.model.chains.member.account.UserFriend;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.Serializable;

import java.util.Map;

public class ViewMyFriend extends HttpServlet implements Serializable {

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
        }

        GetUserFriendController friendByName = (GetUserFriendController) this.context.getBean("userFriendMemberCont");
        Map<Long, UserFriend> userFriendMap =
                friendByName.getUserFriendMemberAndInfoByUsername(buildUserFriend(request));

        request.setAttribute("userFriendMap", userFriendMap);
    }

    private UserFriend buildUserFriend(HttpServletRequest request){
        HttpSession session =request.getSession(false);
        UserFriend userFriend = context.getBean(UserFriend.class);

        userFriend.getUser().setUsername((String) session.getAttribute("username"));

        return userFriend;
    }
}
