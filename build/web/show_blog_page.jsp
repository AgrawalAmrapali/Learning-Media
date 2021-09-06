<%-- 
    Document   : show_blog_page
    Created on : 06-Sep-2021, 9:53:42 am
    Author     : acer
--%>
<%@page import="com.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.dao.UserDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.entities.Category"%>
<%@page import="com.entities.Message"%>
<%@page import="com.entities.Post"%>
<%@page import="com.dao.PostDao"%>
<%@page import="com.helper.ConnectionProvider"%>
<%@page import="com.entities.User"%>
<%@page errorPage="Error_Page.jsp" %>
<%
    
    User user=(User)session.getAttribute("currentUser");
    
    if(user==null)
    {
       response.sendRedirect("login.jsp");
    }
    
    %>
<%
    int postId = Integer.parseInt(request.getParameter("post_id"));
    PostDao dao=new PostDao(ConnectionProvider.getConnection());
    Post p=dao.getPostByPostId(postId);
    
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=p.getpTitle()%> || Learning Media</title>
         <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background
            {
                clip-path: polygon(0% 15%, 0 0, 15% 0%, 85% 0%, 100% 0, 100% 15%, 100% 85%, 94% 91%, 85% 100%, 15% 100%, 10% 94%, 0% 85%);
            }
            .post-title{
                font-weight: 100;
                font-size: 25px;
                
            }
            .post-content{
                font-weight: 100;
                font-size: 20px;
            }
            .post-date{
                font-style: italic;
                font-weight: bold;
                
            }
            .post-user-info{
                font-size:20px;
                
            }
            .row-user{
                border:1px solid #e2e2e2;
                padding-top: 20px;
            }
            .img_style{
                width: 675px;
                height: 250px;
            }
            body{
                background:url(img/Key.jpg);
                background-size: cover;
                background-attachment: fixed;
            }
            </style>
            <div id="fb-root"></div>
<script async defer crossorigin="anonymous" src="https://connect.facebook.net/hi_IN/sdk.js#xfbml=1&version=v11.0" nonce="hUYTvBDH"></script>
    </head>
    <body>
                <%--!navbar--%>
        <nav class="navbar navbar-expand-lg navbar-dark primary-background">
    <a class="navbar-brand" href="index.jsp"><span class="fa fa-asterisk"></span>Learning Media</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="profile.jsp">Home </a>
      </li>
   
      
    <li class="nav-item">
        <a class="nav-link " href="#" data-toggle="modal" data-target="#add-post-modal"><span class="fa fa-bell-o"></span> Do Post</a>
      </li>
      
    </ul>
      <ul class="navbar-nav mr-right">
           <li class="nav-item">
               <a class="nav-link" href="#" data-toggle="modal" data-target="#profile-modal"><span class="fa fa-user-circle"></span><%=user.getName()%></a>
      </li>
           <li class="nav-item">
         <a class="nav-link" href="LogoutServlet"><span class="fa fa-user-plus"></span>Logout</a>
      </li>
      </ul>
    
  </div>
