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
    <nav class="navbar navbar-expand-lg mb-0 shadow text-left position-relative"
         style="background-color: #3e3c4e ;height: 6em; width: 100%">


        <p class="text-light h4 font-weight-bold col-md-2">Chatting system</p>
        <p class="text-light mt-3 font-weight-bold col-md-1"><a class="nav-link navLinkHover"
                                                                href="<%= contextPath %>/signin/login.jsp">Home</a></p>
        <p class="text-light mt-3 font-weight-bold col-md-1"><a class="nav-link navLinkHover"
                                                                href="<%= contextPath %>/client/friend.jsp">Friend</a></p>
        <p class="text-light mt-3 font-weight-bold col-md-1">Inbox<span class="badge badge-primary badge-pill">14</span>
        </p>

        <form class="form-inline col-md-5" action="<%= contextPath %>/client/search-result.jsp" method="get">
            <input class="form-control mr-sm-2 w-75" type="text" placeholder="Search" name="keySearch">
            <button class="btn btn-success " type="submit">Search &telrec;</button>
        </form>

        <form class="col-md-1">
            <button class="btn btn-outline-info" type="submit">
                <span class="badge badge-primary badge-pill mb-0 ">14</span>
                <img class="mt-0" src="<%= contextPath %>/client/img/message-white-48dp.svg" id="messageImg" height="24"
                     width="24"/>
            </button>
        </form>

        <div class="dropdown col-md-2">
            <button type="button" class="btn btn-link dropdown-toggle-split" data-toggle="dropdown">
                <img src="<%= contextPath %>/client/img/account_circle-white-48dp.svg" class="rounded-circle mr-0"
                     width="72"
                     height="72"/>&blacktriangledown;
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

<main class="mt-3">

    <article>

        <jsp:include page="/ReviewAccount"></jsp:include>
        <c:forEach items="${accountDetail}" var="account">
        <section>
            <div class="card col-md-10 " style="margin-left: 9%;">
                <div class="card-body">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-auto">
                                <img src="data:image;base64,${account.getBase64()}" width="164" height="164" class="rounded-circle">
                            </div>
                            <c:if test="${account.getAccountType() eq 'USER'}">
                            <div class="col-md-3">
                                <p class="font-weight-bold" style="margin-top: 27%">${account.getFirstName()} ${account.getLastName()}</p>
                            </div>
                            <div class="col-md-3">
                                <button class="btn btn-warning" style="margin-top: 25%">+ Send Request</button>
                            </div>
                            <div class="col-md-3">
                                <button class="btn btn-info" style="margin-top: 25%">Send Message</button>
                            </div>
                            </c:if>
                            <c:if test="${account.getAccountType() eq 'GROUP'}">
                                <div class="col-md-3">
                                    <p class="font-weight-bold" style="margin-top: 27%">${account.getIdGroup()}</p>
                                </div>
                            <c:if test="${account.getGroupPrivacy() ne 'private'}">
                            <div class="col-md-6 text-right">
                                    <button class="btn btn-warning" style="margin-top: 25%">+ Send Request</button>
                                </div>
                            </c:if>
                            </c:if>
                        </div>
                    </div>

                </div>
            </div>
        </section>


        <section>
            <div class="card col-md-6 mt-3" style="margin-left: 24%">
                <div class="card-header">
                    About
                </div>
                <c:if test="${account.getAccountType() eq 'USER'}">
                <div class="card-body">
                    <p class="text-muted">Identify</p>
                    <hr>
                    <p>On chatting system since: ${account.getDateCreate()}</p>
                    <p>${account.getUsername()}</p>
                    <p>${account.getFirstName()} ${account.getLastName()}</p>
                    <p>${account.getGender()}</p>
                    <p>${account.getBirthday()}</p>
                    <p>${account.getAge()}</p>

                    <p class="text-muted mt-5">Communication</p>
                    <hr>
                    <p>${account.getTelephone()}</p>
                    <p>${account.getEmail()}</p>

                    <p class="text-muted mt-5">Address</p>
                    <hr>
                    <p>${account.getCountry()}</p>
                    <p>${account.getState()}</p>
                    <p>${account.getAddress()}</p>
                </div>
                </c:if>
                <c:if test="${account.getAccountType() eq 'GROUP'}">
                    <div class="card-body">
                        <p class="text-muted">Identify</p>
                        <hr>
                        <p>On chatting system since: ${account.getDateCreate()}</p>
                        <p>${account.getIdGroup()}</p>
                        <p class="text-muted mt-5">Activity</p>
                        <hr>
                        <p>${account.getGroupActivity()}</p>
                    </div>
                </c:if>
            </div>
        </section>
        </c:forEach>

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