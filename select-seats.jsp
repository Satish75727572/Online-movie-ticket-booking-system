<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String movie = (String) request.getAttribute("movie");
    String showtime = (String) request.getAttribute("showtime");
    String priceStr = (String) request.getAttribute("price");
    List<String> bookedSeats = (List<String>) request.getAttribute("bookedSeats");
    
    if (movie == null) {
        response.sendRedirect("movies");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Seats - <%= movie %></title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

    <div class="page-header">
        <h1><%= movie %></h1>
        <p><%= showtime %> | ₹<%= priceStr %> / Seat</p>
    </div>

    <div class="seat-section fade-in">
        <div class="seat-legend">
            <div class="legend-item"><div class="legend-box available"></div> Available</div>
            <div class="legend-item"><div class="legend-box selected"></div> Selected</div>
            <div class="legend-item"><div class="legend-box booked"></div> Sold</div>
        </div>

        <div class="screen">All eyes this way please!</div>

        <div id="seatMap">
            <!-- Seat grid logic -->
            <% 
                String[] rows = {"A", "B", "C", "D", "E"};
                int cols = 10;
                
                out.print("<div class='seat-category'>");
                out.print("<div class='seat-category-title'>PREMIUM - ₹" + priceStr + "</div>");

                for (String row : rows) {
                    out.print("<div class='seat-row'>");
                    out.print("<div class='seat-row-label'>" + row + "</div>");
                    
                    for (int i = 1; i <= cols; i++) {
                        String seatId = row + i;
                        boolean isBooked = (bookedSeats != null && bookedSeats.contains(seatId));
                        String statusClass = isBooked ? "booked" : "available";
                        
                        out.print("<button class='seat " + statusClass + "' data-seat='" + seatId + "' " + 
                                  (isBooked ? "disabled" : "") + ">" + i + "</button>");
                        
                        // Add an aisle / gap
                        if (i == 5) {
                            out.print("<div style='width: 30px;'></div>");
                        }
                    }
                    out.print("</div>");
                }
                out.print("</div>");
            %>
        </div>
        
        <br><br><br>
    </div>

    <!-- Hidden form for summary bar submit -->
    <form action="booking-summary.jsp" method="POST" id="seatForm" style="display: none;">
        <input type="hidden" name="movie" value="<%= movie %>">
        <input type="hidden" name="showtime" value="<%= showtime %>">
        <input type="hidden" name="price" value="<%= priceStr %>">
        <input type="hidden" id="seatPrice" value="<%= priceStr %>">
        <input type="hidden" name="seats" id="selectedSeats">
        <input type="hidden" name="count" id="seatCount">
    </form>

    <!-- Floating Summary Bar -->
    <div class="summary-bar">
        <div class="summary-info">
            <span id="selectedCount">0</span> Tickets selected <br>
            <strong>₹<span id="selectedTotal">0</span></strong>
        </div>
        <button class="btn btn-primary" onclick="document.getElementById('seatForm').submit()">Proceed to Booking</button>
    </div>

    <script src="js/app.js"></script>
</body>
</html>
