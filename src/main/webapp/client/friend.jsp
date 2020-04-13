<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page errorPage="../util/error.jsp" %>
<%@page import="com.louay.projects.controller.service.*" %>
<%@ page import="java.util.Set" %>
<%@ page import="com.louay.projects.model.chains.communications.AccountPicture" %>
<%@ page import="com.louay.projects.model.chains.users.Users" %>
<%@ page import="com.louay.projects.model.chains.users.Admin" %>
<jsp:useBean id="context" class="org.springframework.context.annotation.AnnotationConfigApplicationContext"
             scope="application">
    <%
        context.scan("com.louay.projects.model", "com.louay.projects.controller");
        context.refresh();
    %>
</jsp:useBean>

<%
    String username = request.getParameter("username");
    Users users = context.getBean(Admin.class);
    users.setUsername(username);
    FindFriendByUsernameController friendByName = (FindFriendByUsernameController) context.getBean("findFriendByName");
    Set<AccountPicture> friend = friendByName.execute(users);

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
            for (AccountPicture pic: friend) {
                int size = (int)pic.getPicture().length();
                byte [] img = pic.getPicture().getBytes(1, size);
                response.setContentType("image/png");
                response.setContentLength(img.length);
        %>


        <section class="float-right col-md-9">
            <div class="card">
                <div class="card-body">
                    <div class="form-row">
                        <img src="<%= response.getOutputStream().write(img) %>" class="rounded-circle" width="164" height="164"/>
                        <p class="font-weight-bolder h5" style="margin-left: 25%; margin-top: 7%"><%= pic.getUsername() %></p>
                    </div>
                </div>
            </div>
        </section>

       <%
            response.getOutputStream().flush();
            };
            response.getOutputStream().close();
       %>

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
