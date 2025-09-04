<%-- 
    Document   : SellCar2 (Modernized)
    Created on : 05-May-2024, 8:04:14 pm
    Author     : Abrarali
    Refactored Version with Bootstrap 5 and Multi-Step Form
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
    <title>Sell Your Car - CarDeal</title>
    
    <!-- SEO Meta Tags -->
    <meta name="description" content="Sell your car easily with CarDeal. Create a detailed listing and reach thousands of potential buyers.">
    <meta name="keywords" content="sell car, car    , automotive marketplace, sell vehicle">
    <meta name="author" content="CarDeal Team">
    
    <!-- Favicon -->
    <link rel="icon" href="images/favicon.ico" type="image/x-icon">
    
    <!-- CSS Links -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/dropzone@5.9.3/dist/min/dropzone.min.css" rel="stylesheet">
    
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
        
        body {
            background-color: #f8f9fa;
            padding-top: 76px;
        }
        
        .page-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 4rem 0 2rem;
            margin-bottom: 2rem;
        }
        
        .sell-form-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            margin-bottom: 3rem;
        }
        
        .form-step {
            padding: 3rem;
            display: none;
        }
        
        .form-step.active {
            display: block;
        }
        
        .form-step h4 {
            color: var(--dark-color);
            margin-bottom: 2rem;
        }
        
        .step-indicator {
            background: var(--light-color);
            padding: 2rem;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }
        
        .step {
            display: flex;
            align-items: center;
            position: relative;
        }
        
        .step-number {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: #e9ecef;
            color: var(--secondary-color);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 1.2rem;
            transition: all 0.3s ease;
        }
        
        .step.active .step-number {
            background: var(--primary-color);
            color: white;
        }
        
        .step.completed .step-number {
            background: var(--success-color);
            color: white;
        }
        
        .step-label {
            margin-left: 1rem;
            font-weight: 500;
            color: var(--secondary-color);
        }
        
        .step.active .step-label {
            color: var(--primary-color);
        }
        
        .step.completed .step-label {
            color: var(--success-color);
        }
        
        .step-connector {
            width: 60px;
            height: 2px;
            background: #e9ecef;
            margin: 0 1rem;
        }
        
        .step.completed + .step .step-connector {
            background: var(--success-color);
        }
        
        .form-control, .form-select {
            border-radius: 10px;
            border: 2px solid #e9ecef;
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
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
            background: #0056b3;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 123, 255, 0.3);
        }
        
        .image-preview {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-top: 1rem;
        }
        
        .image-preview-item {
            position: relative;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .image-preview-item img {
            width: 100%;
            height: 150px;
            object-fit: cover;
        }
        
        .image-remove {
            position: absolute;
            top: 10px;
            right: 10px;
            background: var(--danger-color);
            color: white;
            border: none;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .image-remove:hover {
            background: #c82333;
            transform: scale(1.1);
        }
        
        .dropzone {
            border: 2px dashed var(--primary-color);
            border-radius: 10px;
            padding: 2rem;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            background: #f8f9ff;
        }
        
        .dropzone:hover {
            background: #e7f3ff;
            border-color: #0056b3;
        }
        
        .dropzone.dragover {
            background: #e7f3ff;
            border-color: #0056b3;
            transform: scale(1.02);
        }
        
        .feature-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1rem;
            margin-top: 2rem;
        }
        
        .feature-card {
            background: var(--light-color);
            padding: 1.5rem;
            border-radius: 10px;
            text-align: center;
            transition: all 0.3s ease;
        }
        
        .feature-card:hover {
            background: white;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .feature-icon {
            font-size: 2.5rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }
        
        .progress-bar-container {
            background: #e9ecef;
            border-radius: 10px;
            height: 8px;
            margin: 2rem 0;
            overflow: hidden;
        }
        
        .progress-bar-fill {
            background: linear-gradient(90deg, var(--primary-color), var(--success-color));
            height: 100%;
            transition: width 0.5s ease;
            border-radius: 10px;
        }
        
        .price-suggestion {
            background: var(--info-color);
            color: white;
            padding: 1rem;
            border-radius: 10px;
            margin-top: 1rem;
        }
        
        .char-counter {
            font-size: 0.9rem;
            color: var(--secondary-color);
            text-align: right;
            margin-top: 0.5rem;
        }
        
        @media (max-width: 768px) {
            .form-step {
                padding: 2rem;
            }
            
            .step-indicator {
                padding: 1rem;
            }
            
            .step-connector {
                display: none;
            }
            
            .step {
                margin-bottom: 1rem;
            }
        }
    </style>
</head>

<body>
    <%
        // Security headers
        response.setHeader("X-Content-Type-Options", "nosniff");
        response.setHeader("X-Frame-Options", "DENY");
        response.setHeader("X-XSS-Protection", "1; mode=block");
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        // Check if user is logged in
        HttpSession userSession = request.getSession(false);
        String username = null;
        Integer userId = null;
        boolean isLoggedIn = false;
        
        if (userSession != null) {
            username = (String) userSession.getAttribute("Username");
            userId = (Integer) userSession.getAttribute("UserID");
            isLoggedIn = (userId != null);
        }
        
        // Redirect to login if not authenticated
        if (!isLoggedIn) {
            response.sendRedirect("login.jsp?error=Please login to sell your car");
            return;
        }

        // Get error and success messages
        String errorMessage = request.getParameter("error");
        String successMessage = request.getParameter("success");
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
                        <a class="nav-link" href="index.jsp">
                            <i class="fas fa-home"></i> Home
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="cars.jsp">
                            <i class="fas fa-car"></i> Buy Cars
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="SellCar2.jsp">
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
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="contact.jsp">
                            <i class="fas fa-envelope"></i> Contact
                        </a>
                    </li>
                </ul>
                
                <ul class="navbar-nav">
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
                </ul>
            </div>
        </div>
    </nav>

    <!-- Page Header -->
    <section class="page-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8" data-aos="fade-right">
                    <h1 class="display-5 fw-bold mb-3">Sell Your Car</h1>
                    <p class="lead mb-0">Create a detailed listing and reach thousands of potential buyers</p>
                </div>
                <div class="col-lg-4 text-lg-end" data-aos="fade-left">
                    <div class="d-flex justify-content-lg-end justify-content-center mt-3 mt-lg-0">
                        <a href="MyUCars.jsp" class="btn btn-light btn-lg">
                            <i class="fas fa-list"></i> My Listings
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <div class="container">
        <!-- Why Sell With Us -->
        <div class="row mb-5" data-aos="fade-up">
            <div class="col-12">
                <h3 class="text-center mb-4">Why Sell With CarDeal?</h3>
                <div class="feature-grid">
                    <div class="feature-card">
                        <i class="fas fa-users feature-icon"></i>
                        <h5>Large Audience</h5>
                        <p class="text-muted">Reach thousands of potential buyers actively searching for cars.</p>
                    </div>
                    <div class="feature-card">
                        <i class="fas fa-shield-alt feature-icon"></i>
                        <h5>Secure Platform</h5>
                        <p class="text-muted">Safe and secure transactions with verified buyer contacts.</p>
                    </div>
                    <div class="feature-card">
                        <i class="fas fa-chart-line feature-icon"></i>
                        <h5>Best Prices</h5>
                        <p class="text-muted">Get the best value for your vehicle with our market insights.</p>
                    </div>
                    <div class="feature-card">
                        <i class="fas fa-headset feature-icon"></i>
                        <h5>24/7 Support</h5>
                        <p class="text-muted">Round-the-clock support to help you through the selling process.</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Error/Success Messages -->
        <% if (errorMessage != null) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert" data-aos="fade-up">
                <i class="fas fa-exclamation-circle"></i>
                <%= errorMessage %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>

        <% if (successMessage != null) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert" data-aos="fade-up">
                <i class="fas fa-check-circle"></i>
                <%= successMessage %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>

        <!-- Sell Car Form -->
        <div class="sell-form-container" data-aos="fade-up">
            <!-- Step Indicator -->
            <div class="step-indicator">
                <div class="step active" id="stepIndicator1">
                    <div class="step-number">1</div>
                    <div class="step-label">Basic Info</div>
                </div>
                <div class="step-connector"></div>
                <div class="step" id="stepIndicator2">
                    <div class="step-number">2</div>
                    <div class="step-label">Details</div>
                </div>
                <div class="step-connector"></div>
                <div class="step" id="stepIndicator3">
                    <div class="step-number">3</div>
                    <div class="step-label">Photos</div>
                </div>
                <div class="step-connector"></div>
                <div class="step" id="stepIndicator4">
                    <div class="step-number">4</div>
                    <div class="step-label">Review</div>
                </div>
            </div>

            <!-- Progress Bar -->
            <div class="progress-bar-container">
                <div class="progress-bar-fill" id="progressBar" style="width: 25%;"></div>
            </div>

            <!-- Form -->
            <form action="SellCarServlet" method="post" enctype="multipart/form-data" id="sellCarForm" novalidate>
                <!-- CSRF Token -->
                <input type="hidden" name="csrfToken" value="<%= session.getAttribute("csrfToken") != null ? session.getAttribute("csrfToken") : "" %>">
                <input type="hidden" name="userId" value="<%= userId %>">
                
                <!-- Step 1: Basic Information -->
                <div class="form-step active" id="step1">
                    <h4><i class="fas fa-info-circle"></i> Basic Car Information</h4>
                    
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="carTitle" class="form-label">Car Title *</label>
                            <input type="text" 
                                   class="form-control" 
                                   id="carTitle" 
                                   name="carTitle" 
                                   placeholder="e.g., 2020 Toyota Camry LE"
                                   required
                                   maxlength="100">
                            <div class="invalid-feedback">Please enter a car title.</div>
                        </div>

                        <div class="col-md-6">
                            <label for="price" class="form-label">Asking Price ($) *</label>
                            <input type="number" 
                                   class="form-control" 
                                   id="price" 
                                   name="price" 
                                   placeholder="25000"
                                   required
                                   min="500"
                                   max="999999"
                                   oninput="updatePriceSuggestion()">
                            <div class="invalid-feedback">Please enter a valid price ($500 - $999,999).</div>
                            <div class="price-suggestion" id="priceSuggestion" style="display: none;">
                                <i class="fas fa-lightbulb"></i> 
                                <span id="suggestionText"></span>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <label for="carBrand" class="form-label">Make *</label>
                            <select class="form-select" id="carBrand" name="carBrand" required onchange="updateModelOptions()">
                                <option value="">Select Make</option>
                                <option value="Toyota">Toyota</option>
                                <option value="Honda">Honda</option>
                                <option value="Ford">Ford</option>
                                <option value="Chevrolet">Chevrolet</option>
                                <option value="BMW">BMW</option>
                                <option value="Mercedes">Mercedes-Benz</option>
                                <option value="Audi">Audi</option>
                                <option value="Nissan">Nissan</option>
                                <option value="Hyundai">Hyundai</option>
                                <option value="Kia">Kia</option>
                                <option value="Volkswagen">Volkswagen</option>
                                <option value="Subaru">Subaru</option>
                                <option value="Mazda">Mazda</option>
                                <option value="Lexus">Lexus</option>
                                <option value="Acura">Acura</option>
                                <option value="Infiniti">Infiniti</option>
                                <option value="Other">Other</option>
                            </select>
                            <div class="invalid-feedback">Please select a make.</div>
                        </div>

                        <div class="col-md-4">
                            <label for="carModel" class="form-label">Model *</label>
                            <input type="text" 
                                   class="form-control" 
                                   id="carModel" 
                                   name="carModel" 
                                   placeholder="e.g., Camry"
                                   required
                                   maxlength="50">
                            <div class="invalid-feedback">Please enter the car model.</div>
                        </div>

                        <div class="col-md-4">
                            <label for="carYear" class="form-label">Year *</label>
                            <select class="form-select" id="carYear" name="carYear" required>
                                <option value="">Select Year</option>
                                <% 
                                int currentYear = java.time.LocalDate.now().getYear();
                                for (int year = currentYear + 1; year >= 1990; year--) { 
                                %>
                                    <option value="<%= year %>"><%= year %></option>
                                <% } %>
                            </select>
                            <div class="invalid-feedback">Please select the year.</div>
                        </div>

                        <div class="col-md-6">
                            <label for="mileage" class="form-label">Mileage (km)</label>
                            <input type="number" 
                                   class="form-control" 
                                   id="mileage" 
                                   name="mileage" 
                                   placeholder="50000"
                                   min="0"
                                   max="1000000">
                            <div class="form-text">Leave blank if not applicable</div>
                        </div>

                        <div class="col-md-6">
                            <label for="location" class="form-label">Location *</label>
                            <input type="text" 
                                   class="form-control" 
                                   id="location" 
                                   name="location" 
                                   placeholder="City, State"
                                   required
                                   maxlength="100">
                            <div class="invalid-feedback">Please enter your location.</div>
                        </div>
                    </div>
                    
                    <div class="d-flex justify-content-end mt-4">
                        <button type="button" class="btn btn-primary" onclick="nextStep(2)">
                            Next: Car Details <i class="fas fa-arrow-right"></i>
                        </button>
                    </div>
                </div>

                <!-- Step 2: Car Details -->
                <div class="form-step" id="step2">
                    <h4><i class="fas fa-cogs"></i> Car Details & Specifications</h4>
                    
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label for="fuelType" class="form-label">Fuel Type *</label>
                            <select class="form-select" id="fuelType" name="fuelType" required>
                                <option value="">Select Fuel Type</option>
                                <option value="Petrol">Petrol</option>
                                <option value="Diesel">Diesel</option>
                                <option value="Electric">Electric</option>
                                <option value="Hybrid">Hybrid</option>
                                <option value="CNG">CNG</option>
                                <option value="LPG">LPG</option>
                            </select>
                            <div class="invalid-feedback">Please select fuel type.</div>
                        </div>

                        <div class="col-md-4">
                            <label for="transmission" class="form-label">Transmission *</label>
                            <select class="form-select" id="transmission" name="transmission" required>
                                <option value="">Select Transmission</option>
                                <option value="Manual">Manual</option>
                                <option value="Automatic">Automatic</option>
                                <option value="CVT">CVT</option>
                                <option value="Semi-Automatic">Semi-Automatic</option>
                            </select>
                            <div class="invalid-feedback">Please select transmission type.</div>
                        </div>

                        <div class="col-md-4">
                            <label for="bodyType" class="form-label">Body Type</label>
                            <select class="form-select" id="bodyType" name="bodyType">
                                <option value="">Select Body Type</option>
                                <option value="Sedan">Sedan</option>
                                <option value="SUV">SUV</option>
                                <option value="Hatchback">Hatchback</option>
                                <option value="Coupe">Coupe</option>
                                <option value="Convertible">Convertible</option>
                                <option value="Pickup Truck">Pickup Truck</option>
                                <option value="Van">Van</option>
                                <option value="Wagon">Wagon</option>
                            </select>
                        </div>

                        <div class="col-md-4">
                            <label for="engineSize" class="form-label">Engine Size (L)</label>
                            <input type="number" 
                                   class="form-control" 
                                   id="engineSize" 
                                   name="engineSize" 
                                   placeholder="2.0"
                                   step="0.1"
                                   min="0.5"
                                   max="10.0">
                        </div>

                        <div class="col-md-4">
                            <label for="doors" class="form-label">Number of Doors</label>
                            <select class="form-select" id="doors" name="doors">
                                <option value="">Select Doors</option>
                                <option value="2">2 Doors</option>
                                <option value="3">3 Doors</option>
                                <option value="4">4 Doors</option>
                                <option value="5">5 Doors</option>
                            </select>
                        </div>

                        <div class="col-md-4">
                            <label for="seats" class="form-label">Number of Seats</label>
                            <select class="form-select" id="seats" name="seats">
                                <option value="">Select Seats</option>
                                <option value="2">2 Seats</option>
                                <option value="4">4 Seats</option>
                                <option value="5">5 Seats</option>
                                <option value="7">7 Seats</option>
                                <option value="8">8 Seats</option>
                                <option value="9+">9+ Seats</option>
                            </select>
                        </div>

                        <div class="col-md-6">
                            <label for="color" class="form-label">Color</label>
                            <input type="text" 
                                   class="form-control" 
                                   id="color" 
                                   name="color" 
                                   placeholder="e.g., Red, Blue, Silver"
                                   maxlength="30">
                        </div>

                        <div class="col-md-6">
                            <label for="condition" class="form-label">Condition *</label>
                            <select class="form-select" id="condition" name="condition" required>
                                <option value="">Select Condition</option>
                                <option value="Excellent">Excellent</option>
                                <option value="Very Good">Very Good</option>
                                <option value="Good">Good</option>
                                <option value="Fair">Fair</option>
                                <option value="Poor">Poor</option>
                            </select>
                            <div class="invalid-feedback">Please select car condition.</div>
                        </div>

                        <div class="col-12">
                            <label for="features" class="form-label">Features & Equipment</label>
                            <div class="row g-2">
                                <div class="col-md-3">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="aircon" name="features" value="Air Conditioning">
                                        <label class="form-check-label" for="aircon">Air Conditioning</label>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="powerSteering" name="features" value="Power Steering">
                                        <label class="form-check-label" for="powerSteering">Power Steering</label>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="abs" name="features" value="ABS">
                                        <label class="form-check-label" for="abs">ABS</label>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="airbags" name="features" value="Airbags">
                                        <label class="form-check-label" for="airbags">Airbags</label>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="sunroof" name="features" value="Sunroof">
                                        <label class="form-check-label" for="sunroof">Sunroof</label>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="gps" name="features" value="GPS Navigation">
                                        <label class="form-check-label" for="gps">GPS Navigation</label>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="bluetooth" name="features" value="Bluetooth">
                                        <label class="form-check-label" for="bluetooth">Bluetooth</label>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="backup" name="features" value="Backup Camera">
                                        <label class="form-check-label" for="backup">Backup Camera</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-12">
                            <label for="carDescription" class="form-label">Description</label>
                            <textarea class="form-control" 
                                      id="carDescription" 
                                      name="carDescription" 
                                      rows="4" 
                                      placeholder="Describe your car's condition, history, and any additional details..."
                                      maxlength="1000"
                                      oninput="updateCharCounter('carDescription', 'descCounter', 1000)"></textarea>
                            <div class="char-counter">
                                <span id="descCounter">0</span>/1000 characters
                            </div>
                        </div>
                    </div>
                    
                    <div class="d-flex justify-content-between mt-4">
                        <button type="button" class="btn btn-outline-secondary" onclick="previousStep(1)">
                            <i class="fas fa-arrow-left"></i> Back
                        </button>
                        <button type="button" class="btn btn-primary" onclick="nextStep(3)">
                            Next: Add Photos <i class="fas fa-arrow-right"></i>
                        </button>
                    </div>
                </div>

                <!-- Step 3: Photos -->
                <div class="form-step" id="step3">
                    <h4><i class="fas fa-camera"></i> Add Car Photos</h4>
                    <p class="text-muted mb-4">Add high-quality photos to attract more buyers. You can upload up to 5 images.</p>
                    
                    <div class="dropzone" id="photoDropzone">
                        <i class="fas fa-cloud-upload-alt fa-3x mb-3 text-primary"></i>
                        <h5>Drag & Drop Photos Here</h5>
                        <p class="text-muted">or click to browse files</p>
                        <p class="small text-muted">Supported formats: JPG, PNG, GIF (Max 5MB each)</p>
                        <input type="file" 
                               id="carImages" 
                               name="carImages" 
                               multiple 
                               accept="image/*" 
                               style="display: none;"
                               onchange="handleFileSelect(this.files)">
                    </div>
                    
                    <div class="image-preview" id="imagePreview"></div>
                    
                    <div class="alert alert-info mt-3">
                        <i class="fas fa-lightbulb"></i>
                        <strong>Photo Tips:</strong>
                        <ul class="mb-0 mt-2">
                            <li>Take photos in good lighting conditions</li>
                            <li>Include exterior shots from multiple angles</li>
                            <li>Add interior photos showing dashboard and seats</li>
                            <li>Capture any damage or wear honestly</li>
                            <li>Clean your car before taking photos</li>
                        </ul>
                    </div>
                    
                    <div class="d-flex justify-content-between mt-4">
                        <button type="button" class="btn btn-outline-secondary" onclick="previousStep(2)">
                            <i class="fas fa-arrow-left"></i> Back
                        </button>
                        <button type="button" class="btn btn-primary" onclick="nextStep(4)">
                            Next: Review <i class="fas fa-arrow-right"></i>
                        </button>
                    </div>
                </div>

                <!-- Step 4: Review & Submit -->
                <div class="form-step" id="step4">
                    <h4><i class="fas fa-check-circle"></i> Review Your Listing</h4>
                    <p class="text-muted mb-4">Please review all information before submitting your car listing.</p>
                    
                    <div class="row">
                        <div class="col-lg-8">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="mb-0">Listing Preview</h5>
                                </div>
                                <div class="card-body">
                                    <div id="listingPreview">
                                        <!-- Preview content will be generated by JavaScript -->
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-lg-4">
                            <div class="card">
                                <div class="card-header">
                                    <h6 class="mb-0">Listing Agreement</h6>
                                </div>
                                <div class="card-body">
                                    <div class="form-check mb-3">
                                        <input class="form-check-input" type="checkbox" id="agreeTerms" name="agreeTerms" required>
                                        <label class="form-check-label" for="agreeTerms">
                                            I agree to the <a href="#" target="_blank">Terms of Service</a> and 
                                            <a href="#" target="_blank">Listing Agreement</a>
                                        </label>
                                        <div class="invalid-feedback">You must agree to the terms.</div>
                                    </div>
                                    
                                    <div class="form-check mb-3">
                                        <input class="form-check-input" type="checkbox" id="accurateInfo" name="accurateInfo" required>
                                        <label class="form-check-label" for="accurateInfo">
                                            I confirm that all information provided is accurate and truthful
                                        </label>
                                        <div class="invalid-feedback">Please confirm information accuracy.</div>
                                    </div>
                                    
                                    <div class="form-check mb-3">
                                        <input class="form-check-input" type="checkbox" id="contactPermission" name="contactPermission" required>
                                        <label class="form-check-label" for="contactPermission">
                                            I agree to be contacted by potential buyers
                                        </label>
                                        <div class="invalid-feedback">Contact permission is required.</div>
                                    </div>
                                    
                                    <div class="alert alert-warning">
                                        <small>
                                            <i class="fas fa-exclamation-triangle"></i>
                                            Your listing will be reviewed and published within 24 hours.
                                        </small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="d-flex justify-content-between mt-4">
                        <button type="button" class="btn btn-outline-secondary" onclick="previousStep(3)">
                            <i class="fas fa-arrow-left"></i> Back
                        </button>
                        <button type="submit" class="btn btn-success btn-lg" id="submitBtn">
                            <i class="fas fa-paper-plane"></i> Submit Listing
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>

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

        let currentStep = 1;
        const totalSteps = 4;
        let uploadedFiles = [];

        // Step navigation
        function nextStep(step) {
            if (validateCurrentStep()) {
                document.getElementById('step' + currentStep).classList.remove('active');
                document.getElementById('stepIndicator' + currentStep).classList.remove('active');
                document.getElementById('stepIndicator' + currentStep).classList.add('completed');
                
                currentStep = step;
                document.getElementById('step' + currentStep).classList.add('active');
                document.getElementById('stepIndicator' + currentStep).classList.add('active');
                
                updateProgressBar();
                
                if (currentStep === 4) {
                    generateListingPreview();
                }
            }
        }

        function previousStep(step) {
            document.getElementById('step' + currentStep).classList.remove('active');
            document.getElementById('stepIndicator' + currentStep).classList.remove('active');
            
            currentStep = step;
            document.getElementById('step' + currentStep).classList.add('active');
            document.getElementById('stepIndicator' + currentStep).classList.add('active');
            document.getElementById('stepIndicator' + currentStep).classList.remove('completed');
            
            updateProgressBar();
        }

        function updateProgressBar() {
            const progress = (currentStep / totalSteps) * 100;
            document.getElementById('progressBar').style.width = progress + '%';
        }

        function validateCurrentStep() {
            const currentStepElement = document.getElementById('step' + currentStep);
            const requiredFields = currentStepElement.querySelectorAll('[required]');
            let isValid = true;

            requiredFields.forEach(field => {
                if (!field.checkValidity()) {
                    field.classList.add('is-invalid');
                    isValid = false;
                } else {
                    field.classList.remove('is-invalid');
                    field.classList.add('is-valid');
                }
            });

            if (!isValid) {
                currentStepElement.classList.add('was-validated');
            }

            return isValid;
        }

        // File upload handling
        function handleFileSelect(files) {
            const maxFiles = 5;
            const maxSize = 5 * 1024 * 1024; // 5MB
            
            if (uploadedFiles.length + files.length > maxFiles) {
                alert('Maximum 5 images allowed');
                return;
            }
            
            Array.from(files).forEach(file => {
                if (file.size > maxSize) {
                    alert('File ' + file.name + ' is too large. Maximum size is 5MB.');
                    return;
                }
                
                if (!file.type.startsWith('image/')) {
                    alert('File ' + file.name + ' is not an image.');
                    return;
                }
                
                uploadedFiles.push(file);
                displayImagePreview(file);
            });
        }

        function displayImagePreview(file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                const imagePreview = document.getElementById('imagePreview');
                const imageItem = document.createElement('div');
                imageItem.className = 'image-preview-item';
                imageItem.innerHTML = `
                    <img src="${e.target.result}" alt="Car image">
                    <button type="button" class="image-remove" onclick="removeImage(this, '${file.name}')">
                        <i class="fas fa-times"></i>
                    </button>
                `;
                imagePreview.appendChild(imageItem);
            };
            reader.readAsDataURL(file);
        }

        function removeImage(button, fileName) {
            uploadedFiles = uploadedFiles.filter(file => file.name !== fileName);
            button.parentElement.remove();
        }

        // Dropzone functionality
        const dropzone = document.getElementById('photoDropzone');
        const fileInput = document.getElementById('carImages');

        dropzone.addEventListener('click', () => fileInput.click());

        dropzone.addEventListener('dragover', (e) => {
            e.preventDefault();
            dropzone.classList.add('dragover');
        });

        dropzone.addEventListener('dragleave', () => {
            dropzone.classList.remove('dragover');
        });

        dropzone.addEventListener('drop', (e) => {
            e.preventDefault();
            dropzone.classList.remove('dragover');
            handleFileSelect(e.dataTransfer.files);
        });

        // Character counter
        function updateCharCounter(textareaId, counterId, maxLength) {
            const textarea = document.getElementById(textareaId);
            const counter = document.getElementById(counterId);
            counter.textContent = textarea.value.length;
            
            if (textarea.value.length > maxLength * 0.9) {
                counter.style.color = 'var(--warning-color)';
            } else {
                counter.style.color = 'var(--secondary-color)';
            }
        }

        // Price suggestion
        function updatePriceSuggestion() {
            const price = document.getElementById('price').value;
            const year = document.getElementById('carYear').value;
            const brand = document.getElementById('carBrand').value;
            const suggestion = document.getElementById('priceSuggestion');
            const suggestionText = document.getElementById('suggestionText');
            
            if (price && year && brand) {
                const currentYear = new Date().getFullYear();
                const age = currentYear - parseInt(year);
                
                let message = '';
                if (age <= 3) {
                    message = 'Great! This price is competitive for a newer vehicle.';
                } else if (age <= 7) {
                    message = 'Consider market comparison for vehicles of this age.';
                } else {
                    message = 'Older vehicles may benefit from competitive pricing.';
                }
                
                suggestionText.textContent = message;
                suggestion.style.display = 'block';
            } else {
                suggestion.style.display = 'none';
            }
        }

        // Generate listing preview
        function generateListingPreview() {
            const formData = new FormData(document.getElementById('sellCarForm'));
            const features = Array.from(document.querySelectorAll('input[name="features"]:checked')).map(cb => cb.value);
            
            const preview = document.getElementById('listingPreview');
            preview.innerHTML = `
                <h5>${formData.get('carTitle') || 'Car Title'}</h5>
                <div class="row mb-3">
                    <div class="col-6"><strong>Price:</strong> $${formData.get('price') || 'N/A'}</div>
                    <div class="col-6"><strong>Year:</strong> ${formData.get('carYear') || 'N/A'}</div>
                    <div class="col-6"><strong>Make:</strong> ${formData.get('carBrand') || 'N/A'}</div>
                    <div class="col-6"><strong>Model:</strong> ${formData.get('carModel') || 'N/A'}</div>
                    <div class="col-6"><strong>Fuel:</strong> ${formData.get('fuelType') || 'N/A'}</div>
                    <div class="col-6"><strong>Transmission:</strong> ${formData.get('transmission') || 'N/A'}</div>
                    <div class="col-6"><strong>Mileage:</strong> ${formData.get('mileage') || 'N/A'} km</div>
                    <div class="col-6"><strong>Location:</strong> ${formData.get('location') || 'N/A'}</div>
                </div>
                ${features.length ? '<p><strong>Features:</strong> ' + features.join(', ') + '</p>' : ''}
                ${formData.get('carDescription') ? '<p><strong>Description:</strong> ' + formData.get('carDescription') + '</p>' : ''}
                <p><strong>Images:</strong> ${uploadedFiles.length} uploaded</p>
            `;
        }

        // Form submission
        document.getElementById('sellCarForm').addEventListener('submit', function(e) {
            if (!validateCurrentStep()) {
                e.preventDefault();
                return;
            }
            
            const submitBtn = document.getElementById('submitBtn');
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Submitting...';
            
            // Re-enable after 10 seconds as fallback
            setTimeout(function() {
                submitBtn.disabled = false;
                submitBtn.innerHTML = '<i class="fas fa-paper-plane"></i> Submit Listing';
            }, 10000);
        });

        // Real-time validation
        document.querySelectorAll('input, select, textarea').forEach(field => {
            field.addEventListener('blur', function() {
                if (this.checkValidity()) {
                    this.classList.remove('is-invalid');
                    this.classList.add('is-valid');
                } else {
                    this.classList.remove('is-valid');
                    this.classList.add('is-invalid');
                }
            });
        });

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
