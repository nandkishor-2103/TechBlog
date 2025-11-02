package com.tech.blog.servlets;

import com.tech.blog.dao.ShareDao;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ShareServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int pid = Integer.parseInt(req.getParameter("pid"));
        String platform = req.getParameter("platform");

        HttpSession s = req.getSession();
        User user = (User) s.getAttribute("currentUser");

        int userId = 0;
        String userName = "Guest";

        if (user != null) {
            userId = user.getId();
            userName = user.getName();
        }

        ShareDao dao = new ShareDao(ConnectionProvider.getConnection());
        boolean result = dao.saveShare(pid, userId, userName, platform);

        PrintWriter out = resp.getWriter();
        out.print(result ? "true" : "false");
    }
}
