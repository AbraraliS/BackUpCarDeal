package carsellbuy;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/cars")
public class CarListingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Car> carList = new ArrayList<>();

        try {
            // Get database connection
            conn = new DbConnection().makeConnection();

            // SQL query to fetch car data
            // TODO: Add filtering and pagination based on request parameters
            String query = "SELECT * FROM cars2";
            stmt = conn.prepareStatement(query);

            // Execute the select statement
            rs = stmt.executeQuery();

            // Process the result set and create Car objects
            while (rs.next()) {
                Car car = new Car(); // You need to create a Car class
                car.setCarId(rs.getInt("Car2ID"));
                car.setCarName(rs.getString("car2Name"));
                car.setRegYear(rs.getString("Reg2Year"));
                car.setKmDriven(rs.getString("KM2Driven"));
                car.setPrice(rs.getString("Price2"));
                car.setCarBrand(rs.getString("CarBrand2"));
                car.setModel(rs.getString("Model2"));
                car.setPhotoPath(rs.getString("Photos2"));
                // TODO: Set other car attributes
                carList.add(car);
            }

            // Set the car list as a request attribute
            request.setAttribute("carList", carList);

            // Forward the request to cars.jsp
            request.getRequestDispatcher("cars.jsp").forward(request, response);

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