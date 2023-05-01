package servlets;

import dao.CommentDAO;
import dao.NewsDAO;
import entity.Comment;
import entity.News;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/news")
public class NewsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        NewsDAO newsDAO = new NewsDAO();
        CommentDAO commentDAO = new CommentDAO();
        if (req.getParameter("id") != null && req.getParameter("show") == null) {
            req.setAttribute("news", newsDAO.getNewsById(Integer.parseInt(req.getParameter("id"))));
            req.setAttribute("comments", commentDAO.getAllCommentsByNewsId(Integer.parseInt(req.getParameter("id"))));
            newsDAO.incrementViews(Integer.parseInt(req.getParameter("id")));
            req.getRequestDispatcher("news.jsp").forward(req, resp);
        } else {
            int show = Integer.parseInt(req.getParameter("show"));
            int page = Integer.parseInt(req.getParameter("page"));
            switch (show) {
                case 1 -> req.setAttribute("list", newsDAO.getAllNewsSortedByViewsDesc(9, page * 9));
                case 2 -> req.setAttribute("list", newsDAO.getAllNewsSortedByDateDesc(9, page * 9));
                case 3 ->
                        req.setAttribute("list", newsDAO.getAllNewsByCategory(Integer.parseInt(req.getParameter("category"))));
                case 4 -> req.setAttribute("list", newsDAO.getAllNewsByWord(9, page * 9, req.getParameter("search")));
            }
            if (show == 4) {
                req.setAttribute("cardsCount", ((List<News>) req.getAttribute("list")).size());
            } else {
                req.setAttribute("cardsCount", newsDAO.getAllNews().size());
            }
            req.getRequestDispatcher("page.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        NewsDAO newsDAO = new NewsDAO();
        CommentDAO commentDAO = new CommentDAO();
        if ("like".equals(req.getParameter("type"))) {
            newsDAO.like(Integer.parseInt(req.getParameter("id")), Integer.parseInt(req.getParameter("userId")));
        } else if ("dislike".equals(req.getParameter("type"))) {
            newsDAO.dislike(Integer.parseInt(req.getParameter("id")), Integer.parseInt(req.getParameter("userId")));
        } else if ("comm".equals(req.getParameter("type"))) {
            Comment comment = new Comment(
                    req.getParameter("comment"),
                    Date.valueOf(req.getParameter("postDate")),
                    Integer.parseInt(req.getParameter("userId")),
                    Integer.parseInt(req.getParameter("id"))
            );
            commentDAO.createComment(comment);
            req.setAttribute("comments", commentDAO.getAllCommentsByNewsId(Integer.parseInt(req.getParameter("id"))));
        } else if ("add".equals(req.getParameter("type"))) {
            News news = new News(
                    Date.valueOf(req.getParameter("date")),
                    Integer.parseInt(req.getParameter("category")),
                    req.getParameter("title"),
                    req.getParameter("content"),
                    Integer.parseInt(req.getParameter("views")),
                    req.getParameter("image")
            );
            newsDAO.createNews(news);
        } else if ("update".equals(req.getParameter("type"))) {
            News news = new News(
                    Integer.parseInt(req.getParameter("id")),
                    Date.valueOf(req.getParameter("date")),
                    Integer.parseInt(req.getParameter("category")),
                    req.getParameter("title"),
                    req.getParameter("content"),
                    Integer.parseInt(req.getParameter("views")),
                    req.getParameter("image")
            );
            newsDAO.updateNews(news);
        } else if ("delete".equals(req.getParameter("type"))) {
            newsDAO.deleteNews(Integer.parseInt(req.getParameter("id")));
        }
        doGet(req, resp);
    }
}
