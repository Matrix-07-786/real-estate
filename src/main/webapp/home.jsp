<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Real Estate Home</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: Arial, sans-serif;
    }

    body {
      background: #f2f2f2;
    }

    nav {
      background-color: #101110;
      color: white;
      padding: 15px 30px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      position: sticky;
      top: 0;
      z-index: 1000;
    }

    nav h1 { font-size: 24px; }

    nav ul {
      list-style: none;
      display: flex;
      gap: 20px;
    }

    nav ul li a {
      color: white;
      text-decoration: none;
      font-weight: bold;
      transition: 0.3s;
    }

    nav ul li a:hover { text-decoration: underline; }

    .hero {
      background: url('https://images.unsplash.com/photo-1570129477492-45c003edd2be?auto=format&fit=crop&w=1470&q=80') no-repeat center center;
      background-size: cover;
      height: 400px;
      display: flex;
      justify-content: center;
      align-items: center;
      color: white;
      text-align: center;
      position: relative;
    }

    .hero::after {
      content: "";
      position: absolute;
      top: 0; left: 0;
      width: 100%; height: 100%;
      background-color: rgba(0,0,0,0.5);
    }

    .hero-content {
      position: relative;
      z-index: 1;
    }

    .hero-content h2 { font-size: 48px; margin-bottom: 20px; }
    .hero-content p  { font-size: 20px; }

    .listing-section {
      padding: 40px 20px;
      max-width: 1200px;
      margin: auto;
    }

    .listing-section h2 {
      text-align: center;
      margin-bottom: 40px;
      color: #333;
    }

    .listing-container {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
      gap: 20px;
    }

    .property-card {
      background: white;
      border-radius: 10px;
      overflow: hidden;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
      transition: transform 0.2s;
      position: relative;
    }

    .property-card:hover { transform: translateY(-5px); }

    .property-card img {
      width: 100%;
      height: 200px;
      object-fit: cover;
    }

    .property-details { padding: 15px; }
    .property-details h3 { margin-bottom: 10px; color: #333; }
    .property-details p  { margin: 5px 0; color: #555; font-size: 14px; }

    .property-details .price {
      font-weight: bold;
      color: #0a0a0a;
      font-size: 16px;
    }

    .featured-badge {
      position: absolute;
      top: 10px;
      left: 10px;
      background: #ffc107;
      color: #000;
      font-size: 12px;
      font-weight: bold;
      padding: 4px 10px;
      border-radius: 20px;
    }

    .no-featured {
      text-align: center;
      color: #888;
      font-size: 16px;
      padding: 30px;
    }

    footer {
      background-color: #040404;
      color: white;
      text-align: center;
      padding: 20px;
      margin-top: 40px;
    }
  </style>
</head>
<body>

  <nav>
    <h1>Real Estate</h1>
    <ul>
      <li><a href="home">Home</a></li>
      <li><a href="signup.html">Register</a></li>
      <li><a href="login.html">Login</a></li>
      <li><a href="contact.html">Contact</a></li>
    </ul>
  </nav>

  <div class="hero">
    <div class="hero-content">
      <h2>Find Your Dream Home</h2>
      <p>Explore the best properties for sale and rent</p>
    </div>
  </div>

  <section class="listing-section">
    <h2>&#11088; Featured Properties</h2>

    <%
      List<Map<String, String>> featuredProperties =
          (List<Map<String, String>>) request.getAttribute("featuredProperties");

      if (featuredProperties != null && !featuredProperties.isEmpty()) {
    %>
    <div class="listing-container">
    <%
      for (Map<String, String> prop : featuredProperties) {
    %>
      <div class="property-card">
        <span class="featured-badge">&#11088; Featured</span>
        <img src="<%= prop.get("image_url") %>" alt="<%= prop.get("title") %>">
        <div class="property-details">
          <h3><%= prop.get("title") %></h3>
          <p>City: <%= prop.get("city") %></p>
          <p>Bedrooms: <%= prop.get("bedrooms") %> | Bathrooms: <%= prop.get("bathrooms") %> | <%= prop.get("area_sqft") %> sqft</p>
          <p class="price">&#8377;<%= prop.get("price") %></p>
        </div>
      </div>
    <%
      }
    %>
    </div>
    <%
      } else {
    %>
    <p class="no-featured">No featured properties at the moment. Check back soon!</p>
    <%
      }
    %>
  </section>

  <footer>
    <p>&copy; 2026 Real Estate. All rights reserved.</p>
  </footer>

</body>
</html>
