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
    <title>Request Sent 'by Louay Amr'</title>
</head>
<body class="mainBackground">

<header class="fixed-top">
    <nav class="navbar navbar-expand-lg mb-0 shadow text-left"
         style="background-color: #3e3c4e ;height: 6em; width: 100%;">

        <p class="text-light h4 font-weight-bold col-md-2">Chatting system</p>
        <p class="text-light mt-3 font-weight-bold col-md-1"><a class="nav-link navLinkHover"
                                                                href="<%= contextPath %>/signin/login.jsp">Home</a></p>
        <p class="text-light mt-3 font-weight-bold col-md-1"><a class="nav-link navLinkHover"
                                                                href="<%= contextPath %>/client/friend.jsp">Friend</a></p>
        <p class="text-light mt-3 font-weight-bold col-md-1">Inbox<span class="badge badge-primary badge-pill">14</span>
        </p>

        <form class="form-inline col-md-5" action="<%= contextPath %>/client/search-result.jsp" method="get">
            <input class="form-control mr-sm-1 col-md-8" type="text" placeholder="Search" name="keySearch">
            <button class="btn btn-success col-md-3" type="submit">Search &telrec;</button>
        </form>

        <jsp:include page="/ViewAllNotSeenMessage"></jsp:include>
        <a class="col-md-auto col-lg-offset-1"  href="<%=contextPath%>/client/message-receive.jsp">
            <button class="btn btn-outline-info" type="submit">
                <span class="badge badge-primary badge-pill mb-0 "><c:out value="${messageNotSeen}">${messageNotSeen}</c:out></span>
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

<main class="col-md-12" style="padding-top: 7%">

    <article>
        <section style="margin-left: 20%">

            <jsp:include page="/GetRequestSent"></jsp:include>
            <c:forEach items="${requestMap}" var="request">
                <c:if test="${request.value.getRequestClassName() eq 'FRIEND_REQUEST'}">
                    <div class="card col-9 mt-3">
                        <div class="card-body">
                            <div class="form-row">

                                <form class="col-10" action="<%=contextPath%>/client/review-account.jsp" method="get">
                                    <input type="text" value="${request.value.getTargetAccount().getUsername()}"
                                           name="strange" readonly hidden>
                                    <input type="text" value="${request.value.getTargetAccount().getAccountType()}"
                                           name="type" readonly hidden>
                                    <button class="btn btn-block" type="submit">
                                        <div class="form-row">
                                            <div class="col-1">
                                                <img src="data:image/png;base64,${request.value.getSourceAccount().getBase64()}"
                                                     class="rounded-circle" width="128" height="128">
                                            </div>
                                            <div class="col-10">
                                                <p class="font-weight-bold h5" style="margin-left: 5%; margin-top: 9%;">
                                                        ${request.value.getSourceAccount().getFirstName()} ${request.value.getSourceAccount().getLastName()}</p>
                                            </div>
                                            <div class="text-muted small">At: ${request.value.getRequestDate()}</div>
                                        </div>

                                    </button>
                                </form>

                            </div>

                        </div>
                    </div>
                    </div>
                </c:if>

                <c:if test="${request.value.getRequestClassName() eq 'GROUP_REQUEST'}">
                    <div class="card col-9 mt-3">
                        <div class="card-body">
                            <div class="form-row">

                                <form class="col-10" action="<%=contextPath%>/client/review-account.jsp" method="get">
                                    <input type="text" value="${request.value.getSourceGroup().getIdGroup()}"
                                           name="strange" readonly hidden>
                                    <input type="text" value="${request.value.getSourceGroup().getAccountType()}"
                                           name="type" readonly hidden>
                                    <button class="btn btn-block" type="submit">
                                        <div class="form-row">
                                            <div class="col-1">
                                                <img src="data:image/png;base64,${request.value.getSourceGroup().getBase64()}"
                                                     class="rounded-circle" width="128" height="128">
                                            </div>
                                            <div class="col-10">
                                                <p class="font-weight-bold h5" style="margin-left: 5%; margin-top: 9%;">
                                                        ${request.value.getSourceGroup().getIdGroup()}</p>
                                            </div>
                                            <div class="text-muted small">At: ${request.value.getRequestDate()}</div>
                                        </div>

                                    </button>
                                </form>

                            </div>

                        </div>
                    </div>
                    </div>
                </c:if>

            </c:forEach>

        </section>

    </article>

</main>

<footer style="padding-top: 31em;">
    <nav class="navbar"
         style="background-color: #d3c7cd; height: 11em; width: 100%;">
        <p>Louay Amr © 2020</p>
    </nav>
</footer>


</body>
</html>