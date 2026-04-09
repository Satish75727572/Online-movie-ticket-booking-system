import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            response.sendRedirect("register.jsp?error=All fields are required");
            return;
        }

        try {
            Connection conn = DBConnection.connect();

            // Check if username exists
            PreparedStatement check = conn.prepareStatement("SELECT id FROM users WHERE username=?");
            check.setString(1, username);
            if (check.executeQuery().next()) {
                response.sendRedirect("register.jsp?error=Username already exists");
                conn.close();
                return;
            }

            PreparedStatement pst = conn.prepareStatement(
                    "INSERT INTO users(username, password) VALUES(?,?)");
            pst.setString(1, username);
            pst.setString(2, password);
            pst.executeUpdate();
            conn.close();

            response.sendRedirect("login.jsp?success=Registration successful! Please login.");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=Registration failed");
        }
    }
}
