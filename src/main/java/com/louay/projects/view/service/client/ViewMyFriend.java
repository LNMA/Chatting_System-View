package com.louay.projects.view.service.client;

import com.louay.projects.controller.service.client.ViewMyFriendController;
import com.louay.projects.model.chains.users.Admin;
import com.louay.projects.model.chains.users.Users;
import com.louay.projects.model.chains.util.PictureBase64;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Calendar;
import java.util.List;

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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String usernameSession = (String) request.getSession(false).getAttribute("username");
        String passwordSession = (String) request.getSession(false).getAttribute("password");

        Calendar calendar = Calendar.getInstance();
        calendar.setTimeInMillis(request.getSession(false).getCreationTime());
        LocalDateTime sessionCreate = LocalDateTime.of(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH),
                calendar.get(Calendar.DAY_OF_MONTH), calendar.get(Calendar.HOUR), calendar.get(Calendar.MINUTE),
                calendar.get(Calendar.SECOND));

        if (usernameSession == null || passwordSession == null || (sessionCreate.plusMinutes(59).compareTo(LocalDateTime.now()) > 0)) {
            response.sendRedirect(request.getContextPath()+"\\signin\\login.jsp");
        }

        Users users = context.getBean(Admin.class);
        users.setUsername(usernameSession);
        users.setPassword(passwordSession);
        ViewMyFriendController friendByName = (ViewMyFriendController) this.context.getBean("findFriendByName");
        List<PictureBase64> list = friendByName.execute(users);

        request.setAttribute("pictureList", list);

        RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/client/friend.jsp");
        dispatcher.forward(request, response);
    }
}
