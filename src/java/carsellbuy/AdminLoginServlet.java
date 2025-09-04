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

@WebServlet("/AdminLogin")
public class AdminLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("AdminLogin.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("ademail");
        String password = request.getParameter("adpassword");

        String sql = "SELECT * FROM admins WHERE Email = ?";
        
        try (Connection con = DataSource.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, email);
            
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    String dbPassword = rs.getString("Password");
                    if (password.equals(dbPassword)) {
                        HttpSession session = request.getSession();
                        session.setAttribute("AdminID", rs.getInt("AdminID"));
                        session.setAttribute("Username", rs.getString("Username"));
                        session.setAttribute("Email", rs.getString("Email"));
                        response.sendRedirect("AdminPanel.jsp");
                    } else {
                        // Invalid password
                        request.setAttribute("errorMessage", "Invalid credentials. Please try again.");
                        request.getRequestDispatcher("AdminLogin.jsp").forward(request, response);
                    }
                } else {
                    // User not found
                    request.setAttribute("errorMessage", "Invalid credentials. Please try again.");
                    request.getRequestDispatcher("AdminLogin.jsp").forward(request, response);
                }
            }
        } catch (SQLException e) {
            // Log the exception
            e.printStackTrace();
            // Show a generic error page
            request.setAttribute("errorMessage", "A database error occurred. Please try again later.");
            request.getRequestDispatcher("AdminLogin.jsp").forward(request, response);
        }
    }
}
