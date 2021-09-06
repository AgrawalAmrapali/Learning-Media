<%-- 
    Document   : index
    Created on : 26-Aug-2021, 8:32:37 pm
    Author     : acer
--%>

<%@page import="com.helper.ConnectionProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!--css-->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background
            {
                clip-path: polygon(0% 15%, 0 0, 15% 0%, 85% 0%, 100% 0, 100% 15%, 100% 85%, 94% 91%, 85% 100%, 15% 100%, 10% 94%, 0% 85%);
            }
             body{
                background:url(img/Key.jpg);
                background-size: cover;
                background-attachment: fixed;
            }
            </style>
    </head>
    <body>
        <!--navbar-->
       <%@include file="normal_navbar.jsp"%>
       <!--banner-->
       <div class="container-fluid p-0 m-0">
           <div class="jumbotron primary-background text-white">
               <div class="container">
                   <h3 class="display-3">
                       Welcome to Learning Media
                   </h3>
                   <p>
                       A complete website for computer science student
                   </p>
                   <a  href="register.jsp" class="btn btn-outline-light btn-lg"><span class="	fa fa-user-plus"></span>Register</a>
                   <a  href="login.jsp" class="btn btn-outline-light btn-lg"><span class="fa fa-user-circle fa-spin"></span>Login</a>
               </div>
           </div>
       </div> 
       <div class="container">
           <div class="row mb-2">
               <div class="col-md-4">
               <div class="card">
                 <div class="card-body">
                  <h5 class="card-title">Java Programming</h5>
                  <p class="card-text">
Although it is primarily used for Internet-based applications, Java is a simple, efficient, general-purpose language. Java was originally designed for embedded network applications running on multiple platforms. It is a portable, object-oriented, interpreted language. Java is extremely portable.</p>
                  <a href="https://en.wikipedia.org/wiki/Java_(programming_language)" class="btn primary-background text-white">Go somewhere</a>
                 </div>
                </div>
                </div>
                <div class="col-md-4">
               <div class="card">
                 <div class="card-body">
                  <h5 class="card-title">Python Programming</h5>
                  <p class="card-text">Python is an interpreted high-level general-purpose programming language. Its design philosophy emphasizes code readability with its use of significant indentation. Its language constructs as well as its object-oriented approach aim to help programmers write clear, logical code for small and large-scale projects.</p>
                  <a href="https://en.wikipedia.org/wiki/Python_(programming_language)" class="btn primary-background text-white">Go somewhere</a>
                 </div>
                </div>
                </div>
                <div class="col-md-4">
               <div class="card">
                 <div class="card-body">
                  <h5 class="card-title">Cpp Progrmming</h5>
                  <p class="card-text">C++ is a general-purpose programming language  as an extension of the C programming language, or "C with Classes". The language has expanded significantly over time, and modern C++ now has object-oriented, generic, and functional features in addition to facilities for low-level memory manipulation. </p>
                  <a href="https://en.wikipedia.org/wiki/C%2B%2B" class="btn primary-background text-white">Go somewhere</a>
                 </div>
                </div>
                </div>
           </div>
             <div class="row">
               <div class="col-md-4">
               <div class="card">
                 <div class="card-body">
                  <h5 class="card-title">Web Development</h5>
                  <p class="card-text">Web development is the work involved in developing a Web site for the Internet or an intranet (a private network).[1] Web development can range from developing a simple single static page of plain text to complex web applications, electronic businesses, and social network services.</p>
                  <a href="https://en.wikipedia.org/wiki/Web_development" class="btn primary-background text-white">Go somewhere</a>
                 </div>
                </div>
                </div>
                <div class="col-md-4">
               <div class="card">
                 <div class="card-body">
                  <h5 class="card-title">Android Development</h5>
                  <p class="card-text">Android software development is the process by which applications are created for devices running the Android operating system. Google states that[3] "Android apps can be written using Kotlin, Java, and C++ languages" using the Android software development kit (SDK),</p>
                  <a href="#" class="btn primary-background text-white">Go somewhere</a>
                 </div>
                </div>
                </div>
                <div class="col-md-4">
               <div class="card">
                 <div class="card-body">
                  <h5 class="card-title">Desktop Development</h5>
                  <p class="card-text">Software development is the process of conceiving, specifying, designing, programming, documenting, testing, and bug fixing involved in creating or add other software components.Software development involves writing and maintaining the source code, </p>
                  <a href="https://en.wikipedia.org/wiki/Software_development" class="btn primary-background text-white">Go somewhere</a>
                 </div>
                </div>
                </div>
           </div>
           
       </div>
       
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script src="js/myjs.js" type="text/javascript"></script>
    </body>
</html>
