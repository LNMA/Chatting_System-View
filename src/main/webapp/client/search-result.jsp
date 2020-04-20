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
        @import url(<%=contextPath%>/libr/bootstrap-4.4.1/css/bootstrap.min.css);
        @import url(<%=contextPath%>/client/home-client.css);
        @import url(<%=contextPath%>/libr/bootstrap-formHelper-2.3.0/dist/css/bootstrap-formhelpers.min.css);
    </style>
    <script src="<%=contextPath%>/libr/jQuery-3.4.1/jquery.min.js"></script>
    <script src="<%=contextPath%>/libr/popper-1.16/popper.js"></script>
    <script src="<%=contextPath%>/libr/bootstrap-4.4.1/js/bootstrap.bundle.min.js"></script>
    <script src="<%=contextPath%>/libr/bootstrap-formHelper-2.3.0/dist/js/bootstrap-formhelpers.min.js"></script>
    <script src="<%=contextPath%>/client/home-client.js"></script>
    <title>User Friend `by Louay Amr'</title>
</head>
<body class="mainBackground">

<header>
    <nav class="navbar navbar-expand-lg mb-0 shadow text-left position-relative"
         style="background-color: #3e3c4e ;height: 6em; width: 100%">
        <p class="text-light h3 font-weight-bold">Search Result</p>
    </nav>
</header>

<main class="mt-3">

    <aside class="aside ml-2">
    </aside>

    <article class="mr-3">

        <jsp:include page="/SearchAccountGroup"></jsp:include>
        <c:forEach items="${searchResult}" var="result">

            <c:if test="${result.getAccountType() eq 'USER'}">
                <section class="col-md-9 mt-2" style="margin-left: 14%">
                    <div class="card">
                        <div class="card-body">
                            <div class="form-row">
                                <img src="data:image/png;base64,${result.getBase64()}" class="rounded-circle"
                                     width="164" height="164"/>
                                <p class="font-weight-bolder h5"
                                   style="margin-left: 13%; margin-top: 7%">${result.getUsername()} </p>
                            </div>
                        </div>
                    </div>
                </section>
            </c:if>

            <c:if test="${result.getAccountType() eq 'GROUP'}">
                <section class="col-md-9 mt-2" style="margin-left: 14%">
                    <div class="card">
                        <div class="card-body">
                            <div class="form-row">
                                <img src="data:image/png;base64,${result.getBase64()}" class="rounded-circle"
                                     width="164" height="164"/>
                                <p class="font-weight-bolder h5"
                                   style="margin-left: 13%; margin-top: 7%">${result.getIdGroup()} </p>
                            </div>
                        </div>
                    </div>
                </section>
            </c:if>
        </c:forEach>

    </article>

</main>
<footer>
    <nav class="navbar"
         style="background-color: #d3c7cd; height: 11em; width: 100%;margin-top: 50%">
        <p>Louay Amr © 2020</p>
    </nav>
</footer>


</body>
</html>