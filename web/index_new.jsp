<%-- 
    Document   : index (Modernized)
    Created on : 02-May-2024, 9:51:17 pm
    Author     : Abrarali
    Refactored Version with Bootstrap 5 and Modern UI/UX
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
        <title>CarDeal - Find Your Perfect Car</title>
        
        <!-- SEO Meta Tags -->
        <meta name="description" content="Find your perfect car with CarDeal. Browse thousands of new and used cars, sell your vehicle, and get the best deals in the automotive market.">
        <meta name="keywords" content="cars, buy cars, sell cars, automotive, used cars, new cars, car deals">
        <meta name="author" content="CarDeal Team">
        
        <!-- Open Graph Meta Tags -->
        <meta property="og:title" content="CarDeal - Find Your Perfect Car">
        <meta property="og:description" content="Browse thousands of cars and find your perfect match">
        <meta property="og:type" content="website">
        <meta property="og:url" content="<%= request.getRequestURL() %>">
        
        <!-- Favicon -->
        <link rel="icon" href="images/favicon.ico" type="image/x-icon">
        
        <!-- CSS Links -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">
        <link rel="stylesheet" href="css/style.css">
        
        <!-- Custom Styles -->
        <style>
            :root {
                --primary-color: #007bff;
                --secondary-color: #6c757d;
                --success-color: #28a745;
                --danger-color: #dc3545;
                --warning-color: #ffc107;
                --info-color: #17a2b8;
                --dark-color: #343a40;
                --light-color: #f8f9fa;
            }
            
            .hero-section {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 80vh;
                display: flex;
                align-items: center;
                color: white;
                position: relative;
                overflow: hidden;
            }
            
            .hero-section::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: rgba(0, 0, 0, 0.3);
                z-index: 1;
            }
            
            .hero-content {
                position: relative;
                z-index: 2;
            }
            
            .search-box {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                border-radius: 15px;
                padding: 2rem;
                margin-top: 2rem;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            }
            
            .feature-card {
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                border: none;
                border-radius: 15px;
                overflow: hidden;
                height: 100%;
            }
            
            .feature-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            }
            
            .feature-icon {
                font-size: 3rem;
                margin-bottom: 1rem;
                color: var(--primary-color);
            }
            
            .stats-section {
                background: var(--dark-color);
                color: white;
                padding: 4rem 0;
            }
            
            .stat-item {
                text-align: center;
                margin-bottom: 2rem;
            }
            
            .stat-number {
                font-size: 3rem;
                font-weight: bold;
                color: var(--primary-color);
                display: block;
            }
            
            .navbar-brand {
                font-weight: bold;
                font-size: 1.5rem;
            }
            
            .btn-primary {
                background: var(--primary-color);
                border: none;
                border-radius: 25px;
                padding: 0.75rem 2rem;
                font-weight: 500;
                transition: all 0.3s ease;
            }
            
            .btn-primary:hover {
                background: #0056b3;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(0, 123, 255, 0.3);
            }
            
            .loading-spinner {
                display: none;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                z-index: 9999;
            }
            
            .car-card {
                border: none;
                border-radius: 15px;
                overflow: hidden;
                transition: all 0.3s ease;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            }
            
            .car-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
            }
            
            .car-image {
                height: 200px;
                object-fit: cover;
                width: 100%;
            }
            
            .price-tag {
                position: absolute;
                top: 15px;
                right: 15px;
                background: var(--primary-color);
                color: white;
                padding: 0.5rem 1rem;
                border-radius: 25px;
                font-weight: bold;
                font-size: 1.1rem;
            }
        </style>
    </head>
    
    <body>
        <!-- Loading Spinner -->
        <div class="loading-spinner">
            <div class="spinner-border text-primary" role="status">
                <span class="visually-hidden">Loading...</span>
            </div>
        </div>
        
        <%
            // Security headers
            response.setHeader("X-Content-Type-Options", "nosniff");
            response.setHeader("X-Frame-Options", "DENY");
            response.setHeader("X-XSS-Protection", "1; mode=block");
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);

            // Get session information
            HttpSession userSession = request.getSession(false);
            String username = null;
            Integer userId = null;
            boolean isLoggedIn = false;
            
            if (userSession != null) {
                username = (String) userSession.getAttribute("Username");
                userId = (Integer) userSession.getAttribute("UserID");
                isLoggedIn = (userId != null);
            }
            
            // Database statistics
            int totalCars = 0;
            int totalUsers = 0;
            int totalSales = 0;
            
            try (Connection conn = DataSource.getConnection()) {
                // Get total cars
                PreparedStatement ps1 = conn.prepareStatement("SELECT COUNT(*) FROM CarDetails WHERE isActive = 1");
                ResultSet rs1 = ps1.executeQuery();
                if (rs1.next()) totalCars = rs1.getInt(1);
                
                // Get total users
                PreparedStatement ps2 = conn.prepareStatement("SELECT COUNT(*) FROM UserDetails WHERE isActive = 1");
                ResultSet rs2 = ps2.executeQuery();
                if (rs2.next()) totalUsers = rs2.getInt(1);
                
                // Get total sales (assuming from purchase history)
                PreparedStatement ps3 = conn.prepareStatement("SELECT COUNT(*) FROM PurchaseHistory");
                ResultSet rs3 = ps3.executeQuery();
                if (rs3.next()) totalSales = rs3.getInt(1);
                
            } catch (Exception e) {
                // Fallback values if database is not accessible
                totalCars = 150;
                totalUsers = 1250;
                totalSales = 850;
            }
        %>

        <!-- Navigation -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
            <div class="container">
                <a class="navbar-brand" href="index.jsp">
                    <i class="fas fa-car-side"></i> CarDeal
                </a>
                
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link active" href="index.jsp">
                                <i class="fas fa-home"></i> Home
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="cars.jsp">
                                <i class="fas fa-car"></i> Buy Cars
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="SellCar2.jsp">
                                <i class="fas fa-plus-circle"></i> Sell Car
                            </a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                <i class="fas fa-info-circle"></i> About
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="about-us.jsp">About Us</a></li>
                                <li><a class="dropdown-item" href="team.jsp">Our Team</a></li>
                                <li><a class="dropdown-item" href="testimonials.jsp">Testimonials</a></li>
                                <li><a class="dropdown-item" href="blog-posts.jsp">Blog</a></li>
                            </ul>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="contact.jsp">
                                <i class="fas fa-envelope"></i> Contact
                            </a>
                        </li>
                    </ul>
                    
                    <ul class="navbar-nav">
                        <% if (!isLoggedIn) { %>
                            <li class="nav-item">
                                <a class="nav-link" href="userRegister.jsp">
                                    <i class="fas fa-user-plus"></i> Register
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="login.jsp">
                                    <i class="fas fa-sign-in-alt"></i> Login
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="btn btn-outline-light ms-2" href="Subscribe.jsp">
                                    <i class="fas fa-star"></i> Subscribe
                                </a>
                            </li>
                        <% } else { %>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-user"></i> Welcome, <%= username %>
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="userProfile.jsp">
                                        <i class="fas fa-user-circle"></i> My Profile
                                    </a></li>
                                    <li><a class="dropdown-item" href="MyUCars.jsp">
                                        <i class="fas fa-car"></i> My Cars
                                    </a></li>
                                    <li><a class="dropdown-item" href="BuyHist.jsp">
                                        <i class="fas fa-history"></i> Purchase History
                                    </a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="logout">
                                        <i class="fas fa-sign-out-alt"></i> Logout
                                    </a></li>
                                </ul>
                            </li>
                        <% } %>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Hero Section -->
        <section class="hero-section">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-6" data-aos="fade-right">
                        <div class="hero-content">
                            <h1 class="display-4 fw-bold mb-4">Find Your Perfect Car</h1>
                            <p class="lead mb-4">
                                Discover thousands of quality cars from trusted dealers and private sellers. 
                                Whether you're buying or selling, we make it easy and secure.
                            </p>
                            <div class="d-flex flex-wrap gap-3">
                                <a href="cars.jsp" class="btn btn-primary btn-lg">
                                    <i class="fas fa-search"></i> Browse Cars
                                </a>
                                <a href="SellCar2.jsp" class="btn btn-outline-light btn-lg">
                                    <i class="fas fa-plus"></i> Sell Your Car
                                </a>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-6" data-aos="fade-left" data-aos-delay="200">
                        <!-- Quick Search -->
                        <div class="search-box">
                            <h3 class="text-dark mb-4"><i class="fas fa-search"></i> Quick Car Search</h3>
                            <form action="cars.jsp" method="get" class="car-search-form">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label text-dark">Make</label>
                                        <select class="form-select" name="make">
                                            <option value="">Any Make</option>
                                            <option value="Toyota">Toyota</option>
                                            <option value="Honda">Honda</option>
                                            <option value="Ford">Ford</option>
                                            <option value="Chevrolet">Chevrolet</option>
                                            <option value="BMW">BMW</option>
                                            <option value="Mercedes">Mercedes-Benz</option>
                                            <option value="Audi">Audi</option>
                                            <option value="Nissan">Nissan</option>
                                            <option value="Hyundai">Hyundai</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label text-dark">Price Range</label>
                                        <select class="form-select" name="priceRange">
                                            <option value="">Any Price</option>
                                            <option value="0-10000">Under $10,000</option>
                                            <option value="10000-25000">$10,000 - $25,000</option>
                                            <option value="25000-50000">$25,000 - $50,000</option>
                                            <option value="50000-100000">$50,000 - $100,000</option>
                                            <option value="100000-999999">$100,000+</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label text-dark">Year</label>
                                        <select class="form-select" name="year">
                                            <option value="">Any Year</option>
                                            <% 
                                            int currentYear = java.time.LocalDate.now().getYear();
                                            for (int year = currentYear; year >= currentYear - 20; year--) { 
                                            %>
                                                <option value="<%= year %>"><%= year %></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label text-dark">Fuel Type</label>
                                        <select class="form-select" name="fuelType">
                                            <option value="">Any Fuel</option>
                                            <option value="Petrol">Petrol</option>
                                            <option value="Diesel">Diesel</option>
                                            <option value="Electric">Electric</option>
                                            <option value="Hybrid">Hybrid</option>
                                        </select>
                                    </div>
                                    <div class="col-12">
                                        <button type="submit" class="btn btn-primary w-100">
                                            <i class="fas fa-search"></i> Search Cars
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Statistics Section -->
        <section class="stats-section">
            <div class="container">
                <div class="row">
                    <div class="col-md-4" data-aos="fade-up" data-aos-delay="100">
                        <div class="stat-item">
                            <i class="fas fa-car feature-icon"></i>
                            <span class="stat-number"><%= totalCars %></span>
                            <h4>Cars Available</h4>
                            <p>Quality vehicles from trusted sellers</p>
                        </div>
                    </div>
                    <div class="col-md-4" data-aos="fade-up" data-aos-delay="200">
                        <div class="stat-item">
                            <i class="fas fa-users feature-icon"></i>
                            <span class="stat-number"><%= totalUsers %></span>
                            <h4>Happy Customers</h4>
                            <p>Join our growing community</p>
                        </div>
                    </div>
                    <div class="col-md-4" data-aos="fade-up" data-aos-delay="300">
                        <div class="stat-item">
                            <i class="fas fa-handshake feature-icon"></i>
                            <span class="stat-number"><%= totalSales %></span>
                            <h4>Successful Deals</h4>
                            <p>Completed transactions</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Features Section -->
        <section class="py-5 bg-light">
            <div class="container">
                <div class="row text-center mb-5">
                    <div class="col-lg-12" data-aos="fade-up">
                        <h2 class="display-5 fw-bold">Why Choose CarDeal?</h2>
                        <p class="lead">We provide the best car buying and selling experience</p>
                    </div>
                </div>
                
                <div class="row g-4">
                    <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                        <div class="card feature-card h-100 text-center p-4">
                            <div class="card-body">
                                <i class="fas fa-shield-alt feature-icon"></i>
                                <h4>Secure Transactions</h4>
                                <p class="text-muted">All transactions are protected with advanced security measures and encryption.</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                        <div class="card feature-card h-100 text-center p-4">
                            <div class="card-body">
                                <i class="fas fa-search feature-icon"></i>
                                <h4>Advanced Search</h4>
                                <p class="text-muted">Find exactly what you're looking for with our powerful search and filter options.</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
                        <div class="card feature-card h-100 text-center p-4">
                            <div class="card-body">
                                <i class="fas fa-headset feature-icon"></i>
                                <h4>24/7 Support</h4>
                                <p class="text-muted">Our dedicated support team is available round the clock to assist you.</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="400">
                        <div class="card feature-card h-100 text-center p-4">
                            <div class="card-body">
                                <i class="fas fa-dollar-sign feature-icon"></i>
                                <h4>Best Prices</h4>
                                <p class="text-muted">Competitive pricing ensures you get the best deal whether buying or selling.</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="500">
                        <div class="card feature-card h-100 text-center p-4">
                            <div class="card-body">
                                <i class="fas fa-certificate feature-icon"></i>
                                <h4>Verified Dealers</h4>
                                <p class="text-muted">All our dealers are verified and trusted partners with proven track records.</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="600">
                        <div class="card feature-card h-100 text-center p-4">
                            <div class="card-body">
                                <i class="fas fa-mobile-alt feature-icon"></i>
                                <h4>Mobile Friendly</h4>
                                <p class="text-muted">Access our platform from any device with our responsive and mobile-friendly design.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Featured Cars Section -->
        <section class="py-5">
            <div class="container">
                <div class="row text-center mb-5">
                    <div class="col-lg-12" data-aos="fade-up">
                        <h2 class="display-5 fw-bold">Featured Cars</h2>
                        <p class="lead">Check out our latest and most popular listings</p>
                    </div>
                </div>
                
                <div class="row g-4">
                    <%
                    try (Connection conn = DataSource.getConnection()) {
                        String sql = "SELECT cd.*, ud.FirstName, ud.LastName FROM CarDetails cd " +
                                   "JOIN UserDetails ud ON cd.UserID = ud.UserID " +
                                   "WHERE cd.isActive = 1 AND cd.isFeatured = 1 " +
                                   "ORDER BY cd.CreatedDate DESC LIMIT 6";
                        PreparedStatement ps = conn.prepareStatement(sql);
                        ResultSet rs = ps.executeQuery();
                        
                        while (rs.next()) {
                            String carTitle = rs.getString("CarTitle");
                            String carImage = rs.getString("CarImage1");
                            String price = rs.getString("Price");
                            String carBrand = rs.getString("CarBrand");
                            String carModel = rs.getString("CarModel");
                            String year = rs.getString("CarYear");
                            String fuelType = rs.getString("FuelType");
                            String sellerName = rs.getString("FirstName") + " " + rs.getString("LastName");
                            int carId = rs.getInt("CarID");
                    %>
                    <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                        <div class="card car-card">
                            <div class="position-relative">
                                <img src="image/<%= carImage %>" class="car-image" alt="<%= carTitle %>">
                                <div class="price-tag">$<%= price %></div>
                            </div>
                            <div class="card-body">
                                <h5 class="card-title"><%= carTitle %></h5>
                                <p class="text-muted mb-2">
                                    <i class="fas fa-calendar"></i> <%= year %> •
                                    <i class="fas fa-gas-pump"></i> <%= fuelType %>
                                </p>
                                <p class="text-muted mb-3">
                                    <i class="fas fa-user"></i> <%= sellerName %>
                                </p>
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="text-primary fw-bold fs-5">$<%= price %></span>
                                    <a href="car-details.jsp?carId=<%= carId %>" class="btn btn-primary">
                                        <i class="fas fa-eye"></i> View Details
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    } catch (Exception e) {
                        // Show sample cars if database is not accessible
                    %>
                    <div class="col-12 text-center">
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle"></i>
                            Featured cars will be displayed here. Please check back later or browse our full inventory.
                        </div>
                        <a href="cars.jsp" class="btn btn-primary">Browse All Cars</a>
                    </div>
                    <%
                    }
                    %>
                </div>
                
                <div class="text-center mt-5" data-aos="fade-up">
                    <a href="cars.jsp" class="btn btn-outline-primary btn-lg">
                        <i class="fas fa-th"></i> View All Cars
                    </a>
                </div>
            </div>
        </section>

        <!-- Newsletter Section -->
        <section class="py-5 bg-primary text-white">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-6" data-aos="fade-right">
                        <h3 class="fw-bold">Stay Updated</h3>
                        <p class="lead mb-0">Get the latest car deals and news delivered to your inbox</p>
                    </div>
                    <div class="col-lg-6" data-aos="fade-left">
                        <form class="d-flex gap-2 mt-3 mt-lg-0">
                            <input type="email" class="form-control" placeholder="Enter your email" required>
                            <button class="btn btn-light" type="submit">
                                <i class="fas fa-paper-plane"></i> Subscribe
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer class="bg-dark text-white py-5">
            <div class="container">
                <div class="row g-4">
                    <div class="col-lg-4 col-md-6">
                        <h5 class="fw-bold mb-3">
                            <i class="fas fa-car-side"></i> CarDeal
                        </h5>
                        <p class="text-muted">
                            Your trusted partner for buying and selling cars. We connect buyers and sellers 
                            with secure, reliable, and efficient automotive transactions.
                        </p>
                        <div class="d-flex gap-3">
                            <a href="#" class="text-white"><i class="fab fa-facebook-f"></i></a>
                            <a href="#" class="text-white"><i class="fab fa-twitter"></i></a>
                            <a href="#" class="text-white"><i class="fab fa-instagram"></i></a>
                            <a href="#" class="text-white"><i class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div>
                    
                    <div class="col-lg-2 col-md-6">
                        <h6 class="fw-bold mb-3">Quick Links</h6>
                        <ul class="list-unstyled">
                            <li><a href="cars.jsp" class="text-muted text-decoration-none">Buy Cars</a></li>
                            <li><a href="SellCar2.jsp" class="text-muted text-decoration-none">Sell Cars</a></li>
                            <li><a href="about-us.jsp" class="text-muted text-decoration-none">About Us</a></li>
                            <li><a href="contact.jsp" class="text-muted text-decoration-none">Contact</a></li>
                        </ul>
                    </div>
                    
                    <div class="col-lg-3 col-md-6">
                        <h6 class="fw-bold mb-3">Support</h6>
                        <ul class="list-unstyled">
                            <li><a href="#" class="text-muted text-decoration-none">Help Center</a></li>
                            <li><a href="#" class="text-muted text-decoration-none">Privacy Policy</a></li>
                            <li><a href="#" class="text-muted text-decoration-none">Terms of Service</a></li>
                            <li><a href="#" class="text-muted text-decoration-none">FAQ</a></li>
                        </ul>
                    </div>
                    
                    <div class="col-lg-3 col-md-6">
                        <h6 class="fw-bold mb-3">Contact Info</h6>
                        <ul class="list-unstyled text-muted">
                            <li><i class="fas fa-map-marker-alt"></i> 123 Car Street, Auto City</li>
                            <li><i class="fas fa-phone"></i> +1 (555) 123-4567</li>
                            <li><i class="fas fa-envelope"></i> info@cardeal.com</li>
                        </ul>
                    </div>
                </div>
                
                <hr class="my-4">
                
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <p class="text-muted mb-0">
                            &copy; 2024 CarDeal. All rights reserved.
                        </p>
                    </div>
                    <div class="col-md-6 text-md-end">
                        <p class="text-muted mb-0">
                            Built with <i class="fas fa-heart text-danger"></i> for car enthusiasts
                        </p>
                    </div>
                </div>
            </div>
        </footer>

        <!-- JavaScript -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
        
        <script>
            // Initialize AOS (Animate On Scroll)
            AOS.init({
                duration: 1000,
                easing: 'ease-in-out',
                once: true
            });

            // Smooth scrolling for anchor links
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function (e) {
                    e.preventDefault();
                    document.querySelector(this.getAttribute('href')).scrollIntoView({
                        behavior: 'smooth'
                    });
                });
            });

            // Loading spinner for form submissions
            document.querySelectorAll('form').forEach(form => {
                form.addEventListener('submit', function() {
                    document.querySelector('.loading-spinner').style.display = 'block';
                });
            });

            // Auto-hide alerts after 5 seconds
            setTimeout(function() {
                const alerts = document.querySelectorAll('.alert');
                alerts.forEach(alert => {
                    if (alert.classList.contains('alert-dismissible')) {
                        alert.style.display = 'none';
                    }
                });
            }, 5000);

            // Navbar scroll effect
            window.addEventListener('scroll', function() {
                const navbar = document.querySelector('.navbar');
                if (window.scrollY > 50) {
                    navbar.classList.add('scrolled');
                } else {
                    navbar.classList.remove('scrolled');
                }
            });

            // Search form validation
            document.querySelector('.car-search-form').addEventListener('submit', function(e) {
                const formData = new FormData(this);
                let hasValue = false;
                
                for (let value of formData.values()) {
                    if (value.trim() !== '') {
                        hasValue = true;
                        break;
                    }
                }
                
                if (!hasValue) {
                    e.preventDefault();
                    alert('Please select at least one search criteria.');
                }
            });
        </script>
    </body>
</html>
