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
    <title>Request Received 'by Louay Amr'</title>
</head>
<body class="mainBackground">

<header>
    <nav class="navbar navbar-dark navbar-expand-md fixed-top shadow" style="background-color: #3e3c4e ;">
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

<main class="container-fluid" style="padding-top: 8%;">
    <div class="row row-cols-md-3">
        <div class="col-md-2"></div>

        <article class="col-md-8">
            <section>
                <jsp:include page="/GetRequestReceive"></jsp:include>
                <c:forEach items="${requestMap}" var="request">
                    <c:if test="${request.value.getRequestClassName() eq 'FRIEND_REQUEST'}">

                        <div class="card mt-2">
                            <div class="card-body">
                                <div class="form-row">

                                    <form class="col-10" action="<%=contextPath%>/client/review-account.jsp"
                                          method="get">
                                        <input type="text" value="${request.value.getSourceAccount().getUsername()}"
                                               name="strange" readonly hidden>
                                        <input type="text" value="${request.value.getSourceAccount().getAccountType()}"
                                               name="type" readonly hidden>
                                        <button class="btn btn-block" type="submit">
                                            <div class="form-row">
                                                <div class="col-1">
                                                    <img src="data:image/png;base64,${request.value.getSourceAccount().getBase64()}"
                                                         class="rounded-circle" width="128" height="128">
                                                </div>
                                                <div class="col-10">
                                                    <p class="font-weight-bold h5"
                                                       style="margin-left: 5%; margin-top: 9%;">
                                                            ${request.value.getSourceAccount().getFirstName()} ${request.value.getSourceAccount().getLastName()}</p>
                                                </div>
                                                <div class="text-muted small">
                                                    At: ${request.value.getRequestDate()}</div>
                                            </div>

                                        </button>
                                    </form>

                                    <div class="col-2">
                                        <form action="<%=contextPath%>/AddUserFriend" method="post">
                                            <input type="text" value="${request.value.getSourceAccount().getUsername()}"
                                                   name="strange" readonly hidden>
                                            <input type="text"
                                                   value="${request.value.getSourceAccount().getAccountType()}"
                                                   name="type" readonly hidden>
                                            <button type="submit" class="btn btn-success" style="margin-top: 38%;">
                                                Accept
                                            </button>
                                        </form>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${request.value.getRequestClassName() eq 'GROUP_INVITE'}">
                        <div class="card mt-2">
                            <div class="card-body">
                                <div class="form-row">

                                    <form class="col-10" action="<%=contextPath%>/client/review-account.jsp"
                                          method="get">
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
                                                    <p class="font-weight-bold h5"
                                                       style="margin-left: 5%; margin-top: 9%;">
                                                            ${request.value.getSourceGroup().getIdGroup()}</p>
                                                </div>
                                                <div class="text-muted small">
                                                    At: ${request.value.getRequestDate()}</div>
                                            </div>

                                        </button>
                                    </form>

                                    <div class="col-2">
                                        <form action="<%=contextPath%>/AddMemberGroup" method="post">
                                            <input type="text" value="${request.value.getSourceGroup().getIdGroup()}"
                                                   name="strange" readonly hidden>
                                            <input type="text"
                                                   value="${request.value.getSourceGroup().getAccountType()}"
                                                   name="type" readonly hidden>
                                            <button type="submit" class="btn btn-success" style="margin-top: 38%;">
                                                Accept
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
                                            <img src="../client/img/edit-black-48dp.svg" width="16" height="16">
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
                                            <img src="../client/img/edit-black-48dp.svg" width="16" height="16">
                                        </button>
                                        <button class="btn mt-2" data-toggle="modal" data-dismiss="modal"
                                                data-target="#lastNameModal">
                                            <img src="../client/img/edit-black-48dp.svg" width="16" height="16">
                                        </button>
                                        <button class="btn mt-2" data-toggle="modal" data-dismiss="modal"
                                                data-target="#genderModal">
                                            <img src="../client/img/edit-black-48dp.svg" width="16" height="16">
                                        </button>
                                        <button class="btn mt-2" data-toggle="modal" data-dismiss="modal"
                                                data-target="#birthdayModal">
                                            <img src="../client/img/edit-black-48dp.svg" width="16" height="16">
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
                                            <img src="../client/img/edit-black-48dp.svg" width="16" height="16">
                                        </button>
                                        <button class="btn mt-2" data-toggle="modal" data-dismiss="modal"
                                                data-target="#emailModal">
                                            <img src="../client/img/edit-black-48dp.svg" width="16" height="16">
                                        </button>
                                        <button class="btn mt-2" data-toggle="modal" data-dismiss="modal"
                                                data-target="#addressModal">
                                            <img src="../client/img/edit-black-48dp.svg" width="16" height="16">
                                        </button>
                                        <button class="btn mt-2" data-toggle="modal" data-dismiss="modal"
                                                data-target="#addressModal">
                                            <img src="../client/img/edit-black-48dp.svg" width="16" height="16">
                                        </button>
                                        <button class="btn mt-2" data-toggle="modal" data-dismiss="modal"
                                                data-target="#addressModal">
                                            <img src="../client/img/edit-black-48dp.svg" width="16" height="16">
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
    <nav class="navbar navbar-light navbar-expand-md shadow"
         style="background-color: #d3c7cd ; height: 10em;margin-top: 32em;">
        <div class="navbar-nav">
            <div class="navbar-text">
                Louay Amr © 2020
            </div>
        </div>
    </nav>
</footer>
</body>
</html>