import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;

public class HistoryServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String username = (String) session.getAttribute("username");

        try {
            Connection conn = DBConnection.connect();
            PreparedStatement pst = conn.prepareStatement(
                    "SELECT * FROM bookings WHERE username=? ORDER BY id DESC");
            pst.setString(1, username);
            ResultSet rs = pst.executeQuery();

            List<Map<String, String>> bookings = new ArrayList<>();
            while (rs.next()) {
                Map<String, String> b = new HashMap<>();
                b.put("id", rs.getString("id"));
                b.put("movie", rs.getString("movie"));
                b.put("seats", rs.getString("seats"));
                b.put("total", rs.getString("total"));
                b.put("showtime", rs.getString("showtime") != null ? rs.getString("showtime") : "N/A");
                b.put("booking_date", rs.getString("booking_date") != null ? rs.getString("booking_date") : "");
                bookings.add(b);
            }

            conn.close();
            request.setAttribute("bookings", bookings);
            request.getRequestDispatcher("/my-bookings.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=Failed to load history");
        }
    }
}
