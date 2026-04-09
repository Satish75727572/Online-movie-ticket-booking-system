import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;

public class MovieServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        try {
            Connection conn = DBConnection.connect();
            
            if (idParam != null && !idParam.isEmpty()) {
                // Fetch single movie detail
                PreparedStatement pst = conn.prepareStatement("SELECT * FROM movies WHERE id=?");
                pst.setInt(1, Integer.parseInt(idParam));
                ResultSet rs = pst.executeQuery();
                
                if (rs.next()) {
                    Map<String, String> movie = new HashMap<>();
                    movie.put("id", rs.getString("id"));
                    movie.put("name", rs.getString("name"));
                    movie.put("price", rs.getString("price"));
                    movie.put("image", rs.getString("image"));
                    movie.put("genre", rs.getString("genre"));
                    movie.put("rating", rs.getString("rating"));
                    movie.put("duration", rs.getString("duration"));
                    movie.put("description", rs.getString("description"));
                    request.setAttribute("movie", movie);
                }
                
                conn.close();
                request.getRequestDispatcher("/movie-detail.jsp").forward(request, response);
                
            } else {
                // Fetch all movies for homepage
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM movies");
                
                List<Map<String, String>> movies = new ArrayList<>();
                while(rs.next()) {
                    Map<String, String> movie = new HashMap<>();
                    movie.put("id", rs.getString("id"));
                    movie.put("name", rs.getString("name"));
                    movie.put("price", rs.getString("price"));
                    movie.put("image", rs.getString("image"));
                    movie.put("genre", rs.getString("genre"));
                    movie.put("rating", rs.getString("rating"));
                    movies.add(movie);
                }
                
                conn.close();
                request.setAttribute("movies", movies);
                request.getRequestDispatcher("/index.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}