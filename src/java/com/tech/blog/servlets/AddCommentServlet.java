package com.tech.blog.servlets;

import com.tech.blog.dao.CommentDao;
import com.tech.blog.entities.Comment;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import java.io.IOException;
import java.sql.Timestamp;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AddCommentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");

        // Return error if user is not logged in
        if (user == null) {
            response.getWriter().println("error: not logged in");
            return;
        }

        try {
            int postId = Integer.parseInt(request.getParameter("postId"));
            String content = request.getParameter("content");
            String parentCommentIdStr = request.getParameter("parentCommentId");

            Integer parentCommentId = null;
            if (parentCommentIdStr != null && !parentCommentIdStr.isEmpty()) {
                parentCommentId = Integer.parseInt(parentCommentIdStr);
            }

            Comment comment = new Comment();
            comment.setPostId(postId);
            comment.setUserId(user.getId());
            comment.setContent(content);
            comment.setCommentedOn(new Timestamp(System.currentTimeMillis()));
            comment.setParentCommentId(parentCommentId);

            CommentDao commentDao = new CommentDao(ConnectionProvider.getConnection());
            boolean success = commentDao.addComment(comment);

            if (success) {
                response.getWriter().println("done");
            } else {
                response.getWriter().println("error");
            }
        } catch (Exception e) {
            e.printStackTrace(); // This will go to server log
            response.getWriter().println("error: " + e.getMessage());
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet to add new comments or replies to posts";
    }
}