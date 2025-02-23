<%-- Document : cars Created on : 02-May-2024, 10:11:31 pm Author : Abrarali --%>

<%@page import="carsellbuy.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
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
        <style>
            .pagesnav {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 5px;
            }

            .pagesnav li {
                list-style: none;
                background-color: #29ca8e;
               padding: 10px 15px;
                color: black;
                font-weight: bold;
            }

            .pagesnav li:hover {
                background-color: #104c36;
                color: #ffffff;

            }
            .car{
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                grid-gap: 6vh;
            }
            @media only screen and (max-width: 992px){
                .ddvv{
                    display: none;
                }
                .car{
                    grid-template-columns: repeat(1, 1fr);
                }
            }
        </style>

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
                <div class="text-center">
                    <h1>Car Listing</h1>

                    <br>

                    <p class="lead">Browse Your CAR here !</p>
                </div>
            </div>
        </section>

        <section class="section-background">
            <div class="container">

                <div class="row">
                    <div class="col-lg-3 col-xs-12 ddvv">
                        <div class="form">
                            <form action="#">
                                <div class="form-group">
                                    <label>Used/New:</label>

                                    <select class="form-control">
                                        <option value="">All</option>
                                        <option value="new">New vehicle</option>
                                        <option value="used">Used vehicle</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label>Vehicle Type:</label>

                                    <select class="form-control">
                                        <option value="">--All --</option>
                                        <option value="">option 1</option>
                                        <option value="">option 2</option>
                                        <option value="">option 3</option>
                                        <option value="">option 4</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label>Make:</label>

                                    <select class="form-control">
                                        <option value="">-- All --</option>
                                        <option value="">option 1</option>
                                        <option value="">option 2</option>
                                        <option value="">option 3</option>
                                        <option value="">option 4</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label>Model:</label>

                                    <select class="form-control">
                                        <option value="">-- All --</option>
                                        <option value="">option 1</option>
                                        <option value="">option 2</option>
                                        <option value="">option 3</option>
                                        <option value="">option 4</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label>Price:</label>

                                    <select class="form-control">
                                        <option value="">-- All --</option>
                                        <option value="">option 1</option>
                                        <option value="">option 2</option>
                                        <option value="">option 3</option>
                                        <option value="">option 4</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label>Mileage:</label>

                                    <select class="form-control">
                                        <option value="">-- All --</option>
                                        <option value="">option 1</option>
                                        <option value="">option 2</option>
                                        <option value="">option 3</option>
                                        <option value="">option 4</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label>Engine size:</label>

                                    <select class="form-control">
                                        <option value="">-- All --</option>
                                        <option value="">option 1</option>
                                        <option value="">option 2</option>
                                        <option value="">option 3</option>
                                        <option value="">option 4</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label>Power:</label>

                                    <select class="form-control">
                                        <option value="">-- All --</option>
                                        <option value="">option 1</option>
                                        <option value="">option 2</option>
                                        <option value="">option 3</option>
                                        <option value="">option 4</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label>Fuel:</label>

                                    <select class="form-control">
                                        <option value="">-- All --</option>
                                        <option value="">option 1</option>
                                        <option value="">option 2</option>
                                        <option value="">option 3</option>
                                        <option value="">option 4</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label>Gearbox:</label>

                                    <select class="form-control">
                                        <option value="">-- All --</option>
                                        <option value="">option 1</option>
                                        <option value="">option 2</option>
                                        <option value="">option 3</option>
                                        <option value="">option 4</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label>Doors:</label>

                                    <select class="form-control">
                                        <option value="">-- All --</option>
                                        <option value="">option 1</option>
                                        <option value="">option 2</option>
                                        <option value="">option 3</option>
                                        <option value="">option 4</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label>Number of seats:</label>

                                    <select class="form-control">
                                        <option value="">-- All --</option>
                                        <option value="">option 1</option>
                                        <option value="">option 2</option>
                                        <option value="">option 3</option>
                                        <option value="">option 4</option>
                                    </select>
                                </div>

                                <button type="submit" class="section-btn btn btn-primary btn-block">Search</button>
                            </form>
                        </div>
                    </div>
                    <form action="#">  <div class="car" >
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

                            <div class="">
                                <div class="">
                                    <div class="courses-thumb courses-thumb-secondary">
                                        <div class="courses-top">
                                            <div class="courses-image">
                                                <img src="<%=photo%>" class="img-responsive" style="max-height:220px; width:520px;"  alt="">
                                            </div>
                                            <div class="courses-date">
                                                <span title="Author"><i class="fa fa-dashboard"></i> <%=kmdrive%>km</span>
                                                <span title="Author"><i class="fa fa-cube"></i> 1800cc</span>
                                                <span title="Views"><i class="fa fa-cog"></i> Manual</span>
                                            </div>
                                        </div>

                                        <div class="courses-detail">
                                            <h3><a href="car-details.jsp"><%=brandname%> <%=model%></a></h3>

                                            <p class="lead"><small><del>  ₹<%=price%></del></small>
                                                <strong> ₹<%=price%></strong>
                                            </p>

                                            <p>190 hp &nbsp;&nbsp;/&nbsp;&nbsp; Petrol &nbsp;&nbsp;/&nbsp;&nbsp; <%=regyer%>
                                                &nbsp;&nbsp;/&nbsp;&nbsp; Used vehicle</p>
                                        </div>
                                        <input type="text" name="carid" value="<%=carid%>" hidden>
                                        <div class="courses-info">
                                            <a href="car-details.jsp" class="section-btn btn btn-primary btn-block">View
                                                More</a>
