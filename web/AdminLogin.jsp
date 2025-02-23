<%-- 
    Document   : AdminLogin
    Created on : 04-May-2024, 8:48:22 pm
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


        <!-- MAIN CSS -->

        <style>
            .contant1{
                align-items: center;
                margin-top: 2.5%;
            }
            /* Bordered form */
            .form1 {
                border: 3px solid #f1f1f1;
                max-width: 30%;
                margin: 0 auto;
                padding: 20px;

            }

            /* Full-width inputs */
            .inpt {

                width: 100%;
                padding: 12px 20px;
                margin: 8px 0;
                display: inline-block;
                border: 1px solid #ccc;
                box-sizing: border-box;
            }

            /* Set a style for the login button */
            .btn {
                background-color: #04AA6D;
                color: white;
                padding: 14px 20px;
                margin: 8px 0;
                border: none;
                cursor: pointer;
                width: 100%;
            }

            /* Add a hover effect for buttons */
            .btn:hover {
                opacity: 0.8;
            }

            /* Center the avatar image inside this container */
            .imgcontainer {
                text-align: center;
                margin: 24px 0 12px 0;
            }

            /* Avatar image */
            img.avatar {
                width: 30%;
                border-radius: 50%;
            }

            /* Add padding to containers */
            .container1 {
                padding: 16px;
            }

            /* The "Forgot password" text */
            span.psw {
                /*                    float: right;*/
                padding-top: 16px;
                gap: 5px;
            }

            .newacc {
                border: 3px solid #f1f1f1;
                max-width: 30%;
                margin: 0 auto;
                padding: 20px;
                cursor: pointer;
            }

            .newacc a {
                text-decoration: none;
                color: black;
                font-weight: bold;
                font-family: Verdana, Geneva, Tahoma, sans-serif;
            }
            .newacc button{
                padding: 2% 30%;
            }
            .newacc:hover {
                opacity: 0.8;
                color: black;
            }

            /* Change styles for span and cancel button on extra small screens */
            @media only screen and (max-width: 992px){
                span.psw {
                    display: block;
                    float: none;
                }
                .form1 {
                    min-width: 100%;
                }
                .inpt,.btn{
                    min-width: 100%;
                }
                .newacc{
                    min-width: 100%;
                }
            }
        </style>
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
                <div class="container1" style="background-color:#f1f1f1; display: flex; flex-direction: column;">
                    <span class="psw">Forgot <a href="#">password?</a></span>

                </div>
            </form>

        </div>
    </body>

</html>
