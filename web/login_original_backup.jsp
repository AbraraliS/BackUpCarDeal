<%-- Document : login Created on : 28-Apr-2024, 8:44:35 pm Author : Abrarali --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html>

        <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=Edge">
        <meta name="description" content="">
        <meta name="keywords" content="">
        <meta name="author" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/font-awesome.min.css">
        <link rel="stylesheet" href="css/owl.carousel.css">
        <link rel="stylesheet" href="css/owl.theme.default.min.css">
        <!-- MAIN CSS -->
        <link rel="stylesheet" href="css/style.css">

            <title>Login Page</title>
            <style>
                .contant1{
                    align-items: center;
                    margin-top: 2.5%;
                }
                /* Bordered form */
                .form1 {
                    border: 3px solid #f1f1f1;
                    max-width: 30%;
                    margin: 0 auto;
                    padding: 20px;
                  
                }

                /* Full-width inputs */
                .inpt {
                   
                    width: 100%;
                    padding: 12px 20px;
                    margin: 8px 0;
                    display: inline-block;
                    border: 1px solid #ccc;
                    box-sizing: border-box;
                }

                /* Set a style for the login button */
                .btn {
                    background-color: #04AA6D;
                    color: white;
                    padding: 14px 20px;
                    margin: 8px 0;
                    border: none;
                    cursor: pointer;
                    width: 100%;
                }

                /* Add a hover effect for buttons */
                .btn:hover {
                    opacity: 0.8;
                }

                /* Center the avatar image inside this container */
                .imgcontainer {
                    text-align: center;
                    margin: 24px 0 12px 0;
                }

                /* Avatar image */
                img.avatar {
                    width: 30%;
                    border-radius: 50%;
                }

                /* Add padding to containers */
                .container1 {
                    padding: 16px;
                }

                /* The "Forgot password" text */
                span.psw {
/*                    float: right;*/
                    padding-top: 16px;
                    gap: 5px;
                }

                .newacc {
                    border: 3px solid #f1f1f1;
                    max-width: 30%;
                    margin: 0 auto;
                    padding: 20px;
                    cursor: pointer;
                }

                .newacc a {
                    text-decoration: none;
                    color: black;
                    font-weight: bold;
                    font-family: Verdana, Geneva, Tahoma, sans-serif;
                }
                .newacc button{
                    padding: 2% 30%;
                }
                .newacc:hover {
                    opacity: 0.8;
                    color: black;
                }

                /* Change styles for span and cancel button on extra small screens */
                @media only screen and (max-width: 992px){
                    span.psw {
                        display: block;
                        float: none;
                    }
                     .form1 {
                         min-width: 100%;
                }
                .inpt,.btn{
                    min-width: 100%;
                }
                .newacc{
                    min-width: 100%;
                }
                }
            </style>
        </head>

        <body>
            
                <!-- MENU -->
        <section class="navbar custom-navbar navbar-fixed-top" role="navigation">
            <div class="container">

                <div class="navbar-header">
                    <button class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="icon icon-bar"></span>
                        <span class="icon icon-bar"></span>
                        <span class="icon icon-bar"></span>
                    </button>

                    <!-- lOGO TEXT HERE -->
                    <a href="#" class="navbar-brand">Car Deal</a>
                </div>

                <!-- MENU LINKS -->
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav navbar-nav-first">
                        <li class="active"><a href="index.jsp">Home</a></li>
                        <li><a href="cars.jsp">Buy Cars</a></li>
                       <li><a href="SellCar2.jsp">Sell Cars</a></li>
                        <li><a href="about-us.jsp">About Us</a></li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">More <span class="caret"></span></a>

                            <ul class="dropdown-menu">
                                <li><a href="blog-posts.jsp">Blog</a></li>
                                <li><a href="team.jsp">Team</a></li>
                                <li><a href="testimonials.jsp">Testimonials</a></li>
                            </ul>
                        </li>
                        <li><a href="contact.jsp">Contact Us</a></li>

                    </ul>
                    <div class="ulright" style="margin-left: 50vw; display: flex; justify-content: space-between;">
                        <%
