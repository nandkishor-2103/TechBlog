
import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//enables multipart/form-data handling so you can call request.getPart("pic") to access uploaded files.
@MultipartConfig
public class EditServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
//    This method is called by both doGet() and doPost().
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {  // used to send data to the client (browser)
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditServlet</title>");
            out.println("</head>");
            out.println("<body>");
//Get a writer object (out) that allows the servlet to send text output (like HTML) back to the client’s browser.”
            // Fetch all data from the request
            String userEmail = request.getParameter("user_email");
            String userName = request.getParameter("user_name");
            String userPassword = request.getParameter("user_password");
            String userAbout = request.getParameter("user_about");
            Part part = request.getPart("image"); //gets the uploaded file (profile picture).

    String userName = request.getParameter("user_name");
    String userPassword = request.getParameter("user_password");
    String userAbout = request.getParameter("user_about");

            //get the user from the session...and update the data
            // Update user object with new data
            HttpSession s = request.getSession();
            User user = (User) s.getAttribute("currentUser");
            user.setName(userName);
            user.setEmail(userEmail);
            user.setPassword(userPassword);
            user.setAbout(userAbout);
            String oldFile = user.getProfile();

            user.setProfile(imageName);

            //update database....
            UserDao userDao = new UserDao(ConnectionProvider.getConnection());

            boolean ans = userDao.updateUser(user);
            if (ans) {
                out.println("updated to db");
                // gives your web application’s root directory on the server.
                String path = request.getRealPath("/") + "pics" + File.separator + user.getProfile();

                // delete older profile photos
                String pathOldFile = request.getRealPath("/") + "pics" + File.separator + oldFile;
                
                if(!oldFile.equals("default.png")) {
                    Helper.deleteFile(pathOldFile);
                }
                // Save the new uploaded image
                if (Helper.saveFile(part.getInputStream(), path)) {  // used to read data from the client (browser)
                    out.println("Profile updated...");
                    Message msg = new Message("Profile details updated successfully...", "success", "alert-success");
                    s.setAttribute("msg", msg);
                } else {
                    Message msg = new Message("Somenthing went wrong...", "error", "alert-danger");
                    s.setAttribute("msg", msg);
                }

            } else {
                out.println("not updated...");
                Message msg = new Message("Somenthing went wrong...", "error", "alert-danger");
                s.setAttribute("msg", msg);

            }
            // Redirect back to profile page
            response.sendRedirect("profile.jsp");

            out.println("</body>");
            out.println("</html>");
        }
    }

    user.setName(userName);
    user.setPassword(userPassword);
    user.setAbout(userAbout);
    user.setProfile(imageName);

    UserDao userDao = new UserDao(ConnectionProvider.getConnection());
    boolean updated = userDao.updateUser(user);


        session.setAttribute("msg", new Message("Profile updated successfully!", "success", "alert-success"));
    } else {
        session.setAttribute("msg", new Message("Something went wrong!", "error", "alert-danger"));
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