</nav>
      <% Message m=(Message)session.getAttribute("msg");
                            if(m!=null)
                            {
                                %>
                                <div class="alert <%= m.getCssClass()%>" role="alert">
                                <%=m.getContent() %>
                                </div>
                                <%
                                    session.removeAttribute("msg");
                            }
                            
                                %>
      <!--end of navbar-->
      <!--main content of body-->
      <div class="container ">
          <div class="row my-4">
              <div class="col-md-8 offset-md-2">
                  <div class="card">
                      <div class="card-header primary-background text-white">
                          <h4 class="post-title"><%=p.getpTitle()%></h4>
                          
                      </div>
                          <div class="card-body">
                              <img class="card-img-top my-2 img_style"  src="blog_pics/<%= p.getpPic() %>" alt="Card image cap">
                              <div class="row my-3 row-user">
                                  <div class="col-md-8">
                                      <% UserDao ud=new UserDao(ConnectionProvider.getConnection());
                                         
                                      %>
                                      <p class="post-user-info"><a href="#!"><%= ud.getUserByUserId(p.getUserId()).getName()%></a> has Posted</p>
                                  </div>
                                  <div class="col-md-4">
                                      <p class="post-date"><%=DateFormat.getDateTimeInstance().format(p.getpDate())%></p>
                                  </div>
                              </div>
                              <p class="post-content"><%=p.getpContent()%></p>
                              <br>
                              <br>
                              <div class="post-code">
                              <pre><%=p.getpCode()%></pre>
                              </div>
                          </div>
                          
                              <div class="card-footer primary-background text-center">
                                  <% LikeDao ld=new LikeDao(ConnectionProvider.getConnection()); %>
                                  <%
                                      if(!ld.isLikeByUser(p.getPid(), user.getId()))
                                      {
                                      %>
                                      <a href="#!" id="isLike" onclick="doLike(<%=p.getPid()%>,<%=user.getId()%>) " class="btn btn-outline-light bt-sm"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"><%=ld.countLikeOnPost(p.getPid())%> </span></a>
                                      <%
                                      }
                                  %>
                        
                                  
                        <a href="#!" class="btn btn-outline-light bt-sm"><i class="fa fa-commenting-o"></i><span></span></a>
                    </div>
                        <div class="card-footer">
                            <div class="fb-comments" data-href="http://localhost:9494/WebApplication1/show_blog_page.jsp?post_id=<%=p.getPid()%> " data-width="" data-numposts="5"></div>
                            
                        </div>
                         
                  </div>
              </div>
          </div>
      </div>
      <!--end of main content-->
      <!-- Modal -->
<div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header primary-background text-white text-center">
        <h5 class="modal-title" id="exampleModalLabel">Learning Media</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <div class="container text-center">
              <img src="pics/<%=user.getProfile()%>" class="img-fluid" style="border-radius:50%; max-width: 150px;" > </img>
              <br>
         <h5 class="modal-title mt-3" id="exampleModalLabel"><%=user.getName()%></h5>
         <div id="profile-details">
         <table class="table">
  
  <tbody>
    <tr>
      <th scope="row">ID:</th>
      <td><%=user.getId()%></td>
      
    </tr>
    <tr>
      <th scope="row">Email:</th>
      <td><%=user.getEmail()%></td>
      
    </tr>
    <tr>
      <th scope="row">Gender:</th>
      <td><%=user.getGender()%></td>
      
    </tr>
     <tr>
      <th scope="row">About</th>
      <td><%=user.getAbout()%></td>
      
    </tr>
     <tr>
      <th scope="row">Registered on:</th>
      <td><%=user.getDateTime()%></td>
      
    </tr>
  </tbody>
</table>
         </div>
      <div id="profile-edit" style="display:none;">
          
          <h3 class="mt-2">Please Edit Carefully</h3>
          <form action="EditServlet" method="post" enctype="multipart/form-data">
              <table class="table">
                  <tr>
                      <td>ID:</td>
                      <td><%=user.getId()%></td>
                  </tr>
                   <tr>
                      <td>Email:</td>
                      <td><input type="email" class="form-control" name="user_email" value="<%=user.getEmail()%>"></td>
                  </tr>
                  <tr>
                      <td>Name:</td>
                      <td><input type="text" class="form-control" name="user_name" value="<%=user.getName()%>"></td>
                  </tr>
                  <tr>
                      <td>Password:</td>
                      <td><input type="password" class="form-control" name="user_password" value="<%=user.getPassword()%>"></td>
                  </tr>
                  <tr>
                      <td>Gender:</td>
                      <td><%=user.getGender().toUpperCase()%></td>
                  </tr>
                  <tr>
                      <td>About:</td>
                      <td><textarea rows="3" class="form-control" name="user_about">

                          <%=user.getAbout()%>
                          </textarea></td>
                  </tr>
                  
                   <tr>
                        <td>Select new profile</td>
                      <td><input type="file" name="image" class="form-control"></td>
                  </tr>
                  
              </table>
                          <div class="container">
                              <button type="submit" class="btn btn-outline-primary">
                                  Save
                              </button>
                          </div>
                              
                              
              
          </form>
          
      </div>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" id="edit-profile-button" class="btn btn-primary">Edit</button>
      </div>
    </div>
  </div>
