package com.louay.projects.view.service.client;

import com.louay.projects.controller.service.FindFriendByUsernameController;
import com.louay.projects.model.chains.users.Admin;
import com.louay.projects.model.chains.users.Users;
import com.louay.projects.model.chains.util.PictureDirection;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Calendar;
import java.util.List;

public class AddUsersFriendImgFile extends HttpServlet {

    private AnnotationConfigApplicationContext context;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        this.context = new AnnotationConfigApplicationContext();
        context.scan("com.louay.projects.model", "com.louay.projects.controller");
        context.refresh();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String usernameSession = (String) req.getSession(false).getAttribute("username");
        String passwordSession = (String) req.getSession(false).getAttribute("password");

        Calendar calendar = Calendar.getInstance();
        calendar.setTimeInMillis(req.getSession(false).getCreationTime());
        LocalDateTime sessionCreate = LocalDateTime.of(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH),
                calendar.get(Calendar.DAY_OF_MONTH), calendar.get(Calendar.HOUR), calendar.get(Calendar.MINUTE),
                calendar.get(Calendar.SECOND));

        if (usernameSession == null || passwordSession == null || (sessionCreate.plusMinutes(59).compareTo(LocalDateTime.now()) > 0)) {
            resp.sendRedirect("signin\\login.jsp");
        }

        Users users = context.getBean(Admin.class);
        users.setUsername(usernameSession);
        users.setPassword(passwordSession);
        FindFriendByUsernameController friendByName = (FindFriendByUsernameController) context.getBean("findFriendByName");
        List<PictureDirection> list = friendByName.execute(users);

        resp.setContentType("image");

        HttpSession httpSession = req.getSession(false);
        httpSession.setAttribute("friendList", list);


        resp.sendRedirect("client\\friend.jsp");
    }
}
