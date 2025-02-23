<%-- 
    Document   : index
    Created on : 02-May-2024, 9:51:17 pm
    Author     : Abrarali
--%>

<%@page import="carsellbuy.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Car Deal</title>
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
        <title>Car Deal</title>
    </head>
    <body id="top" data-spy="scroll" data-target=".navbar-collapse" data-offset="50">
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

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
                            if (session.getAttribute("UserID") == null) {
                                out.println("<a href=userRegister.jsp class=ulaa1> <img src=icons/usericon.png height=14px width=14px >Register</a>");
                                out.println("<a href=login.jsp class=ulaa2> <img src=icons/usericon.png height=14px width=14px >Login</a>");
                                out.println("<a href=Subscribe.jsp >SUBSCRIBE</a>");
                            } else {
                                out.println("<img src=icons/user2icon.png  height=14px width=14px >" + "Welcome " + name);
                                out.println("<a href=userProfile.jsp class=ulaa1><img src=icons/user2icon.png height=14px width=14px>Profile</a>");
                                out.println("<a href=logout class=ulaa3><img src=icons/usericon.png height=14px width=14px >Logout</a>");
                            }
                        %>

                    </div>

                </div>
        </section>

        <!-- HOME -->
        <section id="home">
            <div class="row">
                <div class="owl-carousel owl-theme home-slider">
                    <div class="item item-first">
                        <div class="caption">
                            <div class="container">
                                <div class="col-md-6 col-sm-12">
                                    <h1>Buy and Sell Old Cars with Ease</h1>
                                    <h3>Unlock access to our exclusive collection of vintage automobiles. Join our subscription service today!</h3>
                                    <a href="cars.jsp" class="section-btn btn btn-default">Subscribe Now</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="item item-second">
                        <div class="caption">
                            <div class="container">
                                <div class="col-md-6 col-sm-12">
                                    <h1>Discover Classic Cars</h1>
                                    <h3>Explore our curated selection of classic cars from renowned brands. Subscription required for access.</h3>
                                    <a href="cars.jsp" class="section-btn btn btn-default">Browse Cars</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="item item-third">
                        <div class="caption">
                            <div class="container">
                                <div class="col-md-6 col-sm-12">
                                    <h1>Unlock Premium Features</h1>
                                    <h3>Upgrade to our subscription plan to unlock advanced search options and seller privileges.</h3>
                                    <a href="cars.jsp" class="section-btn btn btn-default">Subscribe Now</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <main>


            <section>
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="section-title text-center">
                                <h2>Featured Cars <small>Explore our latest offerings.</small></h2>
                            </div>
                        </div>
          <%
                                DbConnection db = new DbConnection();
                                Connection conn = db.makeConnection();
                                try {
                                    String query = "SELECT * FROM cars2";
                                    PreparedStatement stmt = conn.prepareStatement(query);
                                    ResultSet rs = stmt.executeQuery();
                                    int i = 1;
                                    while (rs.next()) {
                                        String carid = rs.getString("Car2ID");
                                        String carname = rs.getString("car2Name");
                                        String regyer = rs.getString("Reg2Year");
                                        String price = rs.getString("Price2");
                                        String kmdrive = rs.getString("KM2Driven");
                                        String brandname = rs.getString("CarBrand2");
                                        String model = rs.getString("Model2");
                                        String photo = rs.getString("Photos2");
                            %>
                        <div class="col-md-4 col-sm-4">
                            <div class="courses-thumb courses-thumb-secondary">
                                <div class="courses-top">
                                    <div class="courses-image">
                                        <img src="<%=photo%>" class="img-responsive" style="max-height:220px; width:520px;" alt="">
                                    </div>
                                    <div class="courses-date">
                                        <span title="Author"><i class="fa fa-dashboard"></i> <%=kmdrive%></span>
                                        <span title="Author"><i class="fa fa-cube"></i> 1800cc</span>
                                        <span title="Views"><i class="fa fa-cog"></i> Manual</span>
                                    </div>
                                </div>

                                <div class="courses-detail">
                                    <h3><a href="car-details.jsp"><%=brandname%> <%=model%></a></h3>

                                    <p class="lead"><small><del>₹<%=price%></del></small> <strong>₹<%=price%></strong></p>

                                    <p>190 hp &nbsp;&nbsp;/&nbsp;&nbsp; Petrol &nbsp;&nbsp;/&nbsp;&nbsp; <%=regyer%> &nbsp;&nbsp;/&nbsp;&nbsp; Used vehicle</p>
                                </div>

                                <div class="courses-info">
                                    <a href="car-details.jsp" class="section-btn btn btn-primary btn-block">View More</a>
                                </div>
                            </div>
                        </div>
                        <%
                                        i = i + 1;
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                    out.println("Error: " + e.getMessage());
                                }

                            %>

<!--                        <div class="col-md-4 col-sm-4">
                            <div class="courses-thumb courses-thumb-secondary">
                                <div class="courses-top">
                                    <div class="courses-image">
                                        <img src="images/product-2-720x480.jpg" class="img-responsive" alt="">
                                    </div>
                                    <div class="courses-date">
                                        <span title="Author"><i class="fa fa-dashboard"></i> 95,000km</span>
                                        <span title="Author"><i class="fa fa-cube"></i> 2200cc</span>
                                        <span title="Views"><i class="fa fa-cog"></i> Automatic</span>
                                    </div>
                                </div>

                                <div class="courses-detail">
                                    <h3><a href="car-details.jsp">Honda Accord</a></h3>

                                    <p class="lead"><small><del> $14199.00</del></small> <strong>$11179.00</strong></p>

                                    <p>190 hp &nbsp;&nbsp;/&nbsp;&nbsp; Petrol &nbsp;&nbsp;/&nbsp;&nbsp; 2017 &nbsp;&nbsp;/&nbsp;&nbsp; Used vehicle</p>
                                </div>

                                <div class="courses-info">
                                    <a href="car-details.jsp" class="section-btn btn btn-primary btn-block">View More</a>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4 col-sm-4">
                            <div class="courses-thumb courses-thumb-secondary">
                                <div class="courses-top">
                                    <div class="courses-image">
                                        <img src="images/product-3-720x480.jpg" class="img-responsive" alt="">
                                    </div>
                                    <div class="courses-date">
                                        <span title="Author"><i class="fa fa-dashboard"></i> 30 000km</span>
                                        <span title="Author"><i class="fa fa-cube"></i> 2500cc</span>
                                        <span title="Views"><i class="fa fa-cog"></i> Manual</span>
                                    </div>
                                </div>

                                <div class="courses-detail">
                                    <h3><a href="car-details.jsp">Ford Mustang</a></h3>

                                    <p class="lead"><small><del> $11199.00</del></small> <strong>$12179.00</strong></p>

                                    <p>190 hp &nbsp;&nbsp;/&nbsp;&nbsp; Petrol &nbsp;&nbsp;/&nbsp;&nbsp; 2014 &nbsp;&nbsp;/&nbsp;&nbsp; Used vehicle</p>
                                </div>

                                <div class="courses-info">
                                    <a href="car-details.jsp" class="section-btn btn btn-primary btn-block">View More</a>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4 col-sm-4">
                            <div class="courses-thumb courses-thumb-secondary">
                                <div class="courses-top">
                                    <div class="courses-image">
                                        <img src="images/product-4-720x480.jpg" class="img-responsive" alt="">
                                    </div>
                                    <div class="courses-date">
                                        <span title="Author"><i class="fa fa-dashboard"></i> 110 000km</span>
                                        <span title="Author"><i class="fa fa-cube"></i> 1400cc</span>
                                        <span title="Views"><i class="fa fa-cog"></i> Manual</span>
                                    </div>
                                </div>

                                <div class="courses-detail">
                                    <h3><a href="car-details.jsp">Tata Max</a></h3>

                                    <p class="lead"><small><del> $11199.00</del></small> <strong>$12199.00</strong></p>

                                    <p>190 hp &nbsp;&nbsp;/&nbsp;&nbsp; Petrol &nbsp;&nbsp;/&nbsp;&nbsp; 2013 &nbsp;&nbsp;/&nbsp;&nbsp; Used vehicle</p>
                                </div>

                                <div class="courses-info">
                                    <a href="car-details.jsp" class="section-btn btn btn-primary btn-block">View More</a>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4 col-sm-4">
                            <div class="courses-thumb courses-thumb-secondary">
                                <div class="courses-top">
                                    <div class="courses-image">
                                        <img src="images/product-5-720x480.jpg" class="img-responsive" alt="">
                                    </div>
                                    <div class="courses-date">
                                        <span title="Author"><i class="fa fa-dashboard"></i> 130 000km</span>
                                        <span title="Author"><i class="fa fa-cube"></i> 1800cc</span>
                                        <span title="Views"><i class="fa fa-cog"></i> Manual</span>
                                    </div>
                                </div>

                                <div class="courses-detail">
                                    <h3><a href="car-details.jsp">BMW</a></h3>

                                    <p class="lead"><small><del> $11199.00</del></small> <strong>$21179.00</strong></p>

                                    <p>190 hp &nbsp;&nbsp;/&nbsp;&nbsp; Diesel &nbsp;&nbsp;/&nbsp;&nbsp; 2012 &nbsp;&nbsp;/&nbsp;&nbsp; Used vehicle</p>
                                </div>

                                <div class="courses-info">
                                    <a href="car-details.jsp" class="section-btn btn btn-primary btn-block">View More</a>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4 col-sm-4">
                            <div class="courses-thumb courses-thumb-secondary">
                                <div class="courses-top">
                                    <div class="courses-image">
                                        <img src="images/product-6-720x480.jpg" class="img-responsive" alt="">
                                    </div>
                                    <div class="courses-date">
                                        <span title="Author"><i class="fa fa-dashboard"></i> 130 000km</span>
                                        <span title="Author"><i class="fa fa-cube"></i> 1800cc</span>
                                        <span title="Views"><i class="fa fa-cog"></i> Manual</span>
                                    </div>
                                </div>

                                <div class="courses-detail">
                                    <h3><a href="car-details.jsp">Tata Nexo</a></h3>

                                    <p class="lead"><small><del> $10199.00</del></small> <strong>$11179.00</strong></p>

                                    <p>190 hp &nbsp;&nbsp;/&nbsp;&nbsp; Petrol &nbsp;&nbsp;/&nbsp;&nbsp; 2015 &nbsp;&nbsp;/&nbsp;&nbsp; Used vehicle</p>
                                </div>

                                <div class="courses-info">
                                    <a href="car-details.jsp" class="section-btn btn btn-primary btn-block">View More</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>-->
            </section>
            <section>
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="text-center">
                                <h2>About us</h2>

                                <br>

                                <p class="lead">Welcome to our online platform dedicated to the buying and selling of classic and vintage cars. At Car Deal, we are passionate about preserving automotive history and connecting enthusiasts with their dream cars.</p>
                                <p class="lead">Our platform offers a comprehensive marketplace for individuals and collectors to browse, buy, and sell old cars with ease. Whether you're in search of a rare model to add to your collection or looking to find a new home for your beloved classic car, we've got you covered.</p>
                                <p class="lead">>What sets us apart is our exclusive subscription-based model, ensuring that only serious buyers and sellers have access to our premium services. With a subscription, users can unlock advanced search filters, seller privileges, and exclusive deals.</p>
                                <p class="lead">At Car Deal, we understand the importance of trust and transparency in every transaction. That's why we prioritize user security and provide a seamless, user-friendly experience from start to finish.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <section>
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="section-title text-center">
                                <h2>Latest Blog posts <small>Stay updated with CarDeal's latest news and articles.</small></h2>
                            </div>
                        </div>

                        <div class="col-md-4 col-sm-4">
                            <div class="courses-thumb courses-thumb-secondary">
                                <div class="courses-top">
                                    <div class="courses-image">
                                        <img src="images/blog-1-720x480.jpg" class="img-responsive" alt="">
                                    </div>
                                    <div class="courses-date">
                                        <span title="Author"><i class="fa fa-user"></i> Emily Smith</span>
                                        <span title="Date"><i class="fa fa-calendar"></i> 05/15/2023 09:45</span>
                                        <span title="Views"><i class="fa fa-eye"></i> 258</span>
                                    </div>
                                </div>

                                <div class="courses-detail">
                                    <h3><a href="blog-post-details.jsp">Top 10 Vintage Cars Every Enthusiast Should Know About</a></h3>
                                </div>

                                <div class="courses-info">
                                    <a href="blog-post-details.jsp" class="section-btn btn btn-primary btn-block">Read More</a>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4 col-sm-4">
                            <div class="courses-thumb courses-thumb-secondary">
                                <div class="courses-top">
                                    <div class="courses-image">
                                        <img src="images/blog-2-720x480.jpg" class="img-responsive" alt="">
                                    </div>
                                    <div class="courses-date">
                                        <span title="Author"><i class="fa fa-user"></i> David Johnson</span>
                                        <span title="Date"><i class="fa fa-calendar"></i> 05/20/2023 11:15</span>
                                        <span title="Views"><i class="fa fa-eye"></i> 312</span>
                                    </div>
                                </div>

                                <div class="courses-detail">
                                    <h3><a href="blog-post-details.jsp">Maintenance Tips for Classic Car Owners.</a></h3>
                                </div>

                                <div class="courses-info">
                                    <a href="blog-post-details.jsp" class="section-btn btn btn-primary btn-block">Read More</a>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4 col-sm-4">
                            <div class="courses-thumb courses-thumb-secondary">
                                <div class="courses-top">
                                    <div class="courses-image">
                                        <img src="images/blog-3-720x480.jpg" class="img-responsive" alt="">
                                    </div>
                                    <div class="courses-date">
                                        <span title="Author"><i class="fa fa-user"></i> Sarah Williams</span>
                                        <span title="Date"><i class="fa fa-calendar"></i> 05/25/2023 13:20</span>
                                        <span title="Views"><i class="fa fa-eye"></i> 198</span>
                                    </div>
                                </div>

                                <div class="courses-detail">
                                    <h3><a href="blog-post-details.jsp">The Evolution of Automobile Design: A Journey Through Time</a></h3>
                                </div>

                                <div class="courses-info">
                                    <a href="blog-post-details.jsp" class="section-btn btn btn-primary btn-block">Read More</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>



            <section id="testimonial">
                <div class="container">
                    <div class="row">

                        <div class="col-md-12 col-sm-12">
                            <div class="section-title text-center">
                                <h2>Testimonials <small>from around the world</small></h2>
                            </div>

                            <div class="owl-carousel owl-theme owl-client">
                                <div class="col-md-4 col-sm-4">
                                    <div class="item">
                                        <div class="tst-image">
                                            <img src="images/tst-image-1-200x216.jpg" class="img-responsive" alt="">
                                        </div>
                                        <div class="tst-author">
                                            <h4>Jackson</h4>
                                            <span>Shopify Developer</span>
                                        </div>
                                        <p>"CarDeal helped me find the classic car of my dreams. The process was smooth, and the customer service was exceptional. Highly recommended!"</p>
                                        <div class="tst-rating">
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4 col-sm-4">
                                    <div class="item">
                                        <div class="tst-image">
                                            <img src="images/tst-image-2-200x216.jpg" class="img-responsive" alt="">
                                        </div>
                                        <div class="tst-author">
                                            <h4>Camila</h4>
                                            <span>Marketing Manager</span>
                                        </div>
                                        <p>"I had a fantastic experience selling my vintage car through CarDeal. The platform is user-friendly, and I received great support from the team. Thank you!"</p>
                                        <div class="tst-rating">
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4 col-sm-4">
                                    <div class="item">
                                        <div class="tst-image">
                                            <img src="images/tst-image-3-200x216.jpg" class="img-responsive" alt="">
                                        </div>
                                        <div class="tst-author">
                                            <h4>Barbie</h4>
                                            <span>Art Director</span>
                                        </div>
                                        <p>"CarDeal provided me with valuable insights and options when purchasing my first classic car. I couldn't be happier with my purchase. Great service!"</p>
                                        <div class="tst-rating">
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4 col-sm-4">
                                    <div class="item">
                                        <div class="tst-image">
                                            <img src="images/tst-image-4-200x216.jpg" class="img-responsive" alt="">
                                        </div>
                                        <div class="tst-author">
                                            <h4>Andrio</h4>
                                            <span>Web Developer</span>
                                        </div>
                                        <p>"I highly recommend CarDeal to anyone looking to buy or sell classic cars. The platform is intuitive, and the team provides excellent support throughout the process."</p>
                                        <div class="tst-rating">
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </section> 
        </main>

        <!-- CONTACT -->
        <section id="contact">
            <div class="container">
                <div class="row">

                    <div class="col-md-6 col-sm-12">
                        <form id="contact-form" role="form" action="" method="post">
                            <div class="section-title">
                                <h2>Contact us <small>we love conversations. let us talk!</small></h2>
                            </div>

                            <div class="col-md-12 col-sm-12">
                                <input type="text" class="form-control" placeholder="Enter full name" name="name" required>

                                <input type="email" class="form-control" placeholder="Enter email address" name="email" required>

                                <textarea class="form-control" rows="6" placeholder="Tell us about your message" name="message" required></textarea>
                            </div>

                            <div class="col-md-4 col-sm-12">
                                <input type="submit" class="form-control" name="send message" value="Send Message">
                            </div>

                        </form>
                    </div>

                    <div class="col-md-6 col-sm-12">
                        <div class="contact-image">
                            <img src="images/contact-1-600x400.jpg" class="img-responsive" alt="Smiling Two Girls">
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
