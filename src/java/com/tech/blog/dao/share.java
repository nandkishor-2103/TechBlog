package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class ShareDao {

    private Connection con;

    public ShareDao(Connection con) {
        this.con = con;
    }

    public boolean saveShare(int pid, int userId, String userName, String platform) {
        boolean f = false;
        try {
            String query = "INSERT INTO shares(pid, userId, user_name, share_platform) VALUES(?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, pid);
            ps.setInt(2, userId);
            ps.setString(3, userName);
            ps.setString(4, platform);
            ps.executeUpdate();
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
}