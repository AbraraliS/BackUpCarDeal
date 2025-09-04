<%-- 
    Document   : userUpdate
    Created on : 03-May-2024, 8:36:14?pm
    Author     : Abrarali
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    
        <title>User Registration Form</title>
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
        <link rel="stylesheet" href="css/user-update.css">
    </head>

    <body>
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

            session = request.getSession();
            String name = (String) session.getAttribute("Username");
            int user_id = (Integer) session.getAttribute("UserID");
            String email = (String) session.getAttribute("Email");

//            String rpaswd = (String) session.getAttribute("Password");
            String finame = (String) session.getAttribute("FirstName");
            String laname = (String) session.getAttribute("LastName");
            String addres = (String) session.getAttribute("Address");
            String cityy = (String) session.getAttribute("City");
            String statee = (String) session.getAttribute("State");
            long phonee = (Long) session.getAttribute("Phone");
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

        <!-- navBar -->
        <div class="navbar1">
            <div class="imgcontainer1">
                <img src="icons/usericon.png"  alt="Avatar" class="avatar">
            </div>
            <ul>
                  <li><a href="userProfile.jsp" >Profile</a></li>
                <li class="active1"><a href="userUpdate.jsp">Update Profile</a></li>
               <li><a href="BuyHist.jsp">Buy History</a></li>
                 <li ><a href="SellHist.jsp">Sell History</a></li>
                <li><a href="MyUCars.jsp">My Cars</a></li>
                <li><a href="ChangePass.jsp">Change Password</a></li>
                <!--<li><a href="#privacy-policy">Privacy Policy</a></li>-->
            </ul>
        </div>
        <div class="container1">
            <h1>Edite Your Data</h1>
            <h2><%= name%></h2>
            <form action="update" method="POST">
                <!-- <label for="user_id">User ID:</label>
            <input type="text" id="user_id" name="user_id"> -->
                <label for="U_name">User ID:</label>
                <input type="text" id="U_name" name="userid" placeholder="<%= user_id%>" value="<%= user_id%>" disabled>
                <input type="hidden" name="uid" value="<%= user_id%>">


                <label for="U_name">Username:</label>
                <input type="text" id="U_name" name="uname" placeholder="<%= name%>" value="<%= name%>">

                <label for="F_name">First Name:</label>
                <input type="text" id="F_name" name="fname" placeholder="<%= finame%>" value="<%= finame%>">

                <label for="L_name">Last Name:</label>
                <input type="text" id="L_name" name="lname" placeholder="<%= laname%>" value="<%= laname%>">

                <label for="E-Mail">E-Mail:</label>
                <input type="email" id="eMail" name="email" placeholder="<%= email%>" value="<%= email%>" disabled>

                <label for="Password">Password:</label>
                <input type="password" id="Password" name="passwd" placeholder="********" disabled>

                <label for="phoneNo">Phone Number:</label>
                <input type="text" id="phoneNumber" name="phone" maxlength="10" placeholder="<%= phonee%>" value="<%= phonee%>">

                <label for="Address">Address:</label>
                <input type="text" id="Address" name="addrs" placeholder="<%= addres%>" value="<%= addres%>">

                <label for="City">State:</label>
                <input type="text" id="City" name="city" placeholder="<%= statee%>" value="<%= statee%>">

                <label for="State">City:</label>
                <input type="text" id="State" name="state" placeholder="<%= cityy%>" value="<%= cityy%>">

                <label for="pincode">Pincode:</label>
                <input type="text" id="pincode" name="pincd" placeholder="6 digit Pincode">

                <!--                    <label for="subscriType">Subscription Type</label>
                                    <input type="radio" value="1" name="subType">
                                    <input type="radio" value="1" name="subType">-->
                <input type="submit" class="subm" value="Update">

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