//                            if (session.getAttribute("UserID") == null) {
//                                out.println("<a href=userRegister.jsp class=ulaa1> <img src=icons/usericon.png height=14px width=14px >Register</a>");
//                                out.println("<a href=login.jsp class=ulaa2> <img src=icons/usericon.png height=14px width=14px >Login</a>");
//                                out.println("<a href=# >SUBSCRIBE</a>");
//                            } else {
//                                out.println("<img src=icons/user2icon.png  height=14px width=14px >" + "Welcome " + name);
//                                out.println("<a href=userProfile.jsp class=ulaa1><img src=icons/user2icon.png height=14px width=14px>Profile</a>");
//                                out.println("<a href=logout class=ulaa3><img src=icons/usericon.png height=14px width=14px >Logout</a>");
//                            }
                        %>

                    </div>

                </div>
        </section> 
            <div class="contant1">
                <form action="login" method="POST" class="form1">
                    <div class="imgcontainer">
                        <img src="icons/usericon.png" alt="Avatar" class="avatar">
                    </div>
                    <div class="container1">
                        <label for="uname"><b>E-Mail</b></label><br>
                        <input type="text" class="inpt" placeholder="Enter Email ID" name="email" required><br>
                        <label for="psw"><b>Password</b></label><br>
                        <input type="password" class="inpt" placeholder="Enter Password" name="password" required><br>
                        <button type="submit" class="btn" id="signup">Login</button><br>
                        <label>
                            <input type="checkbox" checked="checked" name="remember"> Remember me
                        </label>
                    </div>
                    <div class="container1" style="background-color:#f1f1f1;">
                        <span class="psw">Forgot <a href="#">password?</a></span>

                    </div>
                </form>
                <div class="newacc">
                    <a href="userRegister.jsp" class="newacca"> <Button >Create Your CarDeal Account</Button></a>
                </div>
            </div>
                        
          <!-- FOOTER -->
        <footer id="footer">
            <div class="container">
                <div class="row">

                    <div class="col-md-4 col-sm-6">
                        <div class="footer-info">
                            <div class="section-title">
                                <h2>Headquarter</h2>
                            </div>
                            <address>
                                <p>Palanpur <br>BanasKantha, Gujarat,India</p>
                            </address>

                            <ul class="social-icon">
                                <li><a href="#" class="fa fa-facebook-square" attr="facebook icon"></a></li>
                                <li><a href="#" class="fa fa-twitter"></a></li>
                                <li><a href="#" class="fa fa-instagram"></a></li>
                            </ul>

                            <div class="copyright-text"> 
                                <p>Copyright &copy; 2024 CarDeal.com</p>
                                <p>Created by: <a href="#">Abrarali Sunasara</a></p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4 col-sm-6">
                        <div class="footer-info">
                            <div class="section-title">
                                <h2>Contact Info</h2>
                            </div>
                            <address>
                                <p>+91 7203957429</p>
                                <p><a href="mailto:cardeal@company.com">cardeal@gmail.com</a></p>
                            </address>

                            <div class="footer_menu">
                                <h2>Quick Links</h2>
                                <ul>
                                    <li><a href="index.jsp">Home</a></li>
                                    <li><a href="about-us.jsp">About Us</a></li>
                                    <li><a href="terms.jsp">Terms & Conditions</a></li>
                                    <li><a href="contact.jsp">Contact Us</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4 col-sm-12">
                        <div class="footer-info newsletter-form">
                            <div class="section-title">
                                <h2>Newsletter Signup</h2>
                            </div>
                            <div>
                                <div class="form-group">
                                    <form action="#" method="get">
                                        <input type="email" class="form-control" placeholder="Enter your email" name="email" id="email" required>
                                        <input type="submit" class="form-control" name="submit" id="form-submit" value="Send me">
                                    </form>
                                    <span><sup>*</sup> Please note - we do not spam your email.</span>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </footer>
        <!-- SCRIPTS -->
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/smoothscroll.js"></script>
        <script src="js/custom.js"></script>

        </body>

        </html>