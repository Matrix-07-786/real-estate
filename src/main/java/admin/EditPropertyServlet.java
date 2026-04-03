package admin;

import java.io.IOException;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/editproperty")
public class EditPropertyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL  = "jdbc:mysql://localhost:3306/realestate";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect("admin-login.html");
            return;
        }

        String propertyId = request.getParameter("property_id");
        String price      = request.getParameter("price");
        String featuredParam = request.getParameter("featured"); // "1" if checked, null if not
        int featured = (featuredParam != null && featuredParam.equals("1")) ? 1 : 0;

        if (propertyId == null || price == null || propertyId.isBlank() || price.isBlank()) {
            response.sendRedirect("admindashboard?msg=Invalid+input");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            PreparedStatement pst = conn.prepareStatement(
                "UPDATE properties SET price=?, featured=? WHERE id=?"
            );
            pst.setDouble(1, Double.parseDouble(price));
            pst.setInt(2, featured);
            pst.setInt(3, Integer.parseInt(propertyId));
            pst.executeUpdate();

            pst.close();
            conn.close();

            response.sendRedirect("admindashboard?msg=Property+updated+successfully");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admindashboard?msg=Error+updating+property");
        }
    }
}
