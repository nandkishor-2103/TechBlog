<%@page import="java.util.List"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Redirect if not logged in
    if (session.getAttribute("currentUser") == null) {
        response.sendRedirect("login_page.jsp");
        return;
    }

    User user = (User) session.getAttribute("currentUser");
    PostDao postDao = new PostDao(ConnectionProvider.getConnection());
    List<Post> myPosts = postDao.getPostsByUserId(user.getId());
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Posts - TechBlog</title>

    <!-- Bootstrap & Font Awesome -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" crossorigin="anonymous" referrerpolicy="no-referrer" />

    <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>

    <style>
        body {
            background-color: #f8f9fa;
        }
        .banner-background {
            clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 91%, 63% 100%, 22% 91%, 0 99%, 0 0);
        }
        .card {
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            margin-bottom: 24px;
            background-color: white;
        }
        .card-body b {
            font-size: 18px;
            color: #3563d1;
        }
        .card-content {
            margin-top: 8px;
            font-size: 16px;
            color: #333;
            line-height: 1.5;
        }
        .read-more-btn {
            background-color: #3563d1;
            color: white;
            border: none;
            padding: 5px 15px;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }
        .read-more-btn:hover {
            background-color: #143c74;
        }
        .card-img-top {
            max-width: 100%;
            max-height: 180px;
            object-fit: cover;
            border-radius: 4px;
            margin-bottom: 10px;
        }
        .bookmarked {
            background-color: #f1c40f !important;
            color: white !important;
            border-color: #f1c40f !important;
        }
        .bookmarked i {
            color: white !important;
        }
        .btn-outline-warning i {
            margin-right: 5px;
        }
        .bookmark-btn {
            transition: all 0.3s ease;
        }
        .bookmark-btn:hover {
            background-color: #f1c40f;
            color: white;
        }
    </style>
</head>

<body>

    <%@include file="normal_navbar.jsp" %>

    <div class="container mt-5">
        <h2 class="text-center mb-4">My Posts</h2>

        <%
            if (myPosts == null || myPosts.isEmpty()) {
        %>
            <div class="alert alert-info text-center">
                You haven't created any posts yet.
            </div>
        <%
            } else {
        %>
        <div class="row">
            <%
                for (Post post : myPosts) {
            %>
            <div class="col-md-4 mt-3">
                <div class="card" style="max-width: 380px; margin: 0 auto;">
                    <img class="card-img-top" src="blog_pics/<%= post.getpPic() %>" alt="Post image">
                    <div class="card-body">
                        <h5 class="card-title font-weight-bold" style="color: #232d3b; font-size: 1.4rem;">
                            <%= post.getpTitle() %>
                        </h5>

                        <p class="card-text" style="color: #4c5c68; font-size: 1rem;">
                            <%
                                String content = post.getpContent();
                                if (content.length() > 140) {
                                    out.print(content.substring(0, 140) + "...");
                                } else {
                                    out.print(content);
                                }
                            %>
                        </p>

                        <div class="d-flex justify-content-between align-items-center">
                            <a href="show_blog_page.jsp?post_id=<%= post.getPid() %>" class="btn btn-outline-primary btn-sm">
                                <i class="fa fa-eye"></i> Read More
                            </a>

                            <a href="edit_post.jsp?post_id=<%= post.getPid() %>" class="btn btn-outline-secondary btn-sm">
                                <i class="fa fa-pencil"></i> Edit
                            </a>

                            <a href="RemovePost?post_id=<%= post.getPid() %>" class="btn btn-outline-danger btn-sm"
                               onclick="return confirm('Are you sure you want to delete this post?');">
                                <i class="fa fa-trash"></i> Delete
                            </a>
                        </div>

                        <!-- ✅ Save/Bookmark button clearly visible -->
                        <div class="text-right mt-3">
                            <button class="bookmark-btn btn btn-outline-warning btn-sm"
                                    onclick="toggleBookmark(<%= post.getPid() %>, <%= user.getId() %>, this)">
                                <i class="fa fa-bookmark"></i>
                                <span class="bookmark-text"> Save</span>
                            </button>
                        </div>

                    </div>
                </div>
            </div>
            <%
                }
            %>
        </div>
        <%
            }
        %>
    </div>

    <!-- JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>

    <script>
        function toggleBookmark(pid, uid, btn) {
            $.ajax({
                url: 'BookmarkServlet',
                type: 'POST',
                data: { operation: 'bookmark', pid: pid, uid: uid },
                success: function (response) {
                    if (response.trim() === 'added') {
                        $(btn).addClass('bookmarked');
                        $(btn).find('.bookmark-text').text('Saved');
                    } else if (response.trim() === 'removed') {
                        $(btn).removeClass('bookmarked');
                        $(btn).find('.bookmark-text').text('Save');
                    } else {
                        alert("Something went wrong!");
                    }
                },
                error: function () {
                    alert("Error while saving the post.");
                }
            });
        }
    </script>

</body>
</html>
