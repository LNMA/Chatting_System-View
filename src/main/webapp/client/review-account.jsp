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
    if (session.getAttribute("idGroup") != null && session.getAttribute("memberType") != null) {
        idGroupSession = (String) session.getAttribute("idGroup");
        memberTypeSession = (String) session.getAttribute("memberType");
    }
    usernameSession = (String) session.getAttribute("username");
    passwordSession = (String) session.getAttribute("password");
    StringBuilder contextPath = new StringBuilder(request.getContextPath());

    Calendar calendar = Calendar.getInstance();
    calendar.setTimeInMillis(session.getCreationTime());
    LocalDateTime sessionCreate = LocalDateTime.of(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH),
            calendar.get(Calendar.DAY_OF_MONTH), calendar.get(Calendar.HOUR), calendar.get(Calendar.MINUTE),
            calendar.get(Calendar.SECOND));

    if (sessionCreate.plusMinutes(30).compareTo(LocalDateTime.now()) > 0) {
        session = request.getSession(true);
        session.setAttribute("username", usernameSession);
        session.setAttribute("password", passwordSession);
        if (idGroupSession != null && memberTypeSession != null) {
            session.setAttribute("idGroup", idGroupSession);
            session.setAttribute("memberType", memberTypeSession);
        }
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
        @import url(<%= contextPath %>/group/group.css);
        @import url(<%= contextPath %>/libr/bootstrap-formHelper-2.3.0/dist/css/bootstrap-formhelpers.min.css);
    </style>
    <script src="<%= contextPath %>/libr/jQuery-3.4.1/jquery.min.js"></script>
    <script src="<%= contextPath %>/libr/popper-1.16/popper.js"></script>
    <script src="<%= contextPath %>/libr/bootstrap-4.4.1/js/bootstrap.bundle.min.js"></script>
    <script src="<%= contextPath %>/libr/bootstrap-formHelper-2.3.0/dist/js/bootstrap-formhelpers.min.js"></script>
    <script src="<%= contextPath %>/client/home-client.js"></script>
    <script src="<%= contextPath %>/group/group.js"></script>
    <title>Review Account 'by Louay Amr'</title>
</head>
<body class="mainBackground">

<c:if test="${idGroup eq null}">
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
                        <a class="nav-link dropdown-toggle" href="#" id="inboxDropdown" role="button"
                           data-toggle="dropdown"
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
                <a class="nav-link dropdown-toggle" href="#" id="accountUserDropdown" role="button"
                   data-toggle="dropdown"
                   aria-haspopup="true" aria-expanded="false">
                    <img src="<%=contextPath%>/client/img/account_circle-white-48dp.svg" class="rounded-circle"
                         width="72"
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
</c:if>

<c:if test="${idGroup ne null}">
    <header>
        <nav class="navbar navbar-dark navbar-expand-md fixed-top shadow" style="background-color: #3e3c4e ;">
            <a class="navbar-brand font-weight-bold" href="<%=contextPath%>group/group-switch.jsp">Chatting system</a>

            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarGroupAccount"
                    aria-controls="navbarGroupAccount" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse ml-5" id="navbarGroupAccount">
                <ul class="navbar-nav">
                    <li class="nav-item ml-5">
                        <a class="nav-link font-weight-bold" href="<%=contextPath%>/group/group-switch.jsp">Home</a>
                    </li>
                    <li class="nav-item ml-5">
                        <a class="nav-link font-weight-bold" href="<%=contextPath%>/group/group-members.jsp">Members</a>
                    </li>
                </ul>

                <form class="form-inline my-2 my-md-0 col-md-10" action="<%=contextPath%>/client/search-result.jsp"
                      method="get"
                      style="margin-left: 12%;">
                    <input class="form-control mr-sm-2 w-50" type="search" placeholder="Search" aria-label="Search"
                           name="keySearch">
                    <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search &telrec;</button>
                </form>
            </div>
            <div class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="accountGroupDropdown" role="button"
                   data-toggle="dropdown"
                   aria-haspopup="true" aria-expanded="false">
                    <img src="<%=contextPath%>/client/img/account_circle-white-48dp.svg" class="rounded-circle"
                         width="72" height="72"/>
                </a>
                <div class="dropdown-menu" aria-labelledby="accountGroupDropdown">
                    <button class="dropdown-item text-left" id="dropProfile" data-toggle="modal"
                            data-target="#groupProfileModal">Group Profile
                    </button>
                    <form action="<%=contextPath%>/LogoutGroup" method="post">
                        <input class="dropdown-item text-left" type="submit" value="Group Logout">
                    </form>
                </div>
            </div>
        </nav>
    </header>
</c:if>


<main class="container-fluid" style="margin-top: 8%;">

    <article>
        <jsp:include page="/ReviewAccount"></jsp:include>
        <c:forEach items="${accountDetail}" var="account">
            <section>
                <div class="card col-md-10 " style="margin-left: 9%;">
                    <div class="card-body">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-auto">
                                    <img src="data:image;base64,${account.getBase64()}" width="164" height="164"
                                         class="rounded-circle">
                                </div>
                                <c:if test="${account.getAccountType() eq 'USER'}">
                                    <div class="col-md-3">
                                        <p class="font-weight-bold"
                                           style="margin-top: 27%">${account.getFirstName()} ${account.getLastName()}</p>
                                    </div>
                                    <c:if test="${isFriend eq false and isThereRequest eq false and account.getUsername() ne username}">
                                        <div class="col-md-2">
                                            <form action="<%=contextPath%>/AddRequest" method="post">
                                                <input type="text" value="${account.getUsername()}" name="id" readonly
                                                       hidden>
                                                <input type="text" value="${account.getAccountType()}" name="type"
                                                       readonly hidden>
                                                <button class="btn btn-warning" style="margin-top: 25%">+ Send Request
                                                </button>
                                            </form>
                                        </div>
                                    </c:if>

                                    <c:if test="${memberType eq 'master' and isUserInviteToMyGroup eq false and isOurMemberGroup eq false and isSentGroupRequest eq false and account.getUsername() ne username}">
                                        <div class="col-md-2">
                                            <form action="<%=contextPath%>/AddGroupInvite" method="post">
                                                <input type="text" value="${account.getUsername()}" name="id" readonly
                                                       hidden>
                                                <input type="text" value="${account.getAccountType()}" name="type"
                                                       readonly hidden>
                                                <button class="btn btn-warning" style="margin-top: 25%">+ Invite
                                                </button>
                                            </form>
                                        </div>
                                    </c:if>

                                    <c:if test="${account.getUsername() ne username}">
                                        <div class="col-md-2">
                                            <button class="btn btn-info" data-toggle="modal" data-target="#userModal"
                                                    style="margin-top: 25%">Send Message
                                            </button>

                                            <div class="modal fade" id="userModal">
                                                <div class="modal-dialog modal-lg">
                                                    <div class="modal-content">

                                                        <div class="modal-header">
                                                            <h4 class="modal-title">Send Message</h4>
                                                            <button type="button" class="close" data-dismiss="modal">
                                                                &times;
                                                            </button>
                                                        </div>

                                                        <div class="modal-body">
                                                            <form action="<%= contextPath %>/SendMessage" method="post">
                                                                <input type="text" name="targetUser"
                                                                       value="${account.getUsername()}" readonly hidden>
                                                                <div class="input-group button">
                                                                    <input type="text" class="form-control"
                                                                           placeholder="Type a replay"
                                                                           aria-describedby="sendMessage"
                                                                           name="message">
                                                                    <div class="input-group-append">
                                                                        <button class="btn btn-dark" type="submit"
                                                                                id="sendMessage">Send
                                                                        </button>
                                                                    </div>
                                                                </div>
                                                            </form>
                                                        </div>

                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-danger"
                                                                    data-dismiss="modal">Close
                                                            </button>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </c:if>
                                </c:if>
                                <c:if test="${account.getAccountType() eq 'GROUP'}">
                                    <div class="col-md-3">
                                        <p class="font-weight-bold" style="margin-top: 27%">${account.getIdGroup()}</p>
                                    </div>
                                    <c:if test="${account.getGroupPrivacy() ne 'private' and isImInvited eq false and isImMember eq false and isRequestSent eq false}">
                                        <div class="col-md-4 text-right">
                                            <form action="<%=contextPath%>/AddRequest" method="post">
                                                <input type="text" value="${account.getIdGroup()}" name="id" readonly
                                                       hidden>
                                                <input type="text" value="${account.getAccountType()}" name="type"
                                                       readonly hidden>
                                                <button class="btn btn-warning" style="margin-top: 20%">+ Send Request
                                                </button>
                                            </form>
                                        </div>
                                    </c:if>
                                </c:if>
                            </div>
                        </div>

                    </div>
                </div>
            </section>


            <section class="col-md-6 mt-3" style="margin-left: 26%;">
                <div class="card">
                    <div class="card-header">
                        About
                    </div>
                    <c:if test="${account.getAccountType() eq 'USER'}">
                        <div class="card-body col-md-11">
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

<c:if test="${idGroup eq null}">
    <nav>
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
    </nav>
</c:if>

<c:if test="${idGroup ne null}">
    <nav>
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
                                        <label for="gDateCreate" class="font-weight-bold col-md-12 mt-4">Date
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
                                        <input class="form-control col-md-12 mt-3" id="gDateCreate" name="dateCreate"
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
    </nav>
</c:if>

<footer>
    <nav class="navbar navbar-light navbar-expand-md shadow"
         style="background-color: #d3c7cd ; height: 10em;margin-top: 20em;">
        <div class="navbar-nav">
            <div class="navbar-text">
                Louay Amr © 2020
            </div>
        </div>
    </nav>
</footer>

</body>
</html>