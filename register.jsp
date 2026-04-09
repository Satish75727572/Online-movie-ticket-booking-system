<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - BookMyShow Clone</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="auth-container">
        <div class="auth-card">
            <h2>Create an Account</h2>
            <p class="subtitle">Join us to book tickets seamlessly</p>

            <% 
                String error = request.getParameter("error");
                if(error != null) { out.print("<div class='alert alert-error'><i class='fas fa-exclamation-circle'></i> " + error + "</div>"); }
            %>

            <form action="register" method="POST" id="regForm" onsubmit="return validateForm('regForm')">
                <div class="form-group">
                    <label>Choose Username</label>
                    <input type="text" name="username" class="form-control" placeholder="Create a username" required>
                </div>
                <div class="form-group">
                    <label>Create Password</label>
                    <input type="password" name="password" class="form-control" placeholder="Create a strong password" required>
                </div>
                <button type="submit" class="btn btn-primary btn-block btn-lg" style="margin-top: 10px;">Register</button>
            </form>

            <div class="form-footer">
                Already have an account? <a href="login.jsp">Login here</a>
            </div>
        </div>
    </div>
    <script src="js/app.js"></script>
</body>
</html>
