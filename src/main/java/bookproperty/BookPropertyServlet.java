package bookproperty;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import dbconnection.DBConnection;

@WebServlet("/bookproperty")
public class BookPropertyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // GET — shows booking form with property details
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("login.html");
            return;
        }

        String propertyIdStr = request.getParameter("property_id");
        if (propertyIdStr == null || propertyIdStr.isEmpty()) {
            response.sendRedirect("viewproperties");
            return;
        }

        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT id, title, city, bedrooms, bathrooms, area_sqft, price, image_url FROM properties WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(propertyIdStr));
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Map<String, String> prop = new HashMap<>();
                prop.put("id",        rs.getString("id"));
                prop.put("title",     rs.getString("title"));
                prop.put("city",      rs.getString("city"));
                prop.put("bedrooms",  rs.getString("bedrooms"));
                prop.put("bathrooms", rs.getString("bathrooms"));
                prop.put("area_sqft", rs.getString("area_sqft"));
                prop.put("price",     rs.getString("price"));
                prop.put("image_url", rs.getString("image_url"));
                request.setAttribute("prop", prop);
            } else {
                response.sendRedirect("viewproperties");
                rs.close(); ps.close(); con.close();
                return;
            }

            rs.close();
            ps.close();
            con.close();

            request.getRequestDispatcher("bookproperty.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }

    // POST — submits the booking
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.html");
            return;
        }

        try {
            String propertyIdStr = request.getParameter("property_id");
            String bookingDateStr = request.getParameter("booking_date");

            int propertyId = Integer.parseInt(propertyIdStr);
            Date bookingDate = Date.valueOf(bookingDateStr);

            Connection con = DBConnection.getConnection();

            if (con == null) {
                response.getWriter().println("Database connection failed!");
                return;
            }

            String sql = "INSERT INTO bookings (property_id, user_id, booking_date, status) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, propertyId);
            ps.setInt(2, userId);
            ps.setDate(3, bookingDate);
            ps.setString(4, "pending");

            int row = ps.executeUpdate();
            ps.close();
            con.close();

            if (row > 0) {
                response.sendRedirect("mybookings");
            } else {
                response.getWriter().println("Booking Failed!");
            }

        } catch (NumberFormatException e) {
            response.getWriter().println("Invalid Property ID!");
        } catch (IllegalArgumentException e) {
            response.getWriter().println("Invalid Date Format!");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}