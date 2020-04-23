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

    if (sessionCreate.plusMinutes(50).compareTo(LocalDateTime.now()) > 0) {
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
        @import url(<%= contextPath %>/client/home-client.css);
        @import url(<%= contextPath %>/libr/bootstrap-formHelper-2.3.0/dist/css/bootstrap-formhelpers.min.css);
    </style>
    <script src="<%= contextPath %>/libr/jQuery-3.4.1/jquery.min.js"></script>
    <script src="<%= contextPath %>/libr/popper-1.16/popper.js"></script>
    <script src="<%= contextPath %>/libr/bootstrap-4.4.1/js/bootstrap.bundle.min.js"></script>
    <script src="<%= contextPath %>/libr/bootstrap-formHelper-2.3.0/dist/js/bootstrap-formhelpers.min.js"></script>
    <script src="<%= contextPath %>/client/home-client.js"></script>
    <title>Home `by Louay Amr'</title>
</head>
<body class="mainBackground">

<header>
    <nav class="navbar navbar-expand-lg mb-0 shadow text-left"
         style="background-color: #3e3c4e ;height: 6em; width: 100%">


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

<main class="mt-3 col-md-12">

    <aside class="float-left col-md-2">

        <div class="form-row">
            <img src="<%= contextPath %>/GetUserPhoto" class="rounded-circle" width="134" height="134"/>
            <p class="mt-5 ml-1 font-weight-bold h5"><%= usernameSession %>
            </p>
        </div>
        <hr>
        <div class="form-row">
            <a class="btn btn-toolbar btn-link" href="<%= contextPath %>/client/message-sent.jsp">
                <img src="<%= contextPath %>/client/img/send-black-48dp.svg" width="24" height="24">
                <p class="ml-3">Messages Sent</p>
            </a>
        </div>
        <div class="form-row">
            <a class="btn btn-toolbar btn-link" href="<%= contextPath %>/client/request-user-sent.jsp">
                <img src="<%= contextPath %>/client/img/how_to_reg-black-48dp.svg" width="24" height="24">
                <p class="ml-3">Request Sent</p>
            </a>
        </div>
        <div class="form-row ml-2">
            <img src="<%= contextPath %>/client/img/group-black-48dp.svg" width="24" height="24">
            <p class="ml-3">My Group</p>
        </div>
        <hr>
        <div class="form-text text-muted font-weight-bold ml-2">
            <p>Explore</p>
        </div>
        <div class="form-row">
            <a class="btn btn-toolbar btn-link" href="<%= contextPath %>/client/gallery.jsp">
                <img src="<%= contextPath %>/client/img/photo_library-black-48dp.svg" width="24" height="24">
                <p class="ml-3">My Photo Album</p>
            </a>
        </div>
        <div class="form-row">
            <a class="btn btn-toolbar btn-link" href="<%= contextPath %>/client/request-user-receive.jsp">
                <img src="<%= contextPath %>/client/img/person_add-black-48dp.svg" width="24" height="24">
                <p class="ml-3">Request</p>
            </a>
        </div>
        <div class="form-row">
            <a class="btn btn-toolbar btn-link" href="<%= contextPath %>/client/message-receive.jsp">
                <img class="mt-2" src="<%= contextPath %>/client/img/email-black-48dp.svg" width="24" height="24">
                <p class="ml-3 mt-2">Message</p>
            </a>
        </div>

    </aside>

    <article class="float-right col-md-10">
        <div class="card">
            <div class="card-body">

                <section class="float-left">
                    <div class="col-1 mt-2 mb-2 ">

                        <div class="list-group" role="tablist" style="height: 40em; width: 20em; overflow: auto">

                            <jsp:include page="/ViewListSentMessage"></jsp:include>
                            <c:forEach items="${notSeenSet}" var="set">
                                <form action="<%=contextPath%>/ViewSentMessageContent" method="get">

                                    <input type="text" name="receiveUser" value="${set.getTargetUser().getUsername()}"
                                           readonly hidden>

                                    <button class="list-group-item list-group-item-action" type="submit">

                                        <p class="font-weight-lighter">
                                            <span class="badge badge-secondary">${set.getNumberOfAllMessage()}</span>
                                                ${set.getSourceUser().getFirstName()} ${set.getSourceUser().getLastName()}
                                        </p>

                                    </button>

                                </form>
                            </c:forEach>

                        </div>

                    </div>
                </section>

                <section class="float-right">
                    <div class="col-md-12 mt-2 mb-2 ">

                        <c:if test="${messageTree !=null}">
                            <div class="tab-content" id="nav-tabContent">

                                <div style="height: 55em;overflow: auto">

                                    <c:forEach items="${numOfNotSeen}" var="notSee">
                                        <p class="text-muted small">
                                                ${notSee.getNumOfNotSeen()} message from him to you
                                            (${notSee.getSourceUser().getFirstName()} ${notSee.getSourceUser().getLastName()})
                                            not see it.
                                        </p>
                                    </c:forEach>

                                    <c:forEach items="${messageTree}" var="message">

                                        <c:if test="${message.getSourceUser().getUsername() eq username}">
                                            <div class="mt-3" style="width: 37em;">
                                                <div class="card text-white bg-dark">
                                                    <div class="card-body">
                                                        <div class="card-text">
                                                                ${message.getMessage()}
                                                        </div>
                                                    </div>
                                                </div>
                                                <img src="<%= contextPath %>/GetUserPhoto" width="32" height="32"
                                                     class="rounded-circle">
                                                <label class="text-muted small">Posted by: You,
                                                    At:${message.getSentDate()}</label>
                                            </div>
                                        </c:if>

                                        <c:if test="${message.getSourceUser().getUsername() ne username}">
                                            <div class="mt-3" style="width: 37em;margin-left: 4em;">
                                                <div class="card text-dark bg-light">
                                                    <div class="card-body">
                                                        <div class="card-text">
                                                                ${message.getMessage()}
                                                        </div>
                                                    </div>
                                                </div>
                                                <img src="data:image;base64,${message.getSourceUser().getBase64()}"
                                                     width="32" height="32" class="rounded-circle">
                                                <label class="text-muted small">Posted
                                                    by:${message.getSourceUser().getFirstName()} ${message.getSourceUser().getLastName()}
                                                    , At:${message.getSentDate()}</label>
                                            </div>
                                        </c:if>

                                    </c:forEach>

                                </div>

                                <form action="<%= contextPath %>/SendMessage" method="post">
                                    <input type="text" name="targetUser" value="<c:out value="${target}"/>" readonly
                                           hidden>
                                    <div class="input-group button">
                                        <input type="text" class="form-control" placeholder="Type a replay"
                                               aria-describedby="sendMessage" name="message">
                                        <div class="input-group-append">
                                            <button class="btn btn-dark" type="submit" id="sendMessage">Send</button>
                                        </div>
                                    </div>
                                </form>

                            </div>
                        </c:if>

                    </div>
                </section>

            </div>
        </div>
    </article>

</main>

<footer>
    <nav class="navbar"
         style="background-color: #d3c7cd; height: 11em; width: 100%;">
        <p>Louay Amr © 2020</p>
    </nav>
</footer>

</body>
</html>