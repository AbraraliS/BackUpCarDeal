<%-- 
    Document   : cars (Modernized)
    Created on : 02-May-2024, 10:11:31 pm
    Author     : Abrarali
    Refactored Version with Bootstrap 5 and Advanced Search
--%>

<%@page import="carsellbuy.DataSource"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Browse Cars - CarDeal</title>
    
    <!-- SEO Meta Tags -->
    <meta name="description" content="Browse thousands of quality cars for sale. Find your perfect vehicle with advanced search filters and detailed listings.">
    <meta name="keywords" content="cars for sale, buy cars, used cars, new cars, car listings, automotive marketplace">
    <meta name="author" content="CarDeal Team">
    
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
        
        .search-filters {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            margin-bottom: 2rem;
            position: sticky;
            top: 90px;
            z-index: 100;
        }
        
        .car-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            margin-bottom: 2rem;
            border: none;
        }
        
        .car-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
        }
        
        .car-image {
            height: 250px;
            object-fit: cover;
            width: 100%;
            cursor: pointer;
        }
        
        .car-image-container {
            position: relative;
            overflow: hidden;
        }
        
        .car-image-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.7);
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.3s ease;
        }
        
        .car-image-container:hover .car-image-overlay {
            opacity: 1;
        }
        
        .price-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: var(--primary-color);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 25px;
            font-weight: bold;
            font-size: 1.1rem;
            box-shadow: 0 2px 10px rgba(0, 123, 255, 0.3);
        }
        
        .featured-badge {
            position: absolute;
            top: 15px;
            left: 15px;
            background: var(--warning-color);
            color: var(--dark-color);
            padding: 0.25rem 0.75rem;
            border-radius: 15px;
            font-weight: bold;
            font-size: 0.8rem;
        }
        
        .car-details {
            padding: 1.5rem;
        }
        
        .car-title {
            font-size: 1.25rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
            color: var(--dark-color);
        }
        
        .car-specs {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            margin: 1rem 0;
            color: var(--secondary-color);
            font-size: 0.9rem;
        }
        
        .car-spec {
            display: flex;
            align-items: center;
            gap: 0.25rem;
        }
        
        .car-description {
            color: var(--secondary-color);
            font-size: 0.9rem;
            margin-bottom: 1rem;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            line-clamp: 2;
            overflow: hidden;
        }
        
        .seller-info {
            background: var(--light-color);
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 1rem;
        }
        
        .contact-buttons {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }
        
        .btn-contact {
            flex: 1;
            min-width: 120px;
        }
        
        .pagination-container {
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 3rem 0;
        }
        
        .results-info {
            background: white;
            padding: 1rem 1.5rem;
            border-radius: 10px;
            margin-bottom: 1rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }
        
        .sort-dropdown {
            min-width: 200px;
        }
        
        .filter-chip {
            display: inline-block;
            background: var(--primary-color);
            color: white;
            padding: 0.25rem 0.75rem;
            border-radius: 15px;
            font-size: 0.8rem;
            margin: 0.25rem;
            position: relative;
        }
        
        .filter-chip .remove-filter {
            margin-left: 0.5rem;
            cursor: pointer;
            opacity: 0.7;
        }
        
        .filter-chip .remove-filter:hover {
            opacity: 1;
        }
        
        .no-results {
            text-align: center;
            padding: 4rem 2rem;
            color: var(--secondary-color);
        }
        
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(255, 255, 255, 0.8);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 9999;
        }
        
        @media (max-width: 768px) {
            .search-filters {
                position: static;
                margin-bottom: 1rem;
            }
            
            .car-specs {
                gap: 0.5rem;
            }
            
            .contact-buttons {
                flex-direction: column;
            }
            
            .btn-contact {
                min-width: auto;
            }
            
            .results-info {
                flex-direction: column;
                text-align: center;
            }
        }
    </style>
</head>

