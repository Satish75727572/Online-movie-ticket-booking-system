<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String admin = (String) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - BookMyShow</title>
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body style="background: #f4f6f8;">

    <nav class="navbar" style="background: #1A1A2E;">
        <div class="navbar-inner">
            <div class="navbar-brand" style="color: white;">
                <i class="fas fa-user-shield" style="color: var(--primary);"></i> Admin Dashboard
            </div>
            <div class="nav-actions">
                <a href="../logout" class="btn btn-outline btn-sm" style="color: white; border-color: white;">Logout</a>
            </div>
        </div>
    </nav>

    <div class="section fade-in">
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px; max-width: 800px; margin: 0 auto; margin-top: 40px;">
            
            <a href="add-movie.jsp" class="btn btn-outline" style="padding: 40px; display: flex; flex-direction: column; align-items: center; gap: 15px; border-radius: var(--radius-lg); text-decoration: none; color: var(--text-primary); transition: all 0.3s ease; box-shadow: var(--shadow); background: white;">
                <i class="fas fa-film" style="font-size: 40px; color: var(--primary);"></i>
                <span style="font-size: 20px; font-weight: 600;">Add New Movie</span>
                <p style="font-size: 13px; color: var(--text-secondary); text-align: center; margin: 0;">Upload posters and set pricing</p>
            </a>

            <a href="../admin-bookings" class="btn btn-outline" style="padding: 40px; display: flex; flex-direction: column; align-items: center; gap: 15px; border-radius: var(--radius-lg); text-decoration: none; color: var(--text-primary); transition: all 0.3s ease; box-shadow: var(--shadow); background: white;">
                <i class="fas fa-list-ul" style="font-size: 40px; color: var(--success);"></i>
                <span style="font-size: 20px; font-weight: 600;">View All Bookings</span>
                <p style="font-size: 13px; color: var(--text-secondary); text-align: center; margin: 0;">Track revenue and seat occupancy</p>
            </a>
            
        </div>
    </div>

</body>
</html>
