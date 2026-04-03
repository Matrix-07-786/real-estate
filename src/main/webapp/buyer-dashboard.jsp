<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Buyer Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body {
  background: linear-gradient(rgba(0,0,0,0.8), rgba(0,0,0,0.8)),
  url("https://images.unsplash.com/photo-1600596542815-ffad4c1539a9");
  background-size: cover;
  background-position: center;
  min-height: 100vh;
  color: #fff;
}

.property-card {
  background: rgba(255,255,255,0.1);
  backdrop-filter: blur(10px);
  border-radius: 15px;
}

.featured-card {
  background: rgba(255, 215, 0, 0.15);
  backdrop-filter: blur(10px);
  border-radius: 15px;
  border: 1px solid rgba(255, 215, 0, 0.4);
}

.property-img {
  height: 200px;
  object-fit: cover;
}
</style>

</head>

<body>

<nav class="navbar navbar-dark bg-black px-4">
  <a class="navbar-brand">&#127968; RealEstate</a>
  <div>
    <a href="mybookings" class="btn btn-outline-light btn-sm me-2">My Bookings</a>
    <a href="search.html" class="btn btn-outline-light btn-sm me-2">Search</a>
    <a href="profile" class="btn btn-outline-light btn-sm me-2">Profile</a>
    <a href="login.html" class="btn btn-danger btn-sm">Logout</a>
  </div>
</nav>

<div class="container mt-4">

<%
List<Map<String, String>> featuredProperties =
    (List<Map<String, String>>) request.getAttribute("featuredProperties");

if (featuredProperties != null && !featuredProperties.isEmpty()) {
%>

<h2 class="mb-3">&#11088; Featured Properties</h2>
<div class="row g-4 mb-5">
<%
  for (Map<String, String> fp : featuredProperties) {
%>
<div class="col-md-4">
  <div class="card featured-card text-white">
    <span class="badge bg-warning text-dark position-absolute top-0 start-0 m-2 px-2 py-1">&#11088; Featured</span>
    <img src="<%= fp.get("image_url") %>" class="property-img card-img-top">
    <div class="card-body">
      <h5><%= fp.get("title") %></h5>
      <p>
        Location: <%= fp.get("city") %> <br>
        Bedrooms: <%= fp.get("bedrooms") %> BHK <br>
        Price: &#8377;<%= fp.get("price") %>
      </p>
      <a href="bookproperty?property_id=<%= fp.get("id") %>" class="btn btn-warning w-100 text-dark fw-bold">Book Now</a>
    </div>
  </div>
</div>
<%
  }
%>
</div>

<% } %>

<h2>Available Properties</h2>

<div class="row g-4">

<%
List<Map<String, String>> properties =
    (List<Map<String, String>>) request.getAttribute("properties");

if (properties != null && !properties.isEmpty()) {
    for (Map<String, String> p : properties) {
%>

<div class="col-md-4">
  <div class="card property-card text-white">
    <img src="<%= p.get("image_url") %>" class="property-img">

    <div class="card-body">
      <h5><%= p.get("title") %></h5>
      <p>
        Location: <%= p.get("city") %> <br>
        Bedrooms: <%= p.get("bedrooms") %> BHK <br>
        Price: ₹<%= p.get("price") %>
      </p>
      <a href="bookproperty?property_id=<%= p.get("id") %>" class="btn btn-primary w-100">Book Now</a>
    </div>
  </div>
</div>

<%
    }
} else {
%>

<p>No properties found</p>

<%
}
%>

</div>

</div>

</body>
</html>