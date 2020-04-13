<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page errorPage="../util/error.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="com.louay.projects.model.chains.util.PictureDirection" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.time.LocalDateTime" %>
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

    Calendar calendar = Calendar.getInstance();
    calendar.setTimeInMillis(session.getCreationTime());
    LocalDateTime sessionCreate = LocalDateTime.of(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH),
            calendar.get(Calendar.DAY_OF_MONTH), calendar.get(Calendar.HOUR), calendar.get(Calendar.MINUTE), calendar.get(Calendar.SECOND));

    if (usernameSession == null || passwordSession == null || (sessionCreate.plusMinutes(59).compareTo(LocalDateTime.now()) > 0)) {
        response.sendRedirect("..\\signin\\login.jsp");
    }
%>

<%
    @SuppressWarnings(value = "unchecked")
    List<PictureDirection> list = (List<PictureDirection>) session.getAttribute("friendList");
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<style>
        @import url(../libr/bootstrap-4.4.1/css/bootstrap.min.css);
        @import url(../client/home-client.css);
        @import url(../libr/bootstrap-formHelper-2.3.0/dist/css/bootstrap-formhelpers.min.css);
    </style>
    <script src="../libr/jQuery-3.4.1/jquery.min.js"></script>
    <script src="../libr/popper-1.16/popper.js"></script>
    <script src="../libr/bootstrap-4.4.1/js/bootstrap.bundle.min.js"></script>
    <script src="../libr/bootstrap-formHelper-2.3.0/dist/js/bootstrap-formhelpers.min.js"></script>
    <script src="../client/home-client.js"></script>
    <title>User Friend `by Louay Amr'</title>
</head>
<body>

<header>
    <nav class="navbar navbar-expand-lg navbar-light static-top mb-0 shadow text-left "
         style="background-color: #3e3c4e ;height: 6em; width: 100%">
        <p class="text-light h3 font-weight-bold">User Friend</p>
    </nav>
</header>

<main class="mainBackground">

    <aside class="aside ml-2">
    </aside>

    <article class="mr-3">
        <%
            String fileName;
            for (PictureDirection dir: list) {
                fileName = "/client/friendImag/"+dir.getFileName();

        %>


        <section class="float-right col-md-9">
            <div class="card">
                <div class="card-body">
                    <div class="form-row">
                        <img src="<%= request.getContextPath()+fileName %>" class="rounded-circle" width="164" height="164"/>
                        <p class="font-weight-bolder h5" style="margin-left: 13%; margin-top: 7%"><%= dir.getUsername() %></p>
                    </div>
                </div>
            </div>
        </section>

       <% } %>

    </article>

</main>

<footer>
    <nav class="navbar navbar-dark position-relative mb-0 .fixed-bottom"
         style="background-color: #d3c7cd; height: 11em; width: 100%;">
        <p>Louay Amr © 2020</p>
    </nav>
</footer>

</body>
</html>
