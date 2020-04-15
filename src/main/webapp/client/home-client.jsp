<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.util.Calendar" %>
<%@ page errorPage="../util/error.jsp" %>
<jsp:useBean id="context" class="org.springframework.context.annotation.AnnotationConfigApplicationContext"
             scope="application">
    <%
        context.scan("com.louay.projects.model", "com.louay.projects.controller");
        context.refresh();
    %>
</jsp:useBean>

<%! String usernameSession;%>
<%! String passwordSession;%>
<%
    usernameSession = (String) session.getAttribute("username");
    passwordSession = (String) session.getAttribute("password");
    String contextPath = request.getContextPath();

    Calendar calendar = Calendar.getInstance();
    calendar.setTimeInMillis(session.getCreationTime());
    LocalDateTime sessionCreate = LocalDateTime.of(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH),
            calendar.get(Calendar.DAY_OF_MONTH), calendar.get(Calendar.HOUR), calendar.get(Calendar.MINUTE),
            calendar.get(Calendar.SECOND));

    if (sessionCreate.plusMinutes(58).compareTo(LocalDateTime.now()) > 0){
        session = request.getSession(true);
        session.setAttribute("username", usernameSession);
        session.setAttribute("password", passwordSession);
        response.sendRedirect(contextPath+"\\signin\\login.jsp");
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
<body>

<header>
    <nav class="navbar navbar-expand-lg navbar-light static-top mb-0 shadow text-left "
         style="background-color: #3e3c4e ;height: 6em; width: 100%">


        <p class="text-light h4 font-weight-bold col-md-2">Chatting system</p>
        <p class="text-light mt-3 font-weight-bold col-md-1"><a class="nav-link navLinkHover" href="<%= contextPath %>/signin/login.jsp">Home</a></p>
        <p class="text-light mt-3 font-weight-bold col-md-1"><a class="nav-link navLinkHover" href="<%= contextPath %>/ViewMyFriend">Friend</a></p>
        <p class="text-light mt-3 font-weight-bold col-md-1">Inbox<span class="badge badge-primary badge-pill">14</span>
        </p>

        <form class="form-inline col-md-5" action="">
            <input class="form-control mr-sm-2 w-75" type="text" placeholder="Search" name="search">
            <button class="btn btn-success " type="submit">Search &telrec;</button>
        </form>

        <form class="col-md-1">
            <button class="btn btn-outline-info" type="submit">
                <span class="badge badge-primary badge-pill mb-0 ">14</span>
                <img class="mt-0" src="<%= contextPath %>/client/img/message-white-48dp.svg" id="messageImg" height="24" width="24"/>
            </button>
        </form>

        <div class="dropdown col-md-2">
            <button type="button" class="btn btn-link dropdown-toggle-split" data-toggle="dropdown">
                <img src="<%= contextPath %>/client/img/account_circle-white-48dp.svg" class="rounded-circle mr-0" width="72"
                     height="72"/>&blacktriangledown;
            </button>
            <div class="dropdown-menu">
                <form  >
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

<main class="mainBackground">

    <aside class="aside ml-2">

        <div class="form-row">
            <img src="<%= contextPath %>/GetUserPhoto" class="rounded-circle" width="128" height="128"/>
            <p class="mt-5 mb-0 ml-1 font-weight-bolder h5"> <%= usernameSession %></p>
        </div>
        <hr>
        <div class="form-row ml-2">
            <img src="<%= contextPath %>/client/img/send-black-48dp.svg" width="24" height="24">
            <p class="ml-3">Messages Sent</p>
        </div>
        <div class="form-row ml-2">
            <img src="<%= contextPath %>/client/img/person_add-black-48dp.svg" width="24" height="24">
            <p class="ml-3">Request Sent</p>
        </div>
        <div class="form-row ml-2">
            <img src="<%= contextPath %>/client/img/group-black-48dp.svg" width="24" height="24">
            <p class="ml-3">My Group</p>
        </div>
        <hr>
        <div class="form-text text-muted font-weight-bold ml-2">
            <p>Explore</p>
        </div>
        <div class="form-row ml-2">
            <img src="<%= contextPath %>/client/img/photo_library-black-48dp.svg" width="24" height="24">
            <p class="ml-3">My Photo Album</p>
        </div>
        <div class="form-row ml-2">
            <img src="<%= contextPath %>/client/img/email-black-48dp.svg" width="24" height="24">
            <p class="ml-3">Message</p>
        </div>
    </aside>

    <article class="mr-3">

        <section class="float-right col-md-9">
            <div class="card">
                <div class="card-header">
                    <div class="btn-group btn-toolbar">
                        <button type="button" class="btn btn-outline-info " id="inputStringPost"><img
                                src="<%= contextPath %>/client/img/post_add-black-48dp.svg" class="mb-1" width="30" height="30"/>
                            Creat Post
                        </button>
                        <button type="button" class="btn btn-outline-info " id="inputImg"><img
                                src="<%= contextPath %>/client/img/photo_size_select_actual-black-48dp.svg" class="mb-1" width="30"
                                height="30"/>
                            Photo
                        </button>
                    </div>
                </div>
                <div class="card-body" id="addPost" hidden></div>
            </div>
        </section>

        <jsp:include page="/GetUserTextPost"></jsp:include>
        <c:forEach items="${userTextPost}" var="post">
                <section class="col-md-9 mt-3 float-right">
                    <div class="card">
                        <div class="card-header text-muted">
                                Posted at : ${post.getPostDate()}
                        </div>
                        <div class="card-body">
                                ${post.getPost()}
                        </div>
                    </div>
                </section>
            </c:forEach>


    </article>

</main>

<footer>
    <nav class="navbar navbar-dark position-relative mb-0 fixed-bottom"
         style="background-color: #d3c7cd; height: 11em; width: 100%;">
        <p>Louay Amr © 2020</p>
    </nav>
</footer>

</body>
</html>