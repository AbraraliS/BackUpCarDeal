package carsellbuy;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("userRegister.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uname = request.getParameter("uname");
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String email = request.getParameter("email");
        String passwd = request.getParameter("passwd");
        String addrs = request.getParameter("addrs");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String phone = request.getParameter("phone");

        String sql = "INSERT INTO users (Username, Password, Email, FirstName, LastName, Address, City, State, Phone) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DataSource.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, uname);
            pst.setString(2, passwd);
            pst.setString(3, email);
            pst.setString(4, fname);
            pst.setString(5, lname);
            pst.setString(6, addrs);
            pst.setString(7, city);
            pst.setString(8, state);
            pst.setString(9, phone);

            int result = pst.executeUpdate();

            if (result > 0) {
                request.setAttribute("successMessage", "Registration successful! Please login.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Registration failed. Please try again.");
                request.getRequestDispatcher("/userRegister.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            // Log and show a generic error
            e.printStackTrace(); // Or use a logging framework
            request.setAttribute("errorMessage", "A database error occurred. Please try again later.");
            request.getRequestDispatcher("/userRegister.jsp").forward(request, response);
        }
    }
}
