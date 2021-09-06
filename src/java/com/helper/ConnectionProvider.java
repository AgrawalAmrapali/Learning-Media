/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.helper;
import java.sql.*;

/**
 *
 * @author acer
 */
public class ConnectionProvider {
    private static Connection conn;
    public static Connection getConnection()
    {
        try
        {
        if(conn==null)
        {

            Class.forName("com.mysql.jdbc.Driver");
            conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/webapp","root","9649726949");
        }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return conn;
    }
}
