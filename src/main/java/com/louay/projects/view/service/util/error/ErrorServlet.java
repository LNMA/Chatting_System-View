package com.louay.projects.view.service.util.error;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class ErrorServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Exception exception = (Exception) req.getAttribute("javax.servlet.error.exception");
        String exceptionMessage = (String) req.getAttribute("javax.servlet.error.message");
        Integer statusCode = (Integer) req.getAttribute("javax.servlet.error.status_code");
        String servletName = (String) req.getAttribute("javax.servlet.error.servlet_name");

        if (servletName == null) {
            servletName = "Unknown";
        }
        String requestUri = (String)
                req.getAttribute("javax.servlet.error.request_uri");

        if (requestUri == null) {
            requestUri = "Unknown";
        }

        PrintWriter out = resp.getWriter();
        resp.setContentType("text/html");
        out.print("<!DOCTYPE html>\n" +
                "<html lang=\"en\">\n" +
                "<head>\n" +
                "    <meta charset=\"utf-8\">\n" +
                "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1, shrink-to-fit=no\">\n" +
                "    <style>\n" +
                "        @import url(libr/bootstrap-4.4.1/css/bootstrap.min.css);\n" +
                "        @import url(libr/bootstrap-formHelper-2.3.0/dist/css/bootstrap-formhelpers.min.css);\n" +
                "    </style>\n" +
                "    <script src=\"libr/jQuery-3.4.1/jquery.min.js\"></script>\n" +
                "    <script src=\"libr/popper-1.16/popper.js\"></script>\n" +
                "    <script src=\"libr/bootstrap-4.4.1/js/bootstrap.bundle.min.js\"></script>\n" +
                "    <script src=\"libr/bootstrap-formHelper-2.3.0/dist/js/bootstrap-formhelpers.min.js\"></script>\n" +
                "    <title>Error! `by Louay Amr`</title>\n" +
                "</head>\n" +
                "<body>\n" +
                "<div class=\"float-right\">\n" +
                "    <img src=\"util/img/broken_robot.png\" height=\"420\" width=\"420\" style=\"margin-top: 27%\">\n" +
                "</div>\n" +
                "<div class=\"float-left ml-5 col-md-7\" style=\"margin-top: 10%;\">\n" +
                "    <p class=\"font-weight-bold text-left text-warning h2\">Chatting system</p>\n" +
                "    <p class=\"font-weight-bold h5\">Sorry but Exception is occurred!</p>\n" +
                "    <p class=\"mt-5\">\n" +
                "        <label class=\"font-weight-bold\">" + statusCode + ", " + exception + "\n" +
                "        </label><label class=\"text-muted\">, That's an error.</label>\n" +
                "    </p>\n" +
                "    <p class=\"mt-5\">\n" +
                "        <label class=\"font-weight-bold \">" + requestUri + ", " + servletName + ", " + exceptionMessage + "\n" +
                "        </label><label class=\"text-muted\">. That's all we know.</label>\n" +
                "    </p>\n" +
                "</div>\n" +
                "</body>\n" +
                "</html>");
        out.flush();
        out.close();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Exception exception = (Exception) req.getAttribute("javax.servlet.error.exception");
        String exceptionMessage = (String) req.getAttribute("javax.servlet.error.message");
        Integer statusCode = (Integer) req.getAttribute("javax.servlet.error.status_code");
        String servletName = (String) req.getAttribute("javax.servlet.error.servlet_name");

        if (servletName == null) {
            servletName = "Unknown";
        }
        String requestUri = (String)
                req.getAttribute("javax.servlet.error.request_uri");

        if (requestUri == null) {
            requestUri = "Unknown";
        }

        PrintWriter out = resp.getWriter();
        resp.setContentType("text/html");
        out.print("<!DOCTYPE html>\n" +
                "<html lang=\"en\">\n" +
                "<head>\n" +
                "    <meta charset=\"utf-8\">\n" +
                "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1, shrink-to-fit=no\">\n" +
                "    <style>\n" +
                "        @import url(libr/bootstrap-4.4.1/css/bootstrap.min.css);\n" +
                "        @import url(libr/bootstrap-formHelper-2.3.0/dist/css/bootstrap-formhelpers.min.css);\n" +
                "    </style>\n" +
                "    <script src=\"libr/jQuery-3.4.1/jquery.min.js\"></script>\n" +
                "    <script src=\"libr/popper-1.16/popper.js\"></script>\n" +
                "    <script src=\"libr/bootstrap-4.4.1/js/bootstrap.bundle.min.js\"></script>\n" +
                "    <script src=\"libr/bootstrap-formHelper-2.3.0/dist/js/bootstrap-formhelpers.min.js\"></script>\n" +
                "    <title>Error! `by Louay Amr`</title>\n" +
                "</head>\n" +
                "<body>\n" +
                "<div class=\"float-right\">\n" +
                "    <img src=\"util/img/broken_robot.png\" height=\"420\" width=\"420\" style=\"margin-top: 27%\">\n" +
                "</div>\n" +
                "<div class=\"float-left ml-5 col-md-7\" style=\"margin-top: 10%;\">\n" +
                "    <p class=\"font-weight-bold text-left text-warning h2\">Chatting system</p>\n" +
                "    <p class=\"font-weight-bold h5\">Sorry but Exception is occurred!</p>\n" +
                "    <p class=\"mt-5\">\n" +
                "        <label class=\"font-weight-bold\">" + statusCode + ", " + exception + "\n" +
                "        </label><label class=\"text-muted\">, That's an error.</label>\n" +
                "    </p>\n" +
                "    <p class=\"mt-5\">\n" +
                "        <label class=\"font-weight-bold \">" + requestUri + ", " + servletName + ", " + exceptionMessage + "\n" +
                "        </label><label class=\"text-muted\">. That's all we know.</label>\n" +
                "    </p>\n" +
                "</div>\n" +
                "</body>\n" +
                "</html>");
        out.flush();
        out.close();
    }
}
