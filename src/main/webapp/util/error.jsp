<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isErrorPage="true" %>
<% StringBuilder contextPath = new StringBuilder(request.getContextPath()); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <style>
        @import url(<%= contextPath %>/libr/bootstrap-4.4.1/css/bootstrap.min.css);
        @import url(<%= contextPath %>/libr/bootstrap-formHelper-2.3.0/dist/css/bootstrap-formhelpers.min.css);
    </style>
    <script src="<%= contextPath %>/libr/jQuery-3.4.1/jquery.min.js"></script>
    <script src="<%= contextPath %>/libr/popper-1.16/popper.js"></script>
    <script src="<%= contextPath %>/libr/bootstrap-4.4.1/js/bootstrap.bundle.min.js"></script>
    <script src="<%= contextPath %>/libr/bootstrap-formHelper-2.3.0/dist/js/bootstrap-formhelpers.min.js"></script>
    <title>Error! `by Louay Amr`</title>
</head>
<body>
<div class="float-right">
    <img src="<%= contextPath %>/util/img/broken_robot.png" height="420" width="420" style="margin-top: 27%">
</div>
<div class="float-left ml-5 col-md-7" style="margin-top: 10%;">
    <p class="font-weight-bold text-left text-warning h2">Chatting system</p>
    <p class="font-weight-bold h5">Sorry but Exception is occurred!</p>
    <p class="mt-5">
        <label class="font-weight-bold"><%= exception%>
        </label><label class="text-muted">, That's an error.</label>
    </p>
    <p class="mt-5">
        <label class="font-weight-bold "><%= exception.getMessage()%>
        </label><label class="text-muted">. That's all we know.</label>
    </p>
</div>
</body>
</html>