package com.louay.projects.view.service.search;

import com.louay.projects.controller.service.member.*;
import com.louay.projects.controller.service.search.GetAccountDetailController;
import com.louay.projects.model.chains.accounts.Accounts;
import com.louay.projects.model.chains.accounts.Client;
import com.louay.projects.model.chains.accounts.Users;
import com.louay.projects.model.chains.accounts.constant.AccountType;
import com.louay.projects.model.chains.accounts.group.Groups;
import com.louay.projects.model.chains.member.account.FriendRequest;
import com.louay.projects.model.chains.member.account.UserFriend;
import com.louay.projects.model.chains.member.group.GroupInvite;
import com.louay.projects.model.chains.member.group.GroupMembers;
import com.louay.projects.model.chains.member.group.GroupRequest;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Set;

public class ReviewAccount extends HttpServlet {
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

        String id = request.getParameter("strange");
        AccountType accountType = AccountType.valueOf(request.getParameter("type"));

        GetAccountDetailController detailController = (GetAccountDetailController) this.context.getBean("getAccountDetail");
        GetGroupInviteController inviteController = (GetGroupInviteController) this.context.getBean("groupInviteCont");
        GetGroupMemberController memberController = (GetGroupMemberController) this.context.getBean("groupMemberCont");
        GetGroupRequestController requestController = (GetGroupRequestController) this.context.getBean("groupRequestCont");
        GetUserFriendController friendController = (GetUserFriendController) this.context.getBean("userFriendMemberCont");
        GetUserRequestController userRequestController = (GetUserRequestController) this.context.getBean("userRequestCont");

        Accounts accounts = null;
        String username = (String) session.getAttribute("username");
        if (accountType == AccountType.USER){
            accounts = this.context.getBean(Client.class);
            ((Client)accounts).setUsername(id);

            boolean isFriend = friendController.isMyFriend(buildUserFriend(username, id));
            boolean isThereRequest = userRequestController.isRequestSendOrReceive(buildFriendRequest(username, id));
            request.setAttribute("isFriend", isFriend);
            request.setAttribute("isThereRequest", isThereRequest);

        }else if (accountType == AccountType.GROUP){
            accounts = this.context.getBean(Groups.class);
            ((Groups)accounts).setIdGroup(id);

            boolean isImInvited = inviteController.isImInvited(buildGroupInvite(username, id));
            boolean isImMember = memberController.isImMember(buildGroupMembers(username, id));
            boolean isRequestSent = requestController.isRequestSent(buildGroupRequest(username, id));
            request.setAttribute("isImInvited", isImInvited);
            request.setAttribute("isImMember", isImMember);
            request.setAttribute("isRequestSent", isRequestSent);

        }


        @SuppressWarnings(value = "unchecked")
        Set<Accounts> accountsSet = (Set<Accounts>) detailController.execute(accounts);

        request.setAttribute("accountDetail", accountsSet);
    }

    private UserFriend buildUserFriend(String username, String target){
        UserFriend userFriend = this.context.getBean(UserFriend.class);
        Users users = userFriend.getUser();
        users.setUsername(username);
        Users friendMember = userFriend.getFriendMember();
        friendMember.setUsername(target);
        return userFriend;
    }

    private FriendRequest buildFriendRequest(String username, String target){
        FriendRequest friendRequest = this.context.getBean(FriendRequest.class);
        Users users = friendRequest.getSourceAccount();
        users.setUsername(username);
        Users targetAccount = friendRequest.getTargetAccount();
        targetAccount.setUsername(target);
        return friendRequest;
    }

    private GroupInvite buildGroupInvite(String username, String idGroup){
        GroupInvite invite = this.context.getBean(GroupInvite.class);
        Groups group = invite.getSourceGroup();
        group.setIdGroup(idGroup);
        Users users = invite.getTargetAccount();
        users.setUsername(username);
        return invite;
    }

    private GroupRequest buildGroupRequest(String username, String idGroup){
        GroupRequest request = this.context.getBean(GroupRequest.class);
        Groups groups = request.getSourceGroup();
        groups.setIdGroup(idGroup);
        Users users = request.getTargetAccount();
        users.setUsername(username);
        return request;
    }

    private GroupMembers buildGroupMembers(String username, String idGroup){
        GroupMembers members = this.context.getBean(GroupMembers.class);
        Groups groups = members.getGroup();
        groups.setIdGroup(idGroup);
        Users users = members.getFriendMember();
        users.setUsername(username);
        return members;
    }
}
