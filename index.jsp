<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
    // If user requests index.jsp directly without going through MovieServlet, redirect them to the servlet
    if (request.getAttribute("movies") == null) {
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
    <title>Movie Tickets, Plays, Sports, Events - BookMyShow</title>
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
                <input type="text" placeholder="Search for Movies, Events, Plays...">
            </div>

            <div class="nav-actions">
                <ul class="nav-links">
                    <li><a href="movies" class="active">Movies</a></li>
                    <li><a href="#">Events</a></li>
                    <li><a href="#">Sports</a></li>
                </ul>
                
                <% if(username != null) { %>
                    <a href="my-bookings" class="btn btn-outline btn-sm">My Bookings</a>
                    <a href="logout" class="btn btn-dark btn-sm">Logout</a>
                <% } else { %>
                    <a href="login.jsp" class="btn btn-primary btn-sm">Sign In</a>
                <% } %>
            </div>
        </div>
    </nav>

    <!-- Hero Banner -->
    <section class="hero">
        <div class="hero-inner fade-in">
            <h1>It All Starts <span>Here!</span></h1>
            <p id="heroSubtitle">🎬 Book Your Favorite Movies</p>
            
            <div class="hero-stats">
                <div class="hero-stat">
                    <div class="num">1M+</div>
                    <div class="label">Tickets Booked</div>
                </div>
                <div class="hero-stat">
                    <div class="num">500+</div>
                    <div class="label">Cinemas</div>
                </div>
                <div class="hero-stat">
                    <div class="num">100+</div>
                    <div class="label">Cities</div>
                </div>
            </div>
        </div>
    </section>

    <!-- Recommended Movies Section -->
    <section class="section">
        <h2 class="section-title">Recommended Movies</h2>
        
        <div class="movie-grid">
            <% 
                List<Map<String, String>> movies = (List<Map<String, String>>) request.getAttribute("movies");
                if (movies != null && !movies.isEmpty()) {
                    for (Map<String, String> m : movies) {
            %>
            <a href="movies?id=<%= m.get("id") %>" class="movie-card">
                <div class="poster-wrap">
                    <img src="<%= m.get("image") != null && !m.get("image").isEmpty() ? m.get("image") : "images/default.png" %>" alt="<%= m.get("name") %>">
                    <div class="rating-badge">
                        <i class="fas fa-star star"></i> <%= m.get("rating") %>/10
                    </div>
                </div>
                <div class="card-body">
                    <div class="movie-title"><%= m.get("name") %></div>
                    <div class="movie-genre"><%= m.get("genre") %></div>
                    <div class="movie-price">
                        <span class="price-tag">₹<%= m.get("price") %></span>
                        <button class="book-btn">Book</button>
                    </div>
                </div>
            </a>
            <% 
                    }
                } else {
                    out.print("<p>No movies available right now. Check back later!</p>");
                }
            %>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="footer-inner">
            <div class="brand">BookMyShow Clone</div>
            <p>Copyright 2026 © Built with JSP & Servlets on Tomcat</p>
        </div>
    </footer>

    <script src="js/app.js"></script>
</body>
</html>
