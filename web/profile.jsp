<%@page import="java.util.ArrayList"%>
<%@page import="com.entities.Category"%>
<%@page import="com.dao.PostDao"%>
<%@page import="com.helper.ConnectionProvider"%>
<%@page import="com.entities.Message"%>
<%@page import="com.entities.User"%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="Error_Page.jsp" %>

<%
    
    User user=(User)session.getAttribute("currentUser");
    
    if(user==null)
    {
       response.sendRedirect("login.jsp");
    }
    
    %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Page</title>
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
        <%--!navbar--%>
        <nav class="navbar navbar-expand-lg navbar-dark primary-background">
    <a class="navbar-brand" href="index.jsp"><span class="fa fa-asterisk"></span>Learning Media</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="#">Home </a>
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
      <!--start of modal-->
      <!-- Button trigger modal -->
      <main>
          <div clas="container">
              
              <div class="row mt-2 offset-md-1">
                  <div class="col-md-4 mt-2">
                      <div class="list-group">
                       <a href="#" onclick="getPosts(0,this)" class="c-link list-group-item list-group-item-action active">
                        All Posts
                        </a>
                          <%
                          PostDao postdao=new PostDao(ConnectionProvider.getConnection());
                          ArrayList<Category> list1=postdao.getAllCategories();
                          for(Category cc:list1)
                          {
                              %>
                               <a href="#" onclick="getPosts(<%=cc.getCid()%>,this)" class="c-link list-group-item list-group-item-action"><%=cc.getName()%></a>
                              <%
                          }
                          
                          
                          %>
                       
                        
                    </div>
                  </div>
                  
                  <div class="col-md-8" >
                      <div class="container text-center" id="loader">
                          <i class="fa fa-refresh fa-4x fa-spin"></i>
                          <h3>Loading...</h3>
                      </div>
                      <div  class="container-fluid" id="post-container">
                              
                          </div>
                      
                  </div>
                          
              </div>
              
          </div>
      </main>


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
        
    </body>
</html>
