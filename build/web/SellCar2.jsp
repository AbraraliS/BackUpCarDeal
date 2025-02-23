<%-- 
    Document   : SellCar
    Created on : 05-May-2024, 8:04:14 pm
    Author     : Abrarali
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="carsellbuy.DbConnection"%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

        <title>JSP Page</title>
        <style>
            .sellcartop{
                margin: 5% 30%;
                max-width: 70%;
            }
            .selectop{
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                align-items: center;
                grid-gap: 2vh;

            }
            @media only screen and (max-width: 992px){
                .sellcartop{
                    margin: 5% 10%;
                    max-width: 70%;
                }
                .selectop{
                    display: grid;
                    grid-template-columns: repeat(1, 1fr);
                }
            }
            /* Style the container */
            .custom-select {
                position: relative;
                display: inline-block;
            }

            /* Style the select box */
            .form-select {
                appearance: none; /* Hide default arrow */
                background-color: #f9f9f9;
                border: 1px solid #ccc;
                padding: 10px;
                font-size: 14px;
                width: 300px;
                border-radius: 5px;
                cursor: pointer;
                transition: border-color 0.3s ease;
            }

            /* Add a custom arrow icon */
            .form-select::after {
                content: "\25BC"; /* Unicode down arrow */
                position: absolute;
                top: 50%;
                right: 10px;
                transform: translateY(-50%);
                font-size: 16px;
                color: #555;
            }

            /* Show options on click */
            .form-select:focus {
                outline: none;
                border-color: #007bff; /* Highlight border on focus */
            }
            .form-select:focus option {
                display: block;
            }

            /* Style individual options */
            .form-select option {
                display: none;
                padding: 10px;
                background-color: #f9f9f9;
                color: #333;
                transition: background-color 0.2s;
            }

            .form-select option:hover {
                background-color: #e0e0e0;
            }
            input[type="text"],
            input[type="number"] {
                width: 300px;
                padding: 1vh 1vh;
                border: 1px solid #ccc;
                border-radius: 3px;
            }
            .buttn1{
                margin: 2vh auto;

            }
            .buttn1 button{
                background-color: #29ca8e;
                padding: 1vh 5vh;
                color: white;
                font-weight: bold;
                font-size: 2vh;
            }

        </style>
    </head>
    <body>
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            if (session.getAttribute("UserID") == null) {
                response.sendRedirect("login");
            } else if (session.getAttribute("SubscriptionTypeID") == null) {
                response.sendRedirect("Subscribe.jsp");
            }
                session = request.getSession();
                int useerid = (Integer) session.getAttribute("UserID");
                String name = (String) session.getAttribute("Username");
                String addrs = (String) session.getAttribute("Address");
                String city = (String) session.getAttribute("City");
                String state = (String) session.getAttribute("State");
        %>
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
                        <li  class="active"><a href="SellCar2.jsp">Sell Cars</a></li>
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

        <form action="sellcar" method="POST">
            <div class="sellcartop">
                <div class="selectop">

                    <div class="custom-select">
                        <label for="CarName">Car Name:</label><br>
                        <input type="text" name="cname" placeholder="Enter Car name" required>
                        </select>
                    </div>

                    <div class="custom-select">
                        <label for="RegYear">Regestration Year : </label><br>
                        <select class="form-select" aria-label="Select Regestration Year :" name="regye">
                            <option selected disabled hidden>Select a Regestration Year</option>
                            <option value="2024">2024</option>
                            <option value="2023">2023</option>
                            <option value="2022">2022</option>
                            <option value="2021">2021</option>
                            <option value="2020">2020</option>
                            <option value="2019">2019</option>
                            <option value="2018">2018</option>
                            <option value="2017">2017</option>
                            <option value="2016">2016</option>
                            <option value="2015">2015</option>
                            <option value="2014">2014</option>
                            <option value="2013">2013</option>
                            <option value="2012">2012</option>
                            <option value="2011">2011</option>
                            <option value="2010">2010</option>
                        </select>
                    </div>

                    <div class="custom-select">
                        <label for="Km_driven">KM Driven :</label><br>
                        <input type="number" name="kmdrive" placeholder="How many KM driven"  required>
                    </div>

                    <div class="custom-select">
                        <label for="price">Price :</label><br>
                        <input type="text" name="price" placeholder="Enter Price" required>
                    </div>

                    <div class="custom-select">
                        <label for="Car_Brand">Car Brand :</label><br>
                        <input type="text" name="brand" placeholder="Car Brand: Honda, Tata, Toyota..." required>
                    </div>

                    <div class="custom-select">
                        <label for="Car_Model">Car Model :</label><br>
                        <input type="text" name="model" placeholder="Car Model:Civic, Corolla..."  required>
                    </div>

                    <div class="custom-select">
                        <label for="carvs">Car Varient,FuelType</label><br>
                        <input type="text" name="ftype" placeholder="Car Varient: ZX,FuelType: Petrol"  required>
                    </div>
                    <div class="custom-select">
                        <label for="carDescription">Car Description:</label><br>
                        <textarea id="carDescription" name="cardes" rows="4" cols="40" required></textarea>

                    </div>
                    <input type="text" value="<%=useerid%>" name="gusid" hidden>
                    <div class="custom-select">
                        <label for="caraddrs">Address:</label><br>
                        <input type="text" name="addrs" rows="4" value="<%=addrs%>,<%=city%>,<%=state%>,India">
                    </div>
                    <div class="custom-select">
                        <label for="carPhoto">Upload Photo:</label>
                        <input type="file" name="photos" accept="image/*">
                    </div>



                </div>
                <div class="buttn1"><button type="submit" class="btn">SUBMIT</button></div>
            </div>
        </form>


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
                                <p><a href="mailto:carseal@company.com">cardeal@gmail.com</a></p>
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
