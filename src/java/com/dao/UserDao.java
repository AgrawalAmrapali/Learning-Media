
package com.dao;

import com.entities.User;
import java.sql.*;

public class UserDao {
    private Connection con;

    public  UserDao(Connection con) {
        this.con = con;
    }
    public boolean saveUser(User user)
    {
        boolean f=false;
        try{
        String query="insert into user(name,email,password,gender,about) values(?,?,?,?,?)";
        PreparedStatement pstmt=this.con.prepareStatement(query);
        pstmt.setString(1, user.getName());
        pstmt.setString(2, user.getEmail());
        pstmt.setString(3, user.getPassword());
        pstmt.setString(4, user.getGender());
        pstmt.setString(5, user.getAbout());
        pstmt.executeUpdate();
        f=true;
        
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        return f;
        
    }
    //function for login user through email and password
    public User getUserByEmailAndPassword(String email,String password)
    {
        User user=null;
        try{
            String query="select * from user where email=?and password=?";
            PreparedStatement pstmt=this.con.prepareStatement(query);
            pstmt.setString(1,email);
            pstmt.setString(2, password);
            ResultSet set=pstmt.executeQuery();
            if(set.next())
            {
                user=new User();
                String name=set.getString("name");
                user.setName(name);
                user.setEmail(set.getString("email"));
                user.setPassword(set.getString("password"));
                user.setAbout(set.getString("about"));
                user.setId(set.getInt("id"));
                user.setGender(set.getString("gender"));
                user.setDateTime(set.getTimestamp("rtime"));
                user.setProfile(set.getString("profile"));
                
            }
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        return user;
    }
    public boolean updateUser(User user)
    {
         boolean f=false;
        try{
           
        String query="update user set name=? , email=? , password=? , about=? , profile=? , gender=? where id=?";
        PreparedStatement pstmt=this.con.prepareStatement(query);
        System.out.println(user.getName());
        pstmt.setString(1,user.getName());
        pstmt.setString(2,user.getEmail());
        pstmt.setString(3,user.getPassword());
        pstmt.setString(4,user.getAbout());
        pstmt.setString(5,user.getProfile());
        pstmt.setString(6,user.getGender());
        pstmt.setInt(7,user.getId());
        pstmt.executeUpdate();
        f=true;
        
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        return f;
        
        
    }
    public User getUserByUserId(int userId)
    {
        User user=null;
        try{
        String q="select * from user where id=?";
        PreparedStatement pstmt=con.prepareStatement(q);
        pstmt.setInt(1, userId);
        ResultSet set=pstmt.executeQuery();
        if(set.next())
        {
            user=new User();
                String name=set.getString("name");
                user.setName(name);
                user.setEmail(set.getString("email"));
                user.setPassword(set.getString("password"));
                user.setAbout(set.getString("about"));
                user.setId(set.getInt("id"));
                user.setGender(set.getString("gender"));
                user.setDateTime(set.getTimestamp("rtime"));
                user.setProfile(set.getString("profile"));
        }
          }catch(Exception e)
          {
              e.printStackTrace();
          }
        
        
        return user;
    }
}
