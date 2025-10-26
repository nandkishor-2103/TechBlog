
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
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    HttpSession session = request.getSession();
    User user = (User) session.getAttribute("currentUser");

    String userName = request.getParameter("user_name");
    String userPassword = request.getParameter("user_password");
    String userAbout = request.getParameter("user_about");

    Part part = request.getPart("image");
    String imageName = part.getSubmittedFileName();

    // Keep old image if no new file uploaded
    String oldFile = user.getProfile();
    if (imageName == null || imageName.trim().isEmpty()) {
        imageName = oldFile;
    }

    user.setName(userName);
    user.setPassword(userPassword);
    user.setAbout(userAbout);
    user.setProfile(imageName);

    UserDao userDao = new UserDao(ConnectionProvider.getConnection());
    boolean updated = userDao.updateUser(user);

    if (updated) {
        String uploadDir = getServletContext().getRealPath("/") + "pics" + File.separator;
        String newFilePath = uploadDir + imageName;
        String oldFilePath = uploadDir + oldFile;

        if (!oldFile.equals("default.png") && !oldFile.equals(imageName)) {
            Helper.deleteFile(oldFilePath);
        }

        if (!imageName.equals(oldFile)) {
            Helper.saveFile(part.getInputStream(), newFilePath);
        }

        session.setAttribute("msg", new Message("Profile updated successfully!", "success", "alert-success"));
    } else {
        session.setAttribute("msg", new Message("Something went wrong!", "error", "alert-danger"));
    }

    response.sendRedirect("profile.jsp");
}
