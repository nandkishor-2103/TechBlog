package com.tech.blog.entities;

import java.sql.Timestamp;

public class Comment {

    private String userName;
    private int commentId;
    private String commentUser;
    private int postId;
    private int userId;
    private String content;
    private Timestamp commentedOn;
    private Integer parentCommentId; // Nullable for top-level comments

    public Comment() {
    }

    public Comment(int commentId, int postId, int userId, String content, Timestamp commentedOn,
            Integer parentCommentId, String userName, String commentUser) {
        this.commentId = commentId;
        this.commentUser = commentUser;
        this.postId = postId;
        this.userId = userId;
        this.content = content;
        this.commentedOn = commentedOn;
        this.parentCommentId = parentCommentId;
        this.userName = userName;
    }

    public String getCommentUser() {
        return commentUser;
    }

    public void setCommentUser(String commentUser) {
        this.commentUser = commentUser;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    // Getters and setters
    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getCommentedOn() {
        return commentedOn;
    }

    public void setCommentedOn(Timestamp commentedOn) {
        this.commentedOn = commentedOn;
    }

    public Integer getParentCommentId() {
        return parentCommentId;
    }

    public void setParentCommentId(Integer parentCommentId) {
        this.parentCommentId = parentCommentId;
    }
}