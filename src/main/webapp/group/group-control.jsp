<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="../util/error.jsp" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.util.Calendar" %>

<%! String usernameSession;%>
<%! String passwordSession;%>
<%
    usernameSession = (String) session.getAttribute("username");
    passwordSession = (String) session.getAttribute("password");
    StringBuilder contextPath = new StringBuilder(request.getContextPath());

    Calendar calendar = Calendar.getInstance();
    calendar.setTimeInMillis(session.getCreationTime());
    LocalDateTime sessionCreate = LocalDateTime.of(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH),
            calendar.get(Calendar.DAY_OF_MONTH), calendar.get(Calendar.HOUR), calendar.get(Calendar.MINUTE),
            calendar.get(Calendar.SECOND));

    if (sessionCreate.plusMinutes(10).compareTo(LocalDateTime.now()) > 0) {
        session = request.getSession(true);
        session.setAttribute("username", usernameSession);
        session.setAttribute("password", passwordSession);
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
    <title>Group Control `by Louay Amr'</title>
</head>
<body class="background">

<header class="fixed-top">
    <nav class="navbar navbar-expand-lg mb-0 shadow text-left"
         style="background-color: #3e3c4e ;height: 6em; width: 100%;">


        <p class="text-light h4 font-weight-bold col-md-2">Chatting system</p>
        <p class="text-light mt-3 font-weight-bold col-md-1"><a class="nav-link navLinkHover"
                                                                href="<%= contextPath %>/signin/login.jsp">Home</a></p>
        <p class="text-light mt-3 font-weight-bold col-md-1"><a class="nav-link navLinkHover"
                                                                href="<%= contextPath %>/client/friend.jsp">Friend</a>
        </p>
        <p class="text-light mt-3 font-weight-bold col-md-1">Inbox<span class="badge badge-primary badge-pill">14</span>
        </p>

        <form class="form-inline col-md-5" action="<%= contextPath %>/client/search-result.jsp" method="get">
            <input class="form-control mr-sm-1 col-md-9" type="text" placeholder="Search" name="keySearch">
            <button class="btn btn-success col-md-2" type="submit">Search &telrec;</button>
        </form>

        <jsp:include page="/ViewAllNotSeenMessage"></jsp:include>
        <a class="col-md-auto col-lg-offset-1" href="<%=contextPath%>/client/message-receive.jsp">
            <button class="btn btn-outline-info" type="submit">
                <span class="badge badge-primary badge-pill mb-0 "><c:out
                        value="${messageNotSeen}">${messageNotSeen}</c:out></span>
                <img class="mt-0" src="<%= contextPath %>/client/img/message-white-48dp.svg" id="messageImg" height="24"
                     width="24"/>
            </button>
        </a>

        <div class="dropdown col-md-auto">
            <button type="button" class="btn btn-link dropdown-toggle-split" data-toggle="dropdown">
                <img src="<%= contextPath %>/client/img/account_circle-white-48dp.svg" class="rounded-circle mr-0"
                     width="72" height="72"/>&blacktriangledown;
            </button>
            <div class="dropdown-menu">
                <form>
                    <input class="dropdown-item text-left" type="submit" value="Profile">
                </form>
                <form action="<%= contextPath %>/Logout" method="post">
                    <input class="dropdown-item text-left" type="submit" value="Logout">
                </form>
                <a class="dropdown-item" href="#">Profile</a>
                <a class="dropdown-item disabled" href="#">Disabled</a>
            </div>
        </div>

    </nav>
</header>

<nav class="fixed-top" style="margin-top: 6em;">
    <div class="navbar navbar-dark navbar-expand-md bg-info col-md-12">
        <div class="navbar-brand col-md-10 h-3">
            <p class="font-weight-bold mt-1 text-white">Group Control</p>
        </div>
        <div class="nav-item col-md-2">
            <a href="<%=contextPath%>/group/creat-group.html">
                <button class="btn btn-warning" type="submit">+ Create Group</button>
            </a>
        </div>
    </div>
</nav>

<main class="col-md-12" style="padding-top: 13em;">

    <article>

        <section class="col-md-8 mt-3" style="margin-left: 16%;">

            <div class="card">

                <div class="card-header">
                    My Group
                </div>

                <jsp:include page="/GetUserGroup"></jsp:include>
                <c:forEach items="${groupMap}" var="group">
                <div class="card-body col-md-8" style="margin-left: 10%;">
                    <div class="row row-col-1 row-cols-md-2">

                        <div class="col-md-11">
                            <form action="<%=contextPath%>/client/review-account.jsp" method="get">
                                <input type="text" value="${group.value.getGroup().getIdGroup()}" name="strange" hidden readonly>
                                <input type="text" value="${group.value.getGroup().getAccountType()}" name="type" hidden readonly>
                                <button class="btn btn-block">
                                    <div class="row">
                                        <img src="data:img/png;base64,${group.value.getGroup().getBase64()}" width="94" height="94" class="rounded-circle">
                                        <p class="font-weight-bold ml-3" style="margin-top: 6%;">${group.value.getGroup().getIdGroup()}</p>
                                    </div>
                                </button>
                            </form>
                        </div>

                        <div class="col-md-1" style="margin-top: 6%;">
                            <form action="<%=contextPath%>/SwitchToGroup" method="post">
                                <input type="text" name="idGroup" value="${group.value.getGroup().getIdGroup()}" hidden readonly>
                                <input type="text" name="memberType" value="${group.value.getGroupMemberType()}" hidden readonly>
                                <button type="submit" class="btn btn-success">&circlearrowright;Switch</button>
                            </form>
                        </div>

                    </div>
                </div>
                </c:forEach>

            </div>

        </section>

    </article>

</main>


<footer style="padding-top: 25%;">
    <nav class="navbar" style="background-color: #d3c7cd; height: 11em; width: 100%">
        <p>Louay Amr © 2020</p>
    </nav>
</footer>
</body>
</html>