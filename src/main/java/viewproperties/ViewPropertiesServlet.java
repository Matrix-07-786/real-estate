package viewproperties;


import java.io.IOException;
import java.sql.*;
import java.util.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/viewproperties")
public class ViewPropertiesServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static final String URL = "jdbc:mysql://localhost:3306/realestate";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Map<String, String>> properties         = new ArrayList<>();
        List<Map<String, String>> featuredProperties = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);

            // All properties
            PreparedStatement pst = conn.prepareStatement("SELECT * FROM properties");
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Map<String, String> property = new HashMap<>();
                property.put("id",        rs.getString("id"));
                property.put("title",     rs.getString("title"));
                property.put("city",      rs.getString("city"));
                property.put("bedrooms",  rs.getString("bedrooms"));
                property.put("price",     rs.getString("price"));
                property.put("image_url", rs.getString("image_url"));
                property.put("featured",  rs.getString("featured"));
                properties.add(property);
            }

            rs.close();
            pst.close();

            // Featured properties only
            PreparedStatement pst2 = conn.prepareStatement(
                "SELECT * FROM properties WHERE featured = 1"
            );
            ResultSet rs2 = pst2.executeQuery();

            while (rs2.next()) {
                Map<String, String> fp = new HashMap<>();
                fp.put("id",        rs2.getString("id"));
                fp.put("title",     rs2.getString("title"));
                fp.put("city",      rs2.getString("city"));
                fp.put("bedrooms",  rs2.getString("bedrooms"));
                fp.put("price",     rs2.getString("price"));
                fp.put("image_url", rs2.getString("image_url"));
                featuredProperties.add(fp);
            }

            rs2.close();
            pst2.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("properties", properties);
        request.setAttribute("featuredProperties", featuredProperties);

        request.getRequestDispatcher("buyer-dashboard.jsp").forward(request, response);
    }
}