import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class AdminMovieServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        String name = request.getParameter("name");
        String genre = request.getParameter("genre");
        String duration = request.getParameter("duration");
        String description = request.getParameter("description");
        String image = request.getParameter("image");
        int price = 200;
        double rating = 8.0;

        try { price = Integer.parseInt(request.getParameter("price")); } catch(Exception e) {}
        try { rating = Double.parseDouble(request.getParameter("rating")); } catch(Exception e) {}

        try {
            Connection conn = DBConnection.connect();
            PreparedStatement pst = conn.prepareStatement(
                    "INSERT INTO movies(name, price, image, genre, rating, duration, description) VALUES(?,?,?,?,?,?,?)");
            pst.setString(1, name);
            pst.setInt(2, price);
            pst.setString(3, image != null ? image : "");
            pst.setString(4, genre != null ? genre : "Action");
            pst.setDouble(5, rating);
            pst.setString(6, duration != null ? duration : "2h 30m");
            pst.setString(7, description != null ? description : "An amazing movie!");
            pst.executeUpdate();
            conn.close();

            response.sendRedirect("admin/add-movie.jsp?success=Movie added successfully!");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin/add-movie.jsp?error=Failed to add movie");
        }
    }
}
