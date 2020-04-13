package com.louay.projects.view.service.client;

import com.louay.projects.controller.service.GetMyImgController;
import com.louay.projects.model.chains.communications.AccountPicture;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Set;

public class GetMyPhoto extends HttpServlet {

    private AnnotationConfigApplicationContext context;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        this.context = new AnnotationConfigApplicationContext();
        context.scan("com.louay.projects.model", "com.louay.projects.controller");
        context.refresh();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session =req.getSession(false);
        if (session.getAttribute("username") == null){
            resp.sendRedirect("signin\\login.jsp");
        }else {
            String username = (String) session.getAttribute("username");
            AccountPicture user = context.getBean(AccountPicture.class);
            user.setUsername(username);
            GetMyImgController getMyImgController = (GetMyImgController) context.getBean("getMyImg");
            Set<AccountPicture> img = getMyImgController.getUserPhoto(user);

            byte [] imgByte = null;
            try {
                int size = (int)img.iterator().next().getPicture().length();
                imgByte = img.iterator().next().getPicture().getBytes(1, size);
            } catch (SQLException e) {
                e.printStackTrace();
            }

            resp.setContentType("image");
            if (imgByte != null ) {
                resp.setContentLength(imgByte.length);
                resp.getOutputStream().write(imgByte);
                resp.getOutputStream().flush();
                resp.getOutputStream().close();
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "View users image";
    }
}
