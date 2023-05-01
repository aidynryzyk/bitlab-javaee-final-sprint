<%--
  Created by IntelliJ IDEA.
  User: aidyninho
  Date: 28.04.2023
  Time: 10:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Signup</title>
</head>
<body>
<div class="container">
    <jsp:include page="navbar.jsp"></jsp:include>
    <div style="margin-top: 85px">
        <div class="card text-center">
            <div class="card-header">
                Login Page
            </div>
            <div class="card-body">
                <form method="post" action="/login">
                    <div class="form-group row mb-3">
                        <label class="col-sm-2 col-form-label">Email:</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" name="email">
                        </div>
                    </div>
                    <div class="form-group row mb-3">
                        <label class="col-sm-2 col-form-label">Password:</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" name="password">
                        </div>
                    </div>
                    <div class="form-group row mb-3">
                        <label class="col-sm-2 col-form-label">Full name:</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="fullName">
                        </div>
                    </div>
                    <div class="form-group row mb-3">
                        <label class="col-sm-2 col-form-label">Role:</label>
                        <div class="col-sm-10">
                            <select class="form-select" name="role">
                                <option selected value="2">User</option>
                                <option value="1">Admin</option>
                            </select>
                        </div>
                    </div>
                    <button class="btn btn-dark" type="submit">Sign Up</button>
                </form>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