</div>
      <!--end of modal-->
      <!--post modal-->
      <!-- Modal -->
<div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Provide the post details</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <form  id="add-post-form" action="AddPostServlet" method="post">
              <div class="form-group">
                  <select class="form-control" name="cid">
                      <option selected disabled>---Select Category--</option>
                      <%
                          PostDao postd=new PostDao(ConnectionProvider.getConnection());
                          ArrayList<Category> list=postd.getAllCategories();
                          for(Category c:list)
                          {
                              %>
                              <option value="<%=c.getCid()%>"><%=c.getName()%></option>
                              <%
                          }
                          
                          
                          %>
                  </select>
              </div>
              <div class="form-group">
                  <input name="pTitle" type="text" placeholder="Enter post Title" class="form-control"/>
              </div>
              
             <div class="form-group">
                 <textarea  name="pContent" class="form-control" style="height:200px;" placeholder="Enter post Content"></textarea>
              </div>
                <div class="form-group">
                  <textarea name="pCode" class="form-control" style="height:200px;"  placeholder="Enter post Program(if any)"></textarea>
              </div>
              <div class="form-group">
                  <lable>Select your pic</lable>
                  <br>
                  <input type="file" name="pic"/>
              </div>
              
              <div class="container text-center">
                  <button type="submit" class="btn btn-outline-primary">POST</button>
              </div>
          </form>
      </div>
     
    </div>
  </div>
</div>
      <!--end of post modal-->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
    
<script src="js/myjs.js" type="text/javascript"></script>
<script>
    $(document).ready(function(){
        let editStatus=false;
        $('#edit-profile-button').click(function(){
            if(editStatus==false)
            {
            $('#profile-details').hide();
            $('#profile-edit').show();
            editStatus=true;
            }
            else
            {
                
            $('#profile-details').show();
            $('#profile-edit').hide();
            editStatus=false;
            }
           
        })
        
    });
    </script>
    <!--add-post-js-->
    <script>
        $(document).ready(function (e)
        {
            $("#add-post-form").on("submit",function(event)
            {
                event.preventDefault();
                console.log("you have sumited..");
                let form=new FormData(this);
                $.ajax({
                    url:"AddPostServlet",
                    type:'POST',
                    data:form,
                    success:function(data,textStatus,jqXHR){
                        console.log(data);
                        if(data.trim()=='done')
                        {
                            swal("Good job!", "saved successfully", "success");
                            
                        }else
                        {
                            swal("Error!", "someething went wrong!", "error");
                        }
                    },
                    error:function(jqXHR,textStatus,errorThrown){
                        swal("Error!", "someething went wrong!", "error");
                    },
                    processData:false,
                    contentType:false
                    
                    
                })
                
            })
        })
        </script>
        
    <!--end of add-post-js-->
    <!--loader-js-->
    <script>
        function getPosts(catId,temp)
        {
            $("#loader").show();
            $("#post-container").hide();
            $(".c-link").removeClass("active");
             $.ajax({
                    url:"load_posts.jsp",
                    data:{cid:catId},
                     success:function(data,textStatus,jqXHR){
                        console.log(data);
                        $("#loader").hide();
                        $("#post-container").show();
                        $("#post-container").html(data);
                        $(temp).addClass("active");
                    }
                    })
        }
        $(document).ready(function (e)
        {
            let allPostRef=$('.c-link')[0]
            getPosts(0,allPostRef)
                    
                })
           
       
        </script>
        <script>
            function doLike(pid,uid)
{
    console.log(pid+","+uid);
            
              
            
    const d={
        uid:uid,
        pid:pid,
        operation:'like'
        
    }
    $.ajax({
        url:"LikeServlet",
        data:d,
        success:function(data,textStatus,jqXHR){
            console.log(data);
            if(data.trim()=='true')
            {
                let c=$(".like-counter").html();
                c++;
                $(".like-counter").html(c);
                
                
            }
        },
        error:function(jqXHR,textStatus,errorThrown)
        {
            console.log(data)
        }
        
    })
}
        </script>
       

            
    </body>
</html>
