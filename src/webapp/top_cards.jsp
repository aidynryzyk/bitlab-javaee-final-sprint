<%@ page import="dao.NewsDAO" %>
<%@ page import="entity.News" %>
<%@ page import="entity.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %><%--
  Created by IntelliJ IDEA.
  User: aidyninho
  Date: 26.04.2023
  Time: 10:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Top cards</title>
</head>
<body>
<%
    List<News> newsList = (List<News>) request.getAttribute("list");
    User user = (User) request.getSession().getAttribute("user");
    NewsDAO newsDAO = new NewsDAO();
    if (newsList.size() > 0) {
        News active = newsList.get(0);
        int todayMinusPostDate = LocalDate.now().getDayOfYear() - active.getPostDate().toLocalDate().getDayOfYear();
%>
<%
    if (user != null && user.getRole() == 1) {
%>
<div>
        <%
  } else {
%>
    <div class="shadow bg-body-tertiary rounded" style="margin-top: 85px">
        <%
            }
        %>
        <div id="carouselExampleCaptions" class="carousel slide">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active"
                        aria-current="true" aria-label="Slide 1"></button>
                <%
                    for (int i = 0; i < Math.min(3, newsList.size()) - 1; i++) {
                %>
                <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="<%=i + 1%>"
                        aria-label="Slide <%=i + 2%>"></button>
                <%
                    }
                %>
            </div>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <a href="/news?id=<%=active.getId()%>">
                        <img src="<%=active.getImageURL()%>" class="d-block w-100 h-75" alt="...">
                        <div class="carousel-caption d-none d-md-block">
                            <span class="badge rounded-pill text-bg-light mb-3"><%=newsDAO.getCategoryName(active.getCategoryId())%></span>
                            <h2><%=active.getTitle()%>
                            </h2>
                            <h4><%=active.getContent().split("\\.")[0]%>
                            </h4>
                            <h5><i class="bi bi-suit-heart"></i><small><%=newsDAO.getLikesOfNews(active.getId())%>
                            </small><i class="bi bi-chat-dots"></i><small><%=newsDAO.getCommentsCount(active.getId())%>
                            </small><i class="bi bi-eye"></i><small><%=active.getViews()%>
                            </small></h5>
                            <%
                                if (todayMinusPostDate == 0) {
                            %>
                            <small>Today</small>
                            <%
                                } else if (todayMinusPostDate == 1) {
                            %>
                            <small>Yesterday</small>
                            <%
                                } else {
                            %>
                            <small><%=todayMinusPostDate%> days ago</small>
                            <%
                                }
                            %>
                        </div>
                    </a>
                </div>
                <%
                    for (int i = 1; i < Math.min(3, newsList.size()); i++) {
                        active = newsList.get(i);
                %>
                <div class="carousel-item">
                    <a href="/news?id=<%=active.getId()%>">
                        <img src="<%=active.getImageURL()%>" class="d-block w-100 h-75" alt="...">
                        <div class="carousel-caption d-none d-md-block">
                            <span class="badge rounded-pill text-bg-light mb-3"><%=newsDAO.getCategoryName(active.getCategoryId())%></span>
                            <h2><%=active.getTitle()%>
                            </h2>
                            <h4><%=active.getContent().split("\\.")[0]%>
                            </h4>
                            <h5><i class="bi bi-suit-heart"></i><small><%=newsDAO.getLikesOfNews(active.getId())%>
                            </small><i class="bi bi-chat-dots"></i><small><%=newsDAO.getCommentsCount(active.getId())%>
                            </small><i class="bi bi-eye"></i><small><%=active.getViews()%>
                            </small></h5>
                            <%
                                if (todayMinusPostDate == 0) {
                            %>
                            <small>Today</small>
                            <%
                            } else if (todayMinusPostDate == 1) {
                            %>
                            <small>Yesterday</small>
                            <%
                            } else {
                            %>
                            <small><%=todayMinusPostDate%> days ago</small>
                            <%
                                }
                            %>
                        </div>
                    </a>
                </div>
                <%
                    }
                %>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions"
                    data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions"
                    data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
        <%
        } else {
        %>
        <div style="margin-top: 85px">
            <div class="alert alert-danger" role="alert">
                No results for search <%=request.getParameter("search")%>
            </div>
        </div>
        <%
            }
        %>
    </div>
</body>
</html>
