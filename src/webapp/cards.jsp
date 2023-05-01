<%@ page import="dao.NewsDAO" %>
<%@ page import="entity.News" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.time.LocalDate" %>
<%--
  Created by IntelliJ IDEA.
  User: aidyninho
  Date: 25.04.2023
  Time: 21:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Cards</title>
</head>
<body>
<%
    int j = 3;
    for (int i = 0; i < 3; i++) {
%>
<div class="row mt-3">
    <%
        List<News> newsList = (List<News>) request.getAttribute("list");
        NewsDAO newsDAO = new NewsDAO();
        for (int k = 0; k < 3; k++) {
            if (j >= newsList.size()) {
                break;
            }
            News active = newsList.get(j++);
    %>
    <div class="col">
        <div class="card shadow bg-body-tertiary rounded">
            <a class="link-dark link-offset-2 link-underline-opacity-0 link-underline-opacity-100-hover" href="/news?id=<%=active.getId()%>">
                <img src="<%=active.getImageURL()%>" class="card-img-top" alt="...">
                <div class="card-body">
                    <span class="badge rounded-pill text-bg-dark mb-3"><%=newsDAO.getCategoryName(active.getCategoryId())%></span>
                    <h5 class="card-title"><%=active.getTitle()%></h5>
                    <p class="card-text"><%=active.getContent().split("\\.")[0]%></p>
                    <p class="card-text"><small class="text-body-secondary"><%=LocalDate.now().getDayOfYear() - active.getPostDate().toLocalDate().getDayOfYear()%> days ago</small></p>
                    <p class="card-text"><i class="bi bi-suit-heart"></i><small class="text-body-secondary">  <%=newsDAO.getLikesOfNews(active.getId())%>  </small><i class="bi bi-chat-dots"></i><small class="text-body-secondary">  <%=newsDAO.getCommentsCount(active.getId())%>  </small><i class="bi bi-eye"></i><small class="text-body-secondary">  <%=active.getViews()%>  </small></p>
                </div>
            </a>
        </div>
    </div>
    <%
        }
    %>
</div>
<%
    }
%>
</body>
</html>
