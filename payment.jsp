<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String error = request.getParameter("error");
    String movie = request.getParameter("movie");
    String showtime = request.getParameter("showtime");
    String seats = request.getParameter("seats");
    String total = request.getParameter("total");
    
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
    <title>Payment - BookMyShow</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body style="background: var(--bg-body);">

    <div class="page-header">
        <h1>Payment</h1>
        <p>Complete your booking securely</p>
    </div>

    <div class="payment-section fade-in">
        <div class="payment-card">
            
            <% if(error != null) { out.print("<div class='alert alert-error'><i class='fas fa-exclamation-circle'></i> " + error + "</div>"); } %>

            <div style="text-align: center; margin-bottom: 24px;">
                <h2 style="font-size: 32px; color: var(--text-primary); margin-bottom: 4px;">₹<%= total %></h2>
                <p style="color: var(--text-secondary); font-size: 14px;"><%= movie %> | <%= seats %></p>
            </div>

            <div class="payment-methods">
                <div class="payment-method active" onclick="switchMethod(this, 'upi')">
                    <i class="fas fa-qrcode icon" style="color: #4CAF50;"></i>
                    <div class="name">UPI</div>
                </div>
                <div class="payment-method" onclick="switchMethod(this, 'card')">
                    <i class="far fa-credit-card icon" style="color: #2196F3;"></i>
                    <div class="name">Card</div>
                </div>
                <div class="payment-method" onclick="switchMethod(this, 'wallet')">
                    <i class="fas fa-wallet icon" style="color: #FF9800;"></i>
                    <div class="name">Wallet</div>
                </div>
            </div>

            <!-- Fake Form to trigger BookingServlet -->
            <form action="book" method="POST" id="payForm" onsubmit="return validateForm('payForm')">
                <input type="hidden" name="movie" value="<%= movie %>">
                <input type="hidden" name="showtime" value="<%= showtime %>">
                <input type="hidden" name="seats" value="<%= seats %>">
                <input type="hidden" name="total" value="<%= total %>">
                
                <div id="dynamicInput">
                    <div class="form-group">
                        <label>Enter UPI ID / VPA</label>
                        <input type="text" class="form-control" placeholder="e.g. username@upi" required>
                    </div>
                </div>
                
                <button type="submit" class="btn btn-primary btn-block btn-lg" style="margin-top: 10px;">Pay ₹<%= total %></button>
            </form>
            <p style="text-align: center; font-size: 12px; color: var(--text-light); margin-top: 20px;">
                <i class="fas fa-lock"></i> 100% Secure Transaction
            </p>
        </div>
    </div>

    <script src="js/app.js"></script>
    <script>
        const methodHTML = {
            'upi': `
                <div class="form-group">
                    <label>Enter UPI ID / VPA</label>
                    <input type="text" class="form-control" placeholder="e.g. username@upi" required>
                </div>
            `,
            'card': `
                <div class="form-group">
                    <label>Card Number</label>
                    <input type="text" class="form-control" placeholder="xxxx-xxxx-xxxx-xxxx" required pattern="\\d{16}" title="Enter 16 digit card number">
                </div>
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
                    <div class="form-group">
                        <label>Expiry Date</label>
                        <input type="text" class="form-control" placeholder="MM/YY" required pattern="(0[1-9]|1[0-2])\\/\\d{2}" title="MM/YY format">
                    </div>
                    <div class="form-group">
                        <label>CVV</label>
                        <input type="password" class="form-control" placeholder="•••" required pattern="\\d{3,4}" title="3 or 4 digit security code">
                    </div>
                </div>
                <div class="form-group">
                    <label>Name on Card</label>
                    <input type="text" class="form-control" placeholder="Cardholder Name" required>
                </div>
            `,
            'wallet': `
                <div class="form-group">
                    <label>Select Wallet Provider</label>
                    <select class="form-control" required style="width: 100%; border: 1px solid #ddd; padding: 12px; border-radius: var(--radius-md);">
                        <option value="">Choose Wallet...</option>
                        <option value="amazon">Amazon Pay</option>
                        <option value="paytm">Paytm</option>
                        <option value="phonepe">PhonePe</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Registered Mobile Number</label>
                    <input type="tel" class="form-control" placeholder="10-digit number" required pattern="\\d{10}">
                </div>
            `
        };

        function switchMethod(element, type) {
            // Remove active class from all tabs
            document.querySelectorAll('.payment-method').forEach(el => el.classList.remove('active'));
            // Set active class to clicked tab
            element.classList.add('active');
            // Inject new HTML form
            document.getElementById('dynamicInput').innerHTML = methodHTML[type];
        }
    </script>
</body>
</html>
