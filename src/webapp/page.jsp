<%@ page import="dao.NewsDAO" %>
<%@ page import="entity.User" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: aidyninho
  Date: 26.04.2023
  Time: 10:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Page</title>
</head>
<body class="bg-light">
<div class="container">
    <%
        User user = (User) request.getSession().getAttribute("user");
        NewsDAO newsDAO = new NewsDAO();
    %>
    <jsp:include page="navbar.jsp"></jsp:include>
    <%
        if (user != null && user.getRole() == 1) {
    %>
    <div class="container mb-3" style="margin-top: 85px">
        <div class="d-grid gap-2">
            <button class="btn btn-dark" type="button" data-bs-toggle="modal" data-bs-target="#exampleModal">Add news
            </button>
        </div>
    </div>
    <div class="container">
        <!-- Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Add news</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="/news" method="post">
                            <input type="hidden" name="type" value="add">
                            <input type="hidden" name="show" value="<%=request.getParameter("show")%>">
                            <input type="hidden" name="page" value="<%=request.getParameter("page")%>">
                            <div class="mb-3">
                                <label for="exampleFormControlInput1" class="form-label">Post date</label>
                                <input type="date" class="form-control" name="date" id="exampleFormControlInput1">
                            </div>
                            <div class="mb-3">
                                <label for="exampleFormControlInput2" class="form-label">Category</label>
                                <select class="form-select" id="exampleFormControlInput2" name="category"
                                        aria-label="Default select example">
                                    <%
                                        List<String> categories = newsDAO.getAllCategories();
                                    %>
                                    <option selected value="1"><%=categories.get(0)%>
                                    </option>
                                    <%
                                        for (int i = 1; i < categories.size(); i++) {
                                    %>
                                    <option value="<%=i + 1%>"><%=categories.get(i)%>
                                    </option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="exampleFormControlInput3" class="form-label">Title</label>
                                <input type="text" class="form-control" name="title" id="exampleFormControlInput3">
                            </div>
                            <div class="mb-3">
                                <label for="exampleFormControlInput4" class="form-label">Content</label>
                                <textarea class="form-control" name="content" id="exampleFormControlInput4"></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="exampleFormControlInput5" class="form-label">Likes</label>
                                <input type="text" class="form-control" name="likes" id="exampleFormControlInput5"
                                       value="0" disabled>
                            </div>
                            <div class="mb-3">
                                <label for="exampleFormControlInput6" class="form-label">Views</label>
                                <input type="text" class="form-control" name="views" id="exampleFormControlInput6"
                                       value="0">
                            </div>
                            <div class="mb-3">
                                <label for="exampleFormControlInput7" class="form-label">Image URL</label>
                                <input type="text" class="form-control" name="image" id="exampleFormControlInput7">
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-dark">Add</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%
        }
    %>
    <jsp:include page="top_cards.jsp"></jsp:include>
    <jsp:include page="cards.jsp"></jsp:include>
    <jsp:include page="pagination.jsp"></jsp:include>
</div>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
