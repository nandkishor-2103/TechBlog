package com.tech.blog.servlets;

import com.tech.blog.dao.PostDao;
import com.tech.blog.entities.Post;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;
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


// “This servlet will receive multipart/form-data requests (typically used for file uploads).”
@MultipartConfig
//servlet extends HttpServlet so it can handle HTTP requests (GET, POST, etc.)
public class AddPostServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    //processRequest is a common pattern to centralize GET/POST handling (both doGet and doPost call it).
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
//            Retrieves form parameter cid (category id).
// Validates: if missing/empty, immediately returns "error" to the client.

            String cidStr = request.getParameter("cid");
            if (cidStr == null || cidStr.trim().isEmpty()) {
                out.print("error");
                return;
            }
// Converts string to int with Integer.parseInt. (If cidStr isn't numeric, NumberFormatException will be thrown — not explicitly caught here.)
           
            int cid = Integer.parseInt(cidStr);
            String pTitle = request.getParameter("pTitle");
            String pContent = request.getParameter("pContent");
            String pCode = request.getParameter("pCode");
            // request.getPart("pic") obtains the uploaded file part named pic from the multipart form.
            Part part = request.getPart("pic");
            
            //Retrieves HttpSession for the request.
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("currentUser");  // Get (retrieve) the value stored in the current session under the name "currentUser".
            if (user == null) {
                out.print("error");
                return;
            }

            Post p = new Post(pTitle, pContent, pCode,
                    part.getSubmittedFileName(), null, cid, user.getId());

            PostDao dao = new PostDao(ConnectionProvider.getConnection());

            if (dao.savePost(p)) {
                if (part != null && part.getSize() > 0) {
                    // request.getRealPath("/") returns the absolute path of the webapp root on the server filesystem
                    String path = request.getRealPath("/") + "blog_pics" + File.separator + part.getSubmittedFileName();
                    Helper.saveFile(part.getInputStream(), path);
                }
                out.print("done");
            } else {
                out.print("error");
            }
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