<%-- Document : userRegister Created on : 29-Apr-2024, 1:12:07 pm Author : Abrarali --%>

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

        <title>User Registration Form</title>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/font-awesome.min.css">
        <link rel="stylesheet" href="css/owl.carousel.css">
        <link rel="stylesheet" href="css/owl.theme.default.min.css">
        <!-- MAIN CSS -->
        <link rel="stylesheet" href="css/style.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f9f9f9;
            }

            .container1 {
                max-width: 600px;
                margin: 0 auto;
                padding: 8vh;
                background-color: #ffffff;
                border-radius: 5px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            label {
                font-weight: bold;
            }

            input[type="text"],
            input[type="password"],
            input[type="email"],
            input[type="tel"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 3px;
            }

            .subm {
                background-color: #04AA6D;
                color: #ffffff;
                border: none;
                padding: 10px 30px;
                border-radius: 3px;
                cursor: pointer;
                font-size: 18px;
                text-decoration: none;
            }

            .subm:hover {
                opacity: 0.8;
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
                        <li><a href="index.jsp">Home</a></li>
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
                                out.println("<a href=# >SUBSCRIBE</a>");
                            }
                        %>

                    </div>

                </div>
        </section>

        <div class="container1">
            <h1>User Registration:</h1>
            <form action="register" method="POST">
                <!-- <label for="user_id">User ID:</label>
            <input type="text" id="user_id" name="user_id" required> -->
                <!--                <label for="U_name">User ID:</label>
                                <input type="text" id="U_name" name="uid" placeholder="User ID" required>-->

                <label for="U_name">Username:</label>
                <input type="text" id="U_name" name="uname" placeholder="User Name" required>

                <label for="F_name">First Name:</label>
                <input type="text" id="F_name" name="fname" placeholder="First Name" required>

                <label for="L_name">Last Name:</label>
                <input type="text" id="L_name" name="lname" placeholder="Last Name" required>

                <label for="E-Mail">E-Mail:</label>
                <input type="email" id="eMail" name="email" placeholder="cardeal@gmail.com" required>

                <label for="Password">Password:</label>
                <input type="password" id="Password" name="passwd" placeholder="minimum 8 character password"
                       required>

                <label for="phoneNo">Phone Number:</label>
                <input type="text" id="phoneNumber" name="phone" maxlength="10" placeholder="Enter Phone No." required>

                <label for="Address">Address:</label>
                <input type="text" id="Address" name="addrs" placeholder="Address" required>

                <label for="City">State:</label>
                <input type="text" id="City" name="city" placeholder="State" required>

                <label for="State">City:</label>
                <input type="text" id="State" name="state" placeholder="City" required>

                <label for="pincode">Pincode:</label>
                <input type="text" id="pincode" name="pincd" placeholder="6 digit Pincode" required>

                <!--                                    <label for="subscriType">Subscription Type</label>
                                                    <input type="radio" value="1" name="subType">
                                                    <input type="radio" value="1" name="subType">-->
                <input type="submit" class="subm" value="Register">
                <!--                <a href="login.jsp" class="subm">Login</a>-->

            </form>
        </div>
        <!-- SCRIPTS -->
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/smoothscroll.js"></script>
        <script src="js/custom.js"></script>
    </body>

</html>