<%--
  Created by IntelliJ IDEA.
  User: aidyninho
  Date: 27.04.2023
  Time: 09:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Pagination</title>
</head>
<body>
<%
    int cardsCount = (int) request.getAttribute("cardsCount");
    int currentPage = Integer.parseInt(request.getParameter("page"));
%>
<nav aria-label="..." class="mt-3">
    <ul class="pagination justify-content-center">
        <%
            if (currentPage == 0) {
        %>
        <li class="page-item disabled">
            <a class="page-link">Previous</a>
        </li>
        <%
        } else {
        %>
        <li class="page-item">
            <a class="page-link text-dark"
               href="/news?show=<%=request.getParameter("show")%>&page=<%=currentPage - 1%><%=request.getParameter("category") == null ? "" : "&category=" + request.getParameter("category")%><%=request.getParameter("search") == null ? "" : "&search=" + request.getParameter("search")%>">Previous</a>
        </li>
        <%
            }
            for (int i = 0; i < (int) Math.ceil(cardsCount / 9.0); i++) {
                if (currentPage == i) {
        %>
        <li class="page-item active bg-secondary"><a class="page-link text-dark"
                                                     href="/news?show=<%=request.getParameter("show")%>&page=<%=i%><%=request.getParameter("category") == null ? "" : "&category=" + request.getParameter("category")%><%=request.getParameter("search") == null ? "" : "&search=" + request.getParameter("search")%>"><%=i + 1%>
        </a></li>
        <%
        } else {
        %>
        <li class="page-item"><a class="page-link text-dark"
                                 href="/news?show=<%=request.getParameter("show")%>&page=<%=i%><%=request.getParameter("category") == null ? "" : "&category=" + request.getParameter("category")%><%=request.getParameter("search") == null ? "" : "&search=" + request.getParameter("search")%>"><%=i + 1%>
        </a></li>
        <%
                }
            }
            if (currentPage == cardsCount / 9) {
        %>
        <li class="page-item disabled">
            <a class="page-link">Next</a>
        </li>
        <%
        } else {
        %>
        <li class="page-item">
            <a class="page-link text-dark"
               href="/news?show=<%=request.getParameter("show")%>&page=<%=currentPage + 1%><%=request.getParameter("category") == null ? "" : "&category=" + request.getParameter("category")%><%=request.getParameter("search") == null ? "" : "&search=" + request.getParameter("search")%>">Next</a>
        </li>
        <%
            }
        %>
    </ul>
</nav>
</body>
</html>
