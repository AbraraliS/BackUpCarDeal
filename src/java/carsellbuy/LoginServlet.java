package carsellbuy;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String sql = "SELECT * FROM users WHERE Email = ?";

        try (Connection con = DataSource.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, email);

            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    String dbPassword = rs.getString("Password");
                    if (password.equals(dbPassword)) {
                        HttpSession session = request.getSession();
                        session.setAttribute("UserID", rs.getInt("UserID"));
                        session.setAttribute("Username", rs.getString("Username"));
                        session.setAttribute("Email", rs.getString("Email"));
                        session.setAttribute("FirstName", rs.getString("FirstName"));
                        session.setAttribute("LastName", rs.getString("LastName"));
                        session.setAttribute("Address", rs.getString("Address"));
                        session.setAttribute("City", rs.getString("City"));
                        session.setAttribute("State", rs.getString("State"));
                        session.setAttribute("Phone", rs.getLong("Phone"));
                        session.setAttribute("SubscriptionTypeID", rs.getString("SubscriptionTypeID"));
                        response.sendRedirect("index.jsp");
                    } else {
                        // Invalid password
                        request.setAttribute("errorMessage", "Invalid credentials. Please try again.");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    }
                } else {
                    // User not found
                    request.setAttribute("errorMessage", "Invalid credentials. Please try again.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "A database error occurred. Please try again later.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
