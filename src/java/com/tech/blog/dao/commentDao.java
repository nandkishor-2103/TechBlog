package com.tech.blog.dao;

import com.tech.blog.entities.Comment;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CommentDao {

    private Connection con;

    public CommentDao(Connection con) {
        this.con = con;
    }

    // Add a new comment or reply
    public boolean addComment(Comment comment) {
        boolean result = false;
        try {
            String query = "INSERT INTO comments(post_id, user_id, content, commented_on, parent_comment_id) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, comment.getPostId());
            ps.setInt(2, comment.getUserId());
            ps.setString(3, comment.getContent());
            ps.setTimestamp(4, comment.getCommentedOn());
            if (comment.getParentCommentId() != null) {
                ps.setInt(5, comment.getParentCommentId());
            } else {
                ps.setNull(5, java.sql.Types.INTEGER);
            }
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                result = true;
            }
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // Get top-level comments for a post (parent_comment_id IS NULL)
    public List<Comment> getCommentsByPostId(int postId) {
        List<Comment> list = new ArrayList<>();
        try {
            String query = "SELECT c.*, u.name AS user_name "
                    + "FROM comments c JOIN user u ON c.user_id = u.id "
                    + "WHERE c.post_id = ? AND c.parent_comment_id IS NULL ORDER BY c.commented_on DESC";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, postId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Comment c = new Comment();
                c.setCommentId(rs.getInt("comment_id"));
                c.setPostId(rs.getInt("post_id"));
                c.setUserId(rs.getInt("user_id"));
                c.setContent(rs.getString("content"));
                c.setCommentedOn(rs.getTimestamp("commented_on"));
                c.setParentCommentId(null);
                c.setUserName(rs.getString("user_name")); // <-- Set username
                list.add(c);
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get replies for a comment
    public List<Comment> getRepliesByCommentId(int commentId) {
        List<Comment> list = new ArrayList<>();
        try {
            String query = "SELECT c.*, u.name AS user_name "
                    + "FROM comments c JOIN user u ON c.user_id = u.id "
                    + "WHERE c.parent_comment_id = ? ORDER BY c.commented_on ASC";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, commentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Comment c = new Comment();
                c.setCommentId(rs.getInt("comment_id"));
                c.setPostId(rs.getInt("post_id"));
                c.setUserId(rs.getInt("user_id"));
                c.setContent(rs.getString("content"));
                c.setParentCommentId(rs.getObject("parent_comment_id") != null ? rs.getInt("parent_comment_id") : null);
                c.setUserName(rs.getString("user_name"));

                list.add(c);
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}