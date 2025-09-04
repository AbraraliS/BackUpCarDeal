<%-- 
    Document   : car-details
    Created on : 02-May-2024, 10:09:59 pm
    Author     : Abrarali
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <<title>Car Deal </title>
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

    </head>
    <body id="top" data-spy="scroll" data-target=".navbar-collapse" data-offset="50">

           <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
             if (session.getAttribute("UserID") == null) {
                response.sendRedirect("login");
            }
            session = request.getSession();
            String name = (String) session.getAttribute("Username");
            
       
        %>
        <!-- PRE LOADER -->
        <section class="preloader">
            <div class="spinner">

                <span class="spinner-rotate"></span>

            </div>
        </section>


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
                        <li><a href="index.jsp">Home</a></li>
                        <li class="active"><a href="cars.jsp">Buy Cars</a></li>
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
                            if (session.getAttribute("UserID") == null) {
                                out.println("<a href=userRegister.jsp class=ulaa1> <img src=icons/usericon.png height=14px width=14px >Register</a>");
                                out.println("<a href=login.jsp class=ulaa2> <img src=icons/usericon.png height=14px width=14px >Login</a>");
                                out.println("<a href=# >SUBSCRIBE</a>");
                            } else {
                                out.println("<img src=icons/user2icon.png  height=14px width=14px >" + "Welcome " + name);
                                out.println("<a href=userProfile.jsp class=ulaa1><img src=icons/user2icon.png height=14px width=14px>Profile</a>");
                                out.println("<a href=logout class=ulaa3><img src=icons/usericon.png height=14px width=14px >Logout</a>");
                            }
                        %>

                    </div>

                </div>
        </section>

        <section>
            <div class="container">
                <div class="row">
                    <div class="col-md-6 col-xs-12">
                        <div>
                            <img src="image/i10.webp" alt="" class="img-responsive wc-image">
                        </div>

                        <br>

                        <div class="row">
                            <div class="col-sm-4 col-xs-6">
                                <div>
                                    <img src="image/i10.webp" alt="" class="img-responsive">
                                </div>

                                <br>
                            </div>

                            <div class="col-sm-4 col-xs-6">
                                <div>
                                    <img src="images/product-1-720x480.jpg" alt="" class="img-responsive">
                                </div>

                                <br>
                            </div>

                            <div class="col-sm-4 col-xs-6">
                                <div>
                                    <img src="images/product-4-720x480.jpg" alt="" class="img-responsive">
                                </div>

                                <br>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 col-xs-12">
                        <form action="#" method="post" class="form">
                            <h2>Hyundai Nios</h2>

                            <p class="lead">ABS, Leather seats, Power Assisted Steering, Electric heated seats, New HU and AU, Xenon headlights</p>

                            <p class="lead"><small><del> ₹321999.00</del></small> <strong class="text-primary">₹310779.00</strong></p>

                            <div class="row">
                                <div class="col-md-4 col-sm-6">
                                    <p>
                                        <span>Type</span>

                                        <br>

                                        <strong>Used vehicle</strong>
                                    </p>
                                </div>

                                <div class="col-md-4 col-sm-6">
                                    <p>
                                        <span>Make</span>

                                        <br>

                                        <strong>Hyundai</strong>
                                    </p>
                                </div>

                                <div class="col-md-4 col-sm-6">
                                    <p>
                                        <span> Model</span>

                                        <br>

                                        <strong>Nios</strong>
                                    </p>
                                </div>

                                <div class="col-md-4 col-sm-6">
                                    <p>
                                        <span>First registration</span>

                                        <br>

                                        <strong>05/2010</strong>
                                    </p>
                                </div>

                                <div class="col-md-4 col-sm-6">
                                    <p>
                                        <span>Mileage</span>

                                        <br>

                                        <strong>5000 km</strong>
                                    </p>
                                </div>

                                <div class="col-md-4 col-sm-6">
                                    <p>
                                        <span>Fuel</span>

                                        <br>

                                        <strong>Diesel</strong>
                                    </p>
                                </div>

                                <div class="col-md-4 col-sm-6">
                                    <p>
                                        <span>Engine size</span>

                                        <br>

                                        <strong>1800 cc</strong>
                                    </p>
                                </div>

                                <div class="col-md-4 col-sm-6">
                                    <p>
                                        <span>Power</span>

                                        <br>

                                        <strong>85 hp</strong>
                                    </p>
                                </div>


                                <div class="col-md-4 col-sm-6">
                                    <p>
                                        <span>Gearbox</span>

                                        <br>

                                        <strong>Manual</strong>
                                    </p>
                                </div>

                                <div class="col-md-4 col-sm-6">
                                    <p>
                                        <span>Number of seats</span>

                                        <br>

                                        <strong>4</strong>
                                    </p>
                                </div>

                                <div class="col-md-4 col-sm-6">
                                    <p>
                                        <span>Doors</span>

                                        <br>

                                        <strong>2/3</strong>
                                    </p>
                                </div>

                                <div class="col-md-4 col-sm-6">
                                    <p>
                                        <span>Color</span>

                                        <br>

                                        <strong>Black</strong>
                                    </p>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-8 col-xs-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4>Vehicle Description</h4>
                            </div>

                            <div class="panel-body">
                                <p>- Colour coded bumpers<br>- Tinted glass<br>- Immobiliser<br>- Central locking - remote<br>- Passenger airbag<br>- Electric windows<br>- Rear head rests<br>- Radio<br>- CD player<br>- Ideal first car<br>- Warranty<br>- High level brake light<br>Toyota Corolla, with color coded bumpers and tinted glass, comes equipped with an immobiliser and remote central locking for added security. It features a passenger airbag, electric windows, and rear head rests for comfort and safety. The car includes a radio and CD player for entertainment, making it an ideal first car. It also comes with a warranty and a high level brake light for added peace of mind.</p>
 </div>
                        </div>
                    </div>

                    <div class="col-lg-4 col-xs-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4>Contact Details</h4>
                            </div>

                            <div class="panel-body">
                                <p>
                                    <span>Name</span>

                                    <br>

                                    <strong>Niraj Kumar</strong>
                                </p>

                                <p>
                                    <span>Phone</span>

                                    <br>

                                    <strong><a href="tel:123-456-789">7203957888</a></strong>
                                </p>


                                <p>
                                    <span>Mobile phone</span>

                                    <br>

                                    <strong><a href="tel:456789123">+91 8271678912</a></strong>
                                </p>

                                <p>
                                    <span>Email</span>

                                    <br>

                                    <strong><a href="mailto:john@carsales.com">niraj@gmail.com</a></strong>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

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