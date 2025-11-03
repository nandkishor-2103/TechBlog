<<<<<<< HEAD
<%@page import="com.tech.blog.dao.LikeDao" %>
    <%@page import="com.tech.blog.entities.Post" %>
        <%@page import="java.util.List" %>
            <%@page import="java.util.HashSet" %>
                <%@page import="com.tech.blog.helper.ConnectionProvider" %>
                    <%@page import="com.tech.blog.dao.PostDao" %>
                        <%@page contentType="text/html" pageEncoding="UTF-8" %>
                            <!DOCTYPE html>
                            <html>

                            <head>
                                <meta charset="UTF-8">
                                <title>TechBlog - Home</title>

                                <!-- Bootstrap / Icons / Custom CSS -->
                                <link rel="stylesheet"
                                    href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
                                <link href="css/mystyle.css" rel="stylesheet" />
                                <link rel="stylesheet"
                                    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

                                <style>
                                    .banner-background {
                                        clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 91%, 63% 100%, 22% 91%, 0 99%, 0 0);
                                    }

                                    .btn-liked {
                                        pointer-events: none;
                                        opacity: 0.6;
                                    }

                                    .card {
                                        border-radius: 12px;
                                        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                                        margin-bottom: 24px;
                                    }

                                    .card-img-container {
                                        max-height: 300px;
                                        overflow: hidden;
                                        background: #f8f9fa;
                                        display: flex;
                                        justify-content: center;
                                        border-radius: 8px 8px 0 0;
                                    }

                                    .card-img-top {
                                        max-height: 300px;
                                        object-fit: contain;
                                        transition: .3s;
                                    }

                                    .card-img-top:hover {
                                        transform: scale(1.05);
                                    }

                                    .read-more-btn {
                                        color: #3563d1;
                                        cursor: pointer;
                                    }
                                </style>

                                <script>
                                    function showFullContent(id)
                                    {
                                        document.getElementById('snippet-' + id).style.display = 'none';
                                        document.getElementById('fullcontent-' + id).style.display = 'block';
                                        document.getElementById('read-more-btn-' + id).style.display = 'none';
                                    }
                                </script>
                            </head>

                            <body>

                                <%@include file="normal_navbar.jsp" %>

                                    <!-- Banner -->
                                    <div class="container-fluid p-0 m-0">
                                        <div class="jumbotron primary-background text-white banner-background">
                                            <div class="container">
                                                <h3 class="display-3">Welcome to TechBlog</h3>
                                                <p>Explore the world of programming, development and technology.</p>
                                                <a href="register_page.jsp" class="btn btn-outline-light btn-lg"><i
                                                        class="fa fa-user-plus"></i> Start Free</a>
                                                <a href="login_page.jsp" class="btn btn-outline-light btn-lg"><i
                                                        class="fa fa-user-circle"></i> Login</a>
                                            </div>
                                        </div>
                                    </div>

                                    <h1 class="text-center my-4" style="text-decoration: underline; color:#2c3e50;">See
                                        All Posts</h1>

                                    <div class="container">
                                        <div class="row">

                                            <% PostDao postDao=new PostDao(ConnectionProvider.getConnection()); LikeDao
                                                likeDao=new LikeDao(ConnectionProvider.getConnection()); List<Post>
                                                posts = postDao.getAllPosts();

                                                if (posts == null || posts.isEmpty()) {
                                                %>
                                                <div class="col-12 text-center">
                                                    <h3>No Posts Available</h3>
                                                </div>

                                                <% } else { HashSet<Integer> likedPostIds = new HashSet<>();
                                                        if (currentUser != null) {
                                                        for (Post post : posts) {
                                                        if (likeDao.isLikedByUser(post.getPid(), currentUser.getId())) {
                                                        likedPostIds.add(post.getPid());
                                                        }
                                                        }
                                                        }

                                                        for (Post post : posts) {
                                                        boolean userLiked = currentUser != null &&
                                                        likedPostIds.contains(post.getPid());
                                                        int likeCount = likeDao.countLikeOnPost(post.getPid());
                                                        %>

                                                        <div class="col-md-6 mt-2">
                                                            <div class="card">
                                                                <div class="card-img-container">
                                                                    <img class="card-img-top"
                                                                        src="blog_pics/<%= post.getpPic()%>"
                                                                        alt="Post Image">
                                                                </div>

                                                                <div class="card-body">
                                                                    <b>
                                                                        <%= post.getpTitle()%>
                                                                    </b>

                                                                    <div id="snippet-<%= post.getPid()%>">
                                                                        <%= post.getpContent().length()> 150 ?
                                                                            post.getpContent().substring(0, 150) + "..."
                                                                            : post.getpContent()%>
                                                                    </div>

                                                                    <% if (post.getpContent().length()> 150) {%>
                                                                        <div id="fullcontent-<%= post.getPid()%>"
                                                                            style="display:none;">
                                                                            <%= post.getpContent()%>
                                                                        </div>
                                                                        <span class="read-more-btn"
                                                                            id="read-more-btn-<%= post.getPid()%>"
                                                                            onclick="showFullContent(<%= post.getPid()%>)">Read
                                                                            More</span>
                                                                        <% } %>
=======
<%@page import="com.tech.blog.entities.Message" %>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Login Page</title>
            <!--CSS-->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
                integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
                crossorigin="anonymous">
            <link href="css/mystyle.css" rel="stylesheet" type="text/css" />
            <link rel="stylesheet"
                href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
            <!-- Font Awesome 4.7 CDN -->
            <link rel="stylesheet"
                href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

            <style>
                .icon {
                    margin: 10px;
                    font-size: 24px;
                    /* default size */
                }

                .banner-background {
                    clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 96%, 71% 93%, 32% 97%, 0 89%, 0 0);
                }

                body {
                    padding-top: 70px;
                }
            </style>
        </head>

        <body>

            <!--Nav-bar-->
            <%@include file="normal_navbar.jsp" %>

                <main class="d-flex align-items-center primary-background banner-background" style="height: 70vh">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-4 offset-md-4">
                                <div class="card">
                                    <div class="card-header primary-background text-white text-center">
                                        <span class="fa fa-user-plus fa-3x"></span>
                                        <br>
                                        <p>Login here</p>
                                    </div>

                                    <% Message m=(Message) session.getAttribute("msg"); if (m !=null) { %>
                                        <div class="alert <%= m.getCssClass() %>" role="alert">
                                            <%= m.getContent() %>
                                        </div>
                                        <% session.removeAttribute("msg"); } %>


                                            <div class="card-body">
                                                <form action="LoginServlet" method="POST">
                                                    <div class="form-group">
                                                        <label for="exampleInputEmail1">Email address</label>
                                                        <input name="email" required type="email" class="form-control"
                                                            id="exampleInputEmail1" aria-describedby="emailHelp"
                                                            placeholder="Enter email">
                                                        <small id="emailHelp" class="form-text text-muted">We'll never
                                                            share your email with anyone else.</small>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="exampleInputPassword1">Password</label>
                                                        <input name="password" required type="password"
                                                            class="form-control" id="exampleInputPassword1"
                                                            placeholder="Password">
                                                    </div>

                                                    <div class="container text-center">
                                                        <button type="submit" class="btn btn-primary">Submit</button>
                                                    </div>
                                                </form>
                                            </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </main>
>>>>>>> Roshan




<<<<<<< HEAD
                                                                </div>



                                                                <div class="card-footer primary-background text-center">
                                                                    <% if (currentUser !=null) {%>
                                                                        <a href="#!"
                                                                            onclick="doLike(<%= post.getPid()%>, <%= currentUser.getId()%>, this)"
                                                                            class="btn btn-outline-light btn-sm <%= userLiked ? "
                                                                            btn-liked" : "" %>"
                                                                            <%= userLiked ? "disabled" : "" %>>
                                                                                <i class="fa fa-thumbs-o-up"></i>
                                                                                <span class="like-counter">
                                                                                    <%= likeCount%>
                                                                                </span>
                                                                        </a>
                                                                        <% }%>

                                                                            <a href="show_blog_page.jsp?post_id=<%= post.getPid()%>"
                                                                                class="btn btn-outline-light btn-sm">
                                                                                View Post
                                                                            </a>

                                                                            <button
                                                                                class="btn btn-outline-light btn-sm share-btn"
                                                                                data-posturl="show_blog_page.jsp?post_id=<%= post.getPid()%>">
                                                                                <i class="fa fa-share"></i> Share
                                                                            </button>

                                                                </div>
                                                            </div>
                                                        </div>

                                                        <% } }%>

                                        </div>
                                    </div>

                                    <!-- Footer -->
                                    <footer class="text-center text-white"
                                        style="background:#232d3b; padding:20px; margin-top:40px;">
                                        <p>&copy; 2025 TechBlog | Made by <span style="color:#1abc9c;">TechBlog
                                                Team</span></p>
                                    </footer>

                                    <!-- Scripts -->
                                    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
                                    <script src="js/myjs.js"></script>

                                    <script>
                                        function doLike(pid, uid, btn)
                                        {
                                            if (btn.disabled)
                                                return;
                                            $.post('LikeServlet', { operation: 'like', pid, uid }, function (response)
                                            {
                                                if (response.trim() === 'true')
                                                {
                                                    let likeSpan = $(btn).find('.like-counter');
                                                    likeSpan.text(parseInt(likeSpan.text()) + 1);
                                                    btn.disabled = true;
                                                    $(btn).addClass('btn-liked');
                                                }
                                            });
                                        }
                                    </script>


                                    <!-- Share Modal -->
                                    <div id="shareModal" class="modal fade" tabindex="-1" role="dialog">
                                        <div class="modal-dialog modal-dialog-centered" role="document">
                                            <div class="modal-content">

                                                <div class="modal-header">
                                                    <h5 class="modal-title">Share this post</h5>
                                                    <button type="button" class="close"
                                                        data-dismiss="modal">&times;</button>
                                                </div>

                                                <div class="modal-body text-center">
                                                    <input type="text" id="shareLink" class="form-control mb-3"
                                                        readonly>

                                                    <button class="btn btn-primary mb-2" id="copyLinkBtn">
                                                        <i class="fa fa-copy"></i> Copy Link
                                                    </button>
                                                    <br>

                                                    <a id="whatsappShare" class="btn btn-success mb-2" target="_blank">
                                                        <i class="fa fa-whatsapp"></i> WhatsApp
                                                    </a>
                                                    <br>

                                                    <a id="facebookShare" class="btn btn-primary mb-2" target="_blank">
                                                        <i class="fa fa-facebook"></i> Facebook
                                                    </a>
                                                    <br>

                                                    <a id="twitterShare" class="btn btn-info mb-2" target="_blank">
                                                        <i class="fa fa-twitter"></i> Twitter
                                                    </a>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                    <script>
                                        $(document).ready(function ()
                                        {

                                            $(".share-btn").click(function ()
                                            {
                                                let baseUrl = window.location.origin + "/TechBlog/";
                                                let postUrl = $(this).data("posturl");
                                                let fullLink = baseUrl + postUrl;

                                                $("#shareLink").val(fullLink);
                                                $("#whatsappShare").attr("href", "https://api.whatsapp.com/send?text=" + encodeURIComponent(fullLink));
                                                $("#facebookShare").attr("href", "https://www.facebook.com/sharer/sharer.php?u=" + encodeURIComponent(fullLink));
                                                $("#twitterShare").attr("href", "https://twitter.com/intent/tweet?url=" + encodeURIComponent(fullLink));

                                                $("#shareModal").modal("show");
                                            });

                                            $("#copyLinkBtn").click(function ()
                                            {
                                                navigator.clipboard.writeText($("#shareLink").val());
                                                alert("Link copied!");
                                            });

                                        });


                                    </script>
                                    <!-- Popper JS -->
                                    <script
                                        src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>

                                    <!-- Bootstrap JS -->
                                    <script
                                        src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

                                    <!-- Share Modal  end here-->
                                    <script>
                                        $(document).ready(function ()
                                        {

                                            $(".share-btn").click(function ()
                                            {
                                                let baseUrl = window.location.origin + "/TechBlog/";
                                                let postUrl = $(this).data("posturl");
                                                let fullLink = baseUrl + postUrl;
                                                let pid = postUrl.split("=")[1];

                                                $("#shareLink").val(fullLink);

                                                $("#whatsappShare").off().attr("href", "https://api.whatsapp.com/send?text=" + encodeURIComponent(fullLink))
                                                    .click(function () { saveShare(pid, "whatsapp"); });

                                                $("#facebookShare").off().attr("href", "https://www.facebook.com/sharer/sharer.php?u=" + encodeURIComponent(fullLink))
                                                    .click(function () { saveShare(pid, "facebook"); });

                                                $("#twitterShare").off().attr("href", "https://twitter.com/intent/tweet?url=" + encodeURIComponent(fullLink))
                                                    .click(function () { saveShare(pid, "twitter"); });

                                                $("#copyLinkBtn").off().click(function ()
                                                {
                                                    navigator.clipboard.writeText($("#shareLink").val());
                                                    alert("Link copied!");
                                                    saveShare(pid, "copylink");
                                                });

                                                $("#shareModal").modal("show");
                                            });
                                        });

                                        function saveShare(pid, platform)
                                        {
                                            $.post("ShareServlet", { pid: pid, platform: platform });
                                        }
                                    </script>





                            </body>

                            </html>
=======




                <!--JavaScript-->
                <script src="https://code.jquery.com/jquery-3.7.1.min.js"
                    integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous">
                    </script>
                <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
                    integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
                    crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
                    integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
                    crossorigin="anonymous"></script>
                <script src="js/myjs.js" type="text/javascript"></script>

        </body>

        </html>
>>>>>>> Roshan
