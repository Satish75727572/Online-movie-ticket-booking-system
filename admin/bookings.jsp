<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
    String admin = (String) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<Map<String, String>> allBookings = (List<Map<String, String>>) request.getAttribute("allBookings");
    if (allBookings == null) {
        response.sendRedirect("../admin-bookings");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Bookings - Admin</title>
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body style="background: #f4f6f8;">

    <nav class="navbar" style="background: #1A1A2E;">
        <div class="navbar-inner">
            <div class="navbar-brand" style="color: white;">
                <i class="fas fa-list-ul" style="color: var(--success);"></i> All Bookings
            </div>
            <div class="nav-actions">
                <a href="dashboard.jsp" class="btn btn-outline btn-sm" style="color: white; border-color: white;">Back to Dashboard</a>
            </div>
        </div>
    </nav>

    <div class="section fade-in">
        <div style="max-width: 1000px; margin: 0 auto; background: white; border-radius: var(--radius-lg); box-shadow: var(--shadow); overflow: hidden;">
            
            <table style="width: 100%; border-collapse: collapse; text-align: left;">
                <thead>
                    <tr style="background: var(--bg-body); border-bottom: 2px solid #eee;">
                        <th style="padding: 16px;">Booking ID</th>
                        <th style="padding: 16px;">User</th>
                        <th style="padding: 16px;">Movie</th>
                        <th style="padding: 16px;">Showtime</th>
                        <th style="padding: 16px;">Seats</th>
                        <th style="padding: 16px;">Revenue</th>
                    </tr>
                </thead>
                <tbody>
                    <% if(allBookings.isEmpty()) { %>
                        <tr><td colspan="6" style="padding: 24px; text-align: center; color: var(--text-light);">No bookings found in the system.</td></tr>
                    <% } else { %>
                        <% for(Map<String, String> b : allBookings) { %>
                        <tr style="border-bottom: 1px solid #eee; transition: background 0.2s;">
                            <td style="padding: 16px; font-weight: 500; color: var(--primary);">BMSX<%= b.get("id") %></td>
                            <td style="padding: 16px;"><i class="far fa-user" style="color: var(--text-light);"></i> <%= b.get("username") %></td>
                            <td style="padding: 16px; font-weight: 600;"><%= b.get("movie") %></td>
                            <td style="padding: 16px;"><%= b.get("showtime") %></td>
                            <td style="padding: 16px;"><span style="background: #f0f0f0; padding: 4px 8px; border-radius: 4px; font-size: 13px;"><%= b.get("seats") %></span></td>
                            <td style="padding: 16px; color: var(--success); font-weight: bold;">₹<%= b.get("total") %></td>
                        </tr>
                        <% } %>
                    <% } %>
                </tbody>
            </table>
            
        </div>
    </div>

</body>
</html>
