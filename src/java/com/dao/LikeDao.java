/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;
import java.sql.*;

/**
 *
 * @author acer
 */
public class LikeDao {
    Connection con;

    public LikeDao(Connection con) {
        this.con = con;
    }
    public boolean insertLike(int pid,int uid)
    {
        boolean f=false;
        try{
            String q="insert into liked(pid,uid) values(?,?)";
            PreparedStatement psmt=con.prepareStatement(q);
            psmt.setInt(1, pid);
            psmt.setInt(2, uid);
            psmt.executeUpdate();
            f=true;
            
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        return f;
    }
    public int countLikeOnPost(int pid)
    {
        int cn=0;
        try{
        String q="select count(*) from liked where pid=?";
        PreparedStatement psmt=con.prepareStatement(q);
         psmt.setInt(1, pid);
         ResultSet set=psmt.executeQuery();
         if(set.next())
         {
             cn=set.getInt("count(*)");
         }
            }catch(Exception e)
             {
                e.printStackTrace();
             }
        return cn;
    }
    public boolean isLikeByUser(int pid,int uid)
    {
        boolean f=false;
        try{
            String q="select * from liked where pid=? and uid=?";
            PreparedStatement psmt=con.prepareStatement(q);
            psmt.setInt(1, pid);
            psmt.setInt(2, uid);
            ResultSet set=psmt.executeQuery();
           if(set.next())
         {
             f=true;
         }
           
            
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        return f;
    }
     public boolean deleteLike(int pid,int uid)
    {
        boolean f=false;
        try{
            String q="delete from liked where pid=? and uid=?";
            PreparedStatement psmt=con.prepareStatement(q);
            psmt.setInt(1, pid);
            psmt.setInt(2, uid);
            psmt.executeUpdate();
            f=true;
            
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        return f;
    }
    
}
