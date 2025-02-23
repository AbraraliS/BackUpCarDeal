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

;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("userRegister.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DbConnection db = new DbConnection();

//        String uid = request.getParameter("uid");
        String uname = request.getParameter("uname");
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String email = request.getParameter("email");
        String passwd = request.getParameter("passwd");
        String addrs = request.getParameter("addrs");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String phone = request.getParameter("phone");
//        String subType = request.getParameter("subType");
//        String pincd = request.getParameter("pincd");

//        System.out.println("User name:\t" + request.getParameter("uid"));
        System.out.println("User name:\t" + request.getParameter("name"));
        System.out.println("User email:\t" + request.getParameter("fname"));
        System.out.println("User password:\t" + request.getParameter("lname"));
        System.out.println("User password:\t" + request.getParameter("email"));
        System.out.println("User password:\t" + request.getParameter("passwd"));
        System.out.println("User password:\t" + request.getParameter("addrs"));
        System.out.println("User password:\t" + request.getParameter("city"));
        System.out.println("User password:\t" + request.getParameter("state"));
        System.out.println("User password:\t" + request.getParameter("phone"));
//        System.out.println("User password:\t" + request.getParameter("subType"));
//        System.out.println("User password:\t" + request.getParameter("pincd"));

        try {
            Connection con = db.makeConnection();
            if (con != null) {
                System.out.print("Connection Successfull...\t");

                // Execute SQL query
                String sql;
                sql = "INSERT INTO users (Username, Password, Email, FirstName, LastName, Address, City, State, Phone) VALUES ('" + uname + "', '" + passwd + "', '" + email + "', '" + fname + "', '" + lname + "', '" + addrs + "', '" + city + "', '" + state + "', '" + phone + "')";
                PreparedStatement st = con.prepareStatement(sql);
                st.executeUpdate();
                
                response.sendRedirect("userRegister.jsp");  
            } 
        } catch (IOException | ClassNotFoundException | SQLException e) {
            System.out.println("Something went wrong....."+e);
            response.sendRedirect("userRegister.jsp");
        }

    }

}
