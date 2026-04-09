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
    <title>Add New Movie - Admin</title>
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body style="background: #f4f6f8;">

    <nav class="navbar" style="background: #1A1A2E;">
        <div class="navbar-inner">
            <div class="navbar-brand" style="color: white;">
                <i class="fas fa-plus-circle" style="color: var(--primary);"></i> Add Movie
            </div>
            <div class="nav-actions">
                <a href="dashboard.jsp" class="btn btn-outline btn-sm" style="color: white; border-color: white;">Back to Dashboard</a>
            </div>
        </div>
    </nav>

    <div class="section fade-in">
        <div style="max-width: 600px; margin: 0 auto; background: white; padding: 40px; border-radius: var(--radius-lg); box-shadow: var(--shadow);">
            <h2 style="margin-bottom: 24px;">Enter Movie Details</h2>
            
            <% 
                String error = request.getParameter("error");
                String success = request.getParameter("success");
                if(error != null) { out.print("<div class='alert alert-error'>" + error + "</div>"); }
                if(success != null) { out.print("<div class='alert alert-success'>" + success + "</div>"); }
            %>

            <form action="../admin-add-movie" method="POST">
                <div class="form-group">
                    <label>Movie Name</label>
                    <input type="text" name="name" class="form-control" required>
                </div>
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div class="form-group">
                        <label>Genre</label>
                        <input type="text" name="genre" class="form-control" placeholder="e.g. Action/Sci-Fi" required>
                    </div>
                    <div class="form-group">
                        <label>Ticket Price (₹)</label>
                        <input type="number" name="price" class="form-control" required>
                    </div>
                </div>
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div class="form-group">
                        <label>Rating (e.g. 8.5)</label>
                        <input type="number" step="0.1" name="rating" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>Duration</label>
                        <input type="text" name="duration" class="form-control" placeholder="e.g. 2h 45m" required>
                    </div>
                </div>
                <div class="form-group">
                    <label>Image URL or Path</label>
                    <input type="text" name="image" class="form-control" placeholder="images/movie.png" required>
                </div>
                <div class="form-group">
                    <label>Description</label>
                    <textarea name="description" class="form-control" rows="3" required></textarea>
                </div>
                
                <button type="submit" class="btn btn-primary btn-block btn-lg" style="margin-top: 10px;">Add Movie</button>
            </form>
        </div>
    </div>

</body>
</html>
