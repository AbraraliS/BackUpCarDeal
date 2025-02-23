<%-- 
    Document   : blog-post-details
    Created on : 02-May-2024, 10:01:17 pm
    Author     : Abrarali
--%>

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
                        <li><a href="index.jsp">Home</a></li>
                        <li><a href="cars.jsp">Buy Cars</a></li>
                        <li><a href="SellCar.jsp">Sell Cars</a></li>
                        <li><a href="about-us.jsp">About Us</a></li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">More <span class="caret"></span></a>

                            <ul class="dropdown-menu">
                                <li class="active"><a href="blog-posts.jsp">Blog</a></li>
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
                <h2>Client Satisfaction: Our Priority</h2>

                <p class="lead">
                    <i class="fa fa-user"></i> Alice Smith &nbsp;&nbsp;&nbsp;
                    <i class="fa fa-calendar"></i> 12/06/2020 10:30 &nbsp;&nbsp;&nbsp;
                    <i class="fa fa-eye"></i> 114
                </p>

                <img src="images/other-image-fullscreen-1-1920x700.jpg" class="img-responsive" alt="">

                <br>

                <h3>Exceptional Service Beyond Expectations</h3>

        <p>At CarDeal, we strive to deliver exceptional service that goes beyond our clients' expectations. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nemo, tempore. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eius eaque soluta minus mollitia consequatur veritatis, voluptate architecto deserunt reprehenderit laboriosam!</p>

        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nemo, tempore. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eius eaque soluta minus mollitia consequatur veritatis, voluptate architecto deserunt reprehenderit laboriosam!</p>

        <br>

        <h4>Why CarDeal Stands Out</h4>

        <p>What sets CarDeal apart from other platforms is the level of service they provide. Throughout the buying process, the CarDeal team was incredibly helpful and responsive. They guided me through every step, from selecting the right car to arranging the purchase.</p>

        <p>I couldn't be happier with my experience, and I highly recommend CarDeal to anyone in the market for a classic car. Thank you, CarDeal, for helping me turn my dream into a reality!</p>

        <br>
        <br>


                <h4>My Journey with CarDeal</h4>

                 <p>Hi everyone! I just wanted to share my experience with CarDeal. After years of dreaming about owning a classic car, I finally decided to take the plunge and start my search. I stumbled upon CarDeal and was immediately impressed by the selection of cars available.</p>

        <p>After browsing through the listings for a while, I found the perfect car—a beautifully restored vintage Mustang. I reached out to the seller through CarDeal's platform, and within days, I was the proud owner of my dream car!</p>

                <br>
                <br>

                <div class="row">
                    <div class="col-md-4 col-xs-12 pull-right">
                        <h4>Social share</h4>

                        <p>
                            <a href="#" target="_blank"><i class="fa fa-facebook"></i></a> &nbsp;&nbsp;&nbsp;

                            <a href="#" target="_blank"><i class="fa fa-twitter"></i></a> &nbsp;&nbsp;&nbsp;

                            <a href="#" target="_blank"><i class="fa fa-linkedin"></i></a>
                        </p>

                        <br>


                          <h4>More Articles</h4>

                <ul class="list">
                    <li><a href="blog-post-details.jsp">10 Tips for Buying Your First Classic Car</a></li>
                    <li><a href="blog-post-details.jsp">The Rise of Electric Vehicles: What You Need to Know</a></li>
                    <li><a href="blog-post-details.jsp">How to Restore a Vintage Car on a Budget</a></li>
                </ul>
       
                    </div>

                    <div class="col-md-8 col-xs-12">
                        <h4>Comments</h4>

                        <p>No comments found.</p>

                        <br>

                        <h4>Leave a Comment</h4>

                        <form action="#" class="form">

                            <div class="row">
                                <div class="col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <label class="control-label">Name</label>

                                        <input type="text" name="name" class="form-control">
                                    </div>
                                </div>

                                <div class="col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <label class="control-label">Email</label>

                                        <input type="email" name="email" class="form-control">
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label">Message</label>

                                <textarea name="comment" class="form-control" rows="10" autocomplete="off"></textarea>
                            </div>

                            <button type="submit" class="section-btn btn btn-primary">Submit</button>
                        </form>
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