package servlets;

import dao.UserDAO;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/login")
public class UserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getParameter("signup") != null) {
            req.getRequestDispatcher("signup.jsp").forward(req, resp);
        }
        if (req.getParameter("email") == null && req.getParameter("password") == null) {
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        } else {
            UserDAO userDAO = new UserDAO();
            User user = userDAO.getUserByEmail(req.getParameter("email"));
            if (user == null || !user.getPassword().equals(req.getParameter("password"))) {
                req.setAttribute("found", false);
                req.getRequestDispatcher("login.jsp").forward(req, resp);
            } else {
                req.setAttribute("found", true);
                req.setAttribute("user", user);
                req.getSession().setAttribute("user", user);
                req.getRequestDispatcher("/profile?show=5").forward(req, resp);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDAO userDAO = new UserDAO();
        User user = new User(
                req.getParameter("email"),
                req.getParameter("password"),
                req.getParameter("fullName"),
                Integer.parseInt(req.getParameter("role"))
        );
        user.setId(userDAO.createUser(user));
        req.getSession().setAttribute("user", user);
        req.getRequestDispatcher("profile.jsp").forward(req, resp);
    }
}