<body>
    <!-- Loading Overlay -->
    <div class="loading-overlay" id="loadingOverlay">
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

        // Get search parameters
        String searchMake = request.getParameter("make");
        String searchModel = request.getParameter("model");
        String searchYear = request.getParameter("year");
        String searchPriceRange = request.getParameter("priceRange");
        String searchFuelType = request.getParameter("fuelType");
        String searchLocation = request.getParameter("location");
        String searchKeyword = request.getParameter("keyword");
        String sortBy = request.getParameter("sortBy");
        
        // Pagination parameters
        int page = 1;
        int itemsPerPage = 12;
        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null) page = Integer.parseInt(pageParam);
        } catch (NumberFormatException e) {
            page = 1;
        }
        
        // Build search query
        StringBuilder whereClause = new StringBuilder("WHERE cd.isActive = 1");
        List<String> activeFilters = new ArrayList<>();
        
        if (searchMake != null && !searchMake.trim().isEmpty()) {
            whereClause.append(" AND cd.CarBrand LIKE ?");
            activeFilters.add("Make: " + searchMake);
        }
        if (searchModel != null && !searchModel.trim().isEmpty()) {
            whereClause.append(" AND cd.CarModel LIKE ?");
            activeFilters.add("Model: " + searchModel);
        }
        if (searchYear != null && !searchYear.trim().isEmpty()) {
            whereClause.append(" AND cd.CarYear = ?");
            activeFilters.add("Year: " + searchYear);
        }
        if (searchFuelType != null && !searchFuelType.trim().isEmpty()) {
            whereClause.append(" AND cd.FuelType = ?");
            activeFilters.add("Fuel: " + searchFuelType);
        }
        if (searchLocation != null && !searchLocation.trim().isEmpty()) {
            whereClause.append(" AND cd.Location LIKE ?");
            activeFilters.add("Location: " + searchLocation);
        }
        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            whereClause.append(" AND (cd.CarTitle LIKE ? OR cd.CarDescription LIKE ?)");
            activeFilters.add("Keyword: " + searchKeyword);
        }
        if (searchPriceRange != null && !searchPriceRange.trim().isEmpty()) {
            String[] priceRange = searchPriceRange.split("-");
            if (priceRange.length == 2) {
                whereClause.append(" AND cd.Price BETWEEN ? AND ?");
                activeFilters.add("Price: $" + priceRange[0] + " - $" + priceRange[1]);
            }
        }
        
        // Sort options
        String orderBy = "ORDER BY cd.CreatedDate DESC";
        if ("price_asc".equals(sortBy)) {
            orderBy = "ORDER BY CAST(cd.Price AS UNSIGNED) ASC";
        } else if ("price_desc".equals(sortBy)) {
            orderBy = "ORDER BY CAST(cd.Price AS UNSIGNED) DESC";
        } else if ("year_desc".equals(sortBy)) {
            orderBy = "ORDER BY cd.CarYear DESC";
        } else if ("featured".equals(sortBy)) {
            orderBy = "ORDER BY cd.isFeatured DESC, cd.CreatedDate DESC";
        }
        
        int totalResults = 0;
        List<Map<String, Object>> carsList = new ArrayList<>();
        
        try (Connection conn = DataSource.getConnection()) {
            // Count total results
            String countSql = "SELECT COUNT(*) FROM CarDetails cd " + whereClause.toString();
            PreparedStatement countPs = conn.prepareStatement(countSql);
            
            int paramIndex = 1;
            if (searchMake != null && !searchMake.trim().isEmpty()) {
                countPs.setString(paramIndex++, "%" + searchMake + "%");
            }
            if (searchModel != null && !searchModel.trim().isEmpty()) {
                countPs.setString(paramIndex++, "%" + searchModel + "%");
            }
            if (searchYear != null && !searchYear.trim().isEmpty()) {
                countPs.setString(paramIndex++, searchYear);
            }
            if (searchFuelType != null && !searchFuelType.trim().isEmpty()) {
                countPs.setString(paramIndex++, searchFuelType);
            }
            if (searchLocation != null && !searchLocation.trim().isEmpty()) {
                countPs.setString(paramIndex++, "%" + searchLocation + "%");
            }
            if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                countPs.setString(paramIndex++, "%" + searchKeyword + "%");
                countPs.setString(paramIndex++, "%" + searchKeyword + "%");
            }
            if (searchPriceRange != null && !searchPriceRange.trim().isEmpty()) {
                String[] priceRange = searchPriceRange.split("-");
                if (priceRange.length == 2) {
                    countPs.setString(paramIndex++, priceRange[0]);
                    countPs.setString(paramIndex++, priceRange[1]);
                }
            }
            
            ResultSet countRs = countPs.executeQuery();
            if (countRs.next()) {
                totalResults = countRs.getInt(1);
            }
            
            // Get paginated results
            String sql = "SELECT cd.*, ud.FirstName, ud.LastName, ud.Phone, ud.Email " +
                        "FROM CarDetails cd " +
                        "JOIN UserDetails ud ON cd.UserID = ud.UserID " +
                        whereClause.toString() + " " +
                        orderBy + " " +
                        "LIMIT ? OFFSET ?";
                        
            PreparedStatement ps = conn.prepareStatement(sql);
            
            paramIndex = 1;
            if (searchMake != null && !searchMake.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + searchMake + "%");
            }
            if (searchModel != null && !searchModel.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + searchModel + "%");
            }
            if (searchYear != null && !searchYear.trim().isEmpty()) {
                ps.setString(paramIndex++, searchYear);
            }
            if (searchFuelType != null && !searchFuelType.trim().isEmpty()) {
                ps.setString(paramIndex++, searchFuelType);
            }
            if (searchLocation != null && !searchLocation.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + searchLocation + "%");
            }
            if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + searchKeyword + "%");
                ps.setString(paramIndex++, "%" + searchKeyword + "%");
            }
            if (searchPriceRange != null && !searchPriceRange.trim().isEmpty()) {
                String[] priceRange = searchPriceRange.split("-");
                if (priceRange.length == 2) {
                    ps.setString(paramIndex++, priceRange[0]);
                    ps.setString(paramIndex++, priceRange[1]);
                }
            }
            
            ps.setInt(paramIndex++, itemsPerPage);
            ps.setInt(paramIndex++, (page - 1) * itemsPerPage);
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> car = new HashMap<>();
                car.put("CarID", rs.getInt("CarID"));
                car.put("CarTitle", rs.getString("CarTitle"));
                car.put("CarBrand", rs.getString("CarBrand"));
                car.put("CarModel", rs.getString("CarModel"));
                car.put("CarYear", rs.getString("CarYear"));
                car.put("Price", rs.getString("Price"));
                car.put("FuelType", rs.getString("FuelType"));
                car.put("Transmission", rs.getString("Transmission"));
                car.put("Mileage", rs.getString("Mileage"));
                car.put("CarImage1", rs.getString("CarImage1"));
                car.put("CarImage2", rs.getString("CarImage2"));
                car.put("CarImage3", rs.getString("CarImage3"));
                car.put("CarDescription", rs.getString("CarDescription"));
                car.put("Location", rs.getString("Location"));
                car.put("isFeatured", rs.getBoolean("isFeatured"));
                car.put("SellerName", rs.getString("FirstName") + " " + rs.getString("LastName"));
                car.put("SellerPhone", rs.getString("Phone"));
                car.put("SellerEmail", rs.getString("Email"));
                car.put("CreatedDate", rs.getTimestamp("CreatedDate"));
                carsList.add(car);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        int totalPages = (int) Math.ceil((double) totalResults / itemsPerPage);
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
                        <a class="nav-link active" href="cars.jsp">
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

    <!-- Page Header -->
    <section class="page-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8" data-aos="fade-right">
                    <h1 class="display-5 fw-bold mb-3">Browse Cars</h1>
                    <p class="lead mb-0">Find your perfect vehicle from thousands of quality listings</p>
                </div>
                <div class="col-lg-4 text-lg-end" data-aos="fade-left">
                    <div class="d-flex justify-content-lg-end justify-content-center mt-3 mt-lg-0">
                        <a href="SellCar2.jsp" class="btn btn-light btn-lg">
                            <i class="fas fa-plus"></i> Sell Your Car
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <div class="container">
        <div class="row">
            <!-- Search Filters Sidebar -->
            <div class="col-lg-3">
                <div class="search-filters" data-aos="fade-right">
                    <h5 class="mb-3"><i class="fas fa-filter"></i> Search Filters</h5>
                    
                    <form action="cars.jsp" method="get" id="searchForm">
                        <!-- Keyword Search -->
                        <div class="mb-3">
                            <label class="form-label">Search</label>
                            <div class="input-group">
                                <input type="text" 
                                       class="form-control" 
                                       name="keyword" 
                                       placeholder="Search cars..."
                                       value="<%= searchKeyword != null ? searchKeyword : "" %>">
                                <button class="btn btn-outline-primary" type="submit">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </div>

                        <!-- Make -->
                        <div class="mb-3">
                            <label class="form-label">Make</label>
                            <select class="form-select" name="make">
                                <option value="">Any Make</option>
                                <option value="Toyota" <%= "Toyota".equals(searchMake) ? "selected" : "" %>>Toyota</option>
                                <option value="Honda" <%= "Honda".equals(searchMake) ? "selected" : "" %>>Honda</option>
                                <option value="Ford" <%= "Ford".equals(searchMake) ? "selected" : "" %>>Ford</option>
                                <option value="Chevrolet" <%= "Chevrolet".equals(searchMake) ? "selected" : "" %>>Chevrolet</option>
                                <option value="BMW" <%= "BMW".equals(searchMake) ? "selected" : "" %>>BMW</option>
                                <option value="Mercedes" <%= "Mercedes".equals(searchMake) ? "selected" : "" %>>Mercedes-Benz</option>
                                <option value="Audi" <%= "Audi".equals(searchMake) ? "selected" : "" %>>Audi</option>
                                <option value="Nissan" <%= "Nissan".equals(searchMake) ? "selected" : "" %>>Nissan</option>
                                <option value="Hyundai" <%= "Hyundai".equals(searchMake) ? "selected" : "" %>>Hyundai</option>
                                <option value="Kia" <%= "Kia".equals(searchMake) ? "selected" : "" %>>Kia</option>
                                <option value="Volkswagen" <%= "Volkswagen".equals(searchMake) ? "selected" : "" %>>Volkswagen</option>
                                <option value="Subaru" <%= "Subaru".equals(searchMake) ? "selected" : "" %>>Subaru</option>
                            </select>
                        </div>

                        <!-- Year -->
                        <div class="mb-3">
                            <label class="form-label">Year</label>
                            <select class="form-select" name="year">
                                <option value="">Any Year</option>
                                <% 
                                int currentYear = java.time.LocalDate.now().getYear();
                                for (int year = currentYear; year >= currentYear - 25; year--) { 
                                %>
                                    <option value="<%= year %>" <%= String.valueOf(year).equals(searchYear) ? "selected" : "" %>><%= year %></option>
                                <% } %>
                            </select>
                        </div>

                        <!-- Price Range -->
                        <div class="mb-3">
                            <label class="form-label">Price Range</label>
                            <select class="form-select" name="priceRange">
                                <option value="">Any Price</option>
                                <option value="0-10000" <%= "0-10000".equals(searchPriceRange) ? "selected" : "" %>>Under $10,000</option>
                                <option value="10000-25000" <%= "10000-25000".equals(searchPriceRange) ? "selected" : "" %>>$10,000 - $25,000</option>
                                <option value="25000-50000" <%= "25000-50000".equals(searchPriceRange) ? "selected" : "" %>>$25,000 - $50,000</option>
                                <option value="50000-75000" <%= "50000-75000".equals(searchPriceRange) ? "selected" : "" %>>$50,000 - $75,000</option>
                                <option value="75000-100000" <%= "75000-100000".equals(searchPriceRange) ? "selected" : "" %>>$75,000 - $100,000</option>
                                <option value="100000-999999" <%= "100000-999999".equals(searchPriceRange) ? "selected" : "" %>>$100,000+</option>
                            </select>
                        </div>

                        <!-- Fuel Type -->
                        <div class="mb-3">
                            <label class="form-label">Fuel Type</label>
                            <select class="form-select" name="fuelType">
                                <option value="">Any Fuel</option>
                                <option value="Petrol" <%= "Petrol".equals(searchFuelType) ? "selected" : "" %>>Petrol</option>
                                <option value="Diesel" <%= "Diesel".equals(searchFuelType) ? "selected" : "" %>>Diesel</option>
                                <option value="Electric" <%= "Electric".equals(searchFuelType) ? "selected" : "" %>>Electric</option>
                                <option value="Hybrid" <%= "Hybrid".equals(searchFuelType) ? "selected" : "" %>>Hybrid</option>
                                <option value="CNG" <%= "CNG".equals(searchFuelType) ? "selected" : "" %>>CNG</option>
                            </select>
                        </div>

                        <!-- Location -->
                        <div class="mb-3">
                            <label class="form-label">Location</label>
                            <input type="text" 
                                   class="form-control" 
                                   name="location" 
                                   placeholder="Enter city or state"
                                   value="<%= searchLocation != null ? searchLocation : "" %>">
                        </div>

                        <!-- Buttons -->
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-search"></i> Search Cars
                            </button>
                            <a href="cars.jsp" class="btn btn-outline-secondary">
                                <i class="fas fa-undo"></i> Clear Filters
                            </a>
                        </div>
                    </form>

                    <!-- Active Filters -->
                    <% if (!activeFilters.isEmpty()) { %>
                        <div class="mt-3">
                            <h6>Active Filters:</h6>
                            <% for (String filter : activeFilters) { 
                                String filterType = filter.split(":")[0];
                            %>
                                <span class="filter-chip">
                                    <%= filter %>
                                    <span class="remove-filter" onclick="removeFilter('<%= filterType %>')">×</span>
                                </span>
                            <% } %>
                        </div>
                    <% } %>
                </div>
            </div>

            <!-- Results Section -->
            <div class="col-lg-9">
                <!-- Results Info -->
                <div class="results-info" data-aos="fade-up">
                    <div>
                        <h6 class="mb-1">Search Results</h6>
                        <p class="text-muted mb-0">
                            Showing <%= (page - 1) * itemsPerPage + 1 %> - 
                            <%= Math.min(page * itemsPerPage, totalResults) %> of 
                            <%= totalResults %> cars
                        </p>
                    </div>
                    <div>
                        <label class="form-label me-2">Sort by:</label>
                        <select class="form-select sort-dropdown" onchange="updateSort(this.value)">
                            <option value="newest" <%= "newest".equals(sortBy) || sortBy == null ? "selected" : "" %>>Newest First</option>
                            <option value="price_asc" <%= "price_asc".equals(sortBy) ? "selected" : "" %>>Price: Low to High</option>
                            <option value="price_desc" <%= "price_desc".equals(sortBy) ? "selected" : "" %>>Price: High to Low</option>
                            <option value="year_desc" <%= "year_desc".equals(sortBy) ? "selected" : "" %>>Year: Newest First</option>
                            <option value="featured" <%= "featured".equals(sortBy) ? "selected" : "" %>>Featured First</option>
                        </select>
                    </div>
                </div>

                <!-- Car Listings -->
                <div class="row">
                    <% if (carsList.isEmpty()) { %>
                        <div class="col-12">
                            <div class="no-results" data-aos="fade-up">
                                <i class="fas fa-search fa-4x mb-3 text-muted"></i>
                                <h4>No cars found</h4>
                                <p class="lead">Try adjusting your search filters or browse all available cars.</p>
                                <a href="cars.jsp" class="btn btn-primary">
                                    <i class="fas fa-car"></i> View All Cars
                                </a>
                            </div>
                        </div>
                    <% } else { %>
                        <% for (Map<String, Object> car : carsList) { %>
                        <div class="col-lg-6 col-xl-4" data-aos="fade-up" data-aos-delay="100">
                            <div class="car-card">
                                <div class="car-image-container">
                                    <img src="image/<%= car.get("CarImage1") %>" 
                                         class="car-image" 
                                         alt="<%= car.get("CarTitle") %>"
                                         data-car-id="<%= car.get("CarID") %>"
                                         onclick="viewCarDetails(this.getAttribute('data-car-id'))">
                                    
                                    <div class="car-image-overlay">
                                        <button class="btn btn-light" 
                                                data-car-id="<%= car.get("CarID") %>"
                                                onclick="viewCarDetails(this.getAttribute('data-car-id'))">
                                            <i class="fas fa-eye"></i> View Details
                                        </button>
                                    </div>
                                    
                                    <div class="price-badge">$<%= car.get("Price") %></div>
                                    
                                    <% if ((Boolean) car.get("isFeatured")) { %>
                                        <div class="featured-badge">
                                            <i class="fas fa-star"></i> Featured
                                        </div>
                                    <% } %>
                                </div>
                                
                                <div class="car-details">
                                    <h5 class="car-title"><%= car.get("CarTitle") %></h5>
                                    
                                    <div class="car-specs">
                                        <div class="car-spec">
                                            <i class="fas fa-calendar"></i>
                                            <span><%= car.get("CarYear") %></span>
                                        </div>
                                        <div class="car-spec">
                                            <i class="fas fa-gas-pump"></i>
                                            <span><%= car.get("FuelType") %></span>
                                        </div>
                                        <div class="car-spec">
                                            <i class="fas fa-cogs"></i>
                                            <span><%= car.get("Transmission") %></span>
                                        </div>
                                        <% if (car.get("Mileage") != null && !car.get("Mileage").toString().trim().isEmpty()) { %>
                                        <div class="car-spec">
                                            <i class="fas fa-tachometer-alt"></i>
                                            <span><%= car.get("Mileage") %> km</span>
                                        </div>
                                        <% } %>
                                        <div class="car-spec">
                                            <i class="fas fa-map-marker-alt"></i>
                                            <span><%= car.get("Location") %></span>
                                        </div>
                                    </div>
                                    
                                    <% if (car.get("CarDescription") != null && !car.get("CarDescription").toString().trim().isEmpty()) { %>
                                    <p class="car-description"><%= car.get("CarDescription") %></p>
                                    <% } %>
                                    
                                    <div class="seller-info">
                                        <div class="d-flex align-items-center mb-2">
                                            <i class="fas fa-user me-2"></i>
                                            <strong><%= car.get("SellerName") %></strong>
                                        </div>
                                        <div class="contact-buttons">
                                            <button class="btn btn-outline-primary btn-sm btn-contact" 
                                                    data-contact-type="phone"
                                                    data-contact-value="<%= car.get("SellerPhone") %>"
                                                    onclick="contactSeller(this.getAttribute('data-contact-type'), this.getAttribute('data-contact-value'))">
                                                <i class="fas fa-phone"></i> Call
                                            </button>
                                            <button class="btn btn-outline-success btn-sm btn-contact" 
                                                    data-contact-type="email"
                                                    data-contact-value="<%= car.get("SellerEmail") %>"
                                                    onclick="contactSeller(this.getAttribute('data-contact-type'), this.getAttribute('data-contact-value'))">
                                                <i class="fas fa-envelope"></i> Email
                                            </button>
                                            <button class="btn btn-primary btn-sm btn-contact" 
                                                    data-car-id="<%= car.get("CarID") %>"
                                                    onclick="viewCarDetails(this.getAttribute('data-car-id'))">
                                                <i class="fas fa-info-circle"></i> Details
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <% } %>
                    <% } %>
                </div>

                <!-- Pagination -->
                <% if (totalPages > 1) { %>
                <div class="pagination-container" data-aos="fade-up">
                    <nav>
                        <ul class="pagination pagination-lg">
                            <!-- Previous Button -->
                            <% if (page > 1) { %>
                            <li class="page-item">
                                <a class="page-link" href="?<%= request.getQueryString() != null ? request.getQueryString().replaceAll("page=\\d+", "").replaceAll("&+", "&").replaceAll("^&|&$", "") + "&" : "" %>page=<%= page - 1 %>">
                                    <i class="fas fa-chevron-left"></i> Previous
                                </a>
                            </li>
                            <% } else { %>
                            <li class="page-item disabled">
                                <span class="page-link"><i class="fas fa-chevron-left"></i> Previous</span>
                            </li>
                            <% } %>

                            <!-- Page Numbers -->
                            <% 
                            int startPage = Math.max(1, page - 2);
                            int endPage = Math.min(totalPages, page + 2);
                            
                            if (startPage > 1) { %>
                                <li class="page-item">
                                    <a class="page-link" href="?<%= request.getQueryString() != null ? request.getQueryString().replaceAll("page=\\d+", "").replaceAll("&+", "&").replaceAll("^&|&$", "") + "&" : "" %>page=1">1</a>
                                </li>
                                <% if (startPage > 2) { %>
                                <li class="page-item disabled">
                                    <span class="page-link">...</span>
                                </li>
                                <% } %>
                            <% } %>

                            <% for (int i = startPage; i <= endPage; i++) { %>
                            <li class="page-item <%= i == page ? "active" : "" %>">
                                <% if (i == page) { %>
                                <span class="page-link"><%= i %></span>
                                <% } else { %>
                                <a class="page-link" href="?<%= request.getQueryString() != null ? request.getQueryString().replaceAll("page=\\d+", "").replaceAll("&+", "&").replaceAll("^&|&$", "") + "&" : "" %>page=<%= i %>"><%= i %></a>
                                <% } %>
                            </li>
                            <% } %>

                            <% if (endPage < totalPages) { 
                                if (endPage < totalPages - 1) { %>
                                <li class="page-item disabled">
                                    <span class="page-link">...</span>
                                </li>
                                <% } %>
                                <li class="page-item">
                                    <a class="page-link" href="?<%= request.getQueryString() != null ? request.getQueryString().replaceAll("page=\\d+", "").replaceAll("&+", "&").replaceAll("^&|&$", "") + "&" : "" %>page=<%= totalPages %>"><%= totalPages %></a>
                                </li>
                            <% } %>

                            <!-- Next Button -->
                            <% if (page < totalPages) { %>
                            <li class="page-item">
                                <a class="page-link" href="?<%= request.getQueryString() != null ? request.getQueryString().replaceAll("page=\\d+", "").replaceAll("&+", "&").replaceAll("^&|&$", "") + "&" : "" %>page=<%= page + 1 %>">
                                    Next <i class="fas fa-chevron-right"></i>
                                </a>
                            </li>
                            <% } else { %>
                            <li class="page-item disabled">
                                <span class="page-link">Next <i class="fas fa-chevron-right"></i></span>
                            </li>
                            <% } %>
                        </ul>
                    </nav>
                </div>
                <% } %>
            </div>
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

        // View car details
        function viewCarDetails(carId) {
            window.location.href = 'car-details.jsp?carId=' + carId;
        }

        // Contact seller
        function contactSeller(type, contact) {
            if (type === 'phone') {
                window.location.href = 'tel:' + contact;
            } else if (type === 'email') {
                window.location.href = 'mailto:' + contact + '?subject=Inquiry about your car listing';
            }
        }

        // Update sort
        function updateSort(sortValue) {
            const url = new URL(window.location.href);
            url.searchParams.set('sortBy', sortValue);
            url.searchParams.delete('page'); // Reset to first page
            window.location.href = url.toString();
        }

        // Remove filter
        function removeFilter(filterType) {
            const url = new URL(window.location.href);
            
            switch(filterType.toLowerCase()) {
                case 'make':
                    url.searchParams.delete('make');
                    break;
                case 'model':
                    url.searchParams.delete('model');
                    break;
                case 'year':
                    url.searchParams.delete('year');
                    break;
                case 'price':
                    url.searchParams.delete('priceRange');
                    break;
                case 'fuel':
                    url.searchParams.delete('fuelType');
                    break;
                case 'location':
                    url.searchParams.delete('location');
                    break;
                case 'keyword':
                    url.searchParams.delete('keyword');
                    break;
            }
            
            url.searchParams.delete('page'); // Reset to first page
            window.location.href = url.toString();
        }

        // Show loading overlay during navigation
        document.addEventListener('DOMContentLoaded', function() {
            const links = document.querySelectorAll('a[href*="cars.jsp"], form[action*="cars.jsp"]');
            const loadingOverlay = document.getElementById('loadingOverlay');
            
            links.forEach(link => {
                link.addEventListener('click', function() {
                    loadingOverlay.style.display = 'flex';
                });
            });
            
            document.getElementById('searchForm').addEventListener('submit', function() {
                loadingOverlay.style.display = 'flex';
            });
        });

        // Auto-submit form when filters change
        document.querySelectorAll('#searchForm select').forEach(select => {
            select.addEventListener('change', function() {
                document.getElementById('searchForm').submit();
            });
        });

        // Handle image loading errors
        document.querySelectorAll('.car-image').forEach(img => {
            img.addEventListener('error', function() {
                this.src = 'images/placeholder-car.jpg'; // Fallback image
                this.alt = 'Car image not available';
            });
        });
    </script>
</body>
</html>
