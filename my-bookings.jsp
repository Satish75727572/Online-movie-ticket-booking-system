<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<Map<String, String>> bookings = (List<Map<String, String>>) request.getAttribute("bookings");
    if (bookings == null) {
        response.sendRedirect("history");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings - BookMyShow</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

    <nav class="navbar">
        <div class="navbar-inner">
            <a href="movies" class="navbar-brand">
                <i class="fas fa-ticket-alt logo-icon" style="color: var(--primary);"></i>
                BookMy<span>Show</span>
            </a>
            <div class="nav-actions">
                <a href="movies" class="btn btn-dark btn-sm">Back to Home</a>
                <a href="logout" class="btn btn-outline btn-sm">Logout</a>
            </div>
        </div>
    </nav>

    <div class="page-header">
        <h1>My Bookings</h1>
        <p>Review your past trips to the cinema</p>
    </div>

    <section class="section">
        <% if (bookings.isEmpty()) { %>
            <div class="empty-state">
                <i class="fas fa-ticket-alt icon"></i>
                <h3>No Bookings Found</h3>
                <p>Looks like you haven't booked any movies yet.</p>
                <br>
                <a href="movies" class="btn btn-primary">Browse Movies</a>
            </div>
        <% } else { %>
            <div class="bookings-list fade-in" style="max-width: 800px; margin: 0 auto;">
                <% for (Map<String, String> b : bookings) { %>
                <div class="booking-card">
                    <div class="booking-icon">
                        <i class="fas fa-film" style="color: var(--primary);"></i>
                    </div>
                    <div class="booking-details">
                        <h4><%= b.get("movie") %></h4>
                        <p><strong>Showtime:</strong> <%= b.get("showtime") %> | <strong>Seats:</strong> <%= b.get("seats") %></p>
                        <p style="font-size: 11px; margin-top: 4px; color: var(--text-light);">
                            Booked on: <%= b.get("booking_date") %> | Ref: BMSX<%= b.get("id") %>
                        </p>
                    </div>
                    <div class="booking-amount">
                        ₹<%= b.get("total") %>
                    </div>
                </div>
                <% } %>
            </div>
        <% } %>
    </section>

</body>
</html>
