<%@page import="com.entities.User"%>
<%@page import="com.dao.LikeDao"%>
<%@page import="java.util.List"%>
<%@page import="com.entities.Post"%>
<%@page import="com.helper.ConnectionProvider"%>
<%@page import="com.dao.PostDao"%>
<div class="row">

<%
    User user=(User)session.getAttribute("currentUser");
    PostDao dao=new PostDao(ConnectionProvider.getConnection());
    int cid=Integer.parseInt(request.getParameter("cid"));
     List<Post> list;
    if(cid==0)
     list =dao.getAllPosts();
    else
        list=dao.getPostByCatId(cid);
    if(list.size()==0)
    {
        out.println("<h3 class='display-3 text-center'>No post int this category..</h3>");
        return;
    }
    for(Post p:list)
    {
        %>
        <div class="col-md-5 mt-2">
            <div class="card">
                <img class="card-img-top" src="blog_pics/<%= p.getpPic() %>" alt="Card image cap">
                <div class="card-body">
                    <b> <%= p.getpTitle() %> </b>
                    <p><%=p.getpContent()%> </p>
                    
                </div>
                    <div class="card-footer primary-background text-center">
                        <% LikeDao ld=new LikeDao(ConnectionProvider.getConnection());%>
                        
                        <a href="show_blog_page.jsp?post_id=<%=p.getPid()%>" class="btn btn-outline-light bt-sm">Read More...</a>
                                    <%
                                      if(!ld.isLikeByUser(p.getPid(), user.getId()))
                                      {
                                      %>
                                      <a href="#!" id="isLike" onclick="doLike(<%=p.getPid()%>,<%=user.getId()%>) " class="btn btn-outline-light bt-sm"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"><%=ld.countLikeOnPost(p.getPid())%> </span></a>
                                      <%
                                      }
                                  %>
                        
                    </div>
                        
            </div>
                
        </div>
             
             
        <%
    }
    
    %>
</div>
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
         
    