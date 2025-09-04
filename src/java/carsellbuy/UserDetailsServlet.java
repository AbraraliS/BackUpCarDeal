package carsellbuy;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/users")
public class UserDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        try (PrintWriter out = response.getWriter()) {
            String sql = "SELECT * FROM users";
            try (Connection conn = DataSource.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql);
                 ResultSet rs = stmt.executeQuery()) {

                out.println("<html><head><title>User Data</title><style>table{border-collapse: collapse;width: 100%;}th, td{border: 1px solid #dddddd;text-align: left;padding: 8px;}th {background-color: #f2f2f2;}</style></head><body>");
                out.println("<h2>User Details</h2>");
                out.println("<table border='1'><tr><th>UserID</th><th>UserName</th><th>Email</th><th>Password</th><th>FirstName</th><th>LastName</th><th>Address</th><th>State</th><th>City</th><th>Phone</th><th>SubsType</th><th>Update</th><th>Delete</th></tr>");

                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getInt("UserID") + "</td>");
                    out.println("<td>" + rs.getString("Username") + "</td>");
                    out.println("<td>" + rs.getString("Email") + "</td>");
                    out.println("<td>" + rs.getString("Password") + "</td>");
                    out.println("<td>" + rs.getString("FirstName") + "</td>");
                    out.println("<td>" + rs.getString("LastName") + "</td>");
                    out.println("<td>" + rs.getString("Address") + "</td>");
                    out.println("<td>" + rs.getString("State") + "</td>");
                    out.println("<td>" + rs.getString("City") + "</td>");
                    out.println("<td>" + rs.getLong("Phone") + "</td>");
                    out.println("<td>" + rs.getString("SubscriptionTypeID") + "</td>");
                    out.println("<td><a href='userUpdate.jsp?id=" + rs.getInt("UserID") + "'>Update</a></td>");
                    out.println("<td><a href='deleteUser?id=" + rs.getInt("UserID") + "'>Delete</a></td>");
                    out.println("</tr>");
                }

                out.println("</table></body></html>");
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<h1>Error: " + e.getMessage() + "</h1>");
            }
        }
    }
}
