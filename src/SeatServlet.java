import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;

public class SeatServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String movie = request.getParameter("movie");
        String showtime = request.getParameter("showtime");
        String price = request.getParameter("price");

        if (movie == null || showtime == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        try {
            Connection conn = DBConnection.connect();
            PreparedStatement pst = conn.prepareStatement(
                    "SELECT seats FROM bookings WHERE movie=? AND showtime=?");
            pst.setString(1, movie);
            pst.setString(2, showtime);
            ResultSet rs = pst.executeQuery();

            List<String> bookedSeatsList = new ArrayList<>();
            while (rs.next()) {
                String seats = rs.getString("seats");
                if (seats != null) {
                    // Seats are stored like "S1 S2 S5 "
                    String[] seatArr = seats.trim().split(" ");
                    bookedSeatsList.addAll(Arrays.asList(seatArr));
                }
            }

            conn.close();
            
            request.setAttribute("movie", movie);
            request.setAttribute("showtime", showtime);
            request.setAttribute("price", price != null ? price : "200");
            request.setAttribute("bookedSeats", bookedSeatsList);
            
            request.getRequestDispatcher("/select-seats.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=Failed to load seats");
        }
    }
}
