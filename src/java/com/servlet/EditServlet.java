/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import com.dao.UserDao;
import com.entities.Message;
import com.entities.User;
import com.helper.ConnectionProvider;
import com.helper.helper;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author acer
 */
@MultipartConfig
public class EditServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            String userEmail=(String)request.getParameter("user_email");
            String userName=(String)request.getParameter("user_name");
             String userAbout=(String)request.getParameter("user_about");
            String userPassword=(String)request.getParameter("user_password");
            Part part=request.getPart("image");
            String imageName=part.getSubmittedFileName();
            HttpSession s=request.getSession();
            User user=(User)s.getAttribute("currentUser");
            
            user.setEmail(userEmail);
            user.setAbout(userAbout);
            user.setName(userName);
            user.setPassword(userPassword);
            String old=user.getProfile();
            user.setProfile(imageName);
            UserDao dao=new UserDao(ConnectionProvider.getConnection());
            boolean ans=dao.updateUser(user);
            if(ans)
            {
                String path=request.getRealPath("/")+"pics"+File.separator+user.getProfile();
                String oldpath=request.getRealPath("/")+"pics"+File.separator+old;
                if(!old.equals("default.png"))
                {
                    helper.deleteFile(oldpath);
                }
                if(helper.saveFile(part.getInputStream(), path))
                {
                    out.println("done");
                    Message msg=new Message("Profile Updated...","success","alert-success");
                
                s.setAttribute("msg", msg);
          
                    
                }
                else
                {
                 Message msg=new Message("Profile Updated...","success","alert-success");
                
                s.setAttribute("msg", msg);   
                }
                
                
            }
            else
            {
                out.println(" not done");
                Message msg=new Message("Something went wrong.....","error","alert-danger");
                
                s.setAttribute("msg", msg);
            }
                  response.sendRedirect("profile.jsp");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
