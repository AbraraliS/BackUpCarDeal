<%-- 
    Document   : userProfile (Modernized)
    Created on : 30-Apr-2024, 1:34:03 pm
    Author     : Abrarali
    Refactored Version with Bootstrap 5 and Modern Design
--%>

<%@page import="carsellbuy.DataSource"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>My Profile - CarDeal</title>
    
    <!-- SEO Meta Tags -->
    <meta name="description" content="Manage your CarDeal profile, view your listings, and update account information">
    <meta name="keywords" content="user profile, car listings, account management, automotive marketplace">
    <meta name="author" content="CarDeal Team">
    
    <!-- Security Headers -->
    <meta http-equiv="Content-Security-Policy" content="default-src 'self'; script-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net; style-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net https://cdnjs.cloudflare.com; img-src 'self' data: https:; font-src 'self' https://cdnjs.cloudflare.com;">
    
    <!-- Favicon -->
    <link rel="icon" href="images/favicon.ico" type="image/x-icon">
    
    <!-- CSS Links -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">
    
    <!-- Custom Styles -->
    <style>
        :root {
            --primary-color: #007bff;
            --primary-dark: #0056b3;
            --primary-light: #e3f2fd;
            --primary-bg: rgba(0, 123, 255, 0.1);
            --secondary-color: #6c757d;
            --success-color: #28a745;
            --danger-color: #dc3545;
            --warning-color: #ffc107;
            --info-color: #17a2b8;
            --info-bg: #e6f7ff;
            --dark-color: #343a40;
            --light-color: #f8f9fa;
            --light-bg: #ffffff;
            --border-color: #dee2e6;
            --shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            --shadow-sm: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
            --shadow-lg: 0 1rem 3rem rgba(0, 0, 0, 0.175);
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            padding-top: 76px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .profile-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 3rem 0 2rem;
            margin-bottom: 2rem;
        }

        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 4px solid white;
            object-fit: cover;
            box-shadow: var(--shadow-lg);
            transition: transform 0.3s ease;
        }

        .profile-avatar:hover {
            transform: scale(1.05);
        }

        .profile-card {
            background: white;
            border-radius: 20px;
            box-shadow: var(--shadow);
            overflow: hidden;
            margin-bottom: 2rem;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .profile-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }

        .profile-nav {
            background: white;
            border-radius: 20px;
            box-shadow: var(--shadow-sm);
            overflow: hidden;
            margin-bottom: 2rem;
        }

        .nav-pills .nav-link {
            border-radius: 15px;
            margin: 0.25rem;
            padding: 1rem 1.5rem;
            color: var(--secondary-color);
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .nav-pills .nav-link.active {
            background: var(--primary-color);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 123, 255, 0.3);
        }

        .nav-pills .nav-link:hover:not(.active) {
            background: var(--primary-bg);
            color: var(--primary-color);
            transform: translateY(-1px);
        }

        .tab-content {
            min-height: 500px;
        }

        .info-card {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: var(--shadow-sm);
            margin-bottom: 1.5rem;
            border: 1px solid var(--border-color);
        }

        .info-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 0;
            border-bottom: 1px solid var(--border-color);
        }

        .info-item:last-child {
            border-bottom: none;
        }

        .info-label {
            font-weight: 600;
            color: var(--dark-color);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .info-value {
            color: var(--secondary-color);
            font-weight: 500;
        }

        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            text-align: center;
            box-shadow: var(--shadow-sm);
            border: 1px solid var(--border-color);
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow);
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: bold;
            color: var(--primary-color);
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: var(--secondary-color);
            font-weight: 500;
        }

        .car-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: var(--shadow-sm);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin-bottom: 1.5rem;
        }

        .car-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow);
        }

        .car-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .car-status {
            position: absolute;
            top: 1rem;
            right: 1rem;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 600;
        }

        .status-active {
            background: var(--success-color);
            color: white;
        }

        .status-pending {
            background: var(--warning-color);
            color: var(--dark-color);
        }

        .status-sold {
            background: var(--secondary-color);
            color: white;
        }

        .btn-primary {
            background: var(--primary-color);
            border: none;
            border-radius: 10px;
            padding: 0.75rem 2rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 123, 255, 0.3);
        }

        .btn-outline-primary {
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
            border-radius: 10px;
            padding: 0.75rem 2rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-outline-primary:hover {
            background: var(--primary-color);
            color: white;
            transform: translateY(-2px);
        }

        .form-control, .form-select {
            border-radius: 10px;
            border: 2px solid var(--border-color);
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }

        .alert {
            border-radius: 15px;
            border: none;
            padding: 1rem 1.5rem;
        }

        .pagination .page-link {
            border-radius: 10px;
            margin: 0 0.25rem;
            border: 2px solid var(--border-color);
            color: var(--primary-color);
            transition: all 0.3s ease;
        }

        .pagination .page-link:hover {
            background: var(--primary-color);
            border-color: var(--primary-color);
            color: white;
            transform: translateY(-2px);
        }

        .pagination .page-item.active .page-link {
            background: var(--primary-color);
            border-color: var(--primary-color);
        }

        @media (max-width: 768px) {
            .profile-header {
                padding: 2rem 0 1rem;
            }

            .profile-avatar {
                width: 80px;
                height: 80px;
            }

            .stat-card {
                margin-bottom: 1rem;
            }

            .nav-pills {
                flex-wrap: wrap;
            }

            .nav-pills .nav-link {
                flex: 1;
                text-align: center;
                margin: 0.25rem 0;
            }
        }
    </style>
</head>

<%
    // Check if user is logged in
    String userEmail = (String) session.getAttribute("userEmail");
    String userName = (String) session.getAttribute("userName");
    
    if (userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Get user data and statistics
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    int totalListings = 0;
    int activeListings = 0;
    int soldCars = 0;
    String userPhone = "";
    String userLocation = "";
    String joinDate = "";
    
    try {
        conn = DataSource.getConnection();
        
        // Get user details
        String userQuery = "SELECT phone, location, created_date FROM users WHERE email = ?";
        pstmt = conn.prepareStatement(userQuery);
        pstmt.setString(1, userEmail);
        rs = pstmt.executeQuery();
        
        if (rs.next()) {
            userPhone = rs.getString("phone") != null ? rs.getString("phone") : "";
            userLocation = rs.getString("location") != null ? rs.getString("location") : "";
            joinDate = rs.getString("created_date") != null ? rs.getString("created_date") : "";
        }
        
        // Get listing statistics
        String statsQuery = "SELECT COUNT(*) as total, SUM(CASE WHEN status = 'active' THEN 1 ELSE 0 END) as active, SUM(CASE WHEN status = 'sold' THEN 1 ELSE 0 END) as sold FROM car_listings WHERE seller_email = ?";
        pstmt = conn.prepareStatement(statsQuery);
        pstmt.setString(1, userEmail);
        rs = pstmt.executeQuery();
        
        if (rs.next()) {
            totalListings = rs.getInt("total");
            activeListings = rs.getInt("active");
            soldCars = rs.getInt("sold");
        }
        
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>

<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top">
        <div class="container">
            <a class="navbar-brand fw-bold" href="index.jsp">
                <i class="fas fa-car"></i> CarDeal
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="index.jsp">
                            <i class="fas fa-home"></i> Home
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="cars.jsp">
                            <i class="fas fa-car"></i> Browse Cars
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="SellCar2.jsp">
                            <i class="fas fa-plus-circle"></i> Sell Car
                        </a>
                    </li>
                </ul>
                
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle active" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-user-circle"></i> <%=userName != null ? userName : "User"%>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item active" href="userProfile.jsp"><i class="fas fa-user"></i> My Profile</a></li>
                            <li><a class="dropdown-item" href="MyUCars.jsp"><i class="fas fa-car"></i> My Listings</a></li>
                            <li><a class="dropdown-item" href="BuyHist.jsp"><i class="fas fa-history"></i> Purchase History</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="userUpdate.jsp"><i class="fas fa-edit"></i> Edit Profile</a></li>
                            <li><a class="dropdown-item" href="ChangePass.jsp"><i class="fas fa-key"></i> Change Password</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-danger" href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Profile Header -->
    <section class="profile-header">
        <div class="container">
            <div class="row align-items-center" data-aos="fade-up">
                <div class="col-auto">
                    <img src="images/default-avatar.png" alt="Profile Picture" class="profile-avatar">
                </div>
                <div class="col">
                    <h1 class="mb-2"><%=userName != null ? userName : "User Profile"%></h1>
                    <p class="mb-1"><i class="fas fa-envelope"></i> <%=userEmail%></p>
                    <%if (!userPhone.isEmpty()) {%>
                        <p class="mb-1"><i class="fas fa-phone"></i> <%=userPhone%></p>
                    <%}%>
                    <%if (!userLocation.isEmpty()) {%>
                        <p class="mb-1"><i class="fas fa-map-marker-alt"></i> <%=userLocation%></p>
                    <%}%>
                    <%if (!joinDate.isEmpty()) {%>
                        <p class="mb-0"><i class="fas fa-calendar-alt"></i> Member since <%=joinDate.substring(0, 10)%></p>
                    <%}%>
                </div>
                <div class="col-auto">
                    <div class="d-flex gap-2">
                        <a href="userUpdate.jsp" class="btn btn-light">
                            <i class="fas fa-edit"></i> Edit Profile
                        </a>
                        <a href="SellCar2.jsp" class="btn btn-warning">
                            <i class="fas fa-plus"></i> Sell Car
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <div class="container">
        <!-- Statistics Cards -->
        <div class="row mb-4" data-aos="fade-up">
            <div class="col-md-4">
                <div class="stat-card">
                    <div class="stat-number"><%=totalListings%></div>
                    <div class="stat-label">Total Listings</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card">
                    <div class="stat-number"><%=activeListings%></div>
                    <div class="stat-label">Active Listings</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card">
                    <div class="stat-number"><%=soldCars%></div>
                    <div class="stat-label">Cars Sold</div>
                </div>
            </div>
        </div>

        <!-- Profile Navigation -->
        <div class="profile-nav" data-aos="fade-up" data-aos-delay="100">
            <div class="p-3">
                <ul class="nav nav-pills justify-content-center" id="profileTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="overview-tab" data-bs-toggle="pill" data-bs-target="#overview" type="button" role="tab">
                            <i class="fas fa-chart-line"></i> Overview
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="listings-tab" data-bs-toggle="pill" data-bs-target="#listings" type="button" role="tab">
                            <i class="fas fa-car"></i> My Listings
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="activity-tab" data-bs-toggle="pill" data-bs-target="#activity" type="button" role="tab">
                            <i class="fas fa-history"></i> Recent Activity
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="settings-tab" data-bs-toggle="pill" data-bs-target="#settings" type="button" role="tab">
                            <i class="fas fa-cog"></i> Settings
                        </button>
                    </li>
                </ul>
            </div>
        </div>

        <!-- Tab Content -->
        <div class="tab-content" id="profileTabContent" data-aos="fade-up" data-aos-delay="200">
            <!-- Overview Tab -->
            <div class="tab-pane fade show active" id="overview" role="tabpanel">
                <div class="row">
                    <div class="col-lg-8">
                        <div class="info-card">
                            <h5 class="mb-4"><i class="fas fa-user"></i> Profile Information</h5>
                            <div class="info-item">
                                <div class="info-label">
                                    <i class="fas fa-user"></i> Full Name
                                </div>
                                <div class="info-value"><%=userName != null ? userName : "Not provided"%></div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">
                                    <i class="fas fa-envelope"></i> Email Address
                                </div>
                                <div class="info-value"><%=userEmail%></div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">
                                    <i class="fas fa-phone"></i> Phone Number
                                </div>
                                <div class="info-value"><%=!userPhone.isEmpty() ? userPhone : "Not provided"%></div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">
                                    <i class="fas fa-map-marker-alt"></i> Location
                                </div>
                                <div class="info-value"><%=!userLocation.isEmpty() ? userLocation : "Not provided"%></div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">
                                    <i class="fas fa-calendar-alt"></i> Member Since
                                </div>
                                <div class="info-value"><%=!joinDate.isEmpty() ? joinDate.substring(0, 10) : "Unknown"%></div>
                            </div>
                        </div>

                        <div class="info-card">
                            <h5 class="mb-4"><i class="fas fa-chart-bar"></i> Account Statistics</h5>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="text-center p-3">
                                        <h3 class="text-primary"><%=totalListings%></h3>
                                        <p class="text-muted mb-0">Total Cars Listed</p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="text-center p-3">
                                        <h3 class="text-success"><%=soldCars%></h3>
                                        <p class="text-muted mb-0">Cars Successfully Sold</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4">
                        <div class="info-card">
                            <h5 class="mb-4"><i class="fas fa-trophy"></i> Achievements</h5>
                            <%if (totalListings >= 5) {%>
                                <div class="d-flex align-items-center mb-3">
                                    <div class="badge bg-primary rounded-pill me-3" style="width: 40px; height: 40px; display: flex; align-items: center; justify-content: center;">
                                        <i class="fas fa-star"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-0">Active Seller</h6>
                                        <small class="text-muted">Listed 5+ vehicles</small>
                                    </div>
                                </div>
                            <%}%>
                            
                            <%if (soldCars >= 1) {%>
                                <div class="d-flex align-items-center mb-3">
                                    <div class="badge bg-success rounded-pill me-3" style="width: 40px; height: 40px; display: flex; align-items: center; justify-content: center;">
                                        <i class="fas fa-handshake"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-0">First Sale</h6>
                                        <small class="text-muted">Successfully sold a car</small>
                                    </div>
                                </div>
                            <%}%>
                            
                            <%if (!joinDate.isEmpty() && joinDate.substring(0, 4).equals("2024")) {%>
                                <div class="d-flex align-items-center mb-3">
                                    <div class="badge bg-info rounded-pill me-3" style="width: 40px; height: 40px; display: flex; align-items: center; justify-content: center;">
                                        <i class="fas fa-calendar-plus"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-0">New Member</h6>
                                        <small class="text-muted">Joined in 2024</small>
                                    </div>
                                </div>
                            <%}%>
                            
                            <%if (totalListings == 0) {%>
                                <div class="text-center text-muted">
                                    <i class="fas fa-medal fa-3x mb-3"></i>
                                    <p>Start selling cars to earn achievements!</p>
                                    <a href="SellCar2.jsp" class="btn btn-primary btn-sm">
                                        <i class="fas fa-plus"></i> List Your First Car
                                    </a>
                                </div>
                            <%}%>
                        </div>

                        <div class="info-card">
                            <h5 class="mb-4"><i class="fas fa-lightbulb"></i> Quick Tips</h5>
                            <ul class="list-unstyled">
                                <li class="mb-2">
                                    <i class="fas fa-check-circle text-success me-2"></i>
                                    Add high-quality photos to attract buyers
                                </li>
                                <li class="mb-2">
                                    <i class="fas fa-check-circle text-success me-2"></i>
                                    Write detailed descriptions
                                </li>
                                <li class="mb-2">
                                    <i class="fas fa-check-circle text-success me-2"></i>
                                    Price competitively
                                </li>
                                <li class="mb-2">
                                    <i class="fas fa-check-circle text-success me-2"></i>
                                    Respond quickly to inquiries
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Listings Tab -->
            <div class="tab-pane fade" id="listings" role="tabpanel">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h5><i class="fas fa-car"></i> My Car Listings</h5>
                    <a href="SellCar2.jsp" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Add New Listing
                    </a>
                </div>

                <%
                    // Get user's car listings
                    try {
                        conn = DataSource.getConnection();
                        String listingsQuery = "SELECT * FROM car_listings WHERE seller_email = ? ORDER BY created_date DESC LIMIT 10";
                        pstmt = conn.prepareStatement(listingsQuery);
                        pstmt.setString(1, userEmail);
                        rs = pstmt.executeQuery();
                        
                        boolean hasListings = false;
                        while (rs.next()) {
                            hasListings = true;
                            String carTitle = rs.getString("title");
                            String carPrice = rs.getString("price");
                            String carStatus = rs.getString("status");
                            String carImage = rs.getString("image_url");
                            String createdDate = rs.getString("created_date");
                %>
                            <div class="car-card">
                                <div class="row g-0">
                                    <div class="col-md-4 position-relative">
                                        <img src="<%=carImage != null ? carImage : "images/default-car.jpg"%>" 
                                             alt="<%=carTitle%>" class="car-image">
                                        <span class="car-status status-<%=carStatus%>"><%=carStatus.toUpperCase()%></span>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="card-body">
                                            <h5 class="card-title"><%=carTitle%></h5>
                                            <p class="card-text">
                                                <strong class="text-primary fs-4">$<%=carPrice%></strong>
                                            </p>
                                            <p class="card-text">
                                                <small class="text-muted">
                                                    <i class="fas fa-calendar"></i> Listed on <%=createdDate.substring(0, 10)%>
                                                </small>
                                            </p>
                                            <div class="d-flex gap-2">
                                                <a href="car-details.jsp?id=<%=rs.getInt("id")%>" class="btn btn-outline-primary btn-sm">
                                                    <i class="fas fa-eye"></i> View Details
                                                </a>
                                                <a href="editListing.jsp?id=<%=rs.getInt("id")%>" class="btn btn-primary btn-sm">
                                                    <i class="fas fa-edit"></i> Edit
                                                </a>
                                                <%if ("active".equals(carStatus)) {%>
                                                    <button class="btn btn-warning btn-sm" 
                                                            data-car-id="<%=rs.getInt("id")%>" 
                                                            onclick="markAsSold(this.getAttribute('data-car-id'))">
                                                        <i class="fas fa-check"></i> Mark as Sold
                                                    </button>
                                                <%}%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                <%
                        }
                        
                        if (!hasListings) {
                %>
                            <div class="text-center py-5">
                                <i class="fas fa-car fa-4x text-muted mb-4"></i>
                                <h4 class="text-muted">No listings yet</h4>
                                <p class="text-muted mb-4">Start selling your car today and reach thousands of potential buyers!</p>
                                <a href="SellCar2.jsp" class="btn btn-primary btn-lg">
                                    <i class="fas fa-plus"></i> Create Your First Listing
                                </a>
                            </div>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) try { rs.close(); } catch (Exception e) {}
                        if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
                        if (conn != null) try { conn.close(); } catch (Exception e) {}
                    }
                %>
            </div>

            <!-- Activity Tab -->
            <div class="tab-pane fade" id="activity" role="tabpanel">
                <h5 class="mb-4"><i class="fas fa-history"></i> Recent Activity</h5>
                
                <div class="info-card">
                    <div class="timeline">
                        <%
                            // Get recent activity
                            try {
                                conn = DataSource.getConnection();
                                String activityQuery = "SELECT 'listing' as type, title, created_date FROM car_listings WHERE seller_email = ? " +
                                                     "UNION ALL " +
                                                     "SELECT 'update' as type, 'Profile Updated' as title, updated_date as created_date FROM users WHERE email = ? " +
                                                     "ORDER BY created_date DESC LIMIT 10";
                                pstmt = conn.prepareStatement(activityQuery);
                                pstmt.setString(1, userEmail);
                                pstmt.setString(2, userEmail);
                                rs = pstmt.executeQuery();
                                
                                boolean hasActivity = false;
                                while (rs.next()) {
                                    hasActivity = true;
                                    String activityType = rs.getString("type");
                                    String activityTitle = rs.getString("title");
                                    String activityDate = rs.getString("created_date");
                        %>
                                    <div class="timeline-item d-flex align-items-center mb-3">
                                        <div class="timeline-marker me-3">
                                            <%if ("listing".equals(activityType)) {%>
                                                <i class="fas fa-car text-primary"></i>
                                            <%} else {%>
                                                <i class="fas fa-user-edit text-success"></i>
                                            <%}%>
                                        </div>
                                        <div class="flex-grow-1">
                                            <h6 class="mb-1"><%=activityTitle%></h6>
                                            <small class="text-muted"><%=activityDate.substring(0, 16)%></small>
                                        </div>
                                    </div>
                        <%
                                }
                                
                                if (!hasActivity) {
                        %>
                                    <div class="text-center py-4">
                                        <i class="fas fa-clock fa-3x text-muted mb-3"></i>
                                        <h5 class="text-muted">No recent activity</h5>
                                        <p class="text-muted">Your recent actions will appear here.</p>
                                    </div>
                        <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                if (rs != null) try { rs.close(); } catch (Exception e) {}
                                if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
                                if (conn != null) try { conn.close(); } catch (Exception e) {}
                            }
                        %>
                    </div>
                </div>
            </div>

            <!-- Settings Tab -->
            <div class="tab-pane fade" id="settings" role="tabpanel">
                <h5 class="mb-4"><i class="fas fa-cog"></i> Account Settings</h5>
                
                <div class="row">
                    <div class="col-lg-8">
                        <div class="info-card">
                            <h6 class="mb-3"><i class="fas fa-user-cog"></i> Profile Management</h6>
                            <div class="d-grid gap-2">
                                <a href="userUpdate.jsp" class="btn btn-outline-primary text-start">
                                    <i class="fas fa-edit me-2"></i> Edit Profile Information
                                </a>
                                <a href="ChangePass.jsp" class="btn btn-outline-primary text-start">
                                    <i class="fas fa-key me-2"></i> Change Password
                                </a>
                                <a href="#" class="btn btn-outline-primary text-start" onclick="uploadAvatar()">
                                    <i class="fas fa-camera me-2"></i> Change Profile Picture
                                </a>
                            </div>
                        </div>

                        <div class="info-card">
                            <h6 class="mb-3"><i class="fas fa-bell"></i> Notification Preferences</h6>
                            <div class="form-check form-switch mb-3">
                                <input class="form-check-input" type="checkbox" id="emailNotifications" checked>
                                <label class="form-check-label" for="emailNotifications">
                                    Email notifications for new inquiries
                                </label>
                            </div>
                            <div class="form-check form-switch mb-3">
                                <input class="form-check-input" type="checkbox" id="smsNotifications">
                                <label class="form-check-label" for="smsNotifications">
                                    SMS notifications for urgent messages
                                </label>
                            </div>
                            <div class="form-check form-switch mb-3">
                                <input class="form-check-input" type="checkbox" id="marketingEmails">
                                <label class="form-check-label" for="marketingEmails">
                                    Marketing emails and promotions
                                </label>
                            </div>
                            <button class="btn btn-primary" onclick="saveNotificationSettings()">
                                <i class="fas fa-save"></i> Save Preferences
                            </button>
                        </div>
                    </div>

                    <div class="col-lg-4">
                        <div class="info-card">
                            <h6 class="mb-3 text-danger"><i class="fas fa-exclamation-triangle"></i> Account Actions</h6>
                            <div class="d-grid gap-2">
                                <button class="btn btn-outline-warning" onclick="downloadData()">
                                    <i class="fas fa-download me-2"></i> Download My Data
                                </button>
                                <button class="btn btn-outline-danger" onclick="confirmDeleteAccount()">
                                    <i class="fas fa-user-times me-2"></i> Delete Account
                                </button>
                            </div>
                            
                            <div class="alert alert-warning mt-3">
                                <small>
                                    <i class="fas fa-info-circle me-1"></i>
                                    Account deletion is permanent and cannot be undone.
                                </small>
                            </div>
                        </div>

                        <div class="info-card">
                            <h6 class="mb-3"><i class="fas fa-shield-alt"></i> Privacy & Security</h6>
                            <p class="small text-muted mb-3">
                                Your data is protected with industry-standard encryption. 
                                Review our privacy policy for more details.
                            </p>
                            <a href="#" class="btn btn-outline-secondary btn-sm">
                                <i class="fas fa-file-alt"></i> Privacy Policy
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-light py-5 mt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <h5><i class="fas fa-car"></i> CarDeal</h5>
                    <p class="text-muted">Your trusted automotive marketplace for buying and selling cars.</p>
                </div>
                <div class="col-md-4">
                    <h6>Quick Links</h6>
                    <ul class="list-unstyled">
                        <li><a href="about-us.jsp" class="text-light">About Us</a></li>
                        <li><a href="contact.jsp" class="text-light">Contact</a></li>
                        <li><a href="#" class="text-light">Privacy Policy</a></li>
                        <li><a href="#" class="text-light">Terms of Service</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h6>Contact Info</h6>
                    <p class="text-muted mb-1"><i class="fas fa-phone"></i> +1 (555) 123-4567</p>
                    <p class="text-muted mb-1"><i class="fas fa-envelope"></i> support@cardeal.com</p>
                    <p class="text-muted"><i class="fas fa-map-marker-alt"></i> 123 Auto Street, Car City</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
    
    <script>
        // Initialize AOS
        AOS.init({
            duration: 600,
            easing: 'ease-in-out',
            once: true
        });

        // Mark car as sold
        function markAsSold(carId) {
            if (confirm('Are you sure you want to mark this car as sold?')) {
                // Implementation for marking car as sold
                fetch('updateListingStatus.jsp', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'carId=' + carId + '&status=sold'
                })
                .then(response => response.text())
                .then(data => {
                    if (data.includes('success')) {
                        location.reload();
                    } else {
                        alert('Error updating status. Please try again.');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Error updating status. Please try again.');
                });
            }
        }

        // Upload avatar
        function uploadAvatar() {
            const input = document.createElement('input');
            input.type = 'file';
            input.accept = 'image/*';
            input.onchange = function(e) {
                const file = e.target.files[0];
                if (file) {
                    // Implementation for uploading avatar
                    const formData = new FormData();
                    formData.append('avatar', file);
                    
                    fetch('uploadAvatar.jsp', {
                        method: 'POST',
                        body: formData
                    })
                    .then(response => response.text())
                    .then(data => {
                        if (data.includes('success')) {
                            location.reload();
                        } else {
                            alert('Error uploading image. Please try again.');
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('Error uploading image. Please try again.');
                    });
                }
            };
            input.click();
        }

        // Save notification settings
        function saveNotificationSettings() {
            const emailNotifications = document.getElementById('emailNotifications').checked;
            const smsNotifications = document.getElementById('smsNotifications').checked;
            const marketingEmails = document.getElementById('marketingEmails').checked;
            
            fetch('updateNotificationSettings.jsp', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: `emailNotifications=${emailNotifications}&smsNotifications=${smsNotifications}&marketingEmails=${marketingEmails}`
            })
            .then(response => response.text())
            .then(data => {
                if (data.includes('success')) {
                    const alert = document.createElement('div');
                    alert.className = 'alert alert-success alert-dismissible fade show';
                    alert.innerHTML = `
                        <i class="fas fa-check-circle"></i> Notification settings saved successfully!
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    `;
                    document.querySelector('#settings .info-card').prepend(alert);
                } else {
                    alert('Error saving settings. Please try again.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Error saving settings. Please try again.');
            });
        }

        // Download data
        function downloadData() {
            if (confirm('This will download all your account data. Continue?')) {
                window.location.href = 'downloadUserData.jsp';
            }
        }

        // Confirm delete account
        function confirmDeleteAccount() {
            const confirmed = confirm('Are you sure you want to delete your account? This action cannot be undone.');
            if (confirmed) {
                const password = prompt('Please enter your password to confirm account deletion:');
                if (password) {
                    fetch('deleteAccount.jsp', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: 'password=' + encodeURIComponent(password)
                    })
                    .then(response => response.text())
                    .then(data => {
                        if (data.includes('success')) {
                            alert('Account deleted successfully. You will be redirected to the homepage.');
                            window.location.href = 'index.jsp';
                        } else {
                            alert('Error deleting account. Please check your password and try again.');
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('Error deleting account. Please try again.');
                    });
                }
            }
        }

        // Auto-hide alerts
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert-dismissible');
            alerts.forEach(alert => {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
    </script>
</body>
</html>
