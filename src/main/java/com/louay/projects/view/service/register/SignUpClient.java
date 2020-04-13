package com.louay.projects.view.service.register;

import com.louay.projects.controller.service.SignUpClientController;
import com.louay.projects.controller.service.impl.SignUpClientControllerImpl;
import com.louay.projects.model.chains.users.Client;
import com.louay.projects.model.constants.UserType;
import com.louay.projects.model.util.date.NowDate;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;


import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class SignUpClient extends HttpServlet {

    private AnnotationConfigApplicationContext context;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        this.context = new AnnotationConfigApplicationContext();
        context.scan("com.louay.projects.model", "com.louay.projects.controller");
        context.refresh();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String fName = req.getParameter("firstName");
        String lName = req.getParameter("lastName");
        String gender = req.getParameter("gender");
        java.sql.Date birthday = java.sql.Date.valueOf(req.getParameter("birthday"));
        String telephone = req.getParameter("telephone");
        String email = req.getParameter("email");
        String country = req.getParameter("country");
        String state = req.getParameter("state");
        String address = req.getParameter("address");

        if (username == null || password == null || fName == null || lName == null || gender == null || birthday == null
                || telephone == null || email == null || country == null) {
            resp.sendRedirect("signup\\signupbd.html");

        } else {

            Client user = this.context.getBean(Client.class);
            user.setUsername(username.toLowerCase());
            user.setPassword(password);
            user.setDateCreate(NowDate.getNowTimestamp());
            user.setAccountPermission(UserType.CLIENT.getType());
            user.setFirstName(fName);
            user.setLastName(lName);
            user.setGender(gender);
            user.setBirthday(birthday);
            user.setAge(user.getAgeFromBirthday());
            user.setTelephone(telephone);
            user.setEmail(email);
            user.setCountry(country);
            user.setState(state);
            user.setAddress(address);

            SignUpClientController controller = (SignUpClientControllerImpl) this.context.getBean("signUpControl");

            boolean isFine = controller.execute(user);

            if (isFine) {
                resp.sendRedirect("signup\\signupsccs.html");
            } else {
                resp.sendRedirect("signup\\signupbd.html");
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Sign up client users";
    }
}
