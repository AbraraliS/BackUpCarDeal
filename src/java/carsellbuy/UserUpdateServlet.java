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
import javax.servlet.http.HttpSession;

@WebServlet("/update")
public class UserUpdateServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("userUpdate.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("UserID") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String uid = session.getAttribute("UserID").toString();
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String addrs = request.getParameter("addrs");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String phone = request.getParameter("phone");

        String sql = "UPDATE users SET FirstName=?, LastName=?, Address=?, City=?, State=?, Phone=? WHERE UserID=?";

        try (Connection con = DataSource.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, fname);
            pst.setString(2, lname);
            pst.setString(3, addrs);
            pst.setString(4, city);
            pst.setString(5, state);
            pst.setString(6, phone);
            pst.setString(7, uid);

            int result = pst.executeUpdate();

            if (result > 0) {
                // Update session attributes
                session.setAttribute("FirstName", fname);
                session.setAttribute("LastName", lname);
                session.setAttribute("Address", addrs);
                session.setAttribute("City", city);
                session.setAttribute("State", state);
                session.setAttribute("Phone", Long.parseLong(phone));

                request.setAttribute("successMessage", "Profile updated successfully!");
                request.getRequestDispatcher("/userUpdate.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Failed to update profile. Please try again.");
                request.getRequestDispatcher("/userUpdate.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "A database error occurred. Please try again later.");
            request.getRequestDispatcher("/userUpdate.jsp").forward(request, response);
        }
    }
}