<!--                                            <button class="section-btn btn btn-primary btn-block">View
                                                More </button>-->
                                        </div>
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

                            %>   </div></form>
                    <!--                    <div class="col-lg-9 col-xs-12">
                                            <div class="row">
                                                <div class="col-lg-6 col-md-4 col-sm-6">
                                                    <div class="courses-thumb courses-thumb-secondary">
                                                        <div class="courses-top">
                                                            <div class="courses-image">
                                                                <img src="images/product-1-720x480.jpg" class="img-responsive" alt="">
                                                            </div>
                                                            <div class="courses-date">
                                                                <span title="Author"><i class="fa fa-dashboard"></i> 130 000km</span>
                                                                <span title="Author"><i class="fa fa-cube"></i> 1800cc</span>
                                                                <span title="Views"><i class="fa fa-cog"></i> Manual</span>
                                                            </div>
                                                        </div>
                    
                                                        <div class="courses-detail">
                                                            <h3><a href="car-details.jsp">Toyota Corolla</a></h3>
                    
                                                            <p class="lead"><small><del> $11199.00</del></small>
                                                                <strong>$11079.00</strong>
                                                            </p>
                    
                                                            <p>190 hp &nbsp;&nbsp;/&nbsp;&nbsp; Petrol &nbsp;&nbsp;/&nbsp;&nbsp; 2008
                                                                &nbsp;&nbsp;/&nbsp;&nbsp; Used vehicle</p>
                                                        </div>
                    
                                                        <div class="courses-info">
                                                            <a href="car-details.jsp" class="section-btn btn btn-primary btn-block">View
                                                                More</a>
                                                        </div>
                                                    </div>
                                                </div>
                    
                                                <div class="col-lg-6 col-md-4 col-sm-6">
                                                    <div class="courses-thumb courses-thumb-secondary">
                                                        <div class="courses-top">
                                                            <div class="courses-image">
                                                                <img src="images/product-2-720x480.jpg" class="img-responsive" alt="">
                                                            </div>
                                                            <div class="courses-date">
                                                                <span title="Author"><i class="fa fa-dashboard"></i> 70 000km</span>
                                                                <span title="Author"><i class="fa fa-cube"></i> 2200cc</span>
                                                                <span title="Views"><i class="fa fa-cog"></i> Manual</span>
                                                            </div>
                                                        </div>
                    
                                                        <div class="courses-detail">
                                                            <h3><a href="car-details.jsp">Honda Accord</a></h3>
                    
                                                            <p class="lead"><small><del> $12199.00</del></small>
                                                                <strong>$12079.00</strong>
                                                            </p>
                    
                                                            <p>190 hp &nbsp;&nbsp;/&nbsp;&nbsp; Petrol &nbsp;&nbsp;/&nbsp;&nbsp; 2008
                                                                &nbsp;&nbsp;/&nbsp;&nbsp; New vehicle</p>
                                                        </div>
                    
                                                        <div class="courses-info">
                                                            <a href="car-details.jsp" class="section-btn btn btn-primary btn-block">View
                                                                More</a>
                                                        </div>
                                                    </div>
                                                </div>
                    
                                                <div class="col-lg-6 col-md-4 col-sm-6">
                                                    <div class="courses-thumb courses-thumb-secondary">
                                                        <div class="courses-top">
                                                            <div class="courses-image">
                                                                <img src="images/product-3-720x480.jpg" class="img-responsive" alt="">
                                                            </div>
                                                            <div class="courses-date">
                                                                <span title="Author"><i class="fa fa-dashboard"></i> 130 000km</span>
                                                                <span title="Author"><i class="fa fa-cube"></i> 1800cc</span>
                                                                <span title="Views"><i class="fa fa-cog"></i> Manual</span>
                                                            </div>
                                                        </div>
                    
                                                        <div class="courses-detail">
                                                            <h3><a href="car-details.jsp">Ford Mustang</a></h3>
                    
                                                            <p class="lead"><small><del> $11199.00</del></small>
                                                                <strong>$11179.00</strong>
                                                            </p>
                    
                                                            <p>190 hp &nbsp;&nbsp;/&nbsp;&nbsp; Petrol &nbsp;&nbsp;/&nbsp;&nbsp; 2008
                                                                &nbsp;&nbsp;/&nbsp;&nbsp; Used vehicle</p>
                                                        </div>
                    
                                                        <div class="courses-info">
                                                            <a href="car-details.jsp" class="section-btn btn btn-primary btn-block">View
                                                                More</a>
                                                        </div>
                                                    </div>
                                                </div>
                    
                                                <div class="col-lg-6 col-md-4 col-sm-6">
                                                    <div class="courses-thumb courses-thumb-secondary">
                                                        <div class="courses-top">
                                                            <div class="courses-image">
                                                                <img src="images/product-4-720x480.jpg" class="img-responsive" alt="">
                                                            </div>
                                                            <div class="courses-date">
                                                                <span title="Author"><i class="fa fa-dashboard"></i> 130 000km</span>
                                                                <span title="Author"><i class="fa fa-cube"></i> 1800cc</span>
                                                                <span title="Views"><i class="fa fa-cog"></i> Manual</span>
                                                            </div>
                                                        </div>
                    
                                                        <div class="courses-detail">
                                                            <h3><a href="car-details.jsp">Tata Max</a></h3>
                    
                                                            <p class="lead"><small><del> $11199.00</del></small>
                                                                <strong>$11179.00</strong>
                                                            </p>
                    
                                                            <p>190 hp &nbsp;&nbsp;/&nbsp;&nbsp; Petrol &nbsp;&nbsp;/&nbsp;&nbsp; 2008
                                                                &nbsp;&nbsp;/&nbsp;&nbsp; Used vehicle</p>
                                                        </div>
                    
                                                        <div class="courses-info">
                                                            <a href="car-details.jsp" class="section-btn btn btn-primary btn-block">View
                                                                More</a>
                                                        </div>
                                                    </div>
                                                </div>
                    
                                                <div class="col-lg-6 col-md-4 col-sm-6">
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
                    
                                                            <p class="lead"><small><del> $11199.00</del></small>
                                                                <strong>$11179.00</strong>
                                                            </p>
                    
                                                            <p>190 hp &nbsp;&nbsp;/&nbsp;&nbsp; Petrol &nbsp;&nbsp;/&nbsp;&nbsp; 2008
                                                                &nbsp;&nbsp;/&nbsp;&nbsp; New vehicle</p>
                                                        </div>
                    
                                                        <div class="courses-info">
                                                            <a href="car-details.jsp" class="section-btn btn btn-primary btn-block">View
                                                                More</a>
                                                        </div>
                                                    </div>
                                                </div>
                    
                                                <div class="col-lg-6 col-md-4 col-sm-6">
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
                    
                                                            <p class="lead"><small><del> $11199.00</del></small>
                                                                <strong>$11179.00</strong>
                                                            </p>
                    
                                                            <p>190 hp &nbsp;&nbsp;/&nbsp;&nbsp; Petrol &nbsp;&nbsp;/&nbsp;&nbsp; 2008
                                                                &nbsp;&nbsp;/&nbsp;&nbsp; New vehicle</p>
                                                        </div>
                    
                                                        <div class="courses-info">
                                                            <a href="car-details.jsp" class="section-btn btn btn-primary btn-block">View
                                                                More</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <ul class="pagesnav">
                                                    <li><a href="#">1</a></li>
                                                    <li class="active"><a href="#">2</a></li>
                                                    <li><a href="#">3</a></li>
                                                    <li><a href="#">4</a></li>
                                                    <li><a href="#"><i class="fa fa-angle-double-right"></i></a></li>
                                                </ul>
                                            </div>
                                        </div>-->
                    <div class="col-md-12">
                                                <ul class="pagesnav">
                                                    <li><a href="#">1</a></li>
                                                    <li class="active"><a href="#">2</a></li>
                                                    <li><a href="#">3</a></li>
                                                    <li><a href="#">4</a></li>
                                                    <li><a href="#"><i class="fa fa-angle-double-right"></i></a></li>
                                                </ul>
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

        <div class="modal fade bs-example-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="gridSystemModalLabel">Book Now</h4>
                    </div>

                    <div class="modal-body">
                        <form action="#" id="contact-form">
                            <div class="row">
                                <div class="col-md-6">
                                    <input type="text" class="form-control" placeholder="Pick-up location" required>
                                </div>

                                <div class="col-md-6">
                                    <input type="text" class="form-control" placeholder="Return location" required>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <input type="text" class="form-control" placeholder="Pick-up date/time"
                                           required>
                                </div>

                                <div class="col-md-6">
                                    <input type="text" class="form-control" placeholder="Return date/time" required>
                                </div>
                            </div>
                            <input type="text" class="form-control" placeholder="Enter full name" required>

                            <div class="row">
                                <div class="col-md-6">
                                    <input type="text" class="form-control" placeholder="Enter email address"
                                           required>
                                </div>

                                <div class="col-md-6">
                                    <input type="text" class="form-control" placeholder="Enter phone" required>
                                </div>
                            </div>
                        </form>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="section-btn btn btn-primary">Book Now</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- SCRIPTS -->
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/smoothscroll.js"></script>
        <script src="js/custom.js"></script>

    </body>

</html>