import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class BookingServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp?error=Please login first");
            return;
        }

        String username = (String) session.getAttribute("username");
        String movie = request.getParameter("movie");
        String seats = request.getParameter("seats");
        String showtime = request.getParameter("showtime");
        int total = 0;

        try {
            total = Integer.parseInt(request.getParameter("total"));
        } catch (NumberFormatException e) {
            total = 0;
        }

        try {
            Connection conn = DBConnection.connect();
            PreparedStatement pst = conn.prepareStatement(
                    "INSERT INTO bookings(username, movie, seats, total, showtime) VALUES(?,?,?,?,?)");
            pst.setString(1, username);
            pst.setString(2, movie);
            pst.setString(3, seats);
            pst.setInt(4, total);
            pst.setString(5, showtime);
            pst.executeUpdate();
            conn.close();

            // Store ticket data in session for display
            session.setAttribute("ticket_movie", movie);
            session.setAttribute("ticket_seats", seats);
            session.setAttribute("ticket_total", total);
            session.setAttribute("ticket_showtime", showtime);

            response.sendRedirect("ticket.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("payment.jsp?error=Booking failed. Please try again.");
        }
    }
}
