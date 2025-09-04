<%-- 
    Document   : AdminLogin
    Created on : 04-May-2024, 8:48:22?pm
    Author     : Abrarali
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%> 
    <!DOCTYPE html>
    <html>

    <head>

        <title>Login Page</title>
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
        <link rel="stylesheet" href="css/admin-login.css">

    </head>

    <body>
        <div class="contant1">
            <form action="AdminLogin" method="POST" class="form1">
                <div class="imgcontainer">
                    <img src="icons/usericon.png" alt="Avatar" class="avatar">
                </div>

                <div class="container1">
                    <label for="uname"><b>Admin E-Mail</b></label>
                    <input type="text" class="inpt" placeholder="Enter Admin E-Mail" name="ademail" required>

                    <label for="psw"><b>Password</b></label>
                    <input type="password" class="inpt" placeholder="Enter Password" name="adpassword" required>

                    <button type="submit" class="btn" id="signup">Login</button>
                    <label>
                        <input type="checkbox" checked="checked" name="remember"> Remember me
                    </label>
                </div>

                <div class="container1" style="background-color:#f1f1f1">
                    <!-- <button type="button" class="cancelbtn">Cancel</button> -->
                    <span class="psw">Forgot <a href="#">password?</a></span>

                </div>
            </form>

        </div>
    </body>

    </html>