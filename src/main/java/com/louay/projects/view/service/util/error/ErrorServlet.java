package com.louay.projects.view.service.util.error;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class ErrorServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Exception exception = (Exception) request.getAttribute("javax.servlet.error.exception");
        String exceptionMessage = (String) request.getAttribute("javax.servlet.error.message");
        Integer statusCode = (Integer) request.getAttribute("javax.servlet.error.status_code");
        String servletName = (String) request.getAttribute("javax.servlet.error.servlet_name");

        if (servletName == null) {
            servletName = "Unknown";
        }
        String requestUri = (String)
                request.getAttribute("javax.servlet.error.request_uri");

        if (requestUri == null) {
            requestUri = "Unknown";
        }

        PrintWriter out = response.getWriter();
        response.setContentType("text/html");
        out.print("<!DOCTYPE html>\n" +
                "<html lang=\"en\">\n" +
                "<head>\n" +
                "    <meta charset=\"utf-8\">\n" +
                "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1, shrink-to-fit=no\">\n" +
                "    <style>\n" +
                "        @import url(" + request.getContextPath() + "/libr/bootstrap-4.4.1/css/bootstrap.min.css);\n" +
                "        @import url(" + request.getContextPath() + "/libr/bootstrap-formHelper-2.3.0/dist/css/bootstrap-formhelpers.min.css);\n" +
                "    </style>\n" +
                "    <script src=\"" + request.getContextPath() + "/libr/jQuery-3.4.1/jquery.min.js\"></script>\n" +
                "    <script src=\"" + request.getContextPath() + "/libr/popper-1.16/popper.js\"></script>\n" +
                "    <script src=\"" + request.getContextPath() + "/bootstrap-4.4.1/js/bootstrap.bundle.min.js\"></script>\n" +
                "    <script src=\"" + request.getContextPath() + "/libr/bootstrap-formHelper-2.3.0/dist/js/bootstrap-formhelpers.min.js\"></script>\n" +
                "    <title>Error! `by Louay Amr`</title>\n" +
                "</head>\n" +
                "<body>\n" +
                "<div class=\"float-right\">\n" +
                "    <img src=\"" + request.getContextPath() + "/util/img/broken_robot.png\" height=\"420\" width=\"420\" style=\"margin-top: 27%\">\n" +
                "</div>\n" +
                "<div class=\"float-left ml-5 col-md-7\" style=\"margin-top: 10%;\">\n" +
                "    <p class=\"font-weight-bold text-left text-warning h2\">Chatting system</p>\n" +
                "    <p class=\"font-weight-bold h5\">Sorry but Exception is occurred!</p>\n" +
                "<p class=\"font-weight-bolder h5 mt-3\">"+statusCode+"</p>"+
                "    <p class=\"mt-4\">\n" +
                "        <label class=\"font-weight-bold\">" +exception + "<label class=\"text-muted\">, That's an error.</label></label>" +
                "    </p>\n" +
                "    <p class=\"mt-5\">\n" +
                "        <label class=\"font-weight-bold \"> URI: " + requestUri + ", Servlet Name:" + servletName + ", Message" + exceptionMessage +"<label class=\"text-muted\">. That's all we know.</label></label>" +
                "    </p>\n" +
                "</div>\n" +
                "</body>\n" +
                "</html>");
        out.flush();
        out.close();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Exception exception = (Exception) request.getAttribute("javax.servlet.error.exception");
        String exceptionMessage = (String) request.getAttribute("javax.servlet.error.message");
        Integer statusCode = (Integer) request.getAttribute("javax.servlet.error.status_code");
        String servletName = (String) request.getAttribute("javax.servlet.error.servlet_name");

        if (servletName == null) {
            servletName = "Unknown";
        }
        String requestUri = (String)
                request.getAttribute("javax.servlet.error.request_uri");

        if (requestUri == null) {
            requestUri = "Unknown";
        }

        PrintWriter out = response.getWriter();
        response.setContentType("text/html");
        out.print("<!DOCTYPE html>\n" +
                "<html lang=\"en\">\n" +
                "<head>\n" +
                "    <meta charset=\"utf-8\">\n" +
                "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1, shrink-to-fit=no\">\n" +
                "    <style>\n" +
                "        @import url(" + request.getContextPath() + "/libr/bootstrap-4.4.1/css/bootstrap.min.css);\n" +
                "        @import url(" + request.getContextPath() + "/libr/bootstrap-formHelper-2.3.0/dist/css/bootstrap-formhelpers.min.css);\n" +
                "    </style>\n" +
                "    <script src=\"" + request.getContextPath() + "/libr/jQuery-3.4.1/jquery.min.js\"></script>\n" +
                "    <script src=\"" + request.getContextPath() + "/libr/popper-1.16/popper.js\"></script>\n" +
                "    <script src=\"" + request.getContextPath() + "/bootstrap-4.4.1/js/bootstrap.bundle.min.js\"></script>\n" +
                "    <script src=\"" + request.getContextPath() + "/libr/bootstrap-formHelper-2.3.0/dist/js/bootstrap-formhelpers.min.js\"></script>\n" +
                "    <title>Error! `by Louay Amr`</title>\n" +
                "</head>\n" +
                "<body>\n" +
                "<div class=\"float-right\">\n" +
                "    <img src=\"" + request.getContextPath() + "/util/img/broken_robot.png\" height=\"420\" width=\"420\" style=\"margin-top: 27%\">\n" +
                "</div>\n" +
                "<div class=\"float-left ml-5 col-md-7\" style=\"margin-top: 10%;\">\n" +
                "    <p class=\"font-weight-bold text-left text-warning h2\">Chatting system</p>\n" +
                "    <p class=\"font-weight-bold h5\">Sorry but Exception is occurred!</p>\n" +
                "<p class=\"font-weight-bolder h5 mt-3\">"+statusCode+"</p>"+
                "    <p class=\"mt-4\">\n" +
                "        <label class=\"font-weight-bold\">" +exception + "<label class=\"text-muted\">, That's an error.</label></label>" +
                "    </p>\n" +
                "    <p class=\"mt-5\">\n" +
                "        <label class=\"font-weight-bold \"> URI: " + requestUri + ", Servlet Name:" + servletName + ", Message" + exceptionMessage +"<label class=\"text-muted\">. That's all we know.</label></label>" +
                "    </p>\n" +
                "</div>\n" +
                "</body>\n" +
                "</html>");
        out.flush();
        out.close();
    }

    @Override
    public String getServletInfo() {
        return "Error Occurred!";
    }
}
