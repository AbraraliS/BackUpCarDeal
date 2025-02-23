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
import carsellbuy.DbConnection;
@WebServlet("/users")
public class UserDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         DbConnection db = new DbConnection();
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Connect to the database
            conn = db.makeConnection();
            // SQL query to fetch user data
            String query = "SELECT * FROM users";
            stmt = conn.prepareStatement(query);
            rs = stmt.executeQuery();

            // Display user data
            out.println("<html><head><title>User Data</title><style>table{border-collapse: collapse;width: 100%;}th, td{border: 1px solid #dddddd;text-align: left;padding: 8px;}th {background-color: #f2f2f2;}</style></head><body>"); 
            out.println("<table border='1'><tr><th>UserID</th><th>UserName</th><th>Email</th><th>Password</th><th>FirstName</th><th>LastName</th><th>Address</th><th>State</th><th>City</th><th>Phone</th><th>SubsType</th><th>Update</th><th>Delete</th></tr>");
            while (rs.next()) {
                int id = rs.getInt("UserID");
                String name = rs.getString("Username");
                String passwd = rs.getString("Password");
                String email = rs.getString("Email");
                String fname = rs.getString("FirstName");
                String lname = rs.getString("LastName");
                String addrs = rs.getString("Address");
                String city = rs.getString("City");
                String state = rs.getString("State");
                long phone = rs.getLong("Phone");
                String subtype = rs.getString("SubscriptionTypeID");
                out.println("<tr><td>" + id + "</td><td>" + name + "</td><td>" + email + "</td><td>" + passwd + "</td><td>" + fname + "</td><td>" + lname + "</td><td>" + addrs + "</td><td>" + state + "</td><td>" + city + "</td><td>" + phone + "</td><td>" + subtype +  "</td><td style='color: blue; cursor: pointer'>Update</td><td style='color: red; cursor: pointer'>Delete</td></tr>");
            }
            out.println("</table></body></html>");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        } finally {
            // Close resources
            try {
                if (rs != null)
                    rs.close();
                if (stmt != null)
                    stmt.close();
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            out.close();
        }
    }
}
