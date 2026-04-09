<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - BookMyShow</title>
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body style="background: #1A1A2E;">
    <div class="auth-container">
        <div class="auth-card">
            <h2 style="color: var(--primary);"><i class="fas fa-user-shield"></i> Admin Panel</h2>
            <p class="subtitle">Log in to manage movies and bookings</p>

            <% 
                String error = request.getParameter("error");
                if(error != null) { out.print("<div class='alert alert-error'><i class='fas fa-exclamation-circle'></i> " + error + "</div>"); }
            %>

            <form action="../admin-login" method="POST" id="adminLoginForm">
                <div class="form-group">
                    <label>Admin Username</label>
                    <input type="text" name="username" class="form-control" required>
                </div>
                <div class="form-group">
                    <label>Admin Password</label>
                    <input type="password" name="password" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-primary btn-block btn-lg" style="margin-top: 10px;">Secure Login</button>
            </form>
            
            <div class="form-footer" style="margin-top: 30px;">
                <a href="../index.jsp" style="color: var(--text-secondary);"><i class="fas fa-arrow-left"></i> Back to the Main Site</a>
            </div>
        </div>
    </div>
</body>
</html>
