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

@WebServlet("/car-details")
public class CarDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int carId = Integer.parseInt(request.getParameter("carId")); // Get car ID from request parameter

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Car car = null; // You need to create a Car class

        try {
            // Get database connection
            conn = new DbConnection().makeConnection();

            // SQL query to fetch car details
            String query = "SELECT * FROM cars2 WHERE Car2ID = ?";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, carId);

            // Execute the select statement
            rs = stmt.executeQuery();

            // Process the result set and create a Car object
            if (rs.next()) {
                car = new Car(); // You need to create a Car class
                car.setCarId(rs.getInt("Car2ID"));
                car.setCarName(rs.getString("car2Name"));
                car.setRegYear(rs.getString("Reg2Year"));
                car.setKmDriven(rs.getString("KM2Driven"));
                car.setPrice(rs.getString("Price2"));
                car.setCarBrand(rs.getString("CarBrand2"));
                car.setModel(rs.getString("Model2"));
                car.setPhotoPath(rs.getString("Photos2"));
                // TODO: Set other car attributes
            }

            // Set the car object as a request attribute
            request.setAttribute("car", car);

            // Forward the request to car-details.jsp
            request.getRequestDispatcher("car-details.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage()); // Display database error
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("An error occurred: " + e.getMessage()); // Display other errors
        } finally {
            // Close database resources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}