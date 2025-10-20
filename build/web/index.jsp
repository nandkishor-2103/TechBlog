<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashSet"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TechBlog - Home</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" 
              integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" 
              crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
                clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 91%, 63% 100%, 22% 91%, 0 99%, 0 0);
            }
            .btn-liked {
                pointer-events: none;
                opacity: 0.6;
                color: #ccc !important;
                border-color: #ccc !important;
                background-color: #f8f9fa !important;
            }
        </style>
    </head>
    <body>
        <!--navbar-->
        <%@include file="normal_navbar.jsp" %>
        <!-- DO NOT redeclare User currentUser; it's available from navbar include! -->

        <!--banner-->
        <div class="container-fluid p-0 m-0">
            <div class="jumbotron primary-background text-white banner-background">
                <div class="container">
                    <h3 class="display-3">Welcome to TechBlog </h3>
                    <p>Welcome to technical blog, world of technology
                        A programming language is a formal language, which comprises a set of instructions that produce various kinds of output. Programming languages are used in computer programming to implement algorithms.
                    </p>
                    <p>
                        Most programming languages consist of instructions for computers. There are programmable machines that use a set of specific instructions, rather than general programming languages.
                    </p>
                    <button class="btn btn-outline-light btn-lg"> 
                        <span class="fa fa-user-plus"></span>  Start! It's Free
                    </button>
                    <a href="login_page.jsp" class="btn btn-outline-light btn-lg"> 
                        <span class="fa fa-user-circle fa-spin"></span>  Login
                    </a>
                </div>
            </div>
        </div>

        <!--posts-->
        <div class="container">
            <div class="row">
                <%                    // Get currentUser directly (available from navbar include)
                    PostDao postDao = new PostDao(ConnectionProvider.getConnection());
                    LikeDao likeDao = new LikeDao(ConnectionProvider.getConnection());
                    List<Post> posts = postDao.getAllPosts();

                    if (posts == null || posts.isEmpty()) {
                %>
                <div class="col-12">
                    <h3 class="display-3 text-center">No Posts Available</h3>
                </div>
                <%
                } else {
                    // Use currentUser set in navbar include!
                    HashSet<Integer> likedPostIds = new HashSet<>();
                    if (currentUser != null) {
                        for (Post post : posts) {
                            if (likeDao.isLikedByUser(post.getPid(), currentUser.getId())) {
                                likedPostIds.add(post.getPid());
                            }
                        }
                    }
                    for (Post post : posts) {
                        boolean userLiked = currentUser != null && likedPostIds.contains(post.getPid());
                %>
                <div class="col-md-6 mt-2">
                    <div class="card">
                        <img class="card-img-top" src="blog_pics/<%= post.getpPic()%>" alt="Card image cap">
                        <div class="card-body">
                            <b><%= post.getpTitle()%></b>
                            <p><%= post.getpContent()%></p>
                        </div>
                        <div class="card-footer primary-background text-center">
                            <%
                                int likeCount = likeDao.countLikeOnPost(post.getPid());
                            %>
                            <% if (currentUser != null) {%>
                            <a href="#!" 
                               onclick="doLike(<%= post.getPid()%>, <%= currentUser.getId()%>, this)" 
                               class="btn btn-outline-light btn-sm <%= userLiked ? "btn-liked" : ""%>" 
                               <%= userLiked ? "disabled" : ""%>>
                                <i class="fa fa-thumbs-o-up"></i> 
                                <span class="like-counter"><%= likeCount%></span>
                            </a>
                            <a href="show_blog_page.jsp?post_id=<%= post.getPid()%>" 
                               class="btn btn-outline-light btn-sm">Read More...</a>
                            <% } %>
                        </div>
                    </div>
                </div>
                <%
                        }
                    }
                %>
            </div>
        </div>
        <br>
        <br>


        <!--javascripts-->
        <script
            src="https://code.jquery.com/jquery-3.4.1.min.js"
            integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
        crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" 
                integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" 
        crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" 
                integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" 
        crossorigin="anonymous"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
        <script>
                                   function doLike(pid, uid, btn) {
                                       if (btn.disabled)
                                           return;
                                       $.ajax({
                                           url: 'LikeServlet',
                                           method: 'POST',
                                           data: {operation: 'like', pid: pid, uid: uid},
                                           success: function (response) {
                                               if (response.trim() === 'true') {
                                                   let likeSpan = $(btn).find('.like-counter');
                                                   let currentCount = parseInt(likeSpan.text());
                                                   likeSpan.text(currentCount + 1);
                                                   btn.disabled = true;
                                                   $(btn).addClass('btn-liked');
                                               } else {
                                                   alert("You already liked this post.");
                                                   btn.disabled = true;
                                                   $(btn).addClass('btn-liked');
                                               }
                                           },
                                           error: function () {
                                               alert("Error liking the post. Please try again.");
                                           }
                                       });
                                   }
        </script>
    </body>
</html>