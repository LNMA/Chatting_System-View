<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="../util/error.jsp" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.time.LocalDateTime" %>

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
        @import url(<%= contextPath %>/libr/bootstrap-formHelper-2.3.0/dist/css/bootstrap-formhelpers.min.css);
        @import url(<%= contextPath %>/group/group.css);
    </style>
    <script src="<%= contextPath %>/libr/jQuery-3.4.1/jquery.min.js"></script>
    <script src="<%= contextPath %>/libr/popper-1.16/popper.js"></script>
    <script src="<%= contextPath %>/libr/bootstrap-4.4.1/js/bootstrap.bundle.min.js"></script>
    <script src="<%= contextPath %>/libr/bootstrap-formHelper-2.3.0/dist/js/bootstrap-formhelpers.min.js"></script>
    <script src="<%= contextPath %>/group/group.js"></script>
    <title>Group Members `by Louay Amr'</title>
</head>
<body class="background">

<header>
    <nav class="navbar navbar-dark navbar-expand-md fixed-top shadow" style="background-color: #3e3c4e ;">
        <a class="navbar-brand font-weight-bold" href="<%= contextPath %>/group/group-switch.jsp">Chatting system</a>

        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarGroupAccount"
                aria-controls="navbarGroupAccount" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse ml-5" id="navbarGroupAccount">
            <ul class="navbar-nav">
                <li class="nav-item ml-5">
                    <a class="nav-link font-weight-bold" href="<%= contextPath %>/group/group-switch.jsp">Home</a>
                </li>
                <li class="nav-item ml-5">
                    <a class="nav-link font-weight-bold" href="<%= contextPath %>/group/group-members.jsp">Members</a>
                </li>
            </ul>

            <form class="form-inline my-2 my-md-0 col-md-10" action="<%= contextPath %>/client/search-result.jsp"
                  method="get"
                  style="margin-left: 12%;">
                <input class="form-control mr-sm-2 w-50" type="search" placeholder="Search" aria-label="Search"
                       name="keySearch">
                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search &telrec;</button>
            </form>
        </div>
        <div class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="accountGroupDropdown" role="button" data-toggle="dropdown"
               aria-haspopup="true" aria-expanded="false">
                <img src="<%= contextPath %>/client/img/account_circle-white-48dp.svg" class="rounded-circle" width="72"
                     height="72"/>
            </a>
            <div class="dropdown-menu" aria-labelledby="accountGroupDropdown">
                <button class="dropdown-item text-left" id="dropProfile" data-toggle="modal"
                        data-target="#groupProfileModal">Group Profile
                </button>
                <form action="<%= contextPath %>/LogoutGroup" method="post">
                    <input class="dropdown-item text-left" type="submit" value="Group Logout">
                </form>
            </div>
        </div>
    </nav>
</header>

<main class="container-fluid" style="padding-top: 8%;">
    <div class="row row-cols-md-3">
        <div class="col-md-2"></div>

        <article class="col-md-8">

            <jsp:include page="/GetGroupMember"></jsp:include>
            <c:forEach items="${groupMembersMap}" var="member">
                <section class="mt-3">
                    <div class="card">
                        <div class="card-body">
                            <form action="<%=contextPath%>/client/review-account.jsp" method="get">
                                <input type="text" value="${member.value.getFriendMember().getUsername()}"
                                       name="strange" readonly hidden>
                                <input type="text" value="${member.value.getFriendMember().getAccountType()}"
                                       name="type" readonly hidden>
                                <button class="btn btn-block w-100" type="submit">
                                    <div class="form-row">
                                        <img src="data:image/png;base64,${member.value.getFriendMember().getBase64()}"
                                             class="rounded-circle"
                                             width="164" height="164"/>
                                        <p class="font-weight-bolder h5"
                                           style="margin-left: 5%; margin-top: 10%">${member.value.getFriendMember().getFirstName()} ${member.value.getFriendMember().getLastName()}
                                            : ${member.value.getGroupMemberType()}
                                        </p>

                                    </div>
                                </button>
                            </form>
                            <div class="text-muted small">Since : ${member.value.getFriendMemberSince()}</div>
                        </div>
                    </div>
                </section>
            </c:forEach>

        </article>
    </div>
</main>

<nav>
    <div id="viewProfileModal">
        <jsp:include page="/GetGroupProfileInfo"></jsp:include>
        <c:forEach items="${groupsSet}" var="group">
            <div class="modal fade" id="groupProfileModal">
                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">Profile</h4>
                            <button type="button" class="close" data-dismiss="modal">
                                &times;
                            </button>
                        </div>

                        <div class="modal-body">

                            <div class="container-fluid">
                                <div class="row row-cols-4">
                                    <!-- label -->
                                    <div class="col-md-2">
                                        <label for="idGroup" class="font-weight-bold col-md-12">ID Group: </label>
                                        <label for="dateCreate" class="font-weight-bold col-md-12 mt-4">Date
                                            Create: </label>
                                        <label for="privacy" class="font-weight-bold col-md-12 mt-4">Group
                                            Privacy: </label>
                                        <label for="activity" class="font-weight-bold col-md-12 mt-4">Activity: </label>
                                    </div>
                                    <!-- label -->
                                    <!-- input -->
                                    <div class="col-md-5">
                                        <input class="form-control col-md-12" id="idGroup" name="idGroup" type="text"
                                               value="${group.getIdGroup()}" readonly disabled>
                                        <input class="form-control col-md-12 mt-3" id="dateCreate" name="dateCreate"
                                               type="text"
                                               value="${group.getDateCreate()}" readonly disabled>
                                        <input class="form-control col-md-12 mt-3" id="privacy" name="groupPrivacy"
                                               type="text" value="${group.getGroupPrivacy()}" readonly disabled>
                                        <input class="form-control col-md-12 mt-3" id="activity" name="groupActivity"
                                               type="text"
                                               value="${group.getGroupActivity()}" readonly disabled>
                                    </div>
                                    <!-- input -->
                                    <!-- edit -->
                                    <div class="col-md-1">
                                        <button class="btn" data-toggle="modal" data-dismiss="modal"
                                                data-target="#gPrivacyModal" style="margin-top: 6.5em;">
                                            <img src="../group/img/edit-black-48dp.svg" width="16" height="16">
                                        </button>
                                        <button class="btn mt-3" data-toggle="modal" data-dismiss="modal"
                                                data-target="#gActivityModal">
                                            <img src="../group/img/edit-black-48dp.svg" width="16" height="16">
                                        </button>
                                    </div>
                                    <!-- edit -->
                                    <!-- img -->
                                    <div class="col-md-3 offset-md-1">
                                        <div class="row">
                                            <img src="data:image;base64,${group.getBase64()}" class="rounded-circle"
                                                 width="192" height="192">
                                            <button class="btn" data-toggle="modal" data-dismiss="modal"
                                                    data-target="#gImageModal">
                                                <img src="../group/img/add_photo_alternate-black-48dp.svg" width="28"
                                                     height="28">
                                            </button>
                                        </div>
                                    </div>
                                    <!-- img -->
                                </div>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger"
                                    data-dismiss="modal">Close
                            </button>
                        </div>

                    </div>
                </div>
            </div>
        </c:forEach>
        <div id="changeGroupImageModal"></div>
        <div id="changeGroupPrivacyModal"></div>
        <div id="changeGroupActivityModal"></div>
    </div>
</nav>


<footer>
    <nav class="navbar navbar-light navbar-expand-md shadow"
         style="background-color: #d3c7cd; height: 10em;margin-top: 32em;">
        <div class="navbar-nav">
            <div class="navbar-text">
                Louay Amr © 2020
            </div>
        </div>
    </nav>
</footer>

</body>
</html>
