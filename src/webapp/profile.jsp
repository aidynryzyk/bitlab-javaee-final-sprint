<%@ page import="dao.UserDAO" %>
<%@ page import="entity.User" %><%--
  Created by IntelliJ IDEA.
  User: aidyninho
  Date: 28.04.2023
  Time: 10:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Profile</title>
</head>
<body>
<div class="container">
    <jsp:include page="navbar.jsp"></jsp:include>
    <%
        User user = (User) request.getSession().getAttribute("user");
        UserDAO userDAO = new UserDAO();
    %>
    <div style="margin-top: 85px">
        <figure class="text-center mt-5">
            <blockquote class="blockquote">
                <p class="h1"><strong>Hello, <%=user.getFullName()%>!</strong></p>
                <p class="text-body-secondary">Email: <%=user.getEmail()%>
                </p>
                <p class="text-body-secondary">Role: <%=userDAO.getRoleName(user.getRole())%>
                </p>
            </blockquote>
        </figure>
        <div>
            <!-- Button trigger modal -->
            <div class="d-flex justify-content-center">
                <button type="button" class="btn btn-dark" data-bs-toggle="modal" data-bs-target="#exampleModal">
                    Edit profile
                </button>
            </div>

            <!-- Modal -->
            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalLabel">Edit profile</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="/profile" method="post">
                                <div class="mb-3">
                                    <label for="exampleFormControlInput1" class="form-label">Email address</label>
                                    <input type="email" class="form-control" name="email" id="exampleFormControlInput1"
                                           value="<%=user.getEmail()%>">
                                </div>
                                <div class="mb-3">
                                    <label for="exampleFormControlInput2" class="form-label">Password</label>
                                    <input type="password" class="form-control" name="password"
                                           id="exampleFormControlInput2" value="<%=user.getPassword()%>">
                                </div>
                                <div class="mb-3">
                                    <label for="exampleFormControlInput3" class="form-label">Full name</label>
                                    <input type="text" class="form-control" name="name" id="exampleFormControlInput3"
                                           value="<%=user.getFullName()%>">
                                </div>
                                <div class="mb-3">
                                    <label for="exampleFormControlInput4" class="form-label">Role</label>
                                    <select class="form-select" id="exampleFormControlInput4" name="role"
                                            aria-label="Default select example">
                                        <option selected value="2">User</option>
                                        <option value="1">Admin</option>
                                    </select>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close
                                    </button>
                                    <button type="submit" class="btn btn-dark">Save changes</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
