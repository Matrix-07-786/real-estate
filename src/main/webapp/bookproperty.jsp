<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
  Map<String, String> prop = (Map<String, String>) request.getAttribute("prop");
  if (prop == null) { response.sendRedirect("viewproperties"); return; }
  // min date = today
  String today = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Book Property</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body {
  background: linear-gradient(rgba(0,0,0,0.75), rgba(0,0,0,0.75)),
    url('https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1470&q=80') no-repeat center center fixed;
  background-size: cover;
  min-height: 100vh;
  color: #fff;
}
.property-summary {
  background: rgba(255,255,255,0.08);
  backdrop-filter: blur(8px);
  border-radius: 15px;
  overflow: hidden;
}
.property-summary img {
  width: 100%;
  height: 240px;
  object-fit: cover;
}
.form-card {
  background: rgba(255,255,255,0.95);
  border-radius: 15px;
  padding: 30px;
  color: #333;
}
</style>
</head>
<body>

<nav class="navbar navbar-dark bg-black px-4">
  <a class="navbar-brand">&#127968; RealEstate</a>
  <div>
    <a href="viewproperties" class="btn btn-outline-light btn-sm me-2">Dashboard</a>
    <a href="mybookings" class="btn btn-outline-light btn-sm me-2">My Bookings</a>
    <a href="login.html" class="btn btn-danger btn-sm">Logout</a>
  </div>
</nav>

<div class="container py-5">
  <div class="row g-4 justify-content-center">

    <!-- Property Summary -->
    <div class="col-md-5">
      <div class="property-summary">
        <img src="<%= prop.get("image_url") %>" alt="<%= prop.get("title") %>">
        <div class="p-4">
          <h4><%= prop.get("title") %></h4>
          <p class="mb-1">&#128205; <%= prop.get("city") %></p>
          <p class="mb-1">&#127968; <%= prop.get("bedrooms") %> BHK &nbsp;|&nbsp; <%= prop.get("bathrooms") %> Baths</p>
          <p class="mb-1">&#128400; <%= prop.get("area_sqft") %> sqft</p>
          <p class="mb-0 fs-5 fw-bold text-success">&#8377; <%= prop.get("price") %></p>
        </div>
      </div>
    </div>

    <!-- Booking Form -->
    <div class="col-md-5">
      <div class="form-card">
        <h4 class="mb-4">Confirm Your Booking</h4>
        <form action="bookproperty" method="post">
          <input type="hidden" name="property_id" value="<%= prop.get("id") %>">

          <div class="mb-3">
            <label class="form-label fw-semibold">Select Booking Date</label>
            <input type="date" name="booking_date" class="form-control" min="<%= today %>" required>
          </div>

          <button type="submit" class="btn btn-success w-100 py-2 fw-bold">Book Now</button>
          <a href="viewproperties" class="btn btn-outline-secondary w-100 mt-2">Cancel</a>
        </form>
      </div>
    </div>

  </div>
</div>

</body>
</html>
