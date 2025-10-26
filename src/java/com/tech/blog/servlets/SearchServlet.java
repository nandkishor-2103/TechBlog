package com.tech.blog.servlets;

import com.tech.blog.entities.Post;
import com.tech.blog.helper.ConnectionProvider;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;

public class SearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String search = request.getParameter("query");
        ArrayList<Post> results = new ArrayList<>();
        try {
            Connection con = ConnectionProvider.getConnection();
            String sql = "SELECT * FROM posts WHERE LOWER(pTitle) LIKE LOWER(?) OR LOWER(pContent) LIKE LOWER(?)";
            PreparedStatement ps = con.prepareStatement(sql);
            String q = "%" + search.trim() + "%";
            ps.setString(1, q);
            ps.setString(2, q);
//            System.out.println("Query Used: " + q); // Debug

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Post p = new Post();
                p.setPid(rs.getInt("pid"));
                p.setpTitle(rs.getString("pTitle"));
                p.setpContent(rs.getString("pContent"));
                p.setpCode(rs.getString("pCode"));
                p.setpPic(rs.getString("pPic"));
                p.setpDate(rs.getTimestamp("pDate"));
                p.setCatId(rs.getInt("catId"));
                p.setUserId(rs.getInt("userId"));
                results.add(p);
            }
//            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("searchResults", results);
        request.setAttribute("searchQuery", search);
        //Entry point of HTTP request and response 
        RequestDispatcher rd = request.getRequestDispatcher("search_results.jsp");
        rd.forward(request, response);
    }
}
