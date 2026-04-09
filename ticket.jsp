<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Ticket data comes from session set by BookingServlet
    String movie = (String) session.getAttribute("ticket_movie");
    String seats = (String) session.getAttribute("ticket_seats");
    Integer total = (Integer) session.getAttribute("ticket_total");
    String showtime = (String) session.getAttribute("ticket_showtime");
    
    if (movie == null) {
        response.sendRedirect("movies");
        return;
    }
    
    // Clear ticket from session so it doesn't persist forever
    // session.removeAttribute("ticket_movie"); ...
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmed - Ticket</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body style="background: var(--bg-body);">

    <!-- Confetti / Success header -->
    <div style="background: #4CAF50; padding: 40px; text-align: center; color: white;">
        <i class="fas fa-check-circle" style="font-size: 48px; margin-bottom: 12px;"></i>
        <h2>Booking Successful!</h2>
        <p>Your tickets have been confirmed.</p>
    </div>

    <div class="ticket-container fade-in" style="margin-top: -30px;">
        <div class="ticket">
            
            <div class="ticket-header">
                <h2><%= movie %></h2>
                <p><%= showtime %></p>
            </div>
            
            <div class="ticket-divider">
                <div class="dashed"></div>
            </div>
            
            <div class="ticket-body">
                <div class="ticket-row">
                    <span class="label">Booked By</span>
                    <span class="value" style="color: var(--primary);"><%= username %></span>
                </div>
                <div class="ticket-row">
                    <span class="label">Seats</span>
                    <span class="value"><%= seats %></span>
                </div>
                <div class="ticket-row">
                    <span class="label">Cinema</span>
                    <span class="value">PVR: Inorbit, Mumbai</span>
                </div>
                <div class="ticket-row">
                    <span class="label">Booking ID</span>
                    <span class="value">BMS<%= System.currentTimeMillis() %></span>
                </div>
                
                <div class="ticket-total">
                    <div class="amount">₹<%= total %></div>
                    <div class="text">Total Paid (Inclusive of taxes)</div>
                </div>
                
                <div style="text-align: center; margin-top: 24px;">
                    <img src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=BMS<%= System.currentTimeMillis() %>" alt="QR Code" style="width: 100px; opacity: 0.8; border-radius: 4px;">
                    <p style="font-size: 11px; color: var(--text-light); margin-top: 8px;">Show this QR at cinema entry</p>
                </div>
            </div>
        </div>
        
        <div style="text-align: center; margin-top: 24px; display: flex; justify-content: center; gap: 15px;">
            <a href="movies" class="btn btn-outline">Back to Home</a>
            <button onclick="downloadPDF()" class="btn btn-primary"><i class="fas fa-file-pdf"></i> Download PDF</button>
        </div>
    </div>

    <!-- PDF Generation Script -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
    <script>
        function downloadPDF() {
            const element = document.querySelector('.ticket');
            const opt = {
                margin:       [0.5, 0.5, 0.5, 0.5],
                filename:     'BookMyShow_Ticket_<%= movie.replaceAll("\\s+", "_") %>.pdf',
                image:        { type: 'jpeg', quality: 0.98 },
                html2canvas:  { scale: 2, useCORS: true },
                jsPDF:        { unit: 'in', format: 'letter', orientation: 'portrait' }
            };
            
            html2pdf().set(opt).from(element).save();
        }
    </script>

    </div>

</body>
</html>
