<%@ page import="dao.NewsDAO" %>
<%@ page import="entity.User" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: aidyninho
  Date: 25.04.2023
  Time: 19:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
    <title>Navbar</title>
</head>
<body>
<div>
    <nav class="navbar navbar-expand-lg fixed-top bg-dark" data-bs-theme="dark">
        <div class="container">
            <a class="navbar-brand" href="#">
                <img src="logo2.png" alt="logo" width="40" height="40">
                bitlab news
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                    aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav nav-underline me-auto mb-2 mb-lg-0">
                    <%
                        User user = (User) request.getSession().getAttribute("user");
                        NewsDAO newsDAO = new NewsDAO();
                        List<String> categories = newsDAO.getAllCategories();
                        int show = request.getParameter("show") == null ? 0 : Integer.parseInt(request.getParameter("show"));

                        if (show == 1) {
                    %>
                    <li class="nav-item">
                        <a class="nav-link active" href="/news?show=1&page=0">Top</a>
                    </li>
                    <%
                    } else {
                    %>
                    <li class="nav-item">
                        <a class="nav-link" href="/news?show=1&page=0">Top</a>
                    </li>
                    <%
                        }
                        if (show == 2) {
                    %>
                    <li class="nav-item">
                        <a class="nav-link active" href="/news?show=2&page=0">Hot</a>
                    </li>
                    <%
                    } else {
                    %>
                    <li class="nav-item">
                        <a class="nav-link" href="/news?show=2&page=0">Hot</a>
                    </li>
                    <%
                        }
                        if (show == 3) {
                    %>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle active" href="/news?show=3&page=0" role="button"
                           data-bs-toggle="dropdown" aria-expanded="false">
                            Categories
                        </a>
                        <ul class="dropdown-menu">
                            <%
                                for (int i = 0; i < categories.size(); i++) {
                            %>
                            <li><a class="dropdown-item"
                                   href="/news?show=3&page=0&category=<%=i + 1%>"><%=categories.get(i)%>
                            </a></li>
                            <%
                                }
                            %>
                        </ul>
                    </li>
                    <%
                    } else {
                    %>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="/news?show=3&page=0" role="button"
                           data-bs-toggle="dropdown" aria-expanded="false">
                            Categories
                        </a>
                        <ul class="dropdown-menu">
                            <%
                                for (int i = 0; i < categories.size(); i++) {
                            %>
                            <li><a class="dropdown-item"
                                   href="/news?show=3&page=0&category=<%=i + 1%>"><%=categories.get(i)%>
                            </a></li>
                            <%
                                }
                            %>
                        </ul>
                    </li>
                    <%
                        }
                        if (show == 5) {
                            if (user == null) {
                    %>
                    <a class="nav-link active" href="/login?show=5">Sign In</a>
                    <%
                    } else {
                    %>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle active" role="button" data-bs-toggle="dropdown"
                           aria-expanded="false">
                            <%=user.getFullName()%>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="/profile?show=5">Profile</a></li>
                            <li><a class="dropdown-item" href="/logout">Log out</a></li>
                        </ul>
                    </li>
                    <%
                        }
                    } else {
                        if (user == null) {
                    %>
                    <a class="nav-link" href="/login?show=5">Sign In</a>
                    <%
                    } else {
                    %>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" role="button" data-bs-toggle="dropdown"
                           aria-expanded="false">
                            <%=user.getFullName()%>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="/profile?show=5">Profile</a></li>
                            <li><a class="dropdown-item" href="/logout">Log out</a></li>
                        </ul>
                    </li>
                    <%
                            }
                        }
                        if (user == null) {
                    %>
                    <a class="nav-link" href="/login?signup=1">Sign Up</a>
                    <%
                        }
                    %>
                </ul>
                <form class="d-flex" method="get" action="/news">
                    <input type="hidden" name="show" value="4">
                    <input type="hidden" name="page" value="0">
                    <input class="form-control me-2" name="search" placeholder="Search" aria-label="Search">
                    <button class="btn btn-outline-light" type="submit">Search</button>
                </form>
            </div>
        </div>
    </nav>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>
</body>
</html>
