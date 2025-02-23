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
import java.io.File;
import static java.lang.System.out;
import java.sql.SQLException;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.RequestContext;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

;

@WebServlet("/sellcar")
public class SellCarServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("SellCar2.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DbConnection db = new DbConnection();



//        String uid = request.getParameter("uid");
         String uid = request.getParameter("gusid");
        String carname = request.getParameter("cname");
        String regyear = request.getParameter("regye");
        String kmdrive = request.getParameter("kmdrive");
        String price = request.getParameter("price");
        String brand = request.getParameter("brand");
        String model = request.getParameter("model");
        String varty = request.getParameter("ftype");
        String discrip = request.getParameter("cardes");
        String photo = request.getParameter("photos");

        try {
            Connection con = db.makeConnection();
            if (con != null) {
                System.out.print("Connection Successfull...\t");

                // Execute SQL query
                String sql;
                sql = "INSERT INTO cars2 (Car2Name, Reg2Year, KM2Driven, Price2, CarBrand2, Model2, Variant2, Owner2, Description2, Photos2) VALUES ('" + carname + "', '" + regyear + "', '" + kmdrive + "', '" + price + "', '" + brand + "', '" + model + "', '" + varty + "', '"+ uid + "', '" + discrip + "','" +"image/"+ photo + "')";
                PreparedStatement st = con.prepareStatement(sql);
                st.executeUpdate();
           
                response.sendRedirect("SellCar2.jsp");
            }
        } catch (IOException | ClassNotFoundException | SQLException e) {
            System.out.println("Something went wrong....." + e);
            response.sendRedirect("SellCar2.jsp");
        }

    }

}
