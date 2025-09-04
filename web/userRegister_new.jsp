<%-- 
    Document   : userRegister (Modernized)
    Created on : 29-Apr-2024, 10:30:00 am
    Author     : Abrarali
    Refactored Version with Bootstrap 5 and Enhanced Validation
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Register - CarDeal</title>
    
    <!-- SEO Meta Tags -->
    <meta name="description" content="Create your CarDeal account to start buying and selling cars">
    <meta name="keywords" content="register, signup, car deal, account, create account">
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .register-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 0;
        }
        
        .register-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            max-width: 1000px;
            width: 100%;
        }
        
        .register-left {
            background: linear-gradient(45deg, var(--primary-color), #0056b3);
            color: white;
            padding: 3rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
            text-align: center;
        }
        
        .register-right {
            padding: 3rem;
        }
        
        .form-control {
            border-radius: 10px;
            border: 2px solid #e9ecef;
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
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
        
        .input-group-text {
            background: transparent;
            border: 2px solid #e9ecef;
            border-right: none;
            border-radius: 10px 0 0 10px;
        }
        
        .input-group .form-control {
            border-left: none;
            border-radius: 0 10px 10px 0;
        }
        
        .navbar-brand {
            font-weight: bold;
            font-size: 1.5rem;
        }
        
        .alert {
            border-radius: 10px;
            border: none;
        }
        
        .password-toggle {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #6c757d;
            z-index: 10;
        }
        
        .password-toggle:hover {
            color: var(--primary-color);
        }
        
        .progress {
            height: 5px;
            border-radius: 10px;
        }
        
        .strength-meter {
            margin-top: 0.5rem;
        }
        
        .step-indicator {
            display: flex;
            justify-content: center;
            margin-bottom: 2rem;
        }
        
        .step {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #e9ecef;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 1rem;
            font-weight: bold;
            transition: all 0.3s ease;
        }
        
        .step.active {
            background: var(--primary-color);
            color: white;
        }
        
        .step.completed {
            background: var(--success-color);
            color: white;
        }
        
        @media (max-width: 768px) {
            .register-left {
                display: none;
            }
            
            .register-right {
                padding: 2rem;
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

        // Check if user is already logged in
        HttpSession userSession = request.getSession(false);
        if (userSession != null && userSession.getAttribute("UserID") != null) {
            response.sendRedirect("index.jsp");
            return;
        }

        // Get error messages
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
                        <a class="nav-link" href="about-us.jsp">
                            <i class="fas fa-info-circle"></i> About
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="contact.jsp">
                            <i class="fas fa-envelope"></i> Contact
                        </a>
                    </li>
                </ul>
                
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link active" href="userRegister.jsp">
                            <i class="fas fa-user-plus"></i> Register
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp">
                            <i class="fas fa-sign-in-alt"></i> Login
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Register Container -->
    <div class="register-container">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-11">
                    <div class="register-card" data-aos="fade-up">
                        <div class="row g-0">
                            <!-- Left Side - Welcome -->
                            <div class="col-lg-5">
                                <div class="register-left">
                                    <div>
                                        <h2 class="fw-bold mb-4">Join CarDeal</h2>
                                        <p class="lead mb-4">
                                            Create your account and start your journey in the automotive marketplace.
                                        </p>
                                        <div class="mb-4">
                                            <i class="fas fa-handshake fa-3x mb-3"></i>
                                            <h5>Connect with Car Enthusiasts</h5>
                                        </div>
                                        <div class="mb-4">
                                            <div class="row text-center">
                                                <div class="col-6">
                                                    <i class="fas fa-shopping-cart fa-2x mb-2"></i>
                                                    <p class="small">Buy Cars</p>
                                                </div>
                                                <div class="col-6">
                                                    <i class="fas fa-tag fa-2x mb-2"></i>
                                                    <p class="small">Sell Cars</p>
                                                </div>
                                            </div>
                                        </div>
                                        <p class="mb-0">
                                            Already have an account?
                                            <br>
                                            <a href="login.jsp" class="text-white text-decoration-none fw-bold">
                                                <i class="fas fa-sign-in-alt"></i> Sign In
                                            </a>
                                        </p>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Right Side - Registration Form -->
                            <div class="col-lg-7">
                                <div class="register-right">
                                    <div class="text-center mb-4">
                                        <h3 class="fw-bold text-dark">Create Account</h3>
                                        <p class="text-muted">Fill in your details to get started</p>
                                    </div>

                                    <!-- Step Indicator -->
                                    <div class="step-indicator">
                                        <div class="step active" id="step1">1</div>
                                        <div class="step" id="step2">2</div>
                                        <div class="step" id="step3">3</div>
                                    </div>

                                    <!-- Error/Success Messages -->
                                    <% if (errorMessage != null) { %>
                                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                            <i class="fas fa-exclamation-circle"></i>
                                            <% if ("exists".equals(errorMessage)) { %>
                                                An account with this username or email already exists.
                                            <% } else if ("validation".equals(errorMessage)) { %>
                                                Please check your input data and try again.
                                            <% } else if ("server".equals(errorMessage)) { %>
                                                Server error occurred. Please try again later.
                                            <% } else { %>
                                                <%= errorMessage %>
                                            <% } %>
                                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                        </div>
                                    <% } %>

                                    <% if (successMessage != null) { %>
                                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                                            <i class="fas fa-check-circle"></i>
                                            <%= successMessage %>
                                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                        </div>
                                    <% } %>

                                    <!-- Registration Form -->
                                    <form action="RegisterServlet" method="post" id="registerForm" novalidate>
                                        <!-- CSRF Token -->
                                        <input type="hidden" name="csrfToken" value="<%= session.getAttribute("csrfToken") != null ? session.getAttribute("csrfToken") : "" %>">
                                        
                                        <!-- Step 1: Basic Information -->
                                        <div class="form-step active" id="formStep1">
                                            <h5 class="mb-3"><i class="fas fa-user"></i> Personal Information</h5>
                                            
                                            <div class="row g-3">
                                                <div class="col-md-6">
                                                    <label for="firstName" class="form-label">First Name</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text">
                                                            <i class="fas fa-user"></i>
                                                        </span>
                                                        <input type="text" 
                                                               class="form-control" 
                                                               id="firstName" 
                                                               name="firstName" 
                                                               placeholder="Enter first name"
                                                               required
                                                               pattern="[A-Za-z\s]{2,50}"
                                                               maxlength="50">
                                                    </div>
                                                    <div class="invalid-feedback">
                                                        Please enter a valid first name (2-50 characters, letters only).
                                                    </div>
                                                </div>

                                                <div class="col-md-6">
                                                    <label for="lastName" class="form-label">Last Name</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text">
                                                            <i class="fas fa-user"></i>
                                                        </span>
                                                        <input type="text" 
                                                               class="form-control" 
                                                               id="lastName" 
                                                               name="lastName" 
                                                               placeholder="Enter last name"
                                                               required
                                                               pattern="[A-Za-z\s]{2,50}"
                                                               maxlength="50">
                                                    </div>
                                                    <div class="invalid-feedback">
                                                        Please enter a valid last name (2-50 characters, letters only).
                                                    </div>
                                                </div>

                                                <div class="col-12">
                                                    <label for="email" class="form-label">Email Address</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text">
                                                            <i class="fas fa-envelope"></i>
                                                        </span>
                                                        <input type="email" 
                                                               class="form-control" 
                                                               id="email" 
                                                               name="email" 
                                                               placeholder="Enter your email"
                                                               required
                                                               maxlength="100">
                                                    </div>
                                                    <div class="invalid-feedback">
                                                        Please enter a valid email address.
                                                    </div>
                                                </div>

                                                <div class="col-12">
                                                    <label for="phone" class="form-label">Phone Number</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text">
                                                            <i class="fas fa-phone"></i>
                                                        </span>
                                                        <input type="tel" 
                                                               class="form-control" 
                                                               id="phone" 
                                                               name="phone" 
                                                               placeholder="Enter phone number"
                                                               required
                                                               pattern="[0-9+\-\s\(\)]{10,15}"
                                                               maxlength="15">
                                                    </div>
                                                    <div class="invalid-feedback">
                                                        Please enter a valid phone number (10-15 digits).
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="d-grid gap-2 mt-4">
                                                <button type="button" class="btn btn-primary" onclick="nextStep(2)">
                                                    Next Step <i class="fas fa-arrow-right"></i>
                                                </button>
                                            </div>
                                        </div>

                                        <!-- Step 2: Account Information -->
                                        <div class="form-step" id="formStep2" style="display: none;">
                                            <h5 class="mb-3"><i class="fas fa-key"></i> Account Security</h5>
                                            
                                            <div class="row g-3">
                                                <div class="col-12">
                                                    <label for="username" class="form-label">Username</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text">
                                                            <i class="fas fa-at"></i>
                                                        </span>
                                                        <input type="text" 
                                                               class="form-control" 
                                                               id="username" 
                                                               name="username" 
                                                               placeholder="Choose a username"
                                                               required
                                                               pattern="[A-Za-z0-9_]{3,30}"
                                                               maxlength="30">
                                                    </div>
                                                    <div class="form-text">Username must be 3-30 characters (letters, numbers, underscore only)</div>
                                                    <div class="invalid-feedback">
                                                        Please enter a valid username (3-30 characters, alphanumeric and underscore only).
                                                    </div>
                                                </div>

                                                <div class="col-12">
                                                    <label for="password" class="form-label">Password</label>
                                                    <div class="input-group position-relative">
                                                        <span class="input-group-text">
                                                            <i class="fas fa-lock"></i>
                                                        </span>
                                                        <input type="password" 
                                                               class="form-control" 
                                                               id="password" 
                                                               name="password" 
                                                               placeholder="Create a strong password"
                                                               required
                                                               minlength="8"
                                                               maxlength="100"
                                                               oninput="checkPasswordStrength()">
                                                        <span class="password-toggle" onclick="togglePassword('password')">
                                                            <i class="fas fa-eye" id="toggleIcon1"></i>
                                                        </span>
                                                    </div>
                                                    <div class="strength-meter">
                                                        <div class="progress">
                                                            <div class="progress-bar" id="strengthBar" role="progressbar" style="width: 0%"></div>
                                                        </div>
                                                        <div class="form-text" id="strengthText">Password strength will be shown here</div>
                                                    </div>
                                                    <div class="invalid-feedback">
                                                        Password must be at least 8 characters long.
                                                    </div>
                                                </div>

                                                <div class="col-12">
                                                    <label for="confirmPassword" class="form-label">Confirm Password</label>
                                                    <div class="input-group position-relative">
                                                        <span class="input-group-text">
                                                            <i class="fas fa-lock"></i>
                                                        </span>
                                                        <input type="password" 
                                                               class="form-control" 
                                                               id="confirmPassword" 
                                                               name="confirmPassword" 
                                                               placeholder="Confirm your password"
                                                               required
                                                               oninput="checkPasswordMatch()">
                                                        <span class="password-toggle" onclick="togglePassword('confirmPassword')">
                                                            <i class="fas fa-eye" id="toggleIcon2"></i>
                                                        </span>
                                                    </div>
                                                    <div class="invalid-feedback" id="passwordMismatch">
                                                        Passwords do not match.
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="row mt-4">
                                                <div class="col-6">
                                                    <button type="button" class="btn btn-outline-secondary w-100" onclick="previousStep(1)">
                                                        <i class="fas fa-arrow-left"></i> Previous
                                                    </button>
                                                </div>
                                                <div class="col-6">
                                                    <button type="button" class="btn btn-primary w-100" onclick="nextStep(3)">
                                                        Next Step <i class="fas fa-arrow-right"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Step 3: Additional Information -->
                                        <div class="form-step" id="formStep3" style="display: none;">
                                            <h5 class="mb-3"><i class="fas fa-info-circle"></i> Additional Details</h5>
                                            
                                            <div class="row g-3">
                                                <div class="col-md-6">
                                                    <label for="dateOfBirth" class="form-label">Date of Birth</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text">
                                                            <i class="fas fa-calendar"></i>
                                                        </span>
                                                        <input type="date" 
                                                               class="form-control" 
                                                               id="dateOfBirth" 
                                                               name="dateOfBirth" 
                                                               required
                                                               max="<%= java.time.LocalDate.now().minusYears(16) %>">
                                                    </div>
                                                    <div class="form-text">Must be at least 16 years old</div>
                                                    <div class="invalid-feedback">
                                                        Please enter a valid date of birth.
                                                    </div>
                                                </div>

                                                <div class="col-md-6">
                                                    <label for="gender" class="form-label">Gender</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text">
                                                            <i class="fas fa-user"></i>
                                                        </span>
                                                        <select class="form-select" id="gender" name="gender">
                                                            <option value="">Select Gender</option>
                                                            <option value="Male">Male</option>
                                                            <option value="Female">Female</option>
                                                            <option value="Other">Other</option>
                                                            <option value="Prefer not to say">Prefer not to say</option>
                                                        </select>
                                                    </div>
                                                </div>

                                                <div class="col-12">
                                                    <label for="address" class="form-label">Address</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text">
                                                            <i class="fas fa-map-marker-alt"></i>
                                                        </span>
                                                        <textarea class="form-control" 
                                                                  id="address" 
                                                                  name="address" 
                                                                  rows="3" 
                                                                  placeholder="Enter your full address"
                                                                  maxlength="500"></textarea>
                                                    </div>
                                                    <div class="form-text">Optional - helps us serve you better</div>
                                                </div>

                                                <div class="col-12">
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="checkbox" id="agreeTerms" name="agreeTerms" required>
                                                        <label class="form-check-label" for="agreeTerms">
                                                            I agree to the <a href="#" target="_blank">Terms of Service</a> and 
                                                            <a href="#" target="_blank">Privacy Policy</a>
                                                        </label>
                                                        <div class="invalid-feedback">
                                                            You must agree to the terms and conditions.
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-12">
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="checkbox" id="newsletter" name="newsletter">
                                                        <label class="form-check-label" for="newsletter">
                                                            Subscribe to our newsletter for car deals and updates
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="row mt-4">
                                                <div class="col-6">
                                                    <button type="button" class="btn btn-outline-secondary w-100" onclick="previousStep(2)">
                                                        <i class="fas fa-arrow-left"></i> Previous
                                                    </button>
                                                </div>
                                                <div class="col-6">
                                                    <button type="submit" class="btn btn-success w-100">
                                                        <i class="fas fa-user-plus"></i> Create Account
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>

                                    <!-- Login Link -->
                                    <div class="text-center mt-4">
                                        <p class="text-muted">
                                            Already have an account? 
                                            <a href="login.jsp" class="text-decoration-none fw-bold">
                                                Sign in here
                                            </a>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
    
    <script>
        // Initialize AOS
        AOS.init({
            duration: 1000,
            easing: 'ease-in-out',
            once: true
        });

        let currentStep = 1;

        // Form validation
        (function() {
            'use strict';
            
            const form = document.getElementById('registerForm');
            
            form.addEventListener('submit', function(event) {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                
                form.classList.add('was-validated');
            }, false);
        })();

        // Step navigation
        function nextStep(step) {
            if (validateCurrentStep()) {
                document.getElementById('formStep' + currentStep).style.display = 'none';
                document.getElementById('step' + currentStep).classList.remove('active');
                document.getElementById('step' + currentStep).classList.add('completed');
                
                currentStep = step;
                document.getElementById('formStep' + currentStep).style.display = 'block';
                document.getElementById('step' + currentStep).classList.add('active');
            }
        }

        function previousStep(step) {
            document.getElementById('formStep' + currentStep).style.display = 'none';
            document.getElementById('step' + currentStep).classList.remove('active');
            
            currentStep = step;
            document.getElementById('formStep' + currentStep).style.display = 'block';
            document.getElementById('step' + currentStep).classList.add('active');
            document.getElementById('step' + currentStep).classList.remove('completed');
        }

        function validateCurrentStep() {
            const currentStepElement = document.getElementById('formStep' + currentStep);
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

            return isValid;
        }

        // Toggle password visibility
        function togglePassword(fieldId) {
            const passwordField = document.getElementById(fieldId);
            const toggleIcon = fieldId === 'password' ? document.getElementById('toggleIcon1') : document.getElementById('toggleIcon2');
            
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                passwordField.type = 'password';
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        }

        // Password strength checker
        function checkPasswordStrength() {
            const password = document.getElementById('password').value;
            const strengthBar = document.getElementById('strengthBar');
            const strengthText = document.getElementById('strengthText');
            
            let strength = 0;
            let feedback = [];

            // Length check
            if (password.length >= 8) strength += 1;
            else feedback.push('at least 8 characters');

            // Uppercase check
            if (/[A-Z]/.test(password)) strength += 1;
            else feedback.push('uppercase letter');

            // Lowercase check
            if (/[a-z]/.test(password)) strength += 1;
            else feedback.push('lowercase letter');

            // Number check
            if (/\d/.test(password)) strength += 1;
            else feedback.push('number');

            // Special character check
            if (/[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(password)) strength += 1;
            else feedback.push('special character');

            // Update strength bar
            const percentage = (strength / 5) * 100;
            strengthBar.style.width = percentage + '%';

            if (strength <= 2) {
                strengthBar.className = 'progress-bar bg-danger';
                strengthText.textContent = 'Weak - Add: ' + feedback.slice(0, 2).join(', ');
            } else if (strength <= 3) {
                strengthBar.className = 'progress-bar bg-warning';
                strengthText.textContent = 'Fair - Add: ' + feedback.slice(0, 1).join(', ');
            } else if (strength <= 4) {
                strengthBar.className = 'progress-bar bg-info';
                strengthText.textContent = 'Good - Almost there!';
            } else {
                strengthBar.className = 'progress-bar bg-success';
                strengthText.textContent = 'Excellent password strength!';
            }
        }

        // Password match checker
        function checkPasswordMatch() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const confirmField = document.getElementById('confirmPassword');

            if (password !== confirmPassword) {
                confirmField.setCustomValidity('Passwords do not match');
                confirmField.classList.add('is-invalid');
            } else {
                confirmField.setCustomValidity('');
                confirmField.classList.remove('is-invalid');
                if (confirmPassword.length > 0) {
                    confirmField.classList.add('is-valid');
                }
            }
        }

        // Auto-hide alerts after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                if (alert.classList.contains('alert-dismissible')) {
                    const bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                }
            });
        }, 5000);

        // Prevent multiple form submissions
        document.getElementById('registerForm').addEventListener('submit', function() {
            const submitBtn = this.querySelector('button[type="submit"]');
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Creating Account...';
            
            // Re-enable after 10 seconds as fallback
            setTimeout(function() {
                submitBtn.disabled = false;
                submitBtn.innerHTML = '<i class="fas fa-user-plus"></i> Create Account';
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

        // Focus on first field when page loads
        window.addEventListener('load', function() {
            document.getElementById('firstName').focus();
        });
    </script>
</body>
</html>
