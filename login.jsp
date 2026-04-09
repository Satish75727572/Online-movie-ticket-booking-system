<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - BookMyShow Clone</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="auth-container">
        <div class="auth-card">
            <h2>Welcome Back</h2>
            <p class="subtitle">Log in to book your favorite movies</p>

            <% 
                String error = request.getParameter("error");
                String success = request.getParameter("success");
                if(error != null) { out.print("<div class='alert alert-error'><i class='fas fa-exclamation-circle'></i> " + error + "</div>"); }
                if(success != null) { out.print("<div class='alert alert-success'><i class='fas fa-check-circle'></i> " + success + "</div>"); }
            %>

            <form action="login" method="POST" id="loginForm" onsubmit="return validateForm('loginForm')">
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="username" class="form-control" placeholder="Enter your username" required>
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" class="form-control" placeholder="Enter your password" required>
                </div>
                <button type="submit" class="btn btn-primary btn-block btn-lg" style="margin-top: 10px;">Login</button>
            </form>

            <div class="form-footer">
                Don't have an account? <a href="register.jsp">Register now</a><br><br>
                <a href="admin/login.jsp" style="color: var(--text-secondary); font-weight: 500;"><i class="fas fa-lock"></i> Admin Login</a>
            </div>
        </div>
    </div>
    <script src="js/app.js"></script>
</body>
</html>
