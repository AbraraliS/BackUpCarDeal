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

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("SellCar2.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("UserID") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String uid = session.getAttribute("UserID").toString();
        String carname = request.getParameter("cname");
        String regyear = request.getParameter("regye");
        String kmdrive = request.getParameter("kmdrive");
        String price = request.getParameter("price");
        String brand = request.getParameter("brand");
        String model = request.getParameter("model");
        String varty = request.getParameter("ftype");
        String discrip = request.getParameter("cardes");
        String photo = request.getParameter("photos");

        String sql = "INSERT INTO cars2 (Car2Name, Reg2Year, KM2Driven, Price2, CarBrand2, Model2, Variant2, Owner2, Description2, Photos2) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DataSource.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, carname);
            pst.setString(2, regyear);
            pst.setString(3, kmdrive);
            pst.setString(4, price);
            pst.setString(5, brand);
            pst.setString(6, model);
            pst.setString(7, varty);
            pst.setString(8, uid);
            pst.setString(9, discrip);
            pst.setString(10, "image/" + photo);

            int result = pst.executeUpdate();

            if (result > 0) {
                request.setAttribute("successMessage", "Car listed successfully!");
                request.getRequestDispatcher("/SellCar2.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Failed to list car. Please try again.");
                request.getRequestDispatcher("/SellCar2.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "A database error occurred. Please try again later.");
            request.getRequestDispatcher("/SellCar2.jsp").forward(request, response);
        }
    }
}
