<%@page import="com.tech.blog.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Search Results</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <!--css-->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" crossorigin="anonymous">
    <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body {
            background: #f5f6fa;
        }
        .post-card {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 3px 16px rgba(0,0,0,0.075);
            margin-bottom: 24px;
            padding: 24px 32px;
            max-width: 620px;
            margin-left: auto;
            margin-right: auto;
        }
        .post-title {
            font-size: 26px;
            font-weight: 600;
            color: #3563d1;
            margin-bottom: 8px;
        }
        .post-meta {
            font-size: 14px;
            color: #888;
            margin-bottom: 16px;
        }
        .post-content {
            font-size: 17px;
            color: #222;
        }
        .post-image {
            max-width: 100%;
            height: auto;
            margin-bottom: 16px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .read-more-btn {
            background: #3563d1;
            color: #fff;
            border: none;
            border-radius: 6px;
            padding: 7px 20px;
            font-size: 15px;
            margin-top: 13px;
            cursor: pointer;
            transition: background 0.2s;
        }
        .read-more-btn:hover {
            background: #143c74;
        }
    </style>
    <script>
        function expandContent(id) {
            var snippet = document.getElementById("snippet-" + id);
            var full = document.getElementById("fullcontent-" + id);
            snippet.style.display = "none";
            full.style.display = "block";
        }
    </script>
</head>
<body>
    <%@ include file="normal_navbar.jsp" %> 

    <div class="container" style="margin-top: 80px;">
        <h2 style="color: #3563d1; font-weight:700; margin-bottom:30px;">Search Results for "<%= request.getAttribute("searchQuery")%>"</h2>
        <%
            List<Post> results = (List<Post>) request.getAttribute("searchResults");
            UserDao ud = new UserDao(ConnectionProvider.getConnection());
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            if (results == null || results.size() == 0) {
        %>
        <div class="post-card" style="text-align:center;">
            <img src="pics/no-results.png" style="max-width:110px;margin-bottom:14px;" alt="No result" />
            <div class="post-meta">No blogs found matching your search.</div>
        </div>
        <%
        } else {
            for (Post p : results) {
        %>
        <div class="post-card">

            <div class="post-title">
                <a href="show_blog_page.jsp?post_id=<%= p.getPid()%>" style="text-decoration:none;color:#3563d1;">
                    <%= p.getpTitle()%>
                </a>
            </div>

            <!-- Blog Image -->
            <img src="blog_pics/<%= p.getpPic() %>" alt="Blog Image" class="post-image" />

            <div class="post-meta">
                <b><%= ud.getUserByUserId(p.getUserId()).getName()%></b> Posted on : <b><%= sdf.format(p.getpDate())%></b>
            </div>

            <div class="post-content" id="snippet-<%= p.getPid()%>">
                <%= p.getpContent().length() > 170 ? p.getpContent().substring(0, 170) + "..." : p.getpContent()%>
                <% if (p.getpContent().length() > 170) { %>
                <button class="read-more-btn" onclick="expandContent(<%= p.getPid()%>)">Read More</button>
                <% } %>
            </div>

            <% if (p.getpContent().length() > 170) { %>
            <div class="post-content" id="fullcontent-<%= p.getPid()%>" style="display:none;">
                <%= p.getpContent()%>
            </div>
            <% } %>

        </div>
        <%
            }
        }
        %>
    </div>

    <!--javascript cdn-->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
    <script src="js/myjs.js" type="text/javascript"></script>
</body>
</html>
