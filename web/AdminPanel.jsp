<%-- 
    Document   : AdminPanel
    Created on : 04-May-2024, 8:42:06?pm
    Author     : Abrarali
--%>






<!DOCTYPE html>
<html>
    <head>


        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=Edge">
        <meta name="description" content="">
        <meta name="keywords" content="">
        <meta name="author" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">



        <title>Car Deal</title>
        <link rel="stylesheet" href="css/admin-panel.css">
    </head>
    <body>
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

            session = request.getSession();
//            int adminID = (Integer) session.getAttribute("AdminID");
            String name = (String) session.getAttribute("Username");
//            String email = (String) session.getAttribute("Email");


        %>

        <!-- MENU -->
        <section class="navbar" role="navigation">
            <div class="navbar1">
                <div class="imgcontainer1">
                    <img src="icons/usericon.png"  alt="Avatar" class="avatar">
                </div>
                <ul>
                    <li class="active1"><a href="AdminPanel.jsp" >Users</a></li>
                    <li><a href="AvailCar.jsp">Avail Cars</a></li>
                    <li><a href="AdSellHist.jsp">Seller History</a></li>
                   <li><a href="AdBuyHist.jsp">Buyers History</a></li>
                    <!--<li><a href="#sell-history">Post Blog</a></li>-->
                    <!--<li><a href="#privacy-policy">Privacy Policy</a></li>-->
                </ul>
            </div>
            <div class="nav2">
                <!-- lOGO TEXT HERE -->
                <div class="logocar" >  <a href="index.jsp" class="navbar-brand">Car Deal</a>
                </div>

                <div class="ulright">
                    <%                        out.println("<p><img src=icons/user2icon.png  height=14px width=14px>" + "Admin : " + name + "</p>");
                        out.println("<a href=AdminLogout class=ulaa3 style=background-color:red;><img src=icons/usericon.png height=14px width=14px >Logout</a>");

                    %>
                </div>
            </div>
        </section>



        <!-- navBar -->

        <!-- Profile -->
        <div class="profile-container1">
            <h1>User Details</h1>
            <iframe src="users" width="100%" height="400px"></iframe>        
        </div>
        <!-- SCRIPTS -->
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/smoothscroll.js"></script>
        <script src="js/custom.js"></script>
    </body>
</html>
