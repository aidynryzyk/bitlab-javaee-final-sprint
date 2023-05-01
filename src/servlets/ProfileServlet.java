package servlets;

import dao.UserDAO;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDAO userDAO = new UserDAO();
        User user = (User) req.getSession().getAttribute("user");
        user.setEmail(req.getParameter("email"));
        user.setPassword(req.getParameter("password"));
        user.setFullName(req.getParameter("name"));
        user.setRole(Integer.parseInt(req.getParameter("role")));
        userDAO.updateUser(user);
        req.getRequestDispatcher("profile.jsp").forward(req, resp);
    }
}
