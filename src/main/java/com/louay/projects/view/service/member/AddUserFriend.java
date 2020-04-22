package com.louay.projects.view.service.member;

import com.louay.projects.controller.service.member.AddUserFriendController;
import com.louay.projects.model.chains.accounts.constant.AccountType;
import com.louay.projects.model.chains.member.account.UserFriend;
import com.louay.projects.model.util.date.NowDate;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AddUserFriend extends HttpServlet {
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

        String id = request.getParameter("strange");
        AccountType accountType = AccountType.valueOf(request.getParameter("type"));
        if (accountType.compareTo(AccountType.USER) == 0){

            AddUserFriendController friendController =
                    (AddUserFriendController) this.context.getBean("addUserFriendCont");

            UserFriend userFriend = this.context.getBean(UserFriend.class);
            userFriend.getUser().setUsername((String) session.getAttribute("username"));
            userFriend.getFriendMember().setUsername(id);
            userFriend.setFriendMemberSince(NowDate.getNowTimestamp());

            friendController.addUserFriend(userFriend);

        }

        response.sendRedirect(request.getContextPath()+"\\client\\friend.jsp");
    }
}
