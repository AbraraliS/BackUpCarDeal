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

@WebServlet("/sellcar")
public class SellCarServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("UserID");

        if (userId == null) {
            response.sendRedirect("login.jsp"); // Redirect to login if user is not logged in
            return;
        }

        // Retrieve car data from the form
        String carName = request.getParameter("CarName");
        String regYear = request.getParameter("RegYear");
        String kmDriven = request.getParameter("Km_driven");
        String price = request.getParameter("price");
        String brandId = request.getParameter("brand"); // Assuming you'll send brand ID from the form
        String modelId = request.getParameter("model"); // Assuming you'll send model ID from the form
        String variantId = request.getParameter("variant"); // Assuming you'll send variant ID from the form
        String carDescription = request.getParameter("car_description");
        String address = request.getParameter("addrs");
        // TODO: Handle file uploads and get the photo path
        String photoPath = ""; // Placeholder for the photo path

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Get database connection
            conn = new DbConnection().makeConnection();

            // SQL query to insert car data
            String query = "INSERT INTO cars2 (car2Name, Reg2Year, KM2Driven, Price2, CarBrand2, Model2, Variant2, Photos2, Address, UserID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, carName);
            stmt.setString(2, regYear);
            stmt.setString(3, kmDriven);
            stmt.setString(4, price);
            stmt.setString(5, brandId); // Use brandId
            stmt.setString(6, modelId); // Use modelId
            stmt.setString(7, variantId); // Use variantId
            stmt.setString(8, photoPath);
            stmt.setString(9, address);
            stmt.setInt(10, userId);

            // Execute the insert statement
            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                // Car data inserted successfully
                response.sendRedirect("cars.jsp"); // Redirect to car listing page
            } else {
                // Failed to insert car data
                response.getWriter().println("Failed to add car."); // Display an error message
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage()); // Display database error
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("An error occurred: " + e.getMessage()); // Display other errors
        } finally {
            // Close database resources
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}