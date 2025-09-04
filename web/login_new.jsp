<%-- 
    Document   : login (Modernized)
    Created on : 28-Apr-2024, 8:44:35 pm
    Author     : Abrarali
    Refactored Version with Bootstrap 5 and Enhanced Security
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Login - CarDeal</title>
    
    <!-- SEO Meta Tags -->
    <meta name="description" content="Login to your CarDeal account to manage your car listings and purchases">
    <meta name="keywords" content="login, car deal, account, signin">
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
        
        .login-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .login-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            max-width: 900px;
            width: 100%;
        }
        
        .login-left {
            background: linear-gradient(45deg, var(--primary-color), #0056b3);
            color: white;
            padding: 3rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
            text-align: center;
        }
        
        .login-right {
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
        
        .social-login {
            border-radius: 10px;
            padding: 0.75rem;
            margin: 0.5rem 0;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .social-login:hover {
            transform: translateY(-2px);
        }
        
        .divider {
            text-align: center;
            margin: 2rem 0;
            position: relative;
        }
        
        .divider::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            height: 1px;
            background: #dee2e6;
        }
        
        .divider span {
            background: white;
            padding: 0 1rem;
            color: #6c757d;
        }
        
        @media (max-width: 768px) {
            .login-left {
                display: none;
            }
            
            .login-right {
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
                        <a class="nav-link" href="userRegister.jsp">
                            <i class="fas fa-user-plus"></i> Register
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="login.jsp">
                            <i class="fas fa-sign-in-alt"></i> Login
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Login Container -->
    <div class="login-container">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <div class="login-card" data-aos="fade-up">
                        <div class="row g-0">
                            <!-- Left Side - Welcome -->
                            <div class="col-lg-6">
                                <div class="login-left">
                                    <div>
                                        <h2 class="fw-bold mb-4">Welcome Back!</h2>
                                        <p class="lead mb-4">
                                            Sign in to access your CarDeal account and manage your car listings.
                                        </p>
                                        <div class="mb-4">
                                            <i class="fas fa-car fa-3x mb-3"></i>
                                            <h5>Your Gateway to Car Deals</h5>
                                        </div>
                                        <p class="mb-0">
                                            Don't have an account?
                                            <br>
                                            <a href="userRegister.jsp" class="text-white text-decoration-none fw-bold">
                                                <i class="fas fa-user-plus"></i> Create Account
                                            </a>
                                        </p>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Right Side - Login Form -->
                            <div class="col-lg-6">
                                <div class="login-right">
                                    <div class="text-center mb-4">
                                        <h3 class="fw-bold text-dark">Sign In</h3>
                                        <p class="text-muted">Enter your credentials to access your account</p>
                                    </div>

                                    <!-- Error/Success Messages -->
                                    <% if (errorMessage != null) { %>
                                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                            <i class="fas fa-exclamation-circle"></i>
                                            <% if ("invalid".equals(errorMessage)) { %>
                                                Invalid username or password. Please try again.
                                            <% } else if ("blocked".equals(errorMessage)) { %>
                                                Your account has been temporarily blocked. Please contact support.
                                            <% } else if ("session".equals(errorMessage)) { %>
                                                Your session has expired. Please log in again.
                                            <% } else { %>
                                                <%= errorMessage %>
                                            <% } %>
                                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                        </div>
                                    <% } %>

                                    <% if (successMessage != null) { %>
                                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                                            <i class="fas fa-check-circle"></i>
                                            <% if ("registered".equals(successMessage)) { %>
                                                Registration successful! Please log in with your credentials.
                                            <% } else if ("logout".equals(successMessage)) { %>
                                                You have been successfully logged out.
                                            <% } else { %>
                                                <%= successMessage %>
                                            <% } %>
                                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                        </div>
                                    <% } %>

                                    <!-- Login Form -->
                                    <form action="LoginServlet" method="post" id="loginForm" novalidate>
                                        <!-- CSRF Token -->
                                        <input type="hidden" name="csrfToken" value="<%= session.getAttribute("csrfToken") != null ? session.getAttribute("csrfToken") : "" %>">
                                        
                                        <div class="mb-3">
                                            <label for="username" class="form-label">
                                                <i class="fas fa-user"></i> Username or Email
                                            </label>
                                            <div class="input-group">
                                                <span class="input-group-text">
                                                    <i class="fas fa-user"></i>
                                                </span>
                                                <input type="text" 
                                                       class="form-control" 
                                                       id="username" 
                                                       name="username" 
                                                       placeholder="Enter your username or email"
                                                       required
                                                       autocomplete="username"
                                                       maxlength="100">
                                            </div>
                                            <div class="invalid-feedback">
                                                Please enter your username or email.
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <label for="password" class="form-label">
                                                <i class="fas fa-lock"></i> Password
                                            </label>
                                            <div class="input-group position-relative">
                                                <span class="input-group-text">
                                                    <i class="fas fa-lock"></i>
                                                </span>
                                                <input type="password" 
                                                       class="form-control" 
                                                       id="password" 
                                                       name="password" 
                                                       placeholder="Enter your password"
                                                       required
                                                       autocomplete="current-password"
                                                       minlength="6"
                                                       maxlength="100">
                                                <span class="password-toggle" onclick="togglePassword()">
                                                    <i class="fas fa-eye" id="toggleIcon"></i>
                                                </span>
                                            </div>
                                            <div class="invalid-feedback">
                                                Password must be at least 6 characters long.
                                            </div>
                                        </div>

                                        <div class="mb-3 form-check">
                                            <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
                                            <label class="form-check-label" for="rememberMe">
                                                Remember me for 30 days
                                            </label>
                                        </div>

                                        <div class="d-grid gap-2 mb-3">
                                            <button type="submit" class="btn btn-primary btn-lg">
                                                <i class="fas fa-sign-in-alt"></i> Sign In
                                            </button>
                                        </div>

                                        <div class="text-center">
                                            <a href="forgot-password.jsp" class="text-decoration-none">
                                                <i class="fas fa-key"></i> Forgot Password?
                                            </a>
                                        </div>
                                    </form>

                                    <!-- Divider -->
                                    <div class="divider">
                                        <span>or continue with</span>
                                    </div>

                                    <!-- Social Login Buttons -->
                                    <div class="row g-2 mb-3">
                                        <div class="col-6">
                                            <button class="btn btn-outline-danger social-login w-100" onclick="alert('Google login not implemented yet')">
                                                <i class="fab fa-google"></i> Google
                                            </button>
                                        </div>
                                        <div class="col-6">
                                            <button class="btn btn-outline-primary social-login w-100" onclick="alert('Facebook login not implemented yet')">
                                                <i class="fab fa-facebook-f"></i> Facebook
                                            </button>
                                        </div>
                                    </div>

                                    <!-- Register Link -->
                                    <div class="text-center">
                                        <p class="text-muted">
                                            New to CarDeal? 
                                            <a href="userRegister.jsp" class="text-decoration-none fw-bold">
                                                Create an account
                                            </a>
                                        </p>
                                    </div>

                                    <!-- Admin Login Link -->
                                    <div class="text-center mt-3">
                                        <small>
                                            <a href="AdminLogin.jsp" class="text-muted text-decoration-none">
                                                <i class="fas fa-user-shield"></i> Admin Login
                                            </a>
                                        </small>
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

        // Form validation
        (function() {
            'use strict';
            
            const form = document.getElementById('loginForm');
            
            form.addEventListener('submit', function(event) {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                
                form.classList.add('was-validated');
            }, false);
        })();

        // Toggle password visibility
        function togglePassword() {
            const passwordField = document.getElementById('password');
            const toggleIcon = document.getElementById('toggleIcon');
            
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
        document.getElementById('loginForm').addEventListener('submit', function() {
            const submitBtn = this.querySelector('button[type="submit"]');
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Signing In...';
            
            // Re-enable after 5 seconds as fallback
            setTimeout(function() {
                submitBtn.disabled = false;
                submitBtn.innerHTML = '<i class="fas fa-sign-in-alt"></i> Sign In';
            }, 5000);
        });

        // Focus on username field when page loads
        window.addEventListener('load', function() {
            document.getElementById('username').focus();
        });

        // Enhanced security: Clear form data on page unload
        window.addEventListener('beforeunload', function() {
            document.getElementById('username').value = '';
            document.getElementById('password').value = '';
        });
    </script>
</body>
</html>
