package com.tech.blog.dao;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDao {

    private final Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }

    // Fetch all categories
    public List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();
        String query = "SELECT * FROM categories";

        try (Statement st = con.createStatement();
                ResultSet rs = st.executeQuery(query)) {

            while (rs.next()) {
                list.add(new Category(
                        rs.getInt("cid"),
                        rs.getString("name"),
                        rs.getString("description")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Save Post
    public boolean savePost(Post p) {
        String query = "INSERT INTO posts(pTitle, pContent, pCode, pPic, catId, userId) VALUES(?,?,?,?,?,?)";

        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, p.getpTitle());
            pstmt.setString(2, p.getpContent());
            pstmt.setString(3, p.getpCode());
            pstmt.setString(4, p.getpPic());
            pstmt.setInt(5, p.getCatId());
            pstmt.setInt(6, p.getUserId());
            pstmt.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get all posts
    public List<Post> getAllPosts() {
        List<Post> list = new ArrayList<>();
        String query = "SELECT * FROM posts ORDER BY pid DESC";

        try (PreparedStatement pstmt = con.prepareStatement(query);
                ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                list.add(mapPost(rs));
<<<<<<< HEAD
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get posts by category
    public List<Post> getPostByCatId(int catId) {
        List<Post> list = new ArrayList<>();
        String query = "SELECT * FROM posts WHERE catId=? ORDER BY pid DESC";

        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, catId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapPost(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get post by ID
    public Post getPostByPostId(int postId) {
        String query = "SELECT * FROM posts WHERE pid=?";
        Post post = null;

        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, postId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    post = mapPost(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return post;
    }

<<<<<<< HEAD
    // Get posts by user
    public List<Post> getPostsByUserId(int userId) {
        List<Post> list = new ArrayList<>();
        String query = "SELECT * FROM posts WHERE userId=? ORDER BY pid DESC";

        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, userId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapPost(rs));
                }
=======
    // get all posts by a specific user (for "My Posts" page)
    public List<Post> getPostsByUserId(int userId) {
        List<Post> list = new ArrayList<>();
        try {
            String q = "SELECT * FROM posts WHERE userId = ? ORDER BY pid DESC";
            PreparedStatement pstmt = con.prepareStatement(q);
            pstmt.setInt(1, userId);
            ResultSet set = pstmt.executeQuery();

            while (set.next()) {
                int pid = set.getInt("pid");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                String pPic = set.getString("pPic");
                Timestamp date = set.getTimestamp("pDate");
                int catId = set.getInt("catId");

                Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);
                list.add(post);
>>>>>>> Abhilipsa
=======
>>>>>>> TabishV2
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

<<<<<<< HEAD
    // Delete post
    public boolean deletePost(int postId) {
<<<<<<< HEAD
        String query = "DELETE FROM posts WHERE pid=?";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, postId);
            pstmt.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
=======
        boolean success = false;
        try {
            String query = "DELETE FROM posts WHERE pid = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, postId);
            pstmt.executeUpdate();
            success = true;
=======
    // Get posts by category
    public List<Post> getPostByCatId(int catId) {
        List<Post> list = new ArrayList<>();
        String query = "SELECT * FROM posts WHERE catId=? ORDER BY pid DESC";

        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, catId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapPost(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get post by ID
    public Post getPostByPostId(int postId) {
        String query = "SELECT * FROM posts WHERE pid=?";
        Post post = null;

        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, postId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    post = mapPost(rs);
                }
            }
>>>>>>> TabishV2
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
>>>>>>> Abhilipsa
    }

<<<<<<< HEAD
    // Update post
    public boolean updatePost(Post post) {
<<<<<<< HEAD
        String query = "UPDATE posts SET pTitle=?, pContent=?, pCode=?, pPic=?, catId=? WHERE pid=?";

        try (PreparedStatement pstmt = con.prepareStatement(query)) {
=======
        boolean success = false;
        try {
            String query = "UPDATE posts SET pTitle=?, pContent=?, pCode=?, pPic=?, catId=? WHERE pid=?";
            PreparedStatement pstmt = con.prepareStatement(query);
>>>>>>> Abhilipsa
=======
    // Get posts by user
    public List<Post> getPostsByUserId(int userId) {
        List<Post> list = new ArrayList<>();
        String query = "SELECT * FROM posts WHERE userId=? ORDER BY pid DESC";

        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, userId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapPost(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Delete post
    public boolean deletePost(int postId) {
        String query = "DELETE FROM posts WHERE pid=?";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, postId);
            pstmt.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update post
    public boolean updatePost(Post post) {
        String query = "UPDATE posts SET pTitle=?, pContent=?, pCode=?, pPic=?, catId=? WHERE pid=?";

        try (PreparedStatement pstmt = con.prepareStatement(query)) {
>>>>>>> TabishV2
            pstmt.setString(1, post.getpTitle());
            pstmt.setString(2, post.getpContent());
            pstmt.setString(3, post.getpCode());
            pstmt.setString(4, post.getpPic());
            pstmt.setInt(5, post.getCatId());
            pstmt.setInt(6, post.getPid());
            pstmt.executeUpdate();
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> TabishV2
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Helper method to map ResultSet → Post object
    private Post mapPost(ResultSet rs) throws Exception {
        return new Post(
                rs.getInt("pid"),
                rs.getString("pTitle"),
                rs.getString("pContent"),
                rs.getString("pCode"),
                rs.getString("pPic"),
                rs.getTimestamp("pDate"),
                rs.getInt("catId"),
                rs.getInt("userId"));
    }
}
<<<<<<< HEAD
=======
            success = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

}
>>>>>>> Abhilipsa
=======
>>>>>>> TabishV2
