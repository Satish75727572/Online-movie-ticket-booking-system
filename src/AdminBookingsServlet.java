import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;

public class AdminBookingsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            Connection conn = DBConnection.connect();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM bookings ORDER BY id DESC");

            List<Map<String, String>> bookings = new ArrayList<>();
            while (rs.next()) {
                Map<String, String> b = new HashMap<>();
                b.put("id", rs.getString("id"));
                b.put("username", rs.getString("username"));
                b.put("movie", rs.getString("movie"));
                b.put("seats", rs.getString("seats"));
                b.put("total", rs.getString("total"));
                b.put("showtime", rs.getString("showtime") != null ? rs.getString("showtime") : "N/A");
                bookings.add(b);
            }

            conn.close();
            request.setAttribute("allBookings", bookings);
            request.getRequestDispatcher("/admin/bookings.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("dashboard.jsp?error=Failed to load bookings");
        }
    }
}
