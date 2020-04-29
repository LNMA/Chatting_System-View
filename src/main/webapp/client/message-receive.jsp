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
    <title>Message Received 'by Louay Amr'</title>
</head>
<body class="mainBackground">

<header>
    <nav class="navbar navbar-dark navbar-expand-md shadow" style="background-color: #3e3c4e ;">
        <a class="navbar-brand font-weight-bold" href="<%=contextPath%>/signin/login.jsp">Chatting system</a>

        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarUserAccount"
                aria-controls="navbarUserAccount" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse ml-5" id="navbarUserAccount">
            <ul class="navbar-nav">
                <li class="nav-item ml-4">
                    <a class="nav-link font-weight-bold" href="<%=contextPath%>/signin/login.jsp">Home</a>
                </li>
                <li class="nav-item ml-4">
                    <a class="nav-link font-weight-bold" href="<%=contextPath%>/client/friend.jsp">Friend</a>
                </li>
                <li class="nav-item dropdown ml-4">
                    <jsp:include page="/ViewAllNotSeenMessage"></jsp:include>
                    <a class="nav-link dropdown-toggle" href="#" id="inboxDropdown" role="button" data-toggle="dropdown"
                       aria-haspopup="true" aria-expanded="false">
                        Inbox<span class="badge badge-primary badge-pill"><c:out
                            value="${messageNotSeen+requestReceive}"></c:out></span>
                    </a>
                    <div class="dropdown-menu" aria-labelledby="inboxDropdown">
                        <a class="dropdown-item" href="<%=contextPath%>/client/request-user-receive.jsp">
                            <img src="<%=contextPath%>/client/img/person_add-black-48dp.svg" width="24" height="24">
                            Request <span class="badge badge-primary badge-pill"><c:out
                                value="${requestReceive}"></c:out></span>
                        </a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="<%=contextPath%>/client/message-receive.jsp">
                            <img src="<%=contextPath%>/client/img/email-black-48dp.svg" width="24" height="24">
                            Message <span class="badge badge-primary badge-pill"><c:out
                                value="${messageNotSeen}"></c:out></span>
                        </a>
                    </div>
                </li>
            </ul>

            <form class="form-inline my-2 my-md-0" action="<%=contextPath%>/client/search-result.jsp" method="get"
                  style="margin-left: 12%; margin-right: 12%;">
                <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search"
                       name="keySearch">
                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search &telrec;</button>
            </form>

            <a class="nav-item" href="<%=contextPath%>/client/message-receive.jsp">
                <button class="btn btn-outline-info nav-link">
                    <span class="badge badge-primary badge-pill mb-0 "><c:out
                            value="${messageNotSeen}"></c:out></span>
                    <img class="mt-0" src="<%=contextPath%>/client/img/message-white-48dp.svg" id="messageImg"
                         height="24"
                         width="24"/>
                </button>
            </a>
        </div>
        <div class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="accountUserDropdown" role="button" data-toggle="dropdown"
               aria-haspopup="true" aria-expanded="false">
                <img src="<%=contextPath%>/client/img/account_circle-white-48dp.svg" class="rounded-circle" width="72"
                     height="72"/>
            </a>
            <div class="dropdown-menu" aria-labelledby="accountUserDropdown">
                <button class="dropdown-item text-left" id="dropdownProfile" data-toggle="modal"
                        data-target="#profileModal">Profile
                </button>
                <form action="<%=contextPath%>/Logout" method="post">
                    <input class="dropdown-item text-left" type="submit" value="Logout">
                </form>
            </div>
        </div>
    </nav>
</header>

