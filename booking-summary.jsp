<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Data comes from POST form in select-seats.jsp
    String movie = request.getParameter("movie");
    String showtime = request.getParameter("showtime");
    String seats = request.getParameter("seats");
    String countStr = request.getParameter("count");
    String priceStr = request.getParameter("price");
    
    if (movie == null || seats == null || seats.isEmpty()) {
        response.sendRedirect("movies");
        return;
    }
    
    int count = Integer.parseInt(countStr);
    int price = Integer.parseInt(priceStr);
    int ticketTotal = count * price;
    int convenienceFee = 35 * count; // Base fee per ticket
    int grandTotal = ticketTotal + convenienceFee;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Summary - BookMyShow</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body style="background: var(--bg-body);">

    <!-- Header -->
    <div class="page-header">
        <h1>Booking Summary</h1>
        <p>Review your selection before payment</p>
    </div>

    <div class="summary-page fade-in">
        <div class="summary-card">
            <div class="header">
                <h2><%= movie %></h2>
                <p><%= showtime %> | Seats: <%= count %></p>
            </div>
            
            <div class="body">
                <div class="summary-row">
                    <span class="label">Seat Numbers</span>
                    <span class="value" style="font-size: 13px;"><%= seats %></span>
                </div>
                
                <div class="summary-row">
                    <span class="label">Tickets (<%= count %> × ₹<%= price %>)</span>
                    <span class="value">₹<%= ticketTotal %></span>
                </div>
                
                <div class="summary-row">
                    <span class="label">Convenience Fees</span>
                    <span class="value">₹<%= convenienceFee %>.00</span>
                </div>
                
                <div class="summary-row total">
                    <span class="label">Amount Payable</span>
                    <span class="value">₹<%= grandTotal %>.00</span>
                </div>
            </div>
            
            <div class="footer text-center">
                <form action="payment.jsp" method="POST">
                    <input type="hidden" name="movie" value="<%= movie %>">
                    <input type="hidden" name="showtime" value="<%= showtime %>">
                    <input type="hidden" name="seats" value="<%= seats %>">
                    <input type="hidden" name="total" value="<%= grandTotal %>">
                    
                    <button type="submit" class="btn btn-primary btn-block btn-lg">Proceed to Payment Form</button>
                    <a href="javascript:history.back()" class="btn btn-outline btn-block" style="margin-top: 12px;">Go Back to Seats</a>
                </form>
            </div>
        </div>
    </div>

</body>
</html>
