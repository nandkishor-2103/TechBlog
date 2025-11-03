package com.tech.blog.entities;

import java.sql.Timestamp;

public class Share {

    private int sid;
    private int pid;
    private int userId;
    private String userName;
    private String sharePlatform;
    private Timestamp shareTime;

    // ✅ Constructors
    public Share() {
    }

    public Share(int sid, int pid, int userId, String userName, String sharePlatform, Timestamp shareTime) {
        this.sid = sid;
        this.pid = pid;
        this.userId = userId;
        this.userName = userName;
        this.sharePlatform = sharePlatform;
        this.shareTime = shareTime;
    }

    // ✅ Getters and Setters
    public int getSid() {
        return sid;
    }

    public void setSid(int sid) {
        this.sid = sid;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getSharePlatform() {
        return sharePlatform;
    }

    public void setSharePlatform(String sharePlatform) {
        this.sharePlatform = sharePlatform;
    }

    public Timestamp getShareTime() {
        return shareTime;
    }

    public void setShareTime(Timestamp shareTime) {
        this.shareTime = shareTime;
    }
}