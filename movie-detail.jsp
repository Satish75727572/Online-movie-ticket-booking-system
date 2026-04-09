<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
    Map<String, String> movie = (Map<String, String>) request.getAttribute("movie");
    if (movie == null) {
        response.sendRedirect("movies");
        return;
    }
    String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= movie.get("name") %> - BookMyShow Clone</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar">
        <div class="navbar-inner">
            <a href="movies" class="navbar-brand">
                <i class="fas fa-ticket-alt logo-icon" style="color: var(--primary);"></i>
                BookMy<span>Show</span>
            </a>
            <div class="nav-search">
                <i class="fas fa-search search-icon"></i>
                <input type="text" placeholder="Search for Movies...">
            </div>
            <div class="nav-actions">
                <% if(username != null) { %>
                    <a href="my-bookings" class="btn btn-outline btn-sm">My Bookings</a>
                    <a href="logout" class="btn btn-dark btn-sm">Logout</a>
                <% } else { %>
                    <a href="login.jsp" class="btn btn-primary btn-sm">Sign In</a>
                <% } %>
            </div>
        </div>
    </nav>

    <!-- Movie Detail Hero -->
    <div class="movie-detail-hero fade-in">
        <div class="movie-detail-inner">
            
            <div class="movie-detail-poster">
                <img src="<%= movie.get("image") != null && !movie.get("image").isEmpty() ? movie.get("image") : "images/default.png" %>" alt="<%= movie.get("name") %>">
            </div>

            <div class="movie-detail-info">
                <h1><%= movie.get("name") %></h1>
                
                <div class="movie-meta">
                    <span class="meta-tag rating"><i class="fas fa-star"></i> <%= movie.get("rating") %>/10 Rating</span>
                    <span class="meta-tag"><%= movie.get("genre") %></span>
                    <span class="meta-tag"><i class="far fa-clock"></i> <%= movie.get("duration") %></span>
                </div>

                <p class="movie-description"><%= movie.get("description") %></p>

                <div style="margin-top: 30px; display: flex; align-items: center; gap: 20px;">
                    <a href="select-showtime.jsp?id=<%= movie.get("id") %>&name=<%= java.net.URLEncoder.encode(movie.get("name"), "UTF-8") %>&price=<%= movie.get("price") %>" class="btn btn-primary btn-lg">Book Tickets</a>
                    <span style="color: white; font-size: 18px; font-weight: 600;">₹<%= movie.get("price") %> / Seat</span>
                </div>
            </div>

        </div>
    </div>

    <!-- About Section -->
    <section class="section">
        <h2 class="section-title">About the Movie</h2>
        <p style="color: var(--text-secondary); max-width: 800px; line-height: 1.8;">
            Experience the thrill of <%= movie.get("name") %> on the big screen. 
            This is a masterpiece that combines stunning visuals with an engaging storyline.
            Don't miss out on the action and drama. Book your tickets now and enjoy the show!
        </p>
    </section>

</body>
</html>
