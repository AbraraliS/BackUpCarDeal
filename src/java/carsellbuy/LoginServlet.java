package carsellbuy;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import carsellbuy.DbConnection;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        DbConnection db = new DbConnection();
        PrintWriter out = response.getWriter();

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println("User Email:\t" + request.getParameter("email"));
        System.out.println("User Password:\t" + request.getParameter("password"));

        try {
            Connection con = db.makeConnection();
            if (con != null) {
                System.out.print("Connection Successfull");

                // Execute SQL query
                Statement st = con.createStatement();
                String sql;
                sql = "SELECT * FROM users WHERE Email='" + email + "'";
                ResultSet rs = st.executeQuery(sql);

                // Extract data from result set
                if (!rs.isBeforeFirst()) {
                    out.println("Email ID Not found: \t" + email);
                } else {
                    while (rs.next()) {
                        int user_id = rs.getInt("UserID");
                        String name = rs.getString("Username");
                        String remail = rs.getString("Email");
                        String rpassword = rs.getString("Password");

                        String fname = rs.getString("FirstName");
                        String lname = rs.getString("LastName");

                        String addrs = rs.getString("Address");
                        String city = rs.getString("City");
                        String state = rs.getString("State");
                        long phone = rs.getLong("Phone");
                        String subType = rs.getString("SubscriptionTypeID");
//        String pincd = rs.getString("pincd");
//UserID, Username, Password, Email, FirstName, LastName, Address, City, State, Phone
                        // Check for password 
                        if (password.equals(rpassword)) {
                            session.setAttribute("UserID", user_id);
                            session.setAttribute("Username", name);
                            session.setAttribute("Email", remail);
                            session.setAttribute("Password", rpassword);
                            session.setAttribute("FirstName", fname);
                            session.setAttribute("LastName", lname);
                            session.setAttribute("Address", addrs);
                            session.setAttribute("City", city);
                            session.setAttribute("State", state);
                            session.setAttribute("Phone", phone);
                            session.setAttribute("SubscriptionTypeID", subType);
                            response.sendRedirect("index.jsp");
                            System.out.println("LoginSuccess");
                        } else {
                            out.println("Invalid Password");
                            response.sendRedirect("login");
                        }

                    }
                }

            }
        } catch (Exception e) {
            System.out.println("Error 00" + e);
        }

    }
}
