<%@ page import="com.louay.projects.controller.service.SignInController" %>
<%@ page import="com.louay.projects.model.chains.users.Users" %>
<%@ page import="com.louay.projects.model.chains.users.Admin" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<%! String usernameCookie; %>
<%! String passwordCookie; %>
<%
    Cookie[] cookies = request.getCookies();
    for (Cookie cookie : cookies) {
        if (cookie.getName() != null) {
            if (cookie.getName().equals("username")) {
                if (cookie.getValue() != null) {
                    usernameCookie = cookie.getValue();
                }
            } else if (cookie.getName().equals("password")) {
                if (cookie.getValue() != null) {
                    passwordCookie = cookie.getValue();
                }
            }
        }
    }
    usernameSession = (String) session.getAttribute("username");
    passwordSession = (String) session.getAttribute("password");
%>
<%
    if (usernameCookie != null && passwordCookie != null) {
        if (usernameCookie.length() >= 4 && passwordCookie.length() > 7) {
            session.setAttribute("username", usernameCookie);
            session.setAttribute("password", passwordCookie);
            Users users = context.getBean(Admin.class);
            users.setUsername(usernameCookie);
            users.setPassword(passwordCookie);
            SignInController signInController = (SignInController) context.getBean("isSignUp");
            boolean isSignUp = signInController.isSignUp(users);
            if (isSignUp) {
                response.sendRedirect("..\\client\\home-client.jsp");
            }
        }
    } else if (usernameSession == null || passwordSession == null) {
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <style>
        @import url(../libr/bootstrap-4.4.1/css/bootstrap.min.css);
        @import url(../signin/login.css);
    </style>
    <script src="../libr/jQuery-3.4.1/jquery.min.js"></script>
    <script src="../libr/popper-1.16/popper.js"></script>
    <script src="../libr/bootstrap-4.4.1/js/bootstrap.bundle.min.js"></script>
    <script src="../signin/login.js"></script>
    <title>Login to Chatting`by Louay Amr`</title>
</head>
<body>

<header>
    <nav class="navbar navbar-expand-lg navbar-light static-top mb-0 shadow text-center position-relative"
         style="background-color: #3e3c4e ;height: 6em; width: 100%">
        <p class="text-light text-capitalize h1">Login</p>
    </nav>
</header>

<main>
    <div class="mainBody">

        <div id="topAlert"></div>

        <% if (session.getAttribute("isSign") != null){ %>
        <div class="container">
            <div class="alert alert-danger alert-dismissible" data-dismiss="alert" id="myAlert">
                <button type="button" class="close">&times;</button>
                <strong>Error!</strong> Username or password seem wrong, try again.
            </div>
        </div>
        <%}%>

        <div class="formSignIn">
            <div class="internalForm">

                <form action="../SignIn" method="post" name="signInform"
                      onsubmit="return signInvalidateForm()">

                    <div class="form-group ">
                        <label class="mb-0 h3 text-left formHead" style="margin-top: 5%">Sign in to chatting
                            System</label>
                        <small class="form-text text-muted text-left">all field required</small>
                    </div>

                    <div class="form-group">
                        <input class="form-control w-75 " type="text" name="username" maxlength="30"
                               placeholder="Type your username"/>
                    </div>

                    <div class="form-group">
                        <input class="form-control w-75 " type="password" name="password" maxlength="30"
                               placeholder="Type your password"/>
                    </div>
                    <div class="form-row ">
                        <div class="custom-control custom-checkbox mt-1">
                            <input type="checkbox" class="custom-control-input" id="inputRemember" name="rememberMe"
                                   value="remember">
                            <label class="custom-control-label float-left" for="inputRemember">Remember Me</label>
                        </div>
                        <input type="submit" class="btn btn-primary" style="margin-left: 34%" value="Sign in"/>
                    </div>
                </form>

                <div style="margin-right: 25%">
                    <hr>
                    <p>If this is first time <a href="../signup/signup.html">Sign Up</a></p>
                </div>

            </div>
        </div>
    </div>
</main>

<footer>
    <nav class="navbar navbar-dark position-relative mb-0" style="background-color: #d3c7cd; height: 9em; width: 100%">
        <p>Louay Amr © 2020</p>
    </nav>
</footer>

</body>
</html>
<%
} else if (usernameSession.length() < 4 || passwordSession.length() < 7) {
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <style>
        @import url(../libr/bootstrap-4.4.1/css/bootstrap.min.css);
        @import url(../signin/login.css);
    </style>
    <script src="../libr/jQuery-3.4.1/jquery.min.js"></script>
    <script src="../libr/popper-1.16/popper.js"></script>
    <script src="../libr/bootstrap-4.4.1/js/bootstrap.bundle.min.js"></script>
    <script src="../signin/login.js"></script>
    <title>Login to Chatting`by Louay Amr`</title>
</head>
<body>

<header>
    <nav class="navbar navbar-expand-lg navbar-light static-top mb-0 shadow text-center position-relative"
         style="background-color: #3e3c4e ;height: 6em; width: 100%">
        <p class="text-light text-capitalize h1">Login</p>
    </nav>
</header>

<main>
    <div class="mainBody">

        <div id="topAlert"></div>

        <% if (session.getAttribute("isSign") != null){ %>
           <div class="container">
                    <div class="alert alert-danger alert-dismissible" data-dismiss="alert" id="myAlert">
                        <button type="button" class="close">&times;</button>
                        <strong>Error!</strong> Username or password seem wrong, try again.
                    </div>
            </div>
            <%}%>

        <div class="formSignIn">
            <div class="internalForm">

                <form action="../SignIn" method="post" name="signInform"
                      onsubmit="return signInvalidateForm()">

                    <div class="form-group ">
                        <label class="mb-0 h3 text-left formHead" style="margin-top: 5%">Sign in to chatting
                            System</label>
                        <small class="form-text text-muted text-left">all field required</small>
                    </div>

                    <div class="form-group">
                        <input class="form-control w-75 " type="text" name="username" maxlength="30"
                               placeholder="Type your username"/>
                    </div>

                    <div class="form-group">
                        <input class="form-control w-75 " type="password" name="password" maxlength="30"
                               placeholder="Type your password"/>
                    </div>
                    <div class="form-row ">
                        <div class="custom-control custom-checkbox mt-1">
                            <input type="checkbox" class="custom-control-input" id="inputRemember" name="rememberMe"
                                   value="remember">
                            <label class="custom-control-label float-left" for="inputRemember">Remember Me</label>
                        </div>
                        <input type="submit" class="btn btn-primary" style="margin-left: 34%" value="Sign in"/>
                    </div>
                </form>

                <div style="margin-right: 25%">
                    <hr>
                    <p>If this is first time <a href="../signup/signup.html">Sign Up</a></p>
                </div>

            </div>
        </div>
    </div>
</main>

<footer>
    <nav class="navbar navbar-dark position-relative mb-0" style="background-color: #d3c7cd; height: 9em; width: 100%">
        <p>Louay Amr © 2020</p>
    </nav>
</footer>

</body>
</html>

<%
    } else {
        response.sendRedirect("..\\client\\home-client.jsp");
    }
%>

