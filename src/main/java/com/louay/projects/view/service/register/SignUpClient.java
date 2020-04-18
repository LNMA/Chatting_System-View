package com.louay.projects.view.service.register;


import com.louay.projects.controller.service.register.SignUpClientController;

import com.louay.projects.model.chains.accounts.Client;
import com.louay.projects.model.chains.accounts.constant.UserType;
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fName = request.getParameter("firstName");
        String lName = request.getParameter("lastName");
        String gender = request.getParameter("gender");
        java.sql.Date birthday = java.sql.Date.valueOf(request.getParameter("birthday"));
        String telephone = request.getParameter("telephone");
        String email = request.getParameter("email");
        String country = request.getParameter("country");
        String state = request.getParameter("state");
        String address = request.getParameter("address");

        if (username == null || password == null || fName == null || lName == null || gender == null || birthday == null
                || telephone == null || email == null || country == null) {
            response.sendRedirect("signup\\signupbd.html");

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

            SignUpClientController controller = (SignUpClientController) this.context.getBean("signUpControl");

            boolean isFine = controller.execute(user);

            if (isFine) {
                response.sendRedirect(request.getContextPath()+"\\signup\\signupsccs.html");
            } else {
                response.sendRedirect(request.getContextPath()+"\\signup\\signupbd.html");
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Sign up client users";
    }
}