<main class="mt-3 container-fluid">

    <div class="row row-cols-2">

        <aside class="col-md-2">
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
            <div class="form-row">
                <a class="btn btn-toolbar btn-link" href="<%= contextPath %>/group/group-control.jsp">
                    <img src="<%= contextPath %>/client/img/group-black-48dp.svg" width="24" height="24">
                    <p class="ml-3">My Group</p>
                </a>
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
                <a class="btn btn-toolbar btn-link" href="<%= contextPath %>client/request-user-receive.jsp">
                    <img src="<%= contextPath %>/client/img/person_add-black-48dp.svg" width="24" height="24">
                    <p class="ml-3">Request Receive</p>
                </a>
            </div>
            <div class="form-row">
                <a class="btn btn-toolbar btn-link" href="<%= contextPath %>/client/message-receive.jsp">
                    <img class="mt-2" src="<%= contextPath %>/client/img/email-black-48dp.svg" width="24" height="24">
                    <p class="ml-3 mt-2">Message Receive</p>
                </a>
            </div>
        </aside>

        <article class="col-md-10">
            <div class="card">
                <div class="card-body">
                    <div class="container-fluid">
                        <div class="row row-cols-2">

                            <section class="col-md-3">
                                <div class="mt-2 mb-2" style="height: 40em;overflow: auto;">
                                    <div class="list-group" role="tablist">

                                        <jsp:include page="/ViewListReceiveMessage"></jsp:include>
                                        <c:forEach items="${notSeenSet}" var="set">
                                            <form action="<%=contextPath%>/ViewReceiveMessageContent" method="get">

                                                <input type="text" name="senderUser"
                                                       value="${set.getSourceUser().getUsername()}"
                                                       readonly hidden>

                                                <button class="list-group-item list-group-item-action" type="submit">

                                                    <p class="font-weight-lighter">
                                                        <span class="badge badge-secondary">${set.getNumOfNotSeen()}</span>
                                                            ${set.getSourceUser().getFirstName()} ${set.getSourceUser().getLastName()}
                                                    </p>

                                                </button>
                                            </form>
                                        </c:forEach>

                                    </div>
                                </div>
                            </section>

                            <section class="col-md-8 offset-md-1">
                                <div class="mt-2 mb-2 ">
                                    <c:if test="${messageTree !=null}">
                                        <div class="tab-content" id="nav-tabContent">

                                            <div style="height: 55em;overflow: auto">

                                                <c:forEach items="${numOfNotSeen}" var="notSee">
                                                    <p class="text-muted small">
                                                            ${notSee.getNumOfNotSeen()}
                                                        message ${notSee.getSourceUser().getFirstName()} ${notSee.getSourceUser().getLastName()}
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
                                                            <img src="<%= contextPath %>/GetUserPhoto" width="32"
                                                                 height="32"
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
                                                <input type="text" name="targetUser" value="<c:out value="${sender}"/>"
                                                       readonly
                                                       hidden>
                                                <div class="input-group button">
                                                    <input type="text" class="form-control" placeholder="Type a replay"
                                                           aria-describedby="sendMessage" name="message">
                                                    <div class="input-group-append">
                                                        <button class="btn btn-dark" type="submit" id="sendMessage">
                                                            Send
                                                        </button>
                                                    </div>
                                                </div>
                                            </form>

                                        </div>
                                    </c:if>
                                </div>
                            </section>

                        </div>
                    </div>
                </div>
            </div>
        </article>

    </div>
</main>

