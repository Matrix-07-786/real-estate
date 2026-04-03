package home;

import java.io.IOException;
import java.sql.*;
import java.util.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL  = "jdbc:mysql://localhost:3306/realestate";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Map<String, String>> featuredProperties = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            PreparedStatement pst = conn.prepareStatement(
                "SELECT id, title, city, bedrooms, bathrooms, area_sqft, price, image_url " +
                "FROM properties WHERE featured = 1"
            );
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Map<String, String> prop = new HashMap<>();
                prop.put("id",        rs.getString("id"));
                prop.put("title",     rs.getString("title"));
                prop.put("city",      rs.getString("city"));
                prop.put("bedrooms",  rs.getString("bedrooms"));
                prop.put("bathrooms", rs.getString("bathrooms"));
                prop.put("area_sqft", rs.getString("area_sqft"));
                prop.put("price",     rs.getString("price"));
                prop.put("image_url", rs.getString("image_url"));
                featuredProperties.add(prop);
            }

            rs.close();
            pst.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("featuredProperties", featuredProperties);
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}
