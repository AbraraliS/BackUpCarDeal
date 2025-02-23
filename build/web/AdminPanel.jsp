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
        <style>

            /* styles.css */
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
            }
            /* NavBar */



            .navbar1 {
                height: 100%;
                max-width: 20%;
                background-color: #fafffd;
                color: #000000;
                position: fixed;
                top: 0;
                left: 0;
                display: flex;
                flex-direction: column;
                align-items: center;
                border-right: 4px solid #29ca8e;
                /* justify-content: space-between; */
            }
            .nav2{
                position: fixed;
                right: 0;
                top: 0;
                width: 80%;
                display: flex;
                justify-content: space-between;
                box-shadow: 0 4px 8px -4px #29ca8e;
                padding: 12px 0px;
                align-items: center;
            }
            .logocar{
                margin-left: 4vh;

            }
            .logocar a{
                text-decoration: none;
                font-size: 2.5vw;
                color: black;
                font-weight: bold;
            }
            .ulright{
                display: flex;
                gap: 2vh;
                margin-right: 4vh;
                align-items: center;
            }
            .ulright a{
                text-decoration: none;
                color: black;
                background-color: #29ca8e;
                padding: 12px 12px;
            }
            .ulright a:hover{
                opacity: 0.8;
            }
            .imgcontainer1 {
                text-align: center;
                margin: 24px 0 12px 0;
            }
            img.avatar {
                width: 40%;
                border-radius: 50%;
            }
            .navbar1 li{
                padding: 1vh 2vh;
                border: 2px;
                margin: 5vh 0vh;
                list-style: none;
                justify-content: space-between;
                width: 100%;
                border-right: 2px solid #29ca8e;
                box-shadow: 0 4px 8px -4px #29ca8e;
            }
            .navbar1   .active1{
                border-bottom: 6px solid #116647;
            }
            .navbar1 a {

                text-decoration: none;
                color: #000000;
                font-size: 16px;
                text-align: center;
                transition: 0.3s;

            }
            .navbar1 li:hover {
                opacity: 0.8;
                border-right: 2px solid black;
                border-bottom: 6px solid #116647;
                box-shadow: 0 2px 2px -2px #29ca8e;
            }

            /* Profile css */
            .profile-container1 {
                max-width: 80%;
                height: auto;
                margin: 10% 22%;
                padding: 1vh;
                min-width: 72%;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-shadow: 0 4px 8px 2px #29ca8e;

            }





        </style>
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