<nav>
    <div id="viewProfileModal">
        <jsp:include page="/GetUserProfileInfo"></jsp:include>
        <c:forEach items="${accountDetail}" var="account">
            <div class="modal fade" id="profileModal">
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
                                <div class="row row-cols-3">
                                    <!-- label -->
                                    <div class="col-md-3">
                                        <label for="username" class="font-weight-bold col-md-12">Username: </label>
                                        <label for="accountPermission" class="font-weight-bold col-md-12 mt-4">Account
                                            Permission: </label>
                                        <label for="dateCreate" class="font-weight-bold col-md-12 mt-4">Date
                                            Create: </label>
                                    </div>
                                    <!-- label -->
                                    <!-- input -->
                                    <div class="col-md-4">
                                        <input class="form-control col-md-12" id="username" name="username" type="text"
                                               value="${account.getUsername()}" readonly disabled>
                                        <input class="form-control col-md-12 mt-3" id="accountPermission"
                                               name="accountPermission"
                                               type="text" value="${account.getAccountPermission()}" readonly disabled>
                                        <input class="form-control col-md-12 mt-3" id="dateCreate" name="dateCreate"
                                               type="text"
                                               value="${account.getDateCreate()}" readonly disabled>
                                    </div>
                                    <!-- input -->
                                    <!-- img -->
                                    <div class="col-md-3 offset-md-2">
                                        <div class="row">
                                            <img src="data:image;base64,${account.getBase64()}" class="rounded-circle"
                                                 width="192" height="192">
                                            <button class="btn" data-toggle="modal" data-dismiss="modal"
                                                    data-target="#ImageModal">
                                                <img src="../client/img/add_photo_alternate-black-48dp.svg" width="28"
                                                     height="28">
                                            </button>
                                        </div>
                                    </div>
                                    <!-- img -->
                                </div>
                            </div>

                            <div class="container-fluid">
                                <div class="row row-cols-3">
                                    <div class="col-md-3">
                                        <label for="password" class="font-weight-bold col-md-12">Password: </label>
                                    </div>
                                    <div class="col-md-4">
                                        <input class="form-control col-md-12" id="password" name="password"
                                               type="password"
                                               value="${account.getPassword()}" readonly disabled>
                                    </div>
                                    <div class="col-md-1">
                                        <button class="btn" data-toggle="modal" data-dismiss="modal"
                                                data-target="#passwordModal">
                                            <img src="<%= contextPath %>/client/img/edit-black-48dp.svg" width="16" height="16">
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <div class="container-fluid">
                                <div class="row row-cols-6 mt-5">
                                    <div class="col-md-2">
                                        <label for="fname" class="font-weight-bold col-md-12">First Name: </label>
                                        <label for="lname" class="font-weight-bold col-md-12 mt-3">Last Name: </label>
                                        <label for="gender" class="font-weight-bold col-md-12 mt-3">Gender: </label>
                                        <label for="birthday" class="font-weight-bold col-md-12 mt-3">BirthDay: </label>
                                        <label for="age" class="font-weight-bold col-md-12 mt-3">Age: </label>
                                    </div>
                                    <div class="col-md-3">
                                        <input class="form-control" id="fname" value="${account.getFirstName()}"
                                               type="text" readonly disabled>
                                        <input class="form-control mt-2" id="lname" value="${account.getLastName()}"
                                               type="text" readonly
                                               disabled>
                                        <input class="form-control mt-2" id="gender" value="${account.getGender()}"
                                               type="text" readonly
                                               disabled>
                                        <input class="form-control mt-2" id="birthday" value="${account.getBirthday()}"
                                               type="text" readonly
                                               disabled>
                                        <input class="form-control mt-2" id="age" value="${account.getAge()}"
                                               type="text" readonly disabled>
                                    </div>
                                    <div class="col-md-1">
                                        <button class="btn" data-toggle="modal" data-dismiss="modal"
                                                data-target="#firstNameModal">
                                            <img src="<%= contextPath %>/client/img/edit-black-48dp.svg" width="16" height="16">
                                        </button>
                                        <button class="btn mt-2" data-toggle="modal" data-dismiss="modal"
                                                data-target="#lastNameModal">
                                            <img src="<%= contextPath %>/client/img/edit-black-48dp.svg" width="16" height="16">
                                        </button>
                                        <button class="btn mt-2" data-toggle="modal" data-dismiss="modal"
                                                data-target="#genderModal">
                                            <img src="<%= contextPath %>/client/img/edit-black-48dp.svg" width="16" height="16">
                                        </button>
                                        <button class="btn mt-2" data-toggle="modal" data-dismiss="modal"
                                                data-target="#birthdayModal">
                                            <img src="<%= contextPath %>/client/img/edit-black-48dp.svg" width="16" height="16">
                                        </button>
                                    </div>
                                    <div class="col-md-2">
                                        <label for="telephone" class="font-weight-bold col-md-12">Telephone: </label>
                                        <label for="email" class="font-weight-bold col-md-12 mt-3">Email: </label>
                                        <label for="country" class="font-weight-bold col-md-12 mt-3">Country: </label>
                                        <label for="state" class="font-weight-bold col-md-12 mt-3">State: </label>
                                        <label for="address" class="font-weight-bold col-md-12 mt-3">Address: </label>
                                    </div>
                                    <div class="col-md-3">
                                        <input class="form-control" id="telephone" value="${account.getTelephone()}"
                                               type="text" readonly
                                               disabled>
                                        <input class="form-control mt-2" id="email" value="${account.getEmail()}"
                                               type="text" readonly
                                               disabled>
                                        <input class="form-control mt-2" id="country" value="${account.getCountry()}"
                                               type="text" readonly
                                               disabled>
                                        <input class="form-control mt-2" id="state" value="${account.getState()}"
                                               type="text" readonly
                                               disabled>
                                        <input class="form-control mt-2" id="address" value="${account.getAddress()}"
                                               type="text" readonly disabled>
                                    </div>
                                    <div class="col-md-1">
                                        <button class="btn" data-toggle="modal" data-dismiss="modal"
                                                data-target="#telephoneModal">
                                            <img src="<%= contextPath %>/client/img/edit-black-48dp.svg" width="16" height="16">
                                        </button>
                                        <button class="btn mt-2" data-toggle="modal" data-dismiss="modal"
                                                data-target="#emailModal">
                                            <img src="<%= contextPath %>/client/img/edit-black-48dp.svg" width="16" height="16">
                                        </button>
                                        <button class="btn mt-2" data-toggle="modal" data-dismiss="modal"
                                                data-target="#addressModal">
                                            <img src="<%= contextPath %>/client/img/edit-black-48dp.svg" width="16" height="16">
                                        </button>
                                        <button class="btn mt-2" data-toggle="modal" data-dismiss="modal"
                                                data-target="#addressModal">
                                            <img src="<%= contextPath %>/client/img/edit-black-48dp.svg" width="16" height="16">
                                        </button>
                                        <button class="btn mt-2" data-toggle="modal" data-dismiss="modal"
                                                data-target="#addressModal">
                                            <img src="<%= contextPath %>/client/img/edit-black-48dp.svg" width="16" height="16">
                                        </button>
                                    </div>
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
        <!-- password modal -->
        <div id="changePasswordModal"></div>
        <!-- Image modal -->
        <div id="changeUserPictureModal"></div>
        <!-- fname modal -->
        <div id="changeFNameModal"></div>
        <!-- lname modal -->
        <div id="changeLNameModal"></div>
        <!-- gender modal -->
        <div id="changeGenderModal"></div>
        <!-- birthday modal -->
        <div id="changeBirthdayModal"></div>
        <!-- telephone modal -->
        <div id="changeTelephoneModal"></div>
        <!-- email modal -->
        <div id="changeEmailModal"></div>
        <!-- address modal -->
        <div id="changeAddressModal"></div>
    </div>
</nav>

<footer>
    <nav class="navbar navbar-light navbar-expand-md shadow mt-3" style="background-color: #d3c7cd ; height: 10em;">
        <div class="navbar-nav">
            <div class="navbar-text">
                Louay Amr © 2020
            </div>
        </div>
    </nav>
</footer>

</body>
</html>