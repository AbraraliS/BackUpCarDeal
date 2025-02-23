package carsellbuy;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import carsellbuy.DbConnection;
import static java.lang.System.out;
import java.sql.SQLException;
import javax.servlet.http.HttpSession;

;

@WebServlet("/update")
public class UserUpdateServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("userUpdate.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DbConnection db = new DbConnection();

        String uid = request.getParameter("uid");
        String uname = request.getParameter("uname");
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String email = request.getParameter("email");
//        String passwd = request.getParameter("passwd");
        String addrs = request.getParameter("addrs");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String phone = request.getParameter("phone");
//        String subType = request.getParameter("subType");
//        String pincd = request.getParameter("pincd");

        System.out.println("User name:\t" + request.getParameter("uid"));
        System.out.println("User name:\t" + request.getParameter("name"));
        System.out.println("First Name:\t" + request.getParameter("fname"));
        System.out.println("Last Name:\t" + request.getParameter("lname"));
        System.out.println("Email:\t" + request.getParameter("email"));
        System.out.println("User password:\t" + request.getParameter("passwd"));
        System.out.println("Address:\t" + request.getParameter("addrs"));
        System.out.println("City:\t" + request.getParameter("city"));
        System.out.println("State:\t" + request.getParameter("state"));
        System.out.println("Phone:\t" + request.getParameter("phone"));
//        System.out.println("User password:\t" + request.getParameter("subType"));
//        System.out.println("User password:\t" + request.getParameter("pincd"));

        try {
    Connection con = db.makeConnection();
    if (con != null) {
        System.out.println("Connection Successful...\t");

        // Prepare SQL query with placeholders
        String updateQuery = "UPDATE users SET FirstName=?, LastName=?, Phone=?, Address=?, State=?, City=? WHERE UserID=?";

        // Create PreparedStatement
        PreparedStatement st = con.prepareStatement(updateQuery);

        // Set values for placeholders
        st.setString(1, fname);
        st.setString(2, lname);
        st.setString(3, phone);
        st.setString(4, addrs);
        st.setString(5, state);
        st.setString(6, city);
        st.setString(7, uid); // assuming uid is a variable containing the UserID

        // Execute update
        st.executeUpdate();
        
        // Redirect after successful update
        response.sendRedirect("login.jsp");
    } else {
        // Handle connection failure
    }
        } catch (IOException | ClassNotFoundException | SQLException e) {
            System.out.println("Something went wrong.....\t" + e);
            response.sendRedirect("userUpdate.jsp");
        }

    }

}
