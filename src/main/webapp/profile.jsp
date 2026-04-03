<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Profile</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body {
  background: linear-gradient(rgba(0,0,0,0.85), rgba(0,0,0,0.85)),
    url("https://images.unsplash.com/photo-1600585154526-990dced4db0d") no-repeat center center fixed;
  background-size: cover;
  min-height: 100vh;
  color: white;
}

.profile-card {
  background: rgba(255,255,255,0.08);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255,255,255,0.12);
  padding: 35px 30px;
  border-radius: 20px;
}

.avatar-circle {
  width: 90px;
  height: 90px;
  border-radius: 50%;
  background: linear-gradient(135deg, #27ae60, #1a7a45);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 40px;
  margin: 0 auto 15px auto;
}

.booking-card {
  background: rgba(255,255,255,0.08);
  backdrop-filter: blur(8px);
  border: 1px solid rgba(255,255,255,0.1);
  border-radius: 15px;
  overflow: hidden;
}

.badge-pending   { background-color: #f39c12; color: #000; }
.badge-confirmed { background-color: #27ae60; }
.badge-cancelled { background-color: #e74c3c; }
</style>
</head>

<body>

<nav class="navbar navbar-dark bg-black px-4">
  <a class="navbar-brand">&#128100; Profile</a>
  <div>
    <a href="viewproperties" class="btn btn-outline-light btn-sm me-2">Dashboard</a>
    <a href="mybookings" class="btn btn-outline-light btn-sm me-2">My Bookings</a>
    <a href="login.html" class="btn btn-danger btn-sm">Logout</a>
  </div>
</nav>

<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-5 mb-5">

      <!-- Profile Card -->
      <div class="profile-card text-center">
        <div class="avatar-circle">&#128100;</div>
        <h3 class="mb-1"><%= request.getAttribute("name") %></h3>
        <p class="mb-1 text-light opacity-75">&#128231; <%= request.getAttribute("email") %></p>
        <span class="badge bg-success mt-2 px-3 py-2" style="font-size:13px;">
          <%= request.getAttribute("userType") != null ? request.getAttribute("userType").toString().toUpperCase() : "USER" %>
        </span>
      </div>

    </div>
  </div>

  <!-- Bookings -->
  <h4 class="mb-3">&#128203; My Bookings</h4>

  <%
    List<Map<String, String>> bookings =
        (List<Map<String, String>>) request.getAttribute("bookings");

    if (bookings != null && !bookings.isEmpty()) {
  %>
  <div class="row g-4">
  <%
      for (Map<String, String> b : bookings) {
        String status = b.get("status") != null ? b.get("status") : "pending";
        String badgeClass = "badge-pending";
        if ("confirmed".equalsIgnoreCase(status))  badgeClass = "badge-confirmed";
        else if ("cancelled".equalsIgnoreCase(status)) badgeClass = "badge-cancelled";
  %>
    <div class="col-md-4">
      <div class="booking-card text-white">
        <div class="p-3">
          <h5 class="mb-1">&#127968; <%= b.get("title") %></h5>
          <p class="mb-1 opacity-75">&#128205; <%= b.get("city") %></p>
          <p class="mb-1">&#8377; <%= b.get("price") %></p>
          <p class="mb-2 opacity-75">&#128197; <%= b.get("booking_date") %></p>
          <span class="badge <%= badgeClass %>"><%= status.toUpperCase() %></span>
        </div>
      </div>
    </div>
  <%
      }
  %>
  </div>
  <%
    } else {
  %>
  <div class="text-center mt-4">
    <p class="opacity-75">No bookings yet.</p>
    <a href="viewproperties" class="btn btn-success mt-2">Browse Properties</a>
  </div>
  <%
    }
  %>

</div>

</body>
</html>
