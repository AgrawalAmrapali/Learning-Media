/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;
import com.entities.Category;
import com.entities.Post;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author acer
 */
public class PostDao {
    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }
    public ArrayList<Category> getAllCategories()
    {
        ArrayList<Category> list=new ArrayList<>();
        try
        {
            
            String q="select * from categories";
            Statement st=this.con.createStatement();
            ResultSet set=st.executeQuery(q);
            while(set.next())
            {
                int cid=set.getInt("cid");
                String name=set.getString("name");
                String description=set.getString("description");
                Category c=new Category(cid,name,description);
                list.add(c);
                
            }
            
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        return list;
    }
    public boolean savePost(Post p)
    {
        boolean f=false;
        try{
            
            String q="insert into posts(pTitle,pContent,pCode,pPic,catId,userId) value(?,?,?,?,?,?)";
            PreparedStatement pstmt=con.prepareStatement(q);
            pstmt.setString(1, p.getpTitle());
            pstmt.setString(2, p.getpContent());
            pstmt.setString(3, p.getpCode());
            pstmt.setString(4, p.getpPic());
            pstmt.setInt(5, p.getCatId());
            pstmt.setInt(6, p.getUserId());
            pstmt.executeUpdate();
            f=true;
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        return f;
    }
    public List<Post>getAllPosts()
    {
        List<Post>list=new ArrayList<Post>();
        try{
            PreparedStatement pstmt=con.prepareStatement("select * from posts order by pid desc");
            ResultSet set=pstmt.executeQuery();
            while(set.next())
            {
                int pid=set.getInt("pid");
                String pContent=set.getString("pContent");
                String pCode=set.getString("pCode");
                String pPic=set.getString("pPic");
                String pTitle=set.getString("pTitle");
                Timestamp date=set.getTimestamp("pDate");
                int catId=set.getInt("catId");
                int userId=set.getInt("userId");
                Post post=new Post(pid,pTitle,pContent,pCode,pPic,date,catId,userId);
                list.add(post);
                
                
            }
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return list;
        
    }
     public List<Post>getPostByCatId(int catId)
    {
        List<Post>list=new ArrayList<Post>();
         try{
            PreparedStatement pstmt=con.prepareStatement("select * from posts where catId=?");
            pstmt.setInt(1, catId);
            ResultSet set=pstmt.executeQuery();
            while(set.next())
            {
                int pid=set.getInt("pid");
                String pContent=set.getString("pContent");
                String pCode=set.getString("pCode");
                String pPic=set.getString("pPic");
                String pTitle=set.getString("pTitle");
                Timestamp date=set.getTimestamp("pDate");
                
                int userId=set.getInt("userId");
                Post post=new Post(pid,pTitle,pContent,pCode,pPic,date,catId,userId);
                
                list.add(post);
                
            }
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return list;
        
    }
     public Post getPostByPostId(int postId)
     {   
         Post p=null;
         String q="select * from posts where pid=?";
         try{
          PreparedStatement pstmt=con.prepareStatement(q);
          pstmt.setInt(1, postId);
          ResultSet set=pstmt.executeQuery();
          if(set.next())
          {
                int pid=set.getInt("pid");
                String pContent=set.getString("pContent");
                String pCode=set.getString("pCode");
                String pPic=set.getString("pPic");
                String pTitle=set.getString("pTitle");
                Timestamp date=set.getTimestamp("pDate");
                int catId=set.getInt("catId");
                int userId=set.getInt("userId");
                p=new Post(pid,pTitle,pContent,pCode,pPic,date,catId,userId);
              
          }
         }catch(Exception e)
         {
             e.printStackTrace();
         }
          return p;
         
     }
    
}
