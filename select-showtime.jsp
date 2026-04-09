<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp?error=Please login to book tickets");
        return;
    }
    String movieName = request.getParameter("name");
    String movieId = request.getParameter("id");
    String price = request.getParameter("price");
    
    if (movieName == null) {
        response.sendRedirect("movies");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Showtime - <%= movieName %></title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

    <!-- Header -->
    <div class="page-header">
        <h1><%= movieName %> - Select Showtime</h1>
        <p>Choose your preferred date and time</p>
    </div>

    <div class="showtime-section fade-in">
        
        <!-- Date Picker -->
        <h3 style="margin-bottom: 16px;">Select Date</h3>
        <div class="date-picker">
<%
    java.time.LocalDate today = java.time.LocalDate.now();
    java.time.format.DateTimeFormatter dayFmt = java.time.format.DateTimeFormatter.ofPattern("dd");
    java.time.format.DateTimeFormatter monthFmt = java.time.format.DateTimeFormatter.ofPattern("MMM");
    java.time.format.DateTimeFormatter dowFmt = java.time.format.DateTimeFormatter.ofPattern("EEE");

    for (int i = 0; i < 4; i++) {
        java.time.LocalDate d = today.plusDays(i);
        String dayLabel = i == 0 ? "TODAY" : (i == 1 ? "TOM" : d.format(dowFmt).toUpperCase());
        String activeClass = i == 0 ? " active" : "";
%>
            <div class="date-card<%= activeClass %>" data-date="<%= d.toString() %>">
                <div class="day"><%= dayLabel %></div>
                <div class="date"><%= d.format(dayFmt) %></div>
                <div class="month"><%= d.format(monthFmt).toUpperCase() %></div>
            </div>
<%  } %>
        </div>

        <!-- Available Cinemas & Times -->
        <h3 style="margin-bottom: 16px; margin-top: 30px;">Available Cinemas</h3>
        
        <form action="seats" method="GET">
            <input type="hidden" name="movie" value="<%= movieName %>">
            <input type="hidden" name="price" value="<%= price %>">
            <input type="hidden" name="showtime" id="selectedTime" required>

            <div style="background: var(--bg-card); border-radius: var(--radius-lg); padding: 24px; box-shadow: var(--shadow); margin-bottom: 24px;">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
                    <div>
                        <h4 style="font-size: 16px;">PVR: Inorbit, Malad</h4>
                        <p style="font-size: 12px; color: var(--text-secondary);"><i class="fas fa-map-marker-alt"></i> Malad West, Mumbai</p>
                    </div>
                </div>
                <div class="showtime-grid">
                    <div class="showtime-btn" data-time="10:00 AM">
                        <div class="time">10:00 AM</div>
                        <div class="format">2D</div>
                    </div>
                    <div class="showtime-btn" data-time="01:30 PM">
                        <div class="time">01:30 PM</div>
                        <div class="format">2D</div>
                    </div>
                    <div class="showtime-btn" data-time="04:45 PM">
                        <div class="time">04:45 PM</div>
                        <div class="format">2D</div>
                    </div>
                    <div class="showtime-btn" data-time="08:00 PM">
                        <div class="time">08:00 PM</div>
                        <div class="format">2D</div>
                    </div>
                </div>
            </div>

            <div style="background: var(--bg-card); border-radius: var(--radius-lg); padding: 24px; box-shadow: var(--shadow); margin-bottom: 30px;">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
                    <div>
                        <h4 style="font-size: 16px;">INOX: R-City, Ghatkopar</h4>
                        <p style="font-size: 12px; color: var(--text-secondary);"><i class="fas fa-map-marker-alt"></i> Ghatkopar West, Mumbai</p>
                    </div>
                </div>
                <div class="showtime-grid">
                    <div class="showtime-btn" data-time="11:15 AM">
                        <div class="time">11:15 AM</div>
                        <div class="format">3D / IMAX</div>
                    </div>
                    <div class="showtime-btn" data-time="02:30 PM">
                        <div class="time">02:30 PM</div>
                        <div class="format">3D / IMAX</div>
                    </div>
                    <div class="showtime-btn" data-time="06:00 PM">
                        <div class="time">06:00 PM</div>
                        <div class="format">3D / IMAX</div>
                    </div>
                    <div class="showtime-btn" data-time="09:15 PM">
                        <div class="time">09:15 PM</div>
                        <div class="format">3D / IMAX</div>
                    </div>
                </div>
            </div>

            <div style="text-align: right;">
                <button type="submit" class="btn btn-primary btn-lg" onclick="if(!document.getElementById('selectedTime').value) { alert('Please select a showtime first!'); return false; }">Select Seats</button>
            </div>
        </form>
    </div>

    <script src="js/app.js"></script>
</body>
</html>
