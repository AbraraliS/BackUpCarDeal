<%-- 
    Document   : car-details (Modernized)
    Created on : 02-May-2024, 10:09:59 pm
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
    <title>Car Details - CarDeal</title>
    
    <!-- SEO Meta Tags -->
    <meta name="description" content="View detailed information about this car listing including specifications, photos, and seller contact information">
    <meta name="keywords" content="car details, vehicle specifications, automotive marketplace, car for sale">
    <meta name="author" content="CarDeal Team">
    
    <!-- Security Headers -->
    <meta http-equiv="Content-Security-Policy" content="default-src 'self'; script-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net; style-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net https://cdnjs.cloudflare.com; img-src 'self' data: https:; font-src 'self' https://cdnjs.cloudflare.com;">
    
    <!-- Favicon -->
    <link rel="icon" href="images/favicon.ico" type="image/x-icon">
    
    <!-- CSS Links -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/lightbox2@2.11.3/dist/css/lightbox.min.css" rel="stylesheet">
    
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

        .car-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2rem 0;
        }

        .car-image-gallery {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: var(--shadow);
            margin-bottom: 2rem;
        }

        .main-image {
            width: 100%;
            height: 400px;
            object-fit: cover;
            cursor: pointer;
            transition: transform 0.3s ease;
        }

        .main-image:hover {
            transform: scale(1.02);
        }

        .thumbnail-gallery {
            padding: 1rem;
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(100px, 1fr));
            gap: 0.5rem;
        }

        .thumbnail {
            width: 100%;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
            cursor: pointer;
            border: 2px solid transparent;
            transition: all 0.3s ease;
        }

        .thumbnail:hover,
        .thumbnail.active {
            border-color: var(--primary-color);
            transform: scale(1.05);
        }

        .car-info-card {
            background: white;
            border-radius: 20px;
            box-shadow: var(--shadow);
            overflow: hidden;
            margin-bottom: 2rem;
        }

        .price-badge {
            background: linear-gradient(135deg, var(--success-color), #20c997);
            color: white;
            padding: 1rem 2rem;
            border-radius: 50px;
            font-size: 2rem;
            font-weight: bold;
            display: inline-block;
            box-shadow: var(--shadow);
        }

        .spec-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1rem;
            margin: 1.5rem 0;
        }

        .spec-item {
            background: var(--light-color);
            padding: 1rem;
            border-radius: 10px;
            border-left: 4px solid var(--primary-color);
            transition: transform 0.3s ease;
        }

        .spec-item:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-sm);
        }

        .spec-label {
            font-size: 0.875rem;
            color: var(--secondary-color);
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .spec-value {
            font-size: 1.25rem;
            font-weight: bold;
            color: var(--dark-color);
            margin-top: 0.25rem;
        }

        .seller-card {
            background: white;
            border-radius: 20px;
            padding: 2rem;
            box-shadow: var(--shadow);
            margin-bottom: 2rem;
            border: 1px solid var(--border-color);
        }

        .seller-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid var(--primary-color);
        }

        .contact-button {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            border: none;
            color: white;
            padding: 1rem 2rem;
            border-radius: 50px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
        }

        .contact-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(0, 123, 255, 0.3);
            color: white;
        }

        .feature-tag {
            background: var(--primary-bg);
            color: var(--primary-color);
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 500;
            margin: 0.25rem;
            display: inline-block;
        }

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.875rem;
        }

        .status-available {
            background: var(--success-color);
            color: white;
        }

        .status-sold {
            background: var(--secondary-color);
            color: white;
        }

        .status-pending {
            background: var(--warning-color);
            color: var(--dark-color);
        }

        .description-card {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: var(--shadow-sm);
            margin-bottom: 2rem;
        }

        .breadcrumb {
            background: white;
            border-radius: 10px;
            padding: 1rem;
            margin-bottom: 1rem;
            box-shadow: var(--shadow-sm);
        }

        .breadcrumb-item + .breadcrumb-item::before {
            content: ">";
            color: var(--primary-color);
            font-weight: bold;
        }

        .breadcrumb-item.active {
            color: var(--primary-color);
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

        .similar-cars {
            background: white;
            border-radius: 20px;
            padding: 2rem;
            box-shadow: var(--shadow);
        }

        .similar-car-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: var(--shadow-sm);
            transition: transform 0.3s ease;
            border: 1px solid var(--border-color);
        }

        .similar-car-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow);
        }

        .similar-car-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        @media (max-width: 768px) {
            .main-image {
                height: 250px;
            }

            .spec-grid {
                grid-template-columns: 1fr;
            }

            .price-badge {
                font-size: 1.5rem;
                padding: 0.75rem 1.5rem;
            }

            .thumbnail-gallery {
                grid-template-columns: repeat(auto-fill, minmax(80px, 1fr));
            }

            .contact-button {
                width: 100%;
                justify-content: center;
                margin-bottom: 0.5rem;
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
    
    // Get car ID from parameter
    String carIdParam = request.getParameter("id");
    int carId = 0;
    
    try {
        carId = Integer.parseInt(carIdParam);
    } catch (NumberFormatException e) {
        response.sendRedirect("cars.jsp");
        return;
    }
    
    // Get car details
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    String carTitle = "";
    String carBrand = "";
    String carModel = "";
    String carYear = "";
    String carPrice = "";
    String carMileage = "";
    String fuelType = "";
    String transmission = "";
    String bodyType = "";
    String engineSize = "";
    String carColor = "";
    String carCondition = "";
    String carDescription = "";
    String carFeatures = "";
    String carStatus = "";
    String sellerName = "";
    String sellerEmail = "";
    String sellerPhone = "";
    String sellerLocation = "";
    String listingDate = "";
    String carImages = "";
    
    try {
        conn = DataSource.getConnection();
        
        String carQuery = "SELECT cl.*, u.name as seller_name, u.phone as seller_phone, u.location as seller_location " +
                         "FROM car_listings cl JOIN users u ON cl.seller_email = u.email WHERE cl.id = ?";
        pstmt = conn.prepareStatement(carQuery);
        pstmt.setInt(1, carId);
        rs = pstmt.executeQuery();
        
        if (rs.next()) {
            carTitle = rs.getString("title") != null ? rs.getString("title") : "";
            carBrand = rs.getString("brand") != null ? rs.getString("brand") : "";
            carModel = rs.getString("model") != null ? rs.getString("model") : "";
            carYear = rs.getString("year") != null ? rs.getString("year") : "";
            carPrice = rs.getString("price") != null ? rs.getString("price") : "";
            carMileage = rs.getString("mileage") != null ? rs.getString("mileage") : "";
            fuelType = rs.getString("fuel_type") != null ? rs.getString("fuel_type") : "";
            transmission = rs.getString("transmission") != null ? rs.getString("transmission") : "";
            bodyType = rs.getString("body_type") != null ? rs.getString("body_type") : "";
            engineSize = rs.getString("engine_size") != null ? rs.getString("engine_size") : "";
            carColor = rs.getString("color") != null ? rs.getString("color") : "";
            carCondition = rs.getString("condition") != null ? rs.getString("condition") : "";
            carDescription = rs.getString("description") != null ? rs.getString("description") : "";
            carFeatures = rs.getString("features") != null ? rs.getString("features") : "";
            carStatus = rs.getString("status") != null ? rs.getString("status") : "";
            sellerName = rs.getString("seller_name") != null ? rs.getString("seller_name") : "";
            sellerEmail = rs.getString("seller_email") != null ? rs.getString("seller_email") : "";
            sellerPhone = rs.getString("seller_phone") != null ? rs.getString("seller_phone") : "";
            sellerLocation = rs.getString("seller_location") != null ? rs.getString("seller_location") : "";
            listingDate = rs.getString("created_date") != null ? rs.getString("created_date") : "";
            carImages = rs.getString("images") != null ? rs.getString("images") : "";
        } else {
            response.sendRedirect("cars.jsp");
            return;
        }
        
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("cars.jsp");
        return;
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
                    <li class="nav-item">
                        <a class="nav-link" href="about-us.jsp">
                            <i class="fas fa-info-circle"></i> About
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="contact.jsp">
                            <i class="fas fa-phone"></i> Contact
                        </a>
                    </li>
                </ul>
                
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-user-circle"></i> <%=userName != null ? userName : "User"%>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="userProfile.jsp"><i class="fas fa-user"></i> My Profile</a></li>
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

    <!-- Breadcrumb -->
    <div class="container mt-3">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="index.jsp"><i class="fas fa-home"></i> Home</a></li>
                <li class="breadcrumb-item"><a href="cars.jsp">Cars</a></li>
                <li class="breadcrumb-item active"><%=carTitle%></li>
            </ol>
        </nav>
    </div>

    <!-- Car Header -->
    <section class="car-header">
        <div class="container" data-aos="fade-up">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <h1 class="mb-2"><%=carTitle%></h1>
                    <p class="mb-3">
                        <i class="fas fa-calendar"></i> <%=carYear%> •
                        <i class="fas fa-tachometer-alt"></i> <%=carMileage%> km •
                        <i class="fas fa-map-marker-alt"></i> <%=sellerLocation%>
                    </p>
                    <span class="status-badge status-<%=carStatus%>">
                        <%=carStatus.toUpperCase()%>
                    </span>
                </div>
                <div class="col-lg-4 text-lg-end">
                    <div class="price-badge">
                        $<%=carPrice%>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <div class="container">
        <div class="row">
            <!-- Left Column - Images and Details -->
            <div class="col-lg-8">
                <!-- Image Gallery -->
                <div class="car-image-gallery" data-aos="fade-up">
                    <%
                        String[] imageArray = carImages.split(",");
                        String mainImage = imageArray.length > 0 && !imageArray[0].trim().isEmpty() ? 
                                          imageArray[0].trim() : "images/default-car.jpg";
                    %>
                    <img src="<%=mainImage%>" alt="<%=carTitle%>" class="main-image" id="mainImage" 
                         data-lightbox="car-gallery" data-title="<%=carTitle%>">
                    
                    <%if (imageArray.length > 1) {%>
                        <div class="thumbnail-gallery">
                            <%for (int i = 0; i < imageArray.length && i < 6; i++) {
                                String img = imageArray[i].trim();
                                if (!img.isEmpty()) {%>
                                    <img src="<%=img%>" alt="Car Image <%=i+1%>" class="thumbnail <%=i==0?"active":""%>" 
                                         onclick="changeMainImage('<%=img%>')" data-lightbox="car-gallery" data-title="<%=carTitle%>">
                            <%  }
                            }%>
                        </div>
                    <%}%>
                </div>

                <!-- Car Specifications -->
                <div class="car-info-card" data-aos="fade-up" data-aos-delay="100">
                    <div class="p-4">
                        <h3 class="mb-4"><i class="fas fa-cogs"></i> Vehicle Specifications</h3>
                        
                        <div class="spec-grid">
                            <div class="spec-item">
                                <div class="spec-label">Brand</div>
                                <div class="spec-value"><%=carBrand%></div>
                            </div>
                            <div class="spec-item">
                                <div class="spec-label">Model</div>
                                <div class="spec-value"><%=carModel%></div>
                            </div>
                            <div class="spec-item">
                                <div class="spec-label">Year</div>
                                <div class="spec-value"><%=carYear%></div>
                            </div>
                            <div class="spec-item">
                                <div class="spec-label">Mileage</div>
                                <div class="spec-value"><%=carMileage%> km</div>
                            </div>
                            <div class="spec-item">
                                <div class="spec-label">Fuel Type</div>
                                <div class="spec-value"><%=fuelType%></div>
                            </div>
                            <div class="spec-item">
                                <div class="spec-label">Transmission</div>
                                <div class="spec-value"><%=transmission%></div>
                            </div>
                            <%if (!bodyType.isEmpty()) {%>
                                <div class="spec-item">
                                    <div class="spec-label">Body Type</div>
                                    <div class="spec-value"><%=bodyType%></div>
                                </div>
                            <%}%>
                            <%if (!engineSize.isEmpty()) {%>
                                <div class="spec-item">
                                    <div class="spec-label">Engine Size</div>
                                    <div class="spec-value"><%=engineSize%>L</div>
                                </div>
                            <%}%>
                            <%if (!carColor.isEmpty()) {%>
                                <div class="spec-item">
                                    <div class="spec-label">Color</div>
                                    <div class="spec-value"><%=carColor%></div>
                                </div>
                            <%}%>
                            <div class="spec-item">
                                <div class="spec-label">Condition</div>
                                <div class="spec-value"><%=carCondition%></div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Features -->
                <%if (!carFeatures.isEmpty()) {%>
                    <div class="car-info-card" data-aos="fade-up" data-aos-delay="200">
                        <div class="p-4">
                            <h3 class="mb-4"><i class="fas fa-star"></i> Features & Equipment</h3>
                            <div class="features-list">
                                <%
                                    String[] featuresArray = carFeatures.split(",");
                                    for (String feature : featuresArray) {
                                        if (!feature.trim().isEmpty()) {
                                %>
                                            <span class="feature-tag"><%=feature.trim()%></span>
                                <%      }
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                <%}%>

                <!-- Description -->
                <%if (!carDescription.isEmpty()) {%>
                    <div class="description-card" data-aos="fade-up" data-aos-delay="300">
                        <h3 class="mb-3"><i class="fas fa-align-left"></i> Description</h3>
                        <p class="text-muted"><%=carDescription%></p>
                        
                        <div class="mt-4">
                            <small class="text-muted">
                                <i class="fas fa-calendar-alt"></i> Listed on <%=listingDate.substring(0, 10)%>
                            </small>
                        </div>
                    </div>
                <%}%>
            </div>

            <!-- Right Column - Seller Info -->
            <div class="col-lg-4">
                <!-- Seller Information -->
                <div class="seller-card" data-aos="fade-up" data-aos-delay="100">
                    <h4 class="mb-4"><i class="fas fa-user"></i> Seller Information</h4>
                    
                    <div class="d-flex align-items-center mb-4">
                        <img src="images/default-avatar.png" alt="Seller Avatar" class="seller-avatar me-3">
                        <div>
                            <h5 class="mb-1"><%=sellerName%></h5>
                            <p class="text-muted mb-0">
                                <i class="fas fa-map-marker-alt"></i> <%=sellerLocation%>
                            </p>
                        </div>
                    </div>

                    <div class="contact-info mb-4">
                        <%if (!sellerPhone.isEmpty()) {%>
                            <p class="mb-2">
                                <i class="fas fa-phone text-primary"></i> 
                                <a href="tel:<%=sellerPhone%>" class="text-decoration-none"><%=sellerPhone%></a>
                            </p>
                        <%}%>
                        <p class="mb-3">
                            <i class="fas fa-envelope text-primary"></i> 
                            <a href="mailto:<%=sellerEmail%>" class="text-decoration-none"><%=sellerEmail%></a>
                        </p>
                    </div>

                    <div class="d-grid gap-2">
                        <%if (!sellerPhone.isEmpty()) {%>
                            <a href="tel:<%=sellerPhone%>" class="contact-button">
                                <i class="fas fa-phone"></i> Call Seller
                            </a>
                        <%}%>
                        <a href="mailto:<%=sellerEmail%>?subject=Inquiry about <%=carTitle%>&body=Hi, I'm interested in your <%=carTitle%> listed for $<%=carPrice%>. Please provide more details." 
                           class="contact-button">
                            <i class="fas fa-envelope"></i> Send Email
                        </a>
                        <button class="btn btn-outline-primary" onclick="showContactForm()">
                            <i class="fas fa-comment"></i> Send Message
                        </button>
                    </div>

                    <div class="alert alert-info mt-3">
                        <small>
                            <i class="fas fa-shield-alt"></i> 
                            Always meet in a safe public location when buying or selling vehicles.
                        </small>
                    </div>
                </div>

                <!-- Quick Stats -->
                <div class="seller-card" data-aos="fade-up" data-aos-delay="200">
                    <h5 class="mb-3"><i class="fas fa-chart-bar"></i> Quick Stats</h5>
                    
                    <div class="row text-center">
                        <div class="col-6">
                            <h4 class="text-primary"><%=carYear%></h4>
                            <small class="text-muted">Model Year</small>
                        </div>
                        <div class="col-6">
                            <h4 class="text-success"><%=carMileage%></h4>
                            <small class="text-muted">Kilometers</small>
                        </div>
                    </div>
                </div>

                <!-- Safety Tips -->
                <div class="seller-card" data-aos="fade-up" data-aos-delay="300">
                    <h5 class="mb-3"><i class="fas fa-exclamation-triangle text-warning"></i> Safety Tips</h5>
                    <ul class="small text-muted">
                        <li>Always inspect the vehicle in person</li>
                        <li>Verify all documentation</li>
                        <li>Meet in a safe, public location</li>
                        <li>Consider bringing a mechanic</li>
                        <li>Use secure payment methods</li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- Similar Cars -->
        <div class="similar-cars mt-5" data-aos="fade-up">
            <h3 class="mb-4"><i class="fas fa-cars"></i> Similar Cars You Might Like</h3>
            
            <div class="row">
                <%
                    // Get similar cars
                    try {
                        conn = DataSource.getConnection();
                        String similarQuery = "SELECT id, title, price, year, brand, model, image_url FROM car_listings " +
                                             "WHERE brand = ? AND id != ? AND status = 'active' ORDER BY RAND() LIMIT 4";
                        pstmt = conn.prepareStatement(similarQuery);
                        pstmt.setString(1, carBrand);
                        pstmt.setInt(2, carId);
                        rs = pstmt.executeQuery();
                        
                        while (rs.next()) {
                            String simTitle = rs.getString("title");
                            String simPrice = rs.getString("price");
                            String simYear = rs.getString("year");
                            String simImage = rs.getString("image_url");
                            int simId = rs.getInt("id");
                %>
                            <div class="col-md-6 col-lg-3 mb-4">
                                <div class="similar-car-card">
                                    <img src="<%=simImage != null ? simImage : "images/default-car.jpg"%>" 
                                         alt="<%=simTitle%>" class="similar-car-image">
                                    <div class="p-3">
                                        <h6 class="mb-2"><%=simTitle%></h6>
                                        <p class="text-primary fw-bold mb-2">$<%=simPrice%></p>
                                        <p class="small text-muted mb-3"><%=simYear%></p>
                                        <a href="car-details.jsp?id=<%=simId%>" class="btn btn-outline-primary btn-sm w-100">
                                            View Details
                                        </a>
                                    </div>
                                </div>
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

    <!-- Contact Form Modal -->
    <div class="modal fade" id="contactModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Contact Seller</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="contactForm">
                        <div class="mb-3">
                            <label for="senderName" class="form-label">Your Name</label>
                            <input type="text" class="form-control" id="senderName" value="<%=userName%>" required>
                        </div>
                        <div class="mb-3">
                            <label for="senderEmail" class="form-label">Your Email</label>
                            <input type="email" class="form-control" id="senderEmail" value="<%=userEmail%>" required>
                        </div>
                        <div class="mb-3">
                            <label for="senderPhone" class="form-label">Your Phone (Optional)</label>
                            <input type="tel" class="form-control" id="senderPhone">
                        </div>
                        <div class="mb-3">
                            <label for="messageText" class="form-label">Message</label>
                            <textarea class="form-control" id="messageText" rows="4" 
                                      placeholder="I'm interested in your <%=carTitle%>. Please provide more details." required></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" onclick="sendMessage()">
                        <i class="fas fa-paper-plane"></i> Send Message
                    </button>
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
    <script src="https://cdn.jsdelivr.net/npm/lightbox2@2.11.3/dist/js/lightbox.min.js"></script>
    
    <script>
        // Initialize AOS
        AOS.init({
            duration: 600,
            easing: 'ease-in-out',
            once: true
        });

        // Change main image
        function changeMainImage(imageSrc) {
            document.getElementById('mainImage').src = imageSrc;
            
            // Update active thumbnail
            document.querySelectorAll('.thumbnail').forEach(thumb => {
                thumb.classList.remove('active');
            });
            event.target.classList.add('active');
        }

        // Show contact form modal
        function showContactForm() {
            const modal = new bootstrap.Modal(document.getElementById('contactModal'));
            modal.show();
        }

        // Send message
        function sendMessage() {
            const senderName = document.getElementById('senderName').value;
            const senderEmail = document.getElementById('senderEmail').value;
            const senderPhone = document.getElementById('senderPhone').value;
            const messageText = document.getElementById('messageText').value;
            
            if (!senderName || !senderEmail || !messageText) {
                alert('Please fill in all required fields.');
                return;
            }
            
            // Create email link
            const subject = encodeURIComponent('Inquiry about <%=carTitle%>');
            const body = encodeURIComponent(`
                From: ${senderName}
                Email: ${senderEmail}
                Phone: ${senderPhone || 'Not provided'}
                
                Message:
                ${messageText}
                
                Regarding: <%=carTitle%> - $<%=carPrice%>
            `);
            
            const emailLink = `mailto:<%=sellerEmail%>?subject=${subject}&body=${body}`;
            window.location.href = emailLink;
            
            // Close modal
            const modal = bootstrap.Modal.getInstance(document.getElementById('contactModal'));
            modal.hide();
            
            // Show success message
            const alert = document.createElement('div');
            alert.className = 'alert alert-success alert-dismissible fade show position-fixed';
            alert.style.cssText = 'top: 90px; right: 20px; z-index: 9999;';
            alert.innerHTML = `
                <i class="fas fa-check-circle"></i> Email client opened with your message!
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            `;
            document.body.appendChild(alert);
            
            setTimeout(() => {
                if (alert.parentNode) {
                    alert.parentNode.removeChild(alert);
                }
            }, 5000);
        }

        // Initialize lightbox
        lightbox.option({
            'resizeDuration': 200,
            'wrapAround': true,
            'showImageNumberLabel': false,
            'positionFromTop': 100
        });
    </script>
</body>
</html>
