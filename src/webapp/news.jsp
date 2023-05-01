<%@ page import="dao.NewsDAO" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="entity.Comment" %>
<%@ page import="entity.News" %>
<%@ page import="entity.User" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: aidyninho
  Date: 27.04.2023
  Time: 20:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>News</title>
</head>
<body>
<div>
    <jsp:include page="navbar.jsp"></jsp:include>
    <%
        NewsDAO newsDAO = new NewsDAO();
        UserDAO userDAO = new UserDAO();
        News news = (News) request.getAttribute("news");
        List<Comment> comments = (List<Comment>) request.getAttribute("comments");
        User user = (User) request.getSession().getAttribute("user");
    %>
    <div class="container text-center mb-5" style="margin-top: 85px">
        <%
            if (user != null && user.getRole() == 1) {
        %>
        <div class="mb-3">
            <button class="btn btn-secondary mb-3" type="button" data-bs-toggle="modal" data-bs-target="#exampleModal">
                Edit
            </button>
            <form action="/news" method="post">
                <input type="hidden" name="type" value="delete">
                <input type="hidden" name="id" value="<%=news.getId()%>">
                <input type="hidden" name="show" value="1">
                <input type="hidden" name="page" value="0">
                <button class="btn btn-dark" type="submit">Delete</button>
            </form>
        </div>
        <div class="container">
            <!-- Modal -->
            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalLabel">Add news</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="/news" method="post">
                                <input type="hidden" name="type" value="update">
                                <input type="hidden" name="id" value="<%=news.getId()%>">
                                <div class="mb-3">
                                    <label for="exampleFormControlInput1" class="form-label">Post date</label>
                                    <input type="date" class="form-control" name="date" id="exampleFormControlInput1"
                                           value="<%=news.getPostDate()%>">
                                </div>
                                <div class="mb-3">
                                    <label for="exampleFormControlInput2" class="form-label">Category</label>
                                    <select class="form-select" id="exampleFormControlInput2" name="category"
                                            aria-label="Default select example">
                                        <%
                                            List<String> categories = newsDAO.getAllCategories();
                                        %>
                                        <option selected
                                                value="<%=news.getCategoryId()%>"><%=categories.get(news.getCategoryId() - 1)%>
                                        </option>
                                        <%
                                            for (int i = 0; i < categories.size(); i++) {
                                                if (i == news.getCategoryId() - 1) {
                                                    continue;
                                                }
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
                                    <input type="text" class="form-control" name="title" id="exampleFormControlInput3"
                                           value="<%=news.getTitle()%>">
                                </div>
                                <div class="mb-3">
                                    <label for="exampleFormControlInput4" class="form-label">Content</label>
                                    <textarea class="form-control" name="content"
                                              id="exampleFormControlInput4"><%=news.getContent()%></textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="exampleFormControlInput5" class="form-label">Likes</label>
                                    <input type="text" class="form-control" name="likes" id="exampleFormControlInput5"
                                           disabled value="<%=newsDAO.getLikesOfNews(news.getId())%>">
                                </div>
                                <div class="mb-3">
                                    <label for="exampleFormControlInput6" class="form-label">Views</label>
                                    <input type="text" class="form-control" name="views" id="exampleFormControlInput6"
                                           value="<%=news.getViews()%>">
                                </div>
                                <div class="mb-3">
                                    <label for="exampleFormControlInput7" class="form-label">Image URL</label>
                                    <input type="text" class="form-control" name="image" id="exampleFormControlInput7"
                                           value="<%=news.getImageURL()%>">
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close
                                    </button>
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
        <span class="badge rounded-pill text-bg-dark"><%=newsDAO.getCategoryName(news.getCategoryId())%></span>
        <div class="row">
            <div class="col"><h1 class="display-1"><%=news.getTitle()%>
            </h1></div>
        </div>
        <h5><i class="bi bi-suit-heart"></i><small><%=newsDAO.getLikesOfNews(news.getId())%>
        </small><i class="bi bi-chat-dots"></i><small><%=newsDAO.getCommentsCount(news.getId())%>
        </small><i class="bi bi-eye"></i><small><%=news.getViews()%>
        </small></h5>
        <div class="row justify-content-center">
            <img class="w-75 h-50 mb-3" src="<%=news.getImageURL()%>" alt="<%=news.getId()%>">
        </div>
        <div class="row">
            <div class="col">
                <p class="lead"><%=news.getContent()%>
                </p>
            </div>
        </div>
        <div>
            <%
                if (user != null && newsDAO.isLikedByUser(news.getId(), user.getId())) {
            %>
            <form action="/news?id=<%=news.getId()%>&userId=<%=user.getId()%>&type=dislike" method="post">
                <button type="submit" class="btn btn-danger"><i class="bi bi-suit-heart-fill"></i> Like</button>
            </form>
            <%
            } else if (user != null && !newsDAO.isLikedByUser(news.getId(), user.getId())) {
            %>
            <form action="/news?id=<%=news.getId()%>&userId=<%=user.getId()%>&type=like" method="post">
                <button type="submit" class="btn btn-danger"><i class="bi bi-suit-heart"></i> Like</button>
            </form>
            <%
            } else if (user == null) {
            %>
            <form action="/login" method="get">
                <button type="submit" class="btn btn-danger"><i class="bi bi-suit-heart"></i> Like</button>
            </form>
            <%
                }
            %>
        </div>
    </div>
    <div class="container">
        <%
            if (user == null) {
        %>
        <div class="card mb-3">
            <div class="card-header d-flex justify-content-between">
                <div>
                    <strong>Sign in to comment</strong>
                </div>
                <div>
                    <small><%=LocalDate.now()%>
                    </small>
                </div>
            </div>
            <div class="card-body">
                <form action="/news" method="post">
                    <div class="row">
                        <div class="col">
                            <textarea class="form-control" name="comment" disabled></textarea>
                        </div>
                        <div class="col-md-auto">
                            <button class="btn btn-dark" type="submit" disabled>Comment</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <%
        } else {
        %>
        <div class="card mb-3">
            <div class="card-header d-flex justify-content-between">
                <div>
                    <strong><%=user.getFullName()%>
                    </strong>
                </div>
                <div>
                    <small><%=LocalDate.now()%>
                    </small>
                </div>
            </div>
            <div class="card-body">
                <form action="/news" method="post">
                    <div class="row">
                        <div class="col">
                            <input type="hidden" name="type" value="comm">
                            <input type="hidden" name="userId" value="<%=user.getId()%>">
                            <input type="hidden" name="id" value="<%=news.getId()%>">
                            <input type="hidden" name="postDate" value="<%=LocalDate.now()%>">
                            <textarea class="form-control" name="comment"></textarea>
                        </div>
                        <div class="col-md-auto">
                            <button class="btn btn-dark" type="submit">Comment</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <%
            }
        %>
    </div>
    <div class="container">
        <%
            for (Comment comment :
                    comments) {
        %>
        <div class="card mb-3">
            <div class="card-header d-flex justify-content-between">
                <div>
                    <strong><%=userDAO.getUserById(comment.getUserId()).getFullName()%>
                    </strong>
                </div>
                <div>
                    <small><%=LocalDate.now().getDayOfYear() - comment.getPostDate().toLocalDate().getDayOfYear()%> days ago
                    </small>
                </div>
            </div>
            <div class="card-body">
                <blockquote class="blockquote mb-0">
                    <p><%=comment.getComment()%>
                    </p>
                </blockquote>
            </div>
        </div>
        <%
            }
        %>
    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>
</body>

</html>
