<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="../util/error.jsp" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.util.Calendar" %>
<%! String idGroupSession; %>
<%! String memberTypeSession; %>
<%! String usernameSession;%>
<%! String passwordSession;%>
<%
    idGroupSession = (String) session.getAttribute("idGroup");
    memberTypeSession = (String) session.getAttribute("memberType");
    usernameSession = (String) session.getAttribute("username");
    passwordSession = (String) session.getAttribute("password");
    StringBuilder contextPath = new StringBuilder(request.getContextPath());

    Calendar calendar = Calendar.getInstance();
    calendar.setTimeInMillis(session.getCreationTime());
    LocalDateTime sessionCreate = LocalDateTime.of(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH),
            calendar.get(Calendar.DAY_OF_MONTH), calendar.get(Calendar.HOUR), calendar.get(Calendar.MINUTE),
            calendar.get(Calendar.SECOND));

    if (sessionCreate.plusMinutes(40).compareTo(LocalDateTime.now()) > 0) {
        session = request.getSession(true);
        session.setAttribute("username", usernameSession);
        session.setAttribute("password", passwordSession);
        session.setAttribute("idGroup", idGroupSession);
        session.setAttribute("memberType", memberTypeSession);
        response.sendRedirect(contextPath + "\\signin\\login.jsp");
    }

%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <style>
        @import url(<%= contextPath %>/libr/bootstrap-4.4.1/css/bootstrap.min.css);
        @import url(<%= contextPath %>/libr/bootstrap-formHelper-2.3.0/dist/css/bootstrap-formhelpers.min.css);
        @import url(<%= contextPath %>/group/group.css);
    </style>
    <script src="<%= contextPath %>/libr/jQuery-3.4.1/jquery.min.js"></script>
    <script src="<%= contextPath %>/libr/popper-1.16/popper.js"></script>
    <script src="<%= contextPath %>/libr/bootstrap-4.4.1/js/bootstrap.bundle.min.js"></script>
    <script src="<%= contextPath %>/libr/bootstrap-formHelper-2.3.0/dist/js/bootstrap-formhelpers.min.js"></script>
    <script src="<%= contextPath %>/group/group.js"></script>
    <title>Group Switch `by Louay Amr'</title>
</head>
<body class="background">

<header class="fixed-top">
    <nav class="navbar navbar-expand-lg mb-0 shadow text-left"
         style="background-color: #3e3c4e ;height: 6em; width: 100%;">


        <p class="text-light h4 font-weight-bold col-md-2">Chatting system</p>
        <p class="text-light mt-3 font-weight-bold col-md-1"><a class="nav-link navLinkHover"
                                                                href="<%= contextPath %>/group/group-switch.jsp">Home</a></p>
        <p class="text-light mt-3 font-weight-bold col-md-2"><a class="nav-link navLinkHover"
                                                                href="<%= contextPath %>/group/group-members.jsp">Member</a>
        </p>

        <form class="form-inline col-md-6" action="<%= contextPath %>/client/search-result.jsp" method="get">
            <input class="form-control mr-sm-1 col-md-8" type="text" placeholder="Search" name="keySearch">
            <button class="btn btn-success col-md-2" type="submit">Search &telrec;</button>
        </form>

        <div class="dropdown col-md-auto">
            <button type="button" class="btn btn-link dropdown-toggle-split" data-toggle="dropdown">
                <img src="<%= contextPath %>/client/img/account_circle-white-48dp.svg" class="rounded-circle mr-0"
                     width="72" height="72"/>&blacktriangledown;
            </button>
            <div class="dropdown-menu">
                <form>
                    <input class="dropdown-item text-left" type="submit" value="Profile">
                </form>
                <a href="<%=contextPath%>/client/home-client.jsp">
                    <input class="dropdown-item text-left" type="submit" value="Group Logout">
                </a>
                <a class="dropdown-item" href="#">Profile</a>
                <a class="dropdown-item disabled" href="#">Disabled</a>
            </div>
        </div>

    </nav>
</header>

<main class="col-md-12" style="padding-top: 7em;">

    <article>
        <section style="margin-left: 20%">

            <jsp:include page="/GetGroupInviteSent"></jsp:include>
            <c:forEach items="${groupInviteMap}" var="invite">
                <div class="card col-9 mt-3">
                    <div class="card-body">
                            <div class="form-row">

                                <form class="col-10" action="<%=contextPath%>/client/review-account.jsp" method="get">
                                    <input type="text" value="${invite.value.getTargetAccount().getUsername()}" name="strange" readonly hidden>
                                    <input type="text" value="${invite.value.getTargetAccount().getAccountType()}" name="type" readonly hidden>
                                    <button class="btn btn-block" type="submit">
                                        <div class="form-row">
                                            <div class="col-1">
                                                <img src="data:image/png;base64,${invite.value.getTargetAccount().getBase64()}" class="rounded-circle" width="128" height="128">
                                            </div>
                                            <div class="col-10">
                                                <p class="font-weight-bold h5" style="margin-left: 5%; margin-top: 9%;">
                                                        ${invite.value.getTargetAccount().getFirstName()} ${invite.value.getTargetAccount().getLastName()}</p>
                                            </div>
                                            <div class="text-muted small">${invite.value.getRequestDate()}</div>
                                        </div>

                                    </button>
                                </form>

                            </div>

                    </div>
                </div>
            </c:forEach>

        </section>

    </article>

</main>


<footer style="margin-top: 31em;">
    <nav class="navbar" style="background-color: #d3c7cd; height: 11em; width: 100%">
        <p>Louay Amr © 2020</p>
    </nav>
</footer>
</body>
</html>