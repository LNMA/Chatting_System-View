<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="../util/error.jsp" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.time.LocalDateTime" %>

<%! String idGroupSession; %>
<%! String memberTypeSession; %>
<%! String usernameSession;%>
<%! String passwordSession;%>
<%
    idGroupSession = request.getParameter("idGroup");
    session.setAttribute("idGroup", idGroupSession);
    idGroupSession = request.getParameter("type");
    session.setAttribute("memberType", memberTypeSession);
    usernameSession = (String) session.getAttribute("username");
    passwordSession = (String) session.getAttribute("password");
    StringBuilder contextPath = new StringBuilder(request.getContextPath());

    Calendar calendar = Calendar.getInstance();
    calendar.setTimeInMillis(session.getCreationTime());
    LocalDateTime sessionCreate = LocalDateTime.of(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH),
            calendar.get(Calendar.DAY_OF_MONTH), calendar.get(Calendar.HOUR), calendar.get(Calendar.MINUTE),
            calendar.get(Calendar.SECOND));

    if (sessionCreate.plusMinutes(40).compareTo(LocalDateTime.now()) > 0) {
        session = request.getSession(true);
        session.setAttribute("username", usernameSession);
        session.setAttribute("password", passwordSession);
        session.setAttribute("idGroup", idGroupSession);
        session.setAttribute("memberType", memberTypeSession);
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
    <title>Edit Post 'by Louay Amr'</title>
</head>
<body class="background">

<header>
    <nav class="navbar navbar-expand-lg mb-0 shadow text-left position-relative"
         style="background-color: #3e3c4e ;height: 6em; width: 100%">
        <p class="text-light h3 font-weight-bold">Edit Post</p>
    </nav>
</header>

<main class="mt-3 col-md-12">

    <article class="mr-3">

        <jsp:include page="/GetUserEditPost"></jsp:include>
        <c:forEach items="${editPostSet}" var="post">

            <c:if test="${post.getType() eq 'TEXT_POST'}">
                <section class="col-md-9" style="margin-left: 14%">
                    <div class="card">
                        <div class="card-body" id="editTxtPost">
                            <form class="form-group" action="<%= contextPath %>/EditUserTextPost" method="post">
                                <input type="text" value="${post.getIdPost()}" name="idPost" hidden readonly>
                                <input type="text" value="${post.getClassName()}" name="postClassName" hidden readonly>
                                <textarea class="form-control" data-toggle="collapse"
                                          name="post">${post.getPost()}</textarea>
                                <button class="btn btn-warning mt-2 col-md-1" type="submit" name="post" value="Post">
                                    Edit
                                </button>
                            </form>
                        </div>
                    </div>
                </section>
            </c:if>

            <c:if test="${post.getType() eq 'IMG_POST'}">
                <section class="col-md-9" style="margin-left: 14%">
                    <div class="card">
                        <div class="card-body">
                            <img src="data:image;base64,${post.getBase64()}" class="card-img-top"/>
                            <br>
                            <br>
                            <form class="form-group" action="<%= contextPath %>/EditUserImgPost" method="post"
                                  enctype="multipart/form-data">
                                <input type="text" value="${post.getIdPost()}" name="idPost" hidden readonly>
                                <input type="text" value="${post.getClassName()}" name="postClassName" hidden readonly>
                                <div class="custom-file">
                                    <input type="file" class="custom-file-input" id="editImgPost" name="filename" accept="image/*">
                                    <label class="custom-file-label" for="editImgPost">Choose file...</label>
                                </div>
                                <script>
                                    // Add the following code if you want the name of the file appear on select \n' +
                                    $(".custom-file-input").on("change", function () {
                                        var fileName = $(this).val().split("\\").pop();
                                        $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
                                    });
                                </script>
                                <button class="btn btn-warning mt-2 col-md-1" type="submit" value="post">Edit</button>
                            </form>
                        </div>
                    </div>
                </section>
            </c:if>
        </c:forEach>

    </article>

</main>
<footer style="padding-top: 31em;">
    <nav class="navbar"
         style="background-color: #d3c7cd; height: 11em; width: 100%;">
        <p>Louay Amr © 2020</p>
    </nav>
</footer>


</body>
</html